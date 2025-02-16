Return-Path: <linux-iio+bounces-15597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2C7A3763A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2793AAA86
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892723CF58;
	Sun, 16 Feb 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p9Js3g/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7C3D299
	for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739726228; cv=none; b=Ohn9YAcIR/A36kEmjHwojKFkZhg7500SWXoVaP6/fJGWW0+fvx82WYkPYCEiNzjrXGaGMgypxOti3Ct+uzS4HlK92sPj9EpnBFHvRG/liYmpB6O6NTEjEQ4355qEoCpwmJNKfoEKx6pSJiZj6SoiaxuA/kWKe/xpzhVG3V+GLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739726228; c=relaxed/simple;
	bh=HOF6dl4Fu7JFVDJ9qQtLf3vrKdU1fxZSPDCaVFz1VrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhAihh/g17iIIec/GCEudMiwX3PUEQDnXjivPVvQv+Dbil9HtTHynw8NYlLnLDTkM2+iDv0AVqhbA0A2fwJ46L5alIYPDYITlTU501z4Y9Lc789dD1JA18vF29W0Q9O2rMKKQvZhWZDePnaPFP5O1oJa1oqtS2t/ITKReLtaics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p9Js3g/J; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso588697366b.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 09:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739726223; x=1740331023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOF6dl4Fu7JFVDJ9qQtLf3vrKdU1fxZSPDCaVFz1VrU=;
        b=p9Js3g/JgoIBcKp+rZxmOs7a7A+S72p/lfmCQjTmcchKOlFznF143Fb7KNS4chavjo
         zpI+qNLfEfB0Be/39WT6MJeGjnr2p/0PoVDwaTLpbL0MuQN3E4cPBAr6m/i7VkWtdoZD
         9aFUyZkL1t+nZFcYJidp5fOK5y+n9FTt3vI1GLhQBvMaGUQWGxFYkfnkl4tJ88Hsq7+p
         JDy3aZS+7Cqlgdn0SAY7PM87Dlcatk42jChbWBdzx9RaMYpr4tFRjPfC7b2LxvZdFPqR
         EyLlQCKIEYJmrDQSZb9uBJeZHXSYuyJq2xbqM1NEg6Y4o75Gwg7KH/Ydq5KL+rYbzo82
         iyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739726223; x=1740331023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOF6dl4Fu7JFVDJ9qQtLf3vrKdU1fxZSPDCaVFz1VrU=;
        b=VtskqwGT3ZQtLK/D343jirjvAJ+iZ1pzVP8S5acxpEnKaJZi7LBuZrhs46+qsg5g6E
         VKAPi/UdbnxRrn2U2NWRuTofHIZq9gqgxIXGG/XEqepE2ZBJF/oiZ8McslejoYIGpUyf
         JzHncn+PPDhgOQxuPky0OLtEzmtIPAl6unZbLkwuSSXjKSHlzeMVDlBJtPDqg250Czcm
         TMmslXbE2k3JZ+SNgAq0sPpd82LZWgjTF33zKXiIZ0+kvhYxuh7lvOgFAPdkcgaFkCc7
         bN0w3UMug1G80wSyBPK/9zrJmjE2C2gDLZu+DO1P04cXUF45S+CPN2sAf9e4pkQIsv4q
         Py/A==
X-Forwarded-Encrypted: i=1; AJvYcCWueuwBK4wWMEontRRJ4sEGRYts0xSPAS2L4bYJoqitgjmRfNovjKx7APm/VAFCUQkrzhdTWHXHIyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDTtAX0xo2Qp7ejH+XXPF6E39M6uuDTnhDFf0awYricmnuBHL
	3q4CI6s/TxvT1yC+czTNosJrrNRP2I5w2vkc5NZxY5UB51nZ2+Jeurx1RvLt+2Wiy4e3WMgGymf
	s0DU=
