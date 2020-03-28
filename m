Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4113A196687
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1OKI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OKI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:10:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A14F206E6;
        Sat, 28 Mar 2020 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585404607;
        bh=BHZtviPoMrMkTfYyy8uVuV07iXfN5YgaPK/sDVaMAVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jW3wTziEFiINFJ06iJoMEtayAClQA8DTAQuzbaN4bo5d/udjvfqdFiATUjS5gUEXa
         EfsMRPjU2rD3txwdNdU6hh4iWYi3LcMyUwrNzLvUyncxuxDo7jqGkZ/FO6pTn4XqC9
         WdLz7YB+MK4xnNUXgvMkRIA7hdS/X3L8EOvC1H2Q=
Date:   Sat, 28 Mar 2020 14:10:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] iio: accel: kxsd9: Use vsprintf extension %pe
 for symbolic error name
Message-ID: <20200328141003.458b86d8@archlinux>
In-Reply-To: <9fcebba578c1fe0b02bd1053e5b4d0ba4299452d.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <9fcebba578c1fe0b02bd1053e5b4d0ba4299452d.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:03 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v2:
>   - Rewrite commit subject line outlining the usage of %pe.
>   - Add a separator between regmap and its error name.
> 
> Based on conversations in [1] & [2].
> 
> [1] https://marc.info/?l=linux-iio&m=158427554607223&w=2
> [2] https://marc.info/?l=linux-iio&m=158481647605891&w=2
> ---
>  drivers/iio/accel/kxsd9-i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9-i2c.c b/drivers/iio/accel/kxsd9-i2c.c
> index 38411e1c155b..b6f3de7ef8ea 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>  
>  	regmap = devm_regmap_init_i2c(i2c, &config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&i2c->dev, "Failed to register i2c regmap: %pe\n",
> +			regmap);
>  		return PTR_ERR(regmap);
>  	}
>  

