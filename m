Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452C01C2B88
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgECLAZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 07:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbgECLAY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 07:00:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7C12071C;
        Sun,  3 May 2020 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588503624;
        bh=MtBHVU8IMDhogw/m1PCM6WvisY3Fj7AWWPPtjmYITlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=POuWo4Ou5zAA6un2OLJHbyuknZ/jLcAc2KUifzr7s374izyrb8hXxt+fx4fGYUBhU
         /mX3oxCwyO55r8S45ldXNg0DdVYTv/zHgfXAxRY0GDqfbkr6EHII9LNHw4krLeOQCf
         hIONW00NIz6x2L4j0uf7Pmfm1hZwEfnk0U/Po9As=
Date:   Sun, 3 May 2020 12:00:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 05/11] iio: light: cm32181: Clean up the probe
 function a bit
Message-ID: <20200503120019.4cf7ecdd@archlinux>
In-Reply-To: <20200428172923.567806-5-hdegoede@redhat.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
        <20200428172923.567806-5-hdegoede@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Apr 2020 19:29:17 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> 3 small cleanups to cm32181_probe():
> 
> 1. Do not log an error when we fail to allocate memory (as a general
> rule drivers do not log errors for this as the kernel will already
> have complained loudly that it could not alloc the mem).
> 
> 2. Remove the i2c_set_clientdata() call, we never use i2c_get_clientdata()
> or dev_get_drvdata() anywhere.
> 
> 3. Add a dev helper variable and use it in various places instead of
> &client->dev.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
looks fine to me.

J

> ---
> Changes in v3:
> - This is a new patch in v3 of this patch-set
> ---
>  drivers/iio/light/cm32181.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index 065bc7a11f84..8fe49610fc26 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -326,41 +326,35 @@ static const struct iio_info cm32181_info = {
>  
>  static int cm32181_probe(struct i2c_client *client)
>  {
> +	struct device *dev = &client->dev;
>  	struct cm32181_chip *cm32181;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
> -	if (!indio_dev) {
> -		dev_err(&client->dev, "devm_iio_device_alloc failed\n");
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*cm32181));
> +	if (!indio_dev)
>  		return -ENOMEM;
> -	}
>  
>  	cm32181 = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
>  	cm32181->client = client;
>  
>  	mutex_init(&cm32181->lock);
> -	indio_dev->dev.parent = &client->dev;
> +	indio_dev->dev.parent = dev;
>  	indio_dev->channels = cm32181_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
>  	indio_dev->info = &cm32181_info;
> -	indio_dev->name = dev_name(&client->dev);
> +	indio_dev->name = dev_name(dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	ret = cm32181_reg_init(cm32181);
>  	if (ret) {
> -		dev_err(&client->dev,
> -			"%s: register init failed\n",
> -			__func__);
> +		dev_err(dev, "%s: register init failed\n", __func__);
>  		return ret;
>  	}
>  
> -	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
> -		dev_err(&client->dev,
> -			"%s: regist device failed\n",
> -			__func__);
> +		dev_err(dev, "%s: regist device failed\n", __func__);
>  		return ret;
>  	}
>  

