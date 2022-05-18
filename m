Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4526C52C184
	for <lists+linux-iio@lfdr.de>; Wed, 18 May 2022 19:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiERRbr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 May 2022 13:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbiERRbn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2022 13:31:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD635716C
        for <linux-iio@vger.kernel.org>; Wed, 18 May 2022 10:31:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so2786640pgc.1
        for <linux-iio@vger.kernel.org>; Wed, 18 May 2022 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7nZkxdMlNAebent6MVeqIF9QCrOvlXfT/nFFXjnb4U=;
        b=lAsGnOIMetgYtkKxz1F5DaAhhcMJ5NEsW3w/qmUaRW/URJyhrkwQ0iVXxlSaNLYnWF
         PAa0VOAi8NLKCZw6n/t+I004Gkb+0vryaNWGECdfOA7dJOK1abtWUwHNmF17RY1ZVDtX
         VnM5KklzCK751kmBv9BUlZUwVpGF+bkHYsmJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7nZkxdMlNAebent6MVeqIF9QCrOvlXfT/nFFXjnb4U=;
        b=USBmKuvneWncnAYY+xC3uNBdaV4H7XSh4By02E5LoYCgmHQI+X3gHZ9Cw9LlZ3PbIf
         x3hrWxOjjtS1+rO4LdN7fOuuBfAlTN++E0Avl6uZRYBCPMZTMAA6fE5sZ9btU4oZokm1
         Ok+9S8d6D9+P7wpvY9Ahes9fO0CFbhf/AE6N6FVRCESje2qfg9pPV5geh6kbVXeU6J9G
         dErRO+eYck4hID6A29UL4TU3Wm+mvNJRbgZQUOSCFin/MGtpAWj9ylNUm0SlneROC2yP
         URbFUqN4T2KrKa26TTeuIyfDoGKqjop5wV/UBPp5Lz1/NldWpLFEHgG8kzn2xzqJb8vh
         4Q1w==
X-Gm-Message-State: AOAM532uk2vqIQd0qOeWRHC1wdYDPDsqdXZfqb2Er1c+GT8yoQysJ5Xz
        EKMOrm42pa7y3rMM3N7uEf8SjA==
X-Google-Smtp-Source: ABdhPJw+gQrZdHM3wQLRgk3umwGTFFG++BT40NdPwBqQ77VJgi2mOe9c/8F3p2y3HMqxmgsPLUSGNQ==
X-Received: by 2002:a05:6a00:4515:b0:510:9ec3:e815 with SMTP id cw21-20020a056a00451500b005109ec3e815mr425834pfb.65.1652895101121;
        Wed, 18 May 2022 10:31:41 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:a14:3166:4b67:b688])
        by smtp.gmail.com with UTF8SMTPSA id 64-20020a621643000000b0050dc762819asm2231419pfw.116.2022.05.18.10.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 10:31:40 -0700 (PDT)
Date:   Wed, 18 May 2022 10:31:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuyq@stu.pku.edu.cn
Subject: Re: [PATCH] iio: vadc: Fix potential dereference of NULL pointer
Message-ID: <YoUtezVzsPB8MAEO@google.com>
References: <1652856180-100582-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1652856180-100582-1-git-send-email-lyz_cs@pku.edu.cn>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 17, 2022 at 11:43:00PM -0700, Yongzhi Liu wrote:
> The return value of vadc_get_channel() needs to be checked
> to avoid use of NULL pointer, which is followed by
> the caller 'vadc_do_conversion' of function 'vadc_configure'.
> Fix this by adding the null pointer check on prop
> in function 'vadc_configure'.
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 34202ba..d99bd72 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -210,6 +210,9 @@ static int vadc_configure(struct vadc_priv *vadc,
>  	u8 decimation, mode_ctrl;
>  	int ret;
>  
> +	if (!prop)
> +		return -ENODEV;
> +
>  	/* Mode selection */
>  	mode_ctrl = (VADC_OP_MODE_NORMAL << VADC_OP_MODE_SHIFT) |
>  		     VADC_ADC_TRIM_EN | VADC_AMUX_TRIM_EN;


Shouldn't the check be done in vadc_measure_ref_points() where 'prop' is
obtained, rather than deep down in the call chain? For example
vadc_do_conversion() would also dereference the NULL pointer unless one
of the prior function calls fails.
