Return-Path: <linux-iio+bounces-20277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48AAD0855
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 20:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7563B3D91
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235B1F0E29;
	Fri,  6 Jun 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St6kZK7N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F431EDA16;
	Fri,  6 Jun 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236128; cv=none; b=T/YXSrR2DAuEpe61XQL3KJ+8TIvVZltaVJn54ZQnTkmXEVSzvnP5sOhVyuYtHUXaroQLoHvYgeN1zm0RUkFg31rBQgFSAwiMZsBYyUEvYHdsakb5oz1cnTM5n1tvCbV6UfbQIU6UHEHH0c331OitrknohOweh8w4Jo/ht60lTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236128; c=relaxed/simple;
	bh=IdqCPrXq3+jr02GTO/nLSUv665Ny356ciChyjrXweKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5vyaPuvb0w9qBlP1CkR1RSJ+0xvrjbA/EtFfH4J18xRza1mwiEZ3G/i8TcL1/YD0KVFxgY6GzW+0gGI8eTa/kLHrp9xie061gfiBK7Si7YTVtTFgTg8ehyAr4tTAhHP0S+kOk7zwpqxgstYRxF9kSqurVgpTopUGxkK8UksBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St6kZK7N; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fba9f962so2127104b3a.0;
        Fri, 06 Jun 2025 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749236126; x=1749840926; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Es9M+AVV62UY8MMrou2h//EyFErMKtcnspa7i0MthIs=;
        b=St6kZK7N3MgyBnkDfOupZaTDpvp72Pr91Ufuz51cWAiJ0gGt3xzm3aeLDrt84P+zS/
         X74PbvpvqUCueWX/++LSjNWt8npOWiEufy7KJO0fMcyNwcAIzVZJ3Ut9AljNW91Q9SV/
         tDMrcyTQVqr94s+JMDZd8i9ImZXZeMGrkBMKt2DjLpWnhCHj1TWAQfR+Qkxzn3UpJFqn
         yyFSoIOSDJH/qS2mj5OLaUm5Y5jB/YybXxauxtaiOm17TueSK8xAxGlnnfLunfZ/Pa9r
         FJhEEtUGw0wYFtuusyrZJQSjrAW6PJSzR+oCOTsjiVbZMHesUsuvF0lm4eNpPdb7F/Ch
         jFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749236126; x=1749840926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Es9M+AVV62UY8MMrou2h//EyFErMKtcnspa7i0MthIs=;
        b=Qakp4ThzaY3IakWb4F645oMIduvPEhYpnM0uBRDtJbRpoZ+OPRvqHu3VYy8PTzVGUi
         TyyIJ+gYAC220y/swoL/f2sTc/CaahPSTFpXlHN4VSjQY2nkdnYJY7lPYCT/AUJwzw6u
         7tFrx1IC+QIU+IF6kZEGD/tqBHZkF7/Nw8LGjnKF/z3WBAdXgygpcMeYWF9wNedVo9Yz
         l/35HF6RMzwvReuNmZ92Yh8OPUnp0gX4QhKPLc/1c6txci/2fo9lJVjpCHIk18F0fd09
         HQJwmaeURlBr4Tq6vwbGFKf5+K7hHXBdZPwv3V9kbSa8o5s8MUjPa4yCRG1hNrIe22WE
         4Udg==
X-Forwarded-Encrypted: i=1; AJvYcCUYRb5LnderlJyKUfuGRd0GBV76LAJSsqvBrphvOlEzPuMvy50HoAvLXamuMGC0sRSgtg/tQ+gEJoGzqqYSudpijLU=@vger.kernel.org, AJvYcCUk1OzcoOFVVtq8DVHv3UCBKr1DAelkGFbaiEpxr39A9ziUAUQaGSyYJcVIAClzsj9EmcR/0zrlvUs=@vger.kernel.org, AJvYcCWPFssenc5A6uRBOyNQWASImymfhirFvrAKWARKWHX0wFmkQvWvlkiwyXKxOkPIzuLdRs3Lk2DfK3g=@vger.kernel.org, AJvYcCXBOTS6J9O6WsGV9ZHIiUmRxTm9FN2aBeUka4DxuTnlwueenUPgwGztRePICjwnnpVSZPFTKXne/iKe88Tj@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+5WBEwISpMGm2GWj3e1cdUr1fYUA8bT/dHI9F+Q3/a4LBiPO
	BaQG8NQ/vPwDGwEjYCBOOlRTCb8eFNJH5gTHY3a+dF+APY+sXSQB8HiZ
X-Gm-Gg: ASbGncuDdtm8Iof74St3WOiXHJ4QXiNwkwxF6rn1VmZAimyA4v9w+m/UwffbO1o0GTh
	OWNEUgI2LkA0USJVdfs25Ee8uLdGUML4sLWgPOMrwI1R7SLZJ9YoQDrq5ywVGAlD/KrP3xPSUJR
	0WjYqaW9blAQBNHkXVRrPIc4m9kqi8AnXYKJN5qYjisBDqVMy5XF74tqwAXNAk6DcShm2IK9DHF
	DbSB0kISPVb3p6rQCVFjS/YSahwm3cuc9G9xn09rb0nSEZLFYVLxXCxo1p1eIaPfztScO2iXahp
	4n+Nit5ZWbyUpqEcCvOFUOEfpATx3VdHMyWRkn/t0Bp786AN6yiq
X-Google-Smtp-Source: AGHT+IHuyoCrI5BcHlICcXmskDkgOBvo79KGR4zs3JSO9ZUGizxOdvPfSccKAax0CmvGcgczb/g54A==
X-Received: by 2002:a05:6a20:2449:b0:21a:de8e:5c53 with SMTP id adf61e73a8af0-21ee25affa2mr5896945637.12.1749236125912;
        Fri, 06 Jun 2025 11:55:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b7f5:ce33:d518:3164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c5f7fsm1593369b3a.116.2025.06.06.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 11:55:25 -0700 (PDT)
Date: Fri, 6 Jun 2025 11:55:21 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, 
	dakr@kernel.org, len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>

On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jun 6, 2025 at 1:18 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >
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
> 
> Don't use devm_pm_runtime_enable() then.

What about other devm_ APIs? Are you suggesting that platform drivers
should not be using devm_clk*(), devm_regulator_*(),
devm_request_*_irq() and devm_add_action_or_reset()? Because again,
dev_pm_domain_detach() that is called by platform bus_remove() may shut
off the device too early, before cleanup code has a chance to execute
proper cleanup.

The issue is not limited to runtime PM.

> 
> > If the driver specific runtime PM APIs access registers directly, this
> > will lead to accessing device registers without clocks being enabled.
> > Similar issues may occur with other devres actions that access device
> > registers.
> >
> > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
> > dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
> > device is detached from its PM domain in device_unbind_cleanup(), only
> > after all driver's devres-managed resources have been release.
> >
> > For flexibility, the implemented devm_pm_domain_attach() has 2 state
> > arguments, one for the domain state on attach, one for the domain state on
> > detach.
> 
> dev_pm_domain_attach() is not part driver API and I'm not convinced at

Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?
In that case we can go back to using devres group to enforce ordering,
but proper ordering is needed.

> all by the arguments above.

Please reconsider given the fact that issue is not limited to the
runtime PM.

Thanks.

-- 
Dmitry

