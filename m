Return-Path: <linux-iio+bounces-14295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C57A0BCDE
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7425E3A4CB4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3B1CAA62;
	Mon, 13 Jan 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0CSNV9V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D790E240222;
	Mon, 13 Jan 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784333; cv=none; b=CfPBZjXFD3sWaXHgAmlvHEjajDIQjuYBUHi8IYIJd5GFxLpkXmlnCQPydMEI4/z9o7ImhaLMqOMAuznZu3dCA9XzxQ1uqlYYs24WC5tc4aQg3qdZYePuCyzAarufwG8tFzrVdUNNAcLw+zlAaemLud4gVfXoXb5qxZcumbb73YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784333; c=relaxed/simple;
	bh=LSE67Fxjmd7+bk5gnKFFebEBOIGvo0B5fBFhkxwxKDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzTD4/S8cix6Pyx2KLZQyXwBuQt2ioV/jaomeRCGeJ3wjtA0fjNIbcGvNw+h4buyRCIxb9IJLUOMW3ZBAzj1jIX7alE7gZlnAQg4UVG5o1P3nqv4GiqjwKYCEoqSO3etZNdggud1s7g0kt5Ag1+7hWX2EoiRPw56q6PsgPMMW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0CSNV9V; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso33859335e9.0;
        Mon, 13 Jan 2025 08:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736784330; x=1737389130; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QhnZnwcyVlQ5uXtQ4I8ouV44wGeq+qs1yuTyOGUh7u4=;
        b=c0CSNV9Vkc/zsop5TSG0yBi+Y8xZQLGH/9nwQtgao4Di5uSCe8qkSmLUiiLVYoKkxe
         nfOx1l51xQ8kgQa9zLseon+4YO67wq0mA6EEGWTWV3Zkq4fXYh5QoaBvSfE6DRSP2YWq
         Yl8U50m65GbxkcvwIGNTpSl1Pn/M85S2uT6JNB7V77opTNuWwmiF56faNz72jJnH0cml
         0yJiqFwaIrcM7QFMPaANJF/+zQeNAlvqb1A+3t2B1gRI6Gpdra8bTyjS6LIlMs/hIYwm
         K7B22H+R6SmItLQyJVH5aYU9wibEo2qFvTsaePRw0qAoLGvViDMiNumzoCuGeqR5ZRfi
         UvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784330; x=1737389130;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhnZnwcyVlQ5uXtQ4I8ouV44wGeq+qs1yuTyOGUh7u4=;
        b=Y4u/z+5bE3CL1nwOh2k8cMVxRZDQCYfJ9vceWKt/vttHsViYWAhkqym9y/VK2y5Fp4
         u92t6E/0EPlBP8cJ5v0uLWNzHG7wfO6R/MhpIAft3PXW2r/RAohciAbIetkhQBOGH13l
         +HzmoafZkOt2wiV/u1rpUJeLSfPO3tiD28cM6SBbP4MoyWrTfEqQS9Zw4+K1dywP8qTe
         woQu8DqY/8m3wvHmHHUxTEa/U4lrMtTbcDDb7TcRrrajT6ql56MjR/Lh4gZLGINSVbk/
         eY0XPBAvO9SfsAkzNqlrbKW/FECiHchJ4wsFgVcKEOxI9dbkCbWyCG7WzhJNItpTlni2
         X/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVPIdu9d54Gq/SF9ur00YJrulQtL7Z9PlrBe7c2fHLpCQaYYatzs+iEuZwXHp3hrEKfBiO7Y29CnFqT9Yy@vger.kernel.org, AJvYcCX/tsf+V/uNpZ3iU3pz27rorhl70pCquGapGRx8bBer7be7CMQnkQWx2L2ak0HKeDVxqwUt+ESKP0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxqr7rmF6hBtFO/6zgDPUWbm+yWUjZqw8gqXlWAxm7sOgIRuA
	bXVvlhGbLJxiNLtBYJrrB1P8FMm+7IP5kxP70+AY2XNMweOIs15v
X-Gm-Gg: ASbGnctcUVWkFWTlSTnnFe+rhDG+fpE+s7f6KpnfN0mE2HZ2ZY+LfpSubiitv7J7qYp
	JxknG3XIQPJBaftmDeQRdDoXz39Ip9qIdigiwn+hXI3WutLSK85jFEfpAStwrs3Kw8sS6D/56tO
	ZYlRBc9RoW3xc/S+GpqnqShdcHJdJ8tl2c6cPuqY4SI9YzdRis+ecA1hFjarwfPLEwvHV2eV/lN
	3VTobA4nAlVymocHzac+FW1TVJVV8mtM+tCHEB2Xkack13dCMI1q7994MYGzKc/CJJXXfqC1x75
	Ra5uj7Tt8BOnsor7VC7ooOPLqjNF
