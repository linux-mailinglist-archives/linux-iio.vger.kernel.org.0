Return-Path: <linux-iio+bounces-20709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B5ADAF06
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4424B173261
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9A2D5C99;
	Mon, 16 Jun 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URvOi5I8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E9280A20;
	Mon, 16 Jun 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074436; cv=none; b=DFXs57sCfdL+Rb0rtOkpxGJQJBDJ0tRTGbVLhWqZrMDKIOikrCbPNNoKC/asWycs68oKg9Txw7vDuCxCG0O9CxWRGDBDd4GTTFGppVWeLU6vlzGzyytInRSe9l6EMtNCkUP5yknTl+Y1FYYlUj3lLXABxljuyxnq2A+y8WmMst0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074436; c=relaxed/simple;
	bh=/eA8d5ou+QrxMJUggFyDY7E6MCcB+oR9ejcs6j5ByGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kt3gcJxpKGDqse4lStaVCqx7ZjowdELQhmyx6X2H83+1OpgUj9LoPCabu2Zu5egxdPCkhemQybyn88wXnqIZ6qDuo6Fpksy2bWLBcrCIKbmjjDHqtBgw2UA4e4FvlzfCN2jw6A6vncg/Lr/v+VnoZWgCHRn7Z+daLBEH34p7FJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URvOi5I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EE7C4CEF0;
	Mon, 16 Jun 2025 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750074435;
	bh=/eA8d5ou+QrxMJUggFyDY7E6MCcB+oR9ejcs6j5ByGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=URvOi5I8F1UkkxLoayFwXSuV/hQtiAoFEs9Tx/FNsfPDRgph0Z4JgFUnj/64rHj5/
	 wi8WEsnwWG+krHdknDSAoeZ9GDYHTH/22vjo83JrsgZvYJCtS41V5FiSQmhFN3a1UN
	 g7M4F4wutYovu1c/D8HJgQzSCb1j4XLPpUoTTRci3FNP7Rm1rR69wMnlQu7FdDusLI
	 N4xJ8WCw8Pv+Sdl+4YNYtWrvRx2CVfj62PlSZkhiOVXLADFDrSKvyJFOklNWAegaUE
	 I3WRGI3E1aBiRX8BMf5uuIWbnhgCmBt+7IaSFkhLwb5d2Fl79kITCyOi8SllW5S9fc
	 CeBWMBPdwthUw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2d0920ce388so1822087fac.0;
        Mon, 16 Jun 2025 04:47:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQrh3+rsLcwF6wz4yCilynqjAk8jlLGCauhatD+D4hYt1DLEJgK2BqH6plxMdcj8m0J8pppATOEMk=@vger.kernel.org, AJvYcCUzTI9lXwWkg7YEi5E1KojkaIE8NB1n2U1W88ZoJQ3qY88G1Sfsjxq1HAVRz8Uzb+nLqgNrGWk5dbOIs+SS@vger.kernel.org, AJvYcCV3Fo8oBWXVkOfGsWaObunYn+bnyGyrUYkwLJdhDCXwT9wMH52Ae3wMa3vulJ3FCKpzoLSKktmyF+8=@vger.kernel.org, AJvYcCWEQA17eaAob1YYZA3VpZuSp8GUCtFoTTuMjd8kfIJqrCuvCUrwcvSUqnKp7nnwD75QepKkWTXmQjPXN4lgTsiCS9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzim7R1jVrVi21N0lmMqeD5zO0VypsTYABWbFWNyYdx+XagygNi
	Mg4IB3AIApobkMi1cKb3XD6Pqnrs3ZBiHITiXen2dDZ8Ako0SMfE9TV2PoK9SXd1hfE/crYOQX8
	vuVDVMkBt9CkU+j+tVGvZgDh8SSsL354=
X-Google-Smtp-Source: AGHT+IHbh0MXtcJNYvuStoSaOuvHq7lbFdoHR2M8Gvp/7pdZF6exwkhuPad/zdvZbEayRx1j7YnFebZQjWJG6S4MMnw=
X-Received: by 2002:a05:6870:aa06:b0:2b7:d3f1:dc72 with SMTP id
 586e51a60fabf-2eaf0b84ae4mr6057529fac.29.1750074434780; Mon, 16 Jun 2025
 04:47:14 -0700 (PDT)
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
 <1b83c587-76c2-4fa1-aef8-f94575a3627a@tuxon.dev>
In-Reply-To: <1b83c587-76c2-4fa1-aef8-f94575a3627a@tuxon.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 13:47:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jZNX+FCmu_FeRPS47F37AmyAN25+7LJvzbqRdvs-aGcQ@mail.gmail.com>
X-Gm-Features: AX0GCFtXfRR-RCZjpXtQLu0J-EKxWYotca2xYlLz7wehgjpO1aKv8en2jRNotC8
Message-ID: <CAJZ5v0jZNX+FCmu_FeRPS47F37AmyAN25+7LJvzbqRdvs-aGcQ@mail.gmail.com>
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

