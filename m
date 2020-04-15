Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287A21A936E
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 08:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393583AbgDOGnl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 02:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393592AbgDOGnk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Apr 2020 02:43:40 -0400
Received: from ROU-LT-M43218B.mchp-main.com (amontpellier-556-1-155-96.w109-210.abo.wanadoo.fr [109.210.131.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E673206F9;
        Wed, 15 Apr 2020 06:43:38 +0000 (UTC)
Date:   Wed, 15 Apr 2020 08:43:52 +0200
From:   ludovic.desroches@microchip.com
To:     Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: at91-sama5d2_adc: split
 at91_adc_current_chan_is_touch() helper
Message-ID: <20200415064352.yn7xkvjtsdcvnvni@ROU-LT-M43218B.mchp-main.com>
References: <20200304084219.20810-1-alexandru.ardelean@analog.com>
 <20200413180556.20638f3b@archlinux>
 <9315e9a7-0703-b119-ca32-69f0c2fcc7de@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9315e9a7-0703-b119-ca32-69f0c2fcc7de@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 12:22:45PM +0000, Eugen Hristev - M18282 wrote:
> On 13.04.2020 20:05, Jonathan Cameron wrote:
> > On Wed, 4 Mar 2020 10:42:18 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > 
> >> This change moves the logic to check if the current channel is the
> >> touchscreen channel to a separate helper.
> >> This reduces some code duplication, but the main intent is to re-use this
> >> in the next patches.
> >>
> >> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Eugen / Ludovic,
> > 
> > Have you had a chance to look at this series?
> 
> Hi Jonathan,
> 
> Does the patch apply correctly for you ?

No issue on my side to apply them (v5.7-rc1 and next).

> I will try to test it , if I manage to apply it.
> I can only test the ADC though because at this moment I do not have a 
> touchscreen at disposal.

Same here, not able to test the touchscreen but it doesn't seem very risky.

> 
> Meanwhile, the code looks good for me,
> 
> Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>

You can add mine as well:

Reviewed-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Regards

Ludovic

> 
> By the way, I do not know if my two pending patches on this driver will 
> conflict or not.
> 
> Eugen
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> >> ---
> >>
> >> This patchset continues discussion:
> >>     https://lore.kernel.org/linux-iio/20191023082508.17583-1-alexandru.ardelean@analog.com/
> >> Apologies for the delay.
> >>
> >> Changelog v1 -> v2:
> >> * added patch 'iio: at91-sama5d2_adc: split at91_adc_current_chan_is_touch()
> >>    helper'
> >> * renamed at91_adc_buffer_postenable() -> at91_adc_buffer_preenable()
> >>    - at91_adc_buffer_postenable() - now just calls
> >>      iio_triggered_buffer_postenable() if the channel isn't the touchscreen
> >>      channel
> >> * renamed at91_adc_buffer_predisable() -> at91_adc_buffer_postdisable()
> >>    - at91_adc_buffer_predisable() - now just calls
> >>      iio_triggered_buffer_predisable() if the channel isn't the touchscreen
> >>      channel
> >>
> >>   drivers/iio/adc/at91-sama5d2_adc.c | 31 +++++++++++++++---------------
> >>   1 file changed, 15 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >> index a5c7771227d5..f2a74c47c768 100644
> >> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >> @@ -873,18 +873,24 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
> >>        return 0;
> >>   }
> >>
> >> +static bool at91_adc_current_chan_is_touch(struct iio_dev *indio_dev)
> >> +{
> >> +     struct at91_adc_state *st = iio_priv(indio_dev);
> >> +
> >> +     return !!bitmap_subset(indio_dev->active_scan_mask,
> >> +                            &st->touch_st.channels_bitmask,
> >> +                            AT91_SAMA5D2_MAX_CHAN_IDX + 1);
> >> +}
> >> +
> >>   static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
> >>   {
> >>        int ret;
> >>        struct at91_adc_state *st = iio_priv(indio_dev);
> >>
> >>        /* check if we are enabling triggered buffer or the touchscreen */
> >> -     if (bitmap_subset(indio_dev->active_scan_mask,
> >> -                       &st->touch_st.channels_bitmask,
> >> -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> >> -             /* touchscreen enabling */
> >> +     if (at91_adc_current_chan_is_touch(indio_dev))
> >>                return at91_adc_configure_touch(st, true);
> >> -     }
> >> +
> >>        /* if we are not in triggered mode, we cannot enable the buffer. */
> >>        if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> >>                return -EINVAL;
> >> @@ -906,12 +912,9 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> >>        u8 bit;
> >>
> >>        /* check if we are disabling triggered buffer or the touchscreen */
> >> -     if (bitmap_subset(indio_dev->active_scan_mask,
> >> -                       &st->touch_st.channels_bitmask,
> >> -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> >> -             /* touchscreen disable */
> >> +     if (at91_adc_current_chan_is_touch(indio_dev))
> >>                return at91_adc_configure_touch(st, false);
> >> -     }
> >> +
> >>        /* if we are not in triggered mode, nothing to do here */
> >>        if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> >>                return -EINVAL;
> >> @@ -1886,14 +1889,10 @@ static __maybe_unused int at91_adc_resume(struct device *dev)
> >>                return 0;
> >>
> >>        /* check if we are enabling triggered buffer or the touchscreen */
> >> -     if (bitmap_subset(indio_dev->active_scan_mask,
> >> -                       &st->touch_st.channels_bitmask,
> >> -                       AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
> >> -             /* touchscreen enabling */
> >> +     if (at91_adc_current_chan_is_touch(indio_dev))
> >>                return at91_adc_configure_touch(st, true);
> >> -     } else {
> >> +     else
> >>                return at91_adc_configure_trigger(st->trig, true);
> >> -     }
> >>
> >>        /* not needed but more explicit */
> >>        return 0;
> > 
> 
