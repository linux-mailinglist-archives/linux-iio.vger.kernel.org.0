Return-Path: <linux-iio+bounces-14290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82020A0B995
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DE93A3663
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105023A56E;
	Mon, 13 Jan 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkQX2vvY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AF3232;
	Mon, 13 Jan 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778905; cv=none; b=Um7BCnpd9MZxaGP0HpZqRBcpAa9qJDFU8q5T50kbh2bHwCtjol4A6F80ke+7lFcdWNz/jxysWpKUkrGQcyJZwTsctOeoVOZ7OXaPb7LneU43QuhbVdCSs0a88Fryc82MtOmyvJ6cNSFY6hMABdEmSwaJNYE4v+gqf5KhDoc+1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778905; c=relaxed/simple;
	bh=fmm+g4G9C0YGrg445ZbEejWEGQIW05+JEg4ujpxlVcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwbINMnzR5/w80UXwuzeA81dZTgxDHAmevRuCUQEvdb+znuNpt54aSe+zPJBnvCVokaqmQMJb/fFIB+y5VPtU4EpjWZVfUmRlfwazcIGR9T8iBpr/tz62eh7hYq0rjs3hSk7fAfCMEHlBpBn0iun9PQ22J/znMZUAlJTTojKL78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkQX2vvY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2267342f8f.0;
        Mon, 13 Jan 2025 06:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736778902; x=1737383702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JE/TcA/PePKDGSy3mSdMP0VuintwCB3gzx8giISURwk=;
        b=lkQX2vvY2kvI9pqQiBWl62yBFzgcyA3NRspj2wj/wE4gh+VukClXpTFmfeD5CgcTJU
         t0lbKVNtKKoKQpnTFYZLkwESyQsqS0XEnE+/Vorig6OwCY3GiLOCBX383b8KcKNbiL/a
         ckWjd8L3/z3etxYhkwbHudHJYLr14Hl8VB/p3j8b45NTRHXQM79JkhiB0Py8h8BZldXj
         Nyjbg5MTekSaKjUtcReWP2t1eQRiFYoxk74N2XPnFAKJEkGqhpqOgE2an/jn+lTiWI+s
         VxLdBBGsZ6Tyw7GJ4ZljrP9qZNy5ESGmtjoWbMiFOv6geOk9CEndTnxy5HJZdlCcgR8g
         hz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778902; x=1737383702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JE/TcA/PePKDGSy3mSdMP0VuintwCB3gzx8giISURwk=;
        b=TV4RdXPeWsSTv19i+c7qis3QPpECHS0/9ts5T42BVAzvJg0SMTW8zQLHkNwlmTmhCe
         dxQe2BGmnbCDPb4ZSUA2drh5+t//SItA7e26PMUGW27TF1gOXgbCMCf6UhHk0HXciYlf
         5z0CeQMt+PpKL2gIaohwkR9VGChpaQOGoqZCM0gBoaDQZ90FXE8gda5QXldA4sZYdipK
         D9Xt9gdFDU/ZVAU/nWPTX6+ZEhlpQdyDsMNSWexJEI4opWG5TZWU0By4Y4kdDY4V03dh
         B5KyC9hY9kv1jEbt+2m88HgTfshTPXk0ZLj5TGVKdKerzVS02I6OtF8YhW+2tOG+QirF
         hFew==
X-Forwarded-Encrypted: i=1; AJvYcCW/4Kx7XipJ5C0DiNQmgJhvfKAmikKJVYW4utBT3QTSAjQQtpVMt6MR86XveahOT2f4Nc1dzkRj6g8ftdOY@vger.kernel.org, AJvYcCWsN41MKa+bGFJahpcB8pejfrk2bvGoub9vnlv1iTUuk5w7188oVlikUEH2wmrwbO1+Rh3w0azh8ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxraoZoozHoz3sgwIWJFAXQhvNqFtFDsNNvFIQKTMNuSsk3T8L8
	4BAm1fwHaONJs6W8O2NYGXbKds2bSmQ5PhVpfixJeBpzHpWxRta/
