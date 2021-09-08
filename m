Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C8403E52
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350194AbhIHR2y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 13:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhIHR2y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Sep 2021 13:28:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F19A60EBA;
        Wed,  8 Sep 2021 17:27:39 +0000 (UTC)
Date:   Wed, 8 Sep 2021 18:31:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <kernel@pengutronix.de>, <a.fatoum@pengutronix.de>,
        <kamel.bouhara@bootlin.com>, <gwendal@chromium.org>,
        <alexandre.belloni@bootlin.com>, <david@lechnology.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <syednwaris@gmail.com>,
        <patrick.havelange@essensium.com>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <o.rempel@pengutronix.de>, <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v16 01/14] counter: stm32-lptimer-cnt: Provide defines
 for clock polarities
Message-ID: <20210908183105.062869dd@jic23-huawei>
In-Reply-To: <ec80f7a8-5f2e-522f-6a66-ab25092618c2@foss.st.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
        <a111c8905c467805ca530728f88189b59430f27e.1630031207.git.vilhelm.gray@gmail.com>
        <ec80f7a8-5f2e-522f-6a66-ab25092618c2@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 15:38:50 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 8/27/21 5:47 AM, William Breathitt Gray wrote:
> > The STM32 low-power timer permits configuration of the clock polarity
> > via the LPTIMX_CFGR register CKPOL bits. This patch provides
> > preprocessor defines for the supported clock polarities.
> > 
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/counter/stm32-lptimer-cnt.c | 6 +++---
> >  include/linux/mfd/stm32-lptimer.h   | 5 +++++
> >  2 files changed, 8 insertions(+), 3 deletions(-)  
> 
> Hi William,
> 
> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied to the togreg branch of iio.git and push out as testing for all the normal reasons

> 
> Thanks,
> Fabrice
> 
> > 
> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> > index 13656957c45f..7367f46c6f91 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -140,9 +140,9 @@ static const enum counter_function stm32_lptim_cnt_functions[] = {
> >  };
> >  
> >  enum stm32_lptim_synapse_action {
> > -	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> > -	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> > -	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> > +	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE = STM32_LPTIM_CKPOL_RISING_EDGE,
> > +	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE = STM32_LPTIM_CKPOL_FALLING_EDGE,
> > +	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES = STM32_LPTIM_CKPOL_BOTH_EDGES,
> >  	STM32_LPTIM_SYNAPSE_ACTION_NONE,
> >  };
> >  
> > diff --git a/include/linux/mfd/stm32-lptimer.h b/include/linux/mfd/stm32-lptimer.h
> > index 90b20550c1c8..06d3f11dc3c9 100644
> > --- a/include/linux/mfd/stm32-lptimer.h
> > +++ b/include/linux/mfd/stm32-lptimer.h
> > @@ -45,6 +45,11 @@
> >  #define STM32_LPTIM_PRESC	GENMASK(11, 9)
> >  #define STM32_LPTIM_CKPOL	GENMASK(2, 1)
> >  
> > +/* STM32_LPTIM_CKPOL */
> > +#define STM32_LPTIM_CKPOL_RISING_EDGE	0
> > +#define STM32_LPTIM_CKPOL_FALLING_EDGE	1
> > +#define STM32_LPTIM_CKPOL_BOTH_EDGES	2
> > +
> >  /* STM32_LPTIM_ARR */
> >  #define STM32_LPTIM_MAX_ARR	0xFFFF
> >  
> >   

