Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED42147E6
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 20:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgGDSWc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 14:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgGDSWb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jul 2020 14:22:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741BCC061794
        for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2020 11:22:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ch3so130022pjb.5
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2020 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUpbZeWmdonOJK5SiBIDC12fXxJk3LGYHtfEjmwd5oU=;
        b=dzTsFosRm13MI+SmkkWB1BLDUQHPVwuV+xphNkWJgtbS2AeY3SVgjSw9gAwehM5ubK
         hBZzrXDzgPx77ZUVvA25K4x8ve6Hhp1MEHsnJ6bv7VXCiRwWZPV393PLg+tdVIISaG+M
         +wkTPuleSMFxEB4a8KBUE9YsJJ/b7j+TT/+yNEhzSqmlRUOzLeOi+DM2bBJs0KwGfSyN
         GZZJWrcz3xMaIYn5espXx/BHEVO0ezQd/0se9WDM0I6/q/OXITqoSFk4wVJxAr3XKakW
         pb7TPH5S7NNLCiY/xILn4HCxuKFckJg9MtX1ll7x+97y166RwmRnC7q27jUAgQ+DeGxA
         otrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUpbZeWmdonOJK5SiBIDC12fXxJk3LGYHtfEjmwd5oU=;
        b=gIosc51eOZiK0EEXF299I7BIUHIggPkwKlTLoJSQg576mU0KS0YPi5ABqgqlqdEaQ6
         DXT5AsqTXElxBXZKBPGrdKta/AnSNDxziVKX9W37v4xBwRLHfAOtG7/Oa0zytPYm/xTP
         nlkMnlA1RmDf0C4A27jhZWu9FC2aiiFQg0f9WguRXpoWCxMKlzXneLAzh9TmaWH3TssG
         NvdvP7bg9LQGHtf2jdrkiH9urTfKEHoj/WbvHTIuxtb+xvlZJvQ67RoemcihVDPGwygu
         a5K8DHwuf+pHyaFoUPwq7nMGpG9UySAJCAA1zSRhm3JUaW6rBq5I+118/CdYY4EqCj6b
         WIGQ==
X-Gm-Message-State: AOAM531TN695Eoa0J7kIfQGz9AwiPLz/8hpzWrqzXIU/7zp7MOzB4HwC
        8X8iW9BG9yr+7Px76oDqZf4dsPVamE7KGXHGVWk=
X-Google-Smtp-Source: ABdhPJxPMvQTtvnleWJyWHa/6+w3IdLWy0X5SfPTbVy8XE8giURVTvyA4Dw9w8G0Ey5Hff+LSjqEce7O2FQj1+wE3g0=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr18145323pjb.181.1593886950899;
 Sat, 04 Jul 2020 11:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200628123654.32830-1-jic23@kernel.org> <20200628123654.32830-23-jic23@kernel.org>
 <CAHp75Vf7vfEo9vrL3GseZNfSZWugQtKrks+eCvR+z0NKMgMzAA@mail.gmail.com> <20200704165943.4a6c0f5f@archlinux>
In-Reply-To: <20200704165943.4a6c0f5f@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 4 Jul 2020 21:22:14 +0300
Message-ID: <CAHp75Vfhz3Rcj1O3yiBVLBrnSFpQSw1U0Cu89tdqC3SgDo0Aqg@mail.gmail.com>
Subject: Re: [PATCH 22/23] iio:adc:bcm_iproc: Drop of_match_ptr protection and
 switch to mod_devicetable.h
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 4, 2020 at 6:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 30 Jun 2020 10:25:24 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sun, Jun 28, 2020 at 3:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Whilst it's unlikely that this driver will ever be instantiated from
> > > ACPI PRP0001 there is little advantage in using the of_match_ptr
> > > protection.  The switch of header is because we only use of_match_id
> > > in here and that is defined in mod_devicetable.h not of.h.
> > >
> > > Note the main reason for this patch is to avoid providing instances
> > > of of_match_ptr being used in IIO that might get copied into new drivers.
> > >
> >
> > Commit message is misleading. The change won't help with ACPI due to
> > syscon_regmap_lookup_by_phandle() call.
>
> I'd missed that.  I'll drop this one.

Actually in this case, if it's not done yet, I prefer to see in
Kconfig something like

depends on OF || COMPILE_TEST

to explicitly show that "yes, you may compile it, but it requires OF
to function with usefulness".

-- 
With Best Regards,
Andy Shevchenko
