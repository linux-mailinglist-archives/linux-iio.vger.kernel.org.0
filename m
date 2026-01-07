Return-Path: <linux-iio+bounces-27517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B71C9CFE1FF
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58CD430C231B
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58C329390;
	Wed,  7 Jan 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX4fLLAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E13019A9
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793769; cv=none; b=AYFECsVB1blaqnLcS7ZZDoubnUcvr0X2hwXvfdjvRwdvPmnG9v1JODbQxyl7e0H3CHBKiQnWho9+2DPshjdFJlqGAaoVIbAhT8BW/xpzPgJSd4lNNCZN3HCG+mJdtYZk1OB4Rk95r/j5/UpbZ4+2ty1k7bqSQfSrSdo01sz8vQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793769; c=relaxed/simple;
	bh=CjBZ6lpm/gluwaBs/urTg3hBTAY1XEL5b8Dl7uWZqKQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AEkHmNctUhRcIwWy1jbnYFfD0FRQhet1fEach7lougzpg/pdU/f36IW44D4rHvoUmHZg8tLSvByPBt9cSoobVjeNSx2aT/MOwQZ4UW+irkzF/84q83psTfykExN85H1B1p2ebcZtn7VsmXW4LuXNHMPGpsoZdDJCZbP9L5zEzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX4fLLAF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso20120975e9.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767793766; x=1768398566; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muR3VLqqfejkmv2BmcAcvMLZuPKZEAOQ6QGoVQtHG9A=;
        b=jX4fLLAFoqL82f68N5Xst6N/zJRAKnxfYuXMb53ih6WlEptdRgfTHlOMYCPOPBfl4N
         cVQM6mI0JqsPLdOs6eo8/CNRvVDENyN16xely5r+CSex9I9yCA9/7H2y+tWsnQd3KOaG
         +Y5kEwExOweCBKCOOjHAbwOoOIovY1PMKT1t302YB8b+I1HOAZacOuTG7L/9XfGN6by2
         AiUU3vTSbrL067EoQIrJzzVsaK5xo4GSMKXUGhW4EnOeqvsvB42T65E8OxSb0PKHDi7j
         Xv9en/C3rhZe/U1kQnpAD5cC38TKJyl5qpbNAGLmzm3wxnjIRNDKuSwARg9WE3p0QPSm
         EaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793766; x=1768398566;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=muR3VLqqfejkmv2BmcAcvMLZuPKZEAOQ6QGoVQtHG9A=;
        b=UaBimH8LuFQwvEJegIoNeBEP7JyqKCseFadltfzsHx8NETyWLEs5D3uMJfjjbZ8+fp
         jibUe1fdRae7aDxyLAEeH7GcDgk7ty2ZIvdyjdVXhnG/o5TIbu0fRn8YsVUMWSTvE+Xk
         QGKR3n5Py+OxyV0kjmq3fjMUXJhLYJsHm5OgJtPEZdHr4n0/ey/athPZp+/VnrvsdvAd
         /d2y1D5NlXxZWPNQAS/gvFtU73/G9WE5g0bRP6QGpEG3EBPJYNe4fPnOG8hScEZtZVq0
         l5DSXJ4s0/Bq1ApigyS3kuVbEnehkqc1P3qcfQf1BYLQhc6qqnDpITasI6pzoVo65cBI
         FzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTyMnoird9hxMJMPfuXXyj4eyzniNRyCeeROJqUBOHu7TriY/+vUCGGpVNvPiNb+G2/AgSqD8toyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRdcWzSG7+UL3ZbWQRf+bP5tWIwuekDT/UhGWFj5w4GoWjZsc
	w3QfOMuih6CHytd2hshSdULMGxD8fK+jPWL5V0BM5M/3GN5xmnbsixRH
