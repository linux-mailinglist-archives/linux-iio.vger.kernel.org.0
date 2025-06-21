Return-Path: <linux-iio+bounces-20809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EB7AE28BD
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 13:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F03189D372
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6B1FF1D5;
	Sat, 21 Jun 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC9pDlRG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D782642AB4;
	Sat, 21 Jun 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750504562; cv=none; b=TF8XGgHqVYKMvURdTOmgKI8euPG1Y9sogO6/qgv4Io8z4bVc8oLTGpnVi5RV7bEJ7cCom+mgO3AbPn+LA277GYSXOOLpKIqRxzb/BCr6mZ/wW1jsFEhdwkY2YgUhIw0KKClscZdP0cIbQV5PFz3QhhyjKwpe1ob4gdzHthDSEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750504562; c=relaxed/simple;
	bh=AglLGwocXb7aYtZZ84ovAUyXmvMiTYg9wjTzyeUCXEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f49fQ92mNgGfDgZpC50qqEWcthK2KR+stB1HZoJJuqqv8B4ijU40rDnNhR6MWr4pD9++vpgeQUWRRcrzYWL4E/azkLqajGJvi/wFG2Xz/yc9Qt90j3Hb1hyGs1ZA97nkXjwD6aJSyO75oECUqi/6DRrGs12Ud67Vi8CbGzWijq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC9pDlRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585FBC4CEEF;
	Sat, 21 Jun 2025 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750504561;
	bh=AglLGwocXb7aYtZZ84ovAUyXmvMiTYg9wjTzyeUCXEM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TC9pDlRGvXMO3W1b7lZBugdA7ZJ7Ubj7gFCB6UhpvJ5FtLuKbaFRmEbgSxzd/YM24
	 uaHc5XUvl1KsW1VANmRUdwdU4y2xLvoPn/rdSczYAk/9pHe49xCaFD80SFzE6Xja16
	 RtkSGjSOlUlhZ9jV6QsHaurMbMS8j75Yim+1ue2TsFTdyHKt2T300xbJVwNNrmUL6S
	 vZrncN2zgTBinBnylJ8RMKzcjQxyyqZgkLC+PBP9iBkSYxEPrDOBj2TRcdDFAI5D9+
	 HIWzF5XHdPsPQSU6/vVPcSNL7TBt7bcM088N9XImVAo+qOx8Z5Mq0Xko5o/10OErYh
	 7F2Dmfhg4acoQ==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-40aa391ce1aso689578b6e.2;
        Sat, 21 Jun 2025 04:16:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGgSI6I972xeiIP77tsWjt2YwJoAwfKjQIpxRdb1u4nYKOeTb4X6rBa9R+rfVTqeLq/Ukunhj2zKZj9QZC4o9BhbQ=@vger.kernel.org, AJvYcCUu/g2Hmf9kYU6l5h5FVL+bbww9FyBMl9eFumaUEfxgHZOLyyD116G3SiX4P2R0e0ZihPBDik5Aavjfj+Xu@vger.kernel.org, AJvYcCW8HfCQ2kNswvFoVrYbdxcCCx2kmlEDoh/K67bfPVox77xFyiK2C/jX89ESMHh6YwkFPyjt2jajkOA=@vger.kernel.org, AJvYcCWPnt5+pkRiTS4whqIdt5Eps7Fg8MG+SpH5lhUioaX82cBLpx2H9+u2Y/2Fcmqp8XuatxjcEyizZdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxODi5s/dPYcyxVgESG2YMa+6J7s3bTttqDMLe4dOdAbwbp45SR
	NstW+GyUX8PkH9vXXbwKEhpxaaf3mgrev/pp8VP8OG5yVwoaTy0g3wm3+YNmpL1/mhR9cl6v62h
	ryWmOgt4v4+HYgj7CVBWbORwskOdJYL8=
