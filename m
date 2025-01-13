Return-Path: <linux-iio+bounces-14299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10FA0BCF7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56621188464D
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B761FBBEA;
	Mon, 13 Jan 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIcVo9WV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F201CA8D;
	Mon, 13 Jan 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784680; cv=none; b=h3G6bzmj29rBi0fBjZY04KAEeU6K3o+R0Sgb91pP7sbFyJvWQNGyaw0QRTkXNDswXOESQQscSc3MzlIEEC3d6DqSOF6GovfEWc3XN5zEO5op/78hbmATUA+aEcYCecDmvxCyBmIPZkEXmbdMl0Pdhp8nd8i/A8qEsdzpdD1jmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784680; c=relaxed/simple;
	bh=a1xVmpoeuO87QAR7ktrYGDsxGfnGGaNYkwQgrUcTVMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GudxWGVv7y3If7CHAAo8AxfQgkC4TdCQmtc1NkyMSaqxujdvnuz+7/zHPYebU/Cyrfu+1d8ujz27J6FFhTXTQ8H4W58lPevA/yOB/ejE3q3RDRqJgJz4zauBWqG9OmvMubXqvpIlMRjW/W474NzA5+lxZyEz8ZjNGY5CgyVuzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIcVo9WV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso31808425e9.0;
        Mon, 13 Jan 2025 08:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736784675; x=1737389475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7k6VjkHKrdZBwUE3ZmNmQit8NnV6aF6R7973kqTmXpA=;
        b=iIcVo9WVBjrjHR9QStfIPBrzL1fHgfrKrVkZ5FX1AB+JAJge2Yx3T/CntkjdxKch/l
         Z+F4SRIrbXrdvjkeGei/BQOdMkIxAIVE+k1fxrW1IpvQCGz/zhUU8U6eYBHQcyVtO4Tl
         hdyUgDTytNQVVaogHOWmZvX6KgG0s38+IHu+kBZ7yLRLay2EERZskNBI73V0QrAy7+TV
         QI79/JZHm8fcfYFXP7C/F2oQqWAQ2ArbG1k+Dwiyp5EXeEmtuBIRMBaaiYc9/Ap0EL6k
         Fh8urP0JmBIOa7tgPWw4vviLBHEicSYy7Q+R3Hfh8EPcs/7n2yIoHIJdKY4Z2ZoKW0P5
         JA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784675; x=1737389475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k6VjkHKrdZBwUE3ZmNmQit8NnV6aF6R7973kqTmXpA=;
        b=CkSswmg+m7H++PIYY8ogxSTkchwxkMA/Xf1uVhFZh5W1vWToMj+bFqWOO6OzGinTON
         ARn4wCnnuPtK0yKTB+lWp9KKa8qVbdDyGW4ECM3ZmxWn5eBw2qQPsBNvfAuMYtp4Bd3W
         JSM8EfS1lqwQxFmDYYHci5wB+jARFZ25tfILsd4A5GNqtIasDIFWOZ2wwid3z5S0pfii
         lA37ZfdVBst2+NgIwsyUQjSlkhia11SNxZFZCMJsCN67Ax2wJy/wWgn/Lk37g/2ZbDlA
         CZxRpxlw3sB276Fr1W7OvJrpbjMqI/nvF35bbhQ0yL7nBKIZgHXg4X7C872nANqWGUde
         praA==
X-Forwarded-Encrypted: i=1; AJvYcCU2sVWYqtaJSXDWz4BSR50n9Dd/p98XWhcDOEF4yl30kT4/cwHK0ZzVfFx0ToksPkQLFSwGrfKCtT8=@vger.kernel.org, AJvYcCUg/tx26K+nI+5r9kLJ3mDnOWqP5AZTr61HJvKp9i5ScQXKVlvMyMlCw5acocrDi7WMxREkUniXASDXmh6s@vger.kernel.org
X-Gm-Message-State: AOJu0Yydipb8rZINt4BCJtfClvIgrG5KPQRxlIXjzAgbgE/0O5RcEgDe
	ds8ZFs+WT7xMiRKG25bBXAzNcGzw5hj5jDRVu9yoVBtCC6Xt/pgn
