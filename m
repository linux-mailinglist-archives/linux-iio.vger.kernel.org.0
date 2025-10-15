Return-Path: <linux-iio+bounces-25089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B89BDE036
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FE356390
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2042EB5BF;
	Wed, 15 Oct 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHdkrAIm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF822EA166
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524211; cv=none; b=N1jXCANSnFFncjK5Vsxii/TbgRVFqgpONuH8CFOzOFtDncodomdJgkXq4jb8a769mAXsIkJ2u5SCnJBeXc5vy+jyEuUKPF/zuiCe6sSIo4kJm7ByW5m1qMRrYU5ov2LlnmMpUSMuWQnx4HTrcMMD/6i5Yi1CqObLRIH/shLr7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524211; c=relaxed/simple;
	bh=Bg+Z1n2wXb8uVIji48r8xGjYlXJK8zyqzDDHBMHeaik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UEyLidLgz2qHo/oH6NpMzKR5LW9WVkFCK09jpxk6m5oGJQpSxwozO3k9mobMPA+xvDg4ncZAriEtTeyXCcJJq8juIrUpDMBTL6ufpV9uDCWX3dccWupDRsk606GwVS+yoZQsNOJima9fXMlG+Rl5KpyYaRviqDsUy1++Pmq9FyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHdkrAIm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e47cca387so62789795e9.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760524207; x=1761129007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YQME+sn3dWO68d8oui4leQRfjhZnFNWObqexC6XKq9M=;
        b=CHdkrAImt+9RuVewZ3GqqOIULDQ+Dt1fQ/LRorVeJZRaJSB7nV7/gk2bHBAif+ZfTk
         myL2nfm7RSssQz/0EEV7GTY916GgibMJNRS1WYYy9PXcaHjqcQS1FSka2wpApV9tKGns
         aNg8KEStjtAQeH4r1NPQG3kBMkZnsBxOvSOlfft+apf7cjHAs3hBsfriVnNiBhFKWgDF
         vgTS/0Ag8ySD25Qiop16QhqGw4lh0FIY+ANwd+86x9WLvu7zT+o40bPKxIMwZpA46t0t
         U4LIraOXjwi9XPMLPk7mcn9Wz4lgdkXjIFpnq1fZR+9cbmpreSpPGbId3L6W4g19bf5U
         ysQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760524207; x=1761129007;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQME+sn3dWO68d8oui4leQRfjhZnFNWObqexC6XKq9M=;
        b=BfoxgrRKdbO/TGfFywZjnwW/liVXteZVPqAKHoQnFNrFng4G5CinFwcq0r/1gHJcOa
         7CcSwwbyT5Q45BzYluEVV9it5Cp2c/0gREEGwSpxBocLYatSMSbneBaEoz4aSV0ZSZ0M
         8ORi+BBsdqASe1fcw9sOsHGIxPzwhlJaC7Ye+dMNPLTaj8p15ebMa/4AI5zLjMyi5iWa
         tJM1SjonzKIQ2y58tOL8GoawiomVum9YnHbSWDhpCp0e+q9rSdOgyqdUrmR7gfzO1yw3
         KNjJIeiz5ZkcFn3P+6PgJ+xCU7b5hM9MS1yE2xOXAB9UbpdyA3CulOzCRfPSSZqHfOYd
         Vqpg==
X-Forwarded-Encrypted: i=1; AJvYcCUCOuHU+FCQVzRU/6IyPBaTU0DcmTAPpwsdbzR8eWZmJbbEP3Tjmp3AqRt2X1dia0lwnnkA6qZYx5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBIf7Ae54NZO1UpZitqCgo4q3+jhIhOnYHZP5DDu144f2RzUl
	APgTKekFDa4p6qdw5sEFurMElIVzNLqVFLs9z7xt/nKhL1ElPf0loHn/
