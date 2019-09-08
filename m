Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB9ACBCC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfIHJbu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 05:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfIHJbu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 05:31:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5498E207FC;
        Sun,  8 Sep 2019 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567935109;
        bh=zfv4LkabeN6OFlooLpFdVdcSi/pHnXDU1gNLLwRryLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z65KLRqGR8MjaKNuOU5khtMBQT6UTgixmXphPNY3/iENrc691DTvJWWok5ZRsCPaC
         wbwJpKMe8TMAJGqLBG9w47Sm5wTqk1TdOdk+HXFiXQGhz8YcyqIqhssLDFosnHNdn5
         HyM4JM3z8oERzuFlSuIuDmlPm9NdNV/Bm/ZF/a6U=
Date:   Sun, 8 Sep 2019 10:31:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: accel: adxl372: Make sure interrupts are
 disabled
Message-ID: <20190908103145.7d2f763b@archlinux>
In-Reply-To: <1567502351-10429-1-git-send-email-stefan.popa@analog.com>
References: <1567502351-10429-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Sep 2019 12:19:11 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> This patch disables the adxl372 interrupts at setup. The interrupts
> should be enabled together with the iio buffer. Not doing this, might
> cause an unwanted interrupt to trigger without being able to properly
> clear it.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Given the device has a software reset, would we be better off
just hitting that to make sure we are in a consistent state after
driver start up?

Thanks,

Jonathan


> ---
>  drivers/iio/accel/adxl372.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 72d3f45..77651f4 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -609,6 +609,10 @@ static int adxl372_setup(struct adxl372_state *st)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = adxl372_set_interrupts(st, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* Set the mode of operation to full bandwidth measurement mode */
>  	return adxl372_set_op_mode(st, ADXL372_FULL_BW_MEASUREMENT);
>  }

