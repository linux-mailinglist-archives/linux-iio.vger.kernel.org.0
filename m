Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9907567E09
	for <lists+linux-iio@lfdr.de>; Wed,  6 Jul 2022 07:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGFFw6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Jul 2022 01:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiGFFw6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jul 2022 01:52:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409A2228A
        for <linux-iio@vger.kernel.org>; Tue,  5 Jul 2022 22:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657086774; x=1688622774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/hqBkXb2PRyOUCfQ+H1mxZ5M0YmBbzpl7rPPJ+2RKZw=;
  b=G64wjaATYU/fWAx15PIDoXnXUTuONkNH9Fvul+lIW6tf5O/D/L+hLNzY
   BzMtb5INWNSz2AoD3k3/2uH0LQ0HNOEdDGpoX85N1lVnsYxvRGaqbu1dW
   0wIT5ec8wjp9rqSGrcE1ytv5WBKFh3ApaW1+2EatnjEmWzLCimQf0gZ3E
   6q9Sm8aurArvH8D7Cu9WERyzxedRkYnJYO7hVLb/jhFZj7wrPOeOol7tg
   ii4vt4Le/CDZeELJWETVnXVW01Dz++19Cno3VWavoob8xydJCbv92uUpg
   AKPsTkoFe4jkDQ85Z5NCtjnhPOla7el8ksW2INJIZg/wao83NznGkj8x9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="369970285"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="369970285"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 22:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="695955053"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2022 22:52:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 22:52:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Jul 2022 22:52:44 -0700
Received: from orsmsx611.amr.corp.intel.com ([10.22.229.24]) by
 ORSMSX611.amr.corp.intel.com ([10.22.229.24]) with mapi id 15.01.2308.027;
 Tue, 5 Jul 2022 22:52:44 -0700
From:   "Hall, Christopher S" <christopher.s.hall@intel.com>
To:     Kent Gibson <kent.gibson@iinet.net.au>,
        "william.gray@linaro.org" <william.gray@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Dipen Patel <dipenp@nvidia.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: RE: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Topic: Intel Timed-IO driver in IIO/Counter subsystem
Thread-Index: AdiCFGKgSJf28KGeQ2qEKrwEQy9pwAAQT46AAAU1qIAAA8pdgAANdf+gASG+AQACSHdOgAAQ9ppw
Date:   Wed, 6 Jul 2022 05:52:37 +0000
Message-ID: <7d72f1ef363a4003b5209d68a88f30a9@intel.com>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
 <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
 <CACRpkdbeQ_67V3jkw_-KfTwe54TxrK_LA7N8Nwj1qEpTELN9dQ@mail.gmail.com>
 <ad7e53d1bd2448b4971af65483fe3542@intel.com>
 <CACRpkda63TNWLdTjY+_xxXb4df4qCZi1EaXL3pXK=+Hon-0RLQ@mail.gmail.com>
 <20220705031635.GA14199@sol>
In-Reply-To: <20220705031635.GA14199@sol>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Kent, William, and Linus:

Thank you for your input.

Kent Gibson <warthog618@gmail.com> wrote on Monday, July 04, 2022 8:17 PM:
> To: Hall, Christopher S <christopher.s.hall@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@b=
gdev.pl>; Shevchenko, Andriy
> <andriy.shevchenko@intel.com>; Dipen Patel <dipenp@nvidia.com>; N, Pandit=
h <pandith.n@intel.com>; D,
> Lakshmi Sowjanya <lakshmi.sowjanya.d@intel.com>; Lars-Peter Clausen <lars=
@metafoo.de>; linux-
> iio@vger.kernel.org; vilhelm.gray@gmail.com; jic23@kernel.org; Sangannava=
r, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; T R, Thejesh Reddy <thejesh.redd=
y.t.r@intel.com>
> Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
>=20
> On Thu, Jun 23, 2022 at 02:21:30PM +0200, Linus Walleij wrote:
> > On Sat, Jun 18, 2022 at 4:01 AM Hall, Christopher S
> > <christopher.s.hall@intel.com> wrote:
> > > Friday, June 17, 2022 4:40 AM Linus Walleij <linus.walleij@linaro.org=
> wrote:

