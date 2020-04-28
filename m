Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B535B1BB55A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 06:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgD1Eam (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 00:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1Eam (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 00:30:42 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DADC03C1A9
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 21:30:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q10so18999131ile.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2020 21:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEimIaSBcB0mfT9rADdplO2cqQvrJB1SRZif/RN9wQI=;
        b=gJrE16ueIFnmDXtB5vueAPdnYAix/B7FIxvRjNQeZIgf4c9i7//ZOJ5Svi4CiRrtFa
         kN1nD65tSTpff+qMrFawVg4po2jCjX0201wnYlU2lWXf0E8QBbxO1lq0P+U/q5ySXPVo
         put4nPt1eWg0cl2in8VM2/Pw4Hh+U9tGtSuOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEimIaSBcB0mfT9rADdplO2cqQvrJB1SRZif/RN9wQI=;
        b=Wu04zyQMYEdTq5hFQF+JGvIidgFD/6kNNy9GWfVEmtj8owAFgSOf/QI/brg05lkzBl
         UDN83sc6+1Y2mIMCiNqLipRlaYtLMvfAmFsPw5fp8cqlrpfxAwPvpNWnAWkQpvI9X2np
         NDPotrjnXOTMPMtfoHMHGD+FPK1+Q74mTgiSOaRTaRXxLQ/3DA3HX90HmXT8ZGkyYnYF
         SdhHrstQY4pZW/MfbB1iRyDqJqq36omgQvzN0Y+jzBE09LlGrbR6/Jva/AgmJyYRvtRi
         U+DGzvCGXol9W08I/Y8Azzz7gwotdRDr4p2EmV5T3feLTpiVErmQ+PAG8GYw7DO2Bt/Q
         2dug==
X-Gm-Message-State: AGi0PuYqjKFtpHDCMvremUy5VJJnT/n1irvwZJDsYnzbdafR4odnMMEb
        wqFtE6YpmssT7d7F5mk1whu/DzMhRh86F1GmBCwM1A==
X-Google-Smtp-Source: APiQypKhDhCwllrO5soAYIdmquX5OHseXL994b4H/CiVQ4PB9cn4MtWgAeNgpW8k2S9HbHOz7pCJJ7epWi9TuJhIM8Q=
X-Received: by 2002:a92:d286:: with SMTP id p6mr23475580ilp.98.1588048241333;
 Mon, 27 Apr 2020 21:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200210001058.7515-1-matt.ranostay@konsulko.com> <20200413181031.68e101da@archlinux>
In-Reply-To: <20200413181031.68e101da@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 27 Apr 2020 21:30:30 -0700
Message-ID: <CAJCx=gnEySbyLQA9u=nVJ3-Wk+++Ch6L9C-bYP_EFSz-7TKkhg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iio: chemical: atlas-sensor: add DO support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 13, 2020 at 10:10 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
>
>
> Hi Matt,
>
> Found this still in my queue and to be honest I'm lost and
> can't easily figure out what the status is (I'm too lazy to
> read all the past threads).
>
> So what do you think the status of this patch set is?

The code is merged but just noticed the documentation patch somehow got dropped.

Thanks,

Matt

>
> Thanks,
>
> Jonathan
>
> On Sun,  9 Feb 2020 16:10:55 -0800
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > Changes from v1:
> > * combined dt binding docs
> > * added making interrupt line is optional patchset
> > * broke out dt changes from DO-SM module patchset
> >
> > Changes from v2:
> > * switch docs to YAML format
> >
> > Changes from v3:
> > * fix up issues reported with dt-schema
> >
> > Changes from v4:
> > * fix logic issue in optional interrupt patchset
> >
> > Changes from v5:
> > * Update license on yaml conversion to GPLv2.0+ and BSD clause
> >
> > Matt Ranostay (3):
> >   iio: chemical: atlas-sensor: allow probe without interrupt line
> >   iio: chemical: atlas-sensor: add DO-SM module support
> >   dt-bindings: iio: chemical: consolidate atlas-sensor docs
> >
> >  .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 -----
> >  .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 -----
> >  .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 -----
> >  .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++
> >  drivers/iio/chemical/atlas-sensor.c           | 91 +++++++++++++++----
> >  5 files changed, 125 insertions(+), 82 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ec-sm.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,orp-sm.txt
> >  delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,ph-sm.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,sensor.yaml
> >
>
