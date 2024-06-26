Return-Path: <linux-iio+bounces-6934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F282C917891
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AC91C21A1A
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 06:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C5148FF7;
	Wed, 26 Jun 2024 06:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m8YRuyJC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609D146594
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382277; cv=none; b=gCmaRwVtw3TcfyPkVe8nnN+bqTwpc/hlNL7r2/+16ZG4bctWuylZxzeKOvgrua6WGB0C4s1EtVZXyA+TMFqvkaQhLEwBAwel+KJmRyYu87dpvQxA3N7xkD9IHIi9H8+siD2gLINb9j28rU8aublv4yvUo/kUoN1kxSh6elUGey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382277; c=relaxed/simple;
	bh=/HYDmNirUY5znW5QNOZyrKmyUQvqtiIrJ+wTX1Eoea4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXQkJIp/QwRj7Mte/xgJw45Fi1SHRweBUhXQN5dnjDOAb7Q72Opp5G8sUCmOhp9ri1DqybypyRprt810JUITg67JMcNzsJ4un7uzF81MqYrp6YtakcddBO3V66Fllb7/gtqKtciuwA2Kszu6vKMwF7+HLMEiat73UN2RIcrJhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=m8YRuyJC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ef63c6be17so164790e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Jun 2024 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719382271; x=1719987071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXBvlOv3hmTugL40GJsKnN+zTCUYdB3dlYfOv/3OcJw=;
        b=m8YRuyJC/p0NRbC62d3avgfjO0eiscHriniVz9JBnQjypWhrMweTXp8u82wAqlQDTE
         2EygpOUwK9Tz/uqlFmy8WhwTmqvq39L9A4RAdJUldJt1EcK4U4W7xgx71GB3upkIqcRJ
         vuGY+pkMrkxL9TsC9cXvHoxfn1Myk+gdwIZ7sYVXH1JPQTV+U1qHWRhVYxA7E5pCbkuU
         DxyqU2EQGG52hn1LhWXVH5KyjZW7i+h33gTpT7MzcRwzZH8TRCHRj7XbW85Knxk//x4b
         n96K1W5GDqipBM8gurjbXfxLtoQ0qao4xjuvSVNdegHui9o53ov00nPgj++8pekpozOi
         SL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382271; x=1719987071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXBvlOv3hmTugL40GJsKnN+zTCUYdB3dlYfOv/3OcJw=;
        b=OU9amvLkmhcK1yG3feYieg+4EsuVPdYD9fY3z8tTXoL5qyhEP8EsiSi19lcikynwSr
         LE0vpu3Tx0cuIrNrBolbw97MlpYdOaKUzWWPbTMLxSReMqA7GlFCSay2M876B2vx5zLP
         xhODNPiGg3+ZJtkylJGi2sNxdR3+iyq1LBreRy0tTTaFHvcWPjg1iB6hhSGjdyJes49s
         6bd2+D2e/n/UceyE6wEUoQv8aBAB5QkfOInAJWb8ecciardInp9IbnKzJEGTrr0UmA8b
         y8OmEAT05VyotWQwyz5AKlxIAhvx5cswkMsxRjSGico8WLpFFRnOiYMvXsZtNGQFLyJ+
         LcKw==
X-Forwarded-Encrypted: i=1; AJvYcCXcD7Jg21D/if3z8jn+XS5Er89vm6FHk0pwqH4oXPb+ZJ+ceBfKcSyTDEAeZ1ajzPMBsfc/Nbs7KjpkHjqXobdye1enIpKbfjJo
X-Gm-Message-State: AOJu0Yw2WCV+RYPIAR0ppOTGLnq7q2YYG7ToIQpYqKjOShEz9Z9tlqgw
	LwYfZjiOPXKWLIAB/spacuhQAIPMsQrLZ+xv7if7GPX+w0xkWloXskmPoRs91nKMt3EUu0bcI2J
	AhmSzBoiGZ+dZ5RyEfBM4Y1R0bP4ahiL2W7cq6g==