X-Google-Smtp-Source: AGHT+IGWDJzKXZbveXE2cMWBr0INf24ytawQ6H9nyvaxsWrB3OHsOSfoHSHF8GJrKfXOJKV4GFSSXg==
X-Received: by 2002:a5d:6daf:0:b0:385:f64e:f177 with SMTP id ffacd0b85a97d-38a8b0dafa2mr13880913f8f.11.1736784328355;
        Mon, 13 Jan 2025 08:05:28 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38378csm12453754f8f.25.2025.01.13.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:05:28 -0800 (PST)
Message-ID: <a8630218741ace433752e855f81664f1123d51a3.camel@gmail.com>
Subject: Re: [PATCH v3 4/9] iio: dac: adi-axi-dac: add bus mode setup
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 16:05:26 +0000
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-4-ab42aef0d840@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-4-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 11:24 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> The ad354xr requires DSPI mode (2 data lanes) to work in buffering
> mode, so backend needs to allow a mode selection between:
> =C2=A0=C2=A0=C2=A0 SPI=C2=A0 (entire ad35xxr family),
> =C2=A0=C2=A0=C2=A0 DSPI (ad354xr),
> =C2=A0=C2=A0=C2=A0 QSPI (ad355xr).
>=20

I guess this could be misleading people to think this is being handled by t=
he
backend framework when it's not. I would rephrase things a bit in here.

> About removal of AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER, according to
> the HDL history the flag has never been used. So looks like the driver
> was including it by mistake or in anticipation for something that was
> never implemented on HDL side.
>=20
> Current HDL updated documentation confirm it is actually not in use
> anymore and replaced by the IO_MODE bits.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

With the improved change and the inline note:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.h=C2=A0 |=C2=A0 8 ++++++++
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 22 +++++++++++++++++++++-
> =C2=A02 files changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.h b/drivers/iio/dac/ad3552r-hs.h
> index 724261d38dea..4a9e35234124 100644
> --- a/drivers/iio/dac/ad3552r-hs.h
> +++ b/drivers/iio/dac/ad3552r-hs.h
> @@ -8,11 +8,19 @@
> =C2=A0
> =C2=A0struct iio_backend;
> =C2=A0
> +enum ad3552r_io_mode {
> +	AD3552R_IO_MODE_SPI,
> +	AD3552R_IO_MODE_DSPI,
> +	AD3552R_IO_MODE_QSPI,
> +};
> +
> =C2=A0struct ad3552r_hs_platform_data {
> =C2=A0	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val,
> =C2=A0			=C2=A0=C2=A0=C2=A0 size_t data_size);
> =C2=A0	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 size_t data_size);
> +	int (*bus_set_io_mode)(struct iio_backend *back,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum ad3552r_io_mode mode);
> =C2=A0	u32 bus_sample_data_clock_hz;
> =C2=A0};
> =C2=A0
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index ac871deb8063..bcaf365feef4 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -64,7 +64,7 @@
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> =C2=A0#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> -#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE	GENMASK(3, 2)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> =C2=A0
> @@ -722,6 +722,25 @@ static int axi_dac_bus_reg_read(struct iio_backend *=
back,
> u32 reg, u32 *val,
> =C2=A0	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
> =C2=A0}
> =C2=A0
> +static int axi_dac_bus_set_io_mode(struct iio_backend *back,
> +				=C2=A0=C2=A0 enum ad3552r_io_mode mode)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ival, ret;
> +

No harm in doing some validation on 'mode'.

- Nuno S=C3=A1

> +	guard(mutex)(&st->lock);
> +
> +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> +			AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
> +			FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG,
> ival,
> +			FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) =3D=3D 0, 10,
> +			100 * KILO);
> +}
> +
> =C2=A0static void axi_dac_child_remove(void *data)
> =C2=A0{
> =C2=A0	platform_device_unregister(data);
> @@ -733,6 +752,7 @@ static int axi_dac_create_platform_device(struct
> axi_dac_state *st,
> =C2=A0	struct ad3552r_hs_platform_data pdata =3D {
> =C2=A0		.bus_reg_read =3D axi_dac_bus_reg_read,
> =C2=A0		.bus_reg_write =3D axi_dac_bus_reg_write,
> +		.bus_set_io_mode =3D axi_dac_bus_set_io_mode,
> =C2=A0		.bus_sample_data_clock_hz =3D st->dac_clk_rate,
> =C2=A0	};
> =C2=A0	struct platform_device_info pi =3D {
>=20


