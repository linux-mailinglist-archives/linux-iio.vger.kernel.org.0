Return-Path: <linux-iio+bounces-16806-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C98A60344
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 22:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1BC3AF673
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A91F4C8C;
	Thu, 13 Mar 2025 21:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhC8ko50"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E401F03E5;
	Thu, 13 Mar 2025 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900268; cv=none; b=sFkpVxUSC1TjJ6QjSFS4UsJzxm3hbJ5sN/asy4vzDwq082+uS9cdGp4SDk/pR1QkUYhQJVJTWXy73oOh/QAJNbMDQDgaFaEVXj6GjvripfkvoZJ5FnNjs1G/vXWjoJwDdCnoNIU0myHbIju8MMeMrqXANv6CsEzHIOuTbZkby54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900268; c=relaxed/simple;
	bh=6HZ2YTMBpk/Q9Cg8wMOfmtmm0pvwEds6k6sTnkPON2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=udp8TdDmIt64b3/YH68H+btntTfk/15+YtQzzSiKhEWl4KkKy5la0kuLwZrKh2W1eaiAzbNoiGk/H7aqpW8EXq6ey2BTI/JB8rSAbsyEZ6d+mo2Z35NTbwlLr3zWSeSBiPoiWzOqthdw6hBIKfh+5Xoz5l4hPjTpzqKgye4tHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhC8ko50; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso13258335e9.3;
        Thu, 13 Mar 2025 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741900265; x=1742505065; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6HZ2YTMBpk/Q9Cg8wMOfmtmm0pvwEds6k6sTnkPON2s=;
        b=GhC8ko50bmOwm7z6sm41CFGIc80Ar7zmM2eq+nyPQfK8ZXjczJEqNzC+2qbq7JiAYl
         4fGic7DYJtVuSwBC+c6pH0A4I8FN+XXqj/1GZ8NaKK1oROtZ6hGRVPAkxlP3gV49jc4z
         tfxqbw6z/n4JFfVkB+uPdnUV0JAKx5BmI2YqXVZk2csD+41wFpgrWKFofHRRLIpQR42R
         Fqr8hNkVT2vhBXMDux1fV9sS4YZJREIlYWM/M4IwllDQaPD2sH0sEvWbVRmyWmGGCk6W
         wrqguYnHGhAr1AzHprx0NJNEaLPIHnsZUjn/WnZ4edzvz0mcbp1tqfsokpi2cAqU3uSq
         J3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900265; x=1742505065;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6HZ2YTMBpk/Q9Cg8wMOfmtmm0pvwEds6k6sTnkPON2s=;
        b=CEAYKQ1MtylUvLiJuxxj/QxMLqeQMiv6BchZdaow8TuGKwE9PKLDCaiCJOLqvLJEpX
         phrJ7pY9arLCclae340HUIdiknSNqMISYeS+i3+/h2E5/21ScTBkLSpxwKnOwqcy4hYR
         0TYjDM+7OGqK2AibTlSPl5ii2wnryV0+FHFrQcctiQmnOlzFQZwZRcaF9Kxqu3Ss+UY6
         lcSCZvNV/F+1pVn5ihdjlV0YPjreqZEUnHLxkpwrR/oDMHHxhyMYmiA87eP7yam5FXEj
         45zgspFymSDuDYkUm8cijoSntkW51HCLEu3E+hFzqDh6TIoMA8+w36xbHPK4Z3YcoEhy
         +n9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtrxzt3KRBM6/6OXHGujUqgX/smf/w1NmTwonipCfmV61+P12iQEhkzERqc00EN6TGDevYLI0QhisYVVDZ@vger.kernel.org, AJvYcCW/hkaM36/iwZvH2hE381FWUG/P2nTWrrxGH92GmAXwDhzCt9YD2d4PBKcuf2O3JFfcdPtfBI152tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwEkDxoSBvQ2sa1St93i4CiXSu9MpURfy8SDwSUZc1sOec1yK
	thCDYklXQhmPvtP6Sk8IdtM7Ku2Uw6vW1qmOLL64HZai7wvHW6cDoB5aLlC5RuU=
