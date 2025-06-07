Return-Path: <linux-iio+bounces-20282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C1DAD0D2A
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 13:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579457A00C0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89F221270;
	Sat,  7 Jun 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH9gD9ZH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15A1F151C;
	Sat,  7 Jun 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749296621; cv=none; b=WClDthUTVk4woPP0JNelHaXEmLgWHecUM3MaEmowdPptFQYUNo6KRsZalb+Q1Ypcu8/0hE5JYczU9r4sHCIiBckFyEVrlwMkuIxkAysTpqOZm/KFbgBo+e+yPW3VU1mYgII4dTW37Gi9RhLXj3CHkMtahVBz1Vgog2bC4ER+62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749296621; c=relaxed/simple;
	bh=SX6x8lcMQQu92DOlDbnahesgKUUjd2UjQLVSnWHmy/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8KiKCj9cbsErLkgDUC8bfF+oIuoF8gjIts4noZLoF4PkGvhqirDsKmdoeQm0yskT5U/BO1yk9OYaO6E4gxooDKKJCkbNn5IeZPrVNFw8j4S6Dvje+mwO/6Z1mV1b04Qop/xYov3H920mX2RYstrrJDw0RiC1sP6sPPQzenlnQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH9gD9ZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF833C4CEF1;
	Sat,  7 Jun 2025 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749296620;
	bh=SX6x8lcMQQu92DOlDbnahesgKUUjd2UjQLVSnWHmy/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XH9gD9ZH8faoABoPA/CliUC9yAKk4xUdMOP/CGm9HCPAimf7aNV6YyiG5axdHa51I
	 fB154CDwDFaIAvzfqWuOvIXQ7dMN3mezliivBjbF155oOHwKzErK4OWFVQxkN9k6Kg
	 O6J+ewRwWaLAIKi43RE5jjK6r5+JoION0uQh8zW38bsDHPUineneXgS7dN6ZgvzNMg
	 nWNl3OIdcqRzTnvrA9VjFMBGtugJ4xOjUY3has+dW/q4sZLyu/uQkUIXNzJK+QF7S8
	 kuaXEbO3P7o34FksdTsgUamzIfoUvyA93m3zEan6tAXt0A6VXiZwz0U+HLjHS2LGk2
	 QNwC8jOD462Lw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4067ac8f6cdso2408469b6e.2;
        Sat, 07 Jun 2025 04:43:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsdl2+UZpu18H9Y1Mtd6ChRpxA3iV+qjxMy5twa9OxjEXXipQte/L8QgheiE/Lt5gsrdWBasmAntdi11sekMmK+s0=@vger.kernel.org, AJvYcCVjt8y1siObcXrpBC03q/KaqV62KpBSuNkwjsmzpDbGcGPaCNw7vNAgELstd97tAbEx+2yscY4kR/Q=@vger.kernel.org, AJvYcCVoYszi+NFoJTSTnP9a1oyzSK1qCyOqnLmcz+yH64TJ4uWYCZyvRK4X6AFAmKoAqtjbVgrrb0uxJueU1XYf@vger.kernel.org, AJvYcCWMDoJWOyFWPeemLSFCb81030mDJ1csZJ0vYeS6yocwQZMniuIN43eqEOTMaQIB8XIJ5lJIt+yeXEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygd8WsO1VSTfEOBIl2GkONu18qVnxya3LZxcQvXvYPQa5jjaf/
	+op0YVHp9kewvxZFUVwiTsr/BAfPgMKqhEId7u+2H/0xLnd4BDLS51clkQaOQ0CRbYk+qlBgUwM
	kW14D3EgVZ1IIEsfvOFCAyeaSwl10jNo=
X-Google-Smtp-Source: AGHT+IF3MnqzphsP0Aj2aIg2yl7XI8dp/NM9Y6H+A8UL7T966MeN/B7HkHpxRiSvUvZLVuLMG/CCjA7BjOvTOW9l/Jc=
X-Received: by 2002:a05:6808:3a06:b0:3fe:ab15:5ed6 with SMTP id
 5614622812f47-409051b20b3mr4396736b6e.12.1749296620023; Sat, 07 Jun 2025
 04:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv> <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 7 Jun 2025 13:43:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSqLGF_7xmiEf-=0gvHcNJjAsu-X60v6i3csv6ibc40g@mail.gmail.com>
X-Gm-Features: AX0GCFv4XobSvj2dlLBGvOdVJ5KhLGQQoql-NVH0ppX4BNmroN0ev4Uw8EHd3Zw
Message-ID: <CAJZ5v0hSqLGF_7xmiEf-=0gvHcNJjAsu-X60v6i3csv6ibc40g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, ulf.hansson@linaro.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Jun 6, 2025 at 8:55=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.=
dev> wrote:
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
> > > > on the power domain state, those resources are released later durin=
g
> > > > device_unbind_cleanup().
> > > >
> > > > Releasing devres-managed resources that depend on the power domain =
state
> > > > after detaching the device from its PM domain can cause failures.
> > > >
> > > > For example, if the driver uses devm_pm_runtime_enable() in its pro=
be
> > > > function, and the device's clocks are managed by the PM domain, the=
n
> > > > during removal the runtime PM is disabled in device_unbind_cleanup(=
) after
> > > > the clocks have been removed from the PM domain. It may happen that=
 the
> > > > devm_pm_runtime_enable() action causes the device to be runtime-res=
umed.
> > >
> > > Don't use devm_pm_runtime_enable() then.
> >
> > What about other devm_ APIs? Are you suggesting that platform drivers
> > should not be using devm_clk*(), devm_regulator_*(),
> > devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> > dev_pm_domain_detach() that is called by platform bus_remove() may shut
> > off the device too early, before cleanup code has a chance to execute
> > proper cleanup.
> >
> > The issue is not limited to runtime PM.
> >
> > >
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
> > > > For flexibility, the implemented devm_pm_domain_attach() has 2 stat=
e
> > > > arguments, one for the domain state on attach, one for the domain s=
tate on
> > > > detach.
> > >
> > > dev_pm_domain_attach() is not part driver API and I'm not convinced a=
t
> >
> > Is the concern that devm_pm_domain_attach() will be [ab]used by drivers=
?
>
> Yes, among other things.

This would be much less objectionable to me if it were not devm_, but
also the current expectation is that the PM domain will be gone after
device_remove() has returned.

