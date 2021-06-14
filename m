Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24A3A6276
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhFNLA4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 14 Jun 2021 07:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233915AbhFNK5Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 06:57:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5BF61426;
        Mon, 14 Jun 2021 10:41:32 +0000 (UTC)
Date:   Mon, 14 Jun 2021 11:43:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andreas Klinger <ak@it-klinger.d>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH RESEND 0/8] IIO: Alignment fixes part 3 - __aligned(8)
 used to ensure alignment
Message-ID: <20210614114333.4bf9ec28@jic23-huawei>
In-Reply-To: <PH0PR03MB6366479D135F6D96D3FD4F1C99319@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210613152301.571002-1-jic23@kernel.org>
        <PH0PR03MB6366479D135F6D96D3FD4F1C99319@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 08:03:20 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Jonathan,
> 
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, June 13, 2021 5:23 PM
> > To: linux-iio@vger.kernel.org
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Eugen
> > Hristev <eugen.hristev@microchip.com>; Andreas Klinger <ak@it-  
> > klinger.d>; Song Qiang <songqiang1304521@gmail.com>; Mathieu  
> > Othacehe <m.othacehe@gmail.com>; Parthiban Nallathambi
> > <pn@denx.de>
> > Subject: [PATCH RESEND 0/8] IIO: Alignment fixes part 3 - __aligned(8)
> > used to ensure alignment
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Resent as none of these have had any comments since being sent out
> > over
> > a month ago.  Note these are very straight forward, but I've messed up
> > such things in the past so really appreciate it if someone takes the time
> > to do a quick sanity check.
> > 
> > I have picked up those patches that did get review in first posting and
> > dropped them from this posting.
> > 
> > Cover letter from first posting.
> > 
> > I finally got around to do a manual audit of all the calls to
> > iio_push_to_buffers_with_timestamp() which has the somewhat odd
> > requirements
> > of:
> > 1. 8 byte alignment of the provided buffer.
> > 2. space for an 8 byte naturally aligned timestamp to be inserted at the
> >    end.
> > 
> > Unfortunately there were rather a lot of these left, but time to bite
> > the bullet
> > and clean them up.
> > 
> > As discussed previous in
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-
> > iio/20200920112742.170751-1-
> > jic23@kernel.org/__;!!A3Ni8CS0y2Y!uCn6NSpGUvHYdcFazn7flxxjh8RA
> > RqPCumitrRDDgGAjXF7crgi911KY2v_iyw$
> > it is not easy to fix the alignment issue without requiring a bounce
> > buffer
> > (see part 4 of the alignment fixes for a proposal for that where it is
> > absolutely necessary).
> > 
> > Part 3 contains the cases where the struct approach in part 2 did not
> > seem
> > appropriate.  Normally there are two possible reasons for this.
> > 1.  Would have required an additional memset operation to avoid any
> >     possibility of leaking kernel data.
> > 2.  The location of the timestamp may depend on the channels
> > enabled.
> >     This normally happens when the max sizeof channels is greater than
> >     8 bytes.
> > 
> > Once all cases are fixes, I'll take a look at hardening against any
> > accidental reintroductions. Note that on many platforms and usecases
> > the
> > bug in question will never occur.
> > 
> > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> > Cc: Andreas Klinger <ak@it-klinger.d>
> > Cc: Song Qiang <songqiang1304521@gmail.com>
> > Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> > Cc: Parthiban Nallathambi <pn@denx.de>
> > 
> > Jonathan Cameron (8):
> >   iio: adc: at91-sama5d2: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: hx711: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: mxs-lradc: Fix buffer alignment in
> >     iio_push_to_buffers_with_timestamp()
> >   iio: adc: ti-ads8688: Fix alignment of buffer in
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
> >  drivers/iio/adc/at91-sama5d2_adc.c     | 3 ++-
> >  drivers/iio/adc/hx711.c                | 4 ++--
> >  drivers/iio/adc/mxs-lradc-adc.c        | 3 ++-
> >  drivers/iio/adc/ti-ads8688.c           | 3 ++-
> >  drivers/iio/light/vcnl4000.c           | 2 +-
> >  drivers/iio/light/vcnl4035.c           | 3 ++-
> >  drivers/iio/magnetometer/rm3100-core.c | 3 ++-
> >  drivers/iio/proximity/isl29501.c       | 2 +-
> >  8 files changed, 14 insertions(+), 9 deletions(-)
> > 
> > --
> > 2.32.0  
> 
> LGTM. For the whole series:
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Thanks!

Given how long they've been sitting around on list...

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> 
> - Nuno Sá

