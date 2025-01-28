Return-Path: <linux-iio+bounces-14657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1110FA20419
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 06:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8711885AAB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 05:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20F1C3BF7;
	Tue, 28 Jan 2025 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNDBdPJn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF442A92;
	Tue, 28 Jan 2025 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738042850; cv=none; b=p+azheBEW3Wvf8Pw2cpr89NUp7h0JYiFVbiTiZYY841d7GFXW2fSprZKCPNjXAdyaHFyeiv8AO9JyDFTQSjX1P//kWd/l0dqKz5KNLz+JbEh8Dcq1gxOKGPNDUafh98nemygDGIQFfjeQwNRLX44GYgk0MjLADdG1sEyqJd9Ydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738042850; c=relaxed/simple;
	bh=fp/AKR08leJQyxoIVH0K+aUyLAtVoeweGwz7qftQjQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z34ww2+Dxwqz1ractwRUHSufzzOAmL7bmPAKC6ZLIms0+gKhw+BUwojtm45An5fPfkplUiaQ54isdRoUmOXElLdS4PE/id53SJkaBR32DfOyK07ZYDD/MqQMGd9W+x0+zCGB831UZIt8za+Ly+axZmefvvKHObDl2dFCw7vnFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNDBdPJn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21619108a6bso89443155ad.3;
        Mon, 27 Jan 2025 21:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738042848; x=1738647648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+SSF90F8yfJ8x0hIchNY8H6SvKBtg5lmJmCIqNZqmQ0=;
        b=iNDBdPJnRwP7S1eL+36A/6VMMWfkyNZ2B39OH1738DeiMpYzdBhF2/5dsIEvaRu8Az
         73dl52sd3DsF6iOsBQK2irHnd/cW6qFpCr3nfEY+2g/5mO1ZfaZ2OS226AEFDrvDNKem
         MbYe+EdbA1VV25zuQ668zZCYFMkjyl2DjWD8sEO0Np8yti9lYqLnI035wIaDeMkYuwfM
         6FE8DUD2+1WBVZklmhHg5Yu6dJauuIzCM7yL37g9ZiSeUb0QiahjWckmAIUaAP7BOMDU
         B0OAORpC6YoST1Whg50KxM32MNgvaYHSJYZjYKcnlUtT7+FXYNca+d/tjVZQGSMj8A3w
         wwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738042848; x=1738647648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SSF90F8yfJ8x0hIchNY8H6SvKBtg5lmJmCIqNZqmQ0=;
        b=JBSoEr7ceGAGexRplUP2sPb1K+i2/w/8SrEWtReMy64NRxdO2WoQbII12/8+w9P+O7
         vSV3tK45w3YNAwzNIFqCbjHXdmDKaEP0+odC1fq9ZQY81Cw6d6vHNYA3rNY/ig/9S/C6
         eFnS8zSIhffWQIZyOYjDx5eCtxVLMI5s435F31jCNSPyC2trvDsBTt0EY/1aROhP16IW
         7pu+YXAnMTtu2mFnJjuKjLlceHDs1W6MBJS/BAKBdSXVFaWRpLPSbaGakb8yLNAkKLTo
         Ha5HYVL5mjXJ2AzC029DfnCwQ+d7bFCu2gNpBTd/Ci95Bfn1ZNu2OVCHAMHG7dNj0ndc
         n4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIZv+6ULhl36Sq4L7RywIUW9vskssKYIdtFx2F6VQ1qfyf3nRjohIl3UdHgPF7EBCvGD0GNlpbdNWqBCKw@vger.kernel.org, AJvYcCVWHpRXjtlvTSPCIjSoLtiJc3RHOw6z4aHm/6ye4K80mTyPZu+x3kdIJm/6OCTrCtSNYb0sz2nPrIecFfz2pIpqdTw=@vger.kernel.org, AJvYcCWqcbLpgzyBNWXj0/tGBh5XuMeCCGfajjBSdBzMbfKtHKsfc2ctocD+j/wUXtxqITwu3eqZmYQcLMk=@vger.kernel.org, AJvYcCXNUcvRRcOFLfFKkGIeuSL55MrNhfjukA+JQAKPNYPBj1hNRA2wn/o57SPFEbm5aCLqLd8w23UXy+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotzvDD9/dpAWvYMK0AYWehe7y47f5Q2Hg6OnyzehgCJvra/dt
	8ayvqAdWNmccDHERLqp7fuW0ALN5owbc9I9aN4dk7VmjEt+CbQTL
