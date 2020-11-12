Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F63E2B040E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 12:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKLLkn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgKLLjv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 06:39:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465DC0613D1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 03:39:50 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r17so5686575wrw.1
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2020 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2yBcVMAYM89L0pNLBwjheCruacUb1pfQ9rLevl8WsAY=;
        b=VSkYtzoOqhMtvfFhicPy+3lWsCsFM9Uh8TuGet56GZJ4a9nfE1itQ035jgyaMj/xiD
         /TQ+HpkdB0CSlr7avcMiGDMZSF+7MTVaRIl1MC8XiDyYLWmOkHby8A0YLw3rYH/9Z3Pi
         bCusMAsHOvfwUp74mj8MitYrvJhW8AYjTo61vq277NtLIjzpvRYZ+Db1Zze2n+FPBDwS
         XW/eDowiePzjNJy8tcWGVBaquOA6ZTo++ad98vhu6PwpQKl3A4fxSobPXgAdvQ9WcBcd
         7RociI45MNzu8Jo0RHLhieurWEeUXeAC/fGbL1j1vUSRGttvkvWzcWYpo82IWJ4MIFq7
         CEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2yBcVMAYM89L0pNLBwjheCruacUb1pfQ9rLevl8WsAY=;
        b=sXRy/rgVlCIcDmu0WQhBmESSZRkLYzlwTIKJwxDT3H5YBFiSLxL28nm1NNbBc9PUrA
         KYw53J+JKyMlH6fOdE5wJW8IuE5hvlFxSd+31Oai9218vSYKZh45eIgd7ikE2pULA15L
         zC0jBNOBzmnvPxxUz6D0sx4jkirZp4MvaJK25w1TErtvkmCi2a+0c4Sf86ORELdJdfmE
         aXEkVAmEJoMEemNOQRIkypEWdqkZXSQDUFwlFBkXmBlfoXYe/Rn5hSkRZcFesNnGQp5F
         9V6tt+1nayFJCQYM44SFl2cgwH6WKjlTI1v9iqX2SuRjLjZTHf5lUGnbnOzF9u7E/dZK
         7vDg==
X-Gm-Message-State: AOAM532ynysajsOVcs4XAyD+UpwsTGZfQlZZ9EX9JBgkHo2RRvuY9cqp
        kZ+AtPeTBUVM7uMEpl8LeR2QTQ==
X-Google-Smtp-Source: ABdhPJzsTxA1zW/q5sM0l2RXE9Np/KJT5Rv3SsHglK+wim7/HYjXom4ZLwemm3xLeNDbggkoeMKMDg==
X-Received: by 2002:adf:e506:: with SMTP id j6mr25938384wrm.411.1605181189271;
        Thu, 12 Nov 2020 03:39:49 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id p12sm6369412wrw.28.2020.11.12.03.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:39:48 -0800 (PST)
Subject: Re: [PATCH v9 00/15] qcom: pm8150: add support for thermal monitoring
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c943f56c-f72c-0f14-b6ed-b67e91573b1e@linaro.org>
Date:   Thu, 12 Nov 2020 12:39:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Shall I take patch 1/15 and 12/15 ?



On 02/11/2020 18:49, Dmitry Baryshkov wrote:
> This patch serie adds support for thermal monitoring block on Qualcomm's
> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> to support thermal zones provided by this thermal monitoring block.
> Unlike the rest of PMIC thermal senses, these thermal zones describe
> particular thermistors, which differ between from board to board.
> 
> Changes since v8:
>  - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
>    tables support
>  - Simplified qcom-vadc-common volt/temp mapping code
>  - Implement suggestions by Matthias Kaehlcke: message formatting,
>    rewrite comments, remove unused variable initialization.
> 
> Changes since v7:
>  - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
>  - Use explicit sizeof(var) instead of hand-coding 1 when accessing
>    adc-tm registers.
>  - Remove buffer read from adc_tm5_init().
>  - Remove extra on-stack var from adc_tm5_get_temp().
>  - Minor formatting changes as suggested Daniel.
> 
> Changes since v6:
>  - Added include <linux/bitfield.h> as noted by Jishnu Prakash.
> 
> Changes since v5:
>  - Reworked DT bindings:
>    * Removed qcom,adc-channel, instead it is parsed from io-channels
>    * Renamed qcom,hw-settle-time to include -us suffix
>  - Re-added monitor enabling which got lost during refactored. Noted by
>    Jishnu Prakash.
>  - Use threaded IRQ handler as susggested by Jishnu.
> 
> Changes since v4:
>  - Added kernel-doc comments to ADC-TM structures
>  - Used several sizeof(buf) instead of hand-conding register size
> 
> Changes since v3:
>  - Fix DT description to spell "thermal monitoring" instead of just TM
>  - Fix warnings in DT example
>  - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
>  - Fixed whitespace chanes in qcom-vadc-common.c
>  - Removed error message if IIO chanel get returns -EPROBE_DEFER
> 
> Changes since v2:
>  - IIO: export of_iio_channel_get_by_name() function
>  - dt-bindings: move individual io-channels to each thermal monitoring
>    channel rather than listing them all in device node
>  - added fallback defaults to of_device_get_match_data calls in
>    qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
>  - minor typo fixes
> 
> Changes since v1:
>  - Introduce fixp_linear_interpolate() by Craig Tatlor
>  - Lots of syntax/whitespace changes
>  - Cleaned up register definitions per Jonathan's suggestion
>  - Implemented most of the suggestions from Bjorn's and Jonathan's
>    review
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
