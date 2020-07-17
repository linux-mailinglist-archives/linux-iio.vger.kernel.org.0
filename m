Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D89224509
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGQUR3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 16:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGQUR2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 16:17:28 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450B5C0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 13:17:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so7199440pgq.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iywrvyPBUDOgHRTdq53ACuS34hQViRNteLGcc1mvGYA=;
        b=ZzQEnJsNJiKD1+yaEqf4xcmZtSkJVW4gUh/WVumhUke25claBLvOg39F57AjX/yF+t
         IvyVWmqsEW1BG1/7ICm+lb5tIZHbhj6w4nT+BPSJ6CibQrPdK+8W8oAm9ZV7+CSh3o1L
         9SBC3nq8OLCaa+A3fSH2QIaFY3KBeCMeHL73w5dOYvvE1PpkBGOCFRx8y6ZlQ31K2kAi
         ZxpJ9UEIW9v0vrZQNDYA2jBFcqpLUTC5ham8evExg5OaVhsyNcwqAZTR3fjV6lHUUC3g
         enqTg+ha9FChfUqjoDjg6uCiikxsYcZBbiKoKMsgyjIjrKE6ubdCgM7ABH06BNxm421j
         xWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iywrvyPBUDOgHRTdq53ACuS34hQViRNteLGcc1mvGYA=;
        b=NayWRwTEgxcybPRBc05FtAS5s2oKXpxVJrhcdD/WsVn679iNIqX77FTRZjy1BAE6Li
         vqIaUV5fmz3s8cBXLhhf3Nzabvx9IBLemz0fn5LUmx0rJkpIUtZ97GKmTXfXMEm8JMqP
         rgydE3965QvrmhoQkY1T3X5FUsAw+XitiI7kaUwOCKe6hG8pScQU4542uPWzjyb2wYlU
         dss5aVtj3VBbMopGEDiHXmhQlya7VIq4Jp+tPrZlRcPBbfSor3J1YFO7XfFdcm07i/1J
         T+rDH/D7R0GdPBd4b34B7xqK2pDxS2LoeYtDX6L3yxm9DiuwPs3pZbkeBQmq/n2HYzFA
         cWOw==
X-Gm-Message-State: AOAM531LSQetoS1mRJ/ZfDSch9Zz+uYCI6SoagUEG4nkhxQRm6LvzPxO
        JqycIbjUXFp6dP95aqS8B/4p74wm5cI=
X-Google-Smtp-Source: ABdhPJz7Sa8W0Soyk0M+slHFD6+b0FyIRfrfoarpP+teJuhSDo13gE34xXY80gmRSxgao04OxKIvOg==
X-Received: by 2002:a63:c150:: with SMTP id p16mr10228264pgi.141.1595017047679;
        Fri, 17 Jul 2020 13:17:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w12sm3084248pjb.18.2020.07.17.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:17:26 -0700 (PDT)
Date:   Fri, 17 Jul 2020 13:15:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 26/30] iio: adc: qcom-pm8xxx-xoadc: Demote standard
 comment block and supply missing description
Message-ID: <20200717201525.GK388985@builder.lan>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
 <20200717165538.3275050-27-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717165538.3275050-27-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri 17 Jul 09:55 PDT 2020, Lee Jones wrote:

> Kerneldoc is only suitable for documenting functions and struct/enums.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_INTERNAL' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_125V' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_INTERNAL_2' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:133: warning: Excess function parameter 'PM8XXX_CHANNEL_MUXOFF' description in 'PM8XXX_CHANNEL_INTERNAL'
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c:412: warning: Function parameter or member 'variant' not described in 'pm8xxx_xoadc'
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index c599ffa45a04c..cd5fa30e77df4 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -120,7 +120,7 @@
>  #define ADC_ARB_USRP_DATA0			0x19D
>  #define ADC_ARB_USRP_DATA1			0x19C
>  
> -/**
> +/*
>   * Physical channels which MUST exist on all PM variants in order to provide
>   * proper reference points for calibration.
>   *
> @@ -388,6 +388,7 @@ struct pm8xxx_chan_info {
>   * struct pm8xxx_xoadc - state container for the XOADC
>   * @dev: pointer to device
>   * @map: regmap to access registers
> + * @variant: XOADC variant characteristics
>   * @vref: reference voltage regulator
>   * characteristics of the channels, and sensible default settings
>   * @nchans: number of channels, configured by the device tree
> -- 
> 2.25.1
> 
