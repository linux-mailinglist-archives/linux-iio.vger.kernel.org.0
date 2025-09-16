Return-Path: <linux-iio+bounces-24161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2192CB5978C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050597AAF5C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A13191D4;
	Tue, 16 Sep 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVUJhPTX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3599315D2E
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029119; cv=none; b=k42hY8VkSJ6LX55OHehQLXQaFz0EraKfseJIawlmwOT2mVT0+KtY57+Gu/WrC8Te5iC2VUlnFk3mRpZJfdp5A/pA105Lda8Jb+Dr8ksxPXZtppUsWddkqrXdEifu49ZdNjH1uv6eFepoQwNIhpQFECgFptfxehOrBUKoJikHeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029119; c=relaxed/simple;
	bh=PRpXH+sZjdebPpC4rWrrnPimJkKolPv4aO3TWAccum0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEFSoAD8kUmDCeJSSJx+y2tfuAnHRL4bGqrcL1ZoShH1tPQSB3SW3ABMBCAovH3iygE7yT96p0oosUuZ+TuUbeWExfhhaTK+thNOYdfMcligtGpUPqraZbHXd2PmipXuQLda8jBqfHsHVlHQkgqNIaYsabWPAE2FOzaOP0a8yrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IVUJhPTX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so776732166b.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758029116; x=1758633916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cec1ryxoXhXjrqFSDj+/T+n/YhygzPX418Utr1UQ+9Q=;
        b=IVUJhPTXbWR8QfUsBnQZUZsqv5OFAueWaiCO4FxXmaMFpwLs7Pn4IJfZI02C64cAwC
         +RgPjPf/6I3Oinz0CfZfrNgP7pN061/hDfV7X9c9YjDJNJ3ZMEY73YBuR1O7zk2Eh+q+
         PWWlULY8Z1Otvpz9z8SeD1zIryMmxf1/sOo/IY5drClwgKZwHO6GFxoe1kHpwzZhjccK
         YvfRAHeYHblSiA0dTjjrXZ5VN9WoI3/KH+ADNaIBupDiMGgalOrgDpeTyLYRt//VNlPX
         UXAuNW0mj1WnYYNdx1WB4K6sho7+aDhccOu5MqHlHEnHxdO9hQUctqvXimcR7o+I+9IH
         08AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029116; x=1758633916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cec1ryxoXhXjrqFSDj+/T+n/YhygzPX418Utr1UQ+9Q=;
        b=PEgJ7hTqTIVEBheY6iD/cjLS+SLNXOt3KeEP32HwOctKm8wZHyUp3YB5jvh5ud1KKK
         m19qFOXlTMtS0HnKjRnjhSITysmEGizG/8k4riT+ZpMWHPHZ4hXBu9P11LC0N113JIWW
         K4bvN6rfo7jY86aKK+MP+gdIWoaOP7LQrPcM6sKpb/5C+gs1yH2dDb8MfW6baGpzyi6r
         5Gil4ldzMR42dRsv5gIR/ahF3+1ytCP/gUzvzYT0yAVvCmTnNSfOaEvE8bOSvKqDsIN2
         bmaz48fXIsq3KxfyvNKJ5i/t2f9a6P4q8lToow74xpRcKngCLC7aK16pq3/t5y8x735/
         dBrw==
X-Forwarded-Encrypted: i=1; AJvYcCUfGAPsaGQKHZFmO9eUOY1gKB/Nx+b/IDz5B1hflaFfb7UD85z8z1Y8UuJSEtJm+4JhyVT3GGD7LPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtufFBnbDwgMZfqOHqXsieZceGFzZUGNQJo6PyZrZGttgUZ91D
	PK6gRRv075ZjmFUes3EYJuz296T8QNbWAsd7aiWDD8w6rI0SyZtcvUS6d1/5Lexy6Xs=
