Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728AD43E343
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1ORY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhJ1ORX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:17:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E948160238;
        Thu, 28 Oct 2021 14:14:54 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:19:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32: fix a leak by resetting pcsel before
 disabling vdda
Message-ID: <20211028151921.761c1413@jic23-huawei>
In-Reply-To: <76ac386a-a748-f044-13c5-46b164738338@foss.st.com>
References: <1634905169-23762-1-git-send-email-fabrice.gasnier@foss.st.com>
        <77f3593a-0e94-f5ab-f102-86ba8d0f1a3b@foss.st.com>
        <20211024170749.44c0d81f@jic23-huawei>
        <76ac386a-a748-f044-13c5-46b164738338@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Oct 2021 09:43:10 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 10/24/21 6:07 PM, Jonathan Cameron wrote:
> > On Fri, 22 Oct 2021 14:38:52 +0200
> > Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:
> > 
> > I'll probably reword the description here as 'leak' tends to mean memory
> > leak rather than current.  
> 
> Hi Jonathan,
> 
> Yes, please fell free to improve this. I had the same concern, but I
> haven't found a more suitable description.

Added the word current to the title which I think makes it clear.
> 
> >   
> >> Hi Fabrice,
> >>
> >> On 10/22/21 2:19 PM, Fabrice Gasnier wrote:  
> >>> Some I/Os are connected to ADC input channels, when the corresponding bit
> >>> in PCSEL register are set on STM32H7 and STM32MP15. This is done in the
> >>> prepare routine of stm32-adc driver.
> >>> There are constraints here, as PCSEL shouldn't be set when VDDA supply
> >>> is disabled. Enabling/disabling of VDDA supply in done via stm32-adc-core
> >>> runtime PM routines (before/after ADC is enabled/disabled).
> >>>
> >>> Currently, PCSEL remains set when disabling ADC. Later on, PM runtime
> >>> can disable the VDDA supply. This creates some conditions on I/Os that
> >>> can start to leak current.
> >>> So PCSEL needs to be cleared when disabling the ADC.
> >>>
> >>> Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")
> >>>  
> > 
> > No line break here as Fixes forms part of the tag block.
> >   
> 
> Sorry, will check this next time.
> 
> >>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>  
> > 
> > Given timing wrt to being too near merge window, I'll let this it on
> > list a while longer as it'll be post rc1 material now anyway.
> > 
> > I can fix the above whilst applying if nothing else comes up.  
> 
> That's fine for me.

Applied to the fixes-togreg branch of iio.git, targeting a pull request
some time shortly after rc1.

Thanks,

Jonathan

> 
> Many thanks,
> Fabrice
> > 
> > Jonathan
> >   
> >>> ---
> >>>   drivers/iio/adc/stm32-adc.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> >>> index 5088de8..e3e7541 100644
> >>> --- a/drivers/iio/adc/stm32-adc.c
> >>> +++ b/drivers/iio/adc/stm32-adc.c
> >>> @@ -975,6 +975,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
> >>>   {
> >>>   	struct stm32_adc *adc = iio_priv(indio_dev);
> >>>   
> >>> +	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
> >>>   	stm32h7_adc_disable(indio_dev);
> >>>   	stm32h7_adc_enter_pwr_down(adc);
> >>>   }
> >>>     
> >>
> >> Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> >>
> >> Thanks
> >> Olivier  
> >   

