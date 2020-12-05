Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CBC2CFD64
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLESce (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgLES2z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Dec 2020 13:28:55 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B2C02B8F8
        for <linux-iio@vger.kernel.org>; Sat,  5 Dec 2020 07:50:14 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id q1so8120368ilt.6
        for <linux-iio@vger.kernel.org>; Sat, 05 Dec 2020 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtNgo2D1Ic+pYCO01LJfEMZQjRueM5d4Zqn+Q1wGnUs=;
        b=gUwYiGo9itCOrMM5kgmg4c4/XUaM0wqHrVABqeqZisNtyeieHH/dPEgd8M8pUyDpsS
         4RNWFa5nTdCyJuNTsOzXJJszcDoIYspnnvDcOpcEisWySx3jD7u4UyAMQiK3a2eLEKm8
         Fuy9CUvqdhj0FmpP1Y03OghNGz+2pTDowA1tn+u5afuGYYtYKEmfasZA37VF2+V10wB4
         7B2RxZIAQEuvaHi2A73fRZylNsBrRGeozr+aLIZ6wgAdTGYTqqDLCWYLVdQYge23kPKw
         P2XARjn8MBcTFrDNqw6fTJizkPQ1AljQsOEXgkuuUuJNRpVurEN3eNR7B2i985HYdaWy
         1VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtNgo2D1Ic+pYCO01LJfEMZQjRueM5d4Zqn+Q1wGnUs=;
        b=ooalwaib2uc+7wUgZPGLbBD5T2LukRhxq7YOYJVNDFKG/ZEr0/F1E74r5XoCOlH14k
         8TvUh6nc7AjWXQS0nKOxDOrws1wIQ1giMX8pGOwum4Zx8epEIIUwgKUEV86teMZTgOur
         vmNBCEW/7Mh6FP3cJ/xKrvu+X2TBGuggJhSop/Dz0VYrKGEpEVX3jHiylPuVPnNue4bX
         Ua8YQPkPEL2Sej+PSSwLpk+DKwdyu2i1qc5VSA6PkbxyXa0UivzyRcdYVAZqDC+07e5j
         bAnwQchkS0O64WqZkRVUnlFyLcQoCe2Qi4682fioBWSJGT9VoxHrpOCDyvjdVdKst60U
         WCOw==
X-Gm-Message-State: AOAM530FAw+Dqll19vZXkdUKbJ7HUu7wiot5DTFdiiHNceTUu1h95zmX
        Ti+vkM0vJ6XQxqAxB5Uw2AkS5m3qPRWLYSKcd0A=
X-Google-Smtp-Source: ABdhPJwLIZ5s52s53l7SZ8wjlzg82tbbTt1vnpAqqdk6k5lAv3/nKrYHiCNcUACEuD62Mx9doBiBAmX+gu5e0KPrJjc=
X-Received: by 2002:a92:c844:: with SMTP id b4mr11536702ilq.292.1607183413967;
 Sat, 05 Dec 2020 07:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20201125084606.11404-1-hdegoede@redhat.com> <2a20cf21-d483-d41e-6ff8-95ae23d230c2@redhat.com>
 <20201205152344.173e5b96@archlinux> <f11fd496-948e-8bf9-04eb-44262d54a271@redhat.com>
In-Reply-To: <f11fd496-948e-8bf9-04eb-44262d54a271@redhat.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 5 Dec 2020 17:50:02 +0200
Message-ID: <CA+U=Dsqc8djb8KFV75EST4=9W5CN+mgeym+hgUX0F8x2P04Epg@mail.gmail.com>
Subject: Re: [PATCH 0/1] iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 5, 2020 at 5:44 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> n 12/5/20 4:23 PM, Jonathan Cameron wrote:
> > On Tue, 1 Dec 2020 13:28:47 +0100
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >
> >> Hi,
> >>
> >> On 11/25/20 9:46 AM, Hans de Goede wrote:
> >>> Hi All,
> >>>
> >>> I wrote this because I was planning on using is_visible in a driver's
> >>> attribute group myself (1). But in the end it looks like I'm going to
> >>> do things differently.
> >>>
> >>> This is still useful to have though, both for possible future use of
> >>> is_visible in driver's attribute groups as well as to make the current
> >>> usage of is_visible in adi-axi-adc.c actually work.
> >>
> >> Jonathan, any opinion / remarks on this one?
> >>
> >> FWIW since I no longer have plans to use is_visible in an iio-driver
> >> myself I'm fine with dropping this one, but:
> >>
> >> 1. Being able to use is_visible in the attr group of iio-drivers
> >> seems like a nice thing to have.
> >>
> >> 2. There is an existing use of is_visible in adi-axi-adc.c which currently is broken.
> >
> > I was giving time for Alex, or others to sanity check the need for a fix
> > (well more specifically wether this one was the right one as clearly
> > a need!).
> >
> > Anyhow, all sounds good.  Giving timing I'll mark it as one I'll pick up
> > to go in after rc1 + stable.
> >
> > I'm not totally sure on the fixes tag.  Current patch will have to go on top
> > of 207c2d27a010 ("iio: core: move channel list & group to private iio device object")
> > but I don't think it worked before that either as we were still copying attributes
> > around, just to a different location.
>
> I don't think it is important for this one to go to the stables series,
> so if you think it may cause problems feel free to drop the Fixes tag
> (or point it to a different commit).

I am also fine to not port this into the stable series.
The AXI ADC driver that is usually used, is from the Analog Devices Linux tree.
The current upstream version will be the one that reworks/cleans-up
the old ones in the ADI tree.
For some reason, there are like 4 AXI ADC variants in the ADI tree :p
All these 4 should be unified into this one at some point.

>
> Regards,
>
> Hans
>
