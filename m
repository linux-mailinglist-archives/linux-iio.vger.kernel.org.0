Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84D53992E8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFBSzL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 14:55:11 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:36665 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhFBSzK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 14:55:10 -0400
Received: by mail-ej1-f43.google.com with SMTP id a11so4667551ejf.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCITROV0s5RuVFdaBSxMnRiqySCChHb5W4JCWEuT3Z4=;
        b=IDeCwgD5gWq0zSriB9TldoUdWex8cViFUC47pT1kiucVTjEa4zYz1DTNSICtgG5/SS
         jArll/wY9CuhnZ3xKl+QBE8TlhfmuE35bPiroi01r9jk56lFxZt5bXXwVvoOijhIPfMQ
         CSlmP0LKetiafywH29Etk0rP6yEBmOqPq6+suqU5apOWY/L7eH+Cgf9y8FbnrkLK0pYn
         rss9cIJztjyErpZjpsMbtcnl5uyN1AJGXG9lv+e3fTbZ/eVpsGS+z3PtRFI8gQiOckxn
         V5mIEwWpSdUa3nySKV04jAe7d3of5GLD5PLWEBdGFUdYKBpuw4lSiF7OLda2ItqJsou2
         gsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCITROV0s5RuVFdaBSxMnRiqySCChHb5W4JCWEuT3Z4=;
        b=Mg91GHv/hTv2xk90oL+SKCiAQvxmKtGkJhi6xT0v+eSzaOucD+9YSjW9lEk1whQ5cX
         d2gRTKMgKwpJ9KaP3uccoeeWXmF8fuyiNIbwIxQN5Cva+kmGoQzvlgnzvZFEMsDQ/2Bz
         vbC4R7YXPjRlAZdWIYd2K+sdtLJ635IEH0YNuslPz5q/juyI4RnyeBMg/OdGOqdJaDGv
         BFFmr0y6AjzUVnMBYQpVxnppNHGG40ws+PQa5zN6kw7ofR7ow8gVruskbQlhA132nitm
         EJ2Qm8UT6Y4qcMWRnvD1PMGBxlZ8wvOT6O9F4l2XZ5285dFPa4or4XNeIMWyf9whF1zn
         63xA==
X-Gm-Message-State: AOAM533lGZtRLeHQTckvc3QllUhxxANKRNmnmid6GGC9J/b2IqF/2nfH
        Gxv92yeKprKMWlhz+dj/13GetBXNTakg5XhzTDlqIg==
X-Google-Smtp-Source: ABdhPJzs1OgN36+b+vvLp3/dlnTaTJT0RIRBzXwxuydeXtQf9+0B61uyzGw3LkF82CCOhZ5RumJ5+r64QXcz89PZYhs=
X-Received: by 2002:a17:906:68ca:: with SMTP id y10mr35919328ejr.318.1622659933090;
 Wed, 02 Jun 2021 11:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <7a1dcde4-25df-ceee-a481-4a2f4afcf5bf@linux.vnet.ibm.com> <f1add89a-853d-2ddd-b07e-6345eb54e72b@linux.vnet.ibm.com>
In-Reply-To: <f1add89a-853d-2ddd-b07e-6345eb54e72b@linux.vnet.ibm.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 2 Jun 2021 11:52:02 -0700
Message-ID: <CABXOdTcdkXzmi9qWWZapY19Z7-DsnXsz-yBWbaBqwhLrJpTDVw@mail.gmail.com>
Subject: Re: Seeking your opinion on ways to report both Altitude and Pressure
 sensors for the DPS310 as well as Temperature from dbus-sensors.
