Return-Path: <linux-iio+bounces-14658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6144CA20567
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 08:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9673A6E88
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717C1DE3BE;
	Tue, 28 Jan 2025 07:59:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770331B041E;
	Tue, 28 Jan 2025 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738051191; cv=none; b=SQJB+WKyaKsYaGJl6owJNam2zvbrZnpbOVOiBzbjYiSmhr+sGfbRgnV6B5Lhpn97qt/69qJqVr6Tup62pwG1d0P4xlsXUMbjiVv82+yKnt1lFFMBraHUplV4iE6/ARdf+KveVnu3d+w3/aqQcRSFZd1l2z4bnw/VACkvQ+E5iN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738051191; c=relaxed/simple;
	bh=y/fc29ivdkct0Xj2LxTIC29tk78+k0r5ljthRSoP2pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEzjm00p6yFfY16AeNhXW7y9lopX+v4TSg2txt3jWRGEzgigDA3vFLXjIXXJ5PU2CkcPjc0nC6poBUpYY79aIMBGA8v5U+X2IcgrC2hbLChx/19VdOUH4RjFDNFIplfrGpWweCqFR9o7vO1jq88dapdxJZGx3n164lnPu6N5smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5188b485988so1706968e0c.3;
        Mon, 27 Jan 2025 23:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738051186; x=1738655986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbvVyvxoQYODfH3WfXt4tDarZow+qa4UJwH0MIj9+GQ=;
        b=TI9ibyGx6iLudxRYLfMOk3+ScH+/yQ36N8CuK3OW7lLx/ILL4dmOxZyBkPYmVG4pqO
         hwte8IHgXgoaRLkr5A+3/sEt/55PTkdHyxkejA37F6+XfJprgpLQ4itlh6XqkaKW15nl
         Wz4rey8FUAG707ik4NJBN7DXM8rZ03abu9VybJ7LZjtIUBtHwctE/b0nq6a27Ie7X6ow
         8zpimo5m8RwbG+NlltPtTXzMTPk2QkhoAVqdQsB/e8vHEe02HoCRgedJY7rpPzrp+/oq
         q3nmuhZWwGp2JvVxL5zoiIA5EXWoNVmtj2ejdA2CAmJHTkM4L73RTOnxwIdY1lLDGMcz
         YoxA==
X-Forwarded-Encrypted: i=1; AJvYcCUbFPQWM3r/wSDHDr1y9cX6viLwPzxuycUBpWFxtdW1jjHYuSkLVS2imCsJ7dDD27+fcsHfXgRH3a9knGmn@vger.kernel.org, AJvYcCVS6YPkgUfPHiRiXGRl3d93ibWSYy4DdM5E9q2rmwwbz0ALL3hd7p90+FuFKDuCU5z7ctS1yjLu25sPqFEcVoN9YN8=@vger.kernel.org, AJvYcCVoyDvhXL/GaguRlML7gb8m0a79FvVwjTrbuS6SCMk4RCUpERFl7/HreIB1juB0ARptkYAEO6lKPiY=@vger.kernel.org, AJvYcCWmpOPVjM2agBn8k/8braUAakMoFMiFeT1dbXxZuKZ87uss7ZwFmCbOhVZ95JgdvWEH8rwiroGXjoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9nDvfgHOBrdJhKp9Bpa9yuMqKIsHxsocC7VEBgUJTActWXEH
	A+DOheEdFkv4LXCLRk7XKPCQMrWWZhwrWYufoS7n5xqQprR5klMU0dIKGkuHgGA=
X-Gm-Gg: ASbGncv4bJjL8wz/yoKE9GshU51QphJ5sEYAsovFsDGVrOymSLZlSLk/GUov4oog+fX
	/qAx0tMFfWiITcDBkE76GLikcQgrWxgQKSjClPc00UAvrwvYg6W8RDa7DfyAarFmxMWYIkkUyjY
	4sPQZeLXtRh3X+KaP8c5z8CgrHc3KuzIyfJcvf/lTDglkdWw4CoeegJlqCh+s7OqZPsynsIdBZq
	NKUdnGONGXn3ZnIgI1t6vsjVVRdmjyzY8mdo4vWCWHMNpGwpJLgLDaO6gCn5QB5P/FnqzmS2B5o
	Ji+Xpv2jMONmxlNDPzR6+ghdNJJcouyZoEMILKZhpP4fpI4zg/rFBU0mCw==
