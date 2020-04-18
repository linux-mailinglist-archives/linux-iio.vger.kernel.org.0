Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6C1AF324
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDRSVv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 14:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSVu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 14:21:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D100321BE5;
        Sat, 18 Apr 2020 18:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587234110;
        bh=VVZpAOqgMwZPlB6GdhKOTgDQezmxNUaobjVLTtPV/9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CiwglmY46HLtjnEfCn2Y5qBtEkiczixa5AdXyKrkqBqb5l3jfoNw+N2ErSS6AhW+f
         CmiTXiYQNQusddMoWwVN+o/gK4uS8SnJ2Mrc8UcaWEXQq1Z/lBNDN0GAs6nXupgNM7
         RKgV2dgpSFAp5DjgFnxgEsG5O1zw9n3Xa/9w8pEg=
Date:   Sat, 18 Apr 2020 19:21:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: magnetometer: ak8974: Silence deferred-probe
 error
Message-ID: <20200418192145.57fa291b@archlinux>
In-Reply-To: <20200418171244.2320-1-digetx@gmail.com>
References: <20200418171244.2320-1-digetx@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Apr 2020 20:12:44 +0300
Dmitry Osipenko <digetx@gmail.com> wrote:

> It's not uncommon that voltage regulator becomes available later during
> kernel's boot process. This patch adds info message about unavailable
> regulators in a case of the deferred-probe error and also amends the
> error message with a error code.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog:
> 
> v3: - Replaced dev_info() with dev_dbg().
> 
> v2: - Replaced dev_printk() with dev_info() for the deferred-probe error,
>       as was requested by Linus Walleij in a review comment to v1.
> 
>  drivers/iio/magnetometer/ak8974.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index d32996702110..372c80c25dd4 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -746,7 +746,12 @@ static int ak8974_probe(struct i2c_client *i2c,
>  				      ARRAY_SIZE(ak8974->regs),
>  				      ak8974->regs);
>  	if (ret < 0) {
> -		dev_err(&i2c->dev, "cannot get regulators\n");
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
> +		else
> +			dev_dbg(&i2c->dev,
> +				"regulators unavailable, deferring probe\n");
> +
>  		return ret;
>  	}
>  

