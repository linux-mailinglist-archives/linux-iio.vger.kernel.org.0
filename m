Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C81320B84
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhBUPp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 10:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUPp5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 10:45:57 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1701364DA8;
        Sun, 21 Feb 2021 15:45:14 +0000 (UTC)
Date:   Sun, 21 Feb 2021 15:45:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: yas530: Fix return value on
 errorpath
Message-ID: <20210221154511.75b3d8a6@archlinux>
In-Reply-To: <20210215153023.47899-1-linus.walleij@linaro.org>
References: <20210215153023.47899-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Feb 2021 16:30:23 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> There was a missed return variable assignment in the
> default errorpath of the switch statement in yas5xx_probe().
> Fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Hi Linus,

A bit of bad timing on these.  I'm running behind on pull requests for
my fixes-togreg branch so it doesn't yet have the driver.

Hence I'll pick these up in a couple of weeks once that's rebased after
I send Greg a pull request.

Give me a poke if I seem to have forgotten them.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index d46f23d82b3d..cee6207d8847 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -887,6 +887,7 @@ static int yas5xx_probe(struct i2c_client *i2c,
>  		strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
>  		break;
>  	default:
> +		ret = -ENODEV;
>  		dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid);
>  		goto assert_reset;
>  	}

