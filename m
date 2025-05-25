Return-Path: <linux-iio+bounces-19913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66BAC3604
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E6918939FA
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99D121771B;
	Sun, 25 May 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnlcLSPD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBA18C034;
	Sun, 25 May 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748195552; cv=none; b=pTIg0QGSXvIqXfq6wv07LY3FNCP/flr1A5cuxaEFDsC5SorGisOZ8WvCIGIwmL3FZ1QMUZG874DsZ5o1JyTKRU/34shIOYzFYXfmsyAnby9sihEvsFfLsbqTN1S9khIGhqNBXHDd8jxe13pkLkiQ9RuF4TGRioh6MFE1GZ5AKh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748195552; c=relaxed/simple;
	bh=O1XXc4yQhqCGieCyeg3pRqnDQWATWPoOOuCTDwHnQCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/62P7/sP6wUlzJLMtKAmbsFRJxROHiNI4g7cJipIllBEG7l1PdnSGgw5WAVL5gbumHMoSVVPTnfODF0+O70WnN9h0GY7L+kBpQPYQLiqw4sIkOY83gluHgslDBI2mgeaeZJ4ZSA3moxGp5hvGubDEVqEjokJR5W8VPIhRg6HoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnlcLSPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA181C4CEEA;
	Sun, 25 May 2025 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748195550;
	bh=O1XXc4yQhqCGieCyeg3pRqnDQWATWPoOOuCTDwHnQCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MnlcLSPDnVWCw5gqZdP3h2bZZcDR3OpKhlbpoPnj6pIF1yhUbxmnvSn+UcA8ttxzc
	 EWyb5Fd1NL1csefX2EocKGLzevOAAhY1ebHOJjRh1QkjGW3E1GQyiliuySZixZUybL
	 02Hs7bKcJfOiPaUdWsboZztel2W31MkGcKPZf97zXbbcxchSrlDBkpxNaWnA9yme6R
	 EDBB2O83e2rCqsTKSpmmK/4u0uhfRVHkd7k35rcT+IZpphajSbxiY5l/80LvmVm8sy
	 GAXruYbMuGEjBs0ClpFTJdejq545wBJcR/DC/zVz64A0ZXbg7Pb+ru1HJeBUCsZljS
	 xUx68b6R0Shlg==
Date: Sun, 25 May 2025 18:52:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <20250525185222.7f541a28@jic23-huawei>
In-Reply-To: <CAFXKEHbksqY9Xn-0SCHbUmU-YOR2y0TqDXZFtc-ARA+gXNd4Xg@mail.gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250525134958.19fec8c6@jic23-huawei>
	<CAFXKEHbksqY9Xn-0SCHbUmU-YOR2y0TqDXZFtc-ARA+gXNd4Xg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 25 May 2025 16:54:11 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, May 25, 2025 at 2:50=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 23 May 2025 22:35:11 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > The patch set covers the following topics:
> > > - add debug register and regmap cache
> > > - prepare iio channel scan_type and scan_index
> > > - prepare interrupt handling
> > > - implement fifo with watermark
> > > - add activity/inactivity together with auto-sleep with link bit
> > > - documentation
> > >
> > > Since activity and inactivity here are implemented covering all axis,=
 I
> > > assumed x&y&z. Thus the driver uses a fake channel for activity/inact=
iviy. =20
> >
> > Hi Lothar,
> >
> > I think on this occasion you were a bit too speedy in sending out a new
> > version.  Might have been better to wait at least 1-2 weeks at this poi=
nt
> > in the cycle, or until you had a few more reviews in at least.
> >
> > I don't mind that much, but it does create noise on the list and tends
> > to reduce the focus patch sets get a little.
> > =20
>=20
> Hi Jonathan & ML, thank you for this hint.
>=20
> I assumed Andy was just "taking over" here. In consequence the rounds
> were based on his reviews. For the future, I better await your (any
> IIO maintainers') reviews, until going into next round?

We don't separate quite like that and I'm always keen to have more
people review code - so when things are going well you'll probably
get 2 or 3 people reviewing a series at some point as it is revised.

Mind you people (including me!) sometimes hide from the controversial
ABI discussions :)

So as a general rule unless we are in a rush (e.g. little tweaks
just prior to a merge) it's better to give some time and gather up
multiple reviews.  IIO tends to move quicker than some parts of the
kernel (as we have a good bunch of reviewers) but I'd still generally
not send more than one version a week for first few versions at least.

> I accept how you like to work on this. Nevertheless, isn't it more
> efficient when I resubmit right after Andy's review (if I can), then
> you review and I re-submit again? In this case I would go through my
> codes thoroughly twice, which usually improves quality of the result,
> IMHO. Since only the most recent version of my patches should actually
> be considered, the older ones could simply be ignored (not sure if it
> is possible to flag this somenow from your maintainer side). I can see
> the point, though, where this increases the number of mails on the
> list. Nvm, just an idea. I'll wait in future.

It's not a clear cut thing but I still tend to scan read through all the
comments on previous versions to avoid getting into an ill informed
argument with another reviewer, so there is little advantage in sending
a new version unless there are either major changes or review feedback
has settled down.

Also there is always testing and a small amount of overhead in a patch
series preparation so it's not free for you either. A bit of batching
up of fixing multiple sets of comments can help there too!


>=20
> ADXL313: I neither care much about the number of rounds, nor about the
> split of patches. Thus I split rather a bit too much and you tell me
> how I shall merge (I think that's easier than sending you in a big
> blob patch and figuring out then what and how to separate). Pls, let
> me know if you oppose to this approach?

We all get this balance wrong sometimes and it doesn't matter if it
ends up slightly off.  Patches that just change a few values that
aren't used until quite a few patches later are generally a bad idea.

Also size of patch plays into this.  If it's under 500 lines
it is much less likely you'll get a request to split (as long as
arguably it's all one feature) than if it is larger than that.

>=20
> BTW, I also still had a more recent version of the ADXL345 series,
> containing the freefall and inactivity story. Current
> question/proposal: Freefall and inactivity, send out the same MAG
> event. An Idea could be, that userland software simply has logic to
> distinguish on timing, but the kernelspace driver here is doing just
> the same IIO event.
>=20
> Long story short - I shifted freefall to the end (also in oder to
> easily rather exclude it from that series). I expect this NOT to be
> the final round. First, there is the freefall situation (actually I
> expect objections from your side. If so, I'll exclude freefall from
> here). Second, by some of Andys reviews I feel I also should improve
> the ADXL345 a bit. I learned about regmap_assign_bits() which comes in
> very handy. So, if you tell me the freefall approach in ADXL345 is
> nonsense, I'll exclude it from this series.

I got to that a bit later in the day.  I was expecting it to take
more thought so left it to nearly the end when catching up.

I've replied in that thread to the freefall proposal. It's not
nonsense of course, I just don't think we have figured out a way
to avoid the expectations built into userspace code that is already
out there.

Note I'm also not sure about the innovative use of IIO_MOD_STILL
(which is a human motion thing to indicate not running, walking etc)
that the cros_ec activity sensor that was posted this week used.
That was rather unexpected. They do have the small advantage over
most drivers that they also control the relevant userspace (chrome OS
I believe).=20

Seems like we are in a period of pushing against the boundaries
of the ABI :(

BTW regmap_assign_bits() was new to me too ;)

Have a good remainder of the weekend!

Jonathan
>=20
> Best,
> L
>=20
>=20
> > Jonathan =20