X-Gm-Gg: ASbGncs8CDJTKiVGYNoz44i2OBDmi8Rt7ED3tMvA9KrUVO7sKnZ2thooefJHyJHq/pY
	Llp4MVQh6VxDOb15biTXxzS8Qkg/pZy3qPYID+1i8kWFnBtgpfTNO0dkKMUC6Hvu7ikQwfzXGyU
	lOTqRoKXFKY2rLxBj9hW44cGQcRoSR01/Qdyghpe6kl1eNpQ/mpNNyFMgEZte7f/fa5qFlpErLG
	M+9ixbZRRfjnsXXvVXbFDoszLONZLq+5CcHBmK9WMtMXsxG0vCUEepFjHEP9C+WHK3hy61qx2v/
	HKDH1JDHHmMu631+mOzr
X-Google-Smtp-Source: AGHT+IFaRjebA3Fmbwd1zbdg56J5VXESPx83AftZHkq+OsPhUnwpYH2WxZDI51NPC+HF4Mt3l9zxag==
X-Received: by 2002:a17:907:1c21:b0:ab7:84bc:3233 with SMTP id a640c23a62f3a-abb70b39c8emr697299766b.28.1739726222611;
        Sun, 16 Feb 2025 09:17:02 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323226asm737953666b.8.2025.02.16.09.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 09:17:02 -0800 (PST)
Date: Sun, 16 Feb 2025 18:17:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: adc: ad_sigma_delta: Disable channel after
 calibration
Message-ID: <slnxc6h4tkjzgjv7ory3xmhgzalyjtacde3lvgevaahjhcjg7s@jl55meuxwmvi>
References: <20250212105322.10243-5-u.kleine-koenig@baylibre.com>
 <20250212105322.10243-7-u.kleine-koenig@baylibre.com>
 <20250216163600.42211c3d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rmneyz64wldiauz5"
Content-Disposition: inline
In-Reply-To: <20250216163600.42211c3d@jic23-huawei>


--rmneyz64wldiauz5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/3] iio: adc: ad_sigma_delta: Disable channel after
 calibration
MIME-Version: 1.0

Hello Jonathan,

On Sun, Feb 16, 2025 at 04:36:00PM +0000, Jonathan Cameron wrote:
> On Wed, 12 Feb 2025 11:53:23 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > The function ad_sd_calibrate() enables the channel to calibrate at
> > function entry but doesn't disable it on exit. This is problematic
> > because if two (or more) channels are calibrated in a row, the second
> > calibration isn't executed as intended as the first (still enabled)
> > channel is recalibrated and after the first irq (i.e. when the
> > calibration of the first channel completed) the calibration is aborted.
> >=20
> > To fix this, disable the calibrated channel after calibration.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Whilst you said don't look in reply to patch 3 I ignored you. ;)
>=20
> This feels like it deserves a fixes tag.

Maybe. The ad7124 driver currently doesn't use this function. And if the
described behaviour isn't relevant for the other chips, that's fine.

Needs some more research.

Best regards
Uwe

--rmneyz64wldiauz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeyHYkACgkQj4D7WH0S
/k7i2wgAlWsH7dLrT+JYsoUJV+9cygdmrDfZV49/rd1fOUScm5raOH3JxLdTeqbU
xE7gKLP9MXxGDc0+JbSgK3PWqKgheijW/9FcCl0AaIzAg6g0y1mLe8Y1zB6ogEaA
ZfrRmUrV9opSga8L6FD5DNmyic73+1LeZPYOnVr/g6tbjCreF7kXsyhNdDClkaG9
9SBo+PXFxj+Xza9MkQTwzUvPC9IHkqGnOZEhFzPshnm18U4Xq4T8TMJ441DXdiCm
YJgo1DDLouppRuVhOY2dEwm3leGOxXEsY6uTsLcLM/DbIfQJ26L4ricPqOCnZGjr
SeFz9ThFBjjXsWpWPugLV4bv8JK5sw==
=Yo0J
-----END PGP SIGNATURE-----

--rmneyz64wldiauz5--