X-Google-Smtp-Source: AGHT+IHmzP+IEXFNJ+iXwIXpdagOkuL34pA3duK4G++bz5LtffGRV9ZJ/x0VqiA1U71rDsjPRu/+kg==
X-Received: by 2002:a05:6122:2510:b0:516:240b:58ff with SMTP id 71dfb90a1353d-51d5b26bd2bmr35623460e0c.5.1738051186484;
        Mon, 27 Jan 2025 23:59:46 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51e4e829ec7sm1808588e0c.0.2025.01.27.23.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 23:59:45 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5188e0c2b52so1622175e0c.1;
        Mon, 27 Jan 2025 23:59:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVf0zkxWpnpv5+fqRkTi+rUwdDzsF+rNdIESELunel6u17LVeq6y0Xib8DQtN9F5dx+Ll1wQLFF6co=@vger.kernel.org, AJvYcCW6dIdty0+pdJmrGyNLTEw1PJtgj6JjBpE2GawjL0s96T+ywxI3rJhM2pqmYT74OhrgzBG/H4sJVwD41VwoAmSG+5I=@vger.kernel.org, AJvYcCXIw9kwW/n6j5Je7JOoa4Dvi/cmwWUhCIt12vNlJO5ZxJ9pmctMU7iYXSTTRe03G/YBvDrfEZMhXb4=@vger.kernel.org, AJvYcCXrMpX39MPZBO0gZ3VkoSLnTvmJf/RRZQWeCnXZnashUupiOad+7JsFVM4+J2LssJTt96gvepb95EvpxNUP@vger.kernel.org
X-Received: by 2002:a05:6122:88e:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-51d592b338cmr33909450e0c.1.1738051185203; Mon, 27 Jan 2025
 23:59:45 -0800 (PST)
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
 <20250127123250.00002784@huawei.com> <CAPDyKFoCx3jQOptPrY0CYNpH1R+fszF3MUQLSTn_nreyi5-vPw@mail.gmail.com>
 <20250127182423.000013a7@huawei.com>
