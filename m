Return-Path: <linux-iio+bounces-24356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4AB9357C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BE3176A9A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61672857D8;
	Mon, 22 Sep 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifGZveNz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55632FD1D3
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575401; cv=none; b=Qix9WleA671rG1DJMYplxOpYkiGQbll9KqEoh4nutbVGg2PeQEr/7USNqskJGTEZhZzJjGsjSntOGaR2yE7iU4RVya+VJB/u1Esp0q7aiO8uMlg7pbcUNKNSkrQO1qkwQaoTVumzSGu76p4jDcAJDA32eE4r6XN1WOAozabfyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575401; c=relaxed/simple;
	bh=0zEkXPmthcOYy+k20HASdyS055JrPTn0l0RoEyNXNUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khT5EnbzWo6R6fJgd7PfXftpPXsf+QiCbqLF020HqzLoV+j674Vn1sjYQCnKswQv6PqkGKZSQ1h7YYbHhsRvNWggEDSptiBt50ueTZpkpWsjfU/0OlkjNcnwrdv7eILLY0m2M6S70LVPg20wo56u48LDeVw5rK70nJ6GgAO6/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifGZveNz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ece1102998so3062712f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758575397; x=1759180197; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+8dRG/LLSczlrcz2sI01JOamdKjotUDi9xFwucy4h8=;
        b=ifGZveNzvXi3lWE3FDHguchqbnOqucBmtBjiJKy6cEYl6QMQLY3CsQPa7jHAxWTWNN
         CS3Rprop99o3LO5ejqSr580ccLmwZ0yAP6b8wKxJtckbSBVDHdlFg4RZWdwpb57f5pm+
         WHbaOkHW5Dcq99/VGC0mmttb2cgr5GJ716/8f5teRltFNdBTZfSSMnd3BnZgp/Ra95y4
         vOItQMlNz3xm4/mZ4Y+V1UKklQ6AchEIXvd522MGDDl3njLPTb62fBg1Ty4yH4PRMGWz
         eIuJ3ivjm8Rx7GfpJyFsVmhCja0FMwgRWrGaAL5NvOKV2mZiIAa/amJV+D8ch3894t1L
         lF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758575397; x=1759180197;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+8dRG/LLSczlrcz2sI01JOamdKjotUDi9xFwucy4h8=;
        b=jJ18SRi7U83j3kQAhIEKhYhdJxLIrNpMWWK4Wy2XcYou+yX8od52Lf0RQlQdy8OmwX
         FixjiaKvk3kDxKFzCo7AsJeti5Ks/LcxpiagEf5YDCcNy8S8SCFd7H8dMuiTRGX/xJtU
         lVNGZpzSwmZXh2L2RHk19PE40Dwe8fF2Jd56ZRHyt+BrLjaT287/u07U6MIpS7ZGJvW7
         6EH6K7ZcTD9UATD/69/rGQDkHO76LZxtSOwoe/ePll87C8PBLG477IRD6HQU/RV78cz4
         y5/dbEIOx29B1RoN0qeybZKHmP2xxrs4jH7/+Aq01D22ES80GSk9Wx80HVH3szQcMMs3
         fEoA==
X-Gm-Message-State: AOJu0YzHNrn6uRpOxEr1nlTkqADAhOusi96ngJMXOA6Fe2Jy8NSniJlv
	RsOeFFhwDysUyb0ilEBlyGvd941McKugFTaz2Fcx9dX55Qfa8brblygYWPX06A==
X-Gm-Gg: ASbGncvtJfvDSSeGtiTtYp3/ZBhjnj+x4YSBv+sTS8TyvIuCwnPtq1+UrT6MSk9PSDm
	hNJnHE7EVfFs1e3y2ml5he0uNXzAtWJBPB2/xs9cRCML3K9wlNwlZOiqiNVm2v3loZWd7pzQ5c9
	9fnvNk/6I8jYPS4q826WwHXdb5etmei0lcfFZeHS3+8W/QTergaar7Ohv5z5k8nrhxwwSzjM7YY
	ojcHNmf5ihF2FDQq31hPpvzoffO4VxOvw/pw3Vscku+R0zFmNi1hUdv/Cuk5GLIt4qrEDYe3Gam
	+E41Os8/VDAkHVHm9UCCvSjc/ABsUEqEYz0IvG/LcDRskbgFocUXhoKHE8DyghuoCpEprXNRuo6
	NQqO6KE0FR5jTylz9UtlaIPhFd+VR3Hn/6T3HfdDCNEJDJiqKEpObVGnUQTeT84bcL1wjmHvCH9
	DevWvY3Gs=