X-Gm-Gg: ASbGncsquCKXNn2p2OL84xQIUuAmRpTeoSPhqKxPaxn0oJUYZG8nj6aoUud9xUu2yRY
	MtNI44AfYOjdcAZ3neSzqpIsOwJXSKy4xyOtNsg+VfljJ5YWrRjewJXP6dJI3TbSSxfxB/c6pYx
	9tgBRbdcV/9uOujLbn/FJEv4YLxTzDasMd3sKf8dsl7mb+x4fRLnPVjRfiUqiNLBzwubfgr/29N
	2WcOKRkzVQgfrT+/YP6tw8owZ7bzremPWGepsgi1mdq6vKwNj9ZwfBzdlTVDaHs9mkGFApXdJzR
	wg+sZzMqWq8CJXxm
X-Google-Smtp-Source: AGHT+IFrI6uP8tYy0mKk4T2DvFbyzTZKJTN/fkpEQtKd5Pfd6b5+ZPMZJecQ51L7PGR+AEOJS0S3pw==
X-Received: by 2002:a17:903:1ca:b0:216:282d:c692 with SMTP id d9443c01a7336-21c355a4923mr737047195ad.34.1738042847687;
        Mon, 27 Jan 2025 21:40:47 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:8037:dfc5:6e64:2e4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c5casm72788775ad.26.2025.01.27.21.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:40:47 -0800 (PST)
Date: Mon, 27 Jan 2025 21:40:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
Message-ID: <Z5ht3NrbAOazH7ze@google.com>
References: <20250111131409.36bebfd3@jic23-huawei>
 <bb987a1b-a999-478c-8e35-124fcf41561d@tuxon.dev>
 <CAPDyKFoJ3pLU-5_b5MSxMZd7B1cfOvmcdqR4FGkU2Wb7No0mcw@mail.gmail.com>
 <20250117155226.00002691@huawei.com>
 <CAPDyKFpQUMOFtA-QCbYdaeKSDGJpnjcA+tiKZ=kzmrjYRtFZdw@mail.gmail.com>
 <20250124184137.0000047a@huawei.com>
 <CAPDyKFrqDfYEQHk0RsRi2LnMw_HgGozMW9JP9xmkAq52O7eztg@mail.gmail.com>
 <20250127123250.00002784@huawei.com>
 <CAPDyKFoCx3jQOptPrY0CYNpH1R+fszF3MUQLSTn_nreyi5-vPw@mail.gmail.com>
 <20250127182423.000013a7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127182423.000013a7@huawei.com>

On Mon, Jan 27, 2025 at 06:24:23PM +0000, Jonathan Cameron wrote:
> On Mon, 27 Jan 2025 16:02:32 +0100
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > On Mon, 27 Jan 2025 at 13:32, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Mon, 27 Jan 2025 11:47:44 +0100
> > > Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >  
> > > > [...]
> > > >  
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

There is also a similar fix in HID core.

> > >  
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

Right, this is a classic problem of mixing devm-managed resources and
ordinary ones. Every time we have a bus remove() method that is not
trivial we need to make sure the resources are released in the right
order, which is:

1. Driver-allocated resources
2. Bus-allocated resources
3. Driver-core allocated resources.

Establishing a devres group before calling into drivers' probe() methods
(and releasing it before doing the rest of the cleanup in remove()) is
one such way.

Thanks.

-- 
Dmitry