X-Google-Smtp-Source: AGHT+IE/Acs0Fj5rGK34yJKa/gWeXKKWFHRx7ktDor54x4ijn/rPhFWN98A05y+I+mdN9hoYfMbnQh2vLrz92KYIWrw=
X-Received: by 2002:a05:6122:1e07:b0:4ec:f2b9:65c9 with SMTP id
 71dfb90a1353d-4ef60c519d4mr10230788e0c.0.1719382271299; Tue, 25 Jun 2024
 23:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719351923.git.marcelo.schmitt@analog.com> <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
In-Reply-To: <eb5f7b73bdf3ac89117e28f26ee3f54ba849163e.1719351923.git.marcelo.schmitt@analog.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Wed, 26 Jun 2024 09:11:00 +0300
Message-ID: <CA+GgBR9E2EMeqAXJ=b7jMnJgd4FXZPNm-LYEe-=aKZhJBkFNNw@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] iio: adc: Add support for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: broonie@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	corbet@lwn.net, marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:56=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> Add support for AD4000 series of low noise, low power, high speed,
> successive approximation register (SAR) ADCs.
>

Hello :)

Looks good overall.
Just a few comments.
The only one where I am not sure is about the enum-to-string mapping.
If that's fine, we can leave this unchanged (from my side).

> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  12 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad4000.c | 711 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 725 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4000.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9aa6531f7cf2..f4ffedada8ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1205,6 +1205,7 @@ L:        linux-iio@vger.kernel.org
>  S:     Supported
>  W:     https://ez.analog.com/linux-software-drivers
>  F:     Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +F:     drivers/iio/adc/ad4000.c
>
>  ANALOG DEVICES INC AD4130 DRIVER
>  M:     Cosmin Tanislav <cosmin.tanislav@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index b8184706c7d1..5bbe843916a3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -21,6 +21,18 @@ config AD_SIGMA_DELTA
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>
> +config AD4000
> +       tristate "Analog Devices AD4000 ADC Driver"
> +       depends on SPI
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         Say yes here to build support for Analog Devices AD4000 high sp=
eed
> +         SPI analog to digital converters (ADC).
> +
> +         To compile this driver as a module, choose M here: the module w=
ill be
> +         called ad4000.
> +
>  config AD4130
>         tristate "Analog Device AD4130 ADC Driver"
>         depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 51298c52b223..f4361df40cca 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> +obj-$(CONFIG_AD4000) +=3D ad4000.o
>  obj-$(CONFIG_AD4130) +=3D ad4130.o
>  obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> new file mode 100644
> index 000000000000..0b6293db68dc
> --- /dev/null
> +++ b/drivers/iio/adc/ad4000.c
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4000 SPI ADC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define AD4000_READ_COMMAND    0x54
> +#define AD4000_WRITE_COMMAND   0x14
> +
> +#define AD4000_CONFIG_REG_DEFAULT      0xE1
> +
> +/* AD4000 Configuration Register programmable bits */
> +#define AD4000_CFG_STATUS              BIT(4) /* Status bits output */
> +#define AD4000_CFG_SPAN_COMP           BIT(3) /* Input span compression =
 */
> +#define AD4000_CFG_HIGHZ               BIT(2) /* High impedance mode  */
> +#define AD4000_CFG_TURBO               BIT(1) /* Turbo mode */
> +
> +#define AD4000_SCALE_OPTIONS           2
> +
> +#define AD4000_TQUIET1_NS              190
> +#define AD4000_TQUIET2_NS              60
> +#define AD4000_TCONV_NS                        320
> +
> +#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_acc=
ess)   \
> +{                                                                       =
       \
> +       .type =3D IIO_VOLTAGE,                                           =
         \
> +       .indexed =3D 1,                                                  =
         \
> +       .differential =3D 1,                                             =
         \
> +       .channel =3D 0,                                                  =
         \
> +       .channel2 =3D 1,                                                 =
         \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |                 =
         \
> +                             BIT(IIO_CHAN_INFO_SCALE),                  =
       \
> +       .info_mask_separate_available =3D _reg_access ? BIT(IIO_CHAN_INFO=
_SCALE) : 0,\
> +       .scan_type =3D {                                                 =
         \
> +               .sign =3D _sign,                                         =
         \
> +               .realbits =3D _real_bits,                                =
         \
> +               .storagebits =3D _storage_bits,                          =
         \
> +               .shift =3D _storage_bits - _real_bits,                   =
         \
> +               .endianness =3D IIO_BE,                                  =
         \
> +       },                                                               =
       \
> +}
> +
> +#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access)             =
       \
