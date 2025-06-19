Return-Path: <linux-iio+bounces-20783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40704AE052B
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 14:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E80E1897C7F
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jun 2025 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CE22A4E3;
	Thu, 19 Jun 2025 12:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gx3oG5iX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793921D011
	for <linux-iio@vger.kernel.org>; Thu, 19 Jun 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335135; cv=none; b=YCYGfT0NeiRrPhlMaRD53sJQM4q6r1/IQc47HZBMUkNzPd0569fbGhLWvH9fOJREbIhd/JASqvAMl0SKdX8Z8Z2TkpXybB7dqNk/yIcYkAexPaJvPiRfcCigLohmYP6Inyt8uSnXKuAEZ+NDGg2IUO0+NufvXzze7SAQT/hBNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335135; c=relaxed/simple;
	bh=nYb7xQFUld7v08K+Ac/6c9QfLWUi1rCk4mHZ65TBAd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cq8/4RNpWyScg/s+C6/SidpyiPomG+R8WE7vnvjzGsPFc80nfi4a3UdMqrZsjL69EyVlW7pEIk7UpbhczQlb1nzjg2TJ9K9WE5SUESmZGeiFVdWHb75Coi18+9m+EgStrnjGTCunZIxoGpQkcSO3S7V6IPxvry65U9HsFZHQmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gx3oG5iX; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81a7d90835so861077276.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Jun 2025 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750335132; x=1750939932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4jopdmk0/EoPtfqXFOnCJqlK5/IKjz0QIFIwGgRmIw=;
        b=Gx3oG5iXUPx6v76gKs31xgR1/uFQErmUjxB6W3ayiYYYVxj+C/5nRJhyn6vX6FuxrH
         lHcUCQHJOi3ZbmoT4CjfYj8XXmZxWYa/WLcdfkdbddiUf2qnYeqOd/Y1bRpd3LmgseNg
         eTzAEdY9nBXBnAAoLWmEfMnI5E3fU6SoixB5O5MNSf3OIsENFD7C4LdbQFxSgAj4vhBb
         7KklIMu0Kloru71ze2kxJRHUzxo365vYLObdMIJmFphF80GLhPNdaa2Xf+65YPxETcPO
         vaVuKpvhgrZQQE9On/e/J1GqUjoS6lEc04+nxwYhlhHdRUoITnvrjibP9IlVqYlY0ikm
         C86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335132; x=1750939932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4jopdmk0/EoPtfqXFOnCJqlK5/IKjz0QIFIwGgRmIw=;
        b=dUugGVmiyuPVWDIgJpPYfQh1HPq7S56IDXVn10naZaoQxOYSEl0iJXjPZsXMXypAXr
         RwWaf2gUvjq9QweiCVVPeIFylSjcwmvVT1Fp9tmgX+O7E04+An+Zx5rDyybdD14n1B1H
         90YVLhlvAkQt6fOpyxgPtYVfuLDPBFpOsWfo+pVQwW1YMDSP1HE8/0wrLkW6fRLMJw16
         ETN7GV2S4aY3ryUr1XZ7ifsYe7P4tf7INaCX9/RH5Mvbaw57qKf0GS7+L+J7Y4GEl4HK
         mFw+58IxAvRHeEj3m0vGJf7sGOWZJYHAGhOLVqKI2iMPVH+K1GhQ8gPhmDdzHLE/VkBy
         2SlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsjCKQcft9pXy8cqU23cw9QqvNggbpbC0dCPsLqD8xGMVxVhwrSMMoYaoJLDsgdlKjy2XrYysiTic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMo4s48gdyvspYWnvuM4EQWqVukaFilqHlD4shMrthtezjFIYd
	OfDka3pk3l85XzvdbEs4grU86hSOfL9uLHKixw8abycf7yCmCzJpXEYS0j38Ykc0BWWqjOvGNq3
	PLuYsLuCyFjxYj0yO9lsyTtDXMbi5ucVagIIJQ9ctag==
X-Gm-Gg: ASbGncug1Y6kd4dw/fEQI4jHLG6SUoX8qhZ8aK7owRQqOG/AgZvCbz6r5VlxUN6Pw9W
	pf/3XMoGyQqkMzPCwFXeMKye2pScZbSgHeBXYWNlac0JsUNZPhty37+TxDlEVkdV3buauO/s56o
	StaoYKxhTGwAuqwmNTkCnNobZyoFVEVFD+g6SEJrZsp772pYBg7a7E2is=
X-Google-Smtp-Source: AGHT+IEXUEZrdHXQYvHWd4YdUzyPKDHzLM3PIOd0gZanTJJ/vBF4uj1Av1R5EUDrVwtYV0jaSMvxy7uOAiPO38M6OqU=
X-Received: by 2002:a05:6902:1021:b0:e81:77cd:1234 with SMTP id
 3f1490d57ef6-e822ad8ac40mr29042163276.34.1750335132387; Thu, 19 Jun 2025
 05:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com>
 <20250616135357.3929441-2-claudiu.beznea.uj@bp.renesas.com> <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 14:11:35 +0200
