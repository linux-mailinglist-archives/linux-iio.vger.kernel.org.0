Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EDA15FFB2
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgBOSfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgBOSff (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:35:35 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7237206D6;
        Sat, 15 Feb 2020 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581791734;
        bh=zmbBSlGL12WwCliK8pDKydPvO9rp7EAjBk6zkCOQsog=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=frBXbW5sJuaRiGxP5gWWww/3Da9I7nCnmtr1HFSxnJNR574UwDY9nCV+OLuc5APAz
         3MZLbg26uqKNoM6y9tMh5TxJYjdbc0sOoyPq01Bo6y/745iuqLLOop/YH8SMCnnvS7
         kqjGETqZfVN799oGAlsKMKUpKXX6d/be1CQ4pjfw=
Date:   Sat, 15 Feb 2020 18:35:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3] iio: trigger: stm32-timer: enable clock when in
 master mode
Message-ID: <20200215183529.7413d1c0@archlinux>
In-Reply-To: <1581697437-25707-1-git-send-email-fabrice.gasnier@st.com>
References: <1581697437-25707-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Feb 2020 17:23:57 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Clock should be enabled as soon as using master modes, even before
> enabling timer. Or, this may provoke bad behavior on the other end
> (slave timer). Then, introduce 'clk_enabled' flag, instead of relying
> on CR1 EN bit, to keep track of clock being enabled (balanced refcount).
> Propagate this anywhere else in the driver.
> 
> Also add 'remove' routine to stop timer and disable clock in case it
> has been left enabled. Enforce the user interface has been unregistered
> in the remove routine, before disabling the hardware to avoid possible
> race. So, remove use of devm_ variant to register triggers and unregister
> them before the hardware gets disabled [1].
> [1] https://patchwork.kernel.org/patch/9956247/
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,
Jonathan

