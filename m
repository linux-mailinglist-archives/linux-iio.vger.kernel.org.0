Return-Path: <linux-iio+bounces-7677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4CE934D65
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 14:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB121F22E6F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ADD13BC1B;
	Thu, 18 Jul 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3+1vL0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADE01E53A;
	Thu, 18 Jul 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306854; cv=none; b=efchys1unTHo1NhRzPfpZQzDJBnlJWduY4V9LN/I1CpnbRPu/sFut1V+HMuQkYd4zBrQ7PDpZZUXFnnddy+vII85seR2z59r0leKaMGgXkoqXoLWDfx5w2bFm7d/2e3pzmaCL4dSkmyeMgrjtEKqZr/MHFOJmsGB8LWae4dkStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306854; c=relaxed/simple;
	bh=u/gMUo9YD51LZG8Itl0gBpfMLa22w0wIfbFseL996ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jTcWPGaGFV+mkgJCySe0BUjIpEMXUkJ4Xb4X5+E9xLSKsQgdJm5aWgFjcG5nU7N2B7z9uSlujwqMjjGgkmwbPC4hjDZxKTkh27k3SLenV3dQCRtH15im3s6NoR3DQmcgY+th9hHFAelWwOl+DS1Bz7lyQDYgSOFctbI8gj8eUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3+1vL0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AFBC116B1;
	Thu, 18 Jul 2024 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721306854;
	bh=u/gMUo9YD51LZG8Itl0gBpfMLa22w0wIfbFseL996ZM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=t3+1vL0fluWG7AqrGpj1gB1SbRtfRbyVifsRKQTcjTV4/vj3P6pOoZbWwIV9jmK5k
	 QV+L/fNdCJGwbeBkvBVpoX5X0q+QMEF8c359fPwipvpiPoUjxtsqZrDbaSW8C4OFHh
	 PggbhMNliegWcJhL2BSapPc3KEl4THca6Cgr+pGbNIxS17kbdCH5sZXa05fbrzReIv
	 h+qPDnHX1tgmd8diqXZgzDNoyGxdpnOtK3+ZPVg25iwzZ+fCT3yzUUN3yn27cqgQ1f
	 twT81neUZAoz3Q7GWxTzDL+ZGpl/kQl8UNR9kRqNoTGhC1QnJMrBG6RAgatB2/zk/J
	 an5t7q8yaHC/w==
Message-ID: <5aec49af-0a24-464b-b24c-cb23c7b1ae95@kernel.org>
Date: Thu, 18 Jul 2024 14:47:27 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: Bosch SMI240 IMU Driver
To: Jianping.Shen@de.bosch.com, jic23@kernel.org, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian.Lorenz3@de.bosch.com,
 Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
References: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2024 14:24, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)" <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> 
> Add Bosch SMI240 IMU IIO Driver to iio-for-6.10b

What is "iio-for-6.10b"? How is it relevant to git history? This is
supposed to say something about the driver and hardware.

> 
> Signed-off-by: Shen Jianping (ME-SE/EAD2) <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> ---
>  .../bindings/iio/imu/bosch,smi240.yaml        |  45 +
>  drivers/iio/imu/Kconfig                       |   2 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/smi240/Kconfig                |  30 +
>  drivers/iio/imu/smi240/Makefile               |   8 +
>  drivers/iio/imu/smi240/smi240.h               |  31 +
>  drivers/iio/imu/smi240/smi240_core.c          | 814 ++++++++++++++++++
>  drivers/iio/imu/smi240/smi240_spi.c           | 153 ++++
>  8 files changed, 1084 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
>  create mode 100644 drivers/iio/imu/smi240/Kconfig
>  create mode 100644 drivers/iio/imu/smi240/Makefile
>  create mode 100644 drivers/iio/imu/smi240/smi240.h
>  create mode 100644 drivers/iio/imu/smi240/smi240_core.c
>  create mode 100644 drivers/iio/imu/smi240/smi240_spi.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..972819cacff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,smi240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BOSCH SMI240

Also: BOSCH or Bosch?

> +
> +maintainers:
> +  - unknown
> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope 
> +  https://www.bosch-semiconductors.com/mems-sensors/highly-automated-driving/smi240/
> +
> +properties:
> +  compatible:
> +    const: BOSCH,SMI240
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - spi-max-frequency
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        smi240@0 {
> +            compatible = "BOSCH,SMI240";
> +            spi-max-frequency = <10000000>;
> +            reg = <0>;
> +        };
> +    };
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 52a155ff325..2c348ad686a 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -96,6 +96,8 @@ config KMX61
>  
>  source "drivers/iio/imu/inv_icm42600/Kconfig"
>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
> +source "/home/she2rt/dev/smi240-linux-driver-iio/drivers/iio/imu/smi240/Kconfig"

Yeah... this won't work, obviously.

> +source "drivers/iio/imu/smi240/Kconfig"
>  source "drivers/iio/imu/st_lsm6dsx/Kconfig"
>  source "drivers/iio/imu/st_lsm9ds0/Kconfig"
>  
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> index 7e2d7d5c3b7..b6f162ae4ed 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -27,5 +27,6 @@ obj-y += inv_mpu6050/
>  
>  obj-$(CONFIG_KMX61) += kmx61.o
>  
> +obj-y += smi240/
>  obj-y += st_lsm6dsx/
>  obj-y += st_lsm9ds0/
> diff --git a/drivers/iio/imu/smi240/Kconfig b/drivers/iio/imu/smi240/Kconfig
> new file mode 100644
> index 00000000000..7114c941cc3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/Kconfig
> @@ -0,0 +1,30 @@

Missing SPDX

> +config SMI240
> +	tristate "Bosch Sensor SMI240 Inertial Measurement Unit"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Build driver
> +	  for Bosch
> +	  SMI240 6-axis IMU
> +	  sensor.

Ooh my... what's this style?

Read coding style for Kconfig.


> +
> +config SMI240_MAX_BUFFER_LEN

Drop, dead code.

> +	depends on SMI240
> +	int "configue read buffer size"
> +	default "1024"
> +	help
> +	  1024 bytes are big
> +	  enough for most cases.
> +	  Do not change this value
> +	  if not sure.
> +
> +config SMI240_UNIT_TEST

Drop, dead code.

> +	tristate "Unit Test for SMI240"
> +	depends on KUNIT=y
> +	help
> +	  Build Unit Test
> +	  for Bosch
> +	  SMI240 6-axis
> +	  IMU sensor.
> +
> diff --git a/drivers/iio/imu/smi240/Makefile b/drivers/iio/imu/smi240/Makefile
> new file mode 100644
> index 00000000000..394eaecf5f3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for Bosch SMI240

Drop. It cannot be anything else. Do not say that "x" is a "x".

You miss SPDX on the other hand.

> +#
> +
> +obj-$(CONFIG_SMI240) += smi240.o
> +smi240-objs := smi240_core.o


Best regards,
Krzysztof


