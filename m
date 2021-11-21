Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500554583DD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 14:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhKUNoM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 08:44:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234993AbhKUNoL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 08:44:11 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCB260524;
        Sun, 21 Nov 2021 13:41:05 +0000 (UTC)
Date:   Sun, 21 Nov 2021 13:45:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <gwendal@chromium.org>, <lars@metafoo.de>,
        <andy.shevchenko@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 08/13] iio: at91-sama5d2: Use scan_type when
 processing raw data
Message-ID: <20211121134559.25a51842@jic23-huawei>
In-Reply-To: <115f9f1b-5282-4756-8128-863e15065a2f@microchip.com>
References: <20211104082413.3681212-1-gwendal@chromium.org>
        <20211104082413.3681212-9-gwendal@chromium.org>
        <20211113164201.60644fc4@jic23-huawei>
        <115f9f1b-5282-4756-8128-863e15065a2f@microchip.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Nov 2021 09:22:58 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 11/13/21 6:42 PM, Jonathan Cameron wrote:
> > On Thu,  4 Nov 2021 01:24:08 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >   
> >> Use channel definition as root of trust and replace constant
> >> when reading elements directly using the raw sysfs attributes.
> >>
> >> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> > 
> > Hi Eugen,
> > 
> > Gwendal's v2 crossed with your comments on this fixing an issue in
> > 6794e23fa3fe ("iio: adc: at91-sama5d2_adc: add support for oversampling
> > resolution")
> > 
> > You requested a separate fix to change the value to 13 then this on top
> > of that.  I don't see why we can't go directly to this with an appropriately
> > reworded message to say what is being fixed.  Am I missing something beyond
> > the fix being more obvious if we just change the value?
> > 
> > Whilst this is pending I've applied the rest of this series as it's only this
> > one with open questions.  
> 
> Hi Jonathan,
> 
> If you feel it's not worth fixing it in a separate commit , then feel 
> free to apply this patch, I am happy with both ways.
> 
> you can add my
> 
> Reviewed-by: Eugen Hristev <eugen.hristev@microchip.com>

Thanks,

Applied to the fixes-togreg branch of iio.git with the fixes tag and stable marking.

Jonathan

> 
> Thanks !
> Eugen
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >>   drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >> index 4c922ef634f8e..92a57cf10fba4 100644
> >> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >> @@ -1586,7 +1586,8 @@ static int at91_adc_read_info_raw(struct iio_dev *indio_dev,
> >>                *val = st->conversion_value;
> >>                ret = at91_adc_adjust_val_osr(st, val);
> >>                if (chan->scan_type.sign == 's')
> >> -                     *val = sign_extend32(*val, 11);
> >> +                     *val = sign_extend32(*val,
> >> +                                          chan->scan_type.realbits - 1);
> >>                st->conversion_done = false;
> >>        }
> >>  
> >   
> 

