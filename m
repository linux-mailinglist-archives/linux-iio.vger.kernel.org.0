Return-Path: <linux-iio+bounces-14613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE3A1D8F1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAED83A4DF0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423BF55897;
	Mon, 27 Jan 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO7/ToV5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCA13633F
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990191; cv=none; b=Iq1RlVk0qXx+PVtKJMYt0x82RlRAGxT29vew/gPbcgg57ajKusqABuYX1g/qclOvGrLMvi0lHdG+iTVhePKUHoIhMCxPXj4mly3KExXB6aY+DlCqu1/Caqez6HQZTuEuspLwSwfsK3BmLYhx60HUupCjc7I1vAIM+HCDWlYV8Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990191; c=relaxed/simple;
	bh=KgQQ5YANRbxtmZcEfox8jlX6dfC8/IJ+VxKphZA7qPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX8oXJalM8vhd4vcmb1XSeIo7E4kcic0GhxUKiBy33A+XlHrSvlxDPM1DPzEOJ/xXVBK5hI/F/A9sUivs3AC4JZGpguIs9IUnGzYtQ1WhB758rqq9clSW/456pkEmhRk4ZcopInBzppcw9Wlv/0KzDjdxfXyRprdzOVxNuBMErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eO7/ToV5; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso7941933276.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737990188; x=1738594988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NXZQ6nb4ZjNmSWmyYgZm9Czv4PRceNRa178kP6HZ8M0=;
        b=eO7/ToV5q+w+TfV7R8OaW/k3RWkcgG+5XSSKpXgSmn9Kzfsr42IEiTRsLNpeVR2Baz
         cnrrhFDqhctw1TB+1tS8AtR0H+nTrDvq9KCE8S5hoKqIyLxHCanAwh6Xd6f3YKZKQyZ0
         JpsWSDgnGhBVdp9JXbbZrQnCVuUYdlbHLC6vc/z41bEUIVwy61LnpGYe5SoVYJX+Nas+
         UNQF7Sj6lpkN8W0zvrs0pAl70+IXsiHqaZ6DqwO25zaulCQrWqUKk+bvyL5CJXGCMvlq
         k55whc0JvC8NKj2AW0sDwlx4SbY0N5iUcKPI8CU1avha312El5ioG0iAcNN8ZD6L+VF5
         mnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990188; x=1738594988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXZQ6nb4ZjNmSWmyYgZm9Czv4PRceNRa178kP6HZ8M0=;
        b=nnK7saidIXX2vlbRwpvj7sEL5sh1p3LZakL2XKYptj2OX2puKw7Fpin2RdwZxRuJBl
         5AputHYFxooe8dxqJwjxHElERKALc9lKg/jTc3TI2OEa2Ab12YiVhNgJXkxVPqQuGwGB
         mvS4wfnzD4d32UKil4eQp9TyWR39GlWP9SRN9orioJHARmnDReFnahk4ggUqyBhoQOY4
         Yvplyd3GFNvjvp4yJnOQ8zNj6VPN74K5jftf8Ss/6NpyAYzQyAw4Y8HswGPipNVG9MCK
         8/Qr3S2mIeFumYCutICN7Gxnws0fRnBYCBqOxh6GMVR5wpN90YSaz3yiYyavhbQlJBKm
         eA7g==
X-Forwarded-Encrypted: i=1; AJvYcCV1UDOT4L2gTh03UFXgEFV2L/1xbV2OSyWv/v5zB7GDOHdoUT8xAYh9jgj5S25RK/41as2/+PUv16k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKeWobG8CUsxv2hqTNACG+VMkf++cdxNzlokPpiZXJ9XTxmLOE
	yiUw8kOjQ14XZp5zAktvwpu8/ZKFiwKBgyuDQc7AN6BI9QhGnH6tjYH5UWar+sdg2BnRJhW1Vaq
	benO/lNu1tcCWQ/AXuNExjGn2nJkzPo1q9jOuOw==
X-Gm-Gg: ASbGncvGVB+uOPGAuAKn7k9jUyQNoNOXuLaPnOnZmaUA4FQGv+kV6KGaA9oaJlqQMnP
	Ul8EA84o/5+nBGIQx5nZmE12pCYc7T4l9FuE7X9/Tu1lE62jvIaXDlXoZXYpQFOw=
X-Google-Smtp-Source: AGHT+IEt6T/uZdsMbBRTR7v5lKTj+sx8hluU13fEefiuxj0xUTMAIdxo11ZKTBwu3aNDvJlMgWAozLpYi/KSFkSLEJY=
X-Received: by 2002:a05:6902:1501:b0:e58:1412:95e5 with SMTP id
 3f1490d57ef6-e5814129711mr17108491276.32.1737990187961; Mon, 27 Jan 2025
 07:03:07 -0800 (PST)
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
 <20250124184137.0000047a@huawei.com> <CAPDyKFrqDfYEQHk0RsRi2LnMw_HgGozMW9JP9xmkAq52O7eztg@mail.gmail.com>
 <20250127123250.00002784@huawei.com>
