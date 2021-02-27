Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4A3326DBD
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhB0QMV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 11:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhB0QMG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 11:12:06 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE30A64E4D;
        Sat, 27 Feb 2021 16:11:21 +0000 (UTC)
Date:   Sat, 27 Feb 2021 16:11:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2] counter: stm32-timer-cnt: Report count function when
 SLAVE_MODE_DISABLED
Message-ID: <20210227161115.28fdda76@archlinux>
In-Reply-To: <d6ae294d-5d49-bb3f-6456-a485a247323c@foss.st.com>
References: <20210226012931.161429-1-vilhelm.gray@gmail.com>
        <d6ae294d-5d49-bb3f-6456-a485a247323c@foss.st.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Feb 2021 16:24:32 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 2/26/21 2:29 AM, William Breathitt Gray wrote:
> > When in SLAVE_MODE_DISABLED mode, the count still increases if the
> > counter is enabled because an internal clock is used. This patch fixes
> > the stm32_count_function_get() and stm32_count_function_set() functions
> > to properly handle this behavior.
> > 
> > Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> > Changes in v2:
> >  - Support an explicit 0 case for function_get()/function_set()
> > 
> >  drivers/counter/stm32-timer-cnt.c | 39 ++++++++++++++++++++-----------
> >  1 file changed, 25 insertions(+), 14 deletions(-)  
> 
> Hi William,
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> 
> Many thanks for this fix.
> Best Regards,
> Fabrice
> 
> 
> > 
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> > index ef2a974a2f10..cd50dc12bd02 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -44,13 +44,14 @@ struct stm32_timer_cnt {
> >   * @STM32_COUNT_ENCODER_MODE_3: counts on both TI1FP1 and TI2FP2 edges
> >   */
> >  enum stm32_count_function {
> > -	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
> > +	STM32_COUNT_SLAVE_MODE_DISABLED,
> >  	STM32_COUNT_ENCODER_MODE_1,
> >  	STM32_COUNT_ENCODER_MODE_2,
> >  	STM32_COUNT_ENCODER_MODE_3,
> >  };
> >  
> >  static enum counter_count_function stm32_count_functions[] = {
> > +	[STM32_COUNT_SLAVE_MODE_DISABLED] = COUNTER_COUNT_FUNCTION_INCREASE,
> >  	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> >  	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> >  	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> > @@ -90,6 +91,9 @@ static int stm32_count_function_get(struct counter_device *counter,
> >  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> >  
> >  	switch (smcr & TIM_SMCR_SMS) {
> > +	case 0:
> > +		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
> > +		return 0;
> >  	case 1:
> >  		*function = STM32_COUNT_ENCODER_MODE_1;
> >  		return 0;
> > @@ -99,9 +103,9 @@ static int stm32_count_function_get(struct counter_device *counter,
> >  	case 3:
> >  		*function = STM32_COUNT_ENCODER_MODE_3;
> >  		return 0;
> > +	default:
> > +		return -EINVAL;
> >  	}
> > -
> > -	return -EINVAL;
> >  }
> >  
> >  static int stm32_count_function_set(struct counter_device *counter,
> > @@ -112,6 +116,9 @@ static int stm32_count_function_set(struct counter_device *counter,
> >  	u32 cr1, sms;
> >  
> >  	switch (function) {
> > +	case STM32_COUNT_SLAVE_MODE_DISABLED:
> > +		sms = 0;
> > +		break;
> >  	case STM32_COUNT_ENCODER_MODE_1:
> >  		sms = 1;
> >  		break;
> > @@ -122,8 +129,7 @@ static int stm32_count_function_set(struct counter_device *counter,
> >  		sms = 3;
> >  		break;
> >  	default:
> > -		sms = 0;
> > -		break;
> > +		return -EINVAL;
> >  	}
> >  
> >  	/* Store enable status */
> > @@ -274,31 +280,36 @@ static int stm32_action_get(struct counter_device *counter,
> >  	size_t function;
> >  	int err;
> >  
> > -	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
> > -	*action = STM32_SYNAPSE_ACTION_NONE;
> > -
> >  	err = stm32_count_function_get(counter, count, &function);
> >  	if (err)
> > -		return 0;
> > +		return err;
> >  
> >  	switch (function) {
> > +	case STM32_COUNT_SLAVE_MODE_DISABLED:
> > +		/* counts on internal clock when CEN=1 */
> > +		*action = STM32_SYNAPSE_ACTION_NONE;
> > +		return 0;
> >  	case STM32_COUNT_ENCODER_MODE_1:
> >  		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
> >  		if (synapse->signal->id == count->synapses[0].signal->id)
> >  			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > -		break;
> > +		else
> > +			*action = STM32_SYNAPSE_ACTION_NONE;
> > +		return 0;
> >  	case STM32_COUNT_ENCODER_MODE_2:
> >  		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
> >  		if (synapse->signal->id == count->synapses[1].signal->id)
> >  			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > -		break;
> > +		else
> > +			*action = STM32_SYNAPSE_ACTION_NONE;
> > +		return 0;
> >  	case STM32_COUNT_ENCODER_MODE_3:
> >  		/* counts up/down on both TI1FP1 and TI2FP2 edges */
> >  		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > -		break;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> >  	}
> > -
> > -	return 0;
> >  }
> >  
> >  static const struct counter_ops stm32_timer_cnt_ops = {
> >   

