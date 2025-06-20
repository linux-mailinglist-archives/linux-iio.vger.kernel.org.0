Return-Path: <linux-iio+bounces-20794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A0AE1362
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 07:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885AB6A0606
	for <lists+linux-iio@lfdr.de>; Fri, 20 Jun 2025 05:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740F9219A7D;
	Fri, 20 Jun 2025 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmF77vlF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF9E218AAB;
	Fri, 20 Jun 2025 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398561; cv=none; b=N9F0efLs6pcIypguglWorbk/CZgRgAMhov/zCaZb1bbLjQ++K+1shWvtiVPol6YgrUoy0ndJU1kU2JxtQsoTv+uk4IJKL/GA0uWuSUlsImhXyi16Z3zlx6dSz++rejC9bLp85IScdI+FeKh2amiG4VM5wWMM3cYWykttSX6qAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398561; c=relaxed/simple;
	bh=haj66sQygX8Kaxmov9JSNP6qZCUOkzrgO1Nlr0Gjfmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZGmHrCC42mLfVSGF3ODC3uzXTdY7D9T5c0QwAs9sd49MIYArmfi5r7VveX1NkDBTzQazhzn9v22w0UoCm7nB6hea/W85y+yjDBdvYzpnu2kOpWk02lZCFJPXy2uqvY9IOya01flF6J3L/eyrlnZknNZHfr1rOJk1nFW3R69YVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmF77vlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACD8C4CEED;
	Fri, 20 Jun 2025 05:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750398561;
	bh=haj66sQygX8Kaxmov9JSNP6qZCUOkzrgO1Nlr0Gjfmg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cmF77vlFsXgJntmcCio9HoRzhGO7x1D5avrRop4Z66kASWl5dxtqlvrg2X6pF+Gx4
	 snTeBYZ3qtJrYA8Z8nb1R3SAlTlqYLuS25gRR+YeDtcRQU8ZhoEQd4VbgNYjADkuOW
	 f3i/AbEI9mAcTs3JGslQ8T8NiZFu2NItQdOhzorou7Gt4XEsB3FlGC66LyKgXMWS1q
	 YHKFYMunjHBlXZRC+PHag4lOZWn8/YjrcByKtFFLbzf7kcL5KALbc+tewtzpVXnwwJ
	 YcQxgTogGmMbhAPZX4t7uQW6bWarCRmTWzv5ywojE2f/9HUWvhGhWo/JYEzPAFLKqr
	 h8FBX1W8/2JaQ==
Message-ID: <5e39d279-b981-4735-9a5a-f28069474d5f@kernel.org>
Date: Fri, 20 Jun 2025 07:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Add the iio driver for bosch pressure sensor
 bmp390. The bmp390 is a pressure sensor module. It will support SPI and I2C
 protocol based on configuration.
To: liquancin.mereenamathai@in.bosch.com, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, vassilisamir@gmail.com,
 marcelo.schmitt1@gmail.com, javier.carrasco.cruz@gmail.com,
 Xu.Zhang@cn.bosch.com, Maoting.Bian@cn.bosch.com
References: <20250620045456.1151-1-liquancin.mereenamathai@in.bosch.com>
 <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250620045456.1151-2-liquancin.mereenamathai@in.bosch.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2025 06:54, liquancin.mereenamathai@in.bosch.com wrote:
