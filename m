Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA23E3BD3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhHHRIM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 13:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhHHRIL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 13:08:11 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FF060E93;
        Sun,  8 Aug 2021 17:07:47 +0000 (UTC)
Date:   Sun, 8 Aug 2021 18:10:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v14 04/17] counter: Rename counter_signal_value to
 counter_signal_level
Message-ID: <20210808181037.3016bb00@jic23-huawei>
In-Reply-To: <3f17010abe2415859cea9a5fddabd3c97f635ff5.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
        <3f17010abe2415859cea9a5fddabd3c97f635ff5.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Aug 2021 21:06:14 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Signal values will always be levels so let's be explicit it about it to
> make the intent of the code clear.
> 
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Applied.
> ---
>  drivers/counter/104-quad-8.c            |  5 +++--
>  drivers/counter/counter.c               | 12 ++++++------
>  drivers/counter/interrupt-cnt.c         |  4 ++--
>  drivers/counter/microchip-tcb-capture.c |  4 ++--
>  include/linux/counter.h                 | 12 ++++++------
>  5 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index d54efdb8d393..b4dd07cf51eb 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -97,7 +97,8 @@ struct quad8 {
>  #define QUAD8_CMR_QUADRATURE_X4 0x18
>  
>  static int quad8_signal_read(struct counter_device *counter,
> -	struct counter_signal *signal, enum counter_signal_value *val)
> +			     struct counter_signal *signal,
> +			     enum counter_signal_level *level)
>  {
>  	const struct quad8 *const priv = counter->priv;
>  	unsigned int state;
> @@ -109,7 +110,7 @@ static int quad8_signal_read(struct counter_device *counter,
>  	state = inb(priv->base + QUAD8_REG_INDEX_INPUT_LEVELS)
>  		& BIT(signal->id - 16);
>  
> -	*val = (state) ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +	*level = (state) ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
>  
>  	return 0;
>  }
> diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> index 6a683d086008..cb92673552b5 100644
> --- a/drivers/counter/counter.c
> +++ b/drivers/counter/counter.c
> @@ -289,9 +289,9 @@ struct counter_signal_unit {
>  	struct counter_signal *signal;
>  };
>  
> -static const char *const counter_signal_value_str[] = {
> -	[COUNTER_SIGNAL_LOW] = "low",
> -	[COUNTER_SIGNAL_HIGH] = "high"
> +static const char *const counter_signal_level_str[] = {
> +	[COUNTER_SIGNAL_LEVEL_LOW] = "low",
> +	[COUNTER_SIGNAL_LEVEL_HIGH] = "high"
>  };
>  
>  static ssize_t counter_signal_show(struct device *dev,
> @@ -302,13 +302,13 @@ static ssize_t counter_signal_show(struct device *dev,
>  	const struct counter_signal_unit *const component = devattr->component;
>  	struct counter_signal *const signal = component->signal;
>  	int err;
> -	enum counter_signal_value val;
> +	enum counter_signal_level level;
>  
> -	err = counter->ops->signal_read(counter, signal, &val);
> +	err = counter->ops->signal_read(counter, signal, &level);
>  	if (err)
>  		return err;
>  
> -	return sprintf(buf, "%s\n", counter_signal_value_str[val]);
> +	return sprintf(buf, "%s\n", counter_signal_level_str[level]);
>  }
>  
>  struct counter_name_unit {
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 66cac4900327..d06367bef8f0 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -130,7 +130,7 @@ static int interrupt_cnt_function_get(struct counter_device *counter,
>  
>  static int interrupt_cnt_signal_read(struct counter_device *counter,
>  				     struct counter_signal *signal,
> -				     enum counter_signal_value *val)
> +				     enum counter_signal_level *level)
>  {
>  	struct interrupt_cnt_priv *priv = counter->priv;
>  	int ret;
> @@ -142,7 +142,7 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
>  	if (ret < 0)
>  		return ret;
>  
> -	*val = ret ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +	*level = ret ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
>  
>  	return 0;
>  }
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 0c9a61962911..6be3adf74114 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -158,7 +158,7 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
>  
>  static int mchp_tc_count_signal_read(struct counter_device *counter,
>  				     struct counter_signal *signal,
> -				     enum counter_signal_value *val)
> +				     enum counter_signal_level *lvl)
>  {
>  	struct mchp_tc_data *const priv = counter->priv;
>  	bool sigstatus;
> @@ -171,7 +171,7 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
>  	else
>  		sigstatus = (sr & ATMEL_TC_MTIOA);
>  
> -	*val = sigstatus ? COUNTER_SIGNAL_HIGH : COUNTER_SIGNAL_LOW;
> +	*lvl = sigstatus ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
>  
>  	return 0;
>  }
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 9dbd5df4cd34..79f5dcaf6ba0 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -290,16 +290,16 @@ struct counter_device_state {
>  	const struct attribute_group **groups;
>  };
>  
> -enum counter_signal_value {
> -	COUNTER_SIGNAL_LOW = 0,
> -	COUNTER_SIGNAL_HIGH
> +enum counter_signal_level {
> +	COUNTER_SIGNAL_LEVEL_LOW,
> +	COUNTER_SIGNAL_LEVEL_HIGH,
>  };
>  
>  /**
>   * struct counter_ops - Callbacks from driver
>   * @signal_read:	optional read callback for Signal attribute. The read
> - *			value of the respective Signal should be passed back via
> - *			the val parameter.
> + *			level of the respective Signal should be passed back via
> + *			the level parameter.
>   * @count_read:		optional read callback for Count attribute. The read
>   *			value of the respective Count should be passed back via
>   *			the val parameter.
> @@ -324,7 +324,7 @@ enum counter_signal_value {
>  struct counter_ops {
>  	int (*signal_read)(struct counter_device *counter,
>  			   struct counter_signal *signal,
> -			   enum counter_signal_value *val);
> +			   enum counter_signal_level *level);
>  	int (*count_read)(struct counter_device *counter,
>  			  struct counter_count *count, unsigned long *val);
>  	int (*count_write)(struct counter_device *counter,