X-Gm-Gg: ASbGncutIql0Jv9MmIttn0WCyQ7jgMXtobcM/uZf6XPjNXgyxAdPf9Kgn0FhRfmm7jc
	6mRrRAANNmJyrfZcZNZBA2+u/NWYZp3OQqfp4yuZE7W7h7yBl5VzMpBcXBVXivYd7+HjcJ1xBcn
	CsvFcDiRU+nSx6ymGUHpIBql8mBtyrLRmir2KfL9+Tx0tVQYE+Ra/UWjJ7vPNGX4ySVD1TJB780
	zHxc9WeYUdjATLvtrLWqtd5KzFXyhpvbLqUBrccD/L7V4kfetjQeZEl4L0GxPoWmp3OUHZMZAzL
	0OEuc1t+Iyg9VXVDFEXpnVUW6KPzbi71LZhrTHVc3NKFAOdoBZNIJ85pw7+izOcpsqeuc9a4XAs
	M9RNAhb94iF6iUD3RV3XQyG/8RCZUyVY0F8s3aJThl3TQ7mb9rT7xH5JbinXE
X-Google-Smtp-Source: AGHT+IG59U3gqkC6eeKyzFw5fLLTNIH8yW3/ovkw5HgRRTRqvgP4g98uKIUkAFMPY1Ss14l8BFe+jw==
X-Received: by 2002:a05:600c:1c23:b0:45b:6b57:5308 with SMTP id 5b1f17b1804b1-46fa9a892a0mr204503275e9.7.1760524206980;
        Wed, 15 Oct 2025 03:30:06 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm31596615e9.5.2025.10.15.03.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 03:30:06 -0700 (PDT)
