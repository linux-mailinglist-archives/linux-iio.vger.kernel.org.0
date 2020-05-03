Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3EE1C304A
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 01:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgECXvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 19:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgECXvB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 19:51:01 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C353C061A0E
        for <linux-iio@vger.kernel.org>; Sun,  3 May 2020 16:50:59 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so6296333iog.13
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2020 16:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6K4s6GpNB5HBwiMfi4MD8Tdj3oyJBPurGCn0q+DybI=;
        b=AP7P/gLNl7s6FU6937O2v2//Zu8BE9+T3BfqOAeZTFSvhYah8FGZ9raDAjpCaHvMoq
         3olR4RjA88Pal8DWMPFMj+v7OCnmidKpql4Ok6PCqF0datYAVYoR0LdcEZ13qBgDeP2Y
         TChdiBfCjtO396n/Sc0IHWIy5F7lNq60Yd76M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6K4s6GpNB5HBwiMfi4MD8Tdj3oyJBPurGCn0q+DybI=;
        b=EhNS4bxHaBfu0KIXkwFeg+96y2AR25x0SkgKG/S026UtfIbLPuI79n89RRtsXMw4xY
         GWVrwH/tqnFxfNjLHbtak3TUOewSS8zvdPKDJY/mnQn+t6gSCWiJLeW8SnZHjAfY/WZ9
         Z2OSX5x+mUuyDXTvbfxsiKEIOMIy3Jv/ZOdHtAvNAKA2Pu9WtStEpyfFNTDx91AJVvV5
         ylnEblZpM9JkcAdsPGjtPlykJtQ476IVY3uWudKGKVTdeuYSLTDU1UHhZOLyoLO9GWu6
         jz6LPPVsGeWGU5lkEGE2M3I/MRgJLxCeNsdyhzfiknBOQiKjCaRHYpDkVL2mWcT5dwFS
         u6gw==
X-Gm-Message-State: AGi0PuYRNYeWRyRxFe0lbpuDsj6hSPGYrj9dvmtq+AfzBKljq/e0QpOJ
        LdV4NjrNgFXliaykBdzyJ4lbltzBzEigIz66+jzeefmKsSY=
X-Google-Smtp-Source: APiQypI9JqcvVJafNkVWdgtKg+pQYWh025Ke6piHU+rR338Runm94c9ZO3aAX/022kHKJbS5r9B83gl00zcppy3IGWY=
X-Received: by 2002:a5d:8715:: with SMTP id u21mr8047424iom.46.1588549858737;
 Sun, 03 May 2020 16:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200210001058.7515-1-matt.ranostay@konsulko.com>
 <20200413181031.68e101da@archlinux> <CAJCx=gnEySbyLQA9u=nVJ3-Wk+++Ch6L9C-bYP_EFSz-7TKkhg@mail.gmail.com>
 <20200502172336.1456e167@archlinux>
In-Reply-To: <20200502172336.1456e167@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 3 May 2020 16:50:47 -0700
Message-ID: <CAJCx=gmSkVhDQY15Hg=5oJZHu1NY9vuTbQP9h4LF4KSZ6-DpdQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iio: chemical: atlas-sensor: add DO support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 2, 2020 at 9:23 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 27 Apr 2020 21:30:30 -0700
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > On Mon, Apr 13, 2020 at 10:10 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > >
> > >
> > > Hi Matt,
> > >
> > > Found this still in my queue and to be honest I'm lost and
> > > can't easily figure out what the status is (I'm too lazy to
> > > read all the past threads).
> > >
> > > So what do you think the status of this patch set is?
> >
> > The code is merged but just noticed the documentation patch somehow got dropped.
> Ah oops. I picked up v7 but missed dropping v6 from my queue.
>
> For docs, it seems to be there..?

Ah yes it is.. forgot I put it part of "dt-bindings: iio: chemical:
consolidate atlas-sensor docs"

Thanks,

Matt

>
> J
> >
> > Thanks,
> >
> > Matt
> >
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > On Sun,  9 Feb 2020 16:10:55 -0800
> > > Matt Ranostay <matt.ranostay@konsulko.com> wrote:
> > >
> > > > Changes from v1:
> > > > * combined dt binding docs
> > > > * added making interrupt line is optional patchset
> > > > * broke out dt changes from DO-SM module patchset
> > > >
> > > > Changes from v2:
> > > > * switch docs to YAML format
> > > >
> > > > Changes from v3:
> > > > * fix up issues reported with dt-schema
> > > >
> > > > Changes from v4:
> > > > * fix logic issue in optional interrupt patchset
> > > >
> > > > Changes from v5:
> > > > * Update license on yaml conversion to GPLv2.0+ and BSD clause
> > > >
> > > > Matt Ranostay (3):
> > > >   iio: chemical: atlas-sensor: allow probe without interrupt line
> > > >   iio: chemical: atlas-sensor: add DO-SM module support
> > > >   dt-bindings: iio: chemical: consolidate atlas-sensor docs
> > > >
> > > >  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 -----
> > > >  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 -----
> > > >  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 -----
> > > >  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++
> > > >  drivers/iio/chemical/atlas-sensor.c           | 91 +++++++++++++++----
> > > >  5 files changed, 125 insertions(+), 82 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
> > > >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
> > > >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> > > >
> > >
>
