Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD91D6283
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 18:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEPQKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 12:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgEPQKh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 12:10:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE882065C;
        Sat, 16 May 2020 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589645436;
        bh=Qx3DPnLp4Vlp4WJ3u6wX1iOXw5Nit6PjtbPUDtvgjSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k6/tivZNjd8R8swJwDe/I/LbARHwE//1VTw75YxDTQnU4kjsOr8uOUUUIE4kHPLck
         CcB7TEgVRbq+/1fFcOY8zHrtiPSDL/UewC/ncQrkAGtIkOpT9iRmJ51XotBV4MBRJ3
         5Vh8E8jbb1joMTVcVXPQNABRc+WUhbUdeoCOJq/k=
Date:   Sat, 16 May 2020 17:10:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <Ludovic.Desroches@microchip.com>
Subject: Re: [RFC PATCH] iio: __iio_update_buffers: Update mode before
 preenable/after postdisable
Message-ID: <20200516171032.29fa8e08@archlinux>
In-Reply-To: <8551295e-c166-674e-c449-61ccb5bbef76@microchip.com>
References: <20200430082455.1628-1-alexandru.ardelean@analog.com>
        <0096231b-eda4-7685-3411-3de467618c25@microchip.com>
        <dbd7fba9-ad26-fb8f-7a71-55b75951409f@microchip.com>
        <8551295e-c166-674e-c449-61ccb5bbef76@microchip.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 10:56:16 +0000
<Eugen.Hristev@microchip.com> wrote:

> On 04.05.2020 15:27, Eugen Hristev - M18282 wrote:
> > On 30.04.2020 11:42, Eugen Hristev - M18282 wrote:  
> >> On 30.04.2020 11:24, Alexandru Ardelean wrote:  
> >>> From: Lars-Peter Clausen <lars@metafoo.de>
> >>>
> >>> It is clear that we transition to INDIO_DIRECT_MODE when disabling the
> >>> buffer(s) and it is also clear that we transition from INDIO_DIRECT_MODE
> >>> when enabling the buffer(s). So leaving the currentmode field
> >>> INDIO_DIRECT_MODE until after the preenable() callback and updating it to
> >>> INDIO_DIRECT_MODE before the postdisable() callback doesn't add additional
> >>> value. On the other hand some drivers will need to perform different
> >>> actions depending on which mode the device is going to operate in/was
> >>> operating in.
> >>>
> >>> Moving the update of currentmode before preenable() and after postdisable()
> >>> enables us to have drivers which perform mode dependent actions in those
> >>> callbacks.
> >>>
> >>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> >>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >>> ---
> >>>
> >>> This patch is also a V2 of this older patch from a while ago:
> >>>     https://lore.kernel.org/linux-iio/1431525891-19285-5-git-send-email-lars@metafoo.de/
> >>>
> >>> However, in this recent context, it comes to fix this:
> >>>     https://lore.kernel.org/linux-iio/b9ab676489de3575984dac5610fcf05fd8742a38.camel@analog.com/T/#mc09284c8f79250b92a52fd5b8d1f541d1c02c0c0
> >>>
> >>> At this point, I don't have a clear idea if this approach is good or
> >>> not; since the motivation is to fix the at91 adc.
> >>> Hence the RFC.
> >>>
> >>> Some excerpt from the AT91 discussion:
> >>> -------------------------------------------------------------------
> >>> I decided to do a bit of shell magic for this:
> >>>
> >>> get_files() {
> >>> git grep -w iio_buffer_setup_ops  | grep drivers | cut -d: -f1 | sort | uniq
> >>> }
> >>>
> >>> for file in $(get_files) ; do
> >>>        if grep -q currentmode $file ; then
> >>>            echo $file
> >>>        fi
> >>> done
> >>>
> >>> It finds 4 drivers.
> >>> Though, `get_files()` will return 56 files.
> >>>
> >>> drivers/iio/accel/bmc150-accel-core.c
> >>> drivers/iio/adc/at91-sama5d2_adc.c
> >>> drivers/iio/adc/stm32-dfsdm-adc.c
> >>> drivers/iio/magnetometer/rm3100-core.c
> >>>
> >>> The rm3100 driver doesn't do any checks in the setup_ops for 'currentmode' as
> >>> far as I could see.
> >>>
> >>> So, Lars' patch could work nicely to fix this current case and not break others.
> >>>
> >>> Semantically though, it would sound nicer to have a 'nextmode' parameter
> >>> somewhere; maybe on the setup_ops(indio_dev, nextmode)?
> >>> Though, only those 3 drivers would really ever use it; so doing it like that
> >>> sounds like overkill.
> >>>
> >>> So, we're left with Lars' patch or we could add an 'indio_dev->nextmode' field,
> >>> that may be used in just these 3 drivers [which again: sounds overkill at this
> >>> point in time].
> >>>
> >>> Alternatively, this 'indio_dev->currentmode' could be removed from all these 3
> >>> drivers somehow. But that needs testing and a thorough understanding of all 3
> >>> drivers and what they're doing, to do properly.
> >>> -------------------------------------------------------------------  
> >>
> >> Hi Alex,
> >>
> >> Thanks for finding this. I will test this with the at91-sama5d2_adc
> >> driver on Jonathan's testing branch. I will let you know of the results.
> >>
> >> Eugen  
> > 
> > Hi,
> > 
> > For sama5d2-xplained, hw trigger testing, at91-sama5d2_adc driver,
> > Tested-by: Eugen Hristev <eugen.hristev@microchip.com>
> > 
> > I did not get my hands on the touchscreen yet, but hopefully soon.
> > 
> > Thanks again,
> > Eugen  
> 
> Hello Jonathan,
> 
> Without this patch, your current testing branch is broken for hardware 
> trigger for at91-sama5d2_adc (including for-5.8b tag)
> 
> You want me to create a patch that fixes that in the driver, or you will 
> take this patch maybe ?