X-Gm-Gg: ASbGncuzEdl6Rrv52DyP272xB2oWPJ22EkF7qqeRb72C+lSoi7Codi6gAmZCK68PHtR
	pMg7M3OxyYYpEF3d2dASSipdxU188EZ2MPcmgnvVimo3K2KkR3wxaZZxAjWeTqDSnHGl263X1ma
	rJDMEqhnmq7N2Yfy16b8QKcMriAynGFDTfR4JbGvCdVkihjNNpf0UkyEEMMeNZgXatA8A520g2a
	CB428g19IhS0/eylq6f6T9sUBaUQlO5c9LU+72ocJN0BvQIwHYr+GESdYxnalVHiR4p1VhF3dZT
	jta/yqVijjmW8uJvvQVeHXoXHj5fIEbQwmaeAkSjDXoojqsFhT8dSq6hvt9eXAGaZxfMj0rfY0g
	hi6Vkn6ke5miu2RdE6WZnQMsufbrE932K72G/A3YoBn+rHbd5O+XUGKBDiks7l+AWzNSf+SYswK
	E=
X-Google-Smtp-Source: AGHT+IHULzH6kKOXUPbwiu6vHARKbboHWXDMpcq23vOfkgCUTSIFoBy+/FHZDfo4eSTeHnxRnGrBPQ==
X-Received: by 2002:a17:906:eca2:b0:b12:3f5f:603b with SMTP id a640c23a62f3a-b123f5f70c4mr542368966b.3.1758029116046;
        Tue, 16 Sep 2025 06:25:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32f35cdsm1135878466b.92.2025.09.16.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:25:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:25:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
	srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org, 
	krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
Message-ID: <mr7gqhvom5soofn2oujzxtsuczsnx2yizkushar64cojwnvhd6@dt64ojgjqdxw>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6v4vfa6gjhs5clj"
Content-Disposition: inline
In-Reply-To: <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>


--j6v4vfa6gjhs5clj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add()
 and devm variant
MIME-Version: 1.0

Hello AngeloGioacchino,

On Tue, Sep 16, 2025 at 10:44:39AM +0200, AngeloGioacchino Del Regno wrote:
> +/**
> + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
> + * @sparent:	SPMI parent device with previously registered SPMI controller
> + *
> + * Returns:
> + * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.
> + */
> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
> +{
> +	struct spmi_subdevice *sub_sdev;
> +	struct spmi_device *sdev;
> +	int ret;
> +
> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
> +	if (!sub_sdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
> +	if (ret < 0) {
> +		kfree(sub_sdev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	sdev = &sub_sdev->sdev;
> +	sdev->ctrl = sparent->ctrl;
> +	device_initialize(&sdev->dev);
> +	sdev->dev.parent = &sparent->dev;
> +	sdev->dev.bus = &spmi_bus_type;
> +	sdev->dev.type = &spmi_subdev_type;
> +
> +	sub_sdev->devid = ret;
> +	sdev->usid = sparent->usid;
> +
> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);

If I understand correctly sub_sdev->devid is globally unique. I wonder
if a namespace that is specific to the parent spmi device would be more
sensible?!

> +	if (ret)
> +		goto err_put_dev;
> +
> +	ret = device_add(&sdev->dev);
> +	if (ret) {
> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",

I'd use %pe instead of %d here.

> +			dev_name(&sdev->dev), ret);
> +		goto err_put_dev;
> +	}
> +
> +	return sub_sdev;
> +
> +err_put_dev:
> +	put_device(&sdev->dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
> +

Best regards
Uwe

--j6v4vfa6gjhs5clj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjJZTcACgkQj4D7WH0S
/k4DDQf9Fn1HPf8O4u3moGauabP4ZoOg+KJoOMMHiL4JAWvb+ihWLP7SpGDPBfiO
DjMRfgEltRK7S1XHVZqjpkIAREqaRc6TQCYX7uafwyX9JXpUGPvjoVWeywhnWJU3
5vE9b9lEeFfiRzBq8RQ0tr17GyPpmviyXdL6kimCDDWkKzCqU9mXskQiO/HYxzDV
mJBLPPQQ6aRxVVBLLqdsggxptBQ+8BtkqUy9+yqjncsbYTwEgj4QY65d9yQXPTgL
st+pYh7Ra8xceTMOExplwPHN/uSqPBTMTRomAsrtOz09tETIkR6mOuEOUO3fsy9q
v/FjPX6SlBekOqw7TnPDq/t/204YwA==
=j8SY
-----END PGP SIGNATURE-----

--j6v4vfa6gjhs5clj--

