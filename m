Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33BA18E989
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgCVPNr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 11:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVPNr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 11:13:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D03820722;
        Sun, 22 Mar 2020 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584890026;
        bh=tiusHdEiTydq4LjkwpW6vxcmdVY492SblJa37LMWCRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fJh9MbqXdZ5Wwv5GuMhn/YZn8yTVUntg85d/jkfGHQzTiYPX79qnVFBs5X7N0FMbM
         d58VwB+6uDmJFjsKeDlMeCc1DqvAq4iESdaQGVrLTIxe4Vxkaw/lqLRT+uVWJmqfZ0
         O7ZmMKStitfsDozulcLT5TbHM/LELIeRay6JjsBs=
Date:   Sun, 22 Mar 2020 15:13:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] iio: accel: kxsd9: Use suitable format specifier
Message-ID: <20200322151342.1b65a5c0@archlinux>
In-Reply-To: <20200321210204.18106-2-nish.malpani25@gmail.com>
References: <20200321210204.18106-1-nish.malpani25@gmail.com>
        <20200321210204.18106-2-nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 02:31:52 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Provide more suitable format specifiers while printing error logs.
> Discards the use of unnecessary explicit casting and prints symbolic
> error name which might prove to be convenient during debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
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
> index 38411e1c155b..39a9daa7566f 100644
> --- a/drivers/iio/accel/kxsd9-i2c.c
> +++ b/drivers/iio/accel/kxsd9-i2c.c
> @@ -21,8 +21,8 @@ static int kxsd9_i2c_probe(struct i2c_client *i2c,
>  
>  	regmap = devm_regmap_init_i2c(i2c, &config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&i2c->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&i2c->dev, "Failed to register i2c regmap %pe\n",
> +			regmap;

Please make sure you do basic build tests. 

			regmap); 

>  		return PTR_ERR(regmap);
>  	}
>  