In-Reply-To: <20250127182423.000013a7@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Jan 2025 08:59:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAKkAdeZmS14i9ndkK3rcR1tCwxsLabJfbtDW2LkdTHg@mail.gmail.com>
X-Gm-Features: AWEUYZnSa4T5LAUal1X2k-ulc81Twc5DzveurhEeHe--GyzTUnRSWcsk3K4eRjI
Message-ID: <CAMuHMdWAKkAdeZmS14i9ndkK3rcR1tCwxsLabJfbtDW2LkdTHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jonathan Cameron <jic23@kernel.org>, prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Mon, 27 Jan 2025 at 19:24, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Mon, 27 Jan 2025 16:02:32 +0100
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Mon, 27 Jan 2025 at 13:32, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > > On Mon, 27 Jan 2025 11:47:44 +0100
> > > Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > > > > > Do consider OK to change the order in pm_runtime_disable_action() to get
> > > > > > > > > rid of these issues, e.g.:
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > > > > > > > > index 2ee45841486b..f27d311d2619 100644
> > > > > > > > > --- a/drivers/base/power/runtime.c
> > > > > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > > > > @@ -1547,8 +1547,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_enable);
> > > > > > > > >
> > > > > > > > >  static void pm_runtime_disable_action(void *data)
> > > > > > > > >  {
> > > > > > > > > -       pm_runtime_dont_use_autosuspend(data);
> > > > > > > > >         pm_runtime_disable(data);
> > > > > > > > > +       pm_runtime_dont_use_autosuspend(data);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > though I see a rpm_resume() call is still possible though pm_runtime_disable().
> > > > > > > >
> > > > > > > > I am still worried about keeping the device runtime enabled during a
> > > > > > > > window when we have turned off all resources for the device. Typically
> > > > > > > > we want to leave the device in a low power state after unbind.
> > > > > > > >
> > > > > > > > That said, I would rather just drop the devm_pm_runtime_enable() API
> > > > > > > > altogether and convert all users of it into
> > > > > > > > pm_runtime_enable|disable(), similar to what your patch does.
> > > > > > >
> > > > > > > That is making a mess of a lot of automated cleanup for a strange
> > > > > > > runtime pm related path.  This is pain a driver should not have
> > > > > > > to deal with, though I'm not clear what the right solution is!
> > > > > > >
> > > > > > > Key is that drivers should not mix devm managed cleanup and not, so
> > > > > > > that means that anything that happens after runtime pm is enabled
> > > > > > > has to be torn down manually.  One solution to this might be to
> > > > > > > always enable it late assuming that is safe to do so there is
> > > > > > > never anything else done after it in the probe path of a driver.
> > > > > >
> > > > > > The problem is that runtime PM isn't really comparable to other
> > > > > > resources that we are managing through devm* functions.
> > > > > >
> > > > > > Enabling runtime PM for a device changes the behaviour for how
> > > > > > power-mgmt is handled for the device. Enabling/disabling of runtime PM
> > > > > > really needs to be explicitly controlled by the driver for the device.
> > > > >
> > > > > I'm sorry to say I'm not yet convinced.
> > > >
> > > > Okay, let me try one more time. :-)
> > >
> > > +CC Greg as the disagreement here is really a philosophy of what
> > > devm cleanup is relative to remove.  Perhaps Greg or Rafael can
> > > given some guidance on the intent there.
> > >
> > > Mind you I think I found another subsystem working around this
> > > and in a somewhat more elegant, general way (to my eyes anyway!)
> > >
> > > https://elixir.bootlin.com/linux/v6.12.6/source/drivers/i2c/i2c-core-base.c#L630
> > > https://lore.kernel.org/all/YFf1GFPephFxC0mC@google.com/
> > >
> > > +CC Dmitry.
> > >
> > > I2C creates an extra devres group and releases it before devm_pm_domain_detach()
> > > As all devm calls from the driver end up in that group, they are released
> > > before dev_pm_domain_detach()
> >
> > How would that address the problem I pointed out with runtime PM
> > below? This problem isn't limited to attaching/detaching PM domains.
>
> It's associated with anything that happens after a driver remove is done.
> We just disagree on when that remove is finished. There is nothing special about
> the remove() callback, that is just part of remove process.
> No magic transition of state that allows new things to happen follows
> the device driver remove finishing. Sure you can get the remove
> handling ordering wrong whether devm is in use or not.  The trick is
> almost always to never mix devm and not.  Once you need a single bit of
> manual unwinding stop with the devm and do everything beyond that point
> by hand (in probe order, before that point in remove order)
>
> > > > > Devm callbacks are explicitly registered by the driver so that they
> > > > > are unwound in a specific order.  Many other parts of driver
> > > > > registration rely on this ordering.  This does not seem different
> > > > > for runtime PM than anything else.
> > > >
> > > > If you compare clocks, for example. It's the driver that is in full
> > > > control of the clock gating/ungating. When the ->remove() callback
> > > > runs, the driver typically makes sure that it leaves the clock gated.
> > > > Then it doesn't really matter when the clock resource gets released.
> > > > The point is, the driver is in full control of the resource.
> > >
> > > Not a good example. devm_clk_get_enabled() does not gate the clock until
> >
> > I was not referring to devm_clk_get_enable(), but rather just devm_clk_get().
> >
> > To me devm_clk_get_enable() is another interface that we should avoid.
> > For example, what if the clock is already gated when the ->remove()
> > callback runs? Then we need to ungate the clock just to make the
> > devres path happy so it doesn't gate an already gated clock. And this,
> > just to save one or two lines of code.
>
> If someone is using a clock that is gated by other calls in the driver
> that then indeed the use of devm_clk_get_enabled() is inappropriate
> or they turn they do need to enable the clock and turn it off again
> as you mention which is a mess but often needs doing anyway as we
> commonly need some clocks at least to put a device into a low power
> state.
>
> >
> > Don't get me wrong, I certainly like the devm* functions in general,
> > but it's not a good fit for everything.
>
> For anything that a driver otherwise calls in remove() they are
> a direct equivalent that is just called automatically. (though apparently
> not quite in platform drivers!) If you have a sequence that is
> sufficiently complex they may not be a good fit. I just don't think
> that the sequence in this driver (and many others) is complex.
> The driver code (with the above change from i2c ported to platform code
> to fix the specific problem) is a lot simpler before Claudia's v2 to
> change the handling. 32 lines added to work around this...
>
> >
> > > the devm cleanup. The assumption being that nothing that affects
> > > it runs between the remove() and devm cleanup.  So pretty much identical
> > > to the runtime pm case.  They being that you have to obey ordering so
> > > that if you need to run something after the clock is disabled then
> > > you register that callback before you call devm_clk_get_enabled()
> > >
> > > > If runtime PM would remain enabled beyond the call to the ->remove()
> > > > callback, it would mean that the driver's runtime PM callbacks could
> > > > be called too. For example, userspace via sysfs may at any point
> > > > decide to runtime resume the device. In other words, we may end up
> > > > calling the runtime PM callbacks in the driver, when they are not
> > > > intended to be called. In the worst case, I guess we could even end up
> > > > trying to control resources (like a clock) from the ->runtime
> > > > _resume() callback, when the references to these resources may already
> > > > have been released.
> > >
> > > This is all about what we consider remove. To me, with devm_ manged cleanup
> > > in place, both remove() and devm_ cleanup count as parts of that remove
> > > process.
> >
> > There is no straightforward process here, if you would keep runtime PM
> > enabled beyond ->remove(). Things can happen in parallel.
>
> How?  Nothing magic happens when a driver remove() ends.
> So there is no difference at all in a driver calling runtime pm disable
> in that code or in devres cleanup that happens immediately after that
> in the bus driver remove.
>
> > In that case, drivers would need to extend their runtime PM callbacks
> > to cope with more complicated conditions, as resources that those use
> > may have been released. Moreover, how can we make sure that the device
> > is put into a low power state after the ->remove() has been called?
>
> This is a fair question.  Also one commonly handled by drivers using devm
> though perhaps not for the reason you are thinking.  Key is that most
> drivers should not rely at all on runtime PM being built let alone
> enabled.