On Mon, Jun 16, 2025 at 1:37=E2=80=AFPM Claudiu Beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
>
>
> On 16.06.2025 14:18, Rafael J. Wysocki wrote:
> > On Mon, Jun 16, 2025 at 11:37=E2=80=AFAM Claudiu Beznea
> > <claudiu.beznea@tuxon.dev> wrote:
> >>
> >> Hi, Rafael,
> >>
> >> On 13.06.2025 13:02, Rafael J. Wysocki wrote:
> >>> On Fri, Jun 13, 2025 at 9:39=E2=80=AFAM Claudiu Beznea <claudiu.bezne=
a@tuxon.dev> wrote:
> >>>>
> >>>> Hi, Rafael,
> >>>>
> >>>> On 09.06.2025 22:59, Rafael J. Wysocki wrote:
> >>>>> On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kern=
el.org> wrote:
> >>>>>>
> >>>>>> On Fri, 6 Jun 2025 22:01:52 +0200
> >>>>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >>>>>>
> >>>>>> Hi Rafael,
> >>>>>>
> >>>>>>> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> >>>>>>> <dmitry.torokhov@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrot=
e:
> >>>>>>>>> On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@=
tuxon.dev> wrote:
> >>>>>>>>>>
> >>>>>>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>>>>>>
> >>>>>>>>>> The dev_pm_domain_attach() function is typically used in bus c=
ode alongside
> >>>>>>>>>> dev_pm_domain_detach(), often following patterns like:
> >>>>>>>>>>
> >>>>>>>>>> static int bus_probe(struct device *_dev)
> >>>>>>>>>> {
> >>>>>>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >>>>>>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> >>>>>>>>>>     int ret;
> >>>>>>>>>>
> >>>>>>>>>>     // ...
> >>>>>>>>>>
> >>>>>>>>>>     ret =3D dev_pm_domain_attach(_dev, true);
> >>>>>>>>>>     if (ret)
> >>>>>>>>>>         return ret;
> >>>>>>>>>>
> >>>>>>>>>>     if (drv->probe)
> >>>>>>>>>>         ret =3D drv->probe(dev);
> >>>>>>>>>>
> >>>>>>>>>>     // ...
> >>>>>>>>>> }
> >>>>>>>>>>
> >>>>>>>>>> static void bus_remove(struct device *_dev)
> >>>>>>>>>> {
> >>>>>>>>>>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >>>>>>>>>>     struct bus_device *dev =3D to_bus_device(_dev);
> >>>>>>>>>>
> >>>>>>>>>>     if (drv->remove)
> >>>>>>>>>>         drv->remove(dev);
> >>>>>>>>>>     dev_pm_domain_detach(_dev);
> >>>>>>>>>> }
> >>>>>>>>>>
> >>>>>>>>>> When the driver's probe function uses devres-managed resources=
 that depend
> >>>>>>>>>> on the power domain state, those resources are released later =
during
> >>>>>>>>>> device_unbind_cleanup().
> >>>>>>>>>>
> >>>>>>>>>> Releasing devres-managed resources that depend on the power do=
main state
> >>>>>>>>>> after detaching the device from its PM domain can cause failur=
es.
> >>>>>>>>>>
> >>>>>>>>>> For example, if the driver uses devm_pm_runtime_enable() in it=
s probe
> >>>>>>>>>> function, and the device's clocks are managed by the PM domain=
, then
> >>>>>>>>>> during removal the runtime PM is disabled in device_unbind_cle=
anup() after
> >>>>>>>>>> the clocks have been removed from the PM domain. It may happen=
 that the
> >>>>>>>>>> devm_pm_runtime_enable() action causes the device to be runtim=
e-resumed.
> >>>>>>>>>
> >>>>>>>>> Don't use devm_pm_runtime_enable() then.
> >>>>>>>>
> >>>>>>>> What about other devm_ APIs? Are you suggesting that platform dr=
ivers
> >>>>>>>> should not be using devm_clk*(), devm_regulator_*(),
> >>>>>>>> devm_request_*_irq() and devm_add_action_or_reset()? Because aga=
in,
> >>>>>>>> dev_pm_domain_detach() that is called by platform bus_remove() m=
ay shut
> >>>>>>>> off the device too early, before cleanup code has a chance to ex=
ecute
> >>>>>>>> proper cleanup.
> >>>>>>>>
> >>>>>>>> The issue is not limited to runtime PM.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> If the driver specific runtime PM APIs access registers direct=
ly, this
> >>>>>>>>>> will lead to accessing device registers without clocks being e=
nabled.
> >>>>>>>>>> Similar issues may occur with other devres actions that access=
 device
> >>>>>>>>>> registers.
> >>>>>>>>>>
> >>>>>>>>>> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_=
attach() and
> >>>>>>>>>> dev_pm_domain_detach() in bus probe and bus remove, it ensures=
 that the
