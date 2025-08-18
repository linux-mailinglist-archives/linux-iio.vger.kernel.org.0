Return-Path: <linux-iio+bounces-22954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06FB2B1B1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAE5520598
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53421FF26;
	Mon, 18 Aug 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="knEkPWp+"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897C3451B3;
	Mon, 18 Aug 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545520; cv=none; b=vAIiavgDyZRGcOTUVpyyG5Na58BGTfi9haj6l3w2jrswRJQ63/uvUA6BJ9ePJUuYfXVQeJcmjfi9vNQJK1S/FjS5keMKUwdDeU07VXT8zqL7SnSoH8/Avmbv7nudEY7G0xPLd7C27k1ORkhaLhbEVNidTwqos9TRh9xIt8jiaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545520; c=relaxed/simple;
	bh=4xeueHP0P8jeDPQqMipUcwuJSucHzOAimKwUOa+/ThA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLQ9fwVRKEbEignTq+5TK3w9szQLApFxgamxa5mV33IpyTy18MZ4ByuVJNCpaVo9Aob8kFT3mzsWy7KbsH0FwOCFO7J6A5OFLCp/fkEpt1BURa8iOGaTMe+bAomjyxFD+yJZ8HFhNVW5GTWZMP2rJki+uf91wQpDYRYWczUx270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=knEkPWp+; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 15:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755545516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9ezPEEHY0FHo1StKd0VgUEYpVe8bez2tfysswnYvfI=;
	b=knEkPWp+5bdN9ZOadZbOJBI/FOhN4BdH+PhZkwvPqZ5apQMFm4hey9t/zg9mr6WEDvMv04
	HldLmGN+K9pU+iwGd4g+TaozzLOaMeeUmesCAKocoGW5HNmW1lXtRLAjDoVQpVBLTCYFGs
	Go2zxgNV0JI3/PstW7toC0Vwldt4xnw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081815-solemn-beaver-b5dce6@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-6-bcollins@kernel.org>
 <20250818191539.69e1882a@jic23-huawei>
 <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
 <afffc91a-d4fa-47d5-bb59-fad879a2ac6d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dhh56h7zs442u65s"
Content-Disposition: inline
In-Reply-To: <afffc91a-d4fa-47d5-bb59-fad879a2ac6d@baylibre.com>
X-Migadu-Flow: FLOW_OUT


--dhh56h7zs442u65s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 01:59:34PM -0500, David Lechner wrote:
> On 8/18/25 1:47 PM, Ben Collins wrote:
> > On Mon, Aug 18, 2025 at 07:15:39PM -0500, Jonathan Cameron wrote:
> >> On Sun, 17 Aug 2025 23:59:53 -0400
> >> Ben Collins <bcollins@kernel.org> wrote:
> >>
> >>> From: Ben Collins <bcollins@watter.com>
> >>>
> >>> MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> >>> to allow get/set of this value.
> >>>
> >>> Use a filter_type[none, ema] for enabling the IIR filter.
> >> Hi Ben,
> >>
> >> A few comments inline. You also need to send an additional patch to up=
date
> >> the filter_type docs in Documentation/ABI/testing/sysfs-bus-iio
> >=20
> > Hi Jonathan,
> >=20
> > I just sent a v6 because I was getting too many comments on the
> > dt-bindings patch.
>=20
> Actually, folks will be happier if you slow down a bit. General
> advice is only submit one revision per week since some people only
> have time to review once per week.

I appreciate the info. Admittedly, when I was more prolific with kernel
development, the pipline and protocol was much leaner, so I'm not used
to the more recent "norm" quite yet.

Not complaining, just noting. I'll get there.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--dhh56h7zs442u65s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmijf6cACgkQXVpXxyQr
Is8SbQ//ZPDjLa7zQ7U0WEuKZsmZowVbojE/FJFU1VxZJEzdREU0nexLFdF1WI1L
BGuva5VHhi+LOUUm2nedD7mksAG0UcC1Gw59awlrqG/QAwGWdNd8kH89B7jEIC83
mdZEnAP1tSrbnuNIPwlQrDCILyD4CFfi6xptJlSu6UcLStb3tNNzTDpVMuVyFapq
tWYS3CkOS6IA2spsPp44Bw400gsLWW2sQGoVb5sgMDmmKg1MKqvAD1AxiKBXYxXp
J3edk6FFvmdVTAMI1qIm4A8nmumnL/cHr5w1FKeuODeoramGeLcEW3DFrB+ALYD1
terG4z228qn1OMogs8ELffPCFtxyQo2S5DVdoxzYI7+dY63hCWV4DXQH/fyJmIox
92wDmRFiDaFI200DDYbC3zl8wV2NOFdGQ/pxjbf3T7MCEFdy1I/nnkm3mM1WuqhT
0vQmtCVwbXWVo4l5Bw8IubUS/5OIpydks8sporjN+5IdEod1PS9VsThDJsI3gKGV
g6gilJnCTempXihl8POQSZsMt5W6l+KcFBijLWWQTWiDR4iXmgYieLWibvlGISFR
uoAzXgavH5kFZ160vwYhzQFe5HiuG9gEjzijRlKbRiZd6h1AzGleHSxwE9ZBR5Tm
sKZUc/KbT7DmKd7GSx5fGhPvVLRDXD38Wf14kuO64OYzeNTadkc=
=RVWa
-----END PGP SIGNATURE-----

--dhh56h7zs442u65s--

