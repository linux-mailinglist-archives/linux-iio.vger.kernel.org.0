Return-Path: <linux-iio+bounces-17606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B8A7AFF5
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F1D881E78
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC56267B1D;
	Thu,  3 Apr 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwK4WSog"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C425A340;
	Thu,  3 Apr 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710156; cv=none; b=aUIJdHhBVpFKO5pOBHuvgFwZXtOHGCrMBfBwz/b/8OaBBKdQWi7Daa0auyn60enUEPf6NTCoI/PDecoJUguZ1TJDwJgOg+9o97HSLPuYVqsyqRW/hJAY23z4uMAfz6BMpXmq3cQOxD1v5iW97/XWShwypaVlM8cjPKNv4s6tRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710156; c=relaxed/simple;
	bh=Y1TruIEeZTwzEfQsLWvaY/q7zaUrz4+Hs2A24QF6OXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9C8N0T/pw5iUrSHMmG5rDCGRXmeBwaINGgHI/5kmiosMuPi8C35nwIWhUNTXXM8R77/JP7RTI+fedJOcbi84aFjLCMwZrOP1f3Y8ji3RJURG7ZZADhMjrmyrPhi1/oBh4wrdwcjv8j+69TSJkkKvaOb+M/SR/OvATgD/pNQTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwK4WSog; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39129fc51f8so1106576f8f.0;
        Thu, 03 Apr 2025 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743710151; x=1744314951; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5QX/9/QGSyMiI5c5nbcyEu8MAuhHupXZTbU2Rle/Ag=;
        b=bwK4WSogPR6djb3pWeae3/pSaJV2Eyi/lYEdpvpPLhulyrpfyhCzIxfo57yPVVg/DT
         j5nWSYEOMLOoDQTdp/93YQ/wL8X4rAHrgPUJD3lcUO/dmfkgM/xYXB+nhy/a36Xm+O4v
         LX2lmH/6fjt9d2GA9XTrntbXwOkpEYTYUPnKF9/HJfAz+S2xP6RFnYCBya7f8NzndeXW
         KyJ7cDQ3PmJYHaQm70+j8+cTfG4wSDlBPENGUgkC0PVqZ+pGdm/pB767QRTCV3NT8xwm
         Y4rVjy1GevHXT2Tyc+49L1EbIg0E8vIIz7q4ECWrteQ4zYmGpEQTPlsCgxkdnp+4qvwo
         P/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743710151; x=1744314951;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5QX/9/QGSyMiI5c5nbcyEu8MAuhHupXZTbU2Rle/Ag=;
        b=S2I2sheCfkdKO/WvqjEJoS4uVUwwXD+MrXdGsUf1/MJ8h0b2JnpgAQl+c6Zs8PQmWS
         JauP3v98j4c5ypPP/FmKYosYiXm7fcQdJ9yg6ti2T/v4Y+ggiaHAM4S6erzNbDiaSSII
         Tzic7WeIgM85Yu4iYLcObPvmWe3EddHnqzAykE/3cx2bUtnF8pnOxjicAtxA6KdzBFwo
         Dv6ZNTrGWsbfxuwtrdskNrP2uZetmmjTWUnp/cTRylVRqxfuYPGC6XIyLd8M19TUNalt
         pOGpcKgmSG8vaVMfxSR9flBJkwFuw2nIVf+8dJX3qDo3VvDiAa6zIY8xo/PE1BATuMcc
         yWmA==
X-Forwarded-Encrypted: i=1; AJvYcCUccLud9MCT9K6ORPmJHYW7Nb9FcVA9GBXqm0P1N3vLMe6674xutdz8/9kOgHnJI4G6ISE0L3mo/irF@vger.kernel.org, AJvYcCWXYwYO0j8G8VVmoyR6jIj7h47jDJGsNHAlrYVhBFbu0yNAk01jaSHMXr7DTschzvxCpVhTctHIR3+ad4ay@vger.kernel.org, AJvYcCXDxNfaJ8xoD2zlgzaMLvgD8KahmuWrXE282K/mXi+DaDbBY4b9zo/3RbVpQcz+cJfqOIyoWebD91z0@vger.kernel.org, AJvYcCXjiHgs+7vuUe+oyA8DYs7mVdVOU16znj8uRnL4NYQLmrL20wrHA9AsGtLjG38zOLaapi4z57zMh9Z1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nKqyOCFT2hXWEiwqz8LTDYikKcu2xaG0uVJy7IBmda8HKv65
	h11qyBKzU4sqkcqG32jiiLl5fZJpKtmE5RHeo3YoVKCixM52VA5hRfsVtbvd+X8=
