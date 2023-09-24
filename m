Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9477AC810
	for <lists+linux-iio@lfdr.de>; Sun, 24 Sep 2023 14:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjIXMmi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Sep 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMmi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Sep 2023 08:42:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C4C6;
        Sun, 24 Sep 2023 05:42:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2A3C433C7;
        Sun, 24 Sep 2023 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695559352;
        bh=jdSBMvwUrnXjTgwgGycMBUidQuQDTIqZgecQ0g4BZGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SWxT1uL/43yHAcjpJJuh2OV8yzsI7M0yQTwHKJ7Qw74zzy+cHY7wZWJ7SpmmyI7P5
         K+7ZLy4lGmRv9GQ901/o5ZfSOrvIyrZu2MvSyyYcuXYBNJxXrzRzZS8kBDysZeln5M
         1EYBvo94LDiaYzN3w9fyy7RyLu38L8zJgbdJCelKIihMoh3zk+MSad6OGN+I94ppy/
         LCrQzaQLffw+541Q5M6ocr3U+jCIj8SP32KRdxcwykZCw0XkEWxz+RP3rWTnmn+58F
         3P5BH8JpMWM7AlMefGCBaG5qGfoSwc29ujGa58KOFGmo5xCM2vu8F3qekQtVTkrBx7
         /cahXPpo8TO3Q==
Date:   Sun, 24 Sep 2023 13:42:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Basavaraj Natikar <bnatikar@amd.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        benjamin.tissoires@redhat.com, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
Message-ID: <20230924134224.64e54daa@jic23-huawei>
In-Reply-To: <520df871-a6d1-0db3-fba1-cffd35d9cc81@amd.com>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
        <nycvar.YFH.7.76.2309201612350.14216@cbobk.fhfr.pm>
        <520df871-a6d1-0db3-fba1-cffd35d9cc81@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Sep 2023 20:53:33 +0530
Basavaraj Natikar <bnatikar@amd.com> wrote:

> On 9/20/2023 7:43 PM, Jiri Kosina wrote:
> > On Tue, 19 Sep 2023, Basavaraj Natikar wrote:
> >  
> >> This series adds support for light color temperature and chromaticity.
> >>
> >> v1->v2:
> >> *Rename the series.
> >> *Rename als_illum to als channel as it supports other channels.
> >> *Update patch description to include same reading for the two existing
> >>  channels to use channel index to support more hub attributes.
> >> *Keep line length under 80chars in hid-sensor-als.
> >> *Add new channel type IIO_COLORTEMP.
> >> *Update patch description and its subject to add channel type for 
> >>  chromaticity. 
> >>
> >> Basavaraj Natikar (9):
> >>   iio: hid-sensor-als: Use channel index to support more hub attributes
> >>   iio: Add channel type light color temperature
> >>   iio: hid-sensor-als: Add light color temperature support
> >>   HID: amd_sfh: Add support for light color temperature
> >>   HID: amd_sfh: Add support for SFH1.1 light color temperature
> >>   iio: Add channel type for chromaticity
> >>   iio: hid-sensor-als: Add light chromaticity support
> >>   HID: amd_sfh: Add light chromaticity support
> >>   HID: amd_sfh: Add light chromaticity for SFH1.1
> >>
> >>  Documentation/ABI/testing/sysfs-bus-iio       |  15 ++
> >>  .../hid_descriptor/amd_sfh_hid_desc.c         |   7 +
> >>  .../hid_descriptor/amd_sfh_hid_desc.h         |   3 +
> >>  .../hid_descriptor/amd_sfh_hid_report_desc.h  |  21 +++
> >>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c |   9 ++
> >>  .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  15 ++
> >>  drivers/iio/industrialio-core.c               |   2 +
> >>  drivers/iio/light/hid-sensor-als.c            | 130 +++++++++++++++---
> >>  include/linux/hid-sensor-ids.h                |   4 +
> >>  include/uapi/linux/iio/types.h                |   2 +
> >>  tools/iio/iio_event_monitor.c                 |   3 +
> >>  11 files changed, 195 insertions(+), 16 deletions(-)  
> > I believe this should go through Jonathan's tree as a whole, right?  
> 
> Yes, this should go through Jonathan's tree as a whole.
> If you don't have concerns, can you please ack HID amd_sfh changes?

I'll do an immutable branch in case this needs pulling into the hid tree
later in the cycle.

In short that means I'll create a branch with just this series on top of v6.6-rc1
and push that out as ib-iio-hid-sensors-v6.6-rc1.
I'll then merge that into the IIO tree before I do a pull request.
The advantage of this being that it can be pulled into other trees as necessary
and keep the same git IDs etc so that git can cleanly unwind the splitting and
merging of the history to cover the different paths.

However, note this will be messy as the merge into IIO isn't clean. I'll fix it
up but please take a quick look at the testing branch of iio.git on kernel.org
where the results of that merge will be.  Some other channel types were added
recently. So the fix was obvious.

So applied to the branch ib-iio-hid-sensors-6.6-rc1.  I'll merge that into the
IIO tree. That will get pushed out as testing for the build bots to see if they can
find anything we missed before I push this out as togreg which is what
linux-next picks up.

Note the IB branch might be rebased if any test issues show up.

Thanks,

Jonathan

> 
> Thanks,
> --
> Basavaraj
> 