X-Gm-Gg: ASbGncupyRYx4Dx0YXudtth3Yom5jClJ/hxngdSFvhfVGLCKyzlPW/tSVX5g3U61b+9
	n/Og87nlDBqVy1Big5KMBDJ7XA9GPNTCPOnN/0cMDO+XlpJDt+1kKodSb7+E6vMU1sTa6W2LFO6
	ZDYAOgCjXWEfWyVvjgtJvBg4bXYy+vDBpTYnjDQOZT6ymEbTzzuETSwhjvzlIbami7xui4Q+815
	89U3ku08gj6QTLpLDLYqFPNZ7uc7shGTgbRoKN0/IZzpWHfg8FjrSiND4FkKNydiwRe+7B44z25
	BGLHsIzep9o1dyquy412HY1hGQynm1phbOmumqP4vgVzp0eP5U43IEvFSGYNIVLVTg5HXul3IQc
	IScGnM9An9GlAohKteCyONPz63Hp4iw==
X-Google-Smtp-Source: AGHT+IFv+4Q/bw1LQKXtxs7Pd7TKMGokY73iqxAJMGTQJKKytpl/jgQinttGOfHBkAV5D2IK/Otx6Q==
X-Received: by 2002:a05:600c:1c01:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-43d1ed06ae9mr1053265e9.30.1741900264416;
        Thu, 13 Mar 2025 14:11:04 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2aab1sm32176615e9.31.2025.03.13.14.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:11:03 -0700 (PDT)
Message-ID: <111613449ea7effdcbea1c987c66f927182d8395.camel@gmail.com>
Subject: Re: [PATCH 00/11] iio: adc: ad7606: improvements and ad7606c
 parallel interface support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2025 21:11:19 +0000
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
References: 
	<20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-12 at 20:15 -0500, David Lechner wrote:
> The main purpose of this series is to add support for the AD7606C chips
> using a parallel interface. Along the way quite a few improvements were
> made to the driver which in the end made adding the additional chips
> trivial.
>=20
> The first 3 patches are fixes. The next 6 are some minor cleanups. The
> 2nd to last patch is the big one. As explained in the respective commit
> message, the channel data structures were getting out of hand and only
> going to get worse with the addition of SPI offload support. Instead, we
> are opting to dynamically allocate the channel data structures to avoid
> a bunch of the existing complexity in the driver.
>=20
> I have limited access to hardware, so I was only able to test this with
> ad7606c-18.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> David Lechner (11):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606_spi: check error in ad760=
6B_sw_mode_config()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: check for NULL before ca=
lling sw_mode_config()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: fix scales_available att=
ributes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: add missing max sample r=
ates
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: use devm_mutex_init()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: fix kernel-doc comments
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: use kernel identifier na=
me style
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: don't use address field
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: drop ch param from ad760=
6_scale_setup_cb_t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606: dynamically allocate cha=
nnel info
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad7606_par: add ad7606c chips
>=20
> =C2=A0drivers/iio/adc/ad7606.c=C2=A0=C2=A0=C2=A0=C2=A0 | 313 ++++++++++++=
++++++++-----------------------
> =C2=A0drivers/iio/adc/ad7606.h=C2=A0=C2=A0=C2=A0=C2=A0 | 171 +++++++-----=
-----------
> =C2=A0drivers/iio/adc/ad7606_par.c |=C2=A0 37 +----
> =C2=A0drivers/iio/adc/ad7606_spi.c |=C2=A0 98 ++------------
> =C2=A04 files changed, 211 insertions(+), 408 deletions(-)
> ---
> base-commit: 97fe5f8a4299e4b8601ecb62c9672c27f2d2ccce
> change-id: 20250311-iio-adc-ad7606-improvements-997d7af218e3
>=20
> Best regards,


