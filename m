Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCA196694
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgC1ONd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1ONd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:13:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271B7206E6;
        Sat, 28 Mar 2020 14:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585404812;
        bh=TK4r9TQQgWukLt0YvMfS7SVClvnijm6m+FK/7DftQmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xQwMYFl66lixifwm//92A4H5qqQynsfuKFsGhmju+RAxqN2TcnIMw4itmz+taGOOj
         88e2tyqGN0akXnpwx3iaxbE7N0G1BhpPdNksuKaAgWJenmWnynL8j8sSgTKZAahCTU
         YuEaaZPupQeWP1PS2kfWDZIXyp5Ka1V0QM7xxNUE=
Date:   Sat, 28 Mar 2020 14:13:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] iio: gyro: bmg160_i2c: Use vsprintf extension
 %pe for symbolic error name
Message-ID: <20200328141328.74781859@archlinux>
In-Reply-To: <5b9a92dee27f406556b4c945f773ef9b5eea825c.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <5b9a92dee27f406556b4c945f773ef9b5eea825c.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:06 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Applied

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
>  drivers/iio/gyro/bmg160_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 4fc9c6a3321f..513473fb2055 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -21,8 +21,8 @@ static int bmg160_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
> +			regmap);
>  		return PTR_ERR(regmap);
>  	}
>  

