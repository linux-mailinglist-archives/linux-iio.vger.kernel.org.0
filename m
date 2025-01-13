Return-Path: <linux-iio+bounces-14292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FAEA0BCAB
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7AD163AF1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C7C1FBBC0;
	Mon, 13 Jan 2025 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je725qdI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45787240225;
	Mon, 13 Jan 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783772; cv=none; b=PhIeQtuwP+6U/NSSIE/PtfgK49PkXNCnHAUq5QBWZlrqaTCiJ4Zlpf10HteUrnTxNOUEGcyJNWNrkT9/XAge8iCNS5JauKJMIPVmOuCfk+0Rm0I6QB+4bXT1OgSIzfTCQ9SFrJe3R1YMc0HgRBy6dVUAFNJo6pPxH8bVxn/gp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783772; c=relaxed/simple;
	bh=a+hKdJQRJlvZ0TbVYygHNWbgwTvmHLVJbHPDgrYsNig=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7ll0E0JxQHeDFaUjc3mutvqJwv4yMyz5ik3n4S5uKSZTbc5ndCBrZJlhfRynl2mQnHv9U57GFNDgqLlB/MuZKi87nfJW3T9X65JuTh9vihvO3eafGH/fMtLD1/Kd6eyW7jz6wTWZJ9ON5gm18Pukdg8LONnjA8In4BYLzJf4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je725qdI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361815b96cso31563225e9.1;
        Mon, 13 Jan 2025 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736783768; x=1737388568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ElAbJJxdmIe3RhGhz/WeyyLSlNZbEGlARt/QWOxqa2o=;
        b=Je725qdId3YiN8NgAQ1u0tRJkmO3/4IARvAF/xe6WDuh1dyyjP0tiPETPxGH9P9nea
         PTVYVE4vJXetaP1s0NrD1rz2YRqWBMobtsghpMJmNPcOJHHg+EWXY3czHSjNSEU6u19w
         JHw1cWiJcPBdVbzauknEmjmleQKclOUXaGa3jp7zyXnB/AZTSIeV16xPt+lCjtdjG5EC
         AqVNynxydD/TVBWQ/zbuwZOE3YgWVivFiMA6slY1ihSTFOaFqmuO9ifFAjx/kMKe0INy
         cZLutE5enh5ePiLr+NVyZs2Hab+ICfBgYbA4XWfUiTNRJfjRnFO+yx9DM2OfKlPu9I1k
         rN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783768; x=1737388568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElAbJJxdmIe3RhGhz/WeyyLSlNZbEGlARt/QWOxqa2o=;
        b=eOMCgX9eUg9Wg7VHuzrHetJQcqK/m7tVuxJUmAUSbQdQsWEU5YtJf6r+coMrBE9SW0
         rbcCGowl6OfdG0UefO6NSteP2/PKLALSfM/90DRO3+/77vNYwKm0Y8dBpK2HOIBljb+a
         9AdvQ5JFcilLhxuwPkdXijvjMR/d9PVQXlX+3zEK36kmad+VYcZfFB+cCJXunGZKDGjo
         3CNya32S+c6l2vWsKwdcKGHnogOK/1ATqeO/9VFBozhGH34vofco9BgSJl3BIjkHZZZf
         M3DkebwBgV6khU4HmtQAGUtHuA3xHWpeskSFCDqxKN0rjRfSL+Im9f7eIhHv427NiCDU
         4qBA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtulV3vnn8wd87E5HhXE0eyHzQ1HspUkWCP5Foj0jXrznIOpgiAScHjqkmlMBr9gG9zprBujIYow=@vger.kernel.org, AJvYcCUn2enLRsvJeLcPxvCQi6cYfl2Ddrl2gHNlpPOjVpXHbV1S65+4nbZR+9LAfHXhLW6YiaYEuhd54rgWa1mc@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhU6FdStk7ppVmRl9R+1TWoQ+uAWbLnjd2U94kBJjwzUJwuEm
	preLNMl/9ImtowzKY08PVNBDMSJpkDK42XOS0LbiwKAZv2hKjaJ9
X-Gm-Gg: ASbGncvRfAcZYXYwdyqMJpCe0ifQo+urc6Fpn5kr4Lbj6+2Y60FjRzng8OmmdzDbOrC
	N7Dpt26fWQt0fO/Faz9WqM2ZXPSSdedozi3/6evJnCwoEq+NqFjpM11ubSHbmGu9SQ8h5JG7Ca8
	+hh6BZDRaPvpqwrLfhyqDopV3209qicoaCoFCtn9MR6gucUPXudaqo0552EuN6ffjwv6hQtMkWd
	wAT+ijYqhy9iKwmzfv2S6DiAI+CsvJuL4wnjBtAXKwIpvBVSufVqJnhhuNjdTMLWUs4ALRBEySZ
	mKXBY4FHCWOl+6P7VUJ0cAz/z/te
