Return-Path: <linux-iio+bounces-20280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA59AD08E3
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 22:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834CE189B4BB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 20:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D001215073;
	Fri,  6 Jun 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9FUBEc2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA854683;
	Fri,  6 Jun 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240125; cv=none; b=KcbNFG+omNuWegt9xaMZNeJIBqjqA+MYyMCOCK+9gN/GU83wEnr5GXDT4e75Oj6Hk1+2YvozOxpDi6Ez40H4V3jYfYmWwN7Sm2Fb0qjse6lU0jK0BkmYN2DWcyDvf/BhJu+7fcHsE4l216YLyImlCDgFu58RRa8nUP1/25xCuqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240125; c=relaxed/simple;
	bh=Ob/ZeCmO+wM4R1HbnSgpPdyraptai3IhmhW/MHO+XAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mc1kzTmRZr05CLkFkoIzfaUNC2N5/YYUklyY+zS4LgDHsp+SZQkrMYGZcbkMLq4D14z1OqaEm+J7XVn3Vbq2FgzSNnXtY87Y/7MILwgEVaGzN9l/XVq9BHmXTt+VQ9chvaYc8CyPKzM6OCwJX9WBid8WY/prA7tICWXbO0wYEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9FUBEc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FC3C4AF09;
	Fri,  6 Jun 2025 20:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240124;
	bh=Ob/ZeCmO+wM4R1HbnSgpPdyraptai3IhmhW/MHO+XAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t9FUBEc2/VmeaHZwCeWK+Kwv3h+8395994AKfndTgMLKHavK6pfFE6ToGeYiag/ts
	 DGPqHO4yE7GrLfX2iiuTyH/ZQse+oYItRwftwZsxNd9klerkAwUwCyLvJeaQJHaoXH
	 iOEG/tV8lPQnY882k3NbmYk7xkDRqO7Ilu9xdUYvOCTX4Dgl4UD6ErSWjkFZZUDlFO
	 BG09SVH3xvGM+PXaVhnOkfEB+udaheA3v6NVZnEtWlKsiy+rc8+QdmIk11IvpWBo6s
	 XfUCnRR1PWy2Snbifn+eUhl+CmZC6/beWXPkm9n6iyXe9/BgCEBsJSpaWYqJTNUK1h
	 WasWL/+30+s1g==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4067bab37a1so2030662b6e.1;
        Fri, 06 Jun 2025 13:02:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmFOUEZA3pg7eR7pgqtfjZDnEkkNS+/WnYzVkPeXsJFzUWd8FwL98FlW36+WbXPtvU7PdxCJqN7kE=@vger.kernel.org, AJvYcCV5a2C4tKhj+txSBwFMpQBaybomSM9LoiLOkz/Wi8r7qNvtG7KuybmfrjxwyV680/zlsbSFbQ7ILK0Cr8LL@vger.kernel.org, AJvYcCWszul0oFtxKTYabU7MBX6Iq1XYOP6WNXQ8XeZ02qnMnLW6eeIHOE/hbCo1Yg2SAkZZTVp4TabwLAqQ5d37CqIEeHI=@vger.kernel.org, AJvYcCXCGZYKwlPw2DYEi6yErUkJdG275+X9QIGsv6ZrdeHfnO1TBYASOAreb+4UXAf3W+hgWVKJQAgTeR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNrFrJX8hipSpw0dv4w2KTrCWFkCpr2YJTZA1TwTvxxmXJP+Z1
	tQm2LrZYHN5f+zJYycEO5E7bwv/k03Cfik+KFxAngUcsHBAWjzEmC9YdoTCVCTQXU0doZ+rcK0F
	XAxcrNvrTtkGN+uvaHP6rjwXGkkSGk7E=
X-Google-Smtp-Source: AGHT+IHNZnCL1ykgwQryTtQYD1pAw3TeNBUdACA9R8FHLJwKJd2b5YrpQ99JhEVsJ1qktocsfwS3ziRQWkbt5v5XQiE=
X-Received: by 2002:a05:6808:22a5:b0:3fc:7e1:a455 with SMTP id
 5614622812f47-4090519a67dmr3524076b6e.2.1749240123996; Fri, 06 Jun 2025
 13:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com> <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
