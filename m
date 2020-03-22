Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B2D18EAA9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgCVRMV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgCVRMV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:12:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D59E20724;
        Sun, 22 Mar 2020 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584897140;
        bh=RNQAFnyFMkXLrBsta3/IXISWmGcuSDF4CGTlFiPimsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AoVCimXv2hBVMlntlIz4eP20CJSDK+1ZzwBhN90oBM31QC11kgS8a45kUanDl7hVH
         0OUdPRj0WkcANaFjta+Wk/yMuiiy9TgAgTdQ+pFnmO+UR2VAi/tu6xpPbdOnhiMnJQ
         r574M90BGIjqWUlvpMHKUTPZY5SHEm/k4snPpInM=
Date:   Sun, 22 Mar 2020 17:12:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/5] iio: pressure: bmp280: Tolerate IRQ before
 registering
Message-ID: <20200322171216.3260cd37@archlinux>
In-Reply-To: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On Tue, 17 Mar 2020 12:18:09 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> With DEBUG_SHIRQ enabled we have a kernel crash
> 
> [  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 
> ...
> 
> [  116.606571] Call Trace:
> [  116.609023]  <IRQ>
> [  116.611047]  complete+0x34/0x50
> [  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]
> 
> because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
> ought to be able to handle an interrupt happening before request_irq() returns.
> 
> Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hmm. Nasty corner case but fair enough to fix it up.
I guess we should audit other drivers for similar paths...

> ---
>  drivers/iio/pressure/bmp280-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 29c209cc1108..5e229b95308e 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -712,8 +712,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
>  	unsigned int delay_us;
>  	unsigned int ctrl;
>  
> -	if (data->use_eoc)
> -		init_completion(&data->done);
> +	reinit_completion(&data->done);

reinit on the completion when we don't even have an interrupt
(hence data->use_eoc == false) seems excessive.  Why did
you drop the conditional?

Jonathan



>  
>  	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
>  	if (ret)
> @@ -969,6 +968,9 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
>  			"trying to enforce it\n");
>  		irq_trig = IRQF_TRIGGER_RISING;
>  	}
> +
> +	init_completion(&data->done);
> +
>  	ret = devm_request_threaded_irq(dev,
>  			irq,
>  			bmp085_eoc_irq,