X-Google-Smtp-Source: AGHT+IFCB512DFsnvB8ysRw+mA7xR3siYJsI/byNJUYdFjiQqiy6XGWwVo0TGAv3tYMKArADoNszRQ==
X-Received: by 2002:a05:600c:1c1a:b0:434:f2f4:4c07 with SMTP id 5b1f17b1804b1-436e26bd126mr206796805e9.15.1736783768282;
        Mon, 13 Jan 2025 07:56:08 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d090sm12399279f8f.2.2025.01.13.07.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:56:07 -0800 (PST)
Message-ID: <490b530b737cf2fb0be4830ae4f368569231df79.camel@gmail.com>
Subject: Re: [PATCH v3 1/9] iio: dac: ad3552r-common: fix ad3541/2r ranges
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 15:56:07 +0000
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-1-ab42aef0d840@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-1-ab42aef0d840@baylibre.com>
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
> Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
> rev. C, table 38 (page 57).
>=20
> The wrong ad354xr ranges was generating erroneous Vpp output.
>=20
> In more details:
> - fix wrong number of ranges, they are 5 ranges, not 6,
> - remove non-existent 0-3V range,
> - adjust order, since ad3552r_find_range() get a wrong index,
> =C2=A0 producing a wrong Vpp as output.
>=20
> Retested all the ranges on real hardware, EVALAD3542RFMCZ:
>=20
> adi,output-range-microvolt (fdt):
> <(000000) (2500000)>;=C2=A0=C2=A0 ok (Rfbx1, switch 10)
> <(000000) (5000000)>;=C2=A0=C2=A0 ok (Rfbx1, switch 10)
> <(000000) (10000000)>;=C2=A0 ok (Rfbx1, switch 10)
> <(-5000000) (5000000)>; ok (Rfbx2, switch +/- 5)
> <(-2500000) (7500000)>; ok (Rfbx2, switch -2.5/7.5)
>=20
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-common.c | 5 ++---
> =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 8 +++-----
> =C2=A02 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-
> common.c
> index 0f495df2e5ce..03e0864f5084 100644
> --- a/drivers/iio/dac/ad3552r-common.c
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -22,11 +22,10 @@ EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R"=
);
> =C2=A0
> =C2=A0const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] =3D {
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	=3D { 0, 2500 },
> -	[AD3542R_CH_OUTPUT_RANGE_0__3V]		=3D { 0, 3000 },
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_0__5V]		=3D { 0, 5000 },
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_0__10V]	=3D { 0, 10000 },
> -	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	=3D { -2500, 7500 },
> -	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	=3D { -5000, 5000 }
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	=3D { -5000, 5000 },
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	=3D { -2500, 7500 }
> =C2=A0};
> =C2=A0EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
> =C2=A0
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index fd5a3dfd1d1c..4b5581039ae9 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -131,7 +131,7 @@
> =C2=A0#define AD3552R_CH1_ACTIVE				BIT(1)
> =C2=A0
> =C2=A0#define AD3552R_MAX_RANGES	5
> -#define AD3542R_MAX_RANGES	6
> +#define AD3542R_MAX_RANGES	5
> =C2=A0#define AD3552R_QUAD_SPI	2
> =C2=A0
> =C2=A0extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
> @@ -189,16 +189,14 @@ enum ad3552r_ch_vref_select {
> =C2=A0enum ad3542r_ch_output_range {
> =C2=A0	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
> =C2=A0	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
> -	/* Range from 0 V to 3 V. Requires Rfb1x connection=C2=A0 */
> -	AD3542R_CH_OUTPUT_RANGE_0__3V,
> =C2=A0	/* Range from 0 V to 5 V. Requires Rfb1x connection=C2=A0 */
> =C2=A0	AD3542R_CH_OUTPUT_RANGE_0__5V,
> =C2=A0	/* Range from 0 V to 10 V. Requires Rfb2x connection=C2=A0 */
> =C2=A0	AD3542R_CH_OUTPUT_RANGE_0__10V,
> -	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection=C2=A0 */
> -	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
> =C2=A0	/* Range from -5 V to 5 V. Requires Rfb2x connection=C2=A0 */
> =C2=A0	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
> +	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection=C2=A0 */
> +	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
> =C2=A0};
> =C2=A0
> =C2=A0enum ad3552r_ch_output_range {
>=20


