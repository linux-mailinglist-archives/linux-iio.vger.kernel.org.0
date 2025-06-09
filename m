Return-Path: <linux-iio+bounces-20336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC867AD2717
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 22:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C34B3AAB7E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 19:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BD220F5A;
	Mon,  9 Jun 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3N60dkW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05238220F3A;
	Mon,  9 Jun 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499210; cv=none; b=LecXful2pLVVH6FVG8ogJCVFFYMPB8fhW36fmtRBXn8eRxnB2orn3Qz59BcmMrnxjQaN7bVzjfi+o7PgiYRPkYDit5h2WJIVIKdSC2E3cX9NzZSXMBH75aeeiHO9nqlWPYausrFTYch6mAnOMa1e75b+s6xfdZyzr1t2rRORdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499210; c=relaxed/simple;
	bh=nW89nwBj3FurmMV7fGL8RXLg7a4KC3YW2fzqgKeUsMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaB9unEkYUOvsQVlBFy2nFHlrtzsmmj1HYZhWuaKibW1xaEymyHLgfBleNv9GpCfpII0X/960R6MxQrZ/jAWn+idLjHRkCzG4M2a9s1Zm5/uSqM8DxeoPLXZ7My3265NR9CgZh1t7J0YkQMEMJohrilLMRfVJkln1lYJ0xUcJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3N60dkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365DC4CEF5;
	Mon,  9 Jun 2025 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499209;
	bh=nW89nwBj3FurmMV7fGL8RXLg7a4KC3YW2fzqgKeUsMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R3N60dkWxuMNxzAv7XfWEk8D08wZJrhH67kbNwo2w9FZqV5CuKedAjJMqiRilKwVt
	 Ic1QmRcdfczC8ppBz0B7y9bRri5KdiK3D/M/Pw78ksuYAeHEkALq4B+d8hY6cpppFy
	 qsQe2TF3nw3zQwwBlZiygYZBxilgWizRC8+4MH9vRUVw17YSh1lpHpihPAyEHeqwOr
	 omtPrOIn2Gp/0Y/JcmNPh6cczabVHCv4rbt+nnL6qy1vLN1DwNgrZIe97rivE8VEC+
	 L/4W+ts3Zpo/oeUm7SuToPtLF8SYIPC0LyWVxvreKIkhaSJitzbHSgxYNYev7S4sbi
	 djEA+vfZOhtoQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60d5c665fceso2404556eaf.1;
        Mon, 09 Jun 2025 13:00:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURLLMdHhdCjfBUUsb3pRnohOyQOq0tE+kkOr6QPuS4sH+b6V8AWdUtNNFiCiVtyurHrBGcRgtr7nHF2QhgzmrsM10=@vger.kernel.org, AJvYcCUZNqMNDZzpUzmBYdYBFxilfUDgBk3e1qgjr2ec56aKlMrxatlvr65kVQmBGRD0PYk93gksBbxUHB4=@vger.kernel.org, AJvYcCVsY6Up8iqxlLXJdExH/YL9Xf9LZsYXX/0tUqei14WrDNECwOrFpyHVHP9vIcoI2kQoeAZZ4vnsE9Vqe43X@vger.kernel.org, AJvYcCWqrypqqfK3JSaaTC3CRG1lb/EfEonRlFjGW/7H1kBMoSc57uerDF+idyIoEBvcjDo1EwycykkevnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+JcEradTQEwD9jCwMPs+HBFOu9iUvRlujVTn0ViRsNwx24VJ
	YluVKFtCIhIFHr8F2Hh5huRVQV0lPY+RgxDwaha9HUVNBbySzGRFlBFgzuEZCcH5GMId+gFyaRN
	Boi3G3cw2aAE002OipmMRi2lLfXa+e+Y=
X-Google-Smtp-Source: AGHT+IGyapYqGB+aJHE+wlodJ2N3dVnT13GPTwg0aYuBGZS1d+QikchX8STT0THo/lC3/X19pu8ontXCFl9XwGMdnUU=
X-Received: by 2002:a05:6820:210:b0:610:d7e3:b823 with SMTP id
 006d021491bc7-610d7e3df71mr2236793eaf.8.1749499208613; Mon, 09 Jun 2025
 13:00:08 -0700 (PDT)
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
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com> <20250607140600.76e87ea5@jic23-huawei>
In-Reply-To: <20250607140600.76e87ea5@jic23-huawei>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Jun 2025 21:59:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
X-Gm-Features: AX0GCFvVkyM7dSJGee_UmZSFu9Tn0392S88dN1J7jQILREjqC193ls0HTObSI44
Message-ID: <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, dakr@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Fri, 6 Jun 2025 22:01:52 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> Hi Rafael,
>
> > On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
> > > > On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxo=
n.dev> wrote:
> > > > >
> > > > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > >
> > > > > The dev_pm_domain_attach() function is typically used in bus code=
 alongside
