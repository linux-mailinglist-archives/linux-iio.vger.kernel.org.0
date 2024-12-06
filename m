Return-Path: <linux-iio+bounces-13136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE519E6CB7
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B813E166E8C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DA1FC108;
	Fri,  6 Dec 2024 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0a3KEWl/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156A1DF732
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483105; cv=none; b=fLpARmGD2Ua7O3zojibSFSulKqvImhhCXO0rZ28iH30VEkhIgkd/Jjv8n0FmQnkfh0Qz+5jjctLZQiS4/Tt3TjHRj7/J9ipDbhb39wuMgvlEKOannle3MHBOm2Mwm1tbk1AmnJDCKGcSuM59c0AcHzGstAC4PwTebs68gIgTvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483105; c=relaxed/simple;
	bh=VJfzdQCITfxK+kcb6i+L3yXEjDuawRiRx3u6iDtnX8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBaPwNHgFiok5PqZ3upRO0dy6raR/wmbk5N3pAOKQ8bXQje7bpfd/bdLmbbBaetb+pvRHn0pCJ0Ysobmr5QVzz4P6cjqIo6mEyQev7H1MR3a31Utj8eROyj1xguWwsaGnyexrO/IfMYlu8Y6xwnDWfDVCHjAffib6mUbBoncaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0a3KEWl/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso380480f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733483101; x=1734087901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJfzdQCITfxK+kcb6i+L3yXEjDuawRiRx3u6iDtnX8g=;
        b=0a3KEWl/DCieTvugoqZRUAktKFl/Xfbsvm4///Nhhsmzw/VcnjgnFGCnfZYUNZz+d5
         38dOHecnjl26/9cluM0x566DR8kPbc2pDXI7rm3LYa4v+W0HnDwVocD0Y8mzkRc6BBjE
         j8r2c/UYAcYcNIkRbxaeQAwCezJtH6Z8pq+gFdhZ6FagV8mJDz7z3AoDcN6bpVRYVrjd
         woNRDI5ieGLoqRc4d+XN6dGMaxvR5gFprr8NlAbQgmEq274K602fQWBhBrFTpkbo2qJb
         mCsgUndTwp/3HSRklZrpyd5EytJ/NTh5KkyJNlxVo4tsM+w7L2FWOXggDEiJgD0Qdv7/
         czHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483101; x=1734087901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJfzdQCITfxK+kcb6i+L3yXEjDuawRiRx3u6iDtnX8g=;
        b=Sfl5RrxGz1cE3EiSFDZ6w02swXhYlYmwUqncmwvfXEDxBFFkI3vkWtI4T3KizRo4rD
         8YfetCfmt7EoiqmYAuHXx4A23foQW+nPgnkuvSN+CvVyl36no1dfRnCyqkIVwPGZjkiH
         e+nrYDS0T5gSHmgdEArECxparPsps02jwpIFnjPR26pktB9EdWD06HJwuazjMP6acjGV
         +y9c5y2uqRiKKKN9xytstCGzb/yXFqh2Gyfo7jQSZNOkg/rEHEz9shTjx+FuDHITbool
         /exVNi4G27O0/Cc/O+LyD7iCB3nKLbJANnk1+b0DwAoVprdAT9x3ryRPmGs8wMeYil6z
         OtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhQM8TVPC5RHLXaw2/FPJHPc6Sa4RViSndqMUNhENutKuok5Oq+KR5Wwdm0LhaBYR/w/fLX5nwqJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduHCaAPzjN97ycS3r8bbUUIcQ/UDQ0Z/9/cybALA07cq/yYTp
	KJzL8OqUvQ1cdooHJj0bBgeTCzcyBfnEBOOebY+y8NwY+Crz6aFkahmfG4NvgoM=
X-Gm-Gg: ASbGncsrr52PG2xhiBww1WMMEmbyUvg9tszAN2SG6fs0hFso+/4LqKKL6lankydVQ6u
	ZD07wGcuMX3F5reEvW8SpOR8KBiO/h+IfX2UddsRt2hjAZGBmxXo0ai2xpDv0rAdThFQWk65iDv
	XpEvuAZtLVeJ6HN7IxONS1VKxDl2SDqeaRG0CgrNPC0ih/t8PxvA5AGPmwXwZ1FmqfyTji5ngBp
	0VMLlhQLSVUhZYDcDhoNXaz9+8V/sy8ephajxrVairgO4xObFHN2F7slvxEtScxMii+QQiayZF8
	HCGc2a6VoyJPdtttzWy6mEbaFxNUlmwHtYMu+Q==
X-Google-Smtp-Source: AGHT+IFqMVecOVbdx8S8LvBXPtirrgGqvV7eNic5AKNeJWVm9iBUMgXcfD4oAEm2IsB7jhyOk6RVHA==
X-Received: by 2002:a05:6000:2c2:b0:385:ebc4:1c62 with SMTP id ffacd0b85a97d-3862b36aaebmr2346985f8f.24.1733483101246;
        Fri, 06 Dec 2024 03:05:01 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862eb06e00sm710816f8f.99.2024.12.06.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:05:00 -0800 (PST)
Date: Fri, 6 Dec 2024 12:04:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Guillaume Ranquet <granquet@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
Message-ID: <7did4jkzbsvovlinkjimbn3zdqrwi2mrs2onukfonjeexnumvh@xbzcdad4v7kd>
References: <20241104101905.845737-2-u.kleine-koenig@baylibre.com>
 <20241109152438.0135f0c2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wqyzjtgfugywnrjz"
Content-Disposition: inline
In-Reply-To: <20241109152438.0135f0c2@jic23-huawei>


--wqyzjtgfugywnrjz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] iio: adc: ad7124: Disable all channels at probe time
MIME-Version: 1.0

Hello Jonathan,

On Sat, Nov 09, 2024 at 03:24:38PM +0000, Jonathan Cameron wrote:
> Sadly this has probably missed 6.12, but I have queued it up as a fix
> for early next cycle and marked it for stable.

I interpreted "early next cycle" as "This will go into v6.13-rc1.". But
that didn't work and didn't hit the mainline yet (as of cdd30ebb1b9f).

This patch was included in next as
64612ec9b909b699293b7220c634f67a9fc12e06 between next-20241111 and
next-20241128 and then disappeared from there.

What is wrong here?

Best regards
Uwe

--wqyzjtgfugywnrjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdS2lYACgkQj4D7WH0S
/k6/XQf/Wrg922hLwlEEuEzE+F9ngC/R5jfkDYa1SJ4D1dy2rTD/WJxzM0KEc1SQ
6gocNzBMhuhtsVKW6KjjfjneL5qhrP9dpnaLuxlWmx40vdVT31BPGHsnBGt1iakO
JfP+M+l83dKq653GLnMezaxlmp3pj1/ip2R61547ebw8GEWRrtBG6Wmi29RfDamZ
/yv3/xr/+fnHSzGlZbn0OAa+wCjgMb+f1xwk1V3RMO7uqFgGr15/qN1c4DPVBlra
kcmQ+l6RZP1QeD627xOZ3S/m8StzzqQewwc3GLHQBDUyMQrA6ub6/qfj0WTNop9e
+TRhNV41v0Hvy/8DcxiDGk36L+mLHg==
=jcvo
-----END PGP SIGNATURE-----

--wqyzjtgfugywnrjz--

