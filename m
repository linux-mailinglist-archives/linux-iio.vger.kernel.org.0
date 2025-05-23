Return-Path: <linux-iio+bounces-19827-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81938AC247B
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1CB164C26
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45660293B4C;
	Fri, 23 May 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWNSdYIQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046D230BE8
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748008176; cv=none; b=GBifnxbMZhWiLfMhBgNqu6omgUKPFTwN2OS7xVQr5ZmHaBzyrNGGn67ta3RWwrJsJuI1jI4kcDlcViDOlmt8EiZBIl98l92pkmlrfGkTYMKxskO5St9j09+lAGijvpIakjk/Cr3OsfQ8mIPWHgthHQJa9/E4e8bsdkQaAT2akc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748008176; c=relaxed/simple;
	bh=hQH4sl4pAH2WPO33R/7uyvvZOOHNtsDFvCDO5Xyji5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vat5uSEGZ37bcb8Q6IrXBqTsqxqZhtAhY6zHFhODmxnd4Yi/jsmrwsYPv9QJoaIZk3L5fao+n6nBbJ4//md5I+FZwSPYsy1sIzjYHul6vs/3nVPaUURPvZVH1llY6cK74iYXdMEmryHbVoMPTWTkhCTSedXKUtXLRZQsOY/d0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qWNSdYIQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7b3178473eso8636692276.2
        for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748008173; x=1748612973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jm7LJvTGmSbZFlkn4UoigKXMnhFDdijfvdo8t5yXxjg=;
        b=qWNSdYIQeErMMhjJVz2qT79n9g/JRctNfv0E3/6C/7edhOW/tnfd8s3Ta1CFIkat+j
         x/G4z3bGJNqh0Bx2DJZWgs+uDSsDYYe90vGyvWptbWdTTSikEYg9l+Uqmm27a4LqFHAH
         wj7KcXqFg6sqswGOKutosag3IdtktE0KOItFMCkSR7de/4YfFpzsX6agA+cl5S5tLhpq
         xX4pHvfLG7VgGL2MQK5enTL1O2qWUOR/bYDd6qzq9xxxwmkq9qQ1QE7PNQmk9PU4Zo92
         bxLDe5B8Uw6drmb7ZPWLZjey+PA9WO/ix6V7ii01bteB/f2thtIrZjX7izq8UsMd1Ix9
         ZWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748008173; x=1748612973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm7LJvTGmSbZFlkn4UoigKXMnhFDdijfvdo8t5yXxjg=;
        b=uDr+cocAUr21T2hSUrZyIPcIIvnRmLBvoRxUWgej+D6dWUWdgSD2z0vMHVDbCeHSis
         YWjZAucTsyowo7X/PWWCTuWeXVYPD3SqqSoCV0nvDGRAZn6QkobfW/Ypvx4Z4IH83ixj
         5U7fFyFXji6Xul/Z9KplLDucsSBt12VDYn1keqIHP0P8qBI5JvP8r69LT1D58J0P9hLT
         MeP7EuLDcCrS+qYtxrWp4QZ/beDxSl51VeHGst8WGn1eSocq0yDoFaFQM54M7fbj/xVk
         QePz/HNgDIPxxE0EKdCfSYrCzbcSQAvdQr2osKrpfrORdtk2CeQE/Emfx1R9mZu2dI0r
         dvyw==
X-Forwarded-Encrypted: i=1; AJvYcCUGLYi7X8n8S9C6JY/neCwFIcALqpxtdVA4o9b2rMtyP9eSTexifjvaeeJbNwen5bZX7yUIYV5Wm+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZ5l5HoPnGeC1KdkYBzn2GplB5zzKPXAgtTBaTEBcMfBTYriG
	ixvkT5zQwcAwDhgA6IAWJYtfSgqpj/UI4V9v+R7OsR4NBDPRwINYs9ux+v9693a/P6L/oqJWXb0
	agHkgUfhr4eoz4SabTzvHOmGHVF+A0S2+g3l6sGRbhA==
