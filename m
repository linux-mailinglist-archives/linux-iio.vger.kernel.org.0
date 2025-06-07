Return-Path: <linux-iio+bounces-20288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDEAD0D84
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983973ABE8A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1294B221554;
	Sat,  7 Jun 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPHVhphh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2764CA5A;
	Sat,  7 Jun 2025 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301571; cv=none; b=Lxl+SdKTdE2WmrAJt9XPwew1BgB5+f2V5eA16Ycl4tnytB1BMdLv+5uz0CyD8oX2qw7BGufR78ItHpcFyJ8m9+0P4LGTJb234xfoOiEqjlQCzQU6ljqkkNb5x/jYVjVnM2GVJ/nk95NasBam2I4HIY8sSu5/Hdyjk+XcK87ZGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301571; c=relaxed/simple;
	bh=6c+HOf6ZjIH9W8D0daft7amDlJzRluE+zsoKm7aXUC0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRR/L9oulsgH4rkFH3fhMkq1VVqlzwJV5ROya8ILrdzgUEWoNCzDiD16kCPvKzOzrbmpVlgGg2QMYS1L/+lWGs58/8fY+IeQASexPvOe8Uhbv4jUmnQ1IDmAKRficFCCUVG1Wy5MAelERJdiWQ8vc4RaiMUGRn6yx8cy/BynQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPHVhphh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FC1C4CEE4;
	Sat,  7 Jun 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749301571;
	bh=6c+HOf6ZjIH9W8D0daft7amDlJzRluE+zsoKm7aXUC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPHVhphhbYulIq1XoIsucXc0qTYaBVWJO8K8l98szbmu1CKQh3rQhp9L0Ktv1snf3
	 L7hgh0jS3B3nD9KULbAdN3zDdxQDMwrosZxWSWi5AQt+ntkdKNzZVFSY7lZUNdgK0b
	 Ipuhjogl7k4RbDHs7J2WkhQPmzZNmkC+GjpN0xnQSKkVln+F6x5H5Kco+Ie6r9trTz
	 960gpJG2j36iiuvNMHRZSj/QJN1RzvVShoB08sHazmkutLJ4j+l6nR9WrVyz3mU7nC
	 tlGynQ/HI1g4uvCdjf+vSCz4VHRtC+oN/0flRVW0DeBZ1GJsvibwQJDcYkoWEnchVe
	 QqkAaFV4/wtlA==
Date: Sat, 7 Jun 2025 14:06:00 +0100
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
Message-ID: <20250607140600.76e87ea5@jic23-huawei>
In-Reply-To: <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
	<20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
	<CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
	<zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
	<CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Jun 2025 22:01:52 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

Hi Rafael,

> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote: =20
> > > On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.=
dev> wrote: =20
> > > >
> > > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > >
> > > > The dev_pm_domain_attach() function is typically used in bus code a=
longside
> > > > dev_pm_domain_detach(), often following patterns like:
> > > >
> > > > static int bus_probe(struct device *_dev)
> > > > {
> > > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > >     struct bus_device *dev =3D to_bus_device(_dev);
> > > >     int ret;
> > > >
> > > >     // ...
> > > >
> > > >     ret =3D dev_pm_domain_attach(_dev, true);
> > > >     if (ret)
> > > >         return ret;
> > > >
> > > >     if (drv->probe)
> > > >         ret =3D drv->probe(dev);
> > > >
> > > >     // ...
> > > > }
> > > >
> > > > static void bus_remove(struct device *_dev)
> > > > {
> > > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > >     struct bus_device *dev =3D to_bus_device(_dev);
> > > >
> > > >     if (drv->remove)
> > > >         drv->remove(dev);
> > > >     dev_pm_domain_detach(_dev);
> > > > }
> > > >
> > > > When the driver's probe function uses devres-managed resources that=
 depend
> > > > on the power domain state, those resources are released later during
> > > > device_unbind_cleanup().
> > > >
> > > > Releasing devres-managed resources that depend on the power domain =
state
> > > > after detaching the device from its PM domain can cause failures.
> > > >
> > > > For example, if the driver uses devm_pm_runtime_enable() in its pro=
be
> > > > function, and the device's clocks are managed by the PM domain, then
> > > > during removal the runtime PM is disabled in device_unbind_cleanup(=
) after
> > > > the clocks have been removed from the PM domain. It may happen that=
 the
> > > > devm_pm_runtime_enable() action causes the device to be runtime-res=
umed. =20
> > >
> > > Don't use devm_pm_runtime_enable() then. =20
> >
> > What about other devm_ APIs? Are you suggesting that platform drivers
> > should not be using devm_clk*(), devm_regulator_*(),
> > devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> > dev_pm_domain_detach() that is called by platform bus_remove() may shut
> > off the device too early, before cleanup code has a chance to execute
> > proper cleanup.
> >
> > The issue is not limited to runtime PM.
> > =20
> > > =20
> > > > If the driver specific runtime PM APIs access registers directly, t=
his
> > > > will lead to accessing device registers without clocks being enable=
d.
> > > > Similar issues may occur with other devres actions that access devi=
ce
> > > > registers.
> > > >
> > > > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attac=
h() and
> > > > dev_pm_domain_detach() in bus probe and bus remove, it ensures that=
 the
> > > > device is detached from its PM domain in device_unbind_cleanup(), o=
nly
> > > > after all driver's devres-managed resources have been release.
> > > >
> > > > For flexibility, the implemented devm_pm_domain_attach() has 2 state
> > > > arguments, one for the domain state on attach, one for the domain s=
tate on
> > > > detach. =20
> > >
> > > dev_pm_domain_attach() is not part driver API and I'm not convinced a=
t =20
> >
> > Is the concern that devm_pm_domain_attach() will be [ab]used by drivers=
? =20
>=20
> Yes, among other things.

Maybe naming could make abuse at least obvious to spot? e.g.
pm_domain_attach_with_devm_release()

>=20
> > In that case we can go back to using devres group to enforce ordering,
> > but proper ordering is needed. =20
>=20
> Sure.

Ok. Please take a look at:
https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj@bp.re=
nesas.com/

>=20
> > > all by the arguments above. =20
> >
> > Please reconsider given the fact that issue is not limited to the
> > runtime PM. =20
>=20
> PM domains are not resources, they are interfaces that are added to
> devices by the bus types that need them and they also need to be
> removed by those bus types.
>=20
> A PM domain needs to go away at remove time because it may not make
> sense to use PM domain callbacks without driver callbacks and if
> enabled runtime PM is leaked beyond the point at which there are no
> driver and bus type callbacks, this is exactly what may happen.

I'm fully in agreement with all that.  However, I'm not sure on relevance t=
o this
discussion as (if the new function is used as intended) the pm domain will =
get
removed before any problems occur. The only call in
__device_release_driver() between the bus remove and device_unbind_cleanup()
which unrolls the devm stuff as the first thing it does is
dev->bus->dma_cleanup().

Maybe I'm missing another path?

>=20
> If you have ordering issues in drivers, that's where they are and
> that's where they need to be addressed.
>=20

To my viewpoint, the ordering issue is in the bus driver because devm
setup calls are in device driver probe() which comes after the
bus_type->probe() but unwound after the bus_type->remove() - they should
be before that if they are only for device driver usage.  There are
devm uses in bus probe functions though which is assume why the ordering
is as we have it.

Personally I preferred the devres group in the bus driver. It's a
model a couple of busses are already using.  The solution in this
patch also worked for me though as a good compromise between different view
points.

Claudiu has been working on different solutions to this problem for a long
time so lets work together to find a solution that finally resolves it.

Jonathan


> Thanks!


