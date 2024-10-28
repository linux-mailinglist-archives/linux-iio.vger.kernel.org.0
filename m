Return-Path: <linux-iio+bounces-11445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489589B2C07
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF431C21671
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51451D1302;
	Mon, 28 Oct 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iwWl6bP5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AC91CCECE
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109097; cv=none; b=LsYo7Orahha8MYXyaytIE5SvrmTvtlob/uVI5eKd3f8+xauRg40hMGuWtZlsWDZbb0mbFv5jAp9RcwKItr1C5Fff4w3xiUjM8j+kmHhdjL7+J3oIv4xNFO981TwhSXH3U07UUPwDYMSCdkPQuT/yFjwA0dqXe/38Ew8umzK6N3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109097; c=relaxed/simple;
	bh=3BRXW9cfwpRrct9tKvtj+L6tY1rhh5qfZ00d6rDfbMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuS5/OanEhUgdeawnHbWIsjtUG5RETDmdBKfwINH0yllgOowj6nrwqDFytVYNCf/lyKud8A07Y0L8GlEQCdz2L8KwYw4lvJZG3Ed1E4QKi3ha8BXsxl2M9AhOYVo4ftcQ3I01Bd4SkUWJ79JchWU5IDJpgeKRFwAXLzyD3AX/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iwWl6bP5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f1292a9bso4700305e87.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730109093; x=1730713893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q2Vq68zV8lSK5qFKnxVcbIkIPK3/umhpkN3DusMj+A=;
        b=iwWl6bP5fevhvtPEyab472nGCsItJcD3l2yQDzH9DO3reEyCZo+QrbUmsc9DBOCIO3
         qtjV25zw6Z4WwC1PEBkdL7QnsElF3NP6QLkuqNifyrB9GBhB3V4nDzOMT8LwAzcD+0NX
         ymBDMyqn3WQlbDa0GuXDDy1guc7XXBFHF1jLPcXeq07ed+/nyAqb0FlY4LiXLFK71488
         /aut02/p3r3IuuXfu/YXG3LJra6q15Xy93DEB9PlmuAWNB0JvebPzi7VqcjFrkiOH8S/
         I3HpZxWDh4buqxhmNyUo1Exujm6oxXi4/+0DLEk7ff6BRCZ89WfX15BP1rEGHAyfwHM9
         BeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730109093; x=1730713893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Q2Vq68zV8lSK5qFKnxVcbIkIPK3/umhpkN3DusMj+A=;
        b=Ej6Zj1jMSqqGWl4Ln7heiL9G3TBf7BJEEwBM2cQT4qfjchLGTmXBjY0DHco/5OihUh
         j6ZeZoI/mV9tJrsraj3lI/KbgeJ6AJmSsp5WcnSAM4pNpSNgN6+GMwtNrAw7RD7xIFPz
         FVLSzwWjH/N2N6mS1sLGwOVltt4tQRBkE9m+BLG4h5zNcLZLaP9K8tQaG9IR8y2nbeHv
         RSfqWQtnd10E3o2PZbvATDavVEHQIUEhlLwl+CczJGYKx4LtoKOiCCaispLjUzp9VP5h
         zwj2fKmWtqxlrNPfMCGoS3E0/di4SysDV2zn2h7fxy+yKPkJJUbDHvpWNptCMlgIniGz
         TtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb0v6vdkXdqt380BZDprQGPZVMXWRCVmNU1TuO10SzQbKrUdM9Ph+voY7r3XJrRnpS01UIwc0sins=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MnE6VcJL22ns1D1ENer1vWosmD4xbAprnl2PfnGNCJhFjG2N
	JFDMp77a00C3VqBJLil7CTSIWriyjO7InfAlQaltcJoIK2uwWHEZlg5eAO+5iJA=
X-Google-Smtp-Source: AGHT+IHjcfJa14H/SQSNgrFHuJxjbRUq2w4+D9jz+bOQbYbSL65kTl/qkW2DyzH2S1XfD/ePgHM8vw==
X-Received: by 2002:a05:6512:1314:b0:534:3cdc:dbef with SMTP id 2adb3069b0e04-53b3491cd2amr3489723e87.43.1730109092634;
        Mon, 28 Oct 2024 02:51:32 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f689sm134212505e9.16.2024.10.28.02.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:51:32 -0700 (PDT)
Date: Mon, 28 Oct 2024 10:51:30 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <r4nk5euogq5k42exp2y3ujzwnwxvjocsa3g4qnipyesnbtulgy@k6m4bhvlhexx>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
 <20241024171703.201436-6-u.kleine-koenig@baylibre.com>
 <20241027212622.GA101617-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agmvgdfrxefc2bxl"
Content-Disposition: inline
In-Reply-To: <20241027212622.GA101617-robh@kernel.org>


--agmvgdfrxefc2bxl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
MIME-Version: 1.0

Hello Rob,

On Sun, Oct 27, 2024 at 04:26:22PM -0500, Rob Herring wrote:
> On Thu, Oct 24, 2024 at 07:17:03PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > index 35ed04350e28..feb3a41a148e 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> > @@ -37,6 +37,9 @@ properties:
> >      description: IRQ line for the ADC
> >      maxItems: 1
> > =20
> > +  interrupt-gpios:
>=20
> Name it for the pin/signal, not how you are going to use it: rdy-gpios

Good idea. The line is called =CC=85=CC=85R=CC=85D=CC=85Y, is rdy-gpios sti=
ll right? I'd
consider nRDY-gpios.

Best regards
Uwe

--agmvgdfrxefc2bxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcfXqAACgkQj4D7WH0S
/k7alQgApsx6F2quNu2e06rW4u3J4CkxuDjFu6ENEZXXKBeC7/IctIP7MpEtCPrK
zt4r2zEmulWJl+vW0cXIpf0UZ1xBW9OrxPfVLqZhiGe1JG6LLtbFhcWxDH1PwYgZ
tSdnMjk+WdIQY0p9XqACWDATlDr2hCkLi6xjGBNS6SLpHJHz6Ke70o1e7AYqd5re
LT9+8CuaPWxbQShpZYfqdwLDwC60O63tOb9QEbtP3OkQUSdte1HIPRCyxj5G6tEa
b7F8Z2/fTv6I9pyQCyUYawDpezsttmohpl1sgnhwoeFL00UpsWqx4yBTyHjPfui8
n/EUo8jv04/jUIY7V+0jMNoh5GIMmA==
=6AQK
-----END PGP SIGNATURE-----

--agmvgdfrxefc2bxl--