X-Gm-Gg: ASbGnctdUB+uUP4to/nGCE5PG6TUgavwHd7xDyhwwRoWk0C/NPW8GDR8JSBD3h9mlXh
	DMJhVbv8phveZJzNGp/xjWej/ecOm3CA2Uc1YdE3CTYKfOYylB1VqBx+OJqjc5MPSCk7E6w/YBh
	5BiLenI8+kVHPN1Hs/xelMNvbHfNPXBRWhAK8aiPX2dxOizv+KQfOTdpnAEA7UKO68L94gSlsQi
	+LDAj7qcew4jeLxZ6/khOdE9064ptdCSAVTSdhHELcvtSXJnPALlPu3f4WJ/XkU9ix9QpydmOCJ
	DCIoJRBXXEXK8s5moRoY7Xa+jt9Y1pL4Qw3XT2Fr1myb2KxjRXwuZAJ4qICJds/hhbyQ280RYM9
	skPfo5PieWQmyL70hxeE=
X-Google-Smtp-Source: AGHT+IGNDCxP3hOnrn4cIGvLltYjho2w3LgzPNUQPHiJXUfrSG42E/tA5jjJnVYidCgmoHWl4nCNqw==
X-Received: by 2002:a05:6000:2482:b0:39a:c9ed:8657 with SMTP id ffacd0b85a97d-39d0de17e4dmr117733f8f.17.1743710151106;
        Thu, 03 Apr 2025 12:55:51 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c301ba17csm2615035f8f.58.2025.04.03.12.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 12:55:50 -0700 (PDT)
Message-ID: <db78eee7049abc62a1a230ff87d04332de8afd66.camel@gmail.com>
Subject: Re: [PATCH 3/5] iio: adc: ad7380: move internal reference voltage
 to chip_info
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Thu, 03 Apr 2025 19:56:08 +0100
In-Reply-To: <20250401-iio-ad7380-add-ad7389-4-v1-3-23d2568aa24f@baylibre.com>
References: 
	<20250401-iio-ad7380-add-ad7389-4-v1-0-23d2568aa24f@baylibre.com>
	 <20250401-iio-ad7380-add-ad7389-4-v1-3-23d2568aa24f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-01 at 17:50 -0500, David Lechner wrote:
