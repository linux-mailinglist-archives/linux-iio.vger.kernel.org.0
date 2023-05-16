Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E07047A9
	for <lists+linux-iio@lfdr.de>; Tue, 16 May 2023 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjEPIWr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 May 2023 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjEPIWk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2023 04:22:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2949B
        for <linux-iio@vger.kernel.org>; Tue, 16 May 2023 01:22:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so43085375e9.2
        for <linux-iio@vger.kernel.org>; Tue, 16 May 2023 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684225355; x=1686817355;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tpLX8Svr1/hDnROP2r+zi8Bzotl7nD1x9jwIltUx3rY=;
        b=V4G/vHUswI8fobflebz4roVsEnsRIW3HmACHq8dZY3Gmmqczsk4xkVgUYCMX9WHi+l
         2L6pSWm6gzDFXupXRvv2/E9bpsWlRPSsBT0FKdE9/jMhPFrIrdWCxd05IgBs1OH1o0Qn
         vHKM7rqYypTrTt0cDnKleQED5uFTCKiOpQL5KWjayyxv+NvF9q4XNQ8igNrUcVaGsTYK
         dBvkSYAeq/8dn8ibWayt3XYtxCxo7JscCWbh6sgJdeFPCG+x1SAUGN434LTNdB/T7DVE
         TUk7OFTMjSUGHyElneiGUcZPvz8EM6pfzuVxcMC+AivQz73rBV50idCqvx+xjTNfP7I3
         ey9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225355; x=1686817355;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpLX8Svr1/hDnROP2r+zi8Bzotl7nD1x9jwIltUx3rY=;
        b=boY4W9jcvxJC04ge5dxv9CZrJqAwHosTgWGrl5BdstjCrQth0uJ0pYfgZGInwWsRvc
         /nPCYaS0qjxMcvfOcPIgpNUbXGhltxAPObdd0y5rRuibi3s+/9lwAozuloGodASXmHXM
         bJ8uIV8Z0x4DhZ/Z6taPZlkkv//UXOS01opy4cRVaf4/dVMuVj2bhQXxCum6ILPSRQz3
         AJOz9NKl1mMWPU5Wv6bd3G3HS9E70D+xVV86c7nlc4gDpKmAVDoUEGxYwyBRflFi+PVF
         2ICgsTE3aWF5wR+aw77ccWRqxQOYgcKeNcDgzfrGJ0u+JZhZ3iyYje3QiE/C8tEkJQnD
         skTw==
X-Gm-Message-State: AC+VfDwSErPkD9cDv/g3fU3oj8kLYTonuWf5VDljEEr428wnmuJoWdrP
        y4wtBhWZyNSEuYZHmcNZdQA/MdUG7ogdYA22+AHUJA==
X-Google-Smtp-Source: ACHHUZ6IEoiK7nz633paQUNUR+x3TKc/LG/U/kEjia8UrYTb0H6tD/jS4ljplGvyWEx2mfWC3K/MNQ==
X-Received: by 2002:a1c:f418:0:b0:3f1:6f52:74d with SMTP id z24-20020a1cf418000000b003f16f52074dmr24392159wma.39.1684225354916;
        Tue, 16 May 2023 01:22:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id q14-20020adfdfce000000b00304ae802f02sm1709723wrn.66.2023.05.16.01.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:22:34 -0700 (PDT)
Message-ID: <23cb7112-ce2e-cee6-2213-60fd599c998d@linaro.org>
Date:   Tue, 16 May 2023 10:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
Content-Language: en-US
To:     George Stark <gnstark@sberdevices.ru>, jic23@kernel.org,
        lars@metafoo.de, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, andy.shevchenko@gmail.com,
        nuno.sa@analog.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230515210545.2100161-1-gnstark@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15/05/2023 23:05, George Stark wrote:
> From: George Stark <GNStark@sberdevices.ru>
> 
> According to datasheets of supported meson SOCs
> length of ADC_CLK_DIV field is 6 bits long
> 
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> ---
>   drivers/iio/adc/meson_saradc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 85b6826cc10c..b93ff42b8c19 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -72,7 +72,7 @@
>   	#define MESON_SAR_ADC_REG3_PANEL_DETECT_COUNT_MASK	GENMASK(20, 18)
>   	#define MESON_SAR_ADC_REG3_PANEL_DETECT_FILTER_TB_MASK	GENMASK(17, 16)
>   	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT		10
> -	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		5
> +	#define MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH		6
>   	#define MESON_SAR_ADC_REG3_BLOCK_DLY_SEL_MASK		GENMASK(9, 8)
>   	#define MESON_SAR_ADC_REG3_BLOCK_DLY_MASK		GENMASK(7, 0)
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
