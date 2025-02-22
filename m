Return-Path: <linux-iio+bounces-15956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E61CA4097F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFB0421E97
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65C619D092;
	Sat, 22 Feb 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzvFCNgu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60D14037F;
	Sat, 22 Feb 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237955; cv=none; b=RKpUtZQOlyiG5FzyPN/FHkxQgcRcOsLB1M8bRweJzxe9xb9c/CdKcwdhYNi03t8bdeOC52lOaABd+/6iqqtTrL6k7pdfS2zvgy2ZXuxrRHU6ulm9tpAdj9DDumfCWp/4om2Zx4/YBeN+c6G+bigBRjVnQwwonMYFk9XPg1k7voA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237955; c=relaxed/simple;
	bh=5FoHX3Ihpq6uQwdHsZ//hL1s5P1FmjObacFMhwq+9No=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGPuVRnlx417Xd0Xz5fQ/d0kOmg8Z9Jzzz1Rs/cYS+sIMgUoDsMb8YCqK5VXgXb/KzyEA5EmTMncdfFefWPR8ifaJsT2CghFgjPuF8lYp+aiCfCgcw3Rr28v0e/P7qaQEca3JqaDOAjJ/Eey+m1hP/8sAsPV95RwEyahPiavGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzvFCNgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE357C4CED1;
	Sat, 22 Feb 2025 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740237953;
	bh=5FoHX3Ihpq6uQwdHsZ//hL1s5P1FmjObacFMhwq+9No=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AzvFCNgussSYkj6AJHZmpkSgkVM8zJgCfcLakUXfA5ll4Khb1udMQ7pYeY5zipDIk
	 IaUXihFP0TKgIsy9LBeMX2DMWl3DUxljiD7ZwTCBwopxXcgkRHAM2zhEzxCy6ifbJz
	 SGKCNW7Go8Uv1fqxpS5bqE4SK5KG9qrdY0EQMIGN8PYL7T1mWL9btLQQzozRRiyI4U
	 K/h8M6yLGNwzg1y0qzULTpgJJOAbNYlrStjsT+6rnriHdOUxSINve2fOHlWAWEgubY
	 CsXhsSot3MyUsSolxbcGasAux1BHRWJUP81LkqYnvpWk+0sLeklkFdhILIQTchZSXs
	 d8OfoyZOGyVVw==
Date: Sat, 22 Feb 2025 15:25:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, gstols@baylibre.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, marcelo.schmitt@analog.com,
 alisadariana@gmail.com, joao.goncalves@toradex.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Message-ID: <20250222152537.2a24d80f@jic23-huawei>
In-Reply-To: <20250221090918.1487689-1-j2anfernee@gmail.com>
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 17:09:16 +0800
Eason Yang <j2anfernee@gmail.com> wrote:

Hi Eason,

Not sure if I asked this before, but this is a device that seems
to be typically used for hardware monitoring and there are a number
of similar sounding device in drivers/hwmon/  

That raises a couple of questions:
1) Is it compatible with any of those existing drivers?
2) Why IIO rather than HWMON?

There isn't normally a problem with having a hardware monitoring
related device supported by IIO, it is just good to know if your
usecase makes that a good idea.  We have the iio-hwmon bridge
driver to solve the problem of a device than can be used either
as a generic ADC or as a hwmon type monitoring device (which tends
to have more alarms etc)

Jonathan


> Change since version 4:
>  - Fix comments
>  - Add interrupts and reset-gpios to the DT example
>  - Use the FIELD_PREP and FIELD_GET
>  - Add use_single_write in regmap_config
>  - Use regmap_access_table
> 
> Change since version 3:
>  - Fix comments
>  - Don't put nct720"x" in the name, just call it nct7201
>  - Remove differential inputs until conversions are finished
>  - Add NCT7201_ prefix in all macros and avoid the tables
>  - Correct event threshold values in raw units
>  - Add with and without interrupt callback function to have the event
>    config part and one that doesn't
>  - Remove print an error message if regmap_wirte failed case
> 
> Change since version 2:
>  - Remvoe read-vin-data-size property, default use read word vin data
>  - Use regmap instead of i2c smbus API
>  - IIO should be IIO_CHAN_INFO_RAW and _SCALE not _PROCESSED
>  - Use dev_xxx_probe in probe function and dev_xxx in other functions
>  - Use devm_iio_device_register replace of iio_device_register
>  - Use guard(mutex) replace of mutex_lock
>  - Use get_unaligned_le16 conversion API
> 
> Changes since version 1:
>  - Add new property in iio:adc binding document
>  - Add new driver for Nuvoton NCT720x driver
> 
> Eason Yang (2):
>   dt-bindings: iio: adc: add NCT7201 ADCs
>   iio: adc: add support for Nuvoton NCT7201
> 
>  .../bindings/iio/adc/nuvoton,nct7201.yaml     |  57 ++
>  MAINTAINERS                                   |   2 +
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/nct7201.c                     | 487 ++++++++++++++++++
>  5 files changed, 558 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
>  create mode 100644 drivers/iio/adc/nct7201.c
> 


