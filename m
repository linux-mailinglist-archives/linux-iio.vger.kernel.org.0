Return-Path: <linux-iio+bounces-20460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21DAD5C03
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564B21E041A
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CF1E835B;
	Wed, 11 Jun 2025 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqPoV5uF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B291C8632;
	Wed, 11 Jun 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658996; cv=none; b=JcmICQ1CcfWBsdi1JZrcJwm0f4aYBRprIwFBgvYNWMMZk+sonY33L+4REWBpHLva6AcwBLW/XNdfMulMKoOJxc02uCi5JI5LBShyqarpVliDuGIhCnUMu0ha0xm6ednHmA7m9F32WMJsF1jG8aOjdJPXp2m5owIPsARX4rWQ/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658996; c=relaxed/simple;
	bh=6Yr7neCKNg/B0PNZ095QRrKhidA14r8xP13hJkq563Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEIgcpSa29dLUoRTSrCBQhstLosq7BOfOn2AoFy3P6qgbqcWpTyZ31zprbGhvnxnzkBP2lRANdRXtRGiwYG6E8x/IIb2Kq9pwEwlbYnfP07UbfqXwp5goWDYtS/Jo3PR2TK55Jz1evBy4J4kOIlfA4TE2499gAjM4SxNe9hVPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqPoV5uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BA5C4CEE3;
	Wed, 11 Jun 2025 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658993;
	bh=6Yr7neCKNg/B0PNZ095QRrKhidA14r8xP13hJkq563Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gqPoV5uFk7qp0GcxWwFb4sV5d2YF44Y+vaGki/HO6Ls9HVdP4MwrSib52H3KHcRcA
	 BeU761q5eImCF4CMawjl/YfQASldadoP1EBgBW8KChPg6cojLsqmBGWfQ2O6eF85Ax
	 LB0z9OrAD6d6MgvPaJD38yJozqVH+Q0NTDgh9jkMXu38MymZivQXANvu+DfqdOCali
	 XSAZHpT2MxkWP/ttB0Juv/ToZ7yPu+XEEJa6V1U2qKim7PTWFEkdtkPh1EhxaESUWN
	 vhTMxwUUmmpJJ/eOKX9WkJ1KZSMuqELbhi9GittWZrpyQ0VO+xuBh/jcninR7UXAi3
	 EpnczJ/+5XdgQ==
Date: Wed, 11 Jun 2025 17:23:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Claudiu
 <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, dakr@kernel.org,
 len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 fabrizio.castro.jz@renesas.com, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <20250611172307.37c9b725@jic23-huawei>
In-Reply-To: <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
	<20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
	<CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
	<zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
	<CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
	<20250607140600.76e87ea5@jic23-huawei>
	<CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jun 2025 21:59:57 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Fri, 6 Jun 2025 22:01:52 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > Hi Rafael,
> > =20
> > > On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote: =20
> > > >
> > > > On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote: =
=20
> > > > > On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tu=
xon.dev> wrote: =20
> > > > > >
> > > > > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > >
> > > > > > The dev_pm_domain_attach() function is typically used in bus co=
de alongside
> > > > > > dev_pm_domain_detach(), often following patterns like:
> > > > > >
> > > > > > static int bus_probe(struct device *_dev)
> > > > > > {
> > > > > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > > > >     struct bus_device *dev =3D to_bus_device(_dev);
> > > > > >     int ret;
> > > > > >
> > > > > >     // ...
> > > > > >
> > > > > >     ret =3D dev_pm_domain_attach(_dev, true);
> > > > > >     if (ret)
> > > > > >         return ret;
> > > > > >
> > > > > >     if (drv->probe)
> > > > > >         ret =3D drv->probe(dev);
> > > > > >
> > > > > >     // ...
> > > > > > }
> > > > > >
> > > > > > static void bus_remove(struct device *_dev)
> > > > > > {
> > > > > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > > > >     struct bus_device *dev =3D to_bus_device(_dev);
> > > > > >
> > > > > >     if (drv->remove)
> > > > > >         drv->remove(dev);
> > > > > >     dev_pm_domain_detach(_dev);
> > > > > > }
> > > > > >
> > > > > > When the driver's probe function uses devres-managed resources =
that depend
> > > > > > on the power domain state, those resources are released later d=
uring
> > > > > > device_unbind_cleanup().
> > > > > >
> > > > > > Releasing devres-managed resources that depend on the power dom=
ain state
> > > > > > after detaching the device from its PM domain can cause failure=
s.
> > > > > >
> > > > > > For example, if the driver uses devm_pm_runtime_enable() in its=
 probe
> > > > > > function, and the device's clocks are managed by the PM domain,=
 then
> > > > > > during removal the runtime PM is disabled in device_unbind_clea=
nup() after
> > > > > > the clocks have been removed from the PM domain. It may happen =
that the
> > > > > > devm_pm_runtime_enable() action causes the device to be runtime=
-resumed. =20
> > > > >
> > > > > Don't use devm_pm_runtime_enable() then. =20
> > > >
> > > > What about other devm_ APIs? Are you suggesting that platform drive=
rs
> > > > should not be using devm_clk*(), devm_regulator_*(),
> > > > devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> > > > dev_pm_domain_detach() that is called by platform bus_remove() may =
shut
> > > > off the device too early, before cleanup code has a chance to execu=
te
> > > > proper cleanup.
> > > >
> > > > The issue is not limited to runtime PM.
> > > > =20
> > > > > =20
> > > > > > If the driver specific runtime PM APIs access registers directl=
y, this
> > > > > > will lead to accessing device registers without clocks being en=
abled.
> > > > > > Similar issues may occur with other devres actions that access =
device
> > > > > > registers.
> > > > > >
> > > > > > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_a=
ttach() and
> > > > > > dev_pm_domain_detach() in bus probe and bus remove, it ensures =
that the
> > > > > > device is detached from its PM domain in device_unbind_cleanup(=
), only
> > > > > > after all driver's devres-managed resources have been release.
> > > > > >
> > > > > > For flexibility, the implemented devm_pm_domain_attach() has 2 =
state
> > > > > > arguments, one for the domain state on attach, one for the doma=
in state on
> > > > > > detach. =20
> > > > >
> > > > > dev_pm_domain_attach() is not part driver API and I'm not convinc=
ed at =20
> > > >
> > > > Is the concern that devm_pm_domain_attach() will be [ab]used by dri=
vers? =20
> > >
> > > Yes, among other things. =20
> >
> > Maybe naming could make abuse at least obvious to spot? e.g.
> > pm_domain_attach_with_devm_release() =20
>=20
> If I'm not mistaken, it is not even necessary to use devres for this.
>=20
> You might as well add a dev_pm_domain_detach() call to
> device_unbind_cleanup() after devres_release_all().  There is a slight
> complication related to the second argument of it, but I suppose that
> this can be determined at the attach time and stored in a new device
> PM flag, or similar.

That options sounds good to me.  I think this moves dev_pm_domain_detach()
call into the the driver core / perhaps device_unbind_cleanup().  It's a no=
op
if a domain was never attached so that should be fine.

Given that second parameter, I guess we can't move the dev_pm_domain_attach=
()
into the driver core as well so it is a little odd wrt to balance,
but with some documentation that is probably fine. I don't think we
really want a bus->remove_after_devres() callback for just this.
Ulf what do you think of this approach?

Jonathan

>=20
> Note that dev->pm_domain is expected to be cleared by ->detach(), so
> this should not cause the domain to be detached twice in a row from
> the same device, but that needs to be double-checked.
>=20
> Thanks!
>=20


