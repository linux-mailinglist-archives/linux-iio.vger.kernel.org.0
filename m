Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B624015371F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2020 19:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBESAB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 13:00:01 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41180 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgBESAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 13:00:01 -0500
Received: by mail-yw1-f66.google.com with SMTP id l22so3182373ywc.8;
        Wed, 05 Feb 2020 10:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rRgXvPr3SwIij87seHPiKa5mQQ0rdFnyGB2bv1mFSf8=;
        b=Bk0/Cw3/MqA+hum9NqHHMRRRYzF3xdfomLI5myEg+7tMx0ZRORwJbupYsD5Fcx6/WZ
         +iTgQCiKWKSaAPUceVbmwxBP3dluyHQ+6itcBpIHPH0q6OoUk1GIhnSIFXyXx8F4s84y
         1QKv3u2CkJ4vqiaqrL+rDTyQ14PmxhCKsvjK/ky0/EuFW9l1Ze8Vnw29Zc/5/Pr4gVfw
         +4aXPQpSJi3RqV+SAES3L5WtWJN9Lo1Kz9EuSdnxMjYaE5HgsLMCcoyeqKiMvDaPV+eg
         t7eXrxmLxe12Pq8r+W4u487E9V0L5qQsikTa3ePAzgAfKaLzIBM8sWyHYe2UKPsCTdfA
         nL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rRgXvPr3SwIij87seHPiKa5mQQ0rdFnyGB2bv1mFSf8=;
        b=YY8JS2hmTBhs3xJA1D5HZJyDKluF9XWTA5y0Wxy9O/SenLNvJbdu19EYXef4lr7MiC
         aI1txX96nua+j8cv+3r9NzaKytPgahSblCiPd9gDO+qT8fQVZZUYMrlrOQZX4VUFc68f
         +MdscRQu+lA8Mq5GnOevXO9Nv2vtE//r2kxtDLYl0Jk0+jCFttGmP4BPQnPnCsQOOh3M
         1aWXYBIleO1agxqkpZsRBkdrpChvFbLTvlZw7fhXUKylXe4IncivEPWKq9SF/FaY15sm
         PediVI27q7OsHUv85U2m4aNNeFcSlS8RViwe+MnpzRqcZ0KRHTlJibqqMBsyOszKUuwt
         FknA==
X-Gm-Message-State: APjAAAU98uY82lF0/RxENilhXb81OoqfCRfGx04Gn+J43+PdFcOYWjvz
        GmxP0Tw4mnI76XgEwIY3maM9fEhjYv0=
X-Google-Smtp-Source: APXvYqxL/2f5r/cM0VlljtruqTfsVW5vkWvw0UbpVFlDnScpMN99cE8YToUz2/tGE3IbM8NbrZIfaw==
X-Received: by 2002:a81:11d7:: with SMTP id 206mr11978061ywr.150.1580925600074;
        Wed, 05 Feb 2020 10:00:00 -0800 (PST)
Received: from icarus (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id h203sm216399ywb.98.2020.02.05.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:59:59 -0800 (PST)
Date:   Wed, 5 Feb 2020 12:59:45 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org
Cc:     alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
        benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-timer-cnt: add power management support
Message-ID: <20200205175945.GA57132@icarus>
References: <1580899678-26393-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580899678-26393-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Feb 05, 2020 at 11:47:58AM +0100, Fabrice Gasnier wrote:
> Add suspend/resume PM sleep ops. When going to low power, enforce the
> counter isn't active.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

These changes are purely for the PM ops and don't involve the Counter
API, so I don't see any see any issues with this patch from my end.

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/stm32-timer-cnt.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 3eafcce..3b84503 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/types.h>
>  #include <linux/mfd/stm32-timers.h>
>  #include <linux/module.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  
>  #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
> @@ -358,10 +359,33 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>  	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
>  	priv->counter.priv = priv;
>  
> +	platform_set_drvdata(pdev, priv);
> +
>  	/* Register Counter device */
>  	return devm_counter_register(dev, &priv->counter);
>  }
>  
> +static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)
> +{
> +	struct stm32_timer_cnt *priv = dev_get_drvdata(dev);
> +	u32 cr1;
> +
> +	/* Check for active counter */
> +	regmap_read(priv->regmap, TIM_CR1, &cr1);
> +	if (cr1 & TIM_CR1_CEN)
> +		return -EBUSY;
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused stm32_timer_cnt_resume(struct device *dev)
> +{
> +	return pinctrl_pm_select_default_state(dev);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stm32_timer_cnt_pm_ops, stm32_timer_cnt_suspend,
> +			 stm32_timer_cnt_resume);
> +
>  static const struct of_device_id stm32_timer_cnt_of_match[] = {
>  	{ .compatible = "st,stm32-timer-counter", },
>  	{},
> @@ -373,6 +397,7 @@ static struct platform_driver stm32_timer_cnt_driver = {
>  	.driver = {
>  		.name = "stm32-timer-counter",
>  		.of_match_table = stm32_timer_cnt_of_match,
> +		.pm = &stm32_timer_cnt_pm_ops,
>  	},
>  };
>  module_platform_driver(stm32_timer_cnt_driver);
> -- 
> 2.7.4
> 
