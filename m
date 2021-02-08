Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCEB312B0A
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 08:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBHHVf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 02:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBHHVa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 02:21:30 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE6FC06174A
        for <linux-iio@vger.kernel.org>; Sun,  7 Feb 2021 23:20:50 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e1so11883035ilu.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Feb 2021 23:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1ROr4YStOkhsfI/G7+Spjg1QkxQlVZvU+1QIt+DmQs=;
        b=tSbft4xaBHSB2NBMtDBU5RJPlV/kcW0x/XrgUYJyIhlGgBaPGuDqeqN3Mg2pgaa/a+
         Yn8jB5/2d65c6kJntrlA+a9DOvTEIk0GeR2sLxdSdZ2FDDgOsXiRlXCKLCQYIpJq5Yj5
         KY7BeGjgqGQVIRdv7l+ugKJjT2i4B29hnlCXGMrMgWIFVEV79WY8FOTrXps+pdsrvU/o
         NTX3nska2pNwFqs/3M+SKFIDAX2jNZ3HCqSpDS6mc80UXrY0F7Nsr/mIbhaAlyRV98Dm
         mD7tSP3mg0eOI58lix/uJX7cTSZ+dyWLDAElJ7stJQDp+xN0Bq/PlAKH+FGVmENi3gZ3
         pC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1ROr4YStOkhsfI/G7+Spjg1QkxQlVZvU+1QIt+DmQs=;
        b=TTZTTOch7HDkHaGN/GMip9lEwPJ/CcCPFG/TRuFlUOFMFN6b1WsKgPGzSCWoSCugBs
         LkUYyiXBCnL0NnWrSNLobNVGp7UJSBZRHrAmIxdr5Q2AH0e0jTqbHm6WyuKlNql1vne0
         rN2GXqGu4Vg881xRqulYtRTRcYmxLCfzEC/ecr+GWq8eJkTbs8liPgJP3qpMqH2RRzSt
         eyMWY4dhpawGW/8scy0c7q903Q2KReQSpIsJ4pQTwPKIXT84Ww8+Q5apD8rOx+H0QIGN
         1qHLuC05xsut3aDVDSo2zZX1X5Jc3LG+xwemijnfUNWXVEKAKvDG8BvHxCglMhDmRri1
         ruRg==
X-Gm-Message-State: AOAM533upS+r+h7kNy+18Ez57KC7+dlnWEcPru4pNvtb28kVg+cOVv/I
        W7jBUDfX14hmVgtI1u0zwRFGJSlo9DGoierPZ6I=
X-Google-Smtp-Source: ABdhPJxD+xv+IIy66C4MMhwitCNlIjFot6ijdU5E4itnmonAHj/BlVBMKexygUhTddg+ZmbQ3+FWbt8ORJbP3Rzo6T8=
X-Received: by 2002:a92:ab10:: with SMTP id v16mr15126054ilh.100.1612768849814;
 Sun, 07 Feb 2021 23:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20210207154623.433442-1-jic23@kernel.org> <20210207161213.07d83342@archlinux>
In-Reply-To: <20210207161213.07d83342@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 8 Feb 2021 09:20:38 +0200
Message-ID: <CA+U=Dsp-ATeKRv=omMJN3J8H615YdrqcAumtVAiV0DbyyHw8Nw@mail.gmail.com>
Subject: Re: [PATCH 00/24] staging:iio:cdc:ad7150: cleanup / fixup / graduate
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 7, 2021 at 6:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  7 Feb 2021 15:45:59 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This is an 'old' driver in IIO that has been in staging a while.
> > First submitted in October 2010.
> >
> > I wanted to try and experiment and picked this driver to try it with.
> >
> > The cleanup etc here was all tested against some basic emulation
> > added to QEMU rather than real hardware.  Once I've cleaned that up
> > a tiny bit I'll push it up to https://github.com/jic23/qemu
> Now up at:
> https://github.com/jic23/qemu/tree/iio-ad7150
>
> The device emulation is rather messy.
> As arm / virt builds the DT tree alongside the instantiation of
> devices it was a very convenient place to hack an i2c bus and the ad7150
> in using the existing pl061 to provide suitable interrupt lines.
>
> Note that I don't care about VM migration or anything like that
> so the implementation is rather more minimal than would be needed
> for normal QEMU device emulation.
>
> Anyhow, gives an idea of what is needed for anyone who is curious.
>
> qom-list /machine/unattached/device[9]
> lists the various things that can be controlled including.
> ch2_capacitance (int)
> ch1_capacitance_avg (int)
> ch2_event_state (int)
> ch1_event_state (int)
> ch2_capacitance_avg (int)
> ch1_capacitance (int)
>
> Event state is a bit simplistic in that you have direct control of
> the gpio lines. I could have implemented a state machine so that the
> actual thresholds etc were used, but the adaptive mode is sufficiently
> complex that I haven't yet done so.

