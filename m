Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDFD37FCE1
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 19:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhEMRyh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhEMRyX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:54:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B913B61166;
        Thu, 13 May 2021 17:53:09 +0000 (UTC)
Date:   Thu, 13 May 2021 18:54:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Andreas Klinger <ak@it-klinger.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/19] IIO: Alignment fixes part 2 - struct used to
 ensure alignment
Message-ID: <20210513185418.0e7766e5@jic23-huawei>
In-Reply-To: <CAHp75VdWmEHdn1iuA3xNHLMbhiapguEmrktGkf5vDFrPdy1XJA@mail.gmail.com>
References: <20210501170121.512209-1-jic23@kernel.org>
        <CAHp75VdWmEHdn1iuA3xNHLMbhiapguEmrktGkf5vDFrPdy1XJA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 22:12:40 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 1, 2021 at 8:03 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I finally got around to do a manual audit of all the calls to
> > iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
> > of:
> > 1. 8 byte alignment of the provided buffer.
> > 2. space for an 8 byte naturally aligned timestamp to be inserted at the
> >    end.
> >
> > Unfortuantely there were rather a lot of these left, but time to bite the bullet  
> 
> Unfortunately
> 
> > and clean them up.
> >
> > As discussed previous in
> > https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
> > it is not easy to fix the alignment issue without requiring a bounce buffer
> > (see part 4 of the alignment fixes for a proposal for that where it is
> > absolutely necessary).
> >
> > Part 2 is the simple cases where the timestamp position is always the same
> > (as not more than 8 bytes of other scan elements) and where it is either
> > in a structure that is kzalloc'd or there was already an explicit memset
> > that would clear any holes in the structure (and hence avoid a potential
> > kernel data leak).
> >
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>  
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> 1
> 
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>  
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> 2
> 
> One time is enough :-)
> 
> Anyway, I looked at them all and haven't seen any issues on the first glance, so
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks.  Whole series applied though seems I was being more than a bit careless
in some of the early ones so I took a very close look at all them whilst applying.

Do too many similar patches, and mistakes slip in :(

Thanks,

Jonathan

> 
> > Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> > Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> > Cc: Stephan Gerhold <stephan@gerhold.net>
> > Cc: Andreas Klinger <ak@it-klinger.de>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> >
> > Jonathan Cameron (19):
> >   iio: accel: bma180: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: accel: bma220: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: accel: hid: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: accel: kxcjk-1013: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: accel: mxc4005: Fix overread of data and alignment issue.
> >   iio: accel: stk8312: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: accel: stk8ba50: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: ti-ads1015: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: vf610: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: gyro: bmg160: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: humidity: am2315: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: prox: srf08: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: prox: pulsed-light: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: prox: as3935: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: magn: hmc5843: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: magn: bmc150: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: light: isl29125: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: light: tcs3414: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: light: tcs3472: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >
> >  drivers/iio/accel/bma180.c                    | 10 +++++---
> >  drivers/iio/accel/bma220_spi.c                | 10 +++++---
> >  drivers/iio/accel/hid-sensor-accel-3d.c       | 13 ++++++----
> >  drivers/iio/accel/kxcjk-1013.c                | 24 +++++++++++--------
> >  drivers/iio/accel/mxc4005.c                   | 10 +++++---
> >  drivers/iio/accel/stk8312.c                   | 12 ++++++----
> >  drivers/iio/accel/stk8ba50.c                  | 17 +++++++------
> >  drivers/iio/adc/ti-ads1015.c                  | 12 ++++++----
> >  drivers/iio/adc/vf610_adc.c                   | 10 +++++---
> >  drivers/iio/gyro/bmg160_core.c                | 10 +++++---
> >  drivers/iio/humidity/am2315.c                 | 16 ++++++++-----
> >  drivers/iio/light/isl29125.c                  | 10 +++++---
> >  drivers/iio/light/tcs3414.c                   | 10 +++++---
> >  drivers/iio/light/tcs3472.c                   | 10 +++++---
> >  drivers/iio/magnetometer/bmc150_magn.c        | 11 +++++----
> >  drivers/iio/magnetometer/hmc5843.h            |  8 +++++--
> >  drivers/iio/magnetometer/hmc5843_core.c       |  4 ++--
> >  drivers/iio/proximity/as3935.c                | 10 +++++---
> >  .../iio/proximity/pulsedlight-lidar-lite-v2.c | 10 +++++---
> >  drivers/iio/proximity/srf08.c                 | 14 +++++------
> >  20 files changed, 148 insertions(+), 83 deletions(-)
> >
> > --
> > 2.31.1
> >  
> 
> 

