Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 794FC19668D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 15:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgC1OLi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 10:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgC1OLi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 10:11:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F368206E6;
        Sat, 28 Mar 2020 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585404697;
        bh=HUS3qRjvR0SEBD9zZKFHbXKAI6P1UowEvsgqIjSddhw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q4yY4nmrRjznFaNP5NYRfLgAHK7HQitZYcxkr6qwxKQWVCF0Rbmq3IGUvLQ2DLw7F
         sYZuZKhvqO4YS5lw97Bcwe01J0P7juY+9+TsB8QAKVEuXJCfkeoC4VrQpuMAFS83cg
         8dM73SlSatcu1bW103ot6zgJjPYlsZ2SdYsIIXqo=
Date:   Sat, 28 Mar 2020 14:11:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, joe@perches.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] iio: st_sensors_i2c: Use vsprintf extension
 %pe for symbolic error name
Message-ID: <20200328141133.68d74286@archlinux>
In-Reply-To: <1ac10121b5bd95fbba59d27482a77d55c2461230.1584897364.git.nish.malpani25@gmail.com>
References: <cover.1584897364.git.nish.malpani25@gmail.com>
        <1ac10121b5bd95fbba59d27482a77d55c2461230.1584897364.git.nish.malpani25@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 22 Mar 2020 22:53:04 +0530
Nishant Malpani <nish.malpani25@gmail.com> wrote:

> Utilize %pe format specifier from vsprintf while printing error logs
> with dev_err(). Discards the use of unnecessary explicit casting and
> prints symbolic error name which might prove to be convenient during
> debugging.
> 
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
This one doesn't apply because the original 'fix' that the whole series
was based on from Andy has already been applied.

Whilst you could propose a change on top of that it probably isn't
worth the effort, so unless others disagree I'd just drop this one.

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
>  drivers/iio/common/st_sensors/st_sensors_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index 286830fb5d35..4f7ae273ac98 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -49,8 +49,8 @@ int st_sensors_i2c_configure(struct iio_dev *indio_dev,
>  
>  	sdata->regmap = devm_regmap_init_i2c(client, config);
>  	if (IS_ERR(sdata->regmap)) {
> -		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
> -			(int)PTR_ERR(sdata->regmap));
> +		dev_err(&client->dev, "Failed to register i2c regmap: %pe\n",
> +			sdata->regmap);
>  		return PTR_ERR(sdata->regmap);
>  	}
>  

