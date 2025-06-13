Return-Path: <linux-iio+bounces-20583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7973AD88AC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA48189C6FF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BF291C3E;
	Fri, 13 Jun 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC49uMoZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3282DA748;
	Fri, 13 Jun 2025 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808947; cv=none; b=eEu1D5EKUxTQBoiHDbmyGfL7HElt9A/pijvz98yezHSF1p7Qh5k4NFh8JbGCZzUMUffWi1QRkMeN9Mx62crr+qPjt6pHLd1AFpy1P02YOhjiCljSY7kFQZKvQ2uLD7eB4rFZWXnWzY2tvincekjv27J9Dy9RcnE4km+joR7DDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808947; c=relaxed/simple;
	bh=gRTYPv8n7RPX68ovKWwQpPv6R/EmA7Fk41rJ4kGszzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwZTF1VkeJ3bMLu837rjiu6PG3JqpuNrcuq9ILeWkKLtCW2jWhUZzhBciH52q3K/hzlWffYekEO6GYuf0g49Nq/9fR4ySif/1Lm5RvzxA/pYlYWSU3GfR4AwW+FKNDYOnTsjVtdGRw06Rby/v/BtJHG8h/83WuayJSEvQbyhPFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC49uMoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D43AC4CEEB;
	Fri, 13 Jun 2025 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749808947;
	bh=gRTYPv8n7RPX68ovKWwQpPv6R/EmA7Fk41rJ4kGszzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rC49uMoZNt6COZRusTs2MFq0rcxWSlEJliwKrC2jR+IRWqM7dbWuDxDs83H5TEqd4
	 1T8v4XmJ7tDoiw6tf7O+2UXpkgjkSEqc67HgSrF/2/E+B9Yfp5zG2II+7lEtRbniiu
	 BgGXACMnvRJ6bR7L3Ite4ZmJm9R2qEhLXPKSRuDQa0aTQEMfvNn8hzUSVb2YME8Wys
	 SRiPWsYWB064hIYE/hMXhO/IFiM0dU4N1xTKgbKzDiN0nS7TqwA0QoUWzrskXiqcxn
	 4MJSJJ0JlUPlgP/R9uZl5cLS6Fh2ER2KSE2njF5uudDXJS20THFK+pFT6gAptG1E+k
	 4pJsdhKuG3OaQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2e8f84653c3so448575fac.0;
        Fri, 13 Jun 2025 03:02:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXBWmqYEdCNIzqePhxg45P8nhXoHCTh9ucy+bQ8cmz/O/MQ7NsKFY1xSf9Z5LeglvTCwTLPvrzMAA=@vger.kernel.org, AJvYcCVYfeL1LuBA45q1fYUPhdWmg/LysFZrZkpxApagNO0BubtBAbv1HkGy/c+dcctNGXkgD9VleYEFVI+q7Ni+O7HLoZc=@vger.kernel.org, AJvYcCWA5c2IGuDu03+rzETy7k0zGrQogt9+Ocuxm4S20rFF9tWfMreKTWYvsuCUe2DOir32g1rVMplF/7pVuUdQ@vger.kernel.org, AJvYcCX/r42gvdHQfvWh1M80nzOe8gTRXqqPY5csxt+oSrvGIVHHh7fOvB8oxle8+5X7h3bQqKS11mMIl14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbJ1o+P5KUc/8Y7FliHc/MiGkqLWbXCvv6Lrm87TegW7fXe3Q
	7YcbSPDWkb6cojmYB0n9/eBH9gzyBvzlrEv6iMVHQ6H1z0fiw2+apseOJYg3CHU6RIV4/GTgiK1
	Apx7xw8p7VZ7chCPJUW8eJRLnOtoAs/I=
X-Google-Smtp-Source: AGHT+IG6RV4SKL/zKEETYHAk5xh93JCc+BzoHPReRZCSi6kaiSZR+jx4L3gcXCRQIT8z6bjaF9DodMiBECMSXSOM7V8=
X-Received: by 2002:a05:6871:a516:b0:2e8:7953:ece7 with SMTP id
 586e51a60fabf-2ead50ecccdmr1375549fac.24.1749808946553; Fri, 13 Jun 2025
 03:02:26 -0700 (PDT)
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
 <486a1110-5336-42fd-82b8-a7b1452bad65@tuxon.dev>
In-Reply-To: <486a1110-5336-42fd-82b8-a7b1452bad65@tuxon.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Jun 2025 12:02:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
X-Gm-Features: AX0GCFvUpM5UGXUCp-G6WAFRkpKl3jKALA_qxwwQX1rDqdDt1ZJwTijYpfyF6q0
Message-ID: <CAJZ5v0hqBm4L2V9aUjB0tmW67eRRCnM7FScgdJQ=ihnpAZuMfA@mail.gmail.com>
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

