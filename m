Return-Path: <linux-iio+bounces-14773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF042A242DA
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3C6165729
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100791F237C;
	Fri, 31 Jan 2025 18:39:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B88153565;
	Fri, 31 Jan 2025 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348777; cv=none; b=c1cZeEkyF9OTvKUcNvSFJiI5XLO6m+IVSANev7gJZBqXW2ir4tEpkS0udAFxUXmAUNRJ/gmECUL+jnMJNVo4Zlkvd/6HMK0gfP6sqYbsh3I4CyH7cYsIcR/jFH4ODozsWYfXW7YZuTqaVFKCNE0ggIgfrW/wk6K1Q+xywzoaw+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348777; c=relaxed/simple;
	bh=U+vC4MgC6keMoKoFempovO8KBmgpjEzhh9HDD3e8CTM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usS9HGtNNFqQQ8tovkJUl9QZoPic24B9Im+dnKPOeWrCCBDgFKWw1hjPUTu0EF7psFJQ8HdZuXKurPw8QJ36ty3zKLEDqOrvUNUL52Lsp18lhwo5lt+M4L+nVbeVhSy5v2rOkesvRQxoTdnVvkv5BKfHem5nlYRUrcgV32VK9OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl4RG4LRTz6K60m;
	Sat,  1 Feb 2025 02:38:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DC65D140A70;
	Sat,  1 Feb 2025 02:39:32 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 19:39:31 +0100
Date: Fri, 31 Jan 2025 18:39:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
CC: Alisa-Dariana Roman <alisa.roman@analog.com>, David Lechner
	<dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH v3 3/3] docs: iio: add AD7191
Message-ID: <20250131183930.00003f52@huawei.com>
In-Reply-To: <20250129143054.225322-4-alisa.roman@analog.com>
References: <20250129143054.225322-1-alisa.roman@analog.com>
	<20250129143054.225322-4-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 29 Jan 2025 16:29:04 +0200
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Add documentation for AD7191 driver.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Hi Alisa-Dariana,

Please could you build this with make html_docs

It needs to be added to the index as well to build.

Then check formatting of titles and bullet points etc. Looks like
a few bits of formatting of the rst aren't quite right but I haven't
built it to be sure of that.

Content looks fine to me.

Thanks,

Jonathan

> ---
>  Documentation/iio/ad7191.rst | 230 +++++++++++++++++++++++++++++++++++
>  1 file changed, 230 insertions(+)
>  create mode 100644 Documentation/iio/ad7191.rst
>=20
> diff --git a/Documentation/iio/ad7191.rst b/Documentation/iio/ad7191.rst
> new file mode 100644
> index 000000000000..78aa5fefe128
> --- /dev/null
> +++ b/Documentation/iio/ad7191.rst
> @@ -0,0 +1,230 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AD7191 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Device driver for Analog Devices AD7191 ADC.
> +
> +Supported devices
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +* `AD7191 <https://www.analog.com/AD7191>`_
> +
> +The AD7191 is a high precision, low noise, 24-bit =CE=A3-=CE=94 ADC with=
 integrated PGA.
> +It features two differential input channels, an internal temperature sen=
sor,and
> +configurable sampling rates.
> +
> +Device Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Pin Configuration
> +----------------
> +
> +The driver supports both pin-strapped and GPIO-controlled configurations=
 for ODR
> +(Output Data Rate) and PGA (Programmable Gain Amplifier) settings. These
> +configurations are mutually exclusive - you must use either pin-strapped=
 or GPIO
> +control for each setting, not both.
> +
> +ODR Configuration
> +^^^^^^^^^^^^^^^^
> +
> +The ODR can be configured either through GPIO control or pin-strapping:
> +
> +- When using GPIO control, specify the "odr-gpios" property in the devic=
e tree
> +- For pin-strapped configuration, specify the "adi,odr-value" property i=
n the
> +device tree

This doesn't look like correct rst for bullet points. Please
build the docs and sanity check this.  I believe it needs to be aligned
and you may nee some blank lines in a few places.

> +
> +Available ODR settings:
> +  - 120 Hz (ODR1=3D0, ODR2=3D0)
> +  - 60 Hz (ODR1=3D0, ODR2=3D1)
> +  - 50 Hz (ODR1=3D1, ODR2=3D0)
> +  - 10 Hz (ODR1=3D1, ODR2=3D1)
> +
> +PGA Configuration
> +^^^^^^^^^^^^^^^
> +
> +The PGA can be configured either through GPIO control or pin-strapping:
> +
> +- When using GPIO control, specify the "pga-gpios" property in the devic=
e tree
> +- For pin-strapped configuration, specify the "adi,pga-value" property i=
n the
> +device tree
> +
> +Available PGA gain settings:
> +  - 1x (PGA1=3D0, PGA2=3D0)
> +  - 8x (PGA1=3D0, PGA2=3D1)
> +  - 64x (PGA1=3D1, PGA2=3D0)
> +  - 128x (PGA1=3D1, PGA2=3D1)
> +
> +Clock Configuration
> +-----------------
> +
> +The AD7191 supports both internal and external clock sources:
> +
> +- When CLKSEL pin is tied LOW: Uses internal 4.92MHz clock (no clock pro=
perty
> +needed)
> +- When CLKSEL pin is tied HIGH: Requires external clock source
> +  - Can be a crystal between MCLK1 and MCLK2 pins
> +  - Or a CMOS-compatible clock driving MCLK2 pin
> +  - Must specify the "clocks" property in device tree when using externa=
l clock
> +
> +SPI Interface Requirements
> +------------------------
> +
> +The AD7191 has specific SPI interface requirements:
> +
> +- The DOUT/RDY output is dual-purpose and requires SPI bus locking
> +- DOUT/RDY must be connected to an interrupt-capable GPIO
> +- The SPI controller's chip select must be connected to the PDOWN pin of=
 the ADC