> From: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> 
> Implemented features:
> * raw data access for pressure and temp through sysfs
> * iio buffer tool support for continuous sampling
> 
> Signed-off-by: Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> ---
>  MAINTAINERS                                   |    7 +
>  drivers/iio/pressure/Kconfig                  |   26 +
>  drivers/iio/pressure/Makefile                 |    1 +
>  drivers/iio/pressure/bmp390/Kconfig           |   29 +
>  drivers/iio/pressure/bmp390/Makefile          |   32 +
>  drivers/iio/pressure/bmp390/bmp3.c            | 2781 +++++++++++++++++
>  drivers/iio/pressure/bmp390/bmp3.h            |  537 ++++
>  drivers/iio/pressure/bmp390/bmp390_driver.c   | 1604 ++++++++++
>  drivers/iio/pressure/bmp390/bmp390_driver.h   |  232 ++
>  drivers/iio/pressure/bmp390/bmp390_i2c.c      |  328 ++
>  .../iio/pressure/bmp390/bmp390_iio_buffer.c   |  220 ++
>  drivers/iio/pressure/bmp390/bmp390_spi.c      |  286 ++
>  drivers/iio/pressure/bmp390/bmp3_defs.h       |  871 ++++++
>  drivers/iio/pressure/bmp390/bmp3_selftest.c   |  184 ++
>  drivers/iio/pressure/bmp390/bmp3_selftest.h   |   93 +
>  15 files changed, 7231 insertions(+)
>  create mode 100644 drivers/iio/pressure/bmp390/Kconfig
>  create mode 100644 drivers/iio/pressure/bmp390/Makefile
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3.h
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_driver.h
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_i2c.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_iio_buffer.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp390_spi.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3_defs.h
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.c
>  create mode 100644 drivers/iio/pressure/bmp390/bmp3_selftest.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1abec3f7d42b..f962f64d9a9e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27447,6 +27447,13 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  F:	sound/pci/hda/patch_senarytech.c
>  
> +BOSCH SENSORTEC BMP390 PRESSURE IIO DRIVER
> +M:	Liquancin Mereena Mathai <liquancin.mereenamathai@in.bosch.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/bosch,bmp390.yaml
> +F:	drivers/iio/pressure/bmp390/*
> +
>  THE REST
>  M:	Linus Torvalds <torvalds@linux-foundation.org>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index d2cb8c871f6a..ffa5a1c76e06 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -6,6 +6,32 @@
>  
>  menu "Pressure sensors"
>  
> +menu "Bosch BMP390 pressure sensor driver"
> +config BMP390_IIO
> +    tristate "Bosch BMP390 pressure sensor driver"
> +    depends on IIO
> +    help
> +      Say yes here to build support for the Bosch BMP390 pressure sensor.
> +
> +
> +      The Bosch BMP390 is a high-precision, low-power digital pressure sensor

Messed indentation. Look at other entries - what is the indentation there?

> +      designed for a wide range of applications, including weather monitoring,
> +      altitude tracking, and indoor navigation. This driver provides support
> +      for interfacing with the BMP390 sensor through the Industrial I/O (IIO)
> +      subsystem.
> +
> +      If you choose to compile this driver as a module, it will be named
> +      'bmp390'. This allows the driver to be dynamically loaded and unloaded
> +      as needed, providing flexibility in managing the sensor.
> +
> +      To compile this driver as a module, choose M here: the module will be
> +      called bmp390. If you are unsure, it is safe to say 'N' here.
> +



...

> +
> diff --git a/drivers/iio/pressure/bmp390/bmp3_selftest.h b/drivers/iio/pressure/bmp390/bmp3_selftest.h
> new file mode 100644
> index 000000000000..ab6c4a992011
> --- /dev/null
> +++ b/drivers/iio/pressure/bmp390/bmp3_selftest.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> +/**
> + * @section LICENSE
> + * Copyright (c) 2024 Bosch Sensortec GmbH All Rights Reserved.
> + *
> + * This software program is licensed subject to the GNU General
> + * Public License (GPL).Version 2,June 1991,
> + * available at http://www.fsf.org/copyleft/gpl.html
> + *
> + * @file		bmp3_selftest.h
> + * @date		2024-12-04
> + * @version		v2.1.0
> + *

Again...

> + */
> +
> +#ifndef BMP38X_SELFTEST_H_
> +#define BMP38X_SELFTEST_H_
> +
> +/*! CPP guard */
> +#ifdef __cplusplus
> +extern "C" {
> +#endif

No. We don't do C++ in the kernel. Don't upstream your user-space driver
or any other code looking 100% different than everything else in the
kernel. Instead take existing, most recent, reviewed kernel driver and
use it as starting point.

Entire driver has poor style, with these javadoc or doxygen annotations.
Or useless comments like "static functions declaration". That's not kernel.

Best regards,
Krzysztof