Message-ID: <3180475bd51e1e057d6aa7e1b62f564cb57a117e.camel@gmail.com>
Subject: Re: [PATCH 4/6] spi: axi-spi-engine: support
 SPI_MULTI_BUS_MODE_STRIPE
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
Date: Wed, 15 Oct 2025 11:30:39 +0100
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
References: 
	<20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
	 <20251014-spi-add-multi-bus-support-v1-4-2098c12d6f5f@baylibre.com>
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
> Add support for SPI_MULTI_BUS_MODE_STRIPE to the AXI SPI engine driver.
>=20
> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
> buses. This can be used with SPI_MULTI_BUS_MODE_STRIPE to support
> reading from simultaneous sampling ADCs that have a separate SDO line
> for each analog channel. This allows reading all channels at the same
> time to increase throughput.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 128 ++++++++++++++++++++++++++++=
+++++++++-
> -
> =C2=A01 file changed, 124 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> engine.c
> index
> e06f412190fd243161a0b3df992f26157531f6a1..707e5108efec41f7eff608a09fcebd9=
d28fa
> 2d70 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -23,6 +23,9 @@
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0#include <trace/events/spi.h>
> =C2=A0
> +#define SPI_ENGINE_REG_DATA_WIDTH		0x0C
> +#define=C2=A0=C2=A0 SPI_ENGINE_REG_DATA_WIDTH_NUM_OF_SDIO_MASK	GENMASK(2=
4, 16)
> +#define=C2=A0=C2=A0 SPI_ENGINE_REG_DATA_WIDTH_MASK		GENMASK(15, 0)
> =C2=A0#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
> =C2=A0#define SPI_ENGINE_REG_RESET			0x40
> =C2=A0
> @@ -75,6 +78,8 @@
> =C2=A0#define SPI_ENGINE_CMD_REG_CLK_DIV		0x0
> =C2=A0#define SPI_ENGINE_CMD_REG_CONFIG		0x1
> =C2=A0#define SPI_ENGINE_CMD_REG_XFER_BITS		0x2
> +#define SPI_ENGINE_CMD_REG_SDI_MASK		0x3
> +#define SPI_ENGINE_CMD_REG_SDO_MASK		0x4
> =C2=A0
> =C2=A0#define SPI_ENGINE_MISC_SYNC			0x0
> =C2=A0#define SPI_ENGINE_MISC_SLEEP			0x1
> @@ -105,6 +110,10 @@
> =C2=A0#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
> =C2=A0#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
> =C2=A0
> +/* Extending SPI_MULTI_BUS_MODE values for optimizing messages. */
> +#define SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN	-1
> +#define SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING	-2
> +
> =C2=A0struct spi_engine_program {
> =C2=A0	unsigned int length;
> =C2=A0	uint16_t instructions[] __counted_by(length);
> @@ -142,6 +151,9 @@ struct spi_engine_offload {
> =C2=A0	unsigned long flags;
> =C2=A0	unsigned int offload_num;
> =C2=A0	unsigned int spi_mode_config;
> +	unsigned int multi_bus_mode;
> +	u8 primary_bus_mask;
> +	u8 all_bus_mask;
> =C2=A0	u8 bits_per_word;
> =C2=A0};
> =C2=A0
> @@ -165,6 +177,22 @@ struct spi_engine {
> =C2=A0	bool offload_requires_sync;
> =C2=A0};
> =C2=A0
> +static u8 spi_engine_primary_bus_flag(struct spi_device *spi)
> +{
> +	return BIT(spi->data_bus[0]);
> +}
> +
> +static u8 spi_engine_all_bus_flags(struct spi_device *spi)
> +{
> +	u8 flags =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < spi->num_data_bus; i++)
> +		flags |=3D BIT(spi->data_bus[i]);
> +
> +	return flags;
> +}
> +
> =C2=A0static void spi_engine_program_add_cmd(struct spi_engine_program *p=
,
> =C2=A0	bool dry, uint16_t cmd)
> =C2=A0{
> @@ -193,7 +221,7 @@ static unsigned int spi_engine_get_config(struct
> spi_device *spi)
> =C2=A0}
> =C2=A0
> =C2=A0static void spi_engine_gen_xfer(struct spi_engine_program *p, bool =
dry,
> -	struct spi_transfer *xfer)
> +				struct spi_transfer *xfer, u32 num_lanes)
> =C2=A0{
> =C2=A0	unsigned int len;
> =C2=A0
> @@ -204,6 +232,9 @@ static void spi_engine_gen_xfer(struct spi_engine_pro=
gram
> *p, bool dry,
> =C2=A0	else
> =C2=A0		len =3D xfer->len / 4;
> =C2=A0
> +	if (xfer->multi_bus_mode =3D=3D SPI_MULTI_BUS_MODE_STRIPE)
> +		len /=3D num_lanes;
> +
> =C2=A0	while (len) {
> =C2=A0		unsigned int n =3D min(len, 256U);
> =C2=A0		unsigned int flags =3D 0;
> @@ -269,6 +300,7 @@ static int spi_engine_precompile_message(struct
> spi_message *msg)
> =C2=A0{
> =C2=A0	unsigned int clk_div, max_hz =3D msg->spi->controller->max_speed_h=
z;
> =C2=A0	struct spi_transfer *xfer;
> +	int multi_bus_mode =3D SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
> =C2=A0	u8 min_bits_per_word =3D U8_MAX;
> =C2=A0	u8 max_bits_per_word =3D 0;
> =C2=A0
> @@ -284,6 +316,24 @@ static int spi_engine_precompile_message(struct
> spi_message *msg)
> =C2=A0			min_bits_per_word =3D min(min_bits_per_word, xfer-
> >bits_per_word);
> =C2=A0			max_bits_per_word =3D max(max_bits_per_word, xfer-
> >bits_per_word);
> =C2=A0		}
> +
> +		if (xfer->rx_buf || xfer->offload_flags &
> SPI_OFFLOAD_XFER_RX_STREAM ||
> +		=C2=A0=C2=A0=C2=A0 xfer->tx_buf || xfer->offload_flags &
> SPI_OFFLOAD_XFER_TX_STREAM) {

I'm a bit confused by this condition. It looks like setting priv->multi_bus=
_mode
(and the other fields) only matters for msg->offload but the above will be =
true
for regular rx/tx messages, right? Or am i missing something?

If so, I wonder why doing this for all transfers if we only care about
multi_bus_mode for offload messages. I guess you want to validate
xfer->multi_bus_mode? I would then just take the switch() out of the condit=
ion
(I mean trying to setup a no data xfer with an invalid bus_mode should also=
 be
seen as invalid IMO) and then use the offload conditions (or maybe simply m=
sg-
>offload?) for the multi_bus_mode handling. To me, it makes the intent more
clear.
=20
- Nuno S=C3=A1