X-Google-Smtp-Source: AGHT+IFGueWEojM0Zq5uPTqJZRx+6Q38CSHBAAndFQkQXqugs5N7VGTk2OIYJ+3bbjPqEMxxrjyzt3bDH+zW6yF9EMA=
X-Received: by 2002:a05:6870:a54d:b0:2c1:62e9:584b with SMTP id
 586e51a60fabf-2eeee65ae81mr3508649fac.39.1750504560571; Sat, 21 Jun 2025
 04:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
 <20250607140600.76e87ea5@jic23-huawei> <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
 <486a1110-5336-42fd-82b8-a7b1452bad65@tuxon.dev> <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
 <4360ee7a-d85a-4fa0-a1d6-d09a3b9d57c0@tuxon.dev> <CAJZ5v0jUGf9QO6h6bcBcTX+nUbDeD0XMhWj1Qb-0qAtZ8EbVsA@mail.gmail.com>
 <1b83c587-76c2-4fa1-aef8-f94575a3627a@tuxon.dev> <CAJZ5v0jZNX+FCmu_FeRPS47F37AmyAN25+7LJvzbqRdvs-aGcQ@mail.gmail.com>
 <CAPDyKFq9at+aA+OG__ZHvhc3AELfUOyOakH7a=MGHrbAjzL8OA@mail.gmail.com>
In-Reply-To: <CAPDyKFq9at+aA+OG__ZHvhc3AELfUOyOakH7a=MGHrbAjzL8OA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 21 Jun 2025 13:15:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hi2N9iFy-Dh0mkN3zDBytMFXqxosujbPGO5JxnWhBxmg@mail.gmail.com>
X-Gm-Features: AX0GCFvoJozWLVAwBLoX9Vrp18nN2uNK09JD8vUmh6r6GiFPTGTEkUEj71DQfGc
Message-ID: <CAJZ5v0hi2N9iFy-Dh0mkN3zDBytMFXqxosujbPGO5JxnWhBxmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org, 
	dakr@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 2:21=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Mon, 16 Jun 2025 at 13:47, Rafael J. Wysocki <rafael@kernel.org> wrote=
:
> >
> > On Mon, Jun 16, 2025 at 1:37=E2=80=AFPM Claudiu Beznea <claudiu.beznea@=
tuxon.dev> wrote:
> > >
> > >
> > >
> > > On 16.06.2025 14:18, Rafael J. Wysocki wrote:
> > > > On Mon, Jun 16, 2025 at 11:37=E2=80=AFAM Claudiu Beznea
> > > > <claudiu.beznea@tuxon.dev> wrote:
> > > >>
> > > >> Hi, Rafael,
> > > >>
> > > >> On 13.06.2025 13:02, Rafael J. Wysocki wrote:
> > > >>> On Fri, Jun 13, 2025 at 9:39=E2=80=AFAM Claudiu Beznea <claudiu.b=
eznea@tuxon.dev> wrote:
> > > >>>>
> > > >>>> Hi, Rafael,
> > > >>>>
> > > >>>> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> > > >>>>> On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@=
kernel.org> wrote:
> > > >>>>>>
> > > >>>>>> On Fri, 6 Jun 2025 22:01:52 +0200
> > > >>>>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >>>>>>
> > > >>>>>> Hi Rafael,
> > > >>>>>>
> > > >>>>>>> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> > > >>>>>>> <dmitry.torokhov@gmail.com> wrote:
> > > >>>>>>>>
> > > >>>>>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki =
wrote:
> > > >>>>>>>>> On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.bez=
nea@tuxon.dev> wrote:
> > > >>>>>>>>>>
> > > >>>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > >>>>>>>>>>
> > > >>>>>>>>>> The dev_pm_domain_attach() function is typically used in b=
us code alongside
> > > >>>>>>>>>> dev_pm_domain_detach(), often following patterns like:
> > > >>>>>>>>>>
> > > >>>>>>>>>> static int bus_probe(struct device *_dev)
> > > >>>>>>>>>> {
> > > >>>>>>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > >>>>>>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> > > >>>>>>>>>>     int ret;
> > > >>>>>>>>>>
> > > >>>>>>>>>>     // ...
> > > >>>>>>>>>>
> > > >>>>>>>>>>     ret =3D dev_pm_domain_attach(_dev, true);
> > > >>>>>>>>>>     if (ret)
> > > >>>>>>>>>>         return ret;
> > > >>>>>>>>>>
> > > >>>>>>>>>>     if (drv->probe)
> > > >>>>>>>>>>         ret =3D drv->probe(dev);
> > > >>>>>>>>>>
> > > >>>>>>>>>>     // ...
> > > >>>>>>>>>> }
> > > >>>>>>>>>>
> > > >>>>>>>>>> static void bus_remove(struct device *_dev)
> > > >>>>>>>>>> {
> > > >>>>>>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > >>>>>>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> > > >>>>>>>>>>
> > > >>>>>>>>>>     if (drv->remove)
> > > >>>>>>>>>>         drv->remove(dev);
> > > >>>>>>>>>>     dev_pm_domain_detach(_dev);
> > > >>>>>>>>>> }
> > > >>>>>>>>>>
> > > >>>>>>>>>> When the driver's probe function uses devres-managed resou=
rces that depend
> > > >>>>>>>>>> on the power domain state, those resources are released la=
ter during
> > > >>>>>>>>>> device_unbind_cleanup().
> > > >>>>>>>>>>
> > > >>>>>>>>>> Releasing devres-managed resources that depend on the powe=
r domain state
> > > >>>>>>>>>> after detaching the device from its PM domain can cause fa=
ilures.
> > > >>>>>>>>>>
> > > >>>>>>>>>> For example, if the driver uses devm_pm_runtime_enable() i=
n its probe
> > > >>>>>>>>>> function, and the device's clocks are managed by the PM do=
main, then
> > > >>>>>>>>>> during removal the runtime PM is disabled in device_unbind=
_cleanup() after
> > > >>>>>>>>>> the clocks have been removed from the PM domain. It may ha=
ppen that the
> > > >>>>>>>>>> devm_pm_runtime_enable() action causes the device to be ru=
ntime-resumed.
> > > >>>>>>>>>
> > > >>>>>>>>> Don't use devm_pm_runtime_enable() then.
> > > >>>>>>>>
> > > >>>>>>>> What about other devm_ APIs? Are you suggesting that platfor=
m drivers
> > > >>>>>>>> should not be using devm_clk*(), devm_regulator_*(),
> > > >>>>>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because=
 again,
