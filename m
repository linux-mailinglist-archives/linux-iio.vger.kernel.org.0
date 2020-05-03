Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF71C2B91
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 13:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgECLHF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 07:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgECLHE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 07:07:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED43C061A0C;
        Sun,  3 May 2020 04:07:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 188so5104844wmc.2;
        Sun, 03 May 2020 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=y/4hWziwDnaxg9hhzGgE5S9GBZDVzlmvn0sV1JGAgC0=;
        b=Yc6lZmun484/Vh18s4UEd3mb+9ybI0vTPF/1PYX0nM3favhynC9Ap6bHBtiNP3dmoH
         5GTfWDVuOlrAPy9eugO/LpeNbJMtxNz//a0oNshxpOWP/AxaRuSNrE3CxXbmADa9FQOB
         5G1HoB+vySxKWgFXyQgjTOCUhft/+YobVx0BvFn5eOVH4BgAmbYoJG+Oqb0tt17WM/o4
         ARVcPxqzNdsbfmr9jBcnbzvevFkiEsg28AZqMCvTftfi5aVw54AJVjsmeRC3gYuUVccY
         1lUlPAK+wZm8WixEeeyV+Hp1WgpQZxQGZootYcB56aT/eV1b2XV78w7DnExHWz2UgMS4
         6McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=y/4hWziwDnaxg9hhzGgE5S9GBZDVzlmvn0sV1JGAgC0=;
        b=ehN+dhMace9V0xIR1MrXFf8S15JJSSv9yCJ9P1gRlUrgYfbnp7BH+ZbHO6jGR6l5WX
         09N3hCaKyKSzQ5pJEpBPWD9W0b6gj/9x0g3Z5h1WscjKgVwultwch6mb54GS+gLpZr7m
         ck9hCSHPp1AX47ZbroMPjZGsqXzIdcZotIt3EROM6OdC3VwWwPXShxmlBE8tcC8pdHPc
         qkFNKdf0YednZyuYpUHn0awjMnWQullCG5wF7faliVry7/1ql3NIWfpNs8cvWl+9JTXc
         imm0Cp94hM+65bm76+heY6uWUicXYWSWYaR80hd0GsOr0kamPP0ykWi97zVy2IVgbIwt
         AfLQ==
X-Gm-Message-State: AGi0PuakZ9Hjsv1Iep0qui5hiTPI98LdIPsJtcLIvSCNPHC0Kxyf/ZHf
        b7mAlk74D9MudUjuW3jzoW8=
X-Google-Smtp-Source: APiQypIWM7gdS/ZICziZreWOFl1o5XNNZKwzCXPOOYRzWotODc6JHXHZCsafLcNYf3iVY0/etM9oKg==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr8702472wma.157.1588504022896;
        Sun, 03 May 2020 04:07:02 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2488:b501:889a:1d04:1d51:f2d0])
        by smtp.googlemail.com with ESMTPSA id o3sm13292409wru.68.2020.05.03.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 04:07:02 -0700 (PDT)
Message-ID: <231ac29f177774eeb32b0ed907516173af0f97eb.camel@gmail.com>
Subject: Re: [PATCH v5 5/6] iio: imu: Add support for adis16475
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Sun, 03 May 2020 13:07:01 +0200
In-Reply-To: <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
References: <20200413082445.17324-1-nuno.sa@analog.com>
         <20200413082445.17324-6-nuno.sa@analog.com>
         <2418ed60-8407-0c99-bf5d-1afc3964de2b@metafoo.de>
         <20200502184010.134eb8b5@archlinux>
         <67202bd8-e0a5-be53-13c6-e01a25e2a85b@metafoo.de>
         <df0f04296fafccfcf18b08b213bae20ff69c2384.camel@gmail.com>
         <20200503094751.633feda1@archlinux>
         <c7c6c4af-826a-d52a-3969-4ccccbff12e9@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2020-05-03 at 11:07 +0200, Lars-Peter Clausen wrote:
> On 5/3/20 10:47 AM, Jonathan Cameron wrote:
> > On Sat, 02 May 2020 21:52:18 +0200
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > 
> > > On Sat, 2020-05-02 at 20:01 +0200, Lars-Peter Clausen wrote:
> > > > On 5/2/20 7:40 PM, Jonathan Cameron wrote:
> > > > > On Mon, 27 Apr 2020 20:06:07 +0200
> > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > >    
> > > > > > On 4/13/20 10:24 AM, Nuno Sá wrote:
> > > > > > > [...]
> > > > > > > +static irqreturn_t adis16475_trigger_handler(int irq,
> > > > > > > void *p)
> > > > > > > +{
> > > > > > > [...]
> > > > > > > +	__be16 data[ADIS16475_MAX_SCAN_DATA], *buffer;
> > > > > > > [...]
> > > > > > > +
> > > > > > > +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf-
> > > > > > > > timestamp);
> > > > > > If the timestamp is enabled the IIO core might insert
> > > > > > padding
> > > > > > between
> > > > > > the data channels and the timestamp. If that happens this
> > > > > > will
> > > > > > disclose
> > > > > > kernel stack memory to userspace.
> > > > > > 
> > > > > > This needs either a memset(data, 0x00, sizeof(data)) or
> > > > > > maybe put
> > > > > > data
> > > > > > into the state struct and kzalloc it.
> > > > > Good spot. Could simply do __be16 data[ADI..] = {0}; rather
> > > > > than
> > > > > explicit
> > > > > memset, but some form of zeroization is needed.
> > > > > 
> > > > > I've fixed up the applied patch with the above approach.
> > > > There is actually another issue. The stack data is not
> > > > necessarily
> > > > aligned to 64 bit, which causes issues if we try to put the 64-
> > > > bit
> > > Oh, this is actually more problematic. Yes, since we have an
> > > array of
> > > u16, that is not guaranteed to be 64bit aligned. Doing a quick
> > > search
> > > of `iio_push_to_buffers_with_timestamp()` users and I could
> > > quickly
> > > find 4/5 drivers with the same problem. I guess the API should
> > > clearly
> > > state that `data` needs to be __at least__ 64 bits aligned (maybe
> > > a
> > > future patch). Or we could even check the address and guarantee
> > > that it
> > > is properly aligned before continuing (though Im guessing this
> > > will
> > > break a lot of users...)
> > > > timestamp in it. I think data should really be in the state
> > > > struct.
> > > Yes, with a proper __aligned(8) attribute... Or couldn't we just
> > > use
> > > __aligned(8) on the stack variable?
> > Forcing alignment on the stack isn't terribly reliable, which is
> > why
> > we never do that for dma safe buffers.
> > 
> > Probably better to just move it to the state structure.
> > I'll fix it up to do that. Please sanity check what will shortly
> > be in the testing branch.
> > 
> > The moment Lars mentioned this I groaned. As you've noted a few
> > other
> > drivers have the same problem + the ABI doesn't clearly state
> > or check this.
> > 
> > We should certainly fix all the drivers that suffer this problem
> > first then we can think about adding a runtime check.
> 
> It looks like it is actually quite a few drivers, maybe we should
> switch 

Yeps, not surprised...

> to put_unaligned(). We probably got lucky in most cases and the
> buffer

This would keep us from having to fix all the users (just need to fix
the memory leakage you mention on the next email) to use a properly
aligned buffer. And later on, if we want, we can always add an
`aligned` variant of `iio_push_to_buffers_with_timestamp()` were we
check for alignment...

- Nuno Sá