X-Gm-Gg: ASbGncvaUHiBS6jmypSxAS+SH8bXhnRzfnnqj81vt9q+jXnCoWDgp5Z6h5lD4Z3Y8Az
	oms2kKkz4atBFfEKBrTPxdUFcCU8wVrQFP1Hz0Kxg3nVAWtYwL64X9crctRG4U/VNNhw6WTZkB6
	B4xs3fkAPG19nHTbZm3QzN4qJBXHu+dLZkXE3cleQDYWkYv8Pp0Xc+DkMYTsqJFvXc+ouKsJ5i9
	2QYNfIhIV6mY8SYHo7t7oXLmQibzHV1NmIIhDHJgDgk52Z7NOr5QQKG/jz02tMgcdqTu3MNuyEO
	hiOMqKjj/GqRD/ZsDFzOYEj6lrBU
X-Google-Smtp-Source: AGHT+IHs7Cp7fHovuLOFjhAQqnq98hKLbd3ZiYhKUkoQjuyL4GuQGl5mvs3PonlNKKCg0J21Orzf4g==
X-Received: by 2002:a5d:6da4:0:b0:385:de67:2269 with SMTP id ffacd0b85a97d-38a8730e04amr17656939f8f.36.1736784674665;
        Mon, 13 Jan 2025 08:11:14 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1daasm12803498f8f.93.2025.01.13.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:11:14 -0800 (PST)
