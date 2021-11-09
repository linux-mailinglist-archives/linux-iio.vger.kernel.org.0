Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FC244A810
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 09:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhKIIDH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 03:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243911AbhKIIDH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 03:03:07 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEBEC061767;
        Tue,  9 Nov 2021 00:00:21 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id v3so36760122uam.10;
        Tue, 09 Nov 2021 00:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jJRf2QoVELE16P7cEB6PznntzKV1Qjbgm15LTcUsRVc=;
        b=gePWEHOSGecvEl7HJk8CquvjcxB88pnyrkGCaFJpCUh4S1dghmG7/dMru5orqE7XT2
         nt/qRrfPaUPnmctmGZ/Dr1h47Z31ODwM+xwpl7cP4NYlcNiW8zpum+XarWZGbRno+Cqh
         SteCW+khATmPvJsHO43ZUUOKW7X9UxgPRhxPiE+pduHEsilaICggfbpETpT3wRNwJPUu
         UkYaboRaaj1UFiCNng++tcT5e2XmO5/aw2xrpnJG9/64B+005FELBQhMsd/GZFkwrpjm
         XlEJA9UX3xorXGAjTFncWl4WQW2xd7HgCi3MBDqJTl1YS+qwxz42xC1VIyCEubXM54rI
         IVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jJRf2QoVELE16P7cEB6PznntzKV1Qjbgm15LTcUsRVc=;
        b=3UfAsmz4AwiZ9Ae65Hcm9BY6j33PcydpVUyeX4nSuWQ8/pr+SukXE/i3KCGAjjVK0f
         FV+yCXA/uRBLclSKuvTTGsXvtGnU4AGrYbMcJFFc416GwE7F4hOfeR8mnh9oDg5BArIO
         Kvxf7MP2ulKl1/hTHsc+9AlqAF5xZlvUKkJqf31bvPLR1y55sWi1mv8V/RPnta5qxo+5
         7PYBuyy7UaA4sdRtiBLmBxmYwigADE3DDLRlxs2d01Mq/Ky232wVkAHgXL+5xeLUNbys
         +d35HcLLWBFB5xi1bd/I+ORsw5wZMB+wkek/E5W7CQEda3CAvDGds3+viPIqs4i9HSlx
         5mSg==
X-Gm-Message-State: AOAM532pA7MEr2d0SlAh4mj7Rx8IPo6A4TjR7vodZf34SEew5yyUD32g
        bTA2uzpG+qxthH02KesYmC39WONCAv0s/mdYQOg=
X-Google-Smtp-Source: ABdhPJycfRS0jKa6T58TKm+pjxAElkNmAt4iCLFdenRg55Hmth20wKyVn6TBCPo2asd0ozf+/bas1/ZpTV2PDSGl7ak=
X-Received: by 2002:a67:cc19:: with SMTP id q25mr8568763vsl.47.1636444820743;
 Tue, 09 Nov 2021 00:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-3-andrea.merello@gmail.com>
 <20211028114008.0c2abf06@jic23-huawei>
In-Reply-To: <20211028114008.0c2abf06@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 9 Nov 2021 09:00:09 +0100
Message-ID: <CAN8YU5O=rUMQNvu5TmRphYb9gqzNAS=Aai9TYf4bywi3QNXV6w@mail.gmail.com>
Subject: Re: [v2 02/10] iio: document linear acceleration modifiers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 28 ott 2021 alle ore 12:35 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 28 Oct 2021 12:18:32 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > This patch introduces ABI documentation for new iio modifiers used for
> > reporting "linear acceleration" measures.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 6ad47a67521c..5147a00bf24a 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1957,3 +1957,11 @@ Description:
> >               Specify the percent for light sensor relative to the channel
> >               absolute value that a data field should change before an event
> >               is generated. Units are a percentage of the prior reading.
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
> > +KernelVersion:       5.15
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Raw (unscaled) linear acceleration readings.
>
> Probably need more information that this.   What element is being 'removed' from
> a normal acceleration measurement? What are units after application of offset and
> scale?  Can cross refer to the in_accel_x_raw for that info if you like.

OK.  So, may I just state something like "As per in_accel_X_raw
attributes, but minus the gravity acceleration"  ?

> Also, but them immediately after the block with the in_accel_x_raw etc

OK

> The organization fo that file needs a rethink but let us try to avoid making
> it worse in the meeantime!
>
> Jonathan
>
>
