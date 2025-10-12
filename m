Return-Path: <linux-iio+bounces-25015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71584BD0C74
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 23:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1C31896305
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60813223DE9;
	Sun, 12 Oct 2025 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="zYQI60mt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6FA1509A0;
	Sun, 12 Oct 2025 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302887; cv=none; b=NpjGBgS2VDskwGrFEC64jtY1sX2WBmH42RO0bW5SvXArlC2U5L4Ipk+qej4x7Pdy4bb/kCbV7yziARG+w+akzgtpgr6GD847o/1TK4ikXIuev40lSxuqGnD4rEySsV9xKaCMirp5KDhpZS/rpv9N2UNnRWqacrPddIY81TOPrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302887; c=relaxed/simple;
	bh=IopoeBmhJ6Zxp/5pqFewt8TcZWeComBYBrSDx2hjHNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqvi3/pIBVK7jBEC0LYM+C2jyxpAbKIszm0XmEyJ4bu6wRl/rzUNZWnQTBfAiMIfGmj6xxKcNiDtAFcflWy4V0XhlXkOQfvrCsJVmNM5xjzdPS37TZ49HX31Amtce0d/+wHLGS6yGyrX/baHZFAKs4GrnGwmXu7qhHa8rj0+pWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=zYQI60mt; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 72A7D173BE2;
	Sun, 12 Oct 2025 23:54:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1760302462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IopoeBmhJ6Zxp/5pqFewt8TcZWeComBYBrSDx2hjHNo=;
	b=zYQI60mtI/7Na+Mz9UUtb1q2OG7/qa7hrZhJYUD5X272yISJiLj5KxLcCP65f4GXeso5Nw
	NP7g4EcZ9CIIG8oxI0ulhedreaXyJW+zLR33MyYyXGdgJpk/kYmpkP7yI6eJhkyeaKPf9q
	4Rgy0bOJuFPSvA21Lvrp3o3J+4UaonA/Z0ZPP2fZZcU/6PZD+xZQpg5T/H6dcpUil3dk5j
	TFNirqfzNhA6ynRrE2UceWNGf9fYiM66EunmYLl0X8ipIiyYs/WJt9G0IMFRWAAgaAdVIu
	bap5GD46YL9JkutOAD4txKYeI1ca5ewBQj04lpX6HXMDf8On71GQsXnK3isWLw==
Date: Sun, 12 Oct 2025 23:54:17 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/19] iio: accel: bma220: populate buffer ts in
 trigger handler
Message-ID: <aOwVefTE3O_BEuW5@lipo>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
 <20251005-b4-bma220_improvements-v4-12-0f449ba31585@subdimension.ro>
 <20251012160618.4cd15ad3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l8n4bOJUmFl/Vpvd"
Content-Disposition: inline
In-Reply-To: <20251012160618.4cd15ad3@jic23-huawei>


--l8n4bOJUmFl/Vpvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello Jonathan.

I was a bit worried and I hope you've fully recovered from the flu.

And yes, it also had to restart the rebase multiple times because either I forgot to add bma220.h or I tweaked a few innocent lines in the 4-th patch and they had a ripple effect on everything that followed. Thank you for adding the finishing touches.

> Applied.

I promise to test these out quickly, but please do a push on your testing branch (the last commit I can see is the previous patch).

best regards,
peter

--l8n4bOJUmFl/Vpvd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmjsFXEACgkQdCsnp2M6
SWOzKw/8DFDlWj3d5oizUG/EuaKSF1Rzhw2rXkK0h5CQYyJC50jpVDzl8WXmmoK9
G0WV92qBkz9L6GUyv719llOviVGsjsxINl8s8De0SQ0ImRDr9iW0eZ1bhT2t1vKX
eytslm7KO17FSV+nOZjLc/Wb4xEu3gdMWiX/jO5xCV8uw5FOF+zTL3iH6DDYJ99O
idp3c8GdHQqgpgVZIgZEVyIWMCtabWpgf9XCFkHg5tFNED+g3YuN6iQAsRrxcKdx
Y2YpShzXpUNIeDRMoRxiwKF9J+TpBqa57f/NSauY9EpirmkeychQdIYNW+2j8Jg6
LUgeRA3WDzkbhEGFCjoULgGTlrTIF3k7xx0AF8Pkb2TDycboEuSxX0bU/vL0HC/5
4ugsBAVJ0I0KXy4ZOydjvNBSLoXrxODrIV9YxhGvJqlOU0NLNm7fvX4NIYFIKtAE
b6X65Fpm0g6rpG3sjrOwM5zD+UABxCpWfXvUIg0v1wFktOtCR5C/9XxSpDj5oVHQ
cmpByxF4k4mywsjzbEc46OqXD4+9eZcb58gblm0ganTz8vxiZ2A7aBSH8yYXTrNi
B4ToQJ7wIsbafupeuCWj9GQgwlhAFNyehlCCDxmW0LKGwJCaML5z6p2UYk2SmvIJ
/As8xI5mizWjWPFbzZlCRYPzXkZzyVLugEtBe6iKhAGyyGvbo7Q=
=/qZn
-----END PGP SIGNATURE-----

--l8n4bOJUmFl/Vpvd--