> +       __AD4000_DIFF_CHANNEL((_sign), (_real_bits),                     =
       \
> +                                    ((_real_bits) > 16 ? 32 : 16), (_reg=
_access))
> +
> +#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _=
reg_access)\
> +{                                                                       =
       \
> +       .type =3D IIO_VOLTAGE,                                           =
         \
> +       .indexed =3D 1,                                                  =
         \
> +       .channel =3D 0,                                                  =
         \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |                 =
         \
> +                             BIT(IIO_CHAN_INFO_SCALE) |                 =
       \
> +                             BIT(IIO_CHAN_INFO_OFFSET),                 =
       \
> +       .info_mask_separate_available =3D _reg_access ? BIT(IIO_CHAN_INFO=
_SCALE) : 0,\
> +       .scan_type =3D {                                                 =
         \
> +               .sign =3D _sign,                                         =
         \
> +               .realbits =3D _real_bits,                                =
         \
> +               .storagebits =3D _storage_bits,                          =
         \
> +               .shift =3D _storage_bits - _real_bits,                   =
         \
> +               .endianness =3D IIO_BE,                                  =
         \
> +       },                                                               =
       \
> +}
> +
> +#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access)      =
       \
> +       __AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),              =
       \
> +                                    ((_real_bits) > 16 ? 32 : 16), (_reg=
_access))
> +
> +enum ad4000_sdi {
> +       /* datasheet calls this "4-wire mode" (controller CS goes to ADC =
SDI!) */
> +       AD4000_SDI_MOSI,
> +       /* datasheet calls this "3-wire mode" (not related to SPI_3WIRE!)=
 */
> +       AD4000_SDI_VIO,
> +       AD4000_SDI_CS,
> +};
> +
> +/* maps adi,sdi-pin property value to enum */
> +static const char * const ad4000_sdi_pin[] =3D {
> +       [AD4000_SDI_MOSI] =3D "",

Maybe I missed a previous comment.
And I'm also a little fuzzy on the details here, but in the DT this
property has "high", "low", "cs".
Is "low" the default if unspecified?
Or should this string be "low"?

> +       [AD4000_SDI_VIO] =3D "high",
> +       [AD4000_SDI_CS] =3D "cs",
> +};
> +
> +struct ad4000_chip_info {
> +       const char *dev_name;
> +       struct iio_chan_spec chan_spec;
> +       struct iio_chan_spec reg_access_chan_spec;
> +       bool has_hardware_gain;
> +};
> +
> +static const struct ad4000_chip_info ad4000_chip_info =3D {
> +       .dev_name =3D "ad4000",
> +       .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> +       .reg_access_chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4001_chip_info =3D {
> +       .dev_name =3D "ad4001",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 16, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4002_chip_info =3D {
> +       .dev_name =3D "ad4002",
> +       .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4003_chip_info =3D {
> +       .dev_name =3D "ad4003",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4004_chip_info =3D {
> +       .dev_name =3D "ad4004",
> +       .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> +       .reg_access_chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4005_chip_info =3D {
> +       .dev_name =3D "ad4005",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 16, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4006_chip_info =3D {
> +       .dev_name =3D "ad4006",
> +       .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4007_chip_info =3D {
> +       .dev_name =3D "ad4007",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4008_chip_info =3D {
> +       .dev_name =3D "ad4008",
> +       .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> +       .reg_access_chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4010_chip_info =3D {
> +       .dev_name =3D "ad4010",
> +       .chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4011_chip_info =3D {
> +       .dev_name =3D "ad4011",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4020_chip_info =3D {
> +       .dev_name =3D "ad4020",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 20, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 20, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4021_chip_info =3D {
> +       .dev_name =3D "ad4021",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 20, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 20, 1),
> +};
> +
> +static const struct ad4000_chip_info ad4022_chip_info =3D {
> +       .dev_name =3D "ad4022",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 20, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 20, 1),
> +};
> +
> +static const struct ad4000_chip_info adaq4001_chip_info =3D {
> +       .dev_name =3D "adaq4001",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 16, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 16, 1),
> +       .has_hardware_gain =3D true,
> +};
> +
> +static const struct ad4000_chip_info adaq4003_chip_info =3D {
> +       .dev_name =3D "adaq4003",
> +       .chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 0),
> +       .reg_access_chan_spec =3D AD4000_DIFF_CHANNEL('s', 18, 1),
> +       .has_hardware_gain =3D true,
> +};
> +
> +struct ad4000_state {
> +       struct spi_device *spi;
> +       struct gpio_desc *cnv_gpio;
> +       struct spi_transfer xfers[2];
> +       struct spi_message msg;
> +       struct mutex lock; /* Protect read modify write cycle */
> +       int vref_mv;
> +       enum ad4000_sdi sdi_pin;
> +       bool span_comp;
> +       bool turbo_mode;
> +       u16 gain_milli;
> +       int scale_tbl[AD4000_SCALE_OPTIONS][2];
> +
> +       /*
> +        * DMA (thus cache coherency maintenance) requires the transfer b=
uffers
> +        * to live in their own cache lines.
> +        */
> +       struct {
> +               union {
> +                       __be16 sample_buf16;
> +                       __be32 sample_buf32;
> +               } data;
> +               s64 timestamp __aligned(8);
> +       } scan __aligned(IIO_DMA_MINALIGN);
> +       u8 tx_buf[2];
> +       u8 rx_buf[2];
> +};
> +
> +static void ad4000_fill_scale_tbl(struct ad4000_state *st,
> +                                 struct iio_chan_spec const *chan)
> +{
> +       int val, tmp0, tmp1;
> +       int scale_bits;
> +       u64 tmp2;
> +
> +       /*
> +        * ADCs that output two's complement code have one less bit to ex=
press
> +        * voltage magnitude.
> +        */
> +       if (chan->scan_type.sign =3D=3D 's')
> +               scale_bits =3D chan->scan_type.realbits - 1;
> +       else
> +               scale_bits =3D chan->scan_type.realbits;
> +
> +       /*
> +        * The gain is stored as a fraction of 1000 and, as we need to
> +        * divide vref_mv by the gain, we invert the gain/1000 fraction.
> +        * Also multiply by an extra MILLI to preserve precision.
> +        * Thus, we have MILLI * MILLI equals MICRO as fraction numerator=
.
> +        */
> +       val =3D mult_frac(st->vref_mv, MICRO, st->gain_milli);
> +       /* Would multiply by NANO here but we multiplied by extra MILLI *=
/
> +       tmp2 =3D shift_right((u64)val * MICRO, scale_bits);
> +       tmp0 =3D div_s64_rem(tmp2, NANO, &tmp1);
> +       /* Store scale for when span compression is disabled */
> +       st->scale_tbl[0][0] =3D tmp0; /* Integer part */
> +       st->scale_tbl[0][1] =3D abs(tmp1); /* Fractional part */
> +       /* Store scale for when span compression is enabled */
> +       st->scale_tbl[1][0] =3D tmp0;
> +       /* The integer part is always zero so don't bother to divide it. =
*/
> +       if (chan->differential)
> +               st->scale_tbl[1][1] =3D DIV_ROUND_CLOSEST(abs(tmp1) * 4, =
5);
> +       else
> +               st->scale_tbl[1][1] =3D DIV_ROUND_CLOSEST(abs(tmp1) * 9, =
10);
> +}
> +
> +static int ad4000_write_reg(struct ad4000_state *st, uint8_t val)
> +{
> +       st->tx_buf[0] =3D AD4000_WRITE_COMMAND;
> +       st->tx_buf[1] =3D val;
> +       return spi_write(st->spi, st->tx_buf, ARRAY_SIZE(st->tx_buf));
> +}
> +
> +static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
> +{
> +       struct spi_transfer t =3D {
> +               .tx_buf =3D st->tx_buf,
> +               .rx_buf =3D st->rx_buf,
> +               .len =3D 2,
> +       };
> +       int ret;
> +
> +       st->tx_buf[0] =3D AD4000_READ_COMMAND;
> +       ret =3D spi_sync_transfer(st->spi, &t, 1);
> +       if (ret < 0)
> +               return ret;
> +
> +       *val =3D st->tx_buf[1];
> +       return ret;
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections =
are
> + * in "3-wire" mode, selected when the adi,sdi-pin device tree property =
is
> + * absent or set to "high". In this connection mode, the ADC SDI pin is
> + * connected to MOSI or to VIO and ADC CNV pin is connected either to a =
SPI
> + * controller CS or to a GPIO.
> + * AD4000 series of devices initiate conversions on the rising edge of C=
NV pin.
> + *
> + * If the CNV pin is connected to an SPI controller CS line (which is by=
 default
> + * active low), the ADC readings would have a latency (delay) of one rea=
d.
> + * Moreover, since we also do ADC sampling for filling the buffer on tri=
ggered
> + * buffer mode, the timestamps of buffer readings would be disarranged.
> + * To prevent the read latency and reduce the time discrepancy between t=
he
> + * sample read request and the time of actual sampling by the ADC, do a
> + * preparatory transfer to pulse the CS/CNV line.
> + */
> +static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
> +                                            const struct iio_chan_spec *=
chan)
> +{
> +       unsigned int cnv_pulse_time =3D st->turbo_mode ? AD4000_TQUIET1_N=
S
> +                                                    : AD4000_TCONV_NS;
> +       struct spi_transfer *xfers =3D st->xfers;
> +
> +       xfers[0].cs_change =3D 1;
> +       xfers[0].cs_change_delay.value =3D cnv_pulse_time;
> +       xfers[0].cs_change_delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +       xfers[1].rx_buf =3D &st->scan.data;
> +       xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +       xfers[1].delay.value =3D AD4000_TQUIET2_NS;
> +       xfers[1].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +       spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> +
> +       return devm_spi_optimize_message(st->spi, &st->msg);
> +}
> +
> +/*
> + * This executes a data sample transfer for when the device connections =
are
> + * in "4-wire" mode, selected when the adi,sdi-pin device tree property =
is
> + * set to "cs". In this connection mode, the controller CS pin is connec=
ted to
> + * ADC SDI pin and a GPIO is connected to ADC CNV pin.
> + * The GPIO connected to ADC CNV pin is set outside of the SPI transfer.
> + */
> +static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
> +                                            const struct iio_chan_spec *=
chan)
> +{
> +       unsigned int cnv_to_sdi_time =3D st->turbo_mode ? AD4000_TQUIET1_=
NS
> +                                                     : AD4000_TCONV_NS;
> +       struct spi_transfer *xfers =3D st->xfers;
> +
> +       /*
> +        * Dummy transfer to cause enough delay between CNV going high an=
d SDI
> +        * going low.
> +        */
> +       xfers[0].cs_off =3D 1;
> +       xfers[0].delay.value =3D cnv_to_sdi_time;
> +       xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> +
> +       xfers[1].rx_buf =3D &st->scan.data;
> +       xfers[1].len =3D BITS_TO_BYTES(chan->scan_type.storagebits);
> +
> +       spi_message_init_with_transfers(&st->msg, st->xfers, 2);
> +
> +       return devm_spi_optimize_message(st->spi, &st->msg);
> +}
> +
> +static int ad4000_convert_and_acquire(struct ad4000_state *st)
> +{
> +       int ret;
> +
> +       /*
> +        * In 4-wire mode, the CNV line is held high for the entire conve=
rsion
> +        * and acquisition process. In other modes, the CNV GPIO is optio=
nal
> +        * and, if provided, replaces controller CS. If CNV GPIO is not d=
efined
> +        * gpiod_set_value_cansleep() has no effect.
> +        */
> +       gpiod_set_value_cansleep(st->cnv_gpio, 1);
> +       ret =3D spi_sync(st->spi, &st->msg);
> +       gpiod_set_value_cansleep(st->cnv_gpio, 0);
> +
> +       return ret;
> +}
> +
> +static int ad4000_single_conversion(struct iio_dev *indio_dev,
> +                                   const struct iio_chan_spec *chan, int=
 *val)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       u32 sample;
> +       int ret;
> +
> +       ret =3D ad4000_convert_and_acquire(st);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (chan->scan_type.storagebits > 16)
> +               sample =3D be32_to_cpu(st->scan.data.sample_buf32);
> +       else
> +               sample =3D be16_to_cpu(st->scan.data.sample_buf16);
> +
> +       sample >>=3D chan->scan_type.shift;
> +
> +       if (chan->scan_type.sign =3D=3D 's')
> +               *val =3D sign_extend32(sample, chan->scan_type.realbits -=
 1);
> +
> +       return IIO_VAL_INT;
> +}
> +
> +static int ad4000_read_raw(struct iio_dev *indio_dev,
> +                          struct iio_chan_spec const *chan, int *val,
> +                          int *val2, long info)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:
> +               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +                       return ad4000_single_conversion(indio_dev, chan, =
val);
> +               unreachable();
> +       case IIO_CHAN_INFO_SCALE:
> +               *val =3D st->scale_tbl[st->span_comp][0];
> +               *val2 =3D st->scale_tbl[st->span_comp][1];
> +               return IIO_VAL_INT_PLUS_NANO;
> +       case IIO_CHAN_INFO_OFFSET:
> +               *val =3D 0;
> +               if (st->span_comp)
> +                       *val =3D mult_frac(st->vref_mv, 1, 10);
> +
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int ad4000_read_avail(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            const int **vals, int *type, int *length,
> +                            long info)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals =3D (int *)st->scale_tbl;
> +               *length =3D AD4000_SCALE_OPTIONS * 2;
> +               *type =3D IIO_VAL_INT_PLUS_NANO;
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
> +                                   struct iio_chan_spec const *chan, lon=
g mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               return IIO_VAL_INT_PLUS_NANO;
> +       default:
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       }
> +}
> +
> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan, int val, in=
t val2,
> +                           long mask)
> +{
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       unsigned int reg_val;
> +       bool span_comp_en;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               ret =3D iio_device_claim_direct_mode(indio_dev);
> +               if (ret < 0)
> +                       return ret;
> +
> +               mutex_lock(&st->lock);
> +               ret =3D ad4000_read_reg(st, &reg_val);
> +               if (ret < 0)
> +                       goto err_unlock;
> +
> +               span_comp_en =3D val2 =3D=3D st->scale_tbl[1][1];
> +               reg_val &=3D ~AD4000_CFG_SPAN_COMP;
> +               reg_val |=3D FIELD_PREP(AD4000_CFG_SPAN_COMP, span_comp_e=
n);
> +
> +               ret =3D ad4000_write_reg(st, reg_val);
> +               if (ret < 0)
> +                       goto err_unlock;
> +
> +               st->span_comp =3D span_comp_en;
> +err_unlock:
> +               iio_device_release_direct_mode(indio_dev);
> +               mutex_unlock(&st->lock);
> +               return ret;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static irqreturn_t ad4000_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf =3D p;
> +       struct iio_dev *indio_dev =3D pf->indio_dev;
> +       struct ad4000_state *st =3D iio_priv(indio_dev);
> +       int ret;
> +
> +       ret =3D ad4000_convert_and_acquire(st);
> +       if (ret < 0)
> +               goto err_out;
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->time=
stamp);
> +
> +err_out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info ad4000_reg_access_info =3D {
> +       .read_raw =3D &ad4000_read_raw,
> +       .read_avail =3D &ad4000_read_avail,
> +       .write_raw =3D &ad4000_write_raw,
> +       .write_raw_get_fmt =3D &ad4000_write_raw_get_fmt,
> +};
> +
> +static const struct iio_info ad4000_info =3D {
> +       .read_raw =3D &ad4000_read_raw,
> +};
> +
> +static int ad4000_config(struct ad4000_state *st)
> +{
> +       unsigned int reg_val =3D AD4000_CONFIG_REG_DEFAULT;
> +
> +       if (device_property_present(&st->spi->dev, "adi,high-z-input"))
> +               reg_val |=3D FIELD_PREP(AD4000_CFG_HIGHZ, 1);
> +
> +       return ad4000_write_reg(st, reg_val);
> +}
> +
> +static int ad4000_probe(struct spi_device *spi)
> +{
> +       const struct ad4000_chip_info *chip;
> +       struct device *dev =3D &spi->dev;
> +       struct iio_dev *indio_dev;
> +       struct ad4000_state *st;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       chip =3D spi_get_device_match_data(spi);
> +       if (!chip)
> +               return -EINVAL;
> +
> +       st =3D iio_priv(indio_dev);
> +       st->spi =3D spi;
> +
> +       ret =3D devm_regulator_get_enable(dev, "vdd");
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable VDD supp=
ly\n");
> +
> +       ret =3D devm_regulator_get_enable(dev, "vio");
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to enable VIO supp=
ly\n");
> +
> +       ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret,
> +                                    "Failed to get ref regulator referen=
ce\n");
> +       st->vref_mv =3D ret / 1000;
> +
> +       st->cnv_gpio =3D devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_HI=
GH);
> +       if (IS_ERR(st->cnv_gpio))
> +               return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
> +                                    "Failed to get CNV GPIO");
> +
> +       ret =3D device_property_match_property_string(dev, "adi,sdi-pin",
> +                                                   ad4000_sdi_pin,
> +                                                   ARRAY_SIZE(ad4000_sdi=
_pin));
> +       if (ret < 0 && ret !=3D -EINVAL)
> +               return dev_err_probe(dev, ret,
> +                                    "getting adi,sdi-pin property failed=
\n");
> +
> +       /* Default to usual SPI connections if pin properties are not pre=
sent */
> +       st->sdi_pin =3D ret =3D=3D -EINVAL ? AD4000_SDI_MOSI : ret;
> +       switch (st->sdi_pin) {
> +       case AD4000_SDI_MOSI:
> +               indio_dev->info =3D &ad4000_reg_access_info;
> +               indio_dev->channels =3D &chip->reg_access_chan_spec;
> +
> +               /*
> +                * In "3-wire mode", the ADC SDI line must be kept high w=
hen
> +                * data is not being clocked out of the controller.
> +                * Request the SPI controller to make MOSI idle high.
> +                */
> +               spi->mode |=3D SPI_MOSI_IDLE_HIGH;
> +               ret =3D spi_setup(spi);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D ad4000_prepare_3wire_mode_message(st, indio_dev->=
channels);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D ad4000_config(st);
> +               if (ret < 0)
> +                       dev_warn(dev, "Failed to config device\n");
> +
> +               break;
> +       case AD4000_SDI_VIO:
> +               indio_dev->info =3D &ad4000_info;
> +               indio_dev->channels =3D &chip->chan_spec;
> +               ret =3D ad4000_prepare_3wire_mode_message(st, indio_dev->=
channels);
> +               if (ret)
> +                       return ret;
> +
> +               break;
> +       case AD4000_SDI_CS:
> +               indio_dev->info =3D &ad4000_info;
> +               indio_dev->channels =3D &chip->chan_spec;
> +               ret =3D ad4000_prepare_4wire_mode_message(st, indio_dev->=
channels);
> +               if (ret)
> +                       return ret;
> +
> +               break;
> +       default:
> +               return dev_err_probe(dev, -EINVAL, "Unrecognized connecti=
on mode\n");
> +       }
> +
> +       indio_dev->name =3D chip->dev_name;
> +       indio_dev->num_channels =3D 1;
> +
> +       devm_mutex_init(dev, &st->lock);
> +
> +       st->gain_milli =3D 1000;
> +       if (chip->has_hardware_gain) {
> +               if (device_property_present(dev, "adi,gain-milli")) {

Only if there is another version, it may be neat to reduce indentation
here (a bit).
Something like:
        if (chip->has_hardware_gain &&
            device_property_present(dev, "adi,gain-milli")) {

        }

> +                       ret =3D device_property_read_u16(dev, "adi,gain-m=
illi",
> +                                                      &st->gain_milli);
> +                       if (ret)
> +                               return dev_err_probe(dev, ret,
> +                                                    "Failed to read gain=
 property\n");
> +               }
> +       }
> +
> +       ad4000_fill_scale_tbl(st, indio_dev->channels);
> +
> +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &ad4000_trigger_handler, NU=
LL);
> +       if (ret)
> +               return ret;
> +
> +       return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad4000_id[] =3D {
> +       { "ad4000", (kernel_ulong_t)&ad4000_chip_info },
> +       { "ad4001", (kernel_ulong_t)&ad4001_chip_info },
> +       { "ad4002", (kernel_ulong_t)&ad4002_chip_info },
> +       { "ad4003", (kernel_ulong_t)&ad4003_chip_info },
> +       { "ad4004", (kernel_ulong_t)&ad4004_chip_info },
> +       { "ad4005", (kernel_ulong_t)&ad4005_chip_info },
> +       { "ad4006", (kernel_ulong_t)&ad4006_chip_info },
> +       { "ad4007", (kernel_ulong_t)&ad4007_chip_info },
> +       { "ad4008", (kernel_ulong_t)&ad4008_chip_info },
> +       { "ad4010", (kernel_ulong_t)&ad4010_chip_info },
> +       { "ad4011", (kernel_ulong_t)&ad4011_chip_info },
> +       { "ad4020", (kernel_ulong_t)&ad4020_chip_info },
> +       { "ad4021", (kernel_ulong_t)&ad4021_chip_info },
> +       { "ad4022", (kernel_ulong_t)&ad4022_chip_info },
> +       { "adaq4001", (kernel_ulong_t)&adaq4001_chip_info },
> +       { "adaq4003", (kernel_ulong_t)&adaq4003_chip_info },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4000_id);
> +
> +static const struct of_device_id ad4000_of_match[] =3D {
> +       { .compatible =3D "adi,ad4000", .data =3D &ad4000_chip_info },
> +       { .compatible =3D "adi,ad4001", .data =3D &ad4001_chip_info },
> +       { .compatible =3D "adi,ad4002", .data =3D &ad4002_chip_info },
> +       { .compatible =3D "adi,ad4003", .data =3D &ad4003_chip_info },
> +       { .compatible =3D "adi,ad4004", .data =3D &ad4004_chip_info },
> +       { .compatible =3D "adi,ad4005", .data =3D &ad4005_chip_info },
> +       { .compatible =3D "adi,ad4006", .data =3D &ad4006_chip_info },
> +       { .compatible =3D "adi,ad4007", .data =3D &ad4007_chip_info },
> +       { .compatible =3D "adi,ad4008", .data =3D &ad4008_chip_info },
> +       { .compatible =3D "adi,ad4010", .data =3D &ad4010_chip_info },
> +       { .compatible =3D "adi,ad4011", .data =3D &ad4011_chip_info },
> +       { .compatible =3D "adi,ad4020", .data =3D &ad4020_chip_info },
> +       { .compatible =3D "adi,ad4021", .data =3D &ad4021_chip_info },
> +       { .compatible =3D "adi,ad4022", .data =3D &ad4022_chip_info },
> +       { .compatible =3D "adi,adaq4001", .data =3D &adaq4001_chip_info }=
,
> +       { .compatible =3D "adi,adaq4003", .data =3D &adaq4003_chip_info }=
,
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, ad4000_of_match);
> +
> +static struct spi_driver ad4000_driver =3D {
> +       .driver =3D {
> +               .name   =3D "ad4000",
> +               .of_match_table =3D ad4000_of_match,
> +       },
> +       .probe          =3D ad4000_probe,
> +       .id_table       =3D ad4000_id,
> +};
> +module_spi_driver(ad4000_driver);
> +
> +MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>
>

