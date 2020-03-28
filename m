Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229A41966A6
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgC1OTj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgC1OTj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:19:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3981720578;
        Sat, 28 Mar 2020 14:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585405178;
        bh=DmRm1XW1Ca7PlCzQEHXzzKOqmMJ0YhXAMURm8hKZGNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vyis29NCpotN072nPS6eVXuiIbhDAUhBvV0nst7vwKpQ2Mmhk40f5RI0C3RhbmczK
         T9RncQ5s48zZ56nCyIFgzh4iCRfC/62Qq6ZbV/njcXdKfzIzjlDUASp0rnOtna5ovB
         qGNVPLfc2WDaEv7zGXr+zOxZcQfq6K1jiro/9NJQ=
Date:   Sat, 28 Mar 2020 14:19:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/13] iio: imu: bmi160_i2c: Use vsprintf extension
 %pe for symbolic error name
Message-ID: <20200328141933.24286f6f@archlinux>
In-Reply-To: <a43b1f26a000665712039733dfb2b4e0134cac35.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <a43b1f26a000665712039733dfb2b4e0134cac35.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:09 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
Applied

Thanks,

J

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
>  drivers/iio/imu/bmi160/bmi160_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index e36f5e82d400..26398614eddf 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -24,8 +24,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>  
>  	regmap = devm_regmap_init_i2c(client, &bmi160_regmap_config);
>  	if (IS_ERR(regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> -			(int)PTR_ERR(regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
> +			regmap);
>  		return PTR_ERR(regmap);
>  	}
>  