Drivers for components on SoCs that use PM Domains must use
Runtime PM, as that is the only available method to control the PM Domain.

> Solution is normally a devm_add_action_or_reset() call that
> registers a call to put the device into a low power state.
>
> Sequence is normally something like:
>
> 1) enable clks etc.

Can be done explicitly, or using pm_runtime_resume_and_get() in case
of a clock domain.

> 2) Turn the power on.

I assume you mean through a regulator, GPIO, or (deasserted) reset
signal?
In case of a PM Domain, that is done using pm_runtime_resume_and_get()
again.

> 3) device setup
> 4) enable runtime PM after setting the state to active. Let autosuspend
>    do it's work.
>
> On remove (all devm_ managed).
> 5) disable runtime PM.
> 6) Turn the power off (may involve a check on whether it is already
>    off though in many cases it's idempotent so we don't bother checking).
> 7) disable clocks.
>
> in this particular driver I'm assuming that the low power state is
> handled via the reset lines being put back into reset by the
> the unwind of the two
> devm_reset_control_get_exclusive_deasserted() calls.

No, power control is handled by the PM (Power and Clock!) Domain, which
controls both the power area (R9A08G045_PD_ADC) and the module clocks
(R9A08G045_ADC_ADCLK, R9A08G045_ADC_PCLK).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