> Move the internal reference voltage value to the chip_info structure.
>=20
> Before this change, only ADAQ chips could be internal_ref_only and only
> non-ADAQ chips could be external_ref_only. Now, this restriction is
> removed.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 22 ++++++++++++++++++++--
> =C2=A01 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> 18ed07275be8e031e54f3595f70afe47514084cd..e5cd11fd7b1083af2082985f2c0226b=
1a97d600f
> 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -120,6 +120,7 @@ struct ad7380_chip_info {
> =C2=A0	unsigned int num_supplies;
> =C2=A0	bool external_ref_only;
> =C2=A0	bool internal_ref_only;
> +	unsigned int internal_ref_mv;
> =C2=A0	const char * const *vcm_supplies;
> =C2=A0	unsigned int num_vcm_supplies;
> =C2=A0	const unsigned long *available_scan_masks;
> @@ -609,6 +610,7 @@ static const struct ad7380_chip_info ad7380_chip_info=
 =3D {
> =C2=A0	.num_simult_channels =3D 2,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> =C2=A0	.max_conversion_rate_hz =3D 4 * MEGA,
> @@ -622,6 +624,7 @@ static const struct ad7380_chip_info ad7381_chip_info=
 =3D {
> =C2=A0	.num_simult_channels =3D 2,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> =C2=A0	.max_conversion_rate_hz =3D 4 * MEGA,
> @@ -637,6 +640,7 @@ static const struct ad7380_chip_info ad7383_chip_info=
 =3D {
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.vcm_supplies =3D ad7380_2_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> =C2=A0	.max_conversion_rate_hz =3D 4 * MEGA,
> @@ -652,6 +656,7 @@ static const struct ad7380_chip_info ad7384_chip_info=
 =3D {
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.vcm_supplies =3D ad7380_2_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> =C2=A0	.max_conversion_rate_hz =3D 4 * MEGA,
> @@ -665,6 +670,7 @@ static const struct ad7380_chip_info ad7386_chip_info=
 =3D {
> =C2=A0	.num_simult_channels =3D 2,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> @@ -679,6 +685,7 @@ static const struct ad7380_chip_info ad7387_chip_info=
 =3D {
> =C2=A0	.num_simult_channels =3D 2,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> @@ -693,6 +700,7 @@ static const struct ad7380_chip_info ad7388_chip_info=
 =3D {
> =C2=A0	.num_simult_channels =3D 2,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> @@ -721,6 +729,7 @@ static const struct ad7380_chip_info ad7381_4_chip_in=
fo =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> =C2=A0	.max_conversion_rate_hz =3D 4 * MEGA,
> @@ -734,6 +743,7 @@ static const struct ad7380_chip_info ad7383_4_chip_in=
fo =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.vcm_supplies =3D ad7380_4_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> @@ -749,6 +759,7 @@ static const struct ad7380_chip_info ad7384_4_chip_in=
fo =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.vcm_supplies =3D ad7380_4_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> @@ -764,6 +775,7 @@ static const struct ad7380_chip_info ad7386_4_chip_in=
fo =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -778,6 +790,7 @@ static const struct ad7380_chip_info ad7387_4_chip_in=
fo =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -792,6 +805,7 @@ static const struct ad7380_chip_info ad7388_4_chip_in=
fo =3D {
> =C2=A0	.num_simult_channels =3D 4,
> =C2=A0	.supplies =3D ad7380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> +	.internal_ref_mv =3D AD7380_INTERNAL_REF_MV,
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -807,6 +821,7 @@ static const struct ad7380_chip_info adaq4370_4_chip_=
info =3D {
> =C2=A0	.supplies =3D adaq4380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(adaq4380_supplies),
> =C2=A0	.internal_ref_only =3D true,
> +	.internal_ref_mv =3D ADAQ4380_INTERNAL_REF_MV,
> =C2=A0	.has_hardware_gain =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -822,6 +837,7 @@ static const struct ad7380_chip_info adaq4380_4_chip_=
info =3D {
> =C2=A0	.supplies =3D adaq4380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(adaq4380_supplies),
> =C2=A0	.internal_ref_only =3D true,
> +	.internal_ref_mv =3D ADAQ4380_INTERNAL_REF_MV,
> =C2=A0	.has_hardware_gain =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -837,6 +853,7 @@ static const struct ad7380_chip_info adaq4381_4_chip_=
info =3D {
> =C2=A0	.supplies =3D adaq4380_supplies,
> =C2=A0	.num_supplies =3D ARRAY_SIZE(adaq4380_supplies),
> =C2=A0	.internal_ref_only =3D true,
> +	.internal_ref_mv =3D ADAQ4380_INTERNAL_REF_MV,
> =C2=A0	.has_hardware_gain =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -1855,7 +1872,7 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0		 * in bulk_get_enable().
> =C2=A0		 */
> =C2=A0
> -		st->vref_mv =3D ADAQ4380_INTERNAL_REF_MV;
> +		st->vref_mv =3D st->chip_info->internal_ref_mv;
> =C2=A0
> =C2=A0		/* these chips don't have a register bit for this */
> =C2=A0		external_ref_en =3D false;
> @@ -1880,7 +1897,8 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio regulator\n");
> =C2=A0
> =C2=A0		external_ref_en =3D ret !=3D -ENODEV;
> -		st->vref_mv =3D external_ref_en ? ret / 1000 :
> AD7380_INTERNAL_REF_MV;
> +		st->vref_mv =3D external_ref_en ? ret / 1000
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : st->chip_info->internal_ref_mv;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
>=20


