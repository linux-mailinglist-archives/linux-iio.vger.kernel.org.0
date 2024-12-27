Return-Path: <linux-iio+bounces-13824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF59FD6CB
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C3F3A25C6
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2024 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781631F8910;
	Fri, 27 Dec 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyZhSxba"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA467080D;
	Fri, 27 Dec 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735322136; cv=none; b=p5GKjpViJO/bjgk3xZPqKJit2Qz8JrX+LRz8CnJUwIHPhwEb2KKKXy/WQJYJH6xwFb9vvelUnSyE7djixLRs2uhTBS1GatW/cwXxDDYYLF77htoRBlQ/FN5WMBBG8M2QRuvtLMfzpIBb6Codra/wo42WIcXDld1ctkoT9HwrGis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735322136; c=relaxed/simple;
	bh=Cu1HgDuwyDIS4vBwN9X7WrfUbQNM9zs0yLysD9Ct/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdUmMHB/aYE8Upp+5z48ANGglZCHYlqpHtlVve4U2hI3Sh58QYNz5VSCqPmnxVVAS3g/qPfFCbaNiDauVvXho5EWU0U4ph3AH/vW6BRpYfA1xHofEC+ygIH1/FzQC3Tj7tpZBkBARuvDfDD9CmnY8EhrkqyPG7lAFHBUPnJMEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyZhSxba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E304C4CED0;
	Fri, 27 Dec 2024 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735322134;
	bh=Cu1HgDuwyDIS4vBwN9X7WrfUbQNM9zs0yLysD9Ct/Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EyZhSxbay5mQLZKlAhOxEFCEwg47tRaNAMIW9XdQpeqWmXfAccEIxJRCC0svAKwwk
	 ptBd6C7r9Tc6prsUmEgCBZlQUnTWuiboVXUVxCXXglhdoMa6F4HYLWj2DRFfj+Bo5U
	 elW177x3hbPLyx3XUy635i1mIuKLiiomC8680DlpIpVPaGmf/+2KGfj2lbY3XyFrzD
	 fqYUPiwYH8NPL2aABDWSD7vWeCf+07aw+6PQZxLG9M6MyHvHixnrF7wcmu54Rf5iPs
	 kf+sghbjyX6lp5nb3GRue+9s0hgxuOX//SZH49DJD72SJIO4Nepi2beaiQIMzLQesh
	 15+AxQrGXJe8A==
Date: Fri, 27 Dec 2024 17:55:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241227-facebook-paralyze-275c075d37a2@spud>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-4-l.rubusch@gmail.com>
 <20241214121057.5b12a236@jic23-huawei>
 <20241215-satisfied-expiring-9200ec935768@spud>
 <20241219175815.797b376a@jic23-huawei>
 <20241219-pregame-blot-e15ff0fbfe45@spud>
 <CAFXKEHaaLj7gePiDruMvwGGZKq5ctoq5z7_Qv_NC3bvBsL_BeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OA+MRQwrASpxgIbK"
Content-Disposition: inline
In-Reply-To: <CAFXKEHaaLj7gePiDruMvwGGZKq5ctoq5z7_Qv_NC3bvBsL_BeA@mail.gmail.com>


--OA+MRQwrASpxgIbK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 25, 2024 at 02:01:50PM +0100, Lothar Rubusch wrote:
> On Thu, Dec 19, 2024 at 7:21=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Thu, Dec 19, 2024 at 05:58:15PM +0000, Jonathan Cameron wrote:
> > > On Sun, 15 Dec 2024 14:56:58 +0000
> > > Conor Dooley <conor@kernel.org> wrote:
> > >
> > > > On Sat, Dec 14, 2024 at 12:10:57PM +0000, Jonathan Cameron wrote:
> > > > > On Fri, 13 Dec 2024 21:19:05 +0000
> > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > >
> > > > > > Add interrupt-names INT1 and INT2 for the two interrupt lines o=
f the
> > > > > > sensor.
> > > > > >
> > > > > > When one of the two interrupt lines is connected, the interrupt=
 as its
