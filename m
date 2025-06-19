Return-Path: <linux-iio+bounces-20784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C881AE054B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A17C175DEE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD7230BF2;
	Thu, 19 Jun 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obM4JTqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E8F22C35D
	for <linux-iio@vger.kernel.org>; Thu, 19 Jun 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335437; cv=none; b=OzuidfpeNeG7Dm7rtfWQUK7RtYteNudaqzcfcsxfERncy2RkCGXlxYAuOLc4X9ubFpL22MdQipdaQcvOQxtP8fsgtWUj0JHn8GMa5epEa0Wv7V7iL2LN4zWP3ntm+MkgyTfOJ9j5FWK9JKqLDgWoRpg6f0OZVPu5IoQ710vD11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335437; c=relaxed/simple;
	bh=z1DQk6oJwrSJnLk2A1hLLXFtdvMdkvHImQ7JXj50+zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngbHFbSDaV2j1DYS0x3jGveysq37yI9NIDO95vnHWv+/4xWFh0WW9onzPlyTAOWwj8DPIiVzbr8hgySaDQyLdXoAYKcA8QJ/xsfkeVTGEZARc5FQH/FrYNVgL0vgusjKg4z1pKJw8UBTijxZGEoAAgin3PEu2BhtxpZPbfyZi0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obM4JTqU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81749142b3so687118276.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Jun 2025 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750335434; x=1750940234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D89Sqq1aKT2bW7ku1RLQISnLqAu/xDyFbJYC9lO2rJs=;
        b=obM4JTqUGROyw5xmCeQUlcx4VTLRjOzJvRcbHUJGinkBTaJWse6kHmQl2SaSLjK99K
         kjp9Im5YgTrszjvOJtxWj7HHrm5a9bwoVOuCZlDY8OQjZxa9DycSNtKh4758BuawYxWL
         QtdWggCMvhVnwKeQDhP7S+ezr9LScbXuVb7XDh7TumNkvPBIH9KG9QZdl5tIi4mwBWEm
         xl+ZwXDdYuWjDCs18GGw6sEPoQbAhWG2Jo1NRKitkrrNB5d+iyMVn18h8MDl2Eagkbo7
         kwCDSZDC+YZiHB7qrx3HfQIBgxewiwre0RI1u4B2O4Dtve2UJ03U8hwZauYHC4yQIztO
         iwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335434; x=1750940234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D89Sqq1aKT2bW7ku1RLQISnLqAu/xDyFbJYC9lO2rJs=;
        b=DnCUge8CrYHx7PTnfAoywrArhUVM5U6C2JZqZbCJbcJz28bC5PT34F+GyShVtVym8k
         xY9GKooUKQVDL0MhzxyrAZXnvQWOC+gnN8KEcbbXeSgX2BZBKduLhWMuomgC+IIwKPYu
         c+DDoXjjgjanAerlPNBGEEmc+eEPFIMpQihAX3D0eQkHLM0bCxF7/PG8C6KYu7dVxkKV
         /nbvkAVAOuJFkck4uRU83RQ5VPvmiQcRP655MkGOP+f8M66C+2QPaBe05CVDA8jUlJ6B
         k8b4teRmkqWUhMXNgHzWaOgjV59nKaJxj2F8kK3GkZl6VG7aK9p9+ggUiMqVKKHucPr0
         zayw==
X-Forwarded-Encrypted: i=1; AJvYcCUEvdyqrP0Q+OI/1qMjzYjiqFWzTPOSCRy0JocyjdUv99xuZaugX5ULtV01sA/Zw27tF8ipEfURs2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SFKGQg95uOd5IknqIo6Iq8xBUreT2mKL2PPNbJhAFBSTP3FR
	eKrVJCa8hlbbKI61B++GJtR9weCyt+Dje4AbxD/bsIGLVNnFxvPi/mNORhBtD+RWk8+MaTlyIg9
	C0ukAJgnSoy8fZQkYWR2XkYDTiaDBbBR7POC6Le72+g==
X-Gm-Gg: ASbGncupGd2spxUgmhA1n4JmNBnMkSib9RP6NE1whvZt+aMrtyzpIiIG82sPCAd9vnm
	QDkoufLfDybWPEKYNGvasXzEhyoiHadVA8P/tw0RoYCcYdTwh1+x0MhOf3PYPKCD3wWcfxyFXsf
	nxDkxdxiAdl2UMpbTZxeOYjIK9P9t5/V27IaKM7DhT+TSj
