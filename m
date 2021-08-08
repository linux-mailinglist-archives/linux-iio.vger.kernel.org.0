Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444283E3BCD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhHHRGa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 13:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232013AbhHHRGa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 13:06:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76DF460E93;
        Sun,  8 Aug 2021 17:06:06 +0000 (UTC)
Date:   Sun, 8 Aug 2021 18:08:55 +0100
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
        jarkko.nikula@linux.intel.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v14 03/17] counter: Standardize to ERANGE for limit
 exceeded errors
Message-ID: <20210808180855.1251f06c@jic23-huawei>
In-Reply-To: <ae8d3b20b8b02c96b1c9898ffa2f9fa5d99edc81.1627990337.git.vilhelm.gray@gmail.com>
References: <cover.1627990337.git.vilhelm.gray@gmail.com>
        <ae8d3b20b8b02c96b1c9898ffa2f9fa5d99edc81.1627990337.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Aug 2021 21:06:13 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> ERANGE is a semantically better error code to return when an argument
> value falls outside the supported limit range of a device.
> 
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Just for the record, I'll note this is an ABI change.  However, I'm
fairly sure it's the category of no one will notice and so we are fine
to change it.

Applied,

Thanks,

Jonathan

> ---
>  drivers/counter/104-quad-8.c        | 6 +++---
>  drivers/counter/intel-qep.c         | 2 +-
>  drivers/counter/interrupt-cnt.c     | 3 +++
>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index b358b2b2b883..d54efdb8d393 100644
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
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 1a9512e28519..204f94577666 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -319,7 +319,7 @@ static ssize_t spike_filter_ns_write(struct counter_device *counter,
>  	}
>  
>  	if (length > INTEL_QEPFLT_MAX_COUNT(length))
> -		return -EINVAL;
> +		return -ERANGE;
>  
>  	mutex_lock(&qep->lock);
>  	if (qep->enabled) {
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 5df7cd13d4c7..66cac4900327 100644
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

