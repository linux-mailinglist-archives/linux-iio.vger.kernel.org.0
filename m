Return-Path: <linux-iio+bounces-16121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54935A48147
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FD919C112E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8AB2309AE;
	Thu, 27 Feb 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMavpRxM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9C27003D;
	Thu, 27 Feb 2025 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666161; cv=none; b=lxCi92M9UGnssana1eiyWuYMV/YDmgrKENgra1LBX7nFa2vDFliTG89z4L4wBCPym91U/lIpuS+wz6j1fG2cCAWiCA3Tl48QevGoO5YjZzWfQFmxKfqqqvAelrHcFJ1d3dKIso+r4SHxHLzQk0oMIedFgEJWd7VWNFJSosMqBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666161; c=relaxed/simple;
	bh=VbQBsruciLa4JtVJQIpxOxnRwemjEZfvuocPun+iyvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSrbzIIMTCzdte/bE2WBEVxJFHrs+Q/H9POD6d4eI0Z1HskWvYfSCzVAsjQ8390qfb3Z0858dOcNyAMv/ZrZR87p3gNGwqK08awtbCn/uHGOMDfYrMQUJInQeUf/idimamcVOLHB7dettRwugpGWVdmRDXzEDM5I6P3Kud6Bvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMavpRxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E64C4CEDD;
	Thu, 27 Feb 2025 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740666161;
	bh=VbQBsruciLa4JtVJQIpxOxnRwemjEZfvuocPun+iyvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMavpRxMeUFMhmHED2zmedmFZtfHoUybQ+cz/i5pgONnYq7cJOwgvJLVosWFB9Jl6
	 gQPdoRBqW4ruRXHQrNlrphSnAmovi5BTXGl7dw/luhCibjrt9AJToFlW+AFazGnGp0
	 UoV4WNra9Vy73MhlJ3ASmBU4o10Hf3lpUGbyGG4lkgYou2ArOAGOFjTYynM/rX0ANf
	 phE06lz3eYlJlkQ2aTII4VpgkS3Vz2YTIPbOKWznNlrDbVRhPHzzbyU3BP2nCfmGlM
	 MNR3MIulN8m7+YgqVMz3A4lOInz0wpRi5GAnk3hLPjCTJpiWMbnta4CivJixzmBD87
	 uGbIk2L0iHeuw==
Date: Thu, 27 Feb 2025 23:22:36 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dharma.B@microchip.com,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Message-ID: <Z8B1LDT-n2XTTp8q@ishi>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi>
 <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
 <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
 <Z7_xTQeTzD-RH3nH@ishi>
 <20250227135330.GC182392@tpx1.home>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="apdPA/3mp+t/HXU5"
Content-Disposition: inline
In-Reply-To: <20250227135330.GC182392@tpx1.home>


--apdPA/3mp+t/HXU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 02:53:30PM +0100, Kamel Bouhara wrote:
> On Thu, Feb 27, 2025 at 01:59:57PM +0900, William Breathitt Gray wrote:
> > Let me make sure I understand the situation correctly. This SoC has two
> > Timer Counter Blocks (TCB) and each TCB has three Timer Counter Channels
> > (TCC); each TCC has a Counter Value (CV) and three general registers
> > (RA, RB, RC); RA and RB can store Captures, and RC can be used for
> > Compare operations.
> >
> > If that is true, then the correct way for this hardware to be exposed is
> > to have each TCB be a Counter device where each TCC is exposed as a
> > Count. So for this SoC: two Counter devices as counter0 and counter1;
> > count0, count1, and count2 as the three TCC; i.e. counter0/count{0,1,2}
> > and counter1/count{0,1,2}.

[...]

> > Kamel, what would it take for us to rectify this situation so that the
> > TCC are organized together by TCB under the same Counter devices?
>=20
> Hello,
>=20
> Indeed, each TCC operates independently except when quadrature mode is
> enabled. I assume this approach was taken to provide more flexibility by
> exposing them separately.
>=20
> Currently only one channel is configured this would need to rework the
> driver to make the 3 TCCs exposed.
>=20
> Greetings,
> Kamel

Skimming through the driver, it looks like what we'll need is for
mchp_tc_counts[] to have all three TCCs defined, then have
mchp_tc_probe() match on a TCB node and configure each TCC. Once that's
setup, then whenever we need to identify which TCC a callback is
exposing, we can get it from count->id.

So for example, the TC_CV register offset is calculated as 0x00 +
channel * 0x40 + 0x10. In the count_read() callback we can leverage
count->id to identify the TCC and thus get the respective TC_CV register
at offset + count->id * 0x40 + 0x10.

William Breathitt Gray

--apdPA/3mp+t/HXU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ8B1LAAKCRC1SFbKvhIj
K96KAP95x4hAjvqmGv/vhrxFE85qghATuE1a2iHerA9+GalG7AEAwcjujFxyipDA
pe7+An53rZV6GE3xweOLUY/MTzCV8Qw=
=1Axq
-----END PGP SIGNATURE-----

--apdPA/3mp+t/HXU5--

