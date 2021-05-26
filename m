Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B96391D8D
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbhEZRJY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 13:09:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233955AbhEZRJY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 May 2021 13:09:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49FE61184;
        Wed, 26 May 2021 17:07:48 +0000 (UTC)
Date:   Wed, 26 May 2021 18:09:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andreas Klinger <ak@it-klinger.d>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 00/11] IIO: Alignment fixes part 3 - __aligned(8) used
 to ensure alignment
Message-ID: <20210526180916.5e253ef3@jic23-huawei>
In-Reply-To: <20210513185832.515046f9@jic23-huawei>
References: <20210501171352.512953-1-jic23@kernel.org>
        <20210513185832.515046f9@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 18:58:32 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  1 May 2021 18:13:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks to those who have already provided reviews on this set.
> If anyone has time to do a quick sanity check of the remaining patches
> it would be much appreciated.  I'll pick up the ones which have been reviewed
> in a few mins.
> 
> +Cc Andy who was kind enough to look at the other 'parts' of this mega series.

Anyone bored?  Still looking for a sanity check of the rest of this
series before I apply it.

I aim to revisit part 4 in the next few days.

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > 
> > I finally got around to do a manual audit of all the calls to
> > iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
> > of:
> > 1. 8 byte alignment of the provided buffer.
> > 2. space for an 8 byte naturally aligned timestamp to be inserted at the
> >    end.
> > 
> > Unfortunately there were rather a lot of these left, but time to bite the bullet
> > and clean them up.
> > 
> > As discussed previous in
> > https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
> > it is not easy to fix the alignment issue without requiring a bounce buffer
> > (see part 4 of the alignment fixes for a proposal for that where it is
> > absolutely necessary).
> > 
> > Part 3 contains the cases where the struct approach in part 2 did not seem
> > appropriate.  Normally there are two possible reasons for this.
> > 1.  Would have required an additional memset operation to avoid any
> >     possibility of leaking kernel data.
> > 2.  The location of the timestamp may depend on the channels enabled.
> >     This normally happens when the max sizeof channels is greater than
> >     8 bytes.
> > 
> > Once all cases are fixes, I'll take a look at hardening against any
> > accidental reintroductions. Note that on many platforms and usecases the
> > bug in question will never occur.
> > 
> > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> > Cc: Andreas Klinger <ak@it-klinger.d>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Song Qiang <songqiang1304521@gmail.com>
> > Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> > Cc: Parthiban Nallathambi <pn@denx.de>
> > 
> > Jonathan Cameron (11):
> >   iio: adc: at91-sama5d2: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: hx711: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: mxs-lradc: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: ti-ads8688: Fix alignment of buffer in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: chemical: atlas: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: cros_ec_sensors: Fix alignment of buffer in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: potentiostat: lmp91000: Fix alignment of buffer in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: magn: rm3100: Fix alignment of buffer in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: light: vcnl4000: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: light: vcnl4035: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: prox: isl29501: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> > 
> >  drivers/iio/adc/at91-sama5d2_adc.c              | 3 ++-
> >  drivers/iio/adc/hx711.c                         | 4 ++--
> >  drivers/iio/adc/mxs-lradc-adc.c                 | 3 ++-
> >  drivers/iio/adc/ti-ads8688.c                    | 3 ++-
> >  drivers/iio/chemical/atlas-sensor.c             | 4 ++--
> >  drivers/iio/light/vcnl4000.c                    | 2 +-
> >  drivers/iio/light/vcnl4035.c                    | 3 ++-
> >  drivers/iio/magnetometer/rm3100-core.c          | 3 ++-
> >  drivers/iio/potentiostat/lmp91000.c             | 4 ++--
> >  drivers/iio/proximity/isl29501.c                | 2 +-
> >  include/linux/iio/common/cros_ec_sensors_core.h | 2 +-
> >  11 files changed, 19 insertions(+), 14 deletions(-)
> >   
> 