Hmmm. Semantically I wasn't overly keen on this patch, but it does appear
harmless and will kind of make more sense once the big rework Alex
is doing is finished..  My concern was that preenable should see the
currentmode as the one before enabling - so not a buffered mode, 
and with this it doesn't.

I sanity checked the cases identified and they all seem fine so
let's go with it.

We are a bit near the merge window for me to be absolutely sure I'll get
another pull request out, so this might get shifted to the fixes branch
if I miss that.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks !
> Eugen
> >>  
> >>>
> >>>     drivers/iio/industrialio-buffer.c | 8 +++-----
> >>>     1 file changed, 3 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> >>> index 30af8af8f312..efcc44b62946 100644
> >>> --- a/drivers/iio/industrialio-buffer.c
> >>> +++ b/drivers/iio/industrialio-buffer.c
> >>> @@ -989,6 +989,7 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> >>>            indio_dev->active_scan_mask = config->scan_mask;
> >>>            indio_dev->scan_timestamp = config->scan_timestamp;
> >>>            indio_dev->scan_bytes = config->scan_bytes;
> >>> +       indio_dev->currentmode = config->mode;
> >>>
> >>>            iio_update_demux(indio_dev);
> >>>
> >>> @@ -1024,8 +1025,6 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> >>>                            goto err_disable_buffers;
> >>>            }
> >>>
> >>> -       indio_dev->currentmode = config->mode;
> >>> -
> >>>            if (indio_dev->setup_ops->postenable) {
> >>>                    ret = indio_dev->setup_ops->postenable(indio_dev);
> >>>                    if (ret) {
> >>> @@ -1042,10 +1041,10 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
> >>>                                                 buffer_list)
> >>>                    iio_buffer_disable(buffer, indio_dev);
> >>>     err_run_postdisable:
> >>> -       indio_dev->currentmode = INDIO_DIRECT_MODE;
> >>>            if (indio_dev->setup_ops->postdisable)
> >>>                    indio_dev->setup_ops->postdisable(indio_dev);
> >>>     err_undo_config:
> >>> +       indio_dev->currentmode = INDIO_DIRECT_MODE;
> >>>            indio_dev->active_scan_mask = NULL;
> >>>
> >>>            return ret;
> >>> @@ -1080,8 +1079,6 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
> >>>                            ret = ret2;
> >>>            }
> >>>
> >>> -       indio_dev->currentmode = INDIO_DIRECT_MODE;
> >>> -
> >>>            if (indio_dev->setup_ops->postdisable) {
> >>>                    ret2 = indio_dev->setup_ops->postdisable(indio_dev);
> >>>                    if (ret2 && !ret)
> >>> @@ -1090,6 +1087,7 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
> >>>
> >>>            iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
> >>>            indio_dev->active_scan_mask = NULL;
> >>> +       indio_dev->currentmode = INDIO_DIRECT_MODE;
> >>>
> >>>            return ret;
> >>>     }
> >>> --
> >>> 2.17.1
> >>>  
> >>  
> >   
> 

