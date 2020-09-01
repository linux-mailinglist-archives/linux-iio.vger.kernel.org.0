Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175852585F6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 05:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgIADA7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIADA5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2020 23:00:57 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB61C061366
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q6so2609996ild.12
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2020 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pNPzGPBKOW3RQSkVjruvTmr+2vrE77wDaX8RiNNc2/k=;
        b=SXIGBB9e9uLWMNUexx7eVcPbe3GFYsjpP5LS2nNru5UDUo6cKvDeCPLblno+5VCRl8
         n63Ewc0BzmmUvK272iEX+Lu/FJtYK/hGF5I7Ebn9W9gHqKitSp0LCCYRSx3m5pmsWdki
         8ZFuRszVk47cxpYoq14OgcJgQxCzCm0xf577c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNPzGPBKOW3RQSkVjruvTmr+2vrE77wDaX8RiNNc2/k=;
        b=cKCPuyp12Nwck3/t7+xEcMOyIHc0AWaAVyS+v7woX6ORbhdrpbQ3m5eOy1vEtzai7J
         m2rLfGO4nCrHFaMIWG+5mukMhObViiskKasw9OmDP3LcqeZ5OLMay4WFEgXVRssixrg1
         f3ovQu9PzHtEtzck4ddM6RKvuARXu8JuuOrEftKff0HvA/npbnxt3PT9bMhIttWZ5JLU
         v/rvFV1rIDeGNb93+r4Z00/AMjyYdPIGbDKIcU2I+/yp6zE4rdcPiTatyOeoQpV9AT10
         5cMusYb0VrcUv4/FhrAcDwCq090L02SacuLqtMCVUFf0Er+vVBMOARIIDYd8soXgFSux
         T10A==
X-Gm-Message-State: AOAM530fTDBQzAVJOZADlnteTfFPVbmHFpogXPYB6fpk+hblMJJtbCiv
        J06MbjEXS/GHAiipN0JnVrNi+5BfAsrbyuQl2KiLvg==
X-Google-Smtp-Source: ABdhPJwhGoMTwpOLjXosfBb2bDCaugBM9tosJ+hCirV5Uf2D7fXvzaeGVaoSmAfExKEq8LIzLTroateDYpwPLNgLpSY=
X-Received: by 2002:a92:c6c8:: with SMTP id v8mr3987991ilm.145.1598929256931;
 Mon, 31 Aug 2020 20:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200828233156.2264689-1-gwendal@chromium.org>
 <20200828233156.2264689-3-gwendal@chromium.org> <20200830141140.3a360928@archlinux>
In-Reply-To: <20200830141140.3a360928@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 31 Aug 2020 20:00:43 -0700
Message-ID: <CAPUE2uuhXFN2MbrxRP2ojMaqT8+kG+ODMegd2BV4zV0xGc5afA@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: abi: iio: Add event when offset changes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Yuval Peress <peress@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 30, 2020 at 6:11 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 28 Aug 2020 16:31:56 -0700
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Some sensors/sensorhubs can calculate drift or hard iron offsets to
> > apply to raw data to get the true measure data.
> > These offsets are applied by the user space application.
> > When these offsets change, events are raised to tell the application
> > to update the cached offset values.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Hi Gwendal
>
> This strikes me as rather prone to races.  I guess if the updates
> tend to be fairly minor we will just have slightly less accurate data
> until the update gets picked up by userspace.
In case of hard iron for instance, the sensorhub needs several samples
to find out the current offset are now invalid. So it is likely the
measurement of the geomagnetic field was incorrect for a while.
For accelerometer online calibration, we don't expect vast changes
when new offsets are available.
>
> We have had some discussions about how to handle meta data updates
> in the past.  One option was to provide a metadata index channel
> that could be used to indicate there was an update to something
> sat in a separate fifo.
An extra sounds like a waste of space, as it will mostly be 0 most of
the time, and edge to 1 once in a while. An event looks more
appropriate.
>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 33 +++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 47df16c87862d..40da602e7a555 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1716,3 +1716,36 @@ Description:
> >               Mass concentration reading of particulate matter in ug / m3.
> >               pmX consists of particles with aerodynamic diameter less or
> >               equal to X micrometers.
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_offset
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_offset
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_offset
> > +KernelVersion:       x.y
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Gyroscope drift calculated by the sensor. In addition to factory
> > +             calibration, sensor or sensorhub can
> > +             detect gyroscope drift and report it to userspace.
>
> This looks like standard ABI that should probably already be documented,
> unrelated to the controversial part of this patch. I would split it out into
> it's own patch a I can pick that up much faster.
Done in v2.
>
>
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_magn_x_offset
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_magn_y_offset
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_magn_z_offset
> > +KernelVersion:       x.y
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Hard Iron bias calculated by the sensor or sensorhub. To be applied by
> > +             user space application to the raw data to obtain the geomagnetic field.
>
> Same as above.
Done in v2.
>
> > +
> > +What:                /sys/.../iio:deviceX/events/in_accel_offset_change_en
> > +What:                /sys/.../iio:deviceX/events/in_magn_offset_change_en
> > +What:                /sys/.../iio:deviceX/events/in_magn_scale_change_en
> > +What:                /sys/.../iio:deviceX/events/in_anglvel_offset_change_en
> > +KernelVersion:       x.y
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             Some sensors internally calculate offset to apply to remove bias (for
> > +             instance, hard/soft-iron bias for magnetometer, online calibration bias for
> > +             gyroscope or accelerometer).
> > +             When the sensor computes a new set of offset values, it generates an
> > +             event for the userspace application to refresh the offsets to apply to raw
> > +             data.
>
> I'm not totally sold on this idea, though would like inputs from other people before
> ruling it out.
>
> One minor change I'd make would be to have a single event to indicate that something
> userspace might care about in the way of metadata for this channel has changed.
> I guess something like
Make sense, scale and offset should be checked together if they both exists.
Using vents/in_<type>_metadata_en in v2.
>
> in_accel_metachange_en etc with a single new event code.  For events, it's the event
> code mapping that normally matters more than sysfs binding as that is much more
> tightly restricted.
>
> Jonathan
>