> > > > > dev_pm_domain_detach(), often following patterns like:
> > > > >
> > > > > static int bus_probe(struct device *_dev)
> > > > > {
> > > > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > > >     struct bus_device *dev =3D to_bus_device(_dev);
> > > > >     int ret;
> > > > >
> > > > >     // ...
> > > > >
> > > > >     ret =3D dev_pm_domain_attach(_dev, true);
> > > > >     if (ret)
> > > > >         return ret;
> > > > >
> > > > >     if (drv->probe)
> > > > >         ret =3D drv->probe(dev);
> > > > >
> > > > >     // ...
> > > > > }
> > > > >
> > > > > static void bus_remove(struct device *_dev)
> > > > > {
> > > > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > > > >     struct bus_device *dev =3D to_bus_device(_dev);
> > > > >
> > > > >     if (drv->remove)
> > > > >         drv->remove(dev);
> > > > >     dev_pm_domain_detach(_dev);
> > > > > }
> > > > >
> > > > > When the driver's probe function uses devres-managed resources th=
at depend
> > > > > on the power domain state, those resources are released later dur=
ing
> > > > > device_unbind_cleanup().
> > > > >
> > > > > Releasing devres-managed resources that depend on the power domai=
n state
> > > > > after detaching the device from its PM domain can cause failures.
> > > > >
> > > > > For example, if the driver uses devm_pm_runtime_enable() in its p=
robe
> > > > > function, and the device's clocks are managed by the PM domain, t=
hen
> > > > > during removal the runtime PM is disabled in device_unbind_cleanu=
p() after
> > > > > the clocks have been removed from the PM domain. It may happen th=
at the
> > > > > devm_pm_runtime_enable() action causes the device to be runtime-r=
esumed.
> > > >
> > > > Don't use devm_pm_runtime_enable() then.
> > >
> > > What about other devm_ APIs? Are you suggesting that platform drivers
> > > should not be using devm_clk*(), devm_regulator_*(),
> > > devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> > > dev_pm_domain_detach() that is called by platform bus_remove() may sh=
ut
> > > off the device too early, before cleanup code has a chance to execute
> > > proper cleanup.
> > >
> > > The issue is not limited to runtime PM.
> > >
> > > >
> > > > > If the driver specific runtime PM APIs access registers directly,=
 this
> > > > > will lead to accessing device registers without clocks being enab=
led.
> > > > > Similar issues may occur with other devres actions that access de=
vice
> > > > > registers.
> > > > >
> > > > > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_att=
ach() and
> > > > > dev_pm_domain_detach() in bus probe and bus remove, it ensures th=
at the
> > > > > device is detached from its PM domain in device_unbind_cleanup(),=
 only
> > > > > after all driver's devres-managed resources have been release.
> > > > >
> > > > > For flexibility, the implemented devm_pm_domain_attach() has 2 st=
ate
> > > > > arguments, one for the domain state on attach, one for the domain=
 state on
> > > > > detach.
> > > >
> > > > dev_pm_domain_attach() is not part driver API and I'm not convinced=
 at
> > >
> > > Is the concern that devm_pm_domain_attach() will be [ab]used by drive=
rs?
> >
> > Yes, among other things.
>
> Maybe naming could make abuse at least obvious to spot? e.g.
> pm_domain_attach_with_devm_release()

If I'm not mistaken, it is not even necessary to use devres for this.

You might as well add a dev_pm_domain_detach() call to
device_unbind_cleanup() after devres_release_all().  There is a slight
complication related to the second argument of it, but I suppose that
this can be determined at the attach time and stored in a new device
PM flag, or similar.

Note that dev->pm_domain is expected to be cleared by ->detach(), so
this should not cause the domain to be detached twice in a row from
the same device, but that needs to be double-checked.

Thanks!

