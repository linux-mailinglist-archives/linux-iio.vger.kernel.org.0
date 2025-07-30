Return-Path: <linux-iio+bounces-22154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96DB165BE
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 19:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEFA3AD06D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jul 2025 17:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE332DA75B;
	Wed, 30 Jul 2025 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aSYP8dp4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655A1E008B
	for <linux-iio@vger.kernel.org>; Wed, 30 Jul 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897621; cv=none; b=sWzvbB5D6OMvZeOPza2mE9rDplNGmGdeldG/hxwq9Ziz7jM6oDpCe/HnkFRq8jgewafaduDdQyWECPV/5tW9o6cmXqHm2TsE9AVPvgWpfdVnOvujG9V3Wzy9pVifMhFTQjujo3IESZ08isnQnoj4dHQRc49l7IkIhj5qYnWZlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897621; c=relaxed/simple;
	bh=vstGY6DbCgcFoC3+TZn/4Uvo9/0rT9LK56HOh16Ijnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJs1AXID/cgJ2exdAfe/vkfdI9E9zlKc0/rCa821Bkq2NX+I0UHZOtsd8oylz4L/j5Zssu3ec4LjmcJtBiF4FdN+5VqOojKrm68BY3VJrSssdTPAzFPLOsiKfGswatSjhIdOwck7fMU3JXxd1wiEkl/PKKgfb9Nw2opWLhAp+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aSYP8dp4; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-432ae3781fcso27100b6e.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Jul 2025 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753897618; x=1754502418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8BafCbJzq5iIrs0nU1dbhPScQLFmm2TElBkzFfqp0o=;
        b=aSYP8dp48hPZ/NcismDANvc9+QvmHsBp6o/gyzThtPku+BQ1RHVKaZCP1KL2kx1pa3
         QTveOMXHLgZgJ/KrWcFvibWZaicm5fioQIFGF3qrOwEwcc/KyD/EB20OSXJWKSM9hbYa
         gz7hq5iFnpVSZatyWdDMk/Fc1ezToK9HRkvBNJ8REUgGzMMUy1ygTVRTISJu9zvGP8nN
         FUZ7Rk5gWpdIdcaT0k0SkN+/3zCrds87qpiZcWeWIUCRMifTm9y5053y/b6RwnK9uSRK
         sltYVQ3SF/eRnv2bkX/ive+pI4OdDzzXyrVyREPUzFULNioaVn6kb+HYfxcDxd/wxZon
         erZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753897618; x=1754502418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8BafCbJzq5iIrs0nU1dbhPScQLFmm2TElBkzFfqp0o=;
        b=DX5Xg2HoE3Vbs9fVsP6eFVBctwMzdMwawExgnf5lBeBA6o4O4b2mhsSPD+3KTNJCsw
         3Lw4mdjgJUUpl1ToNyAOb1LelfhjAM9kUM/JTGWNhDpfPDrumI72zzU43PDxspD20KnA
         8ObPZxMPEPboRGERnMGxM/ZFqIAq3zY63opnQakgV1BnXsn0e6+NoHPSeWkiUBNCSYKo
         isBVeSUz8StaxTFShodqsji/kTARs4mUggJ9iliqSD0wcuY0H2nC+0+Zs7xR2RTH+Zst
         iH6oV1fqml6P0OFWp5exaIKq4hXR9XpE4MztNnjI2krbDHYGFve/0isk2sAj2BKItp1J
         WZ5g==
X-Gm-Message-State: AOJu0Yw+FuTMjlMDgDg7maDMN3Dma96EeO1/4AXooRZfNarA0Yeuwtj6
	A/CzOd4UZsnZmZ48Us7LteHzj754BB522lgCcqmV6HMw52zzYZNUkq+QXzx5JlHYP+k=
X-Gm-Gg: ASbGncsS5r0Qj1uN6XQU1ciN2OgBGfkkFnsOSaJYirYHc+8qdV7lhkQbol0NDkvtPVQ
	FBJ9rctiAMKQkGBm4GmxYOgYVxWM7LOynzf57KAr+TOkgKaRGGlpIvTqKmHxsgsIKUYMjsNoGpU
	7kezi32o66BKcLTRO4LDeGODNPjZZ46/bjLblLBqWU1cMXN/hHddrwpUxI7BQEH35yGoKJKBq+x
	onP6B+PhrBC8sLYPiaxTax807weQlpJUOTc4eju0qj7Jn6pPk0X25qMDNvAmti7PtiNoj1DLojK
	1rKRjOsfS7QU3bnQ2sQ0rp4OVYzsLrDNeTtvazQfStJGTkwuXqkwcuwh7x5Dd3WMd5WGbQ6B14E
	Ga8wQS3QtUI4urzVYsdBk/jvQvkFBc9dLekTc+0DgkHj+mgD43u4kAeEPF91aviD7DQt/P1fSV1
	o=
X-Google-Smtp-Source: AGHT+IEifJucP/eacVZAMP36FQVIR6gfU6jag+oTHFzJIvfA2TG+IFX/67SN9dFv6yILiPPBrkAEtA==
X-Received: by 2002:a05:6808:4fe1:b0:420:c2cc:ab97 with SMTP id 5614622812f47-4319b63246cmr2746868b6e.19.1753897617624;
        Wed, 30 Jul 2025 10:46:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1791:d65f:27a4:8c38? ([2600:8803:e7e4:1d00:1791:d65f:27a4:8c38])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-42c7d9b19e3sm2000488b6e.32.2025.07.30.10.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 10:46:57 -0700 (PDT)
Message-ID: <cf90537d-bdb3-4770-91f1-4039c727f7c6@baylibre.com>
Date: Wed, 30 Jul 2025 12:46:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi270: Match ACPI ID found on newer GPD
 firmware
To: liziyao@uniontech.com, Alex Lanzano <lanzano.alex@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yao Zi <ziyao@disroot.org>, WangYuli <wangyuli@uniontech.com>,
 Jun Zhan <zhanjun@uniontech.com>
References: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250730-bmi270-gpd-acpi-v1-1-1ffc85b17266@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 7:56 AM, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <liziyao@uniontech.com>
> 
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40,
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.
> 
> Signed-off-by: Cryolitia PukNgae <liziyao@uniontech.com>
> ---
> Some GPD devices ship a buggy firmware that describes on-device BMI260
> with ACPI ID "BMI0160". Since this is fixed in BIOS update v0.40[1],
> let's match the correct ID to detect the device. The buggy ID "BMI0160"
> is kept as well to maintain compatibility with older firmwares.
> 
> Link: http://download.softwincn.com/WIN%20Max%202024/Max2-7840-BIOS-V0.41.zip
> 
> [1]. See the update nodes in the archive file above
> ---
>  drivers/iio/imu/bmi270/bmi270_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index c77839b03a969f6f149c025a0305c4b9b8ac6571..b909a421ad0176ee414f2f96ff09db2297586ded 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -41,6 +41,8 @@ static const struct i2c_device_id bmi270_i2c_id[] = {
>  static const struct acpi_device_id bmi270_acpi_match[] = {
>  	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> +	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */

Is this supposed to say "since" instead of "sincice"?

> +	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },
>  	{ }
>  };
>  
> 
> ---
> base-commit: 0db240bc077fd16cc16bcecfd7f4645bc474aa7e
> change-id: 20250206-bmi270-gpd-acpi-de4d12bce567
> 
> Best regards,


