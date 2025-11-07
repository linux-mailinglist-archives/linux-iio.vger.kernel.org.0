Return-Path: <linux-iio+bounces-26041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F5C41C06
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 22:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F86427EE2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C332D7D3;
	Fri,  7 Nov 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qFE+UGCs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808C320391
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549805; cv=none; b=kiOBtKY1t85zeA0vJLercUXf3f8QqGbP0BCEO9lG8jAkSC3YdsQVAObv7mRBcuARjwxpecSt45mQGXfIfOQHzlxOSeABCLU1FrGT/gco90g5+rFPcTGrOMqxUdDO5kRbQ18poXV0YeSlFmn9SMM99vCpPrsm/5qD3sdaEsYFaM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549805; c=relaxed/simple;
	bh=zIMMhU08e0AhUMrxZVFeK23QuEqKtkjM3A1gejF0Vds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgEDxSIWp4UDl1SDqaRs13gF9DfQpil7S8yAozgpmlOwkAnu2XGNjcmNJT1J690x0ijeIAKRktAwS47AVboh8UxiOJPLBG5WorXKINIRK6piyvIPUb0p4YP8+5Q9OS811LM23P6WnArRh08FpudLl3tFtjdar22wGoXHSfmrwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qFE+UGCs; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3c97813e788so720238fac.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Nov 2025 13:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762549800; x=1763154600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5C+80SdGLi7QO5N0XFDPLF3yCCePwCkQlTQxlk0Flw=;
        b=qFE+UGCsS7sLrf45Ycr/RRti3fxVQJPDhV2YJAJOToKeg8p3F68H1bcDP2BLwlLW3G
         NHAiAFVOLObjapldX/6Kn4WgYDVlqzhl/nIv3pxk6OEP0luzgz1MhrcOMHdzDpTjJyb2
         Nu97xm94PaVQohmMgTBjGfWk5AqY6nTadHO3juMRL5MKia3T2WXcGDk3FtzHQVFXB+ud
         ukE1GRzlGD8KDcvtMJjFqBjQ3u4UdShkw5+K9wJoBuUibNzZOyNEg772cp4Cn5jxkR2c
         0tgO0nKKdLPuUKAoXs+PV2j2GMI0fNvQ4gUpRj3p4iHG8SstBLJsGkLOvfQI9SzaiauK
         g8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549800; x=1763154600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5C+80SdGLi7QO5N0XFDPLF3yCCePwCkQlTQxlk0Flw=;
        b=oLo+sJMgoh3YT+RBuwYB6UOhaDCsJj54Q+NXcD15CqddH8BrocC5iGTFHfazS3Y2u9
         r8tDhMkk+f4VYbza6BG8s9KANrj0BIvqsy4rk2GuMV7c/KX4xIVEyo1tB10Wp8KA/Uey
         LXkxaBNRUO0rc6IQGx7gyN0X9drRfhd9R6kQ/08JgTX2LhXK025N2ysoftrDYbdXZRjB
         fJgSx2sqHpkuIZOIHuizEUBl+3RYFzAgwRTyPGx4XTIxLjSGuRqNOw6R/566Lf1EPifF
         s1DHv9mkaGLF4Z3ddFE3styDHIEzShvHwd1hnYOEKXkGSZstfybqEZtw9dS7+Ygd9Xii
         lpqA==
X-Forwarded-Encrypted: i=1; AJvYcCWapt64JI+jvPhlmG56+PrvOMsjmRXylnoy37SRP9bhMUG8GqWx2OmGZsijc36gXse92dhKRpM4ZqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8ltFKE9BjY24LLpfaPg7gzj2DiJWtTKbJv9CvTlo4THz1nM1
	DtGyGfELlrPA7wddoLHy+LOUKwYoOBfKaarB9TVrEt95W1BQ9WIvE+ADYngRWH0WAkY=
X-Gm-Gg: ASbGnctXwIoLA4fbl6h9uNTHSz8yoWIgV3AiPoAaDMqH56X+5LtwI3azCYPYooccY4z
	yLhj6it++qzzIqVG0xc9oJHr/fAlJstZDrreGMmp52h0pMdF+d81aNtMnLPokWEB02JHyaHGAwy
	q8Vhi1Amj7CfqR0mE3nDExPuS9PpxzO3Pk02+Ws7s2ES86/qKn/8V+d9paDLjHcMu5TFLexXTFA
	dWjUDq9eay3ST3ugTcMTfhEVO+QZvnqgf2JB0mkfQivKBR6Yh+o3QYKLNeHUszuWA3jJ0tzpQix
	lAxpeZTRZQfyYNEFtQu3zK5R1nIsV/X5Su/Fc4nHFbQX+VJiP/yATA7pL5mdMBvgB7xZrXuyxfz
	aBZwODUCR2BS02UFPBCK/oHVY61pg2+Zlf44daMVm80tsJQ8kqoBrNfA+plOf2r4/SGtqK1yUAX
	upFNKPad9dO8ov3colMnsKbr3OhcgbrbGoG7+0v9+QJRVhkSl2sl0LoT9rU1uT
X-Google-Smtp-Source: AGHT+IEQ9ejL+2ENcC9XsVRhLImuzZ+9b4tsXdGn2sN6c46sz5ZWDsXEvMKwQS2aRvyWRPmKUjbTWA==
X-Received: by 2002:a05:6871:28a:b0:3d2:a718:7b36 with SMTP id 586e51a60fabf-3e7c24e337bmr535332fac.20.1762549800616;
        Fri, 07 Nov 2025 13:10:00 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:7bb8:950b:327d:4ba4? ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41f2557a1sm2394214fac.21.2025.11.07.13.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 13:09:58 -0800 (PST)
Message-ID: <fb4aafc1-dbfb-4533-b368-5d26e24acdf1@baylibre.com>
Date: Fri, 7 Nov 2025 15:09:58 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2/6=5D_units=3A_Add_32-_and_64-bit_sign?=
 =?UTF-8?Q?ed_values_of_=CF=80?=
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
References: <20251107201005.3156118-1-andriy.shevchenko@linux.intel.com>
 <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251107201005.3156118-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/25 2:03 PM, Andy Shevchenko wrote:
> There are a few drivers that want to have these values, and
> one more known to come soon. Let's define the values for them.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/units.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/units.h b/include/linux/units.h
> index f626e212d4ca..5b3293bce04c 100644
> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -21,6 +21,12 @@
>  #define PICO	1000000000000ULL
>  #define FEMTO	1000000000000000ULL
>  
> +/* Value of π * 10⁸ (fits s32 or signed int) */
> +#define PI	314159265

It isn't clear to me at all in the other patches that e.g.
DIV_ROUND_UP(PI, 1000) would be π ✕ 10⁴ (rounded to nearest
integer, of course).

Calling these PI_E8 and PI_E18 or PI_x10_8 and PI_x10_18
would help to clear that up.

> +
> +/* Value of π * 10¹⁸ (fits s64 or signed long long) */
> +#define PI_LL	3141592653589793238LL
> +
>  /* Hz based multipliers */
>  #define NANOHZ_PER_HZ		1000000000UL
>  #define MICROHZ_PER_HZ		1000000UL