To:     Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Guenter Roeck <groeck@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        Milton Miller II <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Wed, Jun 2, 2021 at 11:18 AM Bruce Mitchell
<bruce.mitchell@linux.vnet.ibm.com> wrote:
>
> Forwarded to an expanded the To and Cc Lists.
>
> On 6/2/2021 09:21, Ed Tanous wrote:
> > On Wed, Jun 2, 2021 at 9:14 AM Bruce Mitchell
> > <bruce.mitchell@linux.vnet.ibm.com> wrote:
> >>
> >> On 6/2/2021 09:03, Ed Tanous wrote:
> >>> On Wed, Jun 2, 2021 at 8:58 AM Bruce Mitchell
> >>> <bruce.mitchell@linux.vnet.ibm.com> wrote:
> >>>>
> >>>> On 6/2/2021 08:39, Ed Tanous wrote:
> >>>>> On Tue, Jun 1, 2021 at 8:43 AM Bruce Mitchell
> >>>>> <bruce.mitchell@linux.vnet.ibm.com> wrote:
> >>>>>>
> >>>>>> Hello Ed,
> >>>>>>
> >>>>>> It has been suggest I seeking your opinion on ways to report both
> >>>>>> Altitude and Pressure sensors for the DPS310 as well as Temperature from
> >>>>>> dbus-sensors before going to far down the road.  Thus that is what I am
> >>>>>> attempting to do in the email, others on the mailing list input is
> >>>>>> desirable as well.
> >>>>>
> >>>>> Thanks for discussing this before getting too far along.  I haven't
> >>>>> worked on any systems with physical pressure sensors, but I'm excited
> >>>>> to see new things get added.
> >>>>>
> >>>>>>
> >>>>>> As I see it, Altitude and Pressure are different in that
> >>>>>>         1) Altitude is computed base off of essentially a policy
> >>>>>
> >>>>> I have no idea what this means.....   In what way is altitude a
> >>>>> "policy"?  Can you elaborate a little?
> >>>>>
> >>>>
> >>>> I view a mechanism is something like update a FLASH part with
> >>>> an image provided.
> >>>>
> >>>> I view a policy is what decides if the the update of the FLASH part
> >>>> with the specific image is allowed.
> >>>>
> >>>> I the case if Pressure and Temperature I view them as mechanism,
> >>>> merely a simple reading and possibly some well defined computations
> >>>> that are universal.
> >>>>
> >>>> With Altitude computed from Pressure there are several ways to
> >>>> compute the Altitude and they are not universal.  So I see it as
> >>>> a policy of which Pressure to Altitude model is chosen and why.
> >>>
> >>> Sounds like I interpreted your intention correctly. (I think).
> >>
> >> I believe you did.
> >>
> >>>
> >>>>
> >>>>>>         2) Pressures is a read measurement which is a mechanism
> >>>>>>         3) Temperature is a read measurement which is also a mechanism
> >>>>>
> >>>>> I'm really struggling with the above to understand what you're getting
> >>>>> after, so if I go down the wrong path, please forgive me.
> >>>>>
> >>>>> I think what you're saying is that altitude is calculated based on
> >>>>> pressure + some transfer function to determine an altitude?  And that
> >>>>> transfer function might be fungible depending on the platform?
> >>>>>
> >>>>> If I got the above right (big if) I would probably expect a new
> >>>>> pressure sensor type to be added that reports a pressure sensor, then
> >>>>> we'd put the transform code in something that looks a lot like CFM
> >>>>> sensor (which oddly enough has a hardcoded 0 for altitude in its
> >>>>> algorithm for systems without pressure sensors).  Considering how
> >>>>> related a pressure sensor is to altitude, I could see putting them in
> >>>>> the same application if you wanted;  It might simplify the code some.
> >>>>>
> >>>>>
> >>>>> I think overall a better picture of what you're wanting to accomplish
> >>>>> would be a good place to start, then we can iterate from there on what
> >>>>> pieces we need that are new.
> >>>>
> >>>> I have Temperature, Pressure, possibly Humidity sensors all which are
> >>>> variables to different models to compute Altitude from.  I do not have a
> >>>> true Altitude sensor.
> >>>
> >>> This sounds exactly like the CFM sensor, and Exit air temp sensor;
> >>> Most systems don't have exit air temp sensors, but they have input
> >>> power and individual fan speeds, which can be put into models to
> >>> determine CFM and ultimately exit air temperature.  I would expect
> >>> Altitude to do something very similar in code (although with a
> >>> completely different algorithm).
> >>>
> >>
> >> So the DPS310 has 2 sensors in it a Pressure and a Temperature sensor.
> >> Do I create a Pressure reading and a Temperature reading for the DPS310
> >> and then add Altitude to it as well?
> >>
> >> Or do I create 3 separate things,  one for each Pressure, Temperature,
> >> and Altitude?
> >
> > Assuming in this case "things" are intended to mean "entity manager
> > exposes records" you would create one config record for the DPS310
> > itself (which would in turn create 2 sensors).  This is one "record"
> > because physically it's one part, and can't be separated, similar to a
> > TMP421.  After that, I would create another config record for the
> > "Here's the math to combine these into an altitude".  It might just be
> > a type and a name, depending on how many inputs go into the transfer
> > function to convert pressure+temperature into an altitude.
> >
> > If the math to combine into an altitude isn't system specific, I could
> > be convinced that the math should go into a single record within the
> > DPS310 exposes and have that live in the daemon itself, but I don't
> > have enough detail on how these are usually deployed to know that.
> >
>
> I prefer the the 2 record solution, it keeps the DPS310 self-contained.
> And keeps the Altitude self-contained, to the models can evolve and
> change; also if every a true altitude sensor were created it would help
> keep better abstraction from the DPS310.
>
> >>
> >> Also I believe I should be looking to the CFM sensor and Exit air
> >> temperature sensor as reference examples.
> >>
> >>>>
> >>>> I am being asked to provide Altitude.
> >>>>
> >>>> Personally I believe the desired feature is how much cooling a parcel of
> >>>> air per unit of time.  Thus I would think air Temperature, Humidity, and
> >>>> Density (probably compute-able from Pressure, but I have not checked on
> >>>> the specifics) would be the important factors.
> >>
>

Again, I am obviously missing the entire discussion leading to this point, so
my response may just be noise. If so, my apologies. Anyway, here is my $0.02:

Altitude can not be measured on its own with a sensor. It can, for example. be
estimated from air pressure (maybe taking other information or sensors into
account), or it can be provided (calculated) using GPS. Therefore, "altitude"
measurements don't belong into the kernel but need to be calculated in user
space from information which may or may not be provided by the kernel.
How to do that is outside the scope of kernel development.

A kernel driver for DPS310 should report pressure and temperature data,
not anything else that may be derived from it.

Thanks,
Guenter