X-Google-Smtp-Source: AGHT+IHlGjULAy1MK1DXmJEiIQnyeR/Nrx17wURiAECIMFQ/nl14w7JOfaBIA0Hd9mq5VLxN76huVA==
X-Received: by 2002:a05:6000:40c8:b0:3eb:4e88:55e with SMTP id ffacd0b85a97d-405ca95a0abmr101779f8f.41.1758575396565;
        Mon, 22 Sep 2025 14:09:56 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407ccasm21282645f8f.15.2025.09.22.14.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 14:09:56 -0700 (PDT)
Message-ID: <859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 21:10:47 +0100
In-Reply-To: <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
	 <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ariana,

Thanks for your patches. Some initial comments from me...

On Mon, 2025-09-22 at 14:30 +0300, Ariana Lazar wrote:
> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0=
/1/2)2,
> MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage =
output
> Digital-to-Analog Converters with nonvolatile or volatile memory and an I=
2C
> Interface.
>=20
> The families support up to 8 output channels.
>=20
> The devices can be 8-bit, 10-bit and 12-bit.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 16 +
> =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0 1 +
> =C2=A0drivers/iio/dac/mcp47feb02.c | 1347 +++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 1365 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index
> 6f51890cfc3081bc49c08fddc8af526c1ecc8d72..0f97f90ac2f492895d27da86d831df8=
3cb402516
> 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14943,6 +14943,7 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
> =C2=A0L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.y=
aml
> +F:	drivers/iio/dac/mcp47feb02.c
> =C2=A0
> =C2=A0MCP4821 DAC DRIVER
> =C2=A0M:	Anshul Dalal <anshulusr@gmail.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index
> e0996dc014a3d538ab6b4e0d50ff54ede50f1527..179ce565036e3494e4ce43bb926de31=
f38b547c4
> 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -509,6 +509,22 @@ config MCP4728
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le
> =C2=A0	=C2=A0 will be called mcp4728.
> =C2=A0
> +config MCP47FEB02
> +	tristate "MCP47F(E/V)B|(0/1/2)(1/2/4/8)DAC driver"
> +	depends on I2C
> +	help
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes here if y=
ou want to build a driver for the Microchip
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCP47FEB01, MCP47=
FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCP47FEB22, MCP47=
FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCP47FVB12, MCP47=
FVB02, MCP47FVB12, MCP47FVB22, MCP47FVB04,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCP47FVB14, MCP47=
FVB24, MCP47FVB04, MCP47FVB08, MCP47FVB18,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCP47FVB28, MCP47=
FEB04, MCP47FEB14 and MCP47FEB24 having up to 8
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 channels, 8-bit, =
10-bit or 12-bit digital-to-analog converter (DAC)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with I2C interfac=
e.
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To compile this d=
river as a module, choose M here: the module
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will be called mc=
p47feb02.
> +
> =C2=A0config MCP4821
> =C2=A0	tristate "MCP4801/02/11/12/21/22 DAC driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index
> 3684cd52b7fa9bc0ad9f855323dcbb2e4965c404..d633a6440fc4b9aba7d8b1c209b6dcd=
05cd982dd
> 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_MAX5522) +=3D max5522.o
> =C2=A0obj-$(CONFIG_MAX5821) +=3D max5821.o
> =C2=A0obj-$(CONFIG_MCP4725) +=3D mcp4725.o
> =C2=A0obj-$(CONFIG_MCP4728) +=3D mcp4728.o
> +obj-$(CONFIG_MCP47FEB02) +=3D mcp47feb02.o
> =C2=A0obj-$(CONFIG_MCP4821) +=3D mcp4821.o
> =C2=A0obj-$(CONFIG_MCP4922) +=3D mcp4922.o
> =C2=A0obj-$(CONFIG_STM32_DAC_CORE) +=3D stm32-dac-core.o
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> new file mode 100644
> index
> 0000000000000000000000000000000000000000..c9c2ded78d9c6013e5618e6342ebc8f=
50e79a31e
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -0,0 +1,1347 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + * Datasheet for MCP47FEBXX can be found here:
> + *
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDoc=
uments/DataSheets/20005375A.pdf
> + *
> + * Datasheet for MCP47FVBXX can be found here:
> + *
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDoc=
uments/DataSheets/20005405A.pdf
> + *
> + * Datasheet for MCP47FXBX4/8 can be found here:
> + *
> https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDo=
cuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
> + */
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
>=20

