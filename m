Return-Path: <linux-iio+bounces-20461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B87FAD5C1C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DED21E1E57
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3881F460F;
	Wed, 11 Jun 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBrujnsz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123E1EE7C6;
	Wed, 11 Jun 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659241; cv=none; b=g1N1GdGedyPyeisaXpc0PyXrno9VNDz3oS1iT98q7CU7XAUp6HF7eSoN+KKW0vGqwnh4UEWPgjRqla0D34FEEUM8IfpyuQrn+vhSFT7P7lIxG2buHSvmz7LldRTRW/zGR5+TeivnDWrokdR1lgy5GqjmtiQfYd5tLloh+ddRxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659241; c=relaxed/simple;
	bh=NLdVGdz+GIw0Qzy5gD5lhi4bHcNad0lEHSZelIp2i1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n18PvzAA9uFJn3k4wMa5pJJUYao4WCSN7TiXRdGseoYJpJVuBBlMUGQ8v1h/Xkilz3o1MUNVkr/q2K9azOH6LjAv6ZDyXM6nUNJLqs6xZXgabmwsmNElCOWfwwRyAx4jPhUKicMp/KDg0K2wv/g9diPl8kFbucXJt7j9e+M9ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBrujnsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2763CC4CEEA;
	Wed, 11 Jun 2025 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749659241;
	bh=NLdVGdz+GIw0Qzy5gD5lhi4bHcNad0lEHSZelIp2i1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tBrujnsz/M4hjNRz5Dhfk/KBw2kR1iOqeeC6BYxrj8iww9YmtvG8NXKIjNdRDdV30
	 vLlKEDgrDZWNqGQwTtVBmBm4crKPWlhU/NcvLhCxKnzqosXEeXX7apTCqhclOT2dpC
	 5II/Zt8xWTIOHa2wIGH7bzlgFBeoUHiCEyHSFEyttqU8UbQaZMcESea5hk3P2g8d2+
	 53SHIFEazOkP3dog67dmD6omx6v9ncZFe9DxNsEXNWrfwoqDrrG/LjJEG+X+wbf32j
	 tL9YD3h8vsr2RZ3jX2uzsVZtgmSA8g/7wpW1bYlByifPvvemCdxUTBsufTTLuHRI4t
	 UrO3h+Uz4TORQ==
Date: Wed, 11 Jun 2025 17:27:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org, dakr@kernel.org,
 len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org,
 daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 fabrizio.castro.jz@renesas.com, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <20250611172710.144d8d7d@jic23-huawei>
In-Reply-To: <84a0e4bf-cb65-4b6e-93d7-48ac3ba06b0f@tuxon.dev>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
	<20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
	<CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
	<zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
	<CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
	<20250607140600.76e87ea5@jic23-huawei>
	<CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
	<84a0e4bf-cb65-4b6e-93d7-48ac3ba06b0f@tuxon.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jun 2025 12:11:08 +0300
Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:

> Hi, Rafael,
>=20
> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> > On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote: =20
> >>
> >> On Fri, 6 Jun 2025 22:01:52 +0200
> >> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >>
> >> Hi Rafael,
> >> =20
> >>> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> >>> <dmitry.torokhov@gmail.com> wrote: =20
> >>>>
> >>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote: =
=20
> >>>>> On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxo=
n.dev> wrote: =20
> >>>>>>
> >>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>>
> >>>>>> The dev_pm_domain_attach() function is typically used in bus code =
alongside
> >>>>>> dev_pm_domain_detach(), often following patterns like:
> >>>>>>
> >>>>>> static int bus_probe(struct device *_dev)
> >>>>>> {
> >>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> >>>>>>     int ret;
> >>>>>>
> >>>>>>     // ...
> >>>>>>
> >>>>>>     ret =3D dev_pm_domain_attach(_dev, true);
> >>>>>>     if (ret)
> >>>>>>         return ret;
> >>>>>>
> >>>>>>     if (drv->probe)
> >>>>>>         ret =3D drv->probe(dev);
> >>>>>>
> >>>>>>     // ...
> >>>>>> }
> >>>>>>
> >>>>>> static void bus_remove(struct device *_dev)
> >>>>>> {
> >>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> >>>>>>
> >>>>>>     if (drv->remove)
> >>>>>>         drv->remove(dev);
> >>>>>>     dev_pm_domain_detach(_dev);
> >>>>>> }
> >>>>>>
> >>>>>> When the driver's probe function uses devres-managed resources tha=
t depend
> >>>>>> on the power domain state, those resources are released later duri=
ng
> >>>>>> device_unbind_cleanup().
> >>>>>>
> >>>>>> Releasing devres-managed resources that depend on the power domain=
 state
