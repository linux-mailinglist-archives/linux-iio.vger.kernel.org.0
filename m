Return-Path: <linux-iio+bounces-5215-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A944A8CD280
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618C21F21501
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD2014A088;
	Thu, 23 May 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2Fqc+qs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19213BAC7;
	Thu, 23 May 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468355; cv=none; b=OE+sRQsmvFLn0hOtKQ6+LPTi7uJkCQmSgCbXX4NDZm8S1NWeh8cp+UNwSpL8Uvd9rgo8u5O4BT9vWn0jwncatlFlO1tPDiZOAwZItwPh6CzwBJbOdADweLi9J4ORxogEFhD5wJooW/gGoZptaNSCD2fMx4ghusaBSb2C/QPLlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468355; c=relaxed/simple;
	bh=Dr5mko5as+cSEEbcfRg1MLGJNO6Fl6XswPL+RLiRfUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si5rThk++eNIXUGfVK5NYmQsg9Id5EQagWt/gc+T+pAuvuurZs/cpRnTi5ANxqPNdIsm/P67zQ7ELejX8zO/OVfso8lpTVcu5yOZ6mMM9yTLHrICOw2xYhh21t6+4TECqSXIUfQoyUuBbkdwEqLMmRnstgrcfSqYFU8jrNBsoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2Fqc+qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4BEC2BD10;
	Thu, 23 May 2024 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716468355;
	bh=Dr5mko5as+cSEEbcfRg1MLGJNO6Fl6XswPL+RLiRfUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2Fqc+qs8xlohHj9/B8DY0l86xciT9fBdiACVo3T2vBZpbizMUEK7yhlMtHNR5CpH
	 G8PHTYwOB4p0hisDOJrwmpDBt/3II+1W3d4PYtjsWz6LdJx8ARAu2fKDIaA404PyZ0
	 MuWMUE/GwPa50bonVa/bAgx50maWJYnfcRw9sR9jHXaOlQlUEU4/SmtIlltGezw+Pe
	 gzkT2vAmok8sJEKEZz2ZsqPUhZOG0+vqI9mdYcVJUH4ZVA1mOlRthsYQETuf1dP5Pm
	 OS1oyKDeWXZ3Si51tGPQ3iy6pIunlQQiLbUSt3xaV6SqZkySAM9RswuvyoouAQ4bg3
	 1K/oc6GxzNMUw==
Date: Thu, 23 May 2024 13:45:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <c33b87f7-d094-4299-a48b-e977203dc8dc@sirena.org.uk>
References: <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dnVW22IE+zhCJevq"
Content-Disposition: inline
In-Reply-To: <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
X-Cookie: You auto buy now.


--dnVW22IE+zhCJevq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=C3=A1 wrote:
> On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
> > On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> > > On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >=20
> > > > On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--dnVW22IE+zhCJevq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZPOnwACgkQJNaLcl1U
h9Bcrgf/YsNehmAOnw1qa+TJ7fsKV17/BbtOH4aEvi01QY+cmzcwWx2qiqVyKZoT
wO5F+lXO14aar9+4jKHeNH2FtKDd24HZNncTZxDR7TKMgm7P2fjisIQwd7ZuxiED
HNlTbRaGW6PeEs7goEG8zcgJ1jmETp4HpR7JqxlRsd9vWbii33er2/H1FUnVFMtU
nCJ9Jm13i5EtnLLOmA77i7JwwmsGcgqaSGkKAavgP+rpxxnur24lscXfBjp86Qh+
7+fWp/WJ50AYAjnrGKEvo+aRRIWMZB0AgN6X6aZoYn/Yq18v+jd4oEv8gZhDgCMA
gqwBWmKLfvimnPbTvUCcYtqg9udJ4g==
=R0tn
-----END PGP SIGNATURE-----

--dnVW22IE+zhCJevq--

