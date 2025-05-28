Return-Path: <linux-iio+bounces-19987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 668ECAC660B
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 11:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714093BA55A
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AF275874;
	Wed, 28 May 2025 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XU+rZryQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F2202C3A
	for <linux-iio@vger.kernel.org>; Wed, 28 May 2025 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424705; cv=none; b=eOA2rl2hbACe4wADUXjBK+09g3Omqc4Ui5CKq81bof5m+YnB3M9wIe3MHHBWXe6ZBk5o2kAjiiD/L3KnapkRUWtNq7bPCCjFVLgGq0OAuFhZbPOdEX/4rNzFBtRbo2D5qA1OH48UjKncbMnhdMKvXhVUIdDd55dJfuztU3ELk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424705; c=relaxed/simple;
	bh=WsTVlNGVWMlMr7/1HnY9hFlDZoNZeHk/mPpV96JRdec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ygfw8Rz3FRbgtj7wT6rQlz95bNGIWJ8l2W1tu3Z0tKxMvS5wab19Wz/M3jC2n4RSyfq0gwvml9ACr7VlG8peSVgzXbbml3iOU+xS+FwV75yvUbwyllnpfKBCrmcRTHR/k7aKGWYNdn8FJ5h9cPRqbCYoYoAqrJMoYxW07HjuMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XU+rZryQ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e73e9e18556so726360276.0
        for <linux-iio@vger.kernel.org>; Wed, 28 May 2025 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748424700; x=1749029500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxCNklpcwB9Aux3Ir6fEZ7ZfodLW5xursubADF1vInc=;
        b=XU+rZryQS5rdYN2wA/8ERj2PCnbtqeZzyNCZx0JNdYtBEYRXhfmQfsyR5N3NHJAi8x
         BqXDUxD5KSNbirNzLWcNZiIyDNgr7am0Iv2Nj6gXZ1YKATLsJnlOSufs2e54SxfMRypH
         fhl+tKm/Fmv8RstCQ4Ou3HKlz2LjaEyoOItKT33DvXjNkPD2sd8uZrKfsrxt7jfxukzc
         UZ/P7qCKYr+uWmsbUOTyfyGoobkyz7vNIGCOya1yVOcLk+fJNYRggd3+djG9XKnpzjU0
         BGqQzRYyc6d4Y/1wXFYWbGDS0yEcXNaX+DZVYfrRpr4J/O5W0b9aLtJ6OEmKxNPhWLPO
         a7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748424700; x=1749029500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxCNklpcwB9Aux3Ir6fEZ7ZfodLW5xursubADF1vInc=;
        b=jowWo1w1/4FOAz4+gD59rfg297q2hy2BhPpnRQetEk/5Dd+y1L7gSrkXVjsx0WmDG1
         e/4g7vVGkKmLDLpL5phHwCWqoLgZK83qNHi5W4o5U5jNeszmgwe4Zf47rke9N4uaVlqa
         p9YMDsHhTF07NgiibucS2SAMLeZl2d2HAvtT5egR63YspyiVh5CpNPgmKTZJDD3pYvHG
         5CfXaBMIwDT7vLT7Panj2eh4GKjjt6ate418EpDeaPi4fhaw+wbKaZ4OhVWYccfzP+cM
         gKT+3wmDOleF2cCFY4zQhH27M/YCVlJe32fXewl39vpfjJdaRPeyiei35dTr5z9hX0Pf
         h3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVFKNT/OXIm7pZHW5WULrT4q/W6uVjXqHlXZ38X07qFmvopVcjO7iUb3xmw7bXWYDp6qJwUXbiAXJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMvxGXudr2AMEunBCidvWGvQP4Yu2bAu/N8TF/sKKMhV6iuLh
	zD+tGkSQ1OiHYIcYyR6/k0UJ0DBDpS1nGDuPqif4AMXPox0CsYK6S484/Txbqpo5Ec6eTFJtTEz
	IewAgmIA53JC89LyZVU/xhR6tjCNVkt/F5GIbmGeuxg==
X-Gm-Gg: ASbGncsVq3Ov+A4nfLJutj/Pa1SVBA0uUKoV4ZJkPYdHG09m8UpGPuLKuWgZKF2t2Su
	IknOozRivLnrLbGosqcczTeMkw3i6NvLTzI9PtsmSJdK20oveFkTJ3u5p2C9gIFlnjH2LBr/kCw
	Q9DpkqzFUVe6ZOsXFa4zDUma4bhGAIlQXE8Q==
X-Google-Smtp-Source: AGHT+IEyw0lUrmYinEboMHvAdYvFeBCQMFpAFX9P5BvMD2PBk8DgM7GAXBhZytV2fKUiOCBjFWXeZ1b8qL3n9/JSqsY=
X-Received: by 2002:a05:6902:120a:b0:e7d:cff1:340b with SMTP id
 3f1490d57ef6-e7dd01eea9bmr4498112276.0.1748424700237; Wed, 28 May 2025
 02:31:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
 <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com> <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
