Return-Path: <linux-iio+bounces-21239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E459CAF5A9D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B107D4A5666
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7E287243;
	Wed,  2 Jul 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSKN9Ziv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E73219A8D;
	Wed,  2 Jul 2025 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465355; cv=none; b=eqRIlqqftovnqIld64p1FDFZc9P+oL3yTbpLPftJOA15yH3zKjpUOoQ+MJh8RQ7G32MRbo+A61p3HMWrTaRb7BDMsxwCr7XQN+P+1VcjdNgHaB/H3DUfx2B8Nk9F2nSTvrTmpHj1CMWN53uagJGhSsNLAf/mNX7h41zOPc4B8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465355; c=relaxed/simple;
	bh=/avcs2ZFacA5Jv8N3tfWQw5bFeQVPJ6m/fIC8JJLjZo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0aI/UikfzMU41Qo8VWk6kjSnd4yEcpHiVGl/o0oBt/8b1I0xyitmABTNRRu1afyPgWW1dbomo5Nn0uZ6sl2GLARlF1KCwnwg3cMX9CMsMv1UroycATdU655ZkIiKBPKAPgd59FnxvW9uzf12l33tYJmlm5S3vfCvJ1Z1DkVGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSKN9Ziv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453608ed113so45684335e9.0;
        Wed, 02 Jul 2025 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751465352; x=1752070152; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ne1az6UUsk9gtwsk+1Aq7n+cj83AsXUX9YNE+wvmdrI=;
        b=MSKN9ZivD1qYoMno+m9Fk7fJY1k584GQ2D8n+lGyw+Zt8+Qnky1zNEa2wtqzk+fwDI
         9SgJp8/h/q4zC1LdZwQBHTXSuFOB103AZ3ktOK0OXrEoNEzXOHu71oqib8DYJH08aNnq
         raSGtPTln202xGUOYKoL6FNKg5P8HHzmktpjW3F8PXkN0RAFcNhDYOCVPrn9feVWV7yW
         aJ56CCv76oeMzYMdEubyzqoQGSh8CYmN3QLmsNSXXuFiBQ/VFzJ5ZUyV9sNsPNpp8UXW
         zHkm7Ypm3+yuYvKPuWFm8fd1O0NJLPF4mgdHm+o3CZLMgemmqMrgIs14tJcVtBcjZ5Jc
         LtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465352; x=1752070152;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ne1az6UUsk9gtwsk+1Aq7n+cj83AsXUX9YNE+wvmdrI=;
        b=fkkikqy0AQN4NehXxyfP4W1ojsmvRPpTVQSrX9KuallWThyEKHGhtI4aC3FIdpWG9d
         iJyTZf4wl7Row5LqPnny6gCkXME4HDJjCZsNnRkoGPDRN3Ea9blpU5SXdC2um+CwOIgh
         5H8ppfYh4NIdAro633OFPSZjax4oaBXRby6+mBSnl2uBVNMLdiR2ljK1at+D6EUvB4dI
         OthdE4gZzJiip2LSkqPuMFYh4PG3jAyUueD6BEQRDUTfBTh559mIZx562NCuITeSm0cV
         Uy8xH9PRJ9Ff6nBA4xiMuGr1tbrgOjdkezHEEhYns5cIG/5SfnEefs8+vowdFDpRKWpX
         OOyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8RdgK5FHFcrIZj6lhPFJHkUvOgp/+eGQ8te5XvWsqzLGJvJnZqOksjI7+yiM5io+avwWVIJr1IWWiiII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/kGc+1leL3tu4oSYwSSLtksHDYG9dYmKdJquGbpKp95/9xHyC
	qsUpehhRzRuD/mR9ZA8pmfUeKi6B2X5vMtF0ybR3KVUamHq6FQb0haayeXhicm9q
X-Gm-Gg: ASbGncvHjnanx2NjpvE0RIkdlHUaNMygzEc+iy92hvXlOk1yDlryyOocVBUV48Bmfsm
	kQlfPUuDpxGWnH9oqj9B1cAs5sy79YMUwLIYw77i5mv2+/i4OIIjAd/+RZ8eM4gu/uo4G90Mhzq
	HAkYuaFivESxTlCFKg2MdJWvsO6vn3Y0oBdvqtKVbOUKaNumbPCK0YxUqnKvXoYjirdKEUzJWsW
	W6xVACrwUw1Gh/02FoZbDLoG7q0lYsdZFW6IJgBlYQ/eC4gFSf7TuoLUR3EF5R1aNntYQ8d/917
	fqV0QEQTght38Z/CQbiyMXf+FzVZ2fV3Zjv8PID6ZumFADAMels5ZIlRMqyxAjzKqxOTVg==
X-Google-Smtp-Source: AGHT+IHfvqPOShlX+f2H/UFhBgrJOEaNTZZIY+NLyl8y4bSFR/1Tbsy1xmi+nARlD5AdMLUAR8OPVg==
X-Received: by 2002:a05:600c:648a:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-454a37326c9mr41426045e9.30.1751465350229;
        Wed, 02 Jul 2025 07:09:10 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe28dsm200713725e9.20.2025.07.02.07.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:09:09 -0700 (PDT)
Message-ID: <e490200ef3498d0b9798e918a5a78ff429b004da.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad4000: don't use shift_right()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Jul 2025 15:09:19 +0100
In-Reply-To: <20250702-iio-adc-ad4000-don-t-use-shift_right-v1-1-041c2d6c3950@baylibre.com>
References: 
	<20250702-iio-adc-ad4000-don-t-use-shift_right-v1-1-041c2d6c3950@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 08:23 -0500, David Lechner wrote:
> Drop use of shift_right() macro for unsigned value. The shift_right()
> macro is intended for signed values and is not needed for unsigned
> values.
>=20
> This was found by a static analysis tool [1].
>=20
> Link:
> https://github.com/analogdevicesinc/linux/pull/2831/files#diff-c14a34a649=
2576d22e7192cc0f61ad0083190aeb627191596fe12462f0c6f21aR557
> =C2=A0[1]
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4000.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index
> 5609a7845b6f50b5818613170df6b234f8f0c496..fd3d79fca78581e51bb904d0bcfeda3=
d3663
> ea25 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -554,7 +554,7 @@ static void ad4000_fill_scale_tbl(struct ad4000_state=
 *st,
> =C2=A0	val =3D mult_frac(st->vref_mv, MICRO, st->gain_milli);
> =C2=A0
> =C2=A0	/* Would multiply by NANO here but we multiplied by extra MILLI */
> -	tmp2 =3D shift_right((u64)val * MICRO, scale_bits);
> +	tmp2 =3D (u64)val * MICRO >> scale_bits;
> =C2=A0	tmp0 =3D div_s64_rem(tmp2, NANO, &tmp1);
> =C2=A0
> =C2=A0	/* Store scale for when span compression is disabled */
>=20
> ---
> base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> change-id: 20250702-iio-adc-ad4000-don-t-use-shift_right-bda6e41152b6
>=20
> Best regards,

