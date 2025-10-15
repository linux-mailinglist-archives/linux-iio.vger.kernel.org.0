Return-Path: <linux-iio+bounces-25087-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68595BDDE8F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21B204FB8FD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6433E31BC82;
	Wed, 15 Oct 2025 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1AIA/kI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82831AF3C
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522785; cv=none; b=pI6sKms69PskSYJz7+ZElWTv5ekKyDn9dwskMPoXkIJWiF222lZCgu3koJS1bRJqbKz3zd3U8c3PqZnMMb1TLrav1VhZX0iw3BiYfE0CZpDxW3uFbcuFV0v/3GqgvTj4XNXEPeOM1TPEivacxf3wHQfO2U7JEO/VAu2HrpQE3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522785; c=relaxed/simple;
	bh=h9QAIiYBcYTwaPRJ3ulgxq/EMfWZ1M59+t8rd940DqQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sepCTwUcdqi/u5vJDWmLl/q2bzNxC0QNA31kMU9PynKXwf5xAYWEOWimMu60sAwZKUh2dJo/5zSK8meFZmOER3XI+lybk8DssIyrcGTzmubd3Y3pnxmeLrWwfISkS2rmL4dTIVjLzjhqyhoKKnh8hIRLnql1tgQbOaFzRwnRDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1AIA/kI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710022571cso3782205e9.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760522781; x=1761127581; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/JikAXSzFP+8HMT+G2vdPMmgBXFYz0AF+l9lS3J+JcA=;
        b=M1AIA/kIAhdfR/m8NlmK0uf40xKAqqWXaYydoH5oHgRHoOS+HvzPhiyd49aXkIJB+U
         rYsjwqSjBW2ye2TryKylm/t1wgtryNb25A09ItAlMJUbuvS1lIEEd/JdUAL9MJ6UdqRy
         MN07RkD2Wl8bn57jgT3TnQodn6v0615xpAY19x2U99NZ0jUJKyjt4IYjYMCyt4ZKLJsR
         r9PEqVB/BpAsHVnAXVK7phmrlROdLEdRCmNsc6e/XynBQlKcQTd+YJoaIgMQzG6Hnvf7
         ykZZ6o5syqPGylSlxb5hWr3i5ySYFRm/kZV/NEcch7QqjrzKaX8jrymLQ8D9SpcIuivq
         POAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760522781; x=1761127581;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/JikAXSzFP+8HMT+G2vdPMmgBXFYz0AF+l9lS3J+JcA=;
        b=YaYmxwUhtkP5J12RyEyhkx70DjUTUqYugRNi17yT1J173UNGM7j1NAjlMzzGAFmOgd
         rnFR7y1CEk72Pa5ec3oAXvrQkJxhVF11I1khC3izqykpjEnUGsivIn9/HOXg6cSV9V5R
         oyQ+sDciCDjdp3zsHWUTnbyvYdlQF9pFt5h/Uo8zQXLfM2GTuY4juz4KB2zTZVy40Rmy
         muPshw+Qz59IVoR0uFbxgDF8FTVoN8aCKg7jKtjyJ+wMHE2zZjEB2d/rgOXa6X79mGAv
         L0zJOJp6NJYD7pBQwUTxUuBSekEAnhuSan4bd8MzMfANplYVu8K7OF2zB0hXFmjMSvqT
         JrnA==
X-Forwarded-Encrypted: i=1; AJvYcCWBSVfMC9eKSIIpxLQp3PZzjmJK9XGzDUTuLEY2A709WgCN0i0XNbPa1U9X2ymiJt18biBdV1QdwVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVvaZQSAawk2RLnmBXavGi5cC4gDFv3zHjJEZekAIt0wIsbnts
	e2B6m2PlYI7xRzr77+IngafqbdKYnzJLBySQ42DeTejNaNScou5EjKeDewUUQg==
X-Gm-Gg: ASbGncucNxqYyowR6unbshIn+wSyX3Si/L73x6b5wdobK8DLu53BIpnMWLwYqPOtl8b
	qOTt6Fgo1706Qbn2+zV4lK4H/Lvqf0nPrt8QMAkB8H6o4bDyr4VeOf9qHSL8p5e6S79ds7f0a4h
	yDBlENQZHB9JZri45mAsPcPiGFjHZAMEfK43uLZ1ymqv0Z8It6bnEfYr+hIjcGbdJUB54TtZV29
	/bA1QNeRTdysVRpvv3ekBf3Vlg+xigkcwCwIEaNeW1enu5JIrUUHpDjaG8B6mORYa1KuxsUD6km
	VawzzXMlkIeKQjuqP1Dv8Zj0nsLN5w/R8O6WSj/ZKAGnGUUx38phnA6A9nBkPKRcWJ0tXwqmmTC
	vGR90PukYn7FnQI954uefaTrpu4F2ofXgwXq7ffyNpX/8RH5QuA==
