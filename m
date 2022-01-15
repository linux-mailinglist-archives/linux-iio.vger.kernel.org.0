Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B9248F890
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 19:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiAOSBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 13:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiAOSBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 13:01:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C528BC061574
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 10:01:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB841CE04F0
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 18:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D7BC36AE7;
        Sat, 15 Jan 2022 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642269684;
        bh=EUk6S4ihcE2y+atUOiZbAdeZEfE6BTCeNy3JOL20//E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g430xEPndYNgSLXrpSCE7gCq85ptKuxYlFTN+V9brPVkl1gPXQZb660hbgjbXU1YX
         GhSJrUG1ZgEprEHrFSOsSW/nO1oP0YRypzhWMM0TyPWxEhDqhVIeFBkZRerqOGsEed
         B8M9OmUaABA0gKi4YKC5VvTNPvP39qlukxzsUERWdFnNrDjvrvOrm6ebpU3YDtp4Jg
         jLfSwBAlImATJARMytYsRQYW2h1UZnY8vqGYC5SgoWcwSi3x3iLB3bcgHIfzsIWMhJ
         XeiQnJ5TbB9/AQGA51vHz3IGMbfErHxIRfSh9N8iX1SyeXI7JtezJvq/Ne/q7QJUR/
         aOxo2w5QdSoIw==
Date:   Sat, 15 Jan 2022 18:07:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <alexandru.tachici@analog.com>, <dragos.bogdan@analog.com>,
        <nuno.sa@analog.com>, <lars@metafoo.de>
Subject: Re: [PATCH] MAINTAINERS: fix Analog Devices links
Message-ID: <20220115180725.466c94b9@jic23-huawei>
In-Reply-To: <20220103104412.81247-1-antoniu.miclaus@analog.com>
References: <20220103104412.81247-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 Jan 2022 12:44:12 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The forum link for the Analog Devices linux drivers has changed.
>=20
> Fix the links to redirect to the correct forum subsection.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  MAINTAINERS | 56 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d311fd7e445..aa5ebb5a4b6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -459,35 +459,35 @@ AD525X ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/AD5254
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/misc/ad525x_dpot.c
> =20
>  AD5398 CURRENT REGULATOR DRIVER (AD5398/AD5821)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/AD5398
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/regulator/ad5398.c
> =20
>  AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/AD7142
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/misc/ad714x.c
> =20
>  AD7877 TOUCHSCREEN DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/AD7877
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/touchscreen/ad7877.c
> =20
>  AD7879 TOUCHSCREEN DRIVER (AD7879/AD7889)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/AD7879
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/input/touchscreen/ad7879.c
> =20
>  ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
> @@ -499,7 +499,7 @@ M:	Michael Hennerich <michael.hennerich@analog.com>
>  L:	linux-wpan@vger.kernel.org
>  S:	Supported
>  W:	https://wiki.analog.com/ADF7242
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/net/ieee802154/adf7242.txt
>  F:	drivers/net/ieee802154/adf7242.c
> =20
> @@ -533,7 +533,7 @@ ADP5520 BACKLIGHT DRIVER WITH IO EXPANDER (ADP5520/AD=
P5501)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/ADP5520
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/gpio/gpio-adp5520.c
>  F:	drivers/input/keyboard/adp5520-keys.c
>  F:	drivers/leds/leds-adp5520.c
> @@ -544,7 +544,7 @@ ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588=
/ADP5587)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/ADP5588
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/gpio/gpio-adp5588.c
>  F:	drivers/input/keyboard/adp5588-keys.c
> =20
> @@ -552,7 +552,7 @@ ADP8860 BACKLIGHT DRIVER (ADP8860/ADP8861/ADP8863)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/ADP8860
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/video/backlight/adp8860_bl.c
> =20
>  ADT746X FAN DRIVER
> @@ -591,7 +591,7 @@ ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL=
345/ADXL346)
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/ADXL345
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
>  F:	drivers/input/misc/adxl34x.c
> =20
> @@ -608,7 +608,7 @@ F:	drivers/iio/accel/adxl355_spi.c
>  ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
>  F:	drivers/iio/accel/adxl372.c
>  F:	drivers/iio/accel/adxl372_i2c.c
> @@ -1040,7 +1040,7 @@ ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>  F:	drivers/iio/adc/ad7192.c
> =20
> @@ -1048,7 +1048,7 @@ ANALOG DEVICES INC AD7292 DRIVER
>  M:	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
>  F:	drivers/iio/adc/ad7292.c
> =20
> @@ -1064,7 +1064,7 @@ ANALOG DEVICES INC AD7768-1 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
>  F:	drivers/iio/adc/ad7768-1.c
> =20
> @@ -1073,7 +1073,7 @@ M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  M:	Renato Lui Geh <renatogeh@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>  F:	drivers/iio/adc/ad7780.c
> =20
> @@ -1093,7 +1093,7 @@ ANALOG DEVICES INC ADIN DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  L:	netdev@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/net/adi,adin.yaml
>  F:	drivers/net/phy/adin.c
> =20
> @@ -1108,14 +1108,14 @@ ANALOG DEVICES INC ADIS16460 DRIVER
>  M:	Dragos Bogdan <dragos.bogdan@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>  F:	drivers/iio/imu/adis16460.c
> =20
>  ANALOG DEVICES INC ADIS16475 DRIVER
>  M:	Nuno Sa <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  S:	Supported
>  F:	drivers/iio/imu/adis16475.c
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -1124,7 +1124,7 @@ ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
>  F:	drivers/hwmon/adm1177.c
> =20
> @@ -1148,7 +1148,7 @@ ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-pm@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/power/supply/adp5061.c
> =20
>  ANALOG DEVICES INC ADRF6780 DRIVER
> @@ -1163,7 +1163,7 @@ ANALOG DEVICES INC ADV7180 DRIVER
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  L:	linux-media@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/media/i2c/adv7180.c
>  F:	Documentation/devicetree/bindings/media/i2c/adv7180.yaml
> =20
> @@ -1205,7 +1205,7 @@ M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>  S:	Supported
>  W:	http://wiki.analog.com/
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	sound/soc/codecs/ad1*
>  F:	sound/soc/codecs/ad7*
>  F:	sound/soc/codecs/adau*
> @@ -1216,7 +1216,7 @@ F:	sound/soc/codecs/ssm*
>  ANALOG DEVICES INC DMA DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/dma/dma-axi-dmac.c
> =20
>  ANALOG DEVICES INC IIO DRIVERS
> @@ -1224,7 +1224,7 @@ M:	Lars-Peter Clausen <lars@metafoo.de>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  S:	Supported
>  W:	http://wiki.analog.com/
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	Documentation/devicetree/bindings/iio/*/adi,*
> @@ -3254,7 +3254,7 @@ AXI-FAN-CONTROL HARDWARE MONITOR DRIVER
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
>  F:	drivers/hwmon/axi-fan-control.c
> =20
> @@ -11199,7 +11199,7 @@ LTC2947 HARDWARE MONITOR DRIVER
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml
>  F:	drivers/hwmon/ltc2947-core.c
>  F:	drivers/hwmon/ltc2947-i2c.c
> @@ -11210,7 +11210,7 @@ LTC2983 IIO TEMPERATURE DRIVER
>  M:	Nuno S=C3=A1 <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
>  F:	drivers/iio/temperature/ltc2983.c
> =20
> @@ -11225,7 +11225,7 @@ LTC4306 I2C MULTIPLEXER DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  L:	linux-i2c@vger.kernel.org
>  S:	Supported
> -W:	http://ez.analog.com/community/linux-device-drivers
> +W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
>  F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
> =20

