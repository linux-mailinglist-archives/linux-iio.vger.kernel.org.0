Return-Path: <linux-iio+bounces-14597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B0A1D4C2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB9618859D1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964761D540;
	Mon, 27 Jan 2025 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+11nrSX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AC1FE476
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737974903; cv=none; b=VldHKMIqb/T2jCZuU0l6n/bNUvLkj4mNuKal49zUw30n7fiye1avbNJS/w8Hnwn6qUTNF9A8NaochWQBAcfiNeFKLAb4OvYufJURBGuY1gRG9EWjoUftSm05qKIz4HB4+x2UaMbPPwl1Yf43uIrG+CB9WzdKo6FpQRQV59V6TjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737974903; c=relaxed/simple;
	bh=cVfYDpficCohFcrzNa9coeEbPavpuEqiPyI/jnAHZ74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZGJh/zvhHi4FdpdsnTaCYPYAQhsPM0zeJytW1P4+5mQQh4OdWeSw1hLzLIaq0LaaXKVFrfSrxhWl/XnYSmTt6vI/Tv59jr7p+klrtlFFFTCJZynOeYMLrmPiZBuX2PdzzXHnmfqaFsNKEfFYL4VIGTsOUMeiE2HoZQMstcSMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+11nrSX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e460717039fso5719936276.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737974900; x=1738579700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NSK1KmnBTH3noL7N0wn3kkffXOYdA/4LXEZ/0Y0i5VM=;
        b=l+11nrSX5k+8Qg02zh0m8RlU2P/Fwm7gm3WbaIieDrdoL9zAexA8yEs4of/Om23t9L
         zjORRHTwTZl67oveLLrNhfH6O4JUf7QDDD0CRXFMeSRCKSXxOAbkMjlVJqwrloKaM5/6
         SUhONHW0at3wgdH6jHl6gOJ5MSVeI92LFQYTPMsT+KEbv/bO0QI9Y2oiNTLIrtzzxXDV
         1lrmVSZfbqM2Kv8Wl77lXUh6sUEGvVoU+lFzy0asnkVujKZ3CF4KQbzuXLNPMu3rQ2fI
         evzbG+wLaDpIHkD7k207gNv6hbhzmIUcA0nmiMUDwbfwkOdCA0AKkbhqlFFnN8hdbVEO
         +Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737974900; x=1738579700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSK1KmnBTH3noL7N0wn3kkffXOYdA/4LXEZ/0Y0i5VM=;
        b=SKYweb+dJccv9RqcOlRMWuUVfzkqvJg+y2gpeTp6In23xEEaCCD5YLHSQEEkPCmobA
         i3lqiPQ11GuoGJW62XiX6rg1pGxPtzLeSdjmXoBBQOqd4yJUqnuOWQDzh81qr2pG5JcZ
         GcWRy16ooGkD/0iF6TwUXpEz6PHAQjwZb+vSeaVxzH+YLx21e3CLmLela7dHdU6Ay2yi
         jaFXsuwY40IokiE3GaZ7zaUyGnxNDJ9Fl9a6KokUW3to6PDp8ofmUDpejtJ2zJ0rLxus
         qdJreuJFxLFHMUgiIz6bgfMEeA2hWTBVqS6vcpMYZtdCU2vDC1HK4ENmAyZuHKJE7PE2
         0TFA==
X-Forwarded-Encrypted: i=1; AJvYcCXGVRaZp/cDLxU7gR8aHhQIHgfMjiUg96U1wMBCDnsgwSKpTmcU5I9O31ZhjMFVz9o7t4346zg0/2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlAmTahnE46WBhpCsr9iMQWpMdVU/fCBlKlDs97Qly4SPSmLb
	sSaO2YtOo2yxhhR9A3oZbF2oUHPut3wF5QEue1KJ1oYnf3QPqRLFffBx8CPAQ8kyOh4tqMoG1d6
	EoO50/CrnE0nwCWBNsFa4qIlCaAxXXVuG7GDwpA==
X-Gm-Gg: ASbGncuqkly7l1FkwtdQYadYIYAoA4qWjiBNsqajxmRDvJp8gGJESCtzM6J7FO3fnlB
	/qVkPWBKJ0oGINT/AqHH9jxSI06zhkcy4oA5mymnW8jJGOeIIPJRjj1SMz6JbGRA=