Message-ID: <4436a3be542569959a640c78397db67d3152c895.camel@gmail.com>
Subject: Re: [PATCH v3 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 16:11:14 +0000
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-9-ab42aef0d840@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-9-ab42aef0d840@baylibre.com>
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
> Update ad3552r_qspi_update_reg_bits function name to a more
> generic name, since used mode can be SIMPLE/DUAL/QUAD SPI.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-hs.c | 64 ++++++++++++++++++++-------------=
----------
> -
> =C2=A01 file changed, 29 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 4600a9e84dfc..7f3a70cfbef8 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -56,9 +56,9 @@ struct ad3552r_hs_state {
> =C2=A0	u32 config_d;
> =C2=A0};
> =C2=A0
> -static int ad3552r_qspi_update_reg_bits(struct ad3552r_hs_state *st,
> -					u32 reg, u32 mask, u32 val,
> -					size_t xfer_size)
> +static int ad3552r_update_reg_bits(struct ad3552r_hs_state *st,
> +				=C2=A0=C2=A0 u32 reg, u32 mask, u32 val,
> +				=C2=A0=C2=A0 size_t xfer_size)
> =C2=A0{
> =C2=A0	u32 rval;
> =C2=A0	int ret;
> @@ -206,9 +206,8 @@ static int ad3552r_hs_buffer_postenable(struct iio_de=
v
> *indio_dev)
> =C2=A0	 */
> =C2=A0
> =C2=A0	/* Primary region access, set streaming mode (now in SPI + SDR). *=
/
> -	ret =3D ad3552r_qspi_update_reg_bits(st,
> -					=C2=A0=C2=A0
> AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> -					=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST, 0, 1);
> +	ret =3D ad3552r_update_reg_bits(st,
> AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST, 0, 1);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -217,10 +216,9 @@ static int ad3552r_hs_buffer_postenable(struct iio_d=
ev
> *indio_dev)
> =C2=A0	 * len value so it's not cleared hereafter when enabling streaming
> mode
> =C2=A0	 * (cleared by CS_ up).
> =C2=A0	 */
> -	ret =3D ad3552r_qspi_update_reg_bits(st,
> -		AD3552R_REG_ADDR_TRANSFER_REGISTER,
> -		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE,
> -		AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE, 1);
> +	ret =3D ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE=
,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE=
,
> 1);
> =C2=A0	if (ret)
> =C2=A0		goto exit_err_streaming;
> =C2=A0
> @@ -250,7 +248,7 @@ static int ad3552r_hs_buffer_postenable(struct iio_de=
v
> *indio_dev)
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * From here onward mode is DDR, so reading any register is not
> possible
> -	 * anymore, including calling "ad3552r_qspi_update_reg_bits"
> function.
> +	 * anymore, including calling "ad3552r_update_reg_bits" function.
> =C2=A0	 */
> =C2=A0
> =C2=A0	/* Set target to best high speed mode (D or QSPI). */
> @@ -351,18 +349,16 @@ static int ad3552r_hs_buffer_predisable(struct iio_=
dev
> *indio_dev)
> =C2=A0	 * Back to simple SPI for secondary region too now, so to be able =
to
> =C2=A0	 * dump/read registers there too if needed.
> =C2=A0	 */
> -	ret =3D ad3552r_qspi_update_reg_bits(st,
> -					=C2=A0=C2=A0
> AD3552R_REG_ADDR_TRANSFER_REGISTER,
> -					=C2=A0=C2=A0 AD3552R_MASK_MULTI_IO_MODE,
> -					=C2=A0=C2=A0 AD3552R_SPI, 1);
> +	ret =3D ad3552r_update_reg_bits(st, AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_MULTI_IO_MODE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_SPI, 1);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	/* Back to single instruction mode, disabling loop. */
> -	ret =3D ad3552r_qspi_update_reg_bits(st,
> -					=C2=A0=C2=A0
> AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> -					=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST,
> -					=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST, 1);
> +	ret =3D ad3552r_update_reg_bits(st,
> AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_SINGLE_INST, 1);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -379,10 +375,10 @@ static inline int ad3552r_hs_set_output_range(struc=
t
> ad3552r_hs_state *st,
> =C2=A0	else
> =C2=A0		val =3D FIELD_PREP(AD3552R_MASK_CH1_RANGE, mode);
> =C2=A0
> -	return ad3552r_qspi_update_reg_bits(st,
> -
> 					AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> -					AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
> -					val, 1);
> +	return ad3552r_update_reg_bits(st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_CH0_CH1_OUTPUT=
_RANGE,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_CH_OUTPUT_RANGE_SE=
L(ch),
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, 1);
> =C2=A0}
> =C2=A0
> =C2=A0static int ad3552r_hs_reset(struct ad3552r_hs_state *st)
> @@ -398,10 +394,10 @@ static int ad3552r_hs_reset(struct ad3552r_hs_state=
 *st)
> =C2=A0		fsleep(10);
> =C2=A0		gpiod_set_value_cansleep(st->reset_gpio, 0);
> =C2=A0	} else {
> -		ret =3D ad3552r_qspi_update_reg_bits(st,
> -					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> -					AD3552R_MASK_SOFTWARE_RESET,
> -					AD3552R_MASK_SOFTWARE_RESET, 1);
> +		ret =3D ad3552r_update_reg_bits(st,
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +			AD3552R_MASK_SOFTWARE_RESET,
> +			AD3552R_MASK_SOFTWARE_RESET, 1);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
> @@ -534,19 +530,17 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state=
 *st)
> =C2=A0
> =C2=A0	val =3D ret;
> =C2=A0
> -	ret =3D ad3552r_qspi_update_reg_bits(st,
> -				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> -				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> -				val, 1);
> +	ret =3D ad3552r_update_reg_bits(st,
> AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, 1);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	ret =3D ad3552r_get_drive_strength(st->dev, &val);
> =C2=A0	if (!ret) {
> -		ret =3D ad3552r_qspi_update_reg_bits(st,
> -					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> -					AD3552R_MASK_SDO_DRIVE_STRENGTH,
> -					val, 1);
> +		ret =3D ad3552r_update_reg_bits(st,
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +			AD3552R_MASK_SDO_DRIVE_STRENGTH, val, 1);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0	}
>=20