X-Gm-Gg: ASbGncurCI+zCTsyQ8YALWNXa05UoVmLyj+Lm0qP+5PWXTkrwcexoNvi+8OKh7hztt0
	CqL8hQEbDVxe4FgP0AMWnJ1Nsn5CiuIlVWuSFx5RBYjfMTc1dtXvGf4RkPrak+q5vPFUKpoh8q3
	2dEsfhBCS2LeAWQasBIuw3Xnv5fVTEXGheNjIkfXjT/4nIuYAQoxT6FTHlFfmRjbLlt9/djMuGt
	LnJ45KxGrgL/R17he4fOHfRhWvzLQlL45XaHdx+t9WGHBTF1I2TmCmzDeU0K5E/rYBBSDJbBITT
	x+Yn5pkBoDCAjUbllBnE09LYBql7
X-Google-Smtp-Source: AGHT+IHGtKdLOS/PXHkSrC4XqgiY1L2U481ttauNnxmEBTWZ9vBhAiB3NF0dBzcNHtX+VtqGrmB/vA==
X-Received: by 2002:a5d:6c68:0:b0:38a:82a3:395f with SMTP id ffacd0b85a97d-38a872c93f9mr14362546f8f.9.1736778901390;
        Mon, 13 Jan 2025 06:35:01 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fba4sm146425175e9.4.2025.01.13.06.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:35:01 -0800 (PST)
Message-ID: <e3fd7f56675908a60d8ce6bcb6ad4f05b828e132.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ad4695: add offload-based oversampling
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Trevor Gamblin <tgamblin@baylibre.com>, Michael Hennerich	
 <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,  Jonathan
 Corbet	 <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Date: Mon, 13 Jan 2025 14:35:00 +0000
In-Reply-To: <20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
	 <20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-09 at 13:47 -0500, Trevor Gamblin wrote:
> Add support for the ad4695's oversampling feature when SPI offload is
> available. This allows the ad4695 to set oversampling ratios on a
> per-channel basis, raising the effective-number-of-bits from 16
> (OSR =3D=3D 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. on=
e
> full cycle through the auto-sequencer). The logic for reading and
> writing sampling frequency for a given channel is also adjusted based on
> the current oversampling ratio.
>=20
> The non-offload case isn't supported as there isn't a good way to
> trigger the CNV pin in this mode. Support could be added in the future
> if a use-case arises.
>=20
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---

LGTM, just one small thing inline... Either way:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4695.c | 333 ++++++++++++++++++++++++++++++++++++=
++++++----
> -
> =C2=A01 file changed, 303 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index c8cd73d19e86..0caaeaa310ed 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -79,6 +79,7 @@
> =C2=A0#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_MODE			=C2=A0 BIT(6)
> =C2=A0#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_PAIR			=C2=A0 GENMASK(5, 4=
)
> =C2=A0#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_AINHIGHZ_EN		=C2=A0 BIT(3)
> +#define=C2=A0=C2=A0 AD4695_REG_CONFIG_IN_OSR_SET			=C2=A0 GENMASK(1, 0)
> =C2=A0#define AD4695_REG_UPPER_IN(n)				(0x0040 | (2 * (n)))
> =C2=A0#define AD4695_REG_LOWER_IN(n)				(0x0060 | (2 * (n)))
> =C2=A0#define AD4695_REG_HYST_IN(n)				(0x0080 | (2 * (n)))
> @@ -127,6 +128,7 @@ struct ad4695_channel_config {
> =C2=A0	bool bipolar;
> =C2=A0	enum ad4695_in_pair pin_pairing;
> =C2=A0	unsigned int common_mode_mv;
> +	unsigned int oversampling_ratio;
> =C2=A0};
> =C2=A0

...

> +
> +static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
> +{
> +	int val_calc, scale;
> +
> +	switch (osr) {
> +	case 4:
> +		scale =3D 4;
> +		break;
> +	case 16:
> +		scale =3D 2;
> +		break;
> +	case 64:
> +		scale =3D 1;
> +		break;
> +	default:
> +		scale =3D 8;
> +		break;
> +	}
> +
> +	val =3D clamp_t(int, val, S32_MIN / 8, S32_MAX / 8);
> +

Why not clamp()? AFAICS, we have the same type on all the arguments. I also
think clamp*() macros got the same improvements as min/max() ones which mea=
ns
that using the ones with explicit casts are not so often needed anymore. My
understanding is also that those macros are not that encouraged as it's eas=
y to
go wrong with the casts.

- Nuno S=C3=A1
>=20

