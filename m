Return-Path: <linux-iio+bounces-16110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07486A474F9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 06:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154343B19E4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 05:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E771EB5F2;
	Thu, 27 Feb 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYBgkYvA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA31EB5EB;
	Thu, 27 Feb 2025 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632401; cv=none; b=KYL8xTY+bTWqepnjy0/jkkiyooBUGCtm9ua48fWHnZtINCAZcc4r4KFk8qzKRmyFIIYbOFmo4vKra/QVINpsZZLJreDcum0p4OhoxKg1AOe7IkJJ71EGynwATdUhi+Y09eOynvXHUrBLYbaECyaYcmuDgsIpTcU5lhGu4863ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632401; c=relaxed/simple;
	bh=fVzKEBD6VeAoIwJny8URD+9oqLIX9UMzQFDONoxOgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGAfG+xKFvKn70gfj3XUMmKl5oVVaAcvZdY/SPY4Uug2EM8x1nihaHQvNOF5clHMsYZeh+NpRyaiLQx1FeOfpVU4zu8HIuCXGLTEqsMsLk/6cvgcdKZ5kmzvVCQ1z0hyjL1NmQEDpG8X/nMsj9cuHx1pEJ64p9783j0aVtg+ZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYBgkYvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6054C4CEDD;
	Thu, 27 Feb 2025 04:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740632401;
	bh=fVzKEBD6VeAoIwJny8URD+9oqLIX9UMzQFDONoxOgWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYBgkYvAO2nz9ZOAdSIAZDTxasYGU/s1iPJFbZLRloMXsgJUKZT8kA6DKDpP4t+lS
	 sN8wn1DSv7HdYWjlOiyNKN+DfXfveSHlLMoKZgreptSdnaSpdAuDegDxR7bfeaGSbm
	 5UmHc9PGNuXAmbMuzGejsrnLCYycGHvocOWZcPlfSq355ZBEef4Ekkl+5MvTELa26H
	 V/bmOauh4tx0Tk7BlffaQzYCcZwcbf59goU2XNmWLpx9TIi6JXuECPew6c+2NtqYFZ
	 6It83pfm5hIgURScGp5f/++4X7aAZf3HtpRFuJ1ibz6CeXd4D7I1iSDomRliycduoV
	 oAZTZFLgLIH5A==
Date: Thu, 27 Feb 2025 13:59:57 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dharma.B@microchip.com,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 0/2] microchip-tcb-capture: Add Capture, Compare,
 Overflow etc. events
Message-ID: <Z7_xTQeTzD-RH3nH@ishi>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
 <Z7h0AXV1zlgp9Nw-@ishi>
 <8fb9f188-3065-4fdc-a9f1-152cc5959186@prolan.hu>
 <Z7vihBqOgP3fBUVq@ishi>
 <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zy2ksh5Qd2xK/uRQ"
Content-Disposition: inline
In-Reply-To: <bfa70e78-3cc3-4295-820b-3925c26135cb@prolan.hu>


--Zy2ksh5Qd2xK/uRQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 01:58:37PM +0100, Cs=F3k=E1s Bence wrote:
> On 2025. 02. 24. 4:07, William Breathitt Gray wrote:
> > On Fri, Feb 21, 2025 at 03:14:44PM +0100, Cs=F3k=E1s Bence wrote:
> > > On 2025. 02. 21. 13:39, William Breathitt Gray wrote:
> > > > First, register RC seems to serve only as a threshold value for a
> > > > compare operation. So it shouldn't be exposed as "capture2", but ra=
ther
> > > > as its own dedicated threshold component. I think the 104-quad-8 mo=
dule
> > > > is the only other driver supporting THRESHOLD events; it exposes the
> > > > threshold value configuration via the "preset" component, but perha=
ps we
> > > > should introduce a proper "threshold" component instead so counter
> > > > drivers have a standard way to expose this functionality. What do y=
ou
> > > > think?
> > >=20
> > > Possibly. What's the semantics of the `preset` component BTW? If we c=
an
> > > re-use that here as well, that could work too.
> >=20
> > You can find the semantics of each attribute under the sysfs ABI doc
> > file located at Documentation/ABI/testing/sysfs-bus-counter. For the
> > `preset` component, its essential purpose is to configure a value to
> > preset register to reload the Count when some condition is met (e.g.
> > when an external INDEX/SYNC trigger line goes high).
>=20
> Hmm, that doesn't really match this use case. All right, then, for now, I=
'll
> skip the RC part, and then we can add it in a later patch when the
> "threshold" component is in place and used by the 104-quad-8 module.