...

> +
> +static int mcp47feb02_write_to_register(struct regmap *regmap, unsigned =
int reg,
> +					int channel, int tmp_val)
> +{
> +	int ret, val;
> +
> +	ret =3D regmap_read(regmap, CMD_FORMAT(reg, READ_CMD), &val);
> +	if (ret)
> +		return ret;
> +
> +	if (reg =3D=3D MCP47FEB02_GAIN_STATUS_REG_ADDR) {
> +		switch (channel) {
> +		case 0:
> +			FIELD_MODIFY(G_0, &val, tmp_val);
> +			break;
> +		case 1:
> +			FIELD_MODIFY(G_1, &val, tmp_val);
> +			break;
> +		case 2:
> +			FIELD_MODIFY(G_2, &val, tmp_val);
> +			break;
> +		case 3:
> +			FIELD_MODIFY(G_3, &val, tmp_val);
> +			break;
> +		case 4:
> +			FIELD_MODIFY(G_4, &val, tmp_val);
> +			break;
> +		case 5:
> +			FIELD_MODIFY(G_5, &val, tmp_val);
> +			break;
> +		case 6:
> +			FIELD_MODIFY(G_6, &val, tmp_val);
> +			break;
> +		case 7:
> +			FIELD_MODIFY(G_7, &val, tmp_val);
> +			break;
> +		default:
> +			FIELD_MODIFY(G_0, &val, tmp_val);
> +			break;
> +		}
> +	} else {
> +		switch (channel) {
> +		case 0:
> +			FIELD_MODIFY(CH_0, &val, tmp_val);
> +			break;
> +		case 1:
> +			FIELD_MODIFY(CH_1, &val, tmp_val);
> +			break;
> +		case 2:
> +			FIELD_MODIFY(CH_2, &val, tmp_val);
> +			break;
> +		case 3:
> +			FIELD_MODIFY(CH_3, &val, tmp_val);
> +			break;
> +		case 4:
> +			FIELD_MODIFY(CH_4, &val, tmp_val);
> +			break;
> +		case 5:
> +			FIELD_MODIFY(CH_5, &val, tmp_val);
> +			break;
> +		case 6:
> +			FIELD_MODIFY(CH_6, &val, tmp_val);
> +			break;
> +		case 7:
> +			FIELD_MODIFY(CH_7, &val, tmp_val);
> +			break;
> +		default:
> +			FIELD_MODIFY(CH_0, &val, tmp_val);
> +			break;
> +		}
> +	}
> +
> +	ret =3D regmap_write(regmap, CMD_FORMAT(reg, WRITE_CMD), val);

Looking at the above, this looks like a creative way of doing regmap_update=
_bits()?
Am I missing something?

> +
> +	return ret;

return regmap_write()

> +}
> +
> +static int mcp47feb02_write_to_eeprom(struct regmap *regmap, unsigned in=
t reg,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> +{
> +	int eewa_val, ret;
> +
> +	/*
> +	 * wait till the currently occurring EEPROM Write Cycle is completed.
> +	 * Only serial commands to the volatile memory are allowed.
> +	 */
> +	ret =3D regmap_read_poll_timeout(regmap,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CMD_FORMAT(MCP47FEB02_GAIN_STAT=
US_REG_ADDR,
> READ_CMD),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eewa_val, !(eewa_val &
> MCP47FEB02_GAIN_STATUS_EEWA_MASK),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MCP47FEB02_DELAY_1_MS,
> MCP47FEB02_DELAY_1_MS * 5);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(regmap, CMD_FORMAT(reg, WRITE_CMD), val);
> +
> +	return ret;
> +}
> +
> +static ssize_t mcp47feb02_store_eeprom(struct device *dev, struct device=
_attribute
> *attr,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(dev_to_iio_dev(dev));
> +	int ret, i, val, val1;
> +	bool state;
> +
> +	ret =3D kstrtobool(buf, &state);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!state)
> +		return 0;
> +
> +	if (!data->have_eeprom) {
> +		dev_err(dev, "Device has no eeprom memory.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Verify DAC Wiper and DAC Configuratioin are unlocked. If both are
> disabled,
> +	 * writing to EEPROM is available.
> +	 */
> +	ret =3D regmap_read(data->regmap,
> CMD_FORMAT(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, READ_CMD),
> +			=C2=A0 &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val)=C2=A0 {
> +		dev_err(dev, "DAC Wiper and DAC Configuration not are
> unlocked.\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		ret =3D mcp47feb02_write_to_eeprom(data->regmap,
> MCP47FEB02_NV_DAC0_REG_ADDR + i,
> +						 data->chdata[i].dac_data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_VREF_REG_ADDR,
> READ_CMD), &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp47feb02_write_to_eeprom(data->regmap,
> MCP47FEB02_NV_VREF_REG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_POWER_DOWN_REG_=
ADDR,
> READ_CMD), &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp47feb02_write_to_eeprom(data->regmap,
> MCP47FEB02_NV_POWER_DOWN_REG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap,
> +			=C2=A0 CMD_FORMAT(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR,
> READ_CMD), &val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap,
> +			=C2=A0 CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
> &val1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mcp47feb02_write_to_eeprom(data->regmap,
> MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR,
> +					 (val1 & MCP47FEB02_VOLATILE_GAIN_MASK) |
> +					=C2=A0 (val &
> MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK));
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom=
, 0);
> +static struct attribute *mcp47feb02_attributes[] =3D {
> +	&iio_dev_attr_store_eeprom.dev_attr.attr,
> +	NULL,
> +};
> +

Not going to argue about the ABI for now but I don't think this is a standa=
rd one? So
if acceptable you need an ABI doc.

> +static int mcp47feb02_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int ret, ch;
> +
> +	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) =
{
> +		data->chdata[ch].powerdown =3D true;
> +		ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_POWER_DOWN_REG_ADDR,
> +						=C2=A0=C2=A0 ch, data-
> >chdata[ch].powerdown_mode + 1);
> +		if (ret)
> +			return ret;

So looking at this, can we actually powerdown channels individually?

> +
> +		ret =3D regmap_write(data->regmap, CMD_FORMAT(ch, WRITE_CMD),
> +				=C2=A0=C2=A0 data->chdata[ch].dac_data);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp47feb02_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int ch, ret;
> +
> +	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) =
{
> +		data->chdata[ch].powerdown =3D false;
> +
> +		ret =3D regmap_write(data->regmap, CMD_FORMAT(ch, WRITE_CMD),
> +				=C2=A0=C2=A0 data->chdata[ch].dac_data);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_VREF_REG_ADDR,
> +						=C2=A0=C2=A0 ch, data->chdata[ch].ref_mode);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_GAIN_STATUS_REG_ADDR,
> +						=C2=A0=C2=A0 ch, data-
> >chdata[ch].use_2x_gain);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_POWER_DOWN_REG_ADDR,
> +						=C2=A0=C2=A0 ch,
> MCP47FEB02_NORMAL_OPERATION);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend,
> mcp47feb02_resume);
> +
> +static const struct attribute_group mcp47feb02_attribute_group =3D {
> +	.attrs =3D mcp47feb02_attributes,
> +};
> +
> +static const char * const mcp47feb02_powerdown_modes[] =3D {
> +	"1kohm_to_gnd",
> +	"100kohm_to_gnd",
> +	"open_circuit",
> +};
> +
> +static int mcp47feb02_get_powerdown_mode(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int bit_set;
> +
> +	bit_set =3D test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set)