X-Gm-Gg: ASbGncuFqaTmNGE5db/Ykwdq/KDeYTG6kTCsQdHMJlp4qFdxW/mJscahj/Rqf5UgMiV
	c3wHCI5NhDSuBnWhZCjitqLRRTC3kBvM8dMnBBNxcTmz66IBedlp9SG1vvCA7UW5FwiGGuUkJ8c
	lEJEKc1OQO5SgZIA4i5I54y3/6TjOlpufLmw==
X-Google-Smtp-Source: AGHT+IGNqYy2yI4RNlUni96VpZTudvYTqV4SwGwfXprccTDokjVwD65TwJIsh8Rz9fSY0wLyanwf8XtnOdcJPBjSIrQ=
X-Received: by 2002:a05:6902:1025:b0:e7d:702d:934b with SMTP id
 3f1490d57ef6-e7d702d950cmr6373613276.32.1748008173039; Fri, 23 May 2025
 06:49:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev> <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev> <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
 <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev> <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>
 <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
 <CAPDyKFoxs6wDCLp5EGHVqkqSstBLNmngps2KfanRezV_EN8tuA@mail.gmail.com>
 <hd3hobuaunmn2uqzl72yv7nz2ms25fczc264wmt6o7twrxdhsy@mm22ujnawutc>
 <CAPDyKFpRUhTK=UfcEdRdT0f5EVoGN5okLosd9_tYjdGKr0qvkA@mail.gmail.com> <47853bb8-db03-42b1-bcc2-3338fc208abb@tuxon.dev>
