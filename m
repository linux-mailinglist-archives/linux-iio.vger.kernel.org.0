Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E948A438A89
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJXQFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 12:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhJXQFu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 12:05:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBA7360F9C;
        Sun, 24 Oct 2021 16:03:27 +0000 (UTC)
Date:   Sun, 24 Oct 2021 17:07:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32: fix a leak by resetting pcsel before
 disabling vdda
Message-ID: <20211024170749.44c0d81f@jic23-huawei>
In-Reply-To: <77f3593a-0e94-f5ab-f102-86ba8d0f1a3b@foss.st.com>
References: <1634905169-23762-1-git-send-email-fabrice.gasnier@foss.st.com>
        <77f3593a-0e94-f5ab-f102-86ba8d0f1a3b@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Oct 2021 14:38:52 +0200
Olivier MOYSAN <olivier.moysan@foss.st.com> wrote:

I'll probably reword the description here as 'leak' tends to mean memory
leak rather than current.

> Hi Fabrice,
> 
> On 10/22/21 2:19 PM, Fabrice Gasnier wrote:
> > Some I/Os are connected to ADC input channels, when the corresponding bit
> > in PCSEL register are set on STM32H7 and STM32MP15. This is done in the
> > prepare routine of stm32-adc driver.
> > There are constraints here, as PCSEL shouldn't be set when VDDA supply
> > is disabled. Enabling/disabling of VDDA supply in done via stm32-adc-core
> > runtime PM routines (before/after ADC is enabled/disabled).
> > 
> > Currently, PCSEL remains set when disabling ADC. Later on, PM runtime
> > can disable the VDDA supply. This creates some conditions on I/Os that
> > can start to leak current.
> > So PCSEL needs to be cleared when disabling the ADC.
> > 
> > Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")
> > 

No line break here as Fixes forms part of the tag block.

> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Given timing wrt to being too near merge window, I'll let this it on
list a while longer as it'll be post rc1 material now anyway.

I can fix the above whilst applying if nothing else comes up.

Jonathan

> > ---
> >   drivers/iio/adc/stm32-adc.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index 5088de8..e3e7541 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -975,6 +975,7 @@ static void stm32h7_adc_unprepare(struct iio_dev *indio_dev)
> >   {
> >   	struct stm32_adc *adc = iio_priv(indio_dev);
> >   
> > +	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, 0);
> >   	stm32h7_adc_disable(indio_dev);
> >   	stm32h7_adc_enter_pwr_down(adc);
> >   }
> >   
> 
> Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> Thanks
> Olivier

