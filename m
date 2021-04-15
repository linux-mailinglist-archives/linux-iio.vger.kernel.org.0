Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09A2360ED6
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhDOPW0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhDOPVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:21:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4C1C061574;
        Thu, 15 Apr 2021 08:21:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n10so1107176plc.0;
        Thu, 15 Apr 2021 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbALUUk2SxXgau/iYTNOoDs9Qhfc0Z+i8E9uMnpeEUU=;
        b=sktvUIX+DjdfE0jemReuNriEYLHIsv3gV28Ii0dtgUrUjWxsOZoOec8MmMVjiKfmTZ
         OIWYrSHcAczXpx9yWGjBM5wqzBoIInKD4d0R1IS+KJkxYsI1D2nHtEcm6BxB46cWKnlR
         WbnSaRLQjZ6wVqrXYSZAp8JUuTxkMvoMVlT5XC6+7xDWuq9hzrzl0f+aT2UlNRqmQv8S
         SN5ODd4YO0S4r6LxTfLdsr43Rq5i/tc9IKD40X8kIijgn/MO1hBod8WgdMQtGusc/JlM
         zDoDFkMnCnWJpiJwsvOysvNrzGoK/uDLfDZPxtI7BmhQBDu5evxCJkgNUz1pmLyj/UQX
         9H6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbALUUk2SxXgau/iYTNOoDs9Qhfc0Z+i8E9uMnpeEUU=;
        b=oCUYUpBIv0ts2XYzNJK4mWvqcIQ1aLYh4KMei2hHpfSddIIhBgo/zOHHAdAzWGmR5s
         CniBNUgrap4fKnSEQ84KuQQ2urfhoEbR+TScWnGThDoqQMG2D7KPWV38wvnz+4oR+uVL
         ra/ZyNqr//pAlbC7QxL1hSRtveNkrZ2rw/A4Q4eomHWh0+BNLXzIHOyBv2nPuH/loyOs
         1Eo0aWK8LRwGQ+Zcor9phjd6/YTE7lygq5HXH7wWwTXr/OmLnUJv0xnRO34Ipn87LIoM
         DCwH6tFIgkwUy9QoMb+skEaecFOk/nqN6B2EGCoAbhOWdwgTPM+M3RoEtquZlkTRbJph
         zciQ==
X-Gm-Message-State: AOAM532ExIb3ec536fAqnjhzioF7dcG3sS4qgTS7VAUw50Fz6dA1HLEL
        XL0KHX9InQTTLWRFnzhNpPg=
X-Google-Smtp-Source: ABdhPJxSo2gXPLPT8jf7JLWOsxe4pFXobKGAGu1B2MIYZxSffE7+LoFjB/NLyOVLYFEMFOkjCGDkxw==
X-Received: by 2002:a17:902:e74f:b029:ea:f2b5:1add with SMTP id p15-20020a170902e74fb02900eaf2b51addmr4422425plf.29.1618500084741;
        Thu, 15 Apr 2021 08:21:24 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id d3sm2976332pjw.35.2021.04.15.08.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:21:24 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:51:13 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
Subject: Re: [PATCH v10 20/33] counter: Rename counter_signal_value to
 counter_signal_level
Message-ID: <20210415152113.GI8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <33a89af04c3dbba1c9d2f97927b7c2ffcd921af9.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a89af04c3dbba1c9d2f97927b7c2ffcd921af9.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:39PM +0900, William Breathitt Gray wrote:
> Signal values will always be levels so let's be explicit it about it to
> make the intent of the code clear.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c            |  5 +++--

For the 104-quad-8 driver:
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>

>  drivers/counter/counter.c               | 12 ++++++------
>  drivers/counter/interrupt-cnt.c         |  4 ++--
>  drivers/counter/microchip-tcb-capture.c |  4 ++--
>  include/linux/counter.h                 | 12 ++++++------
>  5 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 0409b1771fd9..fb0f021c0751 100644
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
> index f27dea317965..cce579c1c6ae 100644
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
> -- 
> 2.30.2
> 
