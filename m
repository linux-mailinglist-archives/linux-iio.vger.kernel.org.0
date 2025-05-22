Return-Path: <linux-iio+bounces-19815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B50AC174C
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 01:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13391C04101
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9A2BF3F6;
	Thu, 22 May 2025 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht/m0N2z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62582C033D;
	Thu, 22 May 2025 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955213; cv=none; b=ihH8r2kcNo2lyiJRrH0HyNj6qHdW2blyVpR6vv1U4kVA3Osdnq7qeZ1Y0H7SQL4lVPjfKBy82RQiArva1/4yBZvpvqo3uEHl7D9UzyanSXUwUB0/M0VWm9Lj0u7GO97auiNI4UXCQZTTz56ImefKjlcQ1mCqkV8ENAqFAz4089I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955213; c=relaxed/simple;
	bh=xp2gEGdxL4gvITseGz46xtMZ+uLCblWXLLQGn4MdhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHYJruyQuQi4UOf/7iE0erc58+5qM6K1CxnUROFcLNfD6Fs3v+Tzuhmf7T1QKtZKEN8ZQSrsFaJ1bSTqyoJ+B5jW3cae2WnrcawIIDapsbe/B0kS9t7SIriZ82FFWjnwFiOHKZS2TYxEccyXSa0MFaWzWNAKQFyqbJbjaOaWShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht/m0N2z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74068f95d9fso7509222b3a.0;
        Thu, 22 May 2025 16:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747955211; x=1748560011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QAKhy4iiLBv1l7QDi7CDt/6dLpT+ioC4ESr76y1HPRQ=;
        b=Ht/m0N2zqxGs2HLotPuuUY10w4OKETUo5mxVX3ujoLmDvp3mWTCDvmTLj2S6X7TVyE
         jU6tFBrhX1XOOATHo5N41jRQXGGJ7Hg9n56qm+HPHp/LE2DFa5wgBQCFvksdreEGWHCI
         zUNo1UNtplavC6A1VKTrRmMd/rUHSm8vlJTwOAz8TWqpmXKuYCSSRxUAdZAl9x4W1lLQ
         iOBmIkgLCdVBVkuBcJDZo3YllfIZzKx+72bTL0sSTBzQ68yZyOcAMN2rNPDjtNXHF7Qv
         X2jTk9aEKdldOUr/Ce0DQ7uTEYVZnXJeWpblto0IB946fIhb81PE6T0opPXlVhMi/+Mn
         Mh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955211; x=1748560011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAKhy4iiLBv1l7QDi7CDt/6dLpT+ioC4ESr76y1HPRQ=;
        b=oGPD8W2FuN30NyE4kxw4/loDjwo7OFkpgGp8z7u8j9isamJLFZi4gB9EjmDB7ct0in
         Ne3pzXVLxiM2IWJgW8/AEnVi1uG0bZbWAg3Fyf3I+TYH0ZWhL0wcZBBhSTkGvCAIWaWL
         U9FpvuB2is1DZYY3PAPYTBu1CzdSKdmbJP1U8bRU2WyTujsZGw5yGHszuZxooiehqzii
         b+FCiRZ72gHX44E044AtU2ANRwKpLGKkzmP4c2W2pquEQjS1r+49wrRF0nJuDgp37CRC
         4TlqVEKp0t3cLw4N73vF8gqfrAcWyqXI8/hsRVnIgzKZTV+QBEcD0Ao3+U/GubHGhd95
         POWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLNnWk/mS+5NmReAZGsw15M3R5XQxlh//4x9c/YDjVNjr+cMJwkbIP4s8wXEv6XEhpfHYG8rkOS4=@vger.kernel.org, AJvYcCVpYzAwzxunupaH0LRCI4CCj2EW9VW4sp45v1TmssU6jEhL1A9jlslbMtlTcnAgnZLo3EkUNdCEAhk=@vger.kernel.org, AJvYcCX/W6FUS4pjDssEq0EdDUtUaOXgsMmBW4Fu293+ngSZHjJ9vrUXLvjz7OCUmAYGn+jbIktsJnNYYAuSGVB7@vger.kernel.org, AJvYcCXjV/5VKLFN2sc4aL06Ij7HeWUd41CB4agiEtJjHCSE2wY11nfSNnmW/Ff2VMIIyQLTpWFY4YfRnRoDw28Cmne2/ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRjEmIZqKR20V8s7Ub8Zy73B/trypsI+C0QLbMLnQKMRoMTVL
	1LeYotCFGpPDGhQ4vW0+ncMeTIUTjJVT7Z6P1cZQ9YpQwreg4MuOcIr3
X-Gm-Gg: ASbGncu2SfQgqBlg3uo2cKgqJRQQ3NzsrUTx2qYu2S8hqjOJnSXV5DXIwTmc1vwCOge
	raFAuE+BfYAtd2PPqHJvcsXtCOTU6VLAXGdQK7n+3tEyGWYrPguzLrE6fZeXabNQqtih+FNFB3N
	aShDXV0aSMzA76PcCTm/aCcdPTF0B5ATu7YwvICWD7CfOf/CmA5Qoxu1h0NGZg1aEN4aHZMYy4U
	qE4VZwn3xa0MvJxafHfsfLAN0XhnqF6za8eAjI19qGgeFyZEcmhgMmWYMM1kmSmpOz28usa0xy/
	0G4mpm/oixuo8mmP92cfj1AKIjwNZdLotSiSYG9OVQufakKh9RXa
