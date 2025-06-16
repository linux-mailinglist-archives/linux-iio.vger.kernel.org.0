Return-Path: <linux-iio+bounces-20707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FDDADAE2A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93AD516F0B7
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57C12D12EE;
	Mon, 16 Jun 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlbwGtG5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0A2D8DC5;
	Mon, 16 Jun 2025 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072754; cv=none; b=OYVcfBm2V/juww0BjxYlOJmwBYiwF66ImW404rsBxEPhlQS7h1rqkw9GgsPZNtxRa2RmNeOZ/8/FxqAlSWugiNPtl9fHz4vorde9mc58ls+Mck7oIHESvLLHZTHNxDtrm0zVAgDhyYCDO6kJ2Pvv8GvO613d8pVS95Ikh0PEFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072754; c=relaxed/simple;
	bh=b0CBhy1UUY6RQAjWRK15inB4LGY61RqJvVxUJtTtZug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/vZevNLjtHPUA+DlPmQElQSei4gqi90jIQ5c4qeVBFRQ+1p31DK+hUKw3w/8ScRw7+NZ/UklSCDhBe7gxMbVJClbB2rzU0L2nA/cI6dydQZ5YgSor+3EgbhkrW0c7gDxR80Rp6Q8euPxPXt4Gt/TGc0bu6z+GDhAvYyI4hFVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlbwGtG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F50C4CEF9;
	Mon, 16 Jun 2025 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750072754;
	bh=b0CBhy1UUY6RQAjWRK15inB4LGY61RqJvVxUJtTtZug=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GlbwGtG5TzzLNZiVwbk8BLn8L4HQdFUlIXQ+V89UxhvAFL8DrgM6HYrPvxvf4QUso
	 YqKOJ81pPbH6buRPGFiBcEdGVQ8THm2KdlXoDLlLBAZmwkUmiMy8e/nPo2+NGi+omZ
	 yIV08SMrvNAQyEdQbc9fCos8rddrDKNMg48ssHVA6TtRCklKqP8oTgAwCWbNqv+6La
	 1EQQ7xZYKfzaTuLnxwTHoXXkrzteqfPcDpUL7/2bpjnDwR3qmuWAaKFZLzW83oBveI
	 MHILqomGCwvj3RgRJYqhDrxpwLnLARytCKh+ewH/Ox1vLQg06yZbjF5vQj/zODXqSX
	 zAewjuwgfrRBw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-40a8013d961so343892b6e.0;
        Mon, 16 Jun 2025 04:19:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWeevscf45HMdHzym//8IAIA/N7BCiLvTdxl5w2NGaLKFG+W+tgo+slsgMR8IGMFy41SvZzaFIWxfAYNEm5vBHdwU=@vger.kernel.org, AJvYcCVg1NpYJ4jQsLeIr9rUiRJ4w0bTSuTxrhK5HpUdA60xfsbM1LNXZCCuDeplUHvr+zM0DHf7nev14k4=@vger.kernel.org, AJvYcCX0/+yk3S6pUfF+c5KrhtnP3BJ9v6dJqA/EV+pKcZNbAMIwRtkgi0aEDnJ7AWylZrnOgAJ88Qv89eo=@vger.kernel.org, AJvYcCXkkcXt7YOkz3QB2lsGclAmQvvWIsN9TVoq6LdGFVEaRQJup2c/ovzB+9vwiyjrRXyZoq2OJE6A+BG87Wob@vger.kernel.org
X-Gm-Message-State: AOJu0YxFP+6UQ7PxICCZwm5QH6kWWDt0Pa51vaaoHKVOkrnWjA//dW0L
	DknxJtvFLQ+dQDvvqu2oY+80pvg5eH5lootktB1gTsSRC0X3jiHmZmcNCkbAChN+rRxLSjSKBhD
	GYSe7iu50XYoxAnhfOGlgE2YeEe6QLS8=
