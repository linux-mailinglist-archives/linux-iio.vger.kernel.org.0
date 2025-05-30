Return-Path: <linux-iio+bounces-20035-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CA1AC8A99
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95559E0362
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515E21E082;
	Fri, 30 May 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JO9V1K8/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A121883E
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748596701; cv=none; b=CgBw3o6VlrTL8nG/y0hgFxn5bfi3XkL2ZM2oJ/W7qc1Z3G/938w7vVg3IJpo9ln9o6Nz3lxEKxQJgD75xfoQ0SbZsSlqiRfqN+VzuEIvnZtklqZWjz19EYWB/x7UJgEL6j/FZK01t07Mj3iWVkOJcfH+W/qseAbhwzkCxZNgapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748596701; c=relaxed/simple;
	bh=ebOJBYeeHCkyALDjIWQdDTTwURnubvG/RMOC2ONZm84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDJ0kSFzLSEciIm4jDaWE/MGgtnnMmCEBBTzl8PWdb4bIaOxWTagREF4LrWjK/giIUahfRzcXQ2NSk7hozn4LSJZrajNOmBOhNIndxHGaiWybs1jJ6sRdo9ypP/fRZO5R4QUpczb3g3SsP6a4PqqQ09G9w5knx+7gP23P5XyY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JO9V1K8/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e731a56e111so1632481276.1
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748596699; x=1749201499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9LSJUMPXEV1M8KFzX9qlsWTgwSLRhfElyDaP/rhgR2Q=;
        b=JO9V1K8/JqVH6STc3aC5hUeFMsyAGvVmnOc6iVsh+JcQAzddXP4NWCcPSxZbqcE9H+
         pbtJNqQ/kFu6zyfjQ0Ju8XwmisQPpwGLUi90u6fT1PFy40xo0RK63H/92/TLV7WnV7we
         O0hXGEjC9UEK3YZXz8n8yTmLdej1Oab3M2cdXFFldlKpChgPb5moAEtjTLkzdxKYbSIj
         BMxFTGg8lngG82+wA7OA9i9AuU3eK1oL4Jl3V2sQGreDu0w0W9NqBxKPZXAxmQ/qBCNL
         Aq94l5qiD0ncP+b5o3GRjI4V9IJra6qm48SWpqIZKoRCBsLE4UapoLHxkiO2A+VZaqna
         CMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748596699; x=1749201499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LSJUMPXEV1M8KFzX9qlsWTgwSLRhfElyDaP/rhgR2Q=;
        b=DhZ2Nar3h5MQDalxdxpCHc8dXJSMzlOkoCukFwb3EdIvYtBcv+tOrs3vzA7+ToXNVD
         GryeMOgR6XJ1vyJRFfh+XaiLdMGeDy4mnXV0wZtv+DN00UL0wFZAqFIliEOLErXVwtAe
         5ZIO0T/g31cCWMz9DVpoNmzSoF6+XUJR1xGLWAOCbDMIn5be4AD4mRRK91302ePMRPvQ
         kOCGMBjc0lhaIP9bgTeYVtrAK8vpdPLGNNwxZmXqvhOBusHVmgxIfM4o9e0XdZtXck17
         v3VN41B2vgNVhO9X7W6cpyGFPOew9HEXBKbLgYNDTD1FBtS/kYQb09+xrS2BusT5UXPe
         x+8A==
X-Forwarded-Encrypted: i=1; AJvYcCV1ekHukkYfkNaCZshmVGLTZpTg4G28LKWFsboPPgaOtepruDOvaiGArYt8rJJCldxgUhkCGq/ZZHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqOabEYV6dzaMdTLKaK3TlXQ/rohcYgNIhxOn+K5jFi9quufQb
	sSlRy7exdts5IY4OaKNoCRV3ZGz4PymCzLxl/nq+WhIvAaOjMhLaym3wuhLd1TEXWPq7HLJnDQC
	xznc2cHXSM9/CbxjBMG6Kj5//JdbsfY6hD7hwx1O1zQ==
X-Gm-Gg: ASbGncsK6Ybj7ETGGFphgKpI3THNoAh29G99WUpv9NIIEooHXBL63wyjhwmBs7OsVqc
	cyL+4uj4e/54im7JJkCWEUUV1ptL/eB2se7L4awnNGj5BBjLEuz3hYY2ZpYu5yx3m0kyAKI13Ro
	e73V0Rmrh6HgW8180vnoFEIp4oGEZIjkPc4Q==