> > > > > > interrupt-name, need to be declared in the devicetree. The driv=
er then
> > > > > > configures the sensor to indicate its events on either INT1 or =
INT2.
> > > > > >
> > > > > > If no interrupt is configured, then no interrupt-name should be
> > > > > > configured, and vice versa. In this case the sensor runs in FIF=
O BYPASS
> > > > > > mode. This allows sensor measurements, but none of the sensor e=
vents.
> > > > > >
> > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > >
> > > > > Just to repeat what I sent in reply to v6 (well after you'd poste=
d this).
> > > > > Maybe we can maintain compatibility with the binding before this =
by adding
> > > > > a default of INT1.
> > > >
> > > > But can you make that assumption? If we did, and it's not universal=
ly
> > > > true, we break systems that had INT2 connected that previously work=
ed.
> > >
> > > I guess there is a possibility of a driver in some other OS assuming =
INT2, but
> > > seems an odd 'default' choice.
> >
> > Ye, I think that it is unlikely a driver author would think that way.
> >
> > > Also odd for a writer of DT for a platform
> > > to assume it.
> >
> > I agree, I think it is unlikely that someone would assume it'd work like
> > this. I think a lack of attention paid to the schematic of the board is
> > a more likely culprit.
> >
> > > There is a thing that comes up in spec orgs when discussing whether to
> > > rush out an errata.  "Is this bug something people would get wrong
> > > thinking the answer was clear, or something where the would ask a que=
stion?"
> > > Anyone who thinks INT2 is the obvious choice for me falls into the wo=
uld
> > > ask category.
> > >
> > > However, in the linux driver we would would go from assuming no inter=
rupts
> > > to assuming the wrong one.  That's indeed bad.  So I guess this doesn=
't work.
> > > Oh well no default it is.
> >
> > I don't think you really lose anything from having no default. The
> > driver works just fine without the interrupt, so the albeit small risk
> > just doesn't seem worth it.
>=20
> Agree. To be honest, I'm not sure if I catch the point here. IMHO,
> falling back to FIFO bypass should match with backward compatibility.
> Please let me know what I'm missing here.

Ye, falling back to the current behaviour is fine. The only problematic
thing is not checking "for a specified INT name" but assuming the
provided interrupt is either INT1 or INT2 when interrupt-names is not
provided.

>=20
> I would prefer just to check for a specified INT name. Then configure
> the specified interrupt line in the probe. In this sense, the
> interrupt line is only useful also if the INT name is defined in the
> DT. If no INT name is specified, the iio driver will setup FIFO_BYPASS
> which is the legacy behavior (according to the datasheet: if none of
> the FIFO mode bits are set, defaults to bypass mode). This is the new
> behavior.
>=20
> The old iio driver did not use interrupts at all. It stayed in
> FIFO_BYPASS mode (or did not change it, after power on, it assumes
> FIFO_BYPASS to my interpretation). Thus declaring the IRQ line yes or
> no, with or without INT names - for the iio driver implementation
> before this patch series, should not make any difference. It uses
> FIFO_BYPASS in all cases.
>=20
> The input driver (AFAIR we already agreed on ignoring this driver)
> needed interrupts. Defining INT names here does not change anything,
> either. The input driver configures by default INT1 and simply ignores
> what was specified as INT names in the DT.
>=20
> I cannot really think of any third case here. Please, let me know if
> I'm wrong. If not I will keep the above explained behavior, since to
> my understanding it should match the desired compatibility
> requirements. Am I wrong here?
>=20
> Sorry for the late answer. Best,
> L

--OA+MRQwrASpxgIbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ27qEgAKCRB4tDGHoIJi
0rzLAP0eTrjkxQeoiHg3FgqpH1pJyKp3kGBMt+wu1Mv5sSl2qQEA/B3g4ciq9h88
sthwlXZyDrQGVGb9ak617ykmIfL7CQM=
=uz3t
-----END PGP SIGNATURE-----

--OA+MRQwrASpxgIbK--

