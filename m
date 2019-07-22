Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E6709B5
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 21:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfGVT2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 15:28:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37467 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfGVT2A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 15:28:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so41439190otp.4;
        Mon, 22 Jul 2019 12:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uj1vF7RfJZlwyLj5jo8OvTSlBivPfV0p9Isy1dRx0cw=;
        b=KwvUZmA/TFlsf8phNB1484k3noJJmOLRi7PMyWcFL7iLRMAw8JLGcicEhsiyWEeG85
         UWKv5qSpR7cQZnotUdM1xDJzdqRipuzwYLEoZTPVESXEs/+KkcVmK4EOoO3oEWjD8rME
         54H4HkxA02p5hNl1B/ZqOOITWqKPprYmPO/mt9VmA5rCtkOBjiiHiybObG3hllGwcCHJ
         OUQL0rBNSt4IZh2VV1jLAUwMM3QsncDJktSA6kkP4qPx1TJNCTQVpF6fQDqOmJ2EWIMs
         R9KUEUuae/vD5FRJ4g2/WoBC3064GdDTdNNDqCB7WQcIMTq9egSI/6ZAJmhs3ApIrMuw
         qhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uj1vF7RfJZlwyLj5jo8OvTSlBivPfV0p9Isy1dRx0cw=;
        b=VgE91Vt8aQO20343T+Yi6zJ2z9OXAuKVEnZ1pD9TFoR1jVDMfkLoCoXbOVI2QtQUHl
         ePjhIoHAz5R0EMnbpSdV7RLndRx5a4+SX3nyk6z18MEW/Y+joPPCZUYiUedjpzzuJV9C
         6zL3Xm8cCkN1CTmCPXt4VOXqMImnp0ERo7eR0Vd4TEYhRc7IT3+mwHk5MZ9miW1pGq94
         rrDAXrfIxpAnUGVNR/YIutnLqXU96ZxPx++8k9mHp9xRUvg746Z9NGNmD3ecL8/oDfue
         7EbzHDwQ/8fF/BMSs3/v/1DimVmvY5pQ/IGCekhIxB5tT4dODqMCDIQfqiABOlBkKuvi
         f7hg==
X-Gm-Message-State: APjAAAVCt8GFM+HUufAnTb4egDQN11IzWGhZVR7N5LHj84bNFUbeT5Qr
        qHL9ao7YbyqcGconu/IyJNqqxMxFz2njKhDSPQU=
X-Google-Smtp-Source: APXvYqx0aUZdbJBV0PvmJlamscXhqR0+FSAVSRL+feAm2R6HHFb8oR+l2aPxYMzo5wnr+7alnBi0yDE/CrWJjhAszYw=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr27149286oto.207.1563823679323;
 Mon, 22 Jul 2019 12:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
 <20190722124747.4792-2-alexandru.ardelean@analog.com> <20190722163202.GG4756@sirena.org.uk>
In-Reply-To: <20190722163202.GG4756@sirena.org.uk>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 22 Jul 2019 22:27:47 +0300
Message-ID: <CA+U=DspSkWzwVp38No9tGYb0_zc2yVP5jFcLsOd2aLi2WxaW-w@mail.gmail.com>
Subject: Re: [PATCH 1/4][V3] spi: Add optional stall delay between cs_change transfers
To:     Mark Brown <broonie@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 22, 2019 at 8:42 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 03:47:44PM +0300, Alexandru Ardelean wrote:
> > Some devices like the ADIS16460 IMU require a longer period between
> > transfers, i.e. between when the CS is de-asserted and re-asserted. The
> > default value of 10us is not enough. This change makes the delay
> > configurable for when the next CS change goes active, allowing the default
> > to remain 10us is case it is unspecified.
>
> For the third time:
>
> | This looks like cs_change_delay.
>
> >  #define      SPI_NBITS_QUAD          0x04 /* 4bits transfer */
> >       u8              bits_per_word;
> >       u8              word_delay_usecs;
> > +     u8              cs_change_delay;
> >       u16             delay_usecs;
> >       u32             speed_hz;
> >       u16             word_delay;
>
> This patch doesn't apply and even if it did it won't compile because you
> are trying to add a field with the same name as an existing one.

oooohhhhhhhh
now i see;

well, my fault here;
i was basing my patchset on top of branch iio/togreg from Jonathan's
tree for the IMU:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=togreg
[ typically that's the base branch for new IIO drivers ]

that one is a bit behind, and does not contain the cs_change_delay
stuff you mentioned;
also, i will admit that sometimes, some review comments are not
completely obvious to me;
i should have checked the SPI tree before opening my mouth, but this
will [hopefully] serve me as a learning experience when sending
multi-subsystem patches
when sending to a single subsystem, it's clear; when sending to 2, i
get a bit lost

i do feel a bit bad for the noise i caused, but it's not the worst
thing i did today

anyway: disregard this, and i will sync with Jonathan about how to
proceed with this patch just for IIO;

thanks for your time and sorry for the noise
Alex