> >>>>>> after detaching the device from its PM domain can cause failures.
> >>>>>>
> >>>>>> For example, if the driver uses devm_pm_runtime_enable() in its pr=
obe
> >>>>>> function, and the device's clocks are managed by the PM domain, th=
en
> >>>>>> during removal the runtime PM is disabled in device_unbind_cleanup=
() after
> >>>>>> the clocks have been removed from the PM domain. It may happen tha=
t the
> >>>>>> devm_pm_runtime_enable() action causes the device to be runtime-re=
sumed. =20
> >>>>>
> >>>>> Don't use devm_pm_runtime_enable() then. =20
> >>>>
> >>>> What about other devm_ APIs? Are you suggesting that platform drivers
> >>>> should not be using devm_clk*(), devm_regulator_*(),
> >>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> >>>> dev_pm_domain_detach() that is called by platform bus_remove() may s=
hut
> >>>> off the device too early, before cleanup code has a chance to execute
> >>>> proper cleanup.
> >>>>
> >>>> The issue is not limited to runtime PM.
> >>>> =20
> >>>>> =20
> >>>>>> If the driver specific runtime PM APIs access registers directly, =
this
> >>>>>> will lead to accessing device registers without clocks being enabl=
ed.
> >>>>>> Similar issues may occur with other devres actions that access dev=
ice
> >>>>>> registers.
> >>>>>>
> >>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_atta=
ch() and
> >>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures tha=
t the
> >>>>>> device is detached from its PM domain in device_unbind_cleanup(), =
only
> >>>>>> after all driver's devres-managed resources have been release.
> >>>>>>
> >>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2 sta=
te
> >>>>>> arguments, one for the domain state on attach, one for the domain =
state on
> >>>>>> detach. =20
> >>>>>
> >>>>> dev_pm_domain_attach() is not part driver API and I'm not convinced=
 at =20
> >>>>
> >>>> Is the concern that devm_pm_domain_attach() will be [ab]used by driv=
ers? =20
> >>>
> >>> Yes, among other things. =20
> >>
> >> Maybe naming could make abuse at least obvious to spot? e.g.
> >> pm_domain_attach_with_devm_release() =20
> >=20
> > If I'm not mistaken, it is not even necessary to use devres for this.
> >=20
> > You might as well add a dev_pm_domain_detach() call to
> > device_unbind_cleanup() after devres_release_all().  There is a slight
> > complication related to the second argument of it, but I suppose that
> > this can be determined at the attach time and stored in a new device
> > PM flag, or similar. =20
>=20
> I can try this as well.
>=20
> Another option I see at the moment would be keep the code added in
> drivers/base/power/common.c in drivers/base/platform.c, something like:

Whilst this avoids the exposure of a devm interface by just
pushing it down to each bus, we'll for ever be rejecting cleanups
that unify it.  So I'd rather explore Rafael's suggestion to just
handle this one in the driver core.

That only deals with the pm domain issue and not the other ones
Dmitry refers to where devres being handled after bus->remove()
bites us, but maybe that is the right way forwards for now at least.

Jonathan

>=20
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 075ec1d1b73a..391d725cd4c7 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1376,10 +1376,18 @@ static int platform_uevent(const struct device
> *dev, struct kobj_uevent_env *env
>         return 0;
>  }
>=20
> +static void platform_dev_pm_domain_detach(struct device *dev, void *res)
> +{
> +       bool *power_off =3D res;
> +
> +       dev_pm_domain_detach(dev, *power_off);
> +}
> +
>  static int platform_probe(struct device *_dev)
>  {
>         struct platform_driver *drv =3D to_platform_driver(_dev->driver);
>         struct platform_device *dev =3D to_platform_device(_dev);
> +       bool *power_off;
>         int ret;
>=20
>         /*
> @@ -1396,15 +1404,22 @@ static int platform_probe(struct device *_dev)
>         if (ret < 0)
>                 return ret;
>=20
> +       power_off =3D devres_alloc(platform_dev_pm_domain_detach,
> sizeof(*power_off),
> +                                GFP_KERNEL);
> +       if (!power_off)
> +               return -ENOMEM;
> +
>         ret =3D dev_pm_domain_attach(_dev, true);
> -       if (ret)
> +       if (ret) {
> +               devres_free(power_off);
>                 goto out;
> +       }
>=20
> -       if (drv->probe) {
> +       *power_off =3D true;
> +       devres_add(_dev, power_off);
> +
> +       if (drv->probe)
>                 ret =3D drv->probe(dev);
> -               if (ret)
> -                       dev_pm_domain_detach(_dev, true);
> -       }
>=20
>  out:
>         if (drv->prevent_deferred_probe && ret =3D=3D -EPROBE_DEFER) {
> @@ -1422,7 +1437,6 @@ static void platform_remove(struct device *_dev)
>=20
>         if (drv->remove)
>                 drv->remove(dev);
> -       dev_pm_domain_detach(_dev, true);
>  }
>=20
> but this would involve duplicating code, as, sooner or later, this would
> have to be done for other busses as well.
>=20
> Could you please let me know what option would you prefer so that I can go
> forward with it?
>=20
> Thank you for your review,
> Claudiu
>=20
> >=20
> > Note that dev->pm_domain is expected to be cleared by ->detach(), so
> > this should not cause the domain to be detached twice in a row from
> > the same device, but that needs to be double-checked.
> >=20
> > Thanks! =20
>=20


