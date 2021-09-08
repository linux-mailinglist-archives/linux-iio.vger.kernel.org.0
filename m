Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F294F403E56
	for <lists+linux-iio@lfdr.de>; Wed,  8 Sep 2021 19:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350229AbhIHR3h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 13:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhIHR3g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Sep 2021 13:29:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C68961157;
        Wed,  8 Sep 2021 17:28:21 +0000 (UTC)
Date:   Wed, 8 Sep 2021 18:31:49 +0100
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
Subject: Re: [PATCH v16 02/14] counter: stm32-timer-cnt: Provide defines for
 slave mode selection
Message-ID: <20210908183149.468e60ac@jic23-huawei>
In-Reply-To: <ad245fd3-5751-08e6-3f3a-30522822f0af@foss.st.com>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
        <ad3d9cd7af580d586316d368f74964cbc394f981.1630031207.git.vilhelm.gray@gmail.com>
        <ad245fd3-5751-08e6-3f3a-30522822f0af@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 15:40:37 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 8/27/21 5:47 AM, William Breathitt Gray wrote:
> > The STM32 timer permits configuration of the counter encoder mode via
> > the slave mode control register (SMCR) slave mode selection (SMS) bits.
> > This patch provides preprocessor defines for the supported encoder
> > modes.
> > 
> > Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 16 ++++++++--------
> >  include/linux/mfd/stm32-timers.h  |  4 ++++
> >  2 files changed, 12 insertions(+), 8 deletions(-)  
> 
> Hi William,
> 
> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied.

Thanks,

J
> 
> Thanks,
> Fabrice
> 
> > 
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> > index 3fb0debd7425..1fbc46f4ee66 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -93,16 +93,16 @@ static int stm32_count_function_get(struct counter_device *counter,
> >  	regmap_read(priv->regmap, TIM_SMCR, &smcr);
> >  
> >  	switch (smcr & TIM_SMCR_SMS) {
> > -	case 0:
> > +	case TIM_SMCR_SMS_SLAVE_MODE_DISABLED:
> >  		*function = STM32_COUNT_SLAVE_MODE_DISABLED;
> >  		return 0;
> > -	case 1:
> > +	case TIM_SMCR_SMS_ENCODER_MODE_1:
> >  		*function = STM32_COUNT_ENCODER_MODE_1;
> >  		return 0;
> > -	case 2:
> > +	case TIM_SMCR_SMS_ENCODER_MODE_2:
> >  		*function = STM32_COUNT_ENCODER_MODE_2;
> >  		return 0;
> > -	case 3:
> > +	case TIM_SMCR_SMS_ENCODER_MODE_3:
> >  		*function = STM32_COUNT_ENCODER_MODE_3;
> >  		return 0;
> >  	default:
> > @@ -119,16 +119,16 @@ static int stm32_count_function_set(struct counter_device *counter,
> >  
> >  	switch (function) {
> >  	case STM32_COUNT_SLAVE_MODE_DISABLED:
> > -		sms = 0;
> > +		sms = TIM_SMCR_SMS_SLAVE_MODE_DISABLED;
> >  		break;
> >  	case STM32_COUNT_ENCODER_MODE_1:
> > -		sms = 1;
> > +		sms = TIM_SMCR_SMS_ENCODER_MODE_1;
> >  		break;
> >  	case STM32_COUNT_ENCODER_MODE_2:
> > -		sms = 2;
> > +		sms = TIM_SMCR_SMS_ENCODER_MODE_2;
> >  		break;
> >  	case STM32_COUNT_ENCODER_MODE_3:
> > -		sms = 3;
> > +		sms = TIM_SMCR_SMS_ENCODER_MODE_3;
> >  		break;
> >  	default:
> >  		return -EINVAL;
> > diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
> > index f8db83aedb2b..5f5c43fd69dd 100644
> > --- a/include/linux/mfd/stm32-timers.h
> > +++ b/include/linux/mfd/stm32-timers.h
> > @@ -82,6 +82,10 @@
> >  #define MAX_TIM_ICPSC		0x3
> >  #define TIM_CR2_MMS_SHIFT	4
> >  #define TIM_CR2_MMS2_SHIFT	20
> > +#define TIM_SMCR_SMS_SLAVE_MODE_DISABLED	0 /* counts on internal clock when CEN=1 */
> > +#define TIM_SMCR_SMS_ENCODER_MODE_1		1 /* counts TI1FP1 edges, depending on TI2FP2 level */
> > +#define TIM_SMCR_SMS_ENCODER_MODE_2		2 /* counts TI2FP2 edges, depending on TI1FP1 level */
> > +#define TIM_SMCR_SMS_ENCODER_MODE_3		3 /* counts on both TI1FP1 and TI2FP2 edges */
> >  #define TIM_SMCR_TS_SHIFT	4
> >  #define TIM_BDTR_BKF_MASK	0xF
> >  #define TIM_BDTR_BKF_SHIFT(x)	(16 + (x) * 4)
> >   

