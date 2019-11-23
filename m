Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A30107EEE
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKWOpr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfKWOpr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:45:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67CB220706;
        Sat, 23 Nov 2019 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574520346;
        bh=tKBS0EXAvq5wAaV+58kcvj7sQ7sdki2aN1YEypolESg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DFZ1h+NhgfQNrUlzb2/kP25qm6r6tA1c96RpNJwJmpADlM/GjrdVX66ZRHDCq/phS
         hlNX3psi3lt1Q+pi400NtUVgF5tT/750IXPnR2yojZbfkbmcFx79wcPAOYYzhQNSjd
         MuanOEP6n+YvB54Mmpax99bYXyBFRDNMmprUDwT8=
Date:   Sat, 23 Nov 2019 14:45:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: Fix Kconfig indentation
Message-ID: <20191123144542.15adc722@archlinux>
In-Reply-To: <1574306359-29372-1-git-send-email-krzk@kernel.org>
References: <1574306359-29372-1-git-send-email-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Nov 2019 04:19:19 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
This ends up with 1 space less before the help text than in the rest
of the file.  Fixed that up and applied.

thanks,

Jonathan

> 
> ---
> 
> Changes since v1:
> 1. Fix also 7-space and tab+1 space indentation issues.
> ---
>  drivers/iio/gyro/Kconfig | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 95e6f96d4529..7de77419b4a1 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -75,26 +75,26 @@ config BMG160_SPI
>  	select REGMAP_SPI
>  
>  config FXAS21002C
> -       tristate "NXP FXAS21002C Gyro Sensor"
> -       select IIO_BUFFER
> -       select IIO_TRIGGERED_BUFFER
> -       select FXAS21002C_I2C if (I2C)
> -       select FXAS21002C_SPI if (SPI)
> -       depends on (I2C || SPI_MASTER)
> -       help
> -         Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
> -         Sensor driver connected via I2C or SPI.
> -
> -         This driver can also be built as a module.  If so, the module
> -         will be called fxas21002c_i2c or fxas21002c_spi.
> +	tristate "NXP FXAS21002C Gyro Sensor"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select FXAS21002C_I2C if (I2C)
> +	select FXAS21002C_SPI if (SPI)
> +	depends on (I2C || SPI_MASTER)
> +	help
> +	 Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
> +	 Sensor driver connected via I2C or SPI.
> +
> +	 This driver can also be built as a module.  If so, the module
> +	 will be called fxas21002c_i2c or fxas21002c_spi.
>  
>  config FXAS21002C_I2C
> -       tristate
> -       select REGMAP_I2C
> +	tristate
> +	select REGMAP_I2C
>  
>  config FXAS21002C_SPI
> -       tristate
> -       select REGMAP_SPI
> +	tristate
> +	select REGMAP_SPI
>  
>  config HID_SENSOR_GYRO_3D
>  	depends on HID_SENSOR_HUB