In-Reply-To: <47853bb8-db03-42b1-bcc2-3338fc208abb@tuxon.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 May 2025 15:48:56 +0200
X-Gm-Features: AX0GCFsSac-ldUQm8kyY0pi3eboltE5eDrGVCa-jAdlSEMVJc5esYEhG-rZoc2Y
Message-ID: <CAPDyKFofyCNCbGfwo9D0-fwH9Bf+7hpcQUE1jUGwSrSKvEBm4A@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 May 2025 at 12:52, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Ulf,
>
> On 23.05.2025 12:47, Ulf Hansson wrote:
> > On Fri, 23 May 2025 at 01:06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >>
> >> On Fri, May 23, 2025 at 12:09:08AM +0200, Ulf Hansson wrote:
> >>> On Thu, 22 May 2025 at 20:47, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >>>>
> >>>> On Thu, May 22, 2025 at 06:28:44PM +0200, Ulf Hansson wrote:
> >>>>> On Thu, 22 May 2025 at 16:08, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >>>>>>
> >>>>>> Hi, Ulf,
> >>>>>>
> >>>>>> On 22.05.2025 14:53, Ulf Hansson wrote:
> >>>>>>>
> >>>>>>> That said, I think adding a devm_pm_domain_attach() interface would
> >>>>>>> make perfect sense. Then we can try to replace
> >>>>>>> dev_pm_domain_attach|detach() in bus level code, with just a call to
> >>>>>>> devm_pm_domain_attach(). In this way, we should preserve the
> >>>>>>> expectation for drivers around devres for PM domains. Even if it would
> >>>>>>> change the behaviour for some drivers, it still sounds like the
> >>>>>>> correct thing to do in my opinion.
> >>>>>>
> >>>>>> This looks good to me, as well. I did prototype it on my side and tested on
> >>>>>> all my failure cases and it works.
> >>>>>
> >>>>> That's great! I am happy to help review, if/when you decide to post it.
> >>>>
> >>>> So you are saying you'd be OK with essentially the following (with
> >>>> devm_pm_domain_attach() actually being elsewhere in a real patch and not
> >>>> necessarily mimicked by devm_add_action_or_reset()):
> >>>
> >>> Correct!
> >>>
> >>>>
> >>>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> >>>> index cfccf3ff36e7..1e017bfa5caf 100644
> >>>> --- a/drivers/base/platform.c
> >>>> +++ b/drivers/base/platform.c
> >>>> @@ -1376,6 +1376,27 @@ static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env
> >>>>         return 0;
> >>>>  }
> >>>>
> >>>> +
> >>>> +static void platform_pm_domain_detach(void *d)
> >>>> +{
> >>>> +       dev_pm_domain_detach(d, true);
> >>>> +}
> >>>
> >>> Well, I would not limit this to the platform bus, even if that is the
> >>> most widely used.
> >>>
> >>> Let's add the new generic interface along with
> >>> dev_pm_domain_attach|detach* and friends instead.
> >>>
> >>> Then we can convert bus level code (and others), such as the platform
> >>> bus to use it, in a step-by-step approach.
> >>
> >> Right, this was only a draft:
> >>
> >> "... with devm_pm_domain_attach() actually being elsewhere in a real
> >> patch and not necessarily mimicked by devm_add_action_or_reset() ..."
> >>
> >>>
> >>>> +
> >>>> +static int devm_pm_domain_attach(struct device *dev)
> >>>> +{
> >>>> +       int error;
> >>>> +
> >>>> +       error = dev_pm_domain_attach(dev, true);
> >>>> +       if (error)
> >>>> +               return error;
> >>>> +
> >>>> +       error = devm_add_action_or_reset(dev, platform_pm_domain_detach, dev);
> >>>> +       if (error)
> >>>> +               return error;
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>>  static int platform_probe(struct device *_dev)
> >>>>  {
> >>>>         struct platform_driver *drv = to_platform_driver(_dev->driver);
> >>>> @@ -1396,15 +1417,12 @@ static int platform_probe(struct device *_dev)
> >>>>         if (ret < 0)
> >>>>                 return ret;
> >>>>
> >>>> -       ret = dev_pm_domain_attach(_dev, true);
> >>>> +       ret = devm_pm_domain_attach(_dev);
> >>>>         if (ret)
> >>>>                 goto out;
> >>>>
> >>>> -       if (drv->probe) {
> >>>> +       if (drv->probe)
> >>>>                 ret = drv->probe(dev);
> >>>> -               if (ret)
> >>>> -                       dev_pm_domain_detach(_dev, true);
> >>>> -       }
> >>>>
> >>>>  out:
> >>>>         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> >>>> @@ -1422,7 +1440,6 @@ static void platform_remove(struct device *_dev)
> >>>>
> >>>>         if (drv->remove)
> >>>>                 drv->remove(dev);
> >>>> -       dev_pm_domain_detach(_dev, true);
> >>>>  }
> >>>>
> >>>>  static void platform_shutdown(struct device *_dev)
> >>>>
> >>>>
> >>>> If so, then OK, it will work for me as well. This achieves the
> >>>> same behavior as with using devres group. The only difference is that if
> >>>> we ever need to extend the platform bus to acquire/release more
> >>>> resources they will also have to use devm API and not the regular one.
> >>>
> >>> Sounds reasonable to me! Thanks for a nice discussion!
> >>>
> >>> When it comes to the devm_pm_runtime_enable() API, I think we
> >>> seriously should consider removing it. Let me have a closer look at
> >>> that.
> >>
> >> I think once we sort out the power domain detach being out of order with
> >> regard to other devm-managed resources in bus code you need to analyze
> >> this again and you will find out that much as with IRQs, devm API for
> >> runtime PM is useful for majority of cases. Of course there will be
> >> exceptions, but by and large it will cut down on boilerplate code.
> >
> > Well, the problem is that the interface is just too difficult to
> > understand how to use correctly.
> >
> > A quick look for deployments in drivers confirms my worries.
>
> Maybe we can add something like:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 96e64f3d7b47..568a8307863b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10100,6 +10100,7 @@ F:
> Documentation/devicetree/bindings/power/power?domain*
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
>  F:     drivers/pmdomain/
>  F:     include/linux/pm_domain.h
> +K:      \bpm_runtime_\w+\b
>
> in MAINTAINERS file so that any new patch using the RPM will also be sent
> to PM maintainers and checked accordingly?

Well, I like the idea, but I am worried that it may be too much for me
to review. :-)

Although, perhaps I should help Rafael, more officially, to helpt
review code under "POWER MANAGEMENT CORE". Runtime PM is part of it.

Rafael, what do you think?

Kind regards
Uffe