> > > >>>>>>>> dev_pm_domain_detach() that is called by platform bus_remove=
() may shut
> > > >>>>>>>> off the device too early, before cleanup code has a chance t=
o execute
> > > >>>>>>>> proper cleanup.
> > > >>>>>>>>
> > > >>>>>>>> The issue is not limited to runtime PM.
> > > >>>>>>>>
> > > >>>>>>>>>
> > > >>>>>>>>>> If the driver specific runtime PM APIs access registers di=
rectly, this
> > > >>>>>>>>>> will lead to accessing device registers without clocks bei=
ng enabled.
> > > >>>>>>>>>> Similar issues may occur with other devres actions that ac=
cess device
> > > >>>>>>>>>> registers.
> > > >>>>>>>>>>
> > > >>>>>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_dom=
ain_attach() and
> > > >>>>>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ens=
ures that the
> > > >>>>>>>>>> device is detached from its PM domain in device_unbind_cle=
anup(), only
> > > >>>>>>>>>> after all driver's devres-managed resources have been rele=
ase.
> > > >>>>>>>>>>
> > > >>>>>>>>>> For flexibility, the implemented devm_pm_domain_attach() h=
as 2 state
> > > >>>>>>>>>> arguments, one for the domain state on attach, one for the=
 domain state on
> > > >>>>>>>>>> detach.
> > > >>>>>>>>>
> > > >>>>>>>>> dev_pm_domain_attach() is not part driver API and I'm not c=
onvinced at
> > > >>>>>>>>
> > > >>>>>>>> Is the concern that devm_pm_domain_attach() will be [ab]used=
 by drivers?
> > > >>>>>>>
> > > >>>>>>> Yes, among other things.
> > > >>>>>>
> > > >>>>>> Maybe naming could make abuse at least obvious to spot? e.g.
> > > >>>>>> pm_domain_attach_with_devm_release()
> > > >>>>>
> > > >>>>> If I'm not mistaken, it is not even necessary to use devres for=
 this.
> > > >>>>>
> > > >>>>> You might as well add a dev_pm_domain_detach() call to
> > > >>>>> device_unbind_cleanup() after devres_release_all().  There is a=
 slight