not seeing the need for bit_set.

> +		return data->chdata[chan->address].powerdown_mode;
> +
> +	return -EINVAL;
> +}
> +
> +static int mcp47feb02_set_powerdown_mode(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> unsigned int mode)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +	int bit_set, ret;
> +
> +	bit_set =3D test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set) {

same

> +		ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_POWER_DOWN_REG_ADDR,
> +						=C2=A0=C2=A0 chan->address, mode + 1);
> +		if (ret)
> +			return ret;
> +
> +		data->chdata[chan->address].powerdown_mode =3D mode;
> +
> +		return 0;
> +	}
> +
> +	dev_err(dev, "Channel %ld not enabled\n", chan->address);
> +	return -EINVAL;
> +}
> +
> +static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uint=
ptr_t
> private,
> +					 const struct iio_chan_spec *chan, char
> *buf)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int bit_set;
> +
> +	bit_set =3D test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set)
> +		return sysfs_emit(buf, "%d\n", data->chdata[chan-
> >address].powerdown);
> +
> +	dev_err(&data->client->dev, "Channel %ld not enabled\n", chan->address)=
;
> +	return -EINVAL;
> +}
> +
> +static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uin=
tptr_t
> private,
> +					=C2=A0 const struct iio_chan_spec *chan, const
> char *buf,
> +					=C2=A0 size_t len)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +	int bit_set, ret;
> +	bool state;
> +
> +	ret =3D kstrtobool(buf, &state);
> +	if (ret)
> +		return ret;
> +
> +	bit_set =3D test_bit(chan->address, &data->active_channels_mask);
> +	if (bit_set)
> +		data->chdata[chan->address].powerdown =3D state;
> +	else
> +		dev_err(dev, "Channel %ld not enabled\n", chan->address);