X-Gm-Gg: AY/fxX4fpX1w1zfa+lUv/Yp8yhHsLtoRpVdT4/E9/CrgNYADnUN0uriMWdn7bEVWBtB
	F+116n5w+KF2OOwjER+LUdVC1LnkBwWfwimibo/KC1Ws9VSDizMEvf3Qa4bOCIhHR+63mAMoRar
	stgeh7EG8VCUiiENc8Uv5DWF5mEvLJVlj1zwIpZP9KXaTPN58nSlV8TNA02jhMOp77rHZFTVznF
	1iuvMlgtoOUTnGXkLz6/Wnav7RdhUe/6GImXJ6IZoQ0F0QOO9ZmANfhBLKLHogQb2iDUAoRkpZa
	vFhOEKsFsk81z2Hs5/X1CeRe5o1OFu7u6HP2UQD4KclnIjFOrHIYrbuyvItzZCy9KHUbGTseO9K
	VOyYvzJIA2dJSXwYRVPeTSfMHO1a+NjmRYZBLA/HbUCQls55JC6dr/2f++dKjGxVrfgh6AILFg8
	W1i1ne0r3JSeCsffVYJFk=
X-Google-Smtp-Source: AGHT+IHOSGN4Xv5l08m8bU8YN5bcOmKa/WR6M2fI+vb5Ei/oXFAOWRuxZEJSEMIFXdnp5vzFKC7ZKw==
X-Received: by 2002:a05:600c:3b28:b0:477:9b4a:a82 with SMTP id 5b1f17b1804b1-47d84b41152mr30263045e9.35.1767793765458;
        Wed, 07 Jan 2026 05:49:25 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8719e695sm12067035e9.17.2026.01.07.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:49:25 -0800 (PST)
Message-ID: <d9bb518e29939cd8e3c7b62c3f5cb7e9d018ee52.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: adxl380: Store sampling frequency index
 in odr struct member
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Jan 2026 13:50:07 +0000
In-Reply-To: <20260107123518.4017292-2-flavra@baylibre.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
	 <20260107123518.4017292-2-flavra@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 13:35 +0100, Francesco Lavra wrote:
> The ADXL380 driver assumes that acceleration samples are always retrieved
> via the high-performance DSM signal path; as a result, the sampling
> frequency value depends exclusively on the decimation filter settings in
> the TRIG_CFG register.
> In preparation for adding support for sampling frequency values that rely
> on the low-power SAR signal path (on which the decimation filters are not
> supported), use the (currently unused) 'odr' member of struct adxl380_sta=
te
> to store the sampling frequency value, and when userspace requests the
> current frequency value, retrieve it from the struct instead of calculati=
ng
> it from the decimation filter settings.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/accel/adxl380.c | 13 ++-----------
> =C2=A01 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> index ce3643c5deb8..bbf1f88ca781 100644
> --- a/drivers/iio/accel/adxl380.c
> +++ b/drivers/iio/accel/adxl380.c
> @@ -417,17 +417,7 @@ static int adxl380_read_chn(struct adxl380_state *st=
, u8 addr)
> =C2=A0
> =C2=A0static int adxl380_get_odr(struct adxl380_state *st, int *odr)
> =C2=A0{
> -	int ret;
> -	unsigned int trig_cfg, odr_idx;
> -
> -	ret =3D regmap_read(st->regmap, ADXL380_TRIG_CFG_REG, &trig_cfg);
> -	if (ret)
> -		return ret;
> -
> -	odr_idx =3D (FIELD_GET(ADXL380_TRIG_CFG_SINC_RATE_MSK, trig_cfg) << 1) =
|
> -		=C2=A0 (FIELD_GET(ADXL380_TRIG_CFG_DEC_2X_MSK, trig_cfg) & 1);
> -
> -	*odr =3D st->chip_info->samp_freq_tbl[odr_idx];
> +	*odr =3D st->chip_info->samp_freq_tbl[st->odr];
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -500,6 +490,7 @@ static int adxl380_set_odr(struct adxl380_state *st, =
u8 odr)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	st->odr =3D odr;
> =C2=A0	ret =3D adxl380_set_measure_en(st, true);
> =C2=A0	if (ret)
> =C2=A0		return ret;