In-Reply-To: <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Jun 2025 22:01:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
X-Gm-Features: AX0GCFuutVnb1KxLXZv_oVq_-Zm6x2wDg2kJRxLwu7XWQkafSciRR866LCNgLQ4
Message-ID: <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Claudiu <claudiu.beznea@tuxon.dev>, 
	gregkh@linuxfoundation.org, dakr@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, ulf.hansson@linaro.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.de=
v> wrote:
> > >
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > The dev_pm_domain_attach() function is typically used in bus code alo=
ngside
> > > dev_pm_domain_detach(), often following patterns like:
> > >
> > > static int bus_probe(struct device *_dev)
> > > {
> > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > >     struct bus_device *dev =3D to_bus_device(_dev);
> > >     int ret;
> > >
> > >     // ...
> > >
> > >     ret =3D dev_pm_domain_attach(_dev, true);
> > >     if (ret)
> > >         return ret;
> > >
> > >     if (drv->probe)
> > >         ret =3D drv->probe(dev);
> > >
> > >     // ...
> > > }
> > >
> > > static void bus_remove(struct device *_dev)
> > > {
> > >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > >     struct bus_device *dev =3D to_bus_device(_dev);
> > >
> > >     if (drv->remove)
> > >         drv->remove(dev);
> > >     dev_pm_domain_detach(_dev);
> > > }
> > >
> > > When the driver's probe function uses devres-managed resources that d=
epend
> > > on the power domain state, those resources are released later during
> > > device_unbind_cleanup().
> > >
> > > Releasing devres-managed resources that depend on the power domain st=
ate
> > > after detaching the device from its PM domain can cause failures.
> > >
> > > For example, if the driver uses devm_pm_runtime_enable() in its probe
> > > function, and the device's clocks are managed by the PM domain, then
> > > during removal the runtime PM is disabled in device_unbind_cleanup() =
after
> > > the clocks have been removed from the PM domain. It may happen that t=
he
> > > devm_pm_runtime_enable() action causes the device to be runtime-resum=
ed.
> >
> > Don't use devm_pm_runtime_enable() then.
>
> What about other devm_ APIs? Are you suggesting that platform drivers
> should not be using devm_clk*(), devm_regulator_*(),
> devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> dev_pm_domain_detach() that is called by platform bus_remove() may shut
> off the device too early, before cleanup code has a chance to execute
> proper cleanup.
>
> The issue is not limited to runtime PM.
>
> >
> > > If the driver specific runtime PM APIs access registers directly, thi=
s
> > > will lead to accessing device registers without clocks being enabled.
> > > Similar issues may occur with other devres actions that access device
> > > registers.
> > >
> > > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach(=
) and
> > > dev_pm_domain_detach() in bus probe and bus remove, it ensures that t=
he
> > > device is detached from its PM domain in device_unbind_cleanup(), onl=
y
> > > after all driver's devres-managed resources have been release.
> > >
> > > For flexibility, the implemented devm_pm_domain_attach() has 2 state
> > > arguments, one for the domain state on attach, one for the domain sta=
te on
> > > detach.
> >
> > dev_pm_domain_attach() is not part driver API and I'm not convinced at
>
> Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?

Yes, among other things.

> In that case we can go back to using devres group to enforce ordering,
> but proper ordering is needed.

Sure.

> > all by the arguments above.
>
> Please reconsider given the fact that issue is not limited to the
> runtime PM.

PM domains are not resources, they are interfaces that are added to
devices by the bus types that need them and they also need to be
removed by those bus types.

A PM domain needs to go away at remove time because it may not make
sense to use PM domain callbacks without driver callbacks and if
enabled runtime PM is leaked beyond the point at which there are no
driver and bus type callbacks, this is exactly what may happen.

If you have ordering issues in drivers, that's where they are and
that's where they need to be addressed.

Thanks!

