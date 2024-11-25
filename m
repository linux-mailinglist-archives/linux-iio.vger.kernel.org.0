Return-Path: <linux-iio+bounces-12627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C309D8446
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 12:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F680284471
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB85198E90;
	Mon, 25 Nov 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3NB21rEO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E2198A0F
	for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732533638; cv=none; b=NjviELmn4fnTPOh4G6iEww3827IF4sPk1mpDt7KzsHNqRfvWnow0MUNs7rECTFr66GVG+l0UoXrJHSOtmQ04u6aNcdGSSSMfZODviZhVQVGgtCyhsxCWzuDLL/Q+aMxtnH7r5B2M80hwAtV3NuRrZz362P0casUonaraHHc0nTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732533638; c=relaxed/simple;
	bh=4NtGvxzD+fFspqlflwA+Rymkb6c4QHmxgS8pOAnb+lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti6oHLIOoSuWa7ZcQArnhEYnQ7OheffYhpZeWslaxiHms1Dw7Jpu3q/UatEXaR8jSUPW1YwO2SF7gjPoYhg7KEKLBEbkYEXLIF6DB81Ui4YVRmufrs1m1KPg5BO7yqOZN4gWuN+miaRaCBZlvyWcN+TNdm4r7yd35tlgKFMioqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3NB21rEO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382411ea5eeso2382837f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 25 Nov 2024 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732533635; x=1733138435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NtGvxzD+fFspqlflwA+Rymkb6c4QHmxgS8pOAnb+lY=;
        b=3NB21rEOYYwGjsciaRkROXZONTuVyAPJVUsvDnfSp7KdsqwensQHH+faw4u3XJ6Lw1
         wfuSt71AvBf/rZT6BRb7V6UBZTd3rV8to2chUcyKr+5CeVmotvE9vE7QiVvzwWY4Y2pH
         88G+4tuoWnivOsFuhTT7agqRYtMt4uz8/55wz/STvPIjK2k7KLdFDj2c7dhxeo/LoaGx
         O2knzyllD3iQo9L3ZO8rcs6aamXZISY5caBXBcjDZ8VaQ8J9ON+gTatxCDacG/b/9oS1
         hiMOw3+3GU0VU6h1f/1FBMh6QM58Iz2OC51Waqn9XfQyLfP+g/vLSmx/FeWBFDCdizp1
         +kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732533635; x=1733138435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NtGvxzD+fFspqlflwA+Rymkb6c4QHmxgS8pOAnb+lY=;
        b=LGhuFCFgCLIGcGXIYZ4rT8qNE0yZDw/P8ALKhju3ayPZIdOJCGJVkuAijU7Ap8cTIM
         RyMvnDIbbiDI/l6soezj6Lj/U75nXmVMuAYcMA1EVSwpa3sROJbPoRRtRTXsnnz/eGcP
         Bi9NJ9tk2Vqx0qsvq9pEW7FVPujDiRTD5a7DBa+4OidV6diYnUcGpwx5r3ShqGppSmbR
         n0FuXZHGpCH9WMIteRrbBOhSsO2oWf0dA1gRXKXuX72gPYO7cVHedQll2B44WiGuEfry
         2koSly2l26oQZ1KrilPpM1rObBnzMZgNg8g0JoI3+HH1pTn4hHAuGtm4OEszq+OeZaso
         0FvA==
X-Forwarded-Encrypted: i=1; AJvYcCVeSBFWL+xHRMOa7APi1xwQTSaxYcNQ9QySQOTrTvzUny1mXH/eaoC3k6/5OBNEJ9SU5cTDJ/BpDcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweLX38EInWtbmNqQvnOa7ipPRNGUMvLufEixAwUaOj/7F4E4hp
	QLsQZzvalUuQ0o+mzTkFSNhsHgt9CzOGwgsZ1Z6iS4l8IjKDu5gGhm9eNUwVNP4=
X-Gm-Gg: ASbGncvro8xQly2juxWcvbKB7mSUYHP6e1k7FdRKK1FJacMz+WgyS+7LlKE8AgTdEq1
	1gFbA3RiUAOTkRJ0PUS3eLNRlyMShriPi2ZY60rybll9nOZzKL9jrnEajWl6yer8gliiooxQUxo
	JJX4Ny5+erMjcIFcjs1pwN7V59CEtqTGhfBTKsLTJ0I1w3VycQfXF9LX8+w6dhNorKfT49qE6Xx
	le5K8QjIEwjG5lQ1IH7lgKPuGG3Rj4ovJ2hxSPn9vkjzIzIRD9r1MOVIjDBd71fF1Sb823Fi1rJ
	w8evMBHgh3ORCmj4kvGeVzXREILGyUpsBB2l3A==
X-Google-Smtp-Source: AGHT+IE5NQoWZWUcygqi3zPIjzjSMWwkFjE+qgKCP9orIfEB74DriSSBzMyCKrWBuqPzSnW4jBdQhg==
X-Received: by 2002:a05:6000:18ab:b0:37d:46ad:127f with SMTP id ffacd0b85a97d-38259d4fa13mr13893975f8f.26.1732533634851;
        Mon, 25 Nov 2024 03:20:34 -0800 (PST)
Received: from localhost (p200300f65f242d005bbc9b581c6b9666.dip0.t-ipconnect.de. [2003:f6:5f24:2d00:5bbc:9b58:1c6b:9666])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349d8b6da4sm50771125e9.24.2024.11.25.03.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:20:34 -0800 (PST)
Date: Mon, 25 Nov 2024 12:20:33 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Alisa-Dariana Roman <alisa.roman@analog.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during
 probe
Message-ID: <ddle4am42lhi7iq4zfkoliqceh6qxfvy3uefwfl72zokhraxze@fnpvgjzarudt>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
 <20241122113322.242875-21-u.kleine-koenig@baylibre.com>
 <12e62693-adcd-4da4-94ad-e56e98c11cc1@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jf2ode3p4cncq22h"
Content-Disposition: inline
In-Reply-To: <12e62693-adcd-4da4-94ad-e56e98c11cc1@baylibre.com>


--jf2ode3p4cncq22h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 09/10] iio: adc: ad7124: Add error reporting during
 probe
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 11:44:32AM -0500, Trevor Gamblin wrote:
>=20
> On 2024-11-22 06:33, Uwe Kleine-K=F6nig wrote:
> > A driver that silently fails to probe is annoying and hard to debug. So
> > add messages in the error paths of the probe function.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>

With the changes that Andy suggested I didn't add your tag yet. So if
you miss it in v4, *this time* it was a concious choice. :-)

Best regards and thanks,
Uwe

--jf2ode3p4cncq22h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdEXX4ACgkQj4D7WH0S
/k5ntwgAqfnRspGuM/iXoJKuwlTib0q86iKNsoE8GTCc9weX77H5TZckeWTVsJkN
5+/8Am/ZnD9lxNLo5n7VgDbPDohlUmdkcaAhThsIO68itjaycpuyUfpCCYheHAQu
o9e6ZzeiTp92kDns20osLjz/NbbxNLNiBrLK7tGd4slPjbH4yHRFBY1/Q0obMNSd
GkvENtetodEx/wGoquAJyGhODgjOiWuVaR4nPOb9um1KRlRiiDDbxFPJb0rcgC8B
I2Oifph3v11EzHC+uVl1fkiRcWxs5LuE9Xhh7Nnfad2EFbzZ1Pb3Qit0gRcKjFc0
sg09R76MzW5WLHMyXK9n9Il6BC688w==
=YSs8
-----END PGP SIGNATURE-----

--jf2ode3p4cncq22h--