X-Google-Smtp-Source: AGHT+IE4V5K8d8X5JOwKwiCPaHkkAEfI1J8krPds4RSlcpu6FkdIpRV3UcQbKTgBA8xdyC0Mx0IiF2Kw9aGBA8VLdVc=
X-Received: by 2002:a05:6902:2803:b0:e81:81f8:9edb with SMTP id
 3f1490d57ef6-e822ad90167mr27310929276.36.1750335433995; Thu, 19 Jun 2025
 05:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
 <20250616135357.3929441-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
 <04a6c53c-8383-4496-b502-149bd261cfdb@tuxon.dev> <CAJZ5v0gZ3GZ79j2gbhVSjTN+RmYjEUJQjGMSoLsEkUYtjWTngQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gZ3GZ79j2gbhVSjTN+RmYjEUJQjGMSoLsEkUYtjWTngQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 14:16:37 +0200
X-Gm-Features: AX0GCFvleBhZN8Bt4F-qt9DE5tPBIhacUI6gPwf5mtr4W_0PgkdoYzojhC0-B9Q
Message-ID: <CAPDyKFo5=_eiWBf8fpv6kG8qhM6K3DxnqhttgHHgSTP6CM8LuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: domains: Detach on device_unbind_cleanup()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, dakr@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, dmitry.torokhov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com, 
	geert@linux-m68k.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, linux-i2c <linux-i2c@vger.kernel.org>, 
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 at 20:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jun 17, 2025 at 4:41=E2=80=AFPM Claudiu Beznea <claudiu.beznea@tu=
xon.dev> wrote:
> >
> > Hi, Rafael,
> >
> > On 16.06.2025 20:14, Rafael J. Wysocki wrote:
> > > On Mon, Jun 16, 2025 at 3:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon=
.dev> wrote:
> > >>
> > >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>
> > >> The dev_pm_domain_attach() function is typically used in bus code al=
ongside
> > >> dev_pm_domain_detach(), often following patterns like:
> > >>
> > >> static int bus_probe(struct device *_dev)
> > >> {
> > >>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > >>     struct bus_device *dev =3D to_bus_device(_dev);
> > >>     int ret;
> > >>
> > >>     // ...
> > >>
> > >>     ret =3D dev_pm_domain_attach(_dev, true);
> > >>     if (ret)
> > >>         return ret;
> > >>
> > >>     if (drv->probe)
> > >>         ret =3D drv->probe(dev);
> > >>
> > >>     // ...
> > >> }
> > >>
> > >> static void bus_remove(struct device *_dev)
> > >> {
> > >>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> > >>     struct bus_device *dev =3D to_bus_device(_dev);
> > >>
> > >>     if (drv->remove)
> > >>         drv->remove(dev);
> > >>     dev_pm_domain_detach(_dev);
> > >> }
> > >>
> > >> When the driver's probe function uses devres-managed resources that =
depend
> > >> on the power domain state, those resources are released later during
> > >> device_unbind_cleanup().
> > >>
> > >> Releasing devres-managed resources that depend on the power domain s=
tate
> > >> after detaching the device from its PM domain can cause failures.
> > >>
> > >> For example, if the driver uses devm_pm_runtime_enable() in its prob=
e
> > >> function, and the device's clocks are managed by the PM domain, then
> > >> during removal the runtime PM is disabled in device_unbind_cleanup()=
 after