I might be missing something but I'm puzzled. So powering down is just sett=
ing a
variable? I would expect some register read.

> +
> +	return len;
> +}
> +
> +static const struct iio_enum mcp47febxx_powerdown_mode_enum =3D {
> +	.items =3D mcp47feb02_powerdown_modes,
> +	.num_items =3D ARRAY_SIZE(mcp47feb02_powerdown_modes),
> +	.get =3D mcp47feb02_get_powerdown_mode,
> +	.set =3D mcp47feb02_set_powerdown_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info mcp47feb02_ext_info[] =3D {
> +	{
> +		.name =3D "powerdown",
> +		.read =3D mcp47feb02_read_powerdown,
> +		.write =3D mcp47feb02_write_powerdown,
> +		.shared =3D IIO_SEPARATE,
> +	},
> +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp47febxx_powerdown_mode_enu=
m),
> +	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
> &mcp47febxx_powerdown_mode_enum),
> +	{ },
> +};
> +
> +static const struct iio_chan_spec mcp47febxx_ch_template =3D {
> +	.type =3D IIO_VOLTAGE,
> +	.output =3D 1,
> +	.indexed =3D 1,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)	|
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE),
> +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),
> +	.ext_info =3D mcp47feb02_ext_info,
> +};
> +
> +static void mcp47feb02_init_scale(const struct mcp47feb02_features *info=
,
> +				=C2=A0 enum mcp47feb02_scale scale, int vref_mv,
> +				=C2=A0 int scale_avail[])
> +{
> +	int value_micro, value_int;
> +	s64 tmp;
> +
> +	tmp =3D (s64)vref_mv * 1000000LL >> info->resolution;
> +	value_int =3D div_s64_rem(tmp, 1000000LL, &value_micro);
> +	scale_avail[scale * 2] =3D value_int;
> +	scale_avail[scale * 2 + 1] =3D value_micro;
> +}
> +
> +static int mcp47feb02_init_scales_avail(const struct mcp47feb02_features=
 *info,
> +					struct mcp47feb02_data *data, int vdd_mv,
> int vref_mv,
> +					int vref1_mv)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	int tmp_vref;
> +
> +	if (data->use_vref && vref_mv <=3D 0) {
> +		dev_err(dev, "use_vref set but vref_mv invalid\n");
> +		return -EINVAL;

dev_err_probe()?

> +	}
> +
> +	mcp47feb02_init_scale(info, MCP47FEB02_SCALE_VDD, vdd_mv, data->scale);
> +
> +	if (data->use_vref)
> +		tmp_vref =3D vref_mv;
> +	else
> +		tmp_vref =3D MCP47FEB02_INTERNAL_BAND_GAP_MV;
> +
> +	mcp47feb02_init_scale(info, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data-
> >scale);
> +	mcp47feb02_init_scale(info, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, dat=
a-
> >scale);
> +
> +	if (data->phys_channels >=3D 4) {
> +		mcp47feb02_init_scale(info, MCP47FEB02_SCALE_VDD, vdd_mv, data-
> >scale_1);
> +
> +		if (data->use_vref1 && vref1_mv <=3D 0) {
> +			dev_err(dev, "use_vref1 set but vref1_mv invalid\n");
> +			return -EINVAL;

same

...

> +
> +static int mcp47feb02_set_scale(struct mcp47feb02_data *data, int channe=
l, int
> scale)
> +{
> +	int tmp_val, ret;
> +
> +	mcp47feb02_ch_scale(data->phys_channels, data, channel, scale);
> +
> +	if (scale =3D=3D MCP47FEB02_SCALE_GAIN_X2)
> +		tmp_val =3D MCP47FEB02_GAIN_X2;
> +	else
> +		tmp_val =3D MCP47FEB02_GAIN_X1;
> +
> +	ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_GAIN_STATUS_REG_ADDR,
> +					=C2=A0=C2=A0 channel, tmp_val);
> +	if (ret)
> +		return ret;
> +
> +	data->chdata[channel].use_2x_gain =3D tmp_val;
>=20

Also looks like it could use a lock.

> +	return 0;
> +}
> +
> +static int mcp47feb02_read_raw(struct iio_dev *indio_dev, struct iio_cha=
n_spec
> const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D regmap_read(data->regmap, CMD_FORMAT(chan->address,
> READ_CMD), val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		mcp47feb02_get_scale(chan->address, data, val, val2);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_ch=
an_spec
> const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D regmap_write(data->regmap, CMD_FORMAT(chan->address,
> WRITE_CMD), val);
> +		data->chdata[chan->address].dac_data =3D val;

You should only save the value in case regmap_write() succeeds. And given t=
hat you're
doing that you should use a mutx.

> +		return ret;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (data->phys_channels >=3D 4 && (chan->address % 2))
> +			ret =3D mcp47feb02_check_scale(data, val, val2, data-
> >scale_1);
> +		else
> +			ret =3D mcp47feb02_check_scale(data, val, val2, data-
> >scale);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		return mcp47feb02_set_scale(data, chan->address, ret);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info mcp47feb02_info =3D {
> +	.read_raw =3D mcp47feb02_read_raw,
> +	.write_raw =3D mcp47feb02_write_raw,
> +	.read_avail =3D &mcp47feb02_read_avail,
> +	.attrs =3D &mcp47feb02_attribute_group,
> +};
> +
> +static const struct iio_info mcp47fvb02_info =3D {
> +	.read_raw =3D mcp47feb02_read_raw,
> +	.write_raw =3D mcp47feb02_write_raw,
> +	.read_avail =3D &mcp47feb02_read_avail,
> +	.attrs =3D &mcp47feb02_attribute_group,
> +};
> +
> +static int mcp47feb02_parse_fw(struct iio_dev *indio_dev, const struct
> mcp47feb02_features *info)
> +{
> +	struct iio_chan_spec chanspec =3D mcp47febxx_ch_template;
> +	struct mcp47feb02_data *data =3D iio_priv(indio_dev);
> +	struct device *dev =3D &data->client->dev;
> +	struct iio_chan_spec *channels;
> +	u32 reg, num_channels;
> +	int chan_idx =3D 0;
> +
> +	num_channels =3D device_get_child_node_count(dev);
> +	if (num_channels > info->phys_channels)
> +		return dev_err_probe(dev, -EINVAL, "More channels than the chip
> supports\n");
> +

Are 0 channels acceptable? devm_kcalloc() wont't give you a NULL ptr and yo=
u might
get subtle issues.

> +	channels =3D devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KER=
NEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		fwnode_property_read_u32(child, "reg", &reg);
> +

reg is a mandatory property so you need to check for errors. If the propert=
y is not
given, fwnode_property_read_u32() won't touch in reg so you have a random n=
umber in
the next condition.

> +		if (reg >=3D info->phys_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "The index of the channels does not
> match the chip\n");
> +
> +		set_bit(reg, &data->active_channels_mask);
> +
> +		if (fwnode_property_present(child, "label"))
> +			fwnode_property_read_string(child, "label",
> +						=C2=A0=C2=A0=C2=A0 (const char **)&data-
> >labels[reg]);
> +
> +		chanspec.address =3D reg;
> +		chanspec.channel =3D reg;
> +		channels[chan_idx] =3D chanspec;
> +		chan_idx++;
> +	}
> +
> +	indio_dev->num_channels =3D num_channels;
> +	indio_dev->channels =3D channels;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	data->phys_channels =3D info->phys_channels;
> +
> +	/*
> +	 * check if vref-supply, vref1-supply, microchip,vref-buffered and
> +	 * microchip,vref1-buffered are defined in the devicetree
> +	 */
> +	data->use_vref =3D device_property_present(dev, "vref-supply");
> +	data->use_vref1 =3D device_property_present(dev, "vref1-supply");
> +	data->vref_buffered =3D device_property_read_bool(dev, "microchip,vref-
> buffered");
> +	data->vref1_buffered =3D device_property_read_bool(dev, "microchip,vref=
1-
> buffered");
> +
> +	return 0;
> +}
> +
> +static int mcp47feb02_probe(struct i2c_client *client)
> +{
> +	int err, ret, vdd_mv, vref_mv, vref1_mv, i, tmp_vref, vref_ch, gain_ch;
> +	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
> +	const struct mcp47feb02_features *info;
> +	enum vref_mode ref_mode, ref_mode1;
> +	struct device *dev =3D &client->dev;
> +	struct mcp47feb02_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

You can drop the above. See my devm_ comment below.
> +	data->client =3D client;
> +	info =3D i2c_get_match_data(client);

for consistency, add some error handling.

> +
> +	if (info->have_eeprom) {
> +		data->regmap =3D devm_regmap_init_i2c(client,
> &mcp47feb02_regmap_config);
> +		data->have_eeprom =3D true;
> +	} else {
> +		data->regmap =3D devm_regmap_init_i2c(client,
> &mcp47fvb02_regmap_config);
> +		data->have_eeprom =3D false;
> +	}
> +
> +	if (IS_ERR(data->regmap))
> +		dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c
> regmap\n");
> +
> +	err =3D mcp47feb02_parse_fw(indio_dev, info);
> +	if (err)
> +		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
> +
> +	if (!info->have_ext_vref2 && data->use_vref1)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Second External reference is unavailable o=
n
> %s\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 info->name);
> +
> +	ret =3D regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_VREF_REG_ADDR,
> READ_CMD), &vref_ch);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(data->regmap,
> CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
> +			=C2=A0 &gain_ch);
> +	if (ret)
> +		return ret;
> +
> +	gain_ch =3D gain_ch >> 8;
> +
> +	/*
> +	 * Values stored in the nonvolatile memory will be transferred to the
> volatile registers
> +	 * at startup. For safety reasons, the user receives a warning if start=
up
> values
> +	 * do not match the ones from current devicetree configuration.
> +	 * Nonvolatile memory can be written at any time
> +	 */
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		/* VDD can be set as Vref only with Gain x1 */
> +		if ((vref_ch & 0x03) =3D=3D MCP47FEB02_VREF_VDD &&
> +		=C2=A0=C2=A0=C2=A0 (gain_ch & 0x01) =3D=3D MCP47FEB02_GAIN_X2) {

some defines with be nice for those magic bits.

> +			dev_info(dev, "vdd can be used only with gain x1\n");
dev_dbg()
> +			ret =3D mcp47feb02_write_to_register(data->regmap,
> +							=C2=A0=C2=A0
> MCP47FEB02_GAIN_STATUS_REG_ADDR,
> +							=C2=A0=C2=A0 i, MCP47FEB02_GAIN_X1);
> +			if (ret)
> +				return ret;
> +
> +			data->chdata[i].use_2x_gain =3D MCP47FEB02_GAIN_X1;
> +		}
> +
> +		if (data->phys_channels >=3D 4 && (i % 2)) {
> +			if ((vref_ch & 0x03) =3D=3D MCP47FEB02_EXTERNAL_VREF_BUFFERED
> &&
> +			=C2=A0=C2=A0=C2=A0 data->use_vref1 && !data->vref1_buffered)
> +				dev_info(dev, "vref1 is unbuffered\n");
> +			else if ((vref_ch & 0x03) =3D=3D
> MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
> +				 data->use_vref1 && data->vref1_buffered)
> +				dev_info(dev, "vref1 is buffered\n");
> +		} else {
> +			if ((vref_ch & 0x03) =3D=3D MCP47FEB02_EXTERNAL_VREF_BUFFERED
> &&
> +			=C2=A0=C2=A0=C2=A0 data->use_vref && !data->vref_buffered)
> +				dev_info(dev, "vref is unbuffered\n");
> +			else if ((vref_ch & 0x03) =3D=3D
> MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
> +				 data->use_vref && data->vref_buffered)
> +				dev_info(dev, "vref is buffered\n");
> +		}
> +
> +		vref_ch =3D vref_ch >> 2;
> +		gain_ch =3D gain_ch >> 1;
> +	}
> +
> +	if (data->use_vref)
> +		ref_mode =3D data->vref_buffered ?
> +			MCP47FEB02_EXTERNAL_VREF_BUFFERED :
> MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
> +	else
> +		ref_mode =3D MCP47FEB02_INTERNAL_BAND_GAP;
> +
> +	if (data->use_vref1)
> +		ref_mode1 =3D data->vref1_buffered ?
> +			MCP47FEB02_EXTERNAL_VREF_BUFFERED :
> MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
> +
> +	else
> +		ref_mode1 =3D=C2=A0 MCP47FEB02_INTERNAL_BAND_GAP;
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		if (data->phys_channels >=3D 4 && (i % 2))
> +			tmp_vref =3D ref_mode1;
> +		else
> +			tmp_vref =3D ref_mode;
> +
> +		ret =3D mcp47feb02_write_to_register(data->regmap,
> MCP47FEB02_VREF_REG_ADDR,
> +						=C2=A0=C2=A0 i, tmp_vref);
> +		if (ret)
> +			return ret;
> +
> +		data->chdata[i].ref_mode =3D tmp_vref;
> +	}

Maybe have the above in a setup function?

> +
> +	indio_dev->name =3D id->name;
> +	if (info->have_eeprom)
> +		indio_dev->info =3D &mcp47feb02_info;
> +	else
> +		indio_dev->info =3D &mcp47fvb02_info;
> +
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return ret;
> +
> +	vdd_mv =3D ret / 1000;
> +
> +	if (data->use_vref) {
> +		ret =3D devm_regulator_get_enable_read_voltage(dev, "vref");
> +		if (ret < 0)
> +			return ret;
> +
> +		vref_mv =3D ret / 1000;
> +	}
> +
> +	if (data->use_vref1) {
> +		ret =3D devm_regulator_get_enable_read_voltage(dev, "vref1");
> +		if (ret < 0)
> +			return ret;
> +
> +		vref1_mv =3D ret / 1000;
> +	}
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		ret =3D mcp47feb02_init_scales_avail(info, data, vdd_mv, vref_mv,
> vref1_mv);
> +		if (ret)
> +			dev_err_probe(dev, ret, "failed to init scales for ch i
> %d\n", i);
> +	}

I guess the above loop could also be in a setup function.

> +
> +	err =3D iio_device_register(indio_dev);
> +

devm_iio_device_register(). With that you can drop mcp47feb02_remove()


- Nuno S=C3=A1