> > > We want to be able to output a clock from 1 Hz (1 PPS) up to 1 KHz th=
at is
> > > synchronized with the system clock.
> > >
> > > It is possible to represent the periodic output function as a PWM dev=
ice,
> > > but the PWM subsystem output - without modification - is not aligned =
to
> > > any clock which breaks the timing application.
> >
> > Is it "just" a clock then? As in drivers/clk?
> >
> > It's of course annoying that the functionality of a certain hardware fa=
lls
> > between the subsystems so we end up using pieces of a subsystem in
> > another one, but there are several precedents, like network switch chip=
s
> > and USB UART chips with GPIO inside them, or graphic chips with
> > clock dividers inside.
> >
> > > > If a "single event" is something
> > > > like pulling a GPIO line high/low at a specific (wall clock) time i=
n the
> > > > future, it should probably be in the GPIO subsystem, like a trigger=
ed
> > > > GPIO event or so, that sounds a bit hard but certainly doable with =
some
> > > > thinking and tinkering.
> > >
> > > Earlier, we proposed a linereq_write() method in addition to the alre=
ady
> > > existing linereq_read().
> > >
> > > https://lkml.org/lkml/2021/8/24/807
> >
> > This might be a good approach for this part of the hardware, as long
> > as we can make sure we get the userspace API abstract enough
> > that other hardware can make use of it and userspace does not
> > need to know what provides the timed output, just that there is
> > some hardware that does.
> >
> > The ABI in the patch looks a bit dangerous, what happens if
> > you set an event like that and something decides to shake the
> > line by setting the output while the scheduled event is pending?
> >
> > The direction seems sound however, but Bartosz and Kent need
> > to look at it in detail, their effort on the userspace ABI has been
> > tremendous.
> >
>=20
> Extending the GPIO uAPI seems like a reasonable approach for timed
> sets, but as Linus mentioned, you need to consider the semantics of
> your operation for the general case.  What if the set time has already
> passed?  What happens with subsequent sets when one is already pending?
> Can they be cancelled?
>=20
> My first thought was that you could extend the SET_VALUES ioctl but,
> while we have reserved space for future use in most of the ioctls it
> turns out we overlooked sets and gets, so you would be looking at a new
> ioctl.  And you need to keep in mind how the SET_VALUES ioctl would
> interact with it (Linus' point).

I think we worked around this in a previous patchset by disallowing
(return error) the 'set' method. The pin/pad is assigned (by mux
configured in BIOS) to either GPIO or Timed I/O logic and both cannot be
used simultaneously. There is not a set method in the Timed IO hardware
logic, but one could be simulated by reading the current TSC clock value
and writing that to the COMPV (trigger time) register. This necessarily
cancels any trigger in progress unless the COMPV value is cached in
software and rewritten after the level is set. Having said that, I
cannot think of a good reason to mix the two trigger methods. For
example, if timed IO is used to produce a PPS output it is not very
useful to insert an untimed edge.

If we implement the set method, I think we should not allow setting the
output and return the error if an edge is already scheduled. The 'ban'
is lifted after the timer expires or is canceled.

> I don't see the linereq_write() approach flying - an ioctl is more
> appropriate.

This is OK. I am not overly attached to the write() interface

I think we could do this with a two ioctls:

struct lineevent_trigger {
	clockid_t clkid; /* We may want to select another clock */
	struct timespec trigger;
} ltrig_spec;

ioctl(fd, GPIOHANDLE_SET_LINE_EVENT_TRIGGER_ENABLE_IOCTL, &ltrig_spec) /* S=
et trigger time */
ioctl(fd, GPIOHANDLE_SET_LINE_EVENT_TRIGGER_CANCEL_IOCTL, &ltrig_spec) /* C=
ancel a trigger */

I do not see a need for a querying trigger status. The software can set
a timer or poll with clock_gettime()

I think this covers a single event. Periodic output is more of a challenge.
As noted above, the PWM interface is not a great fit mainly because the
PWM pulse is not aligned to a clock. We can augment the interface above

struct lineevent_trigger_periodic {
	clockid_t clkid;
	struct timespec trigger;
	struct timespec period;
} ltrig_spec;

A period of 0 indicates a one-shot timer. This is consistent with the
timer_settime() API.

The trick here is that we can specify the nominal *TSC* output period, but
we need to adjust the period to align the output with a local clock - or
since this feature is likely to be used with TSN - a PTP network clock.

The hardware can count the number of events. Using this, we compute
the *actual* output period with respect to the system clock:

delta(system clock) / delta(event count)

We can nudge the output period to match whichever clock we are tracking
as long as we know its relation to the system clock.

The counter interface can be used find the deltas with the system/ART
timestamp extension suggested by William.

> Cheers,
> Kent.

Thanks,
Christopher
