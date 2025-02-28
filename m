Return-Path: <linux-iio+bounces-16162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6C5A48D10
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 01:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73431168B17
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 00:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155738B;
	Fri, 28 Feb 2025 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPSIMBiY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F105182;
	Fri, 28 Feb 2025 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701612; cv=none; b=RgKtU00EectsCMbDoVXYUrf6KTCx15/KEzBkD4/169hGzWWLuSLnHQu2+RuhhvDjfjG51MGYwaCYTE09SeB931upsbwnzGZJs+46tVfMWu2WBNl1Ijw8V2vjm0jjJTN+NF3u/7U3Z2WlV1E3H2I4yOGklRuI8s0hSihNAR/2MyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701612; c=relaxed/simple;
	bh=VjWpg7dP0s8mbOXJKdWV+Hs+lOOmlqB/DQ6QK29ok7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzC55F2/vS6N6XDC6neJZmhoxJzAUkaKWGgvYgp89lZAC0Ram7CFQTbnFNU78L+6HAhkYrDKE5UXBfEeIH/dFtygxbSp+9IWPlahk9R2dzfWb3179RQ5ZnmRXneUgDrkajbNlb/6cAR3DxwKydVRhD4qKHvUA61eZVuDmQjkdj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPSIMBiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F47C4CEDD;
	Fri, 28 Feb 2025 00:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740701611;
	bh=VjWpg7dP0s8mbOXJKdWV+Hs+lOOmlqB/DQ6QK29ok7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPSIMBiYpk65tkQodTo/Q6a3uAXXcYR/A9MIjM+eaZtBDRB7mS3zYuwI8XBJKliJI
	 ZQIBtAcV49xzFkH3e9QjkktmvszB/CaIPUZBJUUhuLEQgAjYMKC9wkwMGfo00V4Ae/
	 MwgX177YXb8sLMGtS3MyHLB73/SS8BvzIPBqEOqi5fzMZ8xwbSwfoCylasr+Xg2LV9
	 gq0sW7FykZKyCJpc7A08PNzE/+EnNFxOcag/9/bPAdT28B8/s5UrXhrpLbQDrtEuN6
	 y9CuxIxYz2ZZB9KmRu2uT5vlzgqAuFMOcveNTnSzTJX+vGJWGrKUixNRyBuW1qQNep
	 0ursar10TjhZQ==
Date: Fri, 28 Feb 2025 09:13:26 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dharma.B@microchip.com,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Message-ID: <Z8D_phw3GxvdAO8G@ishi>
References: <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
 <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi>
 <20250227135330.GC182392@tpx1.home>
 <Z8B1LDT-n2XTTp8q@ishi>
 <202502271437280a6701d8@mail.local>
 <Z8CA9RTZWChh9cJW@ishi>
 <Z8CKQvRjqH9lwzgO@ishi>
 <077f23f1-3e5f-423c-aa97-ee7fcdf1475d@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aSZS/FbNbRmlzwJh"
Content-Disposition: inline
In-Reply-To: <077f23f1-3e5f-423c-aa97-ee7fcdf1475d@prolan.hu>


--aSZS/FbNbRmlzwJh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 04:56:17PM +0100, Cs=F3k=E1s Bence wrote:
> Hi,
>=20
> On 2025. 02. 27. 16:52, William Breathitt Gray wrote:
> > Sorry, let me step back for a moment because maybe I'm trying to solve
> > a problem that might not actually be a problem.
> >=20
> > I see functionality settings available in the TC Block Mode Register
> > (BMR) that can affect multiple TCCs at a time. Are these BMR settings
> > exposed already to users in someway? If not, do we have a way to
> > introduce these settings if someone wants them; e.g. would the
> > AutoCorrection function enable bit be exposed as a sysfs attribute, or
> > configured in the devicetree?
> >=20
> > Finally, if there's not much interest in general for exposing these BMR
> > settings, then I suppose there is no need to change how things are right
> > now with the microchip-tcb-capture module and we can just keep it the
> > way it is. That's my only concern, whether there are users that want to
> > control these settings but don't have a way right now.
>=20
> My knee-jerk answer to this is that if they do, they will bring it up by
> submitting a patch or bug request. But I'll let others chime in, we only =
use
> an extremely small subset of the features of the TCBs.
>=20
> Bence

I think that's a reasonable stance to take. I don't have an elegant
solution either to this situation, so I'll defer trying to solve it
until an actual user shows up who needs the functionality. Until then,
it seems that what we have right now is adequate for the current
usecases.

William Breathitt Gray

--aSZS/FbNbRmlzwJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8D/pgAKCRC1SFbKvhIj
Kze+AP0TSQhmivwKtynvIgpJ5od2IRhKMwMjM51kwMuLN/TrgwEAzg47J/c7uToS
dZ/ygvQQpXY3J5aXOapiR28Wb6kZLgc=
=D3Ne
-----END PGP SIGNATURE-----

--aSZS/FbNbRmlzwJh--