X-Google-Smtp-Source: AGHT+IGctpWiSKGENLqcKg7sXeBOqsykRb/1UIfSn2LWLMHCI3gvtppA/y9gRe9SwfAL71MhWFwrhyP5Kb9ZnH2DKe4=
X-Received: by 2002:a05:6902:15ce:b0:e58:1575:6fa6 with SMTP id
 3f1490d57ef6-e5815757039mr14761395276.34.1737974900462; Mon, 27 Jan 2025
 02:48:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
 <20250104135225.2573285b@jic23-huawei> <44e4a6b4-39a4-49d0-b3a5-fc5545c39a56@tuxon.dev>
 <20250111131409.36bebfd3@jic23-huawei> <bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
 <CAPDyKFoJ3pLU-5_b5MSxMZd7B1cfOvmcdqR4FGkU2Wb7No0mcw@mail.gmail.com>
 <20250117155226.00002691@huawei.com> <CAPDyKFpQUMOFtA-QCbYdaeKSDGJpnjcA+tiKZ=kzmrjYRtFZdw@mail.gmail.com>
 <20250124184137.0000047a@huawei.com>
In-Reply-To: <20250124184137.0000047a@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Jan 2025 11:47:44 +0100
X-Gm-Features: AWEUYZl722XSDVxMEoGwQ2z6X-rHuYlmteCnNgp1UwkwpBCUpsCMEPYArzwBaCE
Message-ID: <CAPDyKFrqDfYEQHk0RsRi2LnMw_HgGozMW9JP9xmkAq52O7eztg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron <jic23@kernel.org>, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> > > > > Do consider OK to change the order in pm_runtime_disable_action() to get
> > > > > rid of these issues, e.g.:
> > > > >
> > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > index 2ee45841486b..f27d311d2619 100644
> > > > > --- a/drivers/base/power/runtime.c
> > > > > +++ b/drivers/base/power/runtime.c
> > > > > @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > > > >
> > > > >  static void pm_runtime_disable_action(void *data)
> > > > >  {
> > > > > -       pm_runtime_dont_use_autosuspend(data);
> > > > >         pm_runtime_disable(data);
> > > > > +       pm_runtime_dont_use_autosuspend(data);
> > > > >  }
> > > > >
> > > > > though I see a rpm_resume() call is still possible though pm_runtime_disable().
> > > >
> > > > I am still worried about keeping the device runtime enabled during a
> > > > window when we have turned off all resources for the device. Typically
> > > > we want to leave the device in a low power state after unbind.
> > > >
> > > > That said, I would rather just drop the devm_pm_runtime_enable() API
> > > > altogether and convert all users of it into
> > > > pm_runtime_enable|disable(), similar to what your patch does.
> > >
> > > That is making a mess of a lot of automated cleanup for a strange
> > > runtime pm related path.  This is pain a driver should not have
> > > to deal with, though I'm not clear what the right solution is!
> > >
> > > Key is that drivers should not mix devm managed cleanup and not, so
> > > that means that anything that happens after runtime pm is enabled
> > > has to be torn down manually.  One solution to this might be to
> > > always enable it late assuming that is safe to do so there is
> > > never anything else done after it in the probe path of a driver.
> >
> > The problem is that runtime PM isn't really comparable to other
> > resources that we are managing through devm* functions.
> >
> > Enabling runtime PM for a device changes the behaviour for how
> > power-mgmt is handled for the device. Enabling/disabling of runtime PM
> > really needs to be explicitly controlled by the driver for the device.
>
> I'm sorry to say I'm not yet convinced.

Okay, let me try one more time. :-)

>
> Devm callbacks are explicitly registered by the driver so that they
> are unwound in a specific order.  Many other parts of driver
> registration rely on this ordering.  This does not seem different
> for runtime PM than anything else.

If you compare clocks, for example. It's the driver that is in full
control of the clock gating/ungating. When the ->remove() callback
runs, the driver typically makes sure that it leaves the clock gated.
Then it doesn't really matter when the clock resource gets released.
The point is, the driver is in full control of the resource.

If runtime PM would remain enabled beyond the call to the ->remove()
callback, it would mean that the driver's runtime PM callbacks could
be called too. For example, userspace via sysfs may at any point
decide to runtime resume the device. In other words, we may end up
calling the runtime PM callbacks in the driver, when they are not
intended to be called. In the worst case, I guess we could even end up
trying to control resources (like a clock) from the ->runtime
_resume() callback, when the references to these resources may already
have been released.

>
> Superficially the issue here looks to me to be that a non devm
> cleanup is inserted by the bus->remove() callback into drivers
> that are otherwise relying on explicit ordering provided
> by managed cleanup.
>
> I appreciate there may be no trivial solution.
>
> Maybe we can minimize that impact by always doing runtime pm last
> in any probe() function?  Can that work here?
>
>
> >
> > If there are cleanups to be made for runtime PM, beyond disabling
> > runtime PM, we could instead consider adding that code in
> > pm_runtime_reinit().
>
> I'm not familiar enough to comment on this option beyond it being
> after devres_release_all() so, maybe?  It seems superficially
> a better point in the sequence.
>
> Jonathan
> >
> > [...]

Kind regards
Uffe