> >>>>>>>>>> device is detached from its PM domain in device_unbind_cleanup=
(), only
> >>>>>>>>>> after all driver's devres-managed resources have been release.
> >>>>>>>>>>
> >>>>>>>>>> For flexibility, the implemented devm_pm_domain_attach() has 2=
 state
> >>>>>>>>>> arguments, one for the domain state on attach, one for the dom=
ain state on
> >>>>>>>>>> detach.
> >>>>>>>>>
> >>>>>>>>> dev_pm_domain_attach() is not part driver API and I'm not convi=
nced at
> >>>>>>>>
> >>>>>>>> Is the concern that devm_pm_domain_attach() will be [ab]used by =
drivers?
> >>>>>>>
> >>>>>>> Yes, among other things.
> >>>>>>
> >>>>>> Maybe naming could make abuse at least obvious to spot? e.g.
> >>>>>> pm_domain_attach_with_devm_release()
> >>>>>
> >>>>> If I'm not mistaken, it is not even necessary to use devres for thi=
s.
> >>>>>
> >>>>> You might as well add a dev_pm_domain_detach() call to
> >>>>> device_unbind_cleanup() after devres_release_all().  There is a sli=
ght
> >>>>> complication related to the second argument of it, but I suppose th=
at
> >>>>> this can be determined at the attach time and stored in a new devic=
e
> >>>>> PM flag, or similar.
> >>>>>
> >>>>
> >>>> I looked into this solution. I've tested it for all my failure cases=
 and
> >>>> went good.
> >>>
> >>> OK
> >>>
> >>>>> Note that dev->pm_domain is expected to be cleared by ->detach(), s=
o
> >>>>> this should not cause the domain to be detached twice in a row from
> >>>>> the same device, but that needs to be double-checked.
> >>>>
> >>>> The genpd_dev_pm_detach() calls genpd_remove_device() ->
> >>>> dev_pm_domain_set(dev, NULL) which sets the dev->pm_domain =3D NULL.=
 I can't
> >>>> find any other detach function in the current code base.
> >>>
> >>> There is also acpi_dev_pm_detach() which can be somewhat hard to find=
,
> >>> but it calls dev_pm_domain_set(dev, NULL) either.
> >>>
> >>>> The code I've tested for this solution is this one:
> >>>>
> >>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> >>>> index b526e0e0f52d..5e9750d007b4 100644
> >>>> --- a/drivers/base/dd.c
> >>>> +++ b/drivers/base/dd.c
> >>>> @@ -25,6 +25,7 @@
> >>>>  #include <linux/kthread.h>
> >>>>  #include <linux/wait.h>
> >>>>  #include <linux/async.h>
> >>>> +#include <linux/pm_domain.h>
> >>>>  #include <linux/pm_runtime.h>
> >>>>  #include <linux/pinctrl/devinfo.h>
> >>>>  #include <linux/slab.h>
> >>>> @@ -552,8 +553,11 @@ static void device_unbind_cleanup(struct device=
 *dev)
> >>>>         dev->dma_range_map =3D NULL;
> >>>>         device_set_driver(dev, NULL);
> >>>>         dev_set_drvdata(dev, NULL);
> >>>> -       if (dev->pm_domain && dev->pm_domain->dismiss)
> >>>> -               dev->pm_domain->dismiss(dev);
> >>>> +       if (dev->pm_domain) {
> >>>> +               if (dev->pm_domain->dismiss)
> >>>> +                       dev->pm_domain->dismiss(dev);
> >>>> +               dev_pm_domain_detach(dev, dev->pm_domain->detach_pow=
er_off);
> >>>
> >>> I would do the "detach" before the "dismiss" to retain the current or=
dering.
> >>
> >> I applied on my local development branch all your suggestions except t=
his
> >> one because genpd_dev_pm_detach() as well as acpi_dev_pm_detach() set
> >> dev->pm_domain =3D NULL.
> >>
> >> Due to this I would call first ->dismiss() then ->detach(), as initial=
ly
> >> proposed. Please let me know if you consider it otherwise.
> >
> > This is a matter of adding one more dev->pm_domain check AFAICS, but OK=
.
>
> I don't know all the subtleties around this, my concern with adding one
> more check on dev->pm_domain was that the
> dev->pm_domain->dismiss() will never be called if the ->detach() function
> will be called before ->dismiss() and it will set dev->pm_domain =3D NULL=
 (as
> it does today (though genpd_dev_pm_detach() and acpi_dev_pm_detach())).
>
> For platform drivers that used to call dev_pm_domain_detach() in platform
> bus remove function, if I'm not wrong, the dev->pm_domain->dismiss() was
> never called previously. If that is a valid scenario, the code proposed i=
n
> this thread will change the behavior for devices that have ->dismiss()
> implemented.

->dismiss() and ->detach() are supposed to be mutually exclusive, so
this should not be a problem either way and in practice so far the
only user of ->dismiss() has been acpi_lpss_pm_domain which doesn't do
->detach() at all.

So this is your call.

