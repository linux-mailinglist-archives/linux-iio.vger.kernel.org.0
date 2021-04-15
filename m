Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C8360ED1
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhDOPVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbhDOPVM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:21:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F9FC061763;
        Thu, 15 Apr 2021 08:20:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b26so11132841pfr.3;
        Thu, 15 Apr 2021 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=umBbGUAcWrcnGAbWhTZRypZWZRPTnQBY0Pg5VVxN0NU=;
        b=j8JtVZdEfZvjgzlCRUWZnsT1XYSTKwNnzx1AlxBNWsV8wqVQ5yI1ITZpnTTZ7/M1Kf
         eLz5FWg9Khr1aCNThpw+mY1bpbzOtZkBSV9AxA5SONuE3rypEyv/PIU0dDQFJ04gGx3Y
         E974ZCEwm8UO31jg4AcdmN5qqRUvLnmVKpFWoWt73SEd1tFwu0tnXo5SUJ8ci7kdI4mE
         E53O53QfxrAr2liXsQyMVaiE5dgdazQBl68VtFH6Hmb4AeZaqKrbLzldrTPb7x5Of9cQ
         WHZIRusdNipMmKT0+yuyShdZ2bCs7uXepluojpVfHWspQSHydk5SgG6xerqcibc8H4YO
         bu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=umBbGUAcWrcnGAbWhTZRypZWZRPTnQBY0Pg5VVxN0NU=;
        b=sL/UwUQrf9hn+QXWo9hD5XL+WQUFxFodZ+W5o3+euvmeDuZwuLDDoeazJ3vtA3iOIO
         KwVBc6kNaA/wqP2ddV93DOJ7coyBSzg216wteJHffSgxJG7wTYwLbGFAdWljVDFZ+ezG
         WaszWjMkvPVpQmd6SPmIjLGmbbB8K/b0I3Q+gDmJm3WoO/h82kmJLlJ+Qp9tHXwBnysi
         AvmWfEgXiDK8LC3QM8faiSuSL5KLtVp0Vc88g5Stqe7BOEs2VzJAT6hRq7fSf6/nHPXr
         2MtJZC4mZYg+w6ri/sdCjE4Xi3Ha58ppyT9PjQBHdOT4STq6YRXjYheW81k9i2aB8o10
         +EqQ==
X-Gm-Message-State: AOAM530WJIhyIu15GrqLkHUN8tE3tTWY0nBKSityWvi1rbwHt0ki0IBL
        wnx3P3Md/+RweTXO2ax7v3k=
X-Google-Smtp-Source: ABdhPJwisj47l96nQA7bO6SGjtpW+hDMip4ZpK4dUx7XiRiSdphPBbq+tom71ZA18rPGQtyWtvtp+Q==
X-Received: by 2002:a63:9dc5:: with SMTP id i188mr3962509pgd.191.1618500042545;
        Thu, 15 Apr 2021 08:20:42 -0700 (PDT)
Received: from syed ([2401:4900:2eec:4193:f802:b600:e94c:55c4])
        by smtp.gmail.com with ESMTPSA id r1sm2905036pjo.26.2021.04.15.08.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 08:20:42 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:50:31 +0530
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
Subject: Re: [PATCH v10 19/33] counter: Standardize to ERANGE for limit
 exceeded errors
Message-ID: <20210415152031.GH8933@syed>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
 <f09068dd8b89aa81c4310ea39cbdb0d631dddf98.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09068dd8b89aa81c4310ea39cbdb0d631dddf98.1616150619.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 08:00:38PM +0900, William Breathitt Gray wrote:
> ERANGE is a semantically better error code to return when an argument
> value falls outside the supported limit range of a device.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/104-quad-8.c        | 6 +++---

For the 104-quad-8 driver:
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>

>  drivers/counter/interrupt-cnt.c     | 3 +++
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index b7d6c1c43655..0409b1771fd9 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -154,7 +154,7 @@ static int quad8_count_write(struct counter_device *counter,
>  
>  	/* Only 24-bit values are supported */
>  	if (val > 0xFFFFFF)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&priv->lock);
>  
> @@ -669,7 +669,7 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
>  
>  	/* Only 24-bit values are supported */
>  	if (preset > 0xFFFFFF)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&priv->lock);
>  
> @@ -714,7 +714,7 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>  
>  	/* Only 24-bit values are supported */
>  	if (ceiling > 0xFFFFFF)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&priv->lock);
>  
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 0e07607f2cd3..f27dea317965 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -107,6 +107,9 @@ static int interrupt_cnt_write(struct counter_device *counter,
>  {
>  	struct interrupt_cnt_priv *priv = counter->priv;
>  
> +	if (val != (typeof(priv->count.counter))val)
> +		return -ERANGE;
> +
>  	atomic_set(&priv->count, val);
>  
>  	return 0;
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 78f383b77bd2..49aeb9e393f3 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -283,7 +283,7 @@ static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
>  		return ret;
>  
>  	if (ceiling > STM32_LPTIM_MAX_ARR)
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	priv->ceiling = ceiling;
>  
> -- 
> 2.30.2
> 