Understood, I'll work on a separate patchset introducing a "threshold"
component (perhaps "compare" is a better name) to the 104-quad-8 and
once that is complete we can add it to the microchip-tcb-capture as its
own patch to support the RC register functionality.

> > In the same vein, move the uapi header introduction to its own patch.
> > That will separate the userspace-exposed changes and make things easier
> > for future users when bisecting the linux kernel history when tracking
> > down possible bugs.
>=20
> Isn't it better to keep API header changes in the same commit as the
> implementation using them? That way if someone bisects/blames the API
> header, they get the respective implementation as well.

Fair enough, we'll keep the header together with the implementation.

> > and it looks like this chip has
> > three timer counter channels described in section 54. Currently, the
> > microchip-tcb-capture module is exposing only one timer counter channel
> > (as Count0), correct? Should this driver expose all three channels (as
> > Count0, Count1, and Count2)?
>=20
> No, as this device is actually instantiated per-channel, i.e. in the DT,
> there are two TCB nodes (as the SoC has two peripherals, each with 3
> channels), and then the counter is a sub-node with `reg =3D <0/1/2>`,
> specifying which timer channel to use. Or, in quadrature decode mode, you=
'd
> have two elements in `reg`, i.e. `reg =3D <0>, <1>`.

So right now each timer counter channel is exposed as an independent
Counter device? That means we're exposing the timer counter blocks
incorrectly.

You're not at fault Bence, so you don't need to address this problem
with your current patchset, but I do want to discuss it briefly here so
we can come up with a plan for how to resolve it for the future. The
Generic Counter Interface was nascent at the time, so we likely
overlooked this problem at the time. I'm CCing some of those present
during the original introduction of the microchip-tcb-capture driver so
they are aware of this discussion.

Let me make sure I understand the situation correctly. This SoC has two
Timer Counter Blocks (TCB) and each TCB has three Timer Counter Channels
(TCC); each TCC has a Counter Value (CV) and three general registers
(RA, RB, RC); RA and RB can store Captures, and RC can be used for
Compare operations.

If that is true, then the correct way for this hardware to be exposed is
to have each TCB be a Counter device where each TCC is exposed as a
Count. So for this SoC: two Counter devices as counter0 and counter1;
count0, count1, and count2 as the three TCC; i.e. counter0/count{0,1,2}
and counter1/count{0,1,2}.

With that setup, configurations that affect the entire TCB (e.g. Block
Mode Register) can be exposed as Counter device components. Furthermore,
this would allow users to set Counter watches to collect component
values for the other two Counts while triggering off of the events of
any particular one, which wouldn't be possible if each TCC is isolated
to its own Counter device as is the case right now.

Regardless, the three TCC of each TCB should be grouped together
logically as they can represent related values. For example,  when using
the quadrature decoder TTC0 CV can represent Speed/Position while TTC1
CV represents rotation, thus giving a high level of precision on motion
system position as the datasheet points out.

Kamel, what would it take for us to rectify this situation so that the
TCC are organized together by TCB under the same Counter devices?

> > > The `mchp_tc_count_function_write()` function already disables PWM mo=
de by
> > > clearing the `ATMEL_TC_WAVE` bit from the Channel Mode Register (CMR).
> >=20
> > So capture mode is unconditionally set by mchp_tc_count_function_write()
> > which means the first time the user sets the Count function then PWM
> > mode will be disabled. However, what happens if the user does not set
> > the Count function? Should PWM mode be disabled by default in
> > mchp_tc_probe(), or does that already happen?
>=20
> You're right, and it is a problem I encounter regularly: almost all HW
> initialization happens in `mchp_tc_count_function_write()`, the probe()
> function mostly just allocates stuff. Meaning, if you want to do anything
> with the counter, you have to set the "increase" function first (even
> though, if you `cat function`, it will seem like it's already in "increas=
e"
> mode). I don't know if it was deliberate, or what, but again, that would =
be
> a separate bugfix patch.

That does seem like an oversight that goes back to the original commit
106b104137fd ("counter: Add microchip TCB capture counter"). I'll submit
a bug fix patch later separately to address this and we can continue
discussions about the issue there.

William Breathitt Gray

--Zy2ksh5Qd2xK/uRQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ7/xTQAKCRC1SFbKvhIj
K8XfAQDXDNB+DPfhs2rLhgUunNI+KBUL+vccWxpggWZ5E1Jg7wEAkV9CHrxKcsxC
Kf3aKOwwSpwBBqtWpg9v3c/QpcrhCgE=
=Pxrl
-----END PGP SIGNATURE-----

--Zy2ksh5Qd2xK/uRQ--