X-Gm-Features: AX0GCFv4bu1FSlwnwPm1SssPgVOHtD4w3WZrSHj5iZrklgepWarnGSuP3oMCWZo
Message-ID: <CAPDyKFr_oqvtRsCeak62wxw=fqadY6nuwnr0vKxsHqybTA8gzw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: domains: Detach on device_unbind_cleanup()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, dakr@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, dmitry.torokhov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com, 
	geert@linux-m68k.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Jun 2025 at 19:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 16, 2025 at 3:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev=
> wrote:
> >
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The dev_pm_domain_attach() function is typically used in bus code along=
side
> > dev_pm_domain_detach(), often following patterns like:
> >
> > static int bus_probe(struct device *_dev)
> > {
> >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >     struct bus_device *dev =3D to_bus_device(_dev);
> >     int ret;
> >
> >     // ...
> >
> >     ret =3D dev_pm_domain_attach(_dev, true);
> >     if (ret)
> >         return ret;
> >
> >     if (drv->probe)
> >         ret =3D drv->probe(dev);
> >
> >     // ...
> > }
> >
> > static void bus_remove(struct device *_dev)
> > {
> >     struct bus_driver *drv =3D to_bus_driver(dev->driver);
> >     struct bus_device *dev =3D to_bus_device(_dev);
> >
> >     if (drv->remove)
> >         drv->remove(dev);
> >     dev_pm_domain_detach(_dev);
> > }
> >
> > When the driver's probe function uses devres-managed resources that dep=
end
> > on the power domain state, those resources are released later during
> > device_unbind_cleanup().
> >
> > Releasing devres-managed resources that depend on the power domain stat=
e
> > after detaching the device from its PM domain can cause failures.
> >
> > For example, if the driver uses devm_pm_runtime_enable() in its probe
> > function, and the device's clocks are managed by the PM domain, then
> > during removal the runtime PM is disabled in device_unbind_cleanup() af=
ter
> > the clocks have been removed from the PM domain. It may happen that the
> > devm_pm_runtime_enable() action causes the device to be runtime-resumed=
.
> > If the driver specific runtime PM APIs access registers directly, this
> > will lead to accessing device registers without clocks being enabled.
> > Similar issues may occur with other devres actions that access device
> > registers.
> >
> > Add detach_power_off member to struct dev_pm_info, to be used later in
> > device_unbind_cleanup() as the power_off argument for
> > dev_pm_domain_detach(). This is a preparatory step toward removing
> > dev_pm_domain_detach() calls from bus remove functions. Since the curre=
nt
> > PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detac=
h())
> > already set dev->pm_domain =3D NULL, there should be no issues with bus
> > drivers that still call dev_pm_domain_detach() in their remove function=
s.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v4:
> > - save dev->power.detach_power_off in dev_pm_domain_attach() and use
> >   it in device_unbind_cleanup() when detaching
> > - adjusted patch description
> >
> > Changes in v3:
> > - dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
> >   and use a single function devm_pm_domain_detach()
> >
> > Changes in v2:
> > - none; this patch is new
> >
> >  drivers/base/dd.c           | 2 ++
> >  drivers/base/power/common.c | 3 +++
> >  include/linux/pm.h          | 1 +
> >  3 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index b526e0e0f52d..13ab98e033ea 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/wait.h>
> >  #include <linux/async.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/pinctrl/devinfo.h>
> >  #include <linux/slab.h>
> > @@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device *de=
v)
> >         dev->dma_range_map =3D NULL;
> >         device_set_driver(dev, NULL);
> >         dev_set_drvdata(dev, NULL);
> > +       dev_pm_domain_detach(dev, dev->power.detach_power_off);
> >         if (dev->pm_domain && dev->pm_domain->dismiss)
> >                 dev->pm_domain->dismiss(dev);
> >         pm_runtime_reinit(dev);
> > diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> > index 781968a128ff..a8f302ed27a5 100644
> > --- a/drivers/base/power/common.c
> > +++ b/drivers/base/power/common.c
> > @@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool p=
ower_on)
> >         if (!ret)
> >                 ret =3D genpd_dev_pm_attach(dev);
> >
> > +       if (dev->pm_domain)
> > +               dev->power.detach_power_off =3D power_on;
>
> I'm assuming that you have checked all of the users of
> dev_pm_domain_attach() and verified that the "power off" value is the
> same as the "power on" one for all of them.

Also note that the value only matters for the ACPI PM domain.

Genpd doesn't even take the value into account, which is the most
common usage of this.

[...]

Kind regards
Uffe