In-Reply-To: <20250127123250.00002784@huawei.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Jan 2025 16:02:32 +0100
X-Gm-Features: AWEUYZkibkIQT8TcMqUAUe1XzBqCQ3T6nHOIS2uELscvJhEfdW2W4UhZK7QYCLM
Message-ID: <CAPDyKFoCx3jQOptPrY0CYNpH1R+fszF3MUQLSTn_nreyi5-vPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron <jic23@kernel.org>, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 13:32, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 27 Jan 2025 11:47:44 +0100
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > [...]
> >
> > > > > > > Do consider OK to change the order in pm_runtime_disable_action() to get
> > > > > > > rid of these issues, e.g.:
> > > > > > >
> > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > index 2ee45841486b..f27d311d2619 100644
> > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > > > > > >
> > > > > > >  static void pm_runtime_disable_action(void *data)
> > > > > > >  {
> > > > > > > -       pm_runtime_dont_use_autosuspend(data);
> > > > > > >         pm_runtime_disable(data);
> > > > > > > +       pm_runtime_dont_use_autosuspend(data);
> > > > > > >  }
> > > > > > >
> > > > > > > though I see a rpm_resume() call is still possible though pm_runtime_disable().
> > > > > >
> > > > > > I am still worried about keeping the device runtime enabled during a
> > > > > > window when we have turned off all resources for the device. Typically
> > > > > > we want to leave the device in a low power state after unbind.
> > > > > >
> > > > > > That said, I would rather just drop the devm_pm_runtime_enable() API
> > > > > > altogether and convert all users of it into
> > > > > > pm_runtime_enable|disable(), similar to what your patch does.
> > > > >
> > > > > That is making a mess of a lot of automated cleanup for a strange
> > > > > runtime pm related path.  This is pain a driver should not have
> > > > > to deal with, though I'm not clear what the right solution is!
> > > > >
> > > > > Key is that drivers should not mix devm managed cleanup and not, so
> > > > > that means that anything that happens after runtime pm is enabled
> > > > > has to be torn down manually.  One solution to this might be to
> > > > > always enable it late assuming that is safe to do so there is
> > > > > never anything else done after it in the probe path of a driver.
> > > >
> > > > The problem is that runtime PM isn't really comparable to other
> > > > resources that we are managing through devm* functions.
> > > >
> > > > Enabling runtime PM for a device changes the behaviour for how
> > > > power-mgmt is handled for the device. Enabling/disabling of runtime PM
> > > > really needs to be explicitly controlled by the driver for the device.
> > >
> > > I'm sorry to say I'm not yet convinced.
> >
> > Okay, let me try one more time. :-)
>
> +CC Greg as the disagreement here is really a philosophy of what
> devm cleanup is relative to remove.  Perhaps Greg or Rafael can
> given some guidance on the intent there.
>
> Mind you I think I found another subsystem working around this
> and in a somewhat more elegant, general way (to my eyes anyway!)
>
> https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c#L630
> https://lore.kernel.org/all/YFf1GFPephFxC0mC@google.com/
>
> +CC Dmitry.
>
> I2C creates an extra devres group and releases it before devm_pm_domain_detach()
> As all devm calls from the driver end up in that group, they are released
> before dev_pm_domain_detach()
>

How would that address the problem I pointed out with runtime PM
below? This problem isn't limited to attaching/detaching PM domains.

>
> >
> > >
> > > Devm callbacks are explicitly registered by the driver so that they
> > > are unwound in a specific order.  Many other parts of driver
> > > registration rely on this ordering.  This does not seem different
> > > for runtime PM than anything else.
> >
> > If you compare clocks, for example. It's the driver that is in full
> > control of the clock gating/ungating. When the ->remove() callback
> > runs, the driver typically makes sure that it leaves the clock gated.
> > Then it doesn't really matter when the clock resource gets released.
> > The point is, the driver is in full control of the resource.
>
> Not a good example. devm_clk_get_enabled() does not gate the clock until

I was not referring to devm_clk_get_enable(), but rather just devm_clk_get().

To me devm_clk_get_enable() is another interface that we should avoid.
For example, what if the clock is already gated when the ->remove()
callback runs? Then we need to ungate the clock just to make the
devres path happy so it doesn't gate an already gated clock. And this,
just to save one or two lines of code.

Don't get me wrong, I certainly like the devm* functions in general,
but it's not a good fit for everything.

> the devm cleanup. The assumption being that nothing that affects
> it runs between the remove() and devm cleanup.  So pretty much identical
> to the runtime pm case.  They being that you have to obey ordering so
> that if you need to run something after the clock is disabled then
> you register that callback before you call devm_clk_get_enabled()
>
> >
> > If runtime PM would remain enabled beyond the call to the ->remove()
> > callback, it would mean that the driver's runtime PM callbacks could
> > be called too. For example, userspace via sysfs may at any point
> > decide to runtime resume the device. In other words, we may end up
> > calling the runtime PM callbacks in the driver, when they are not
> > intended to be called. In the worst case, I guess we could even end up
> > trying to control resources (like a clock) from the ->runtime
> > _resume() callback, when the references to these resources may already
> > have been released.
>
> This is all about what we consider remove. To me, with devm_ manged cleanup
> in place, both remove() and devm_ cleanup count as parts of that remove
> process.

There is no straightforward process here, if you would keep runtime PM
enabled beyond ->remove(). Things can happen in parallel.

In that case, drivers would need to extend their runtime PM callbacks
to cope with more complicated conditions, as resources that those use
may have been released. Moreover, how can we make sure that the device
is put into a low power state after the ->remove() has been called?

>
> One option I did wonder about was having a devm_pm_domain_attach()
> A little cheeky but I think the call in platform_probe() is late enough
> that we don't run into the checks on no devm_ calls before driver probe.
>
> That would shuffle the dev_pm_domain_detach() to the end of the
> devm_ cleanup.  Mind you the i2c approach above seems better.

Again, this isn't limited to PM domains.

[...]

Kind regards
Uffe

