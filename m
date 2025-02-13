Return-Path: <linux-iio+bounces-15495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAD3A34A9D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A963A3BB888
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0D428A2D4;
	Thu, 13 Feb 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lEtuJ+oX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555328A2C0
	for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463712; cv=none; b=He4kL8xl9Bsu/lbnFplGM+4Vgi+jkw+Q5onS+8HNz0y7pJNjsl1vYl2NNXd1jB6El1JKtXMA6gLAHwEq7ci3J7kVSBReytrYIZxsqoxB6jgNcs9Nyase+wAWakGlHi2rQ5KroBh+izVWnK4ozrobarwWNlZl24tulkN0ke1ztfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463712; c=relaxed/simple;
	bh=snJT283j7cBth/ecgeJexDO2wurMkF//QPOSLDOZHiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYJy26MGEr+Wjq1t9yrU3lSXGr2h6YkQhMdXDqVUnmpnVr6hncyFSdRp05+SZbpekP0gMNyc1P5kXFdsryiCFVr+i8/gIa8oeWVkL/2HS1I085CULQMxXqV+IMXObYxlHJNW0opDDPl47loQURAhy8p46H0PQPW0mVCH89EHAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lEtuJ+oX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-438a39e659cso8086895e9.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Feb 2025 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739463709; x=1740068509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snJT283j7cBth/ecgeJexDO2wurMkF//QPOSLDOZHiA=;
        b=lEtuJ+oXgp3ADroZsFD3rTmeaDow/sv+xTav4p97PbJYjTFrcuQ1r2B1bfX4JgTpSH
         VMJW2eUVycrvmoQjbmtntqkd7ciASk7qIlYRePRlIqtIHwqqrYNjACCz0cQhYGrGaJi1
         tw4BaWCdwjb5Ug+nuegbX61ZPrKSyDED43//Hwynukewa4CPUSmGENroyggydBOFuWf5
         1WoT9oaBIosBXpYL/LBUWdu78FLEoqn2JhSVRHRkwbh7YLtwrLiP7uw0TMEO3ZDPh0KC
         260t2wAO8ZddBbxlV3d/8DxhOq1nDjoAp+Z7XkloQy4w6OltPwOTI8wuETtIFMvNqe3y
         rqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463709; x=1740068509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snJT283j7cBth/ecgeJexDO2wurMkF//QPOSLDOZHiA=;
        b=K+TXochZ+nx278rZhRgSI1VyzYFQR+rGrvJ7HfUJeUmAvbToJa8sWe7kZ24d699b44
         0mk22Tm8qCD1yqSI6U3uO0WMV1L7ju6pkSAgbKr8J3+eFbRUFLcgU57Te/RrdnosxQn6
         U7Ly45aGif2suj76Jwzu9BVlWHE2Bj8RxYRjbYa91bB1W6RZu+zqIf9K3a5GEr06qlca
         hDDhf0NtjNW9VV5NZmp7H+LVR2wO/YEsrwtVvMRHeKbf4HtfQ/2FEqxBQmAIBxTmMrC2
         phmpk6Zdmeks/fpqIek80AOYcu4mhOtyXHlxrXzPb0k3LaOb2mIhhXe3Q7XQL5L/8v9J
         32YQ==
X-Gm-Message-State: AOJu0Yzajf8LIt5X06WBWJOlERhcrNsANko/l7w2Zse28mFLKGbv7A1g
	kFVORCNyO/+qcDA6NdFKPABSBXA5Ef4NbvNM0wX8A3xSlCtpAkL9tDqrG2TekMHUgaWxAX4dTAT
	M2Gg=
X-Gm-Gg: ASbGnctjijowhytaM2JZ7UKjQmdic2SyRxEYjLWFWiyibELYh/4w3TxBg1bJXHo2GTq
	wY5IyTiicT/oPXDtKyFCWSSYV3uSGlJrT9Sp+aiOQPpj8Ym5pMuaQJ1gkjPGRXHdu+M5CazurA8
	8idNC+5X9Cc2/3KaYvpPkV3Pvme5+pe4pLBRYZMhAuFP1dCXDe/dsnOX2GOSqqdRmjzd0v9JZpv
	TfflKBs+xLdtFRzRV8Ti/uPtPHGtp5Hc2yyia4WyfkThETmfbXK7Nvdd1JD7zrGwOVPM6Jv9XBx
	NUcWrfNZWJqRNq+4IzsjZj+JJ3azMqxSB6iOoNbN1Ph2q7PzFy5z5G/S+A==
X-Google-Smtp-Source: AGHT+IGhS+BWH8EX2lGJwBNU2rTA6y1+J/qmoIXaMxpPtHFCfyppQKn69pCzi5OWhUBTW8LndtJEHg==
X-Received: by 2002:a05:6000:381:b0:38f:230d:4c77 with SMTP id ffacd0b85a97d-38f230d4e90mr3816635f8f.46.1739463709370;
        Thu, 13 Feb 2025 08:21:49 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961885077sm21560365e9.25.2025.02.13.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:21:48 -0800 (PST)
Date: Thu, 13 Feb 2025 17:21:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/3] iio: adc: ad7124: Implement calibration at probe
 time
Message-ID: <5vi2qggddrrvsvspv7p2kveevamg3a4psfjtev42xhd6lqfagi@ksjscfuxctrm>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
 <20250212105322.10243-8-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3io5vorf23yef33t"
Content-Disposition: inline
In-Reply-To: <20250212105322.10243-8-u.kleine-koenig@baylibre.com>


--3io5vorf23yef33t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/3] iio: adc: ad7124: Implement calibration at probe
 time
MIME-Version: 1.0

Hello,

how embarrassing, that patch doesn't compile. It's not yet clear to me
how this passed my pre-send review and testing. =F0=9F=99=88

Please just ignore this thread and all the kernel build bot warnings
that for sure will come, too.

Sorry, will fix and resend.

Uwe

--3io5vorf23yef33t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeuHBcACgkQj4D7WH0S
/k53lwf/bmrGPbaFeA8MQvGt+5FAczUArCBHrutC1ywRsLYTPRT5ezRy0uXfTiMP
4GNI5L8QFnhatPk74Jc9/hgYiffSTugZqM2yCLwL+Aaucf52r2EdkyqmqYAniZ+4
70LxxRGVlfuXhdluJx1hZsNzLzDngN2BlVkLgN7KX3QLDHEzuA7DHwO5U5JHX32Z
MEJke4CC1yQ00ytkl17AI7IXVEFh2+oi+f2CkzHZZOgL0T8Mr8cSjQlYCDU3SNjm
DDb18haKnlKA0bxvgplGNp8GOln9cHjHgBkhvk4aa6ZyNMSgiKwswbB/7EhJ7KaC
HnaO8FZYjwgNhW17VWn+m+5c1tHcVA==
=BLzN
-----END PGP SIGNATURE-----

--3io5vorf23yef33t--