X-Google-Smtp-Source: AGHT+IHgV6cBNKFg7lVaIxISMGZEhCnRq3f5FX2Mo/ZiPw8peOXBQ8nl2TpEvxlKSck3NJj+Cpjhig==
X-Received: by 2002:a05:600c:46d2:b0:46e:3686:a2dd with SMTP id 5b1f17b1804b1-46fbbc93abfmr104856245e9.11.1760522780872;
        Wed, 15 Oct 2025 03:06:20 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9absm333699055e9.2.2025.10.15.03.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:06:20 -0700 (PDT)
Message-ID: <d7a62beac6b9ea74ccc791b4491e24328e05fb52.camel@gmail.com>
Subject: Re: [PATCH 2/6] spi: Support multi-bus controllers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko	
 <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Wed, 15 Oct 2025 11:06:53 +0100
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-2-2098c12d6f5f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> Add support for SPI controllers with multiple physical SPI data buses.
> (A data bus in this context means lines connected to a serializer, so a
> controller with two data buses would have two serializers in a single
> controller).
>=20
> This is common in the type of controller that can be used with parallel
> flash memories, but can be used for general purpose SPI as well.
>=20
> To indicate support, a controller just needs to set ctlr->num_data_bus
> to something greater than 1. Peripherals indicate which bus they are
> connected to via device tree (ACPI support can be added if needed).
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM,

Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>

