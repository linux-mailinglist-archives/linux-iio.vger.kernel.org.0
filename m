Return-Path: <linux-iio+bounces-23006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2523BB2CBA6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6771BC7EA6
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC9530EF89;
	Tue, 19 Aug 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agkZ4HtD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024F30DEC5;
	Tue, 19 Aug 2025 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626787; cv=none; b=XDd/K7ypZDzyHU7yetDmsDy3k34vx5bJP04ToZqyWKADO4gjR33tFx9neH+gy3FWYTA2cc6KAl/nkYR1pyXtmKhwgLWGDhbkUce5TBCjQe6klmvuKt9d7+fgEEk0B117R0choYt1pmsyQ7IO26r+/oVog1GkNEqEUv7YPP0nqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626787; c=relaxed/simple;
	bh=WIRstsSxpm2MbT9lu4EaWW8EubQ97pqUS0J8zPc8Qq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckQokgdY4nd6WHSRgT5Wc5248EdirwjivocF9XAvKAs3hR36wX9xIGW7qy2mlvjSWALRiAv4K3mwhN8Sb06kJVzMoY1V1pjXwbg47vhlosFnM6kc5ZYfG7MOpfLsxoJKtjILThkqzP7LCuD1slWkyCbABjXS4U+kRrolarAbBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agkZ4HtD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581c3b43so49543815ad.2;
        Tue, 19 Aug 2025 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755626785; x=1756231585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECxKHBfMHQMVPtUnV2mXt74Z7LQY9m64sURj9vYrUE8=;
        b=agkZ4HtDgJy0fSgUDRRYrS971JNpUPffwM+sah6uuT+YY0pyPBONaXpUTIY4Z2rNVQ
         qFq/0/GOzSRdIWaA72uhnqMm4EyIkp6ONPA4VmGGXDgKSesFL7s3lfOcjagIPOayeMsj
         yadhDj39XMBGV+UfJf8sC4HFs0gsuJ+4UfBwjT2A2TG4mpyVv+PdQks5LSMZoA+9KwVG
         am3uVjb84ED46ECuDO9Gkh/Mq3iLWThvEQvwAOnr2WiEHfCCVTHDX2sxAbkte9PEg9tK
         4K+FnSbtV7I+d7ZMaPDpsMSFNY4/Zue1bFUp/xTPfm5x/O65zriRaUbdrgszbHHwK4QH
         jvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755626785; x=1756231585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECxKHBfMHQMVPtUnV2mXt74Z7LQY9m64sURj9vYrUE8=;
        b=KggAIq4R3CiZhEjkpBSnpKCsoNWDG6VC8kPJXiTarF/XOquZN8Xt1rASqTHXtuocQZ
         6wg8WjeS8cmN601d6zzEWxv6Omvsq30yuaZwahaaTKmJrVRb+11VUzWnmIAIRDLKyKZJ
         zYsnIv1kE6xeNnTs2/tzQEtgVGrwEvnjIy1ShspN50VGl+MzvtQqaNWIJ1Ph3Fny1w3i
         Xu/XTeRmGB2TW1I2NsHfFFAZD2dfk3BFrmKjU63x7nM9m8EqDj4D7n0KWVJ1is6AksOZ
         Vg1XFbWK7ImCn4Mk3lho6xU8uUIO7lRjyAl3mOORtAH9SPfVhmoX4MPv7HLW+MBrFrQE
         jm9A==
X-Forwarded-Encrypted: i=1; AJvYcCV7tqacNyKnPKrLVE4Vhu0vfOj4m1Aw289OnG9Xc5xU5E/CvqN+HhiSf+GT0oAP4MCfrHcXsZK+FUqc@vger.kernel.org, AJvYcCXzSQ32DxfnrSu8uoS9EL0qHyWajyA4zUnTKwAT4QtLNqRdtTkmYqlj/pKs1wC7hXrt+vHuJC+BTPaLgWS/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbj4lBTZavaKByxVBkgvYyYGseOrirROfqgRf++E2fB9pnkrBN
	jUvLD/FNEwPm6cSCkbdopFvYHBLT8ehQeXG0lMleAsh5lSA454XZacfm
X-Gm-Gg: ASbGncsqkhQbIK5ByVf2c5WMK6L7tTWcB+nSHvUs4PKj2r81vLMOWiE7Tq8uED0aarr
	nFI8kuqoo6+tXjYlpV5jczkNAmtatSUyo7yKeLXK9hCx9Y3DpeYDd+Aae1ToF7ehiNrTY6HR9XY
	HJFniRuX24CSGMAkNDexQjXq6Q3c4mWsJsTYzH4AG7xGeao7goQtPCT4yFEKlnn2shKuEY75UPm
	GWoBsuybAtelAwdKHXy1Jm1lGDmNRAulNADwKpjmOi2u1sw1VSyRzskOY+F2ljBMjq08fpbYK9+
	heDo+87j03nkY6D9JmZ+m9R+8RLv4zek+CE73/SUzCqedSvHKyD5EMrajTaEf0xcXVei/FYIl84
	b6XLSoiSI+ouPHOUaOxok43f4htadOq4=
X-Google-Smtp-Source: AGHT+IFy60UZbrVGD1Jhxweii9JhT3RAYDxGSzZd6faYcE8ea186XcaTrq5UPFL/565plxBib0YYCQ==
X-Received: by 2002:a17:902:e849:b0:240:7235:6292 with SMTP id d9443c01a7336-245e04ac7admr63995635ad.39.1755626785160;
        Tue, 19 Aug 2025 11:06:25 -0700 (PDT)
Received: from localhost ([2804:30c:2767:3c00:70b9:40f2:fa7f:19cd])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed358c86sm3533245ad.36.2025.08.19.11.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:06:24 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:06:46 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH 3/4] iio: adc: ad7768-1: use
 devm_regulator_get_enable_read_voltage
Message-ID: <aKS9NmXgD1Sm7OC-@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>

On 08/12, Jonathan Santos wrote:
> Use devm_regulator_get_enable_read_voltage function as a standard and
> concise way of reading the voltage from the regulator and keep the
> regulator enabled. Replace the regulator descriptor with the direct
> voltage value in the device struct.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

With David's and Andy's comments addressed:

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