> ---
> Changes in v3:
> - rebase on top of latest iio tree
> 
> Changes in v2:
> - enforce the user interface has been unregistered in the remove routine,
>   before disabling the hardware to avoid possible race.
> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 98 ++++++++++++++++++++++++-------
>  1 file changed, 76 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index 2e0d32a..16a3b6b 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -79,10 +79,13 @@ struct stm32_timer_trigger {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct clk *clk;
> +	bool clk_enabled;
>  	u32 max_arr;
>  	const void *triggers;
>  	const void *valids;
>  	bool has_trgo2;
> +	struct mutex lock; /* concurrent sysfs configuration */
> +	struct list_head tr_list;
>  };
>  
>  struct stm32_timer_trigger_cfg {
> @@ -106,7 +109,7 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  {
>  	unsigned long long prd, div;
>  	int prescaler = 0;
> -	u32 ccer, cr1;
> +	u32 ccer;
>  
>  	/* Period and prescaler values depends of clock rate */
>  	div = (unsigned long long)clk_get_rate(priv->clk);
> @@ -136,9 +139,11 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  	if (ccer & TIM_CCER_CCXE)
>  		return -EBUSY;
>  
> -	regmap_read(priv->regmap, TIM_CR1, &cr1);
> -	if (!(cr1 & TIM_CR1_CEN))
> +	mutex_lock(&priv->lock);
> +	if (!priv->clk_enabled) {
> +		priv->clk_enabled = true;
>  		clk_enable(priv->clk);
> +	}
>  
>  	regmap_write(priv->regmap, TIM_PSC, prescaler);
>  	regmap_write(priv->regmap, TIM_ARR, prd - 1);
> @@ -157,22 +162,20 @@ static int stm32_timer_start(struct stm32_timer_trigger *priv,
>  
>  	/* Enable controller */
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, TIM_CR1_CEN);
> +	mutex_unlock(&priv->lock);
>  
>  	return 0;
>  }
>  
>  static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  {
> -	u32 ccer, cr1;
> +	u32 ccer;
>  
>  	regmap_read(priv->regmap, TIM_CCER, &ccer);
>  	if (ccer & TIM_CCER_CCXE)
>  		return;
>  
> -	regmap_read(priv->regmap, TIM_CR1, &cr1);
> -	if (cr1 & TIM_CR1_CEN)
> -		clk_disable(priv->clk);
> -
> +	mutex_lock(&priv->lock);
>  	/* Stop timer */
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
>  	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> @@ -181,6 +184,12 @@ static void stm32_timer_stop(struct stm32_timer_trigger *priv)
>  
>  	/* Make sure that registers are updated */
>  	regmap_update_bits(priv->regmap, TIM_EGR, TIM_EGR_UG, TIM_EGR_UG);
> +
> +	if (priv->clk_enabled) {
> +		priv->clk_enabled = false;
> +		clk_disable(priv->clk);
> +	}
> +	mutex_unlock(&priv->lock);
>  }
>  
>  static ssize_t stm32_tt_store_frequency(struct device *dev,
> @@ -295,8 +304,15 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  	for (i = 0; i <= master_mode_max; i++) {
>  		if (!strncmp(master_mode_table[i], buf,
>  			     strlen(master_mode_table[i]))) {
> +			mutex_lock(&priv->lock);
> +			if (!priv->clk_enabled) {
> +				/* Clock should be enabled first */
> +				priv->clk_enabled = true;
> +				clk_enable(priv->clk);
> +			}
>  			regmap_update_bits(priv->regmap, TIM_CR2, mask,
>  					   i << shift);
> +			mutex_unlock(&priv->lock);
>  			return len;
>  		}
>  	}
> @@ -354,11 +370,21 @@ static const struct attribute_group *stm32_trigger_attr_groups[] = {
>  static const struct iio_trigger_ops timer_trigger_ops = {
>  };
>  
> -static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
> +static void stm32_unregister_iio_triggers(struct stm32_timer_trigger *priv)
> +{
> +	struct iio_trigger *tr;
> +
> +	list_for_each_entry(tr, &priv->tr_list, alloc_list)
> +		iio_trigger_unregister(tr);
> +}
> +
> +static int stm32_register_iio_triggers(struct stm32_timer_trigger *priv)
>  {
>  	int ret;
>  	const char * const *cur = priv->triggers;
>  
> +	INIT_LIST_HEAD(&priv->tr_list);
> +
>  	while (cur && *cur) {
>  		struct iio_trigger *trig;
>  		bool cur_is_trgo = stm32_timer_is_trgo_name(*cur);
> @@ -385,9 +411,13 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
>  
>  		iio_trigger_set_drvdata(trig, priv);
>  
> -		ret = devm_iio_trigger_register(priv->dev, trig);
> -		if (ret)
> +		ret = iio_trigger_register(trig);
> +		if (ret) {
> +			stm32_unregister_iio_triggers(priv);
>  			return ret;
> +		}
> +
> +		list_add_tail(&trig->alloc_list, &priv->tr_list);
>  		cur++;
>  	}
>  
> @@ -434,7 +464,6 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  				   int val, int val2, long mask)
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> -	u32 dat;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -445,19 +474,23 @@ static int stm32_counter_write_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  
>  	case IIO_CHAN_INFO_ENABLE:
> +		mutex_lock(&priv->lock);
>  		if (val) {
> -			regmap_read(priv->regmap, TIM_CR1, &dat);
> -			if (!(dat & TIM_CR1_CEN))
> +			if (!priv->clk_enabled) {
> +				priv->clk_enabled = true;
>  				clk_enable(priv->clk);
> +			}
>  			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  					   TIM_CR1_CEN);
>  		} else {
> -			regmap_read(priv->regmap, TIM_CR1, &dat);
>  			regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN,
>  					   0);
> -			if (dat & TIM_CR1_CEN)
> +			if (priv->clk_enabled) {
> +				priv->clk_enabled = false;
>  				clk_disable(priv->clk);
> +			}
>  		}
> +		mutex_unlock(&priv->lock);
>  		return 0;
>  	}
>  
> @@ -553,7 +586,6 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  {
>  	struct stm32_timer_trigger *priv = iio_priv(indio_dev);
>  	int sms = stm32_enable_mode2sms(mode);
> -	u32 val;
>  
>  	if (sms < 0)
>  		return sms;
> @@ -561,11 +593,12 @@ static int stm32_set_enable_mode(struct iio_dev *indio_dev,
>  	 * Triggered mode sets CEN bit automatically by hardware. So, first
>  	 * enable counter clock, so it can use it. Keeps it in sync with CEN.
>  	 */
> -	if (sms == 6) {
> -		regmap_read(priv->regmap, TIM_CR1, &val);
> -		if (!(val & TIM_CR1_CEN))
> -			clk_enable(priv->clk);
> +	mutex_lock(&priv->lock);
> +	if (sms == 6 && !priv->clk_enabled) {
> +		clk_enable(priv->clk);
> +		priv->clk_enabled = true;
>  	}
> +	mutex_unlock(&priv->lock);
>  
>  	regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS, sms);
>  
> @@ -749,8 +782,9 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	priv->triggers = triggers_table[index];
>  	priv->valids = cfg->valids_table[index];
>  	stm32_timer_detect_trgo2(priv);
> +	mutex_init(&priv->lock);
>  
> -	ret = stm32_setup_iio_triggers(priv);
> +	ret = stm32_register_iio_triggers(priv);
>  	if (ret)
>  		return ret;
>  
> @@ -759,6 +793,25 @@ static int stm32_timer_trigger_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int stm32_timer_trigger_remove(struct platform_device *pdev)
> +{
> +	struct stm32_timer_trigger *priv = platform_get_drvdata(pdev);
> +	u32 val;
> +
> +	/* Unregister triggers before everything can be safely turned off */
> +	stm32_unregister_iio_triggers(priv);
> +
> +	/* Check if nobody else use the timer, then disable it */
> +	regmap_read(priv->regmap, TIM_CCER, &val);
> +	if (!(val & TIM_CCER_CCXE))
> +		regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_CEN, 0);
> +
> +	if (priv->clk_enabled)
> +		clk_disable(priv->clk);
> +
> +	return 0;
> +}
> +
>  static const struct stm32_timer_trigger_cfg stm32_timer_trg_cfg = {
>  	.valids_table = valids_table,
>  	.num_valids_table = ARRAY_SIZE(valids_table),
> @@ -783,6 +836,7 @@ MODULE_DEVICE_TABLE(of, stm32_trig_of_match);
>  
>  static struct platform_driver stm32_timer_trigger_driver = {
>  	.probe = stm32_timer_trigger_probe,
> +	.remove = stm32_timer_trigger_remove,
>  	.driver = {
>  		.name = "stm32-timer-trigger",
>  		.of_match_table = stm32_trig_of_match,