X-Google-Smtp-Source: AGHT+IFIdK/xkxk77cnZy0Cm6/R+PNFce5d8K+8kPQ6q9qb7aLWtfpLTmlk+HjpqwbhEqXt4Pm3+ojMisIzpuo2az5E=
X-Received: by 2002:a05:6808:2202:b0:402:a5c:906 with SMTP id
 5614622812f47-40a7c243137mr6201985b6e.34.1750072753372; Mon, 16 Jun 2025
 04:19:13 -0700 (PDT)
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
 <4360ee7a-d85a-4fa0-a1d6-d09a3b9d57c0@tuxon.dev>
In-Reply-To: <4360ee7a-d85a-4fa0-a1d6-d09a3b9d57c0@tuxon.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 13:18:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUGf9QO6h6bcBcTX+nUbDeD0XMhWj1Qb-0qAtZ8EbVsA@mail.gmail.com>
X-Gm-Features: AX0GCFsskiKxdqcuWf29xGUq34Ci2iGQMqSmY7x7YqlG91Fk62ew4emjKZASyuw
Message-ID: <CAJZ5v0jUGf9QO6h6bcBcTX+nUbDeD0XMhWj1Qb-0qAtZ8EbVsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, gregkh@linuxfoundation.org, dakr@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 11:37=E2=80=AFAM Claudiu Beznea
<claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Rafael,
>
> On 13.06.2025 13:02, Rafael J. Wysocki wrote:
> > On Fri, Jun 13, 2025 at 9:39=E2=80=AFAM Claudiu Beznea <claudiu.beznea@=
tuxon.dev> wrote:
> >>
> >> Hi, Rafael,
> >>
> >> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> >>> On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> >>>>
> >>>> On Fri, 6 Jun 2025 22:01:52 +0200
> >>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >>>>
> >>>> Hi Rafael,
> >>>>
> >>>>> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> >>>>> <dmitry.torokhov@gmail.com> wrote:
> >>>>>>
> >>>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
> >>>>>>> On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tu=
xon.dev> wrote:
> >>>>>>>>
> >>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>>>>
> >>>>>>>> The dev_pm_domain_attach() function is typically used in bus cod=
e alongside
> >>>>>>>> dev_pm_domain_detach(), often following patterns like:
> >>>>>>>>
> >>>>>>>> static int bus_probe(struct device *_dev)
> >>>>>>>> {
> >>>>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >>>>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> >>>>>>>>     int ret;
> >>>>>>>>
> >>>>>>>>     // ...
> >>>>>>>>
> >>>>>>>>     ret =3D dev_pm_domain_attach(_dev, true);
> >>>>>>>>     if (ret)
> >>>>>>>>         return ret;
> >>>>>>>>
> >>>>>>>>     if (drv->probe)
> >>>>>>>>         ret =3D drv->probe(dev);
> >>>>>>>>
> >>>>>>>>     // ...
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> static void bus_remove(struct device *_dev)
> >>>>>>>> {
> >>>>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >>>>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> >>>>>>>>
> >>>>>>>>     if (drv->remove)
> >>>>>>>>         drv->remove(dev);
> >>>>>>>>     dev_pm_domain_detach(_dev);
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> When the driver's probe function uses devres-managed resources t=
hat depend
> >>>>>>>> on the power domain state, those resources are released later du=
ring
> >>>>>>>> device_unbind_cleanup().
> >>>>>>>>
> >>>>>>>> Releasing devres-managed resources that depend on the power doma=
in state
> >>>>>>>> after detaching the device from its PM domain can cause failures=
.
> >>>>>>>>
> >>>>>>>> For example, if the driver uses devm_pm_runtime_enable() in its =
probe
> >>>>>>>> function, and the device's clocks are managed by the PM domain, =
then
> >>>>>>>> during removal the runtime PM is disabled in device_unbind_clean=
up() after
> >>>>>>>> the clocks have been removed from the PM domain. It may happen t=
hat the
> >>>>>>>> devm_pm_runtime_enable() action causes the device to be runtime-=
resumed.
> >>>>>>>
> >>>>>>> Don't use devm_pm_runtime_enable() then.
> >>>>>>
> >>>>>> What about other devm_ APIs? Are you suggesting that platform driv=
ers
> >>>>>> should not be using devm_clk*(), devm_regulator_*(),
> >>>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again=
,
> >>>>>> dev_pm_domain_detach() that is called by platform bus_remove() may=
 shut
> >>>>>> off the device too early, before cleanup code has a chance to exec=
ute
> >>>>>> proper cleanup.
> >>>>>>
> >>>>>> The issue is not limited to runtime PM.
> >>>>>>
> >>>>>>>
> >>>>>>>> If the driver specific runtime PM APIs access registers directly=
, this
> >>>>>>>> will lead to accessing device registers without clocks being ena=
bled.
> >>>>>>>> Similar issues may occur with other devres actions that access d=
evice
> >>>>>>>> registers.
> >>>>>>>>
> >>>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_at=
tach() and
> >>>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures t=
hat the
> >>>>>>>> device is detached from its PM domain in device_unbind_cleanup()=
, only
> >>>>>>>> after all driver's devres-managed resources have been release.
> >>>>>>>>
> >>>>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2 s=
tate
> >>>>>>>> arguments, one for the domain state on attach, one for the domai=
n state on
> >>>>>>>> detach.
> >>>>>>>
> >>>>>>> dev_pm_domain_attach() is not part driver API and I'm not convinc=
ed at
> >>>>>>
> >>>>>> Is the concern that devm_pm_domain_attach() will be [ab]used by dr=
ivers?
> >>>>>
> >>>>> Yes, among other things.
> >>>>
> >>>> Maybe naming could make abuse at least obvious to spot? e.g.
> >>>> pm_domain_attach_with_devm_release()
> >>>
> >>> If I'm not mistaken, it is not even necessary to use devres for this.
> >>>
> >>> You might as well add a dev_pm_domain_detach() call to
> >>> device_unbind_cleanup() after devres_release_all().  There is a sligh=
t
> >>> complication related to the second argument of it, but I suppose that
> >>> this can be determined at the attach time and stored in a new device
> >>> PM flag, or similar.
> >>>
> >>
> >> I looked into this solution. I've tested it for all my failure cases a=
nd
> >> went good.
> >
> > OK
> >
> >>> Note that dev->pm_domain is expected to be cleared by ->detach(), so
> >>> this should not cause the domain to be detached twice in a row from
> >>> the same device, but that needs to be double-checked.
> >>
> >> The genpd_dev_pm_detach() calls genpd_remove_device() ->
> >> dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain =3D NULL. I=
 can't
> >> find any other detach function in the current code base.
> >
> > There is also acpi_dev_pm_detach() which can be somewhat hard to find,
> > but it calls dev_pm_domain_set(dev, NULL) either.
> >
> >> The code I've tested for this solution is this one:
> >>
> >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >> index b526e0e0f52d..5e9750d007b4 100644
> >> --- a/drivers/base/dd.c
> >> +++ b/drivers/base/dd.c
> >> @@ -25,6 +25,7 @@
> >>  #include <linux/kthread.h>
> >>  #include <linux/wait.h>
> >>  #include <linux/async.h>
> >> +#include <linux/pm_domain.h>
> >>  #include <linux/pm_runtime.h>
> >>  #include <linux/pinctrl/devinfo.h>
> >>  #include <linux/slab.h>
> >> @@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct device *=
dev)
> >>         dev->dma_range_map =3D NULL;
> >>         device_set_driver(dev, NULL);
> >>         dev_set_drvdata(dev, NULL);
> >> -       if (dev->pm_domain && dev->pm_domain->dismiss)
> >> -               dev->pm_domain->dismiss(dev);
> >> +       if (dev->pm_domain) {
> >> +               if (dev->pm_domain->dismiss)
> >> +                       dev->pm_domain->dismiss(dev);
> >> +               dev_pm_domain_detach(dev, dev->pm_domain->detach_power=
_off);
> >
> > I would do the "detach" before the "dismiss" to retain the current orde=
ring.
>
> I applied on my local development branch all your suggestions except this
> one because genpd_dev_pm_detach() as well as acpi_dev_pm_detach() set
> dev->pm_domain =3D NULL.
>
> Due to this I would call first ->dismiss() then ->detach(), as initially
> proposed. Please let me know if you consider it otherwise.

This is a matter of adding one more dev->pm_domain check AFAICS, but OK.

