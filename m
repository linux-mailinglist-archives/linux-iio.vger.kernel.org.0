Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFE533D4A0
	for <lists+linux-iio@lfdr.de>; Tue, 16 Mar 2021 14:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCPNNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Mar 2021 09:13:36 -0400
Received: from foss.arm.com ([217.140.110.172]:39756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhCPNNe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Mar 2021 09:13:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D29101E;
        Tue, 16 Mar 2021 06:13:33 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75483F792;
        Tue, 16 Mar 2021 06:13:30 -0700 (PDT)
Date:   Tue, 16 Mar 2021 13:13:28 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Enrico Granata <egranata@google.com>,
        Mikhail Golubev <mikhail.golubev@opensynergy.com>,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>,
        Peter Hilber <Peter.hilber@opensynergy.com>,
        Ankit Arora <ankitarora@google.com>,
        Guru Nagarajan <gurunagarajan@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/1] iio/scmi: Adding support for IIO SCMI Based
 Sensors
Message-ID: <20210316131314.GI30179@e120937-lin>
References: <20210309231259.78050-1-jbhayana@google.com>
 <20210309231259.78050-2-jbhayana@google.com>
 <20210311210844.34371d8d@archlinux>
 <20210312121639.00001c31@Huawei.com>
 <20210312133101.GG30179@e120937-lin>
 <CA+=V6c0boA1Q+k4rM0NOcK4ek_FYU7omEWhvMowqACH_t44sAQ@mail.gmail.com>
 <20210313171107.4c8215e7@archlinux>
 <CA+=V6c0a8z9+gkD_M6KNviN-VActtmpTgkuCBn-sgC4Fm2C6QA@mail.gmail.com>
 <20210314154033.3facf1a2@archlinux>
 <CA+=V6c341JjXQ+QFpiSES_Lm7PT0qCh2WU0uQWrmrFaPr_2QiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+=V6c341JjXQ+QFpiSES_Lm7PT0qCh2WU0uQWrmrFaPr_2QiA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

I reposted my series on top of the take3 immutable branch from Jonathan
at:

https://lore.kernel.org/lkml/20210316124903.35011-1-cristian.marussi@arm.com/T/#t

You should have received an email regarding the relevant IIO SCMI patch

v7-0025-iio-scmi-port-driver-to-the-new-scmi_sensor_proto.patch

which includes the port of your v7 IIO SCMI driver to the new API, and moved
also the notification registration to the probe phase to simplify it
further.

On my side I tested with some fake emulated sensors emitting periodic
100ms SENSOR_UPDATE notifs...and verifying that notifications are still
dispatched and received fine. (values are just fakes)

If you can have a look, comment and possibly Ack.

Thanks

Cristian

---

(debian-arm64)root@debarm64:~# /root/iio_generic_buffer -a -c -1 -g -l 100 -N 0
iio device number being used is 0
trigger-less mode selected
Enabling all channels
Enabling: in_accel_x_en
Enabling: in_accel_z_en
Enabling: in_timestamp_en
Enabling: in_accel_y_en
-9465 -9457 -9449 6169807244683640832.000000
-9464 -9456 -9448 6169807244683640832.000000
-9463 -9455 -9447 6169807244683640832.000000
-9462 -9454 -9446 6169807244683640832.000000
-9461 -9453 -9445 6169807244683640832.000000
-9460 -9452 -9444 6169807244683640832.000000
-9459 -9451 -9443 7169807022831960064.000000
-9458 -9450 -9442 7169807022831960064.000000
-9457 -9449 -9441 7169807022831960064.000000
-9456 -9448 -9440 7169807022831960064.000000
-9455 -9447 -9439 7169807022831960064.000000
-9454 -9446 -9438 7169807022831960064.000000
-9453 -9445 -9437 7169807022831960064.000000
-9452 -9444 -9436 7169807022831960064.000000
-9451 -9443 -9435 7169807022831960064.000000
-9450 -9442 -9434 7169807022831960064.000000
-9449 -9441 -9433 8169806800980279296.000000
-9448 -9440 -9432 8169806800980279296.000000
-9447 -9439 -9431 8169806800980279296.000000
-9446 -9438 -9430 8169806800980279296.000000
-9445 -9437 -9429 8169806800980279296.000000
-9444 -9436 -9428 8169806800980279296.000000
-9443 -9435 -9427 8169806800980279296.000000
-9442 -9434 -9426 8169806800980279296.000000
-9441 -9433 -9425 8169806800980279296.000000
-9440 -9432 -9424 8169806800980279296.000000
-9439 -9431 -9423 9169807128884412416.000000
-9438 -9430 -9422 9169807128884412416.000000
-9437 -9429 -9421 9169807128884412416.000000
-9436 -9428 -9420 9169807128884412416.000000
-9435 -9427 -9419 9169807128884412416.000000
^CCaught signal 2
Disabling: in_accel_x_en
Disabling: in_accel_z_en
Disabling: in_timestamp_en
Disabling: in_accel_y_en


On Sun, Mar 14, 2021 at 11:47:25AM -0700, Jyoti Bhayana wrote:
> Hi Jonathan,
> 
> No worries. Thanks for the update. It looks good now.
> 
> Thanks,
> Jyoti
> 
> On Sun, Mar 14, 2021 at 8:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Sat, 13 Mar 2021 11:55:39 -0800
> > Jyoti Bhayana <jbhayana@google.com> wrote:
> >
> > > Hi Jonathan,
> > >
> > > I still see the old version 6 in ib-iio-scmi-5.12-rc2-take2 as well.
> >
> > OK. I'm completely confused as to what is going with my local tree.
> > I have the right patch in the history but it didn't end up in the final
> > pushed out version.  Fat finger mess-up I guess and too many similarly named
> > branches and the fact I didn't check the final result closely enough.
> >
> > There is now an ib-iio-scmi-5.12-rc2-take3 branch
> >
> > This time it definitely has your patch from the 9th of March with no
> > instances of long long in it.
> >
> > Sorry I messed this one up (again!)
> >
> > Jonathan
> >
> > >
> > > Thanks,
> > > Jyoti
> >
