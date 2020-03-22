Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CB18EAEF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCVRie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgCVRie (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:38:34 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9011B206F8;
        Sun, 22 Mar 2020 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584898713;
        bh=DtWJe5A8ojR9MDf5iOQGE9ZnKuUBzNSzoGABAMyWA/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mxkym/oQg7bQpJufaf/IUzGqZbu4zPS37mpf4k+MvxAXJJSac33lUNTQv2WaNxkO3
         lG76xSK+H6vr1ljqxiQlGBtM7S7iS5THYYarx6uYrp/IOeq3bZtnDLFwlyKnV3jeZJ
         JErrsO2bAuVTDJxU1Z7cQo5wqYUFMgHYuLMHKr4I=
Date:   Sun, 22 Mar 2020 17:38:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        hns@goldelico.com, rui.silva@linaro.org
Subject: Re: [PATCH] iio/gyro/bmg160: Add support for BMI088 chip
Message-ID: <20200322173826.12a7c28c@archlinux>
In-Reply-To: <20200316063403.3094-1-mike.looijmans@topic.nl>
References: <20200316063403.3094-1-mike.looijmans@topic.nl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 07:34:03 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> The BMI088 is pin-compatible with the BMI055, and provides
> both gyro and accel functions. The gyro part is similar to
> the BMI055 and this adds the chip to the list of supported
> devices for the gyro part.
> 
> The accel part of the chip is not compatible with anything
> existing already.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Applied.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt | 2 +-
>  drivers/iio/gyro/Kconfig                                   | 2 +-
>  drivers/iio/gyro/bmg160_i2c.c                              | 2 ++
>  drivers/iio/gyro/bmg160_spi.c                              | 1 +
>  4 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> index 78e18a1e9c1d..bb43d1ad9c9f 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties:
>  
> -  - compatible : should be "bosch,bmg160" or "bosch,bmi055_gyro"
> +  - compatible : should be "bosch,bmg160", "bosch,bmi055_gyro" or "bosch,bmi088_gyro"
>    - reg : the I2C address of the sensor (0x69)
>  
>  Optional properties:
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 7eaf77707b0b..6daeddf37f60 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -61,7 +61,7 @@ config BMG160
>  	help
>  	  Say yes here to build support for BOSCH BMG160 Tri-axis Gyro Sensor
>  	  driver connected via I2C or SPI. This driver also supports BMI055
> -	  gyroscope.
> +	  and BMI088 gyroscope.
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called bmg160_i2c or bmg160_spi.
> diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
> index 4fc9c6a3321f..de15c6fc3381 100644
> --- a/drivers/iio/gyro/bmg160_i2c.c
> +++ b/drivers/iio/gyro/bmg160_i2c.c
> @@ -42,6 +42,7 @@ static int bmg160_i2c_remove(struct i2c_client *client)
>  static const struct acpi_device_id bmg160_acpi_match[] = {
>  	{"BMG0160", 0},
>  	{"BMI055B", 0},
> +	{"BMI088B", 0},
>  	{},
>  };
>  
> @@ -50,6 +51,7 @@ MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
>  static const struct i2c_device_id bmg160_i2c_id[] = {
>  	{"bmg160", 0},
>  	{"bmi055_gyro", 0},
> +	{"bmi088_gyro", 0},
>  	{}
>  };
>  
> diff --git a/drivers/iio/gyro/bmg160_spi.c b/drivers/iio/gyro/bmg160_spi.c
> index 182a59c42507..03e80bb2601a 100644
> --- a/drivers/iio/gyro/bmg160_spi.c
> +++ b/drivers/iio/gyro/bmg160_spi.c
> @@ -37,6 +37,7 @@ static int bmg160_spi_remove(struct spi_device *spi)
>  static const struct spi_device_id bmg160_spi_id[] = {
>  	{"bmg160", 0},
>  	{"bmi055_gyro", 0},
> +	{"bmi088_gyro", 0},
>  	{}
>  };
>  