On Fri, Jun 13, 2025 at 9:39=E2=80=AFAM Claudiu Beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Rafael,
>
> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> > On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >>
> >> On Fri, 6 Jun 2025 22:01:52 +0200
> >> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >>
> >> Hi Rafael,
> >>
> >>> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> >>> <dmitry.torokhov@gmail.com> wrote:
> >>>>
> >>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
> >>>>> On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxo=
n.dev> wrote:
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
sumed.
> >>>>>
> >>>>> Don't use devm_pm_runtime_enable() then.
> >>>>
> >>>> What about other devm_ APIs? Are you suggesting that platform driver=
s
> >>>> should not be using devm_clk*(), devm_regulator_*(),
> >>>> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> >>>> dev_pm_domain_detach() that is called by platform bus_remove() may s=
hut
> >>>> off the device too early, before cleanup code has a chance to execut=
e
> >>>> proper cleanup.
> >>>>
> >>>> The issue is not limited to runtime PM.
> >>>>
> >>>>>
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
> >>>>>> detach.
> >>>>>
> >>>>> dev_pm_domain_attach() is not part driver API and I'm not convinced=
 at
> >>>>
> >>>> Is the concern that devm_pm_domain_attach() will be [ab]used by driv=
ers?
> >>>
> >>> Yes, among other things.
> >>
> >> Maybe naming could make abuse at least obvious to spot? e.g.
> >> pm_domain_attach_with_devm_release()
> >
> > If I'm not mistaken, it is not even necessary to use devres for this.
> >
> > You might as well add a dev_pm_domain_detach() call to
> > device_unbind_cleanup() after devres_release_all().  There is a slight
> > complication related to the second argument of it, but I suppose that
> > this can be determined at the attach time and stored in a new device
> > PM flag, or similar.
> >
>
> I looked into this solution. I've tested it for all my failure cases and
> went good.

OK

> > Note that dev->pm_domain is expected to be cleared by ->detach(), so
> > this should not cause the domain to be detached twice in a row from
> > the same device, but that needs to be double-checked.
>
> The genpd_dev_pm_detach() calls genpd_remove_device() ->
> dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain =3D NULL. I ca=
n't
> find any other detach function in the current code base.

There is also acpi_dev_pm_detach() which can be somewhat hard to find,
but it calls dev_pm_domain_set(dev, NULL) either.

> The code I've tested for this solution is this one:
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b526e0e0f52d..5e9750d007b4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -25,6 +25,7 @@
>  #include <linux/kthread.h>
>  #include <linux/wait.h>
>  #include <linux/async.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
>  #include <linux/slab.h>
> @@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct device *dev=
)
>         dev->dma_range_map =3D NULL;
>         device_set_driver(dev, NULL);
>         dev_set_drvdata(dev, NULL);
> -       if (dev->pm_domain && dev->pm_domain->dismiss)
> -               dev->pm_domain->dismiss(dev);
> +       if (dev->pm_domain) {
> +               if (dev->pm_domain->dismiss)
> +                       dev->pm_domain->dismiss(dev);
> +               dev_pm_domain_detach(dev, dev->pm_domain->detach_power_of=
f);

I would do the "detach" before the "dismiss" to retain the current ordering=
.

Also it is interesting that you ended up calling them both in one
place.  It kind of indicates that the PM domains attached via
dev_pm_domain_attach() should be attached earlier and just use the
->activate() and ->dismiss() callbacks.

> +       }
>         pm_runtime_reinit(dev);
>         dev_pm_set_driver_flags(dev, 0);
>  }
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 075ec1d1b73a..2459be6aecf4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1400,11 +1400,8 @@ static int platform_probe(struct device *_dev)
>         if (ret)
>                 goto out;
>
> -       if (drv->probe) {
> +       if (drv->probe)
>                 ret =3D drv->probe(dev);
> -               if (ret)
> -                       dev_pm_domain_detach(_dev, true);
> -       }
>
>  out:
>         if (drv->prevent_deferred_probe && ret =3D=3D -EPROBE_DEFER) {
> @@ -1422,7 +1419,6 @@ static void platform_remove(struct device *_dev)
>
>         if (drv->remove)
>                 drv->remove(dev);
> -       dev_pm_domain_detach(_dev, true);
>  }
>
>  static void platform_shutdown(struct device *_dev)
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 781968a128ff..4bd1e3c7f401 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool pow=
er_on)
>         if (!ret)
>                 ret =3D genpd_dev_pm_attach(dev);
>
> +       if (dev->pm_domain)
> +               dev->pm_domain->detach_power_off =3D power_on;

This will not work for acpi_general_pm_domain because it is shared by
all of its users.

It is likely to not work for shared PM domains in general.

I would put the new flag into struct dev_pm_info.

> +
>         return ret < 0 ? ret : 0;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2..12e97e09e85c 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -748,6 +748,7 @@ struct dev_pm_domain {
>         void (*sync)(struct device *dev);
>         void (*dismiss)(struct device *dev);
>         int (*set_performance_state)(struct device *dev, unsigned int sta=
te);
> +       bool detach_power_off;
>  };
>
> Rafael, Ulf, Dmitry, Jonathan, all,
>
> Could you please let me know how do you consider this approach?

Please see my comments above.

Thanks!