> > > >>>>> complication related to the second argument of it, but I suppos=
e that
> > > >>>>> this can be determined at the attach time and stored in a new d=
evice
> > > >>>>> PM flag, or similar.
> > > >>>>>
> > > >>>>
> > > >>>> I looked into this solution. I've tested it for all my failure c=
ases and
> > > >>>> went good.
> > > >>>
> > > >>> OK
> > > >>>
> > > >>>>> Note that dev->pm_domain is expected to be cleared by ->detach(=
), so
> > > >>>>> this should not cause the domain to be detached twice in a row =
from
> > > >>>>> the same device, but that needs to be double-checked.
> > > >>>>
> > > >>>> The genpd_dev_pm_detach() calls genpd_remove_device() ->
> > > >>>> dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain =3D N=
ULL. I can't
> > > >>>> find any other detach function in the current code base.
> > > >>>
> > > >>> There is also acpi_dev_pm_detach() which can be somewhat hard to =
find,
> > > >>> but it calls dev_pm_domain_set(dev, NULL) either.
> > > >>>
> > > >>>> The code I've tested for this solution is this one:
> > > >>>>
> > > >>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > >>>> index b526e0e0f52d..5e9750d007b4 100644
> > > >>>> --- a/drivers/base/dd.c
> > > >>>> +++ b/drivers/base/dd.c
> > > >>>> @@ -25,6 +25,7 @@
> > > >>>>  #include <linux/kthread.h>
> > > >>>>  #include <linux/wait.h>
> > > >>>>  #include <linux/async.h>
> > > >>>> +#include <linux/pm_domain.h>
> > > >>>>  #include <linux/pm_runtime.h>
> > > >>>>  #include <linux/pinctrl/devinfo.h>
> > > >>>>  #include <linux/slab.h>
> > > >>>> @@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct de=
vice *dev)
> > > >>>>         dev->dma_range_map =3D NULL;
> > > >>>>         device_set_driver(dev, NULL);
> > > >>>>         dev_set_drvdata(dev, NULL);
> > > >>>> -       if (dev->pm_domain && dev->pm_domain->dismiss)
> > > >>>> -               dev->pm_domain->dismiss(dev);
> > > >>>> +       if (dev->pm_domain) {
> > > >>>> +               if (dev->pm_domain->dismiss)
> > > >>>> +                       dev->pm_domain->dismiss(dev);
> > > >>>> +               dev_pm_domain_detach(dev, dev->pm_domain->detach=
_power_off);
> > > >>>
> > > >>> I would do the "detach" before the "dismiss" to retain the curren=
t ordering.
> > > >>
> > > >> I applied on my local development branch all your suggestions exce=
pt this
> > > >> one because genpd_dev_pm_detach() as well as acpi_dev_pm_detach() =
set
> > > >> dev->pm_domain =3D NULL.
> > > >>
> > > >> Due to this I would call first ->dismiss() then ->detach(), as ini=
tially
> > > >> proposed. Please let me know if you consider it otherwise.
> > > >
> > > > This is a matter of adding one more dev->pm_domain check AFAICS, bu=
t OK.
> > >
> > > I don't know all the subtleties around this, my concern with adding o=
ne
> > > more check on dev->pm_domain was that the
> > > dev->pm_domain->dismiss() will never be called if the ->detach() func=
tion
> > > will be called before ->dismiss() and it will set dev->pm_domain =3D =
NULL (as
> > > it does today (though genpd_dev_pm_detach() and acpi_dev_pm_detach())=
).
> > >
> > > For platform drivers that used to call dev_pm_domain_detach() in plat=
form
> > > bus remove function, if I'm not wrong, the dev->pm_domain->dismiss() =
was
> > > never called previously. If that is a valid scenario, the code propos=
ed in
> > > this thread will change the behavior for devices that have ->dismiss(=
)
> > > implemented.
> >
> > ->dismiss() and ->detach() are supposed to be mutually exclusive, so
> > this should not be a problem either way and in practice so far the
> > only user of ->dismiss() has been acpi_lpss_pm_domain which doesn't do
> > ->detach() at all.
>
> May I ask if you know if there remains any real good reasons to keep
> the ->dismiss() callback around?
>
> Can't acpi_lpss_pm_domain() convert to use the ->detach() callback
> instead? Just thinking that it would be easier, but maybe it doesn't
> work.

It will, but let's just not make too many changes in one go.