> > >> the clocks have been removed from the PM domain. It may happen that =
the
> > >> devm_pm_runtime_enable() action causes the device to be runtime-resu=
med.
> > >> If the driver specific runtime PM APIs access registers directly, th=
is
> > >> will lead to accessing device registers without clocks being enabled=
.
> > >> Similar issues may occur with other devres actions that access devic=
e
> > >> registers.
> > >>
> > >> Add detach_power_off member to struct dev_pm_info, to be used later =
in
> > >> device_unbind_cleanup() as the power_off argument for
> > >> dev_pm_domain_detach(). This is a preparatory step toward removing
> > >> dev_pm_domain_detach() calls from bus remove functions. Since the cu=
rrent
> > >> PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_de=
tach())
> > >> already set dev->pm_domain =3D NULL, there should be no issues with =
bus
> > >> drivers that still call dev_pm_domain_detach() in their remove funct=
ions.
> > >>
> > >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >> ---
> > >>
> > >> Changes in v4:
> > >> - save dev->power.detach_power_off in dev_pm_domain_attach() and use
> > >>   it in device_unbind_cleanup() when detaching
> > >> - adjusted patch description
> > >>
> > >> Changes in v3:
> > >> - dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
> > >>   and use a single function devm_pm_domain_detach()
> > >>
> > >> Changes in v2:
> > >> - none; this patch is new
> > >>
> > >>  drivers/base/dd.c           | 2 ++
> > >>  drivers/base/power/common.c | 3 +++
> > >>  include/linux/pm.h          | 1 +
> > >>  3 files changed, 6 insertions(+)
> > >>
> > >> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > >> index b526e0e0f52d..13ab98e033ea 100644
> > >> --- a/drivers/base/dd.c
> > >> +++ b/drivers/base/dd.c
> > >> @@ -25,6 +25,7 @@
> > >>  #include <linux/kthread.h>
> > >>  #include <linux/wait.h>
> > >>  #include <linux/async.h>
> > >> +#include <linux/pm_domain.h>
> > >>  #include <linux/pm_runtime.h>
> > >>  #include <linux/pinctrl/devinfo.h>
> > >>  #include <linux/slab.h>
> > >> @@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device =
*dev)
> > >>         dev->dma_range_map =3D NULL;
> > >>         device_set_driver(dev, NULL);
> > >>         dev_set_drvdata(dev, NULL);
> > >> +       dev_pm_domain_detach(dev, dev->power.detach_power_off);
> > >>         if (dev->pm_domain && dev->pm_domain->dismiss)
> > >>                 dev->pm_domain->dismiss(dev);
> > >>         pm_runtime_reinit(dev);
> > >> diff --git a/drivers/base/power/common.c b/drivers/base/power/common=
.c
> > >> index 781968a128ff..a8f302ed27a5 100644
> > >> --- a/drivers/base/power/common.c
> > >> +++ b/drivers/base/power/common.c
> > >> @@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, boo=
l power_on)
> > >>         if (!ret)
> > >>                 ret =3D genpd_dev_pm_attach(dev);
> > >>
> > >> +       if (dev->pm_domain)
> > >> +               dev->power.detach_power_off =3D power_on;
> > >
> > > I'm assuming that you have checked all of the users of
> > > dev_pm_domain_attach() and verified that the "power off" value is the
> > > same as the "power on" one for all of them.
> >
> > In v2 it has been discussed to just mirror the power_on acquisition.
> >
> > Double checking now, all the current users of dev_pm_domain_attach() fo=
llow
> > this rule, except the i2c bus. i2c powers on the domain conditionally:
> >
> > https://elixir.bootlin.com/linux/v6.15.2/source/drivers/i2c/i2c-core-ba=
se.c#L575
> >
> > and powers it off unconditionally:
> > https://elixir.bootlin.com/linux/v6.15.2/source/drivers/i2c/i2c-core-ba=
se.c#L638
> >
> > Should we take this into account ?
>
> I think so.
>
> It is still sufficient to use one device flag to represent the
> information whether or not to remove power on detach, but I would
> change the second argument of dev_pm_domain_attach() to a u8
> representing a mask of bits:
>
> PM_DOMAIN_POWER_ON    BIT(0)
> PM_DOMAIN_POWER_OFF    BIT(1)
>
> where PM_DOMAIN_POWER_ON will be set to indicate that the device
> should be turned on right after attaching the PM domain and the value
> of PM_DOMAIN_POWER_OFF will be stored in the new device flag.
>
> The majority of users will set or clear both, but i2c will set
> PM_DOMAIN_POWER_OFF and either set of clear PM_DOMAIN_POWER_ON
> depending on the do_power_on value.

I am not sure it's needed, unless it's especially targeted for the
ACPI PM domain, which I find hard to believe.

Also, I find it awkward why the i2c bus should be any different from
many other types of buses. It's probably just because of legacy and
that someone took a decision when we added it.

Wolfram, what's your thinking around this?

Kind regards
Uffe