> +- When CS (PDOWN) is high, the device powers down and resets internal ci=
rcuitry
> +- SPI mode 3 operation (CPOL=3D1, CPHA=3D1) is required
> +
> +Power Supply Requirements
> +-----------------------
> +
> +The device requires the following power supplies:
> +
> +- AVdd: Analog power supply
> +- DVdd: Digital power supply
> +- Vref: Reference voltage supply (external)
> +
> +All power supplies must be specified in the device tree.
> +
> +Device Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Not enough =3D

Check all these as well after make html_docs


> +
> +The AD7191 provides several attributes through the IIO sysfs interface:
> +
> +Voltage Input Differential Channels
> +---------------------------------
> +
> ++-------------------+---------------------------------------------------=
-------+
> +| Attribute         | Description                                       =
       |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +| raw               | Raw ADC output value                              =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +| scale             | Scale factor to convert raw value to voltage      =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +| offset            | Voltage offset                                    =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +| sampling_frequency| Current sampling frequency setting                =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +
> +Temperature Sensor
> +----------------
> +
> ++-------------------+---------------------------------------------------=
-------+
> +| Attribute         | Description                                       =
       |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+
> +| raw               | Raw temperature sensor output value               =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +| scale             | Scale factor to convert raw value to temperature  =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +| offset            | Temperature calibration offset                    =
       |
> ++-------------------+---------------------------------------------------=
-------+
> +
> +Available Attributes
> +------------------
> +
> +The following attributes show available configuration options:
> +
> +- sampling_frequency_available: List of supported sampling frequencies
> +- scale_available: List of supported scale factors (based on PGA setting=
s)
> +
> +Channel Configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The device provides three channels:
> +
> +1. Temperature Sensor
> +   - 24-bit unsigned
> +   - Internal temperature measurement
> +   - Temperature in millidegrees Celsius
> +
> +2. Differential Input (AIN1-AIN2)
> +   - 24-bit unsigned
> +   - Differential voltage measurement
> +   - Configurable gain via PGA
> +
> +3. Differential Input (AIN3-AIN4)
> +   - 24-bit unsigned
> +   - Differential voltage measurement
> +   - Configurable gain via PGA
> +
> +Device Tree Bindings
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Required Properties
> +-----------------
> +
> +- compatible: Should be "adi,ad7191"
> +- reg: SPI chip select number
> +- spi-max-frequency: Maximum SPI clock frequency
> +- spi-cpol: Must be present (set to 1)
> +- spi-cpha: Must be present (set to 1)
> +- interrupts: Interrupt mapping for DOUT/RDY pin
> +- avdd-supply: Analog power supply
> +- dvdd-supply: Digital power supply
> +- vref-supply: Reference voltage supply
> +- temp-gpios: GPIO for temperature channel selection
> +- chan-gpios: GPIO for input channel selection
> +
> +Optional Properties
> +-----------------
> +
> +- clocks: Required when using external clock (CLKSEL=3D1), must be absen=
t for
> +internal clock
> +- adi,odr-value: Pin-strapped ODR configuration (120, 60, 50, or 10)
> +- adi,pga-value: Pin-strapped PGA configuration (1, 8, 64, or 128)
> +- odr-gpios: GPIOs for ODR control (mutually exclusive with adi,odr-valu=
e)
> +- pga-gpios: GPIOs for PGA control (mutually exclusive with adi,pga-valu=
e)
> +
> +Example Device Tree
> +-----------------
> +
> +.. code-block:: dts
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ad7191@0 {
> +            compatible =3D "adi,ad7191";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +
> +            /* Required SPI mode 3 */
> +            spi-cpol;
> +            spi-cpha;
> +
> +            /* Interrupt for DOUT/RDY pin */
> +            interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio>;
> +
> +            /* Power supplies */
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +            vref-supply =3D <&vref>;
> +
> +            /* Optional external clock */
> +            clocks =3D <&ad7191_mclk>;
> +
> +            /* Configuration - either use GPIO control or pin-strapped v=
alues */
> +            adi,pga-value =3D <1>;
> +            odr-gpios =3D <&gpio 23 GPIO_ACTIVE_HIGH>,
> +                       <&gpio 24 GPIO_ACTIVE_HIGH>;
> +
> +            /* Required GPIO controls */
> +            temp-gpios =3D <&gpio 22 GPIO_ACTIVE_HIGH>;
> +            chan-gpios =3D <&gpio 27 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +
> +Buffer Support
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver supports IIO triggered buffers. See Documentation/iio/iio_de=
vbuf.rst
> +for more information about IIO triggered buffers.