X-Google-Smtp-Source: AGHT+IFfycBwEI3FxueTISbpHh6OJPQeP2Lrq+8rdRXtzuwP9IhvuccKAVwiT0W7cxN5YrLOeQ38HlPh8PvZt5WQSe4=
X-Received: by 2002:a05:6902:1003:b0:e7d:9bfb:a320 with SMTP id
 3f1490d57ef6-e7f81f064a1mr3911070276.36.1748596698927; Fri, 30 May 2025
 02:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
 <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com> <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
 <111d2d6c-8ac0-40b9-94c3-02f2f64ef9fe@tuxon.dev> <CAPDyKFoQYTNBhtBXY-Ds7E0TohtA6558W1Jf3cLsnXDQC74DSg@mail.gmail.com>
 <rmc7me6rvumr6pcekgp5lsrxtuge5houitn474lkljew2hzdcw@z7wh2vtntvs5>
In-Reply-To: <rmc7me6rvumr6pcekgp5lsrxtuge5houitn474lkljew2hzdcw@z7wh2vtntvs5>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 May 2025 11:17:42 +0200
X-Gm-Features: AX0GCFvzfTrcuWANsmOBcb2p2VazFw-uQgVJQLGJOuhNKKaI5gJPiizsYJAEId8
Message-ID: <CAPDyKFpsk-o0KvaJK+dgNDvW30piHKgvtyOxF7URaUEvrPZmZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, len.brown@intel.com, pavel@kernel.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, bhelgaas@google.com, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 18:09, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Wed, May 28, 2025 at 06:04:45PM +0200, Ulf Hansson wrote:
> > [...]
> >
> > > >> +/**
> > > >> + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attach()
> > > >> + * @dev: Device to attach.
> > > >> + * @attach_power_on: Use to indicate whether we should power on the device
> > > >> + *                   when attaching (true indicates the device is powered on
> > > >> + *                   when attaching).
> > > >> + * @detach_power_off: Used to indicate whether we should power off the device
> > > >> + *                    when detaching (true indicates the device is powered off
> > > >> + *                    when detaching).
> > > >> + *
> > > >> + * NOTE: this will also handle calling dev_pm_domain_detach() for
> > > >> + * you during remove phase.
> > > >> + *
> > > >> + * Returns 0 on successfully attached PM domain, or a negative error code in
> > > >> + * case of a failure.
> > > >> + */
> > > >> +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
> > > >> +                      bool detach_power_off)
> > > >
> > > > Do we have examples where we power on a device and leave it powered on
> > > > (or do not power on device on attach but power off it on detach)? I
> > >
> > > I haven't found one yet.
> > >
> > > > believe devm release should strictly mirror the acquisition, so separate
> > > > flag is not needed.
> > >
> > > I was in the middle whether I should do it with 2 flags or only to revert
> > > the acquisition.
> > >
> > > >
> > > >
> > > >> +{
> > > >> +    int ret;
> > > >> +
> > > >> +    ret = dev_pm_domain_attach(dev, attach_power_on);
> > > >> +    if (ret)
> > > >> +            return ret;
> > > >> +
> > > >> +    if (detach_power_off)
> > > >> +            return devm_add_action_or_reset(dev, devm_pm_domain_detach_off,
> > > >> +                                            dev);
> > > >> +
> > > >> +    return devm_add_action_or_reset(dev, devm_pm_domain_detach_on, dev);
> > > >
> > > > Instead of 2 separate cleanup methods maybe define dedicated devres:
> > > >
> > > > struct dev_pm_domain_devres {
> > > >       struct device *dev;
> > > >       bool power_off;
> > > > }
> > > >
> > > > ?
> > >
> > > That was the other option I've thought about but I found the one with 2
> > > cleanup methods to be simpler. What would you prefer here?
> > >
> > > Ulf: could you please let me know what would you prefer here?
> >
> > As it looks like we agreed to use one cleanup method, the struct
> > dev_pm_domain_devres seems superfluous to me.
>
> I think we agreed that cleanup should mirror the acquisition, that is
> true. But since attaching to the domain has an option to either turn the
> device on or not we still need 2 cleanup branches. They can either be
> implemented with 2 cleanup callbacks or with 1 callback and dedicated
> devres structure.

Yes, you are right. Better with one callback and using struct
dev_pm_domain_devres to manage the power_off parameter.

Kind regards
Uffe