In-Reply-To: <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 May 2025 11:31:03 +0200
X-Gm-Features: AX0GCFsFhqUi2AGDMBlqa7RGrDqiU7Kbc5fKh9Fg0pv0gNT5kfMImVz5Whz-roI
Message-ID: <CAPDyKFptNg5t6RehRNNfnnuCqpfiaQLaHBEdh4aRXfn7X6rYQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, len.brown@intel.com, pavel@kernel.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 May 2025 at 23:27, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Hi Claudiu,
>
> On Mon, May 26, 2025 at 03:20:53PM +0300, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The dev_pm_domain_attach() function is typically used in bus code alongside
> > dev_pm_domain_detach(), often following patterns like:
> >
> > static int bus_probe(struct device *_dev)
> > {
> >     struct bus_driver *drv = to_bus_driver(dev->driver);
> >     struct bus_device *dev = to_bus_device(_dev);
> >     int ret;
> >
> >     // ...
> >
> >     ret = dev_pm_domain_attach(_dev, true);
> >     if (ret)
> >         return ret;
> >
> >     if (drv->probe)
> >         ret = drv->probe(dev);
> >
> >     // ...
> > }
> >
> > static void bus_remove(struct device *_dev)
> > {
> >     struct bus_driver *drv = to_bus_driver(dev->driver);
> >     struct bus_device *dev = to_bus_device(_dev);
> >
> >     if (drv->remove)
> >         drv->remove(dev);
> >     dev_pm_domain_detach(_dev);
> > }
> >
> > When the driver's probe function uses devres-managed resources that depend
> > on the power domain state, those resources are released later during
> > device_unbind_cleanup().
> >
> > Releasing devres-managed resources that depend on the power domain state
> > after detaching the device from its PM domain can cause failures.
> >
> > For example, if the driver uses devm_pm_runtime_enable() in its probe
> > function, and the device's clocks are managed by the PM domain, then
> > during removal the runtime PM is disabled in device_unbind_cleanup() after
> > the clocks have been removed from the PM domain. It may happen that the
> > devm_pm_runtime_enable() action causes the device to be runtime-resumed.
> > If the driver specific runtime PM APIs access registers directly, this
> > will lead to accessing device registers without clocks being enabled.
> > Similar issues may occur with other devres actions that access device
> > registers.
>
> I think you are concentrating too much on runtime PM aspect of this. As
> you mentioned in the last sentence the same issue may happen in the
> absence of runtime PM if the power domain code will shut down the device
> while it is not fully cleaned up.
>
> >
> > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
> > dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
> > device is detached from its PM domain in device_unbind_cleanup(), only
> > after all driver's devres-managed resources have been release.
> >
> > For flexibility, the implemented devm_pm_domain_attach() has 2 state
> > arguments, one for the domain state on attach, one for the domain state on
> > detach.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > ---
> >
> > Changes in v2:
> > - none; this patch is new
> >
> >  drivers/base/power/common.c | 59 +++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_domain.h   |  8 +++++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> > index 781968a128ff..6ef0924efe2e 100644
> > --- a/drivers/base/power/common.c
> > +++ b/drivers/base/power/common.c
> > @@ -115,6 +115,65 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
> >
> > +/**
> > + * devm_pm_domain_detach_off - devres action for devm_pm_domain_attach() to
> > + * detach a device and power it off.
> > + * @dev: device to detach.
> > + *
> > + * This function reverse the actions from devm_pm_domain_attach().
> > + * It will be invoked during the remove phase from drivers implicitly.
> > + */
> > +static void devm_pm_domain_detach_off(void *dev)
> > +{
> > +     dev_pm_domain_detach(dev, true);
> > +}
> > +
> > +/**
> > + * devm_pm_domain_detach_on - devres action for devm_pm_domain_attach() to
> > + * detach a device and power it on.
> > + * @dev: device to detach.
> > + *
> > + * This function reverse the actions from devm_pm_domain_attach().
> > + * It will be invoked during the remove phase from drivers implicitly.
> > + */
> > +static void devm_pm_domain_detach_on(void *dev)
> > +{
> > +     dev_pm_domain_detach(dev, false);
> > +}
> > +
> > +/**
> > + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attach()
> > + * @dev: Device to attach.
> > + * @attach_power_on: Use to indicate whether we should power on the device
> > + *                   when attaching (true indicates the device is powered on
> > + *                   when attaching).
> > + * @detach_power_off: Used to indicate whether we should power off the device
> > + *                    when detaching (true indicates the device is powered off
> > + *                    when detaching).
> > + *
> > + * NOTE: this will also handle calling dev_pm_domain_detach() for
> > + * you during remove phase.
> > + *
> > + * Returns 0 on successfully attached PM domain, or a negative error code in
> > + * case of a failure.
> > + */
> > +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
> > +                       bool detach_power_off)
>
> Do we have examples where we power on a device and leave it powered on
> (or do not power on device on attach but power off it on detach)? I
> believe devm release should strictly mirror the acquisition, so separate
> flag is not needed.

This sounds reasonable for me too.

Note that, in most of the *special* cases for where
dev_pm_domain_attach|detach() is used today, the corresponding PM
domain is managed by genpd through a DT based configuration. And genpd
via genpd_dev_pm_attach|detach() doesn't even take this as an
in-parameter.

So this is solely for the behaviour for the acpi PM domain, just to
make sure that's clear.

[...]

Kind regards
Uffe