>=20
> This patch has been seen in a different series [1] by Sean before:
>=20
> [1]:
> https://lore.kernel.org/linux-spi/20250616220054.3968946-4-sean.anderson@=
linux.dev/
>=20
> Changes:
> * Use u8 array instead of bitfield so that the order of the mapping is
> =C2=A0 preserved. (Now looks very much like chip select mapping.)
> * Added doc strings for added fields.
> * Tweaked the comments.
> ---
> =C2=A0drivers/spi/spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 ++++++++=
+++++++++++++++++++-
> =C2=A0include/linux/spi/spi.h | 17 +++++++++++++++++
> =C2=A02 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index
> 2e0647a06890290e1c9dc4a347a0864329795b08..84e5d5057eb41f1a522c4870265d78f=
eb411
> 09c8 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2354,7 +2354,7 @@ static void of_spi_parse_dt_cs_delay(struct device_=
node
> *nc,
> =C2=A0static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_=
device
> *spi,
> =C2=A0			=C2=A0=C2=A0 struct device_node *nc)
> =C2=A0{
> -	u32 value, cs[SPI_DEVICE_CS_CNT_MAX];
> +	u32 value, buses[SPI_DEVICE_DATA_BUS_CNT_MAX],
> cs[SPI_DEVICE_CS_CNT_MAX];
> =C2=A0	int rc, idx;
> =C2=A0
> =C2=A0	/* Mode (clock phase/polarity/etc.) */
> @@ -2446,6 +2446,31 @@ static int of_spi_parse_dt(struct spi_controller *=
ctlr,
> struct spi_device *spi,
> =C2=A0	for (idx =3D 0; idx < rc; idx++)
> =C2=A0		spi_set_chipselect(spi, idx, cs[idx]);
> =C2=A0
> +	rc =3D of_property_read_variable_u32_array(nc, "spi-buses", buses, 1,
> +						 ARRAY_SIZE(buses));
> +	if (rc < 0 && rc !=3D -EINVAL) {
> +		dev_err(&ctlr->dev, "%pOF has invalid 'spi-buses' property
> (%d)\n",
> +			nc, rc);
> +		return rc;
> +	}
> +
> +	if (rc =3D=3D -EINVAL) {
> +		/* Default when property is omitted. */
> +		spi->num_data_bus =3D 1;
> +	} else {
> +		for (idx =3D 0; idx < rc; idx++) {
> +			if (buses[idx] >=3D ctlr->num_data_bus) {
> +				dev_err(&ctlr->dev,
> +					"%pOF has out of range 'spi-buses'
> property (%d/%d)\n",
> +					nc, buses[idx], ctlr->num_data_bus);
> +				return -EINVAL;
> +			}
> +			spi->data_bus[idx] =3D buses[idx];
> +		}
> +
> +		spi->num_data_bus =3D rc;
> +	}
> +
> =C2=A0	/*
> =C2=A0	 * By default spi->chip_select[0] will hold the physical CS number=
,
> =C2=A0	 * so set bit 0 in spi->cs_index_mask.
> @@ -3054,6 +3079,7 @@ struct spi_controller *__spi_alloc_controller(struc=
t
> device *dev,
> =C2=A0	mutex_init(&ctlr->add_lock);
> =C2=A0	ctlr->bus_num =3D -1;
> =C2=A0	ctlr->num_chipselect =3D 1;
> +	ctlr->num_data_bus =3D 1;
> =C2=A0	ctlr->target =3D target;
> =C2=A0	if (IS_ENABLED(CONFIG_SPI_SLAVE) && target)
> =C2=A0		ctlr->dev.class =3D &spi_target_class;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index
> cb2c2df3108999a73b67ef4a7b0d2cb07adfc669..c314194d4e7e2b396795ece10e14211=
8ca05
> f4eb 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -23,6 +23,9 @@
> =C2=A0/* Max no. of CS supported per spi device */
> =C2=A0#define SPI_DEVICE_CS_CNT_MAX 4
> =C2=A0
> +/* Max no. of data buses supported per spi device */
> +#define SPI_DEVICE_DATA_BUS_CNT_MAX 8
> +
> =C2=A0struct dma_chan;
> =C2=A0struct software_node;
> =C2=A0struct ptp_system_timestamp;
> @@ -171,6 +174,9 @@ extern void spi_transfer_cs_change_delay_exec(struct
> spi_message *msg,
> =C2=A0 * @chip_select: Array of physical chipselect, spi->chipselect[i] g=
ives
> =C2=A0 *	the corresponding physical CS for logical CS i.
> =C2=A0 * @num_chipselect: Number of physical chipselects used.
> + * @data_bus: Array of physical data buses. This is only used with
> specialized
> + * controllers that support multiple data buses.
> + * @num_data_bus: Number of physical data buses used.
> =C2=A0 * @cs_index_mask: Bit mask of the active chipselect(s) in the chip=
select
> array
> =C2=A0 * @cs_gpiod: Array of GPIO descriptors of the corresponding chipse=
lect lines
> =C2=A0 *	(optional, NULL when not using a GPIO line)
> @@ -231,6 +237,8 @@ struct spi_device {
> =C2=A0
> =C2=A0	u8			chip_select[SPI_DEVICE_CS_CNT_MAX];
> =C2=A0	u8			num_chipselect;
> +	u8			data_bus[SPI_DEVICE_DATA_BUS_CNT_MAX];
> +	u8			num_data_bus;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Bit mask of the chipselect(s) that the driver need to use from
> @@ -401,6 +409,7 @@ extern struct spi_device *spi_new_ancillary_device(st=
ruct
> spi_device *spi, u8 ch
> =C2=A0 *	SPI targets, and are numbered from zero to num_chipselects.
> =C2=A0 *	each target has a chipselect signal, but it's common that not
> =C2=A0 *	every chipselect is connected to a target.
> + * @num_data_bus: Number of data buses supported by this controller. Def=
ault
> is 1.
> =C2=A0 * @dma_alignment: SPI controller constraint on DMA buffers alignme=
nt.
> =C2=A0 * @mode_bits: flags understood by this controller driver
> =C2=A0 * @buswidth_override_bits: flags to override for this controller d=
river
> @@ -576,6 +585,14 @@ struct spi_controller {
> =C2=A0	 */
> =C2=A0	u16			num_chipselect;
> =C2=A0
> +	/*
> +	 * Some specialized SPI controllers can have more than one physical
> +	 * bus interface per controller (each having it's own serializer).
> This
> +	 * specifies the number of buses in that case. Other controllers do
> not
> +	 * need to set this (defaults to 1).
> +	 */
> +	u16			num_data_bus;
> +
> =C2=A0	/* Some SPI controllers pose alignment requirements on DMAable
> =C2=A0	 * buffers; let protocol drivers know about these requirements.
> =C2=A0	 */