X-Google-Smtp-Source: AGHT+IHMZuSWOKsTMSLZmzfCpaFbJLJni2pvDaktkoMtYDLwAW4d5/C5udr2MOFQXAO1MEX/izqVJA==
X-Received: by 2002:a05:6a21:3941:b0:1f5:a3e8:64dd with SMTP id adf61e73a8af0-216f85c6d15mr41220130637.0.1747955210798;
        Thu, 22 May 2025 16:06:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4e98:8fc0:fed2:bab1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm11725405b3a.88.2025.05.22.16.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:06:50 -0700 (PDT)
Date: Thu, 22 May 2025 16:06:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <hd3hobuaunmn2uqzl72yv7nz2ms25fczc264wmt6o7twrxdhsy@mm22ujnawutc>
References: <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
 <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev>
 <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
 <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev>
 <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>
 <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
 <CAPDyKFoxs6wDCLp5EGHVqkqSstBLNmngps2KfanRezV_EN8tuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoxs6wDCLp5EGHVqkqSstBLNmngps2KfanRezV_EN8tuA@mail.gmail.com>

On Fri, May 23, 2025 at 12:09:08AM +0200, Ulf Hansson wrote:
> On Thu, 22 May 2025 at 20:47, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >
> > On Thu, May 22, 2025 at 06:28:44PM +0200, Ulf Hansson wrote:
> > > On Thu, 22 May 2025 at 16:08, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > > >
> > > > Hi, Ulf,
> > > >
> > > > On 22.05.2025 14:53, Ulf Hansson wrote:
> > > > >
> > > > > That said, I think adding a devm_pm_domain_attach() interface would
> > > > > make perfect sense. Then we can try to replace
> > > > > dev_pm_domain_attach|detach() in bus level code, with just a call to
> > > > > devm_pm_domain_attach(). In this way, we should preserve the
> > > > > expectation for drivers around devres for PM domains. Even if it would
> > > > > change the behaviour for some drivers, it still sounds like the
> > > > > correct thing to do in my opinion.
> > > >
> > > > This looks good to me, as well. I did prototype it on my side and tested on
> > > > all my failure cases and it works.
> > >
> > > That's great! I am happy to help review, if/when you decide to post it.
> >
> > So you are saying you'd be OK with essentially the following (with
> > devm_pm_domain_attach() actually being elsewhere in a real patch and not
> > necessarily mimicked by devm_add_action_or_reset()):
> 
> Correct!
> 
> >
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index cfccf3ff36e7..1e017bfa5caf 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1376,6 +1376,27 @@ static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env
> >         return 0;
> >  }
> >
> > +
> > +static void platform_pm_domain_detach(void *d)
> > +{
> > +       dev_pm_domain_detach(d, true);
> > +}
> 
> Well, I would not limit this to the platform bus, even if that is the
> most widely used.
> 
> Let's add the new generic interface along with
> dev_pm_domain_attach|detach* and friends instead.
> 
> Then we can convert bus level code (and others), such as the platform
> bus to use it, in a step-by-step approach.

Right, this was only a draft:

"... with devm_pm_domain_attach() actually being elsewhere in a real
patch and not necessarily mimicked by devm_add_action_or_reset() ..."

> 
> > +
> > +static int devm_pm_domain_attach(struct device *dev)
> > +{
> > +       int error;
> > +
> > +       error = dev_pm_domain_attach(dev, true);
> > +       if (error)
> > +               return error;
> > +
> > +       error = devm_add_action_or_reset(dev, platform_pm_domain_detach, dev);
> > +       if (error)
> > +               return error;
> > +
> > +       return 0;
> > +}
> > +
> >  static int platform_probe(struct device *_dev)
> >  {
> >         struct platform_driver *drv = to_platform_driver(_dev->driver);
> > @@ -1396,15 +1417,12 @@ static int platform_probe(struct device *_dev)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       ret = dev_pm_domain_attach(_dev, true);
> > +       ret = devm_pm_domain_attach(_dev);
> >         if (ret)
> >                 goto out;
> >
> > -       if (drv->probe) {
> > +       if (drv->probe)
> >                 ret = drv->probe(dev);
> > -               if (ret)
> > -                       dev_pm_domain_detach(_dev, true);
> > -       }
> >
> >  out:
> >         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> > @@ -1422,7 +1440,6 @@ static void platform_remove(struct device *_dev)
> >
> >         if (drv->remove)
> >                 drv->remove(dev);
> > -       dev_pm_domain_detach(_dev, true);
> >  }
> >
> >  static void platform_shutdown(struct device *_dev)
> >
> >
> > If so, then OK, it will work for me as well. This achieves the
> > same behavior as with using devres group. The only difference is that if
> > we ever need to extend the platform bus to acquire/release more
> > resources they will also have to use devm API and not the regular one.
> 
> Sounds reasonable to me! Thanks for a nice discussion!
> 
> When it comes to the devm_pm_runtime_enable() API, I think we
> seriously should consider removing it. Let me have a closer look at
> that.

I think once we sort out the power domain detach being out of order with
regard to other devm-managed resources in bus code you need to analyze
this again and you will find out that much as with IRQs, devm API for
runtime PM is useful for majority of cases. Of course there will be
exceptions, but by and large it will cut down on boilerplate code.

Thanks.

-- 
Dmitry