I'm a little unsure about patch 12/24 " staging:iio:cdc:ad7150: Rework
interrupt handling"
And there's a minor issue with the of_match patch.
But for the rest [excluding the bindings ones and ABI ones [I'm not
great with ABI and bindings]]:

Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

This would be interesting to get into the chipmake BUs, as there
wouldn't be a need to create a board-farm for testing.

>
> Jonathan
>
> > Note that for now I'm not proposing to upstream this to QEMU but
> > would be interested in hearing if people thing it is a good idea to
> > do so.
> >
> > Whilst it's obviously hard to be absolutely sure that the emulation is
> > correct, the fact that the original driver worked as expected and the
> > cleaned up version still does is certainly encouraging.
> >
> > Note however, that there were a few more significant changes in here than
> > basic cleanup.
> > 1. Interrupts / events were handled in a rather esoteric fashion.
> >    (Always on, window modes represented as magnitudes).
> >    Note that for two channel devices there are separate lines. The original
> >    driver was not supporting this at all.
> >    They now look more like a standard IIO driver and reflect experience
> >    that we've gained over the years in dealing with devices where these
> >    aren't interrupt lines as such, but rather reporters of current status.
> > 2. Timeouts were handled in a fashion that clearly wouldn't work.
> >
> > Note that this moving out of staging makes a few bits of ABI 'official'
> > and so those are added to the main IIO ABI Docs.
> >
> > Thanks in advance to anyone who has time to take a look.
> >
> > Jonathan
> >
> >
> > Jonathan Cameron (24):
> >   staging:iio:cdc:ad7150: use swapped reads for i2c rather than open
> >     coding.
> >   staging:iio:cdc:ad7150: Remove magnitude adaptive events
> >   staging:iio:cdc:ad7150: Refactor event parameter update
> >   staging:iio:cdc:ad7150: Timeout register covers both directions so
> >     both need updating
> >   staging:iio:cdc:ad7150: Drop platform data support
> >   staging:iio:cdc:ad7150: Handle variation in chan_spec across device
> >     and irq present or not
> >   staging:iio:cdc:ad7150: Simplify event handling by only using rising
> >     direction.
> >   staging:iio:cdc:ad7150: Drop noisy print in probe
> >   staging:iio:cdc:ad7150: Add sampling_frequency support
> >   iio:event: Add timeout event info type
> >   staging:iio:cdc:ad7150: Change timeout units to seconds and use core
> >     support
> >   staging:iio:cdc:ad7150: Rework interrupt handling.
> >   staging:iio:cdc:ad7150: More consistent register and field naming
> >   staging:iio:cdc:ad7150: Reorganize headers.
> >   staging:iio:cdc:ad7150: Tidy up local variable positioning.
> >   staging:iio:cdc:ad7150: Drop unnecessary block comments.
> >   staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
> >   staging:iio:cdc:ad7150: Add scale and offset to
> >     info_mask_shared_by_type
> >   staging:iio:cdc:ad7150: Really basic regulator support.
> >   staging:iio:cdc:ad7150: Add of_match_table
> >   dt-bindings:iio:cdc:adi,ad7150 binding doc
> >   iio:Documentation:ABI Add missing elements as used by the adi,ad7150
> >   staging:iio:cdc:ad7150: Add copyright notice given substantial
> >     changes.
> >   iio:cdc:ad7150: Move driver out of staging.
> >
> >  Documentation/ABI/testing/sysfs-bus-iio       |  33 +
> >  .../bindings/iio/cdc/adi,ad7150.yaml          |  69 ++
> >  drivers/iio/Kconfig                           |   1 +
> >  drivers/iio/Makefile                          |   1 +
> >  drivers/iio/cdc/Kconfig                       |  17 +
> >  drivers/iio/cdc/Makefile                      |   6 +
> >  drivers/iio/cdc/ad7150.c                      | 678 ++++++++++++++++++
> >  drivers/iio/industrialio-event.c              |   1 +
> >  drivers/staging/iio/cdc/Kconfig               |  10 -
> >  drivers/staging/iio/cdc/Makefile              |   3 +-
> >  drivers/staging/iio/cdc/ad7150.c              | 655 -----------------
> >  include/linux/iio/types.h                     |   1 +
> >  12 files changed, 808 insertions(+), 667 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7150.yaml
> >  create mode 100644 drivers/iio/cdc/Kconfig
> >  create mode 100644 drivers/iio/cdc/Makefile
> >  create mode 100644 drivers/iio/cdc/ad7150.c
> >  delete mode 100644 drivers/staging/iio/cdc/ad7150.c
> >
>
