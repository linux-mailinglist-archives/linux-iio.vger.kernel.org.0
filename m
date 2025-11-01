Return-Path: <linux-iio+bounces-25786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4066C28345
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC993AB718
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB9274B39;
	Sat,  1 Nov 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFtsFXR6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669202749E0
	for <linux-iio@vger.kernel.org>; Sat,  1 Nov 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015578; cv=none; b=eE57rvZ6dOpSYbMRq9jjqJ/IdsHNO5orN2m9WPE9JKkYvVl1I6r3ijG1YVzqnC0uywK4Sg6FGf6YfiOmvA8kZsHoUnFpbt8jZGpYSRSCnY/uWRKXNLZXn8o7vKy241YtP7kO0vNDibouz83/ksYAuZzoZwfa1OWQT0rl0fzOrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015578; c=relaxed/simple;
	bh=oQmG1ZGNlkZkVKUgXuS9ATTAEypYuVXy628ULCaWops=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtMEUQJZtZqgvm/dVgYDQAYYX9vJHDHGbcaC4M6vwxGpIsygQcBngmojeqgYH2JB8ZvIY/5bdv8MF+5u3tBPT+cyFNS7eg1SI/lowrYn8vIJY1KGpj8PvatgyMmobhUEKSikap9EQEwzCiZgstu4AsPSs0L5/OvyX0WoVGgAWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFtsFXR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2121DC4CEF1;
	Sat,  1 Nov 2025 16:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762015577;
	bh=oQmG1ZGNlkZkVKUgXuS9ATTAEypYuVXy628ULCaWops=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uFtsFXR6inXJdQO7S0l7WHGhN8QOzY3NPRci1QodlJtZd/0yZ/LEZqtWDty+mJEP3
	 D5UPIFXksV7TWg4uIjZ+Aj69WGzVV6/jWZ4Ax5QX+x4+V/HTHAtz3DXYVGB4oEjyVH
	 bTWgT6p5jn0m2pzk4g3ubj5lAMv/7J4pRvqW9BPuf8bVaPOtjq2mZJma8blaQgQ84k
	 sUH47SS25Zxc/2MmWpqZWD4+Gp8cFvfc2+QLApg1DJ/0usCnGOhKZZNl4KQtDWkMsy
	 m0vPwjKwW5eTqX+FV1vfNsP1cL2MIn5z68BOQzmwB4frFojEO8uGuKOYiCj0fJgFTj
	 IK2CVHxjb0hFw==
Date: Sat, 1 Nov 2025 16:46:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <20251101164612.449606c2@jic23-huawei>
In-Reply-To: <20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	<20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 12:31:27 +0000
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Properly separate the I2C and SPI drivers into two different drivers
> living in their own source file (as usual). So that no need for the
> hacky ifdefery.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

Looks good to me.  A few minor things inline.
In particular a question of which include is missing for the byteorder stuf=
f.
Maybe Andy can help with a suggestion on that?


> diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
> new file mode 100644
> index 000000000000..9d1054c3dd8e
> --- /dev/null
> +++ b/drivers/iio/dac/ad5446-i2c.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD5446 SPI I2C driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +
> +#include "ad5446.h"
> +
> +static int ad5622_write(struct ad5446_state *st, unsigned int val)
> +{
> +	struct i2c_client *client =3D to_i2c_client(st->dev);
> +	int ret;
> +
> +	st->d16 =3D cpu_to_be16(val);

Should have an include for this.  Probably

linux/byteorder/generic.h
though the kernel (and iio) has a random mix of that and
asm/byteorder.h

Hmm. linux/unaligned.h is using asm/byteorder.h so maybe that's the better =
choice



> +
> +	ret =3D i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d1=
6));
> +	if (ret < 0)
> +		return ret;
> +	if (ret !=3D sizeof(st->d16))
> +		return -EIO;
include for the error codes as well.
> +
> +	return 0;
> +}
> +
> +static int ad5446_i2c_probe(struct i2c_client *i2c)
> +{
> +	const struct i2c_device_id *id =3D i2c_client_get_device_id(i2c);
> +	const struct ad5446_chip_info *chip_info;
> +
> +	chip_info =3D i2c_get_match_data(i2c);
> +	if (!chip_info)
> +		return -ENODEV;
> +
> +	return ad5446_probe(&i2c->dev, id->name, chip_info);
> +}
> +
> +/*
> + * ad5446_supported_i2c_device_ids:
> + * The AD5620/40/60 parts are available in different fixed internal refe=
rence
> + * voltage options. The actual part numbers may look differently
> + * (and a bit cryptic), however this style is used to make clear which
> + * parts are supported here.
> + */
> +
> +static const struct ad5446_chip_info ad5602_chip_info =3D {
> +	.channel =3D AD5446_CHANNEL_POWERDOWN(8, 16, 4),
> +	.write =3D ad5622_write,
> +};
> +
> +static const struct ad5446_chip_info ad5612_chip_info =3D {
> +	.channel =3D AD5446_CHANNEL_POWERDOWN(10, 16, 2),
> +	.write =3D ad5622_write,
> +};
> +
> +static const struct ad5446_chip_info ad5622_chip_info =3D {
> +	.channel =3D AD5446_CHANNEL_POWERDOWN(12, 16, 0),
> +	.write =3D ad5622_write,
> +};
> +
> +static const struct i2c_device_id ad5446_i2c_ids[] =3D {
> +	{"ad5301", (kernel_ulong_t)&ad5602_chip_info},
> +	{"ad5311", (kernel_ulong_t)&ad5612_chip_info},
> +	{"ad5321", (kernel_ulong_t)&ad5622_chip_info},
> +	{"ad5602", (kernel_ulong_t)&ad5602_chip_info},
> +	{"ad5612", (kernel_ulong_t)&ad5612_chip_info},
> +	{"ad5622", (kernel_ulong_t)&ad5622_chip_info},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
> +
> +static const struct of_device_id ad5446_i2c_of_ids[] =3D {
> +	{ .compatible =3D "adi,ad5301", .data =3D &ad5602_chip_info },
> +	{ .compatible =3D "adi,ad5311", .data =3D &ad5612_chip_info },
> +	{ .compatible =3D "adi,ad5321", .data =3D &ad5622_chip_info },
> +	{ .compatible =3D "adi,ad5602", .data =3D &ad5602_chip_info },
> +	{ .compatible =3D "adi,ad5612", .data =3D &ad5612_chip_info },
> +	{ .compatible =3D "adi,ad5622", .data =3D &ad5622_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
> +
> +static struct i2c_driver ad5446_i2c_driver =3D {
> +	.driver =3D {
> +		.name	=3D "ad5446",
> +		.of_match_table =3D ad5446_i2c_of_ids,
> +	},
> +	.probe =3D ad5446_i2c_probe,
> +	.id_table =3D ad5446_i2c_ids,
> +};
> +module_i2c_driver(ad5446_i2c_driver);
> +
> +MODULE_AUTHOR("Nuno S=C3=A1 <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 I2C DACs");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_AD5446");
> diff --git a/drivers/iio/dac/ad5446-spi.c b/drivers/iio/dac/ad5446-spi.c
> new file mode 100644
> index 000000000000..7419b17a455f
> --- /dev/null
> +++ b/drivers/iio/dac/ad5446-spi.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD5446 SPI DAC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>

Similar comment on includes probably applies.

> +
> +#include "ad5446.h"
> +
>

>  MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 DAC");
> +MODULE_DESCRIPTION("Analog Devices CORE AD5444/AD5446 DAC");

Maybe a good time to tweak this description to say "AD5444 DAC and similar"

>  MODULE_LICENSE("GPL v2");


