Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C389650E3FE
	for <lists+linux-iio@lfdr.de>; Mon, 25 Apr 2022 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiDYPIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Apr 2022 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242739AbiDYPIi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Apr 2022 11:08:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F52BEB
        for <linux-iio@vger.kernel.org>; Mon, 25 Apr 2022 08:05:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so15024330wrh.7
        for <linux-iio@vger.kernel.org>; Mon, 25 Apr 2022 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=l2YPXMptIRVUDg0/5cE6mEeIv9YZ982lwE8GUgZtShw=;
        b=ZeWu1rkuYLOg5sVsb50fCIPjGGOEg5uO5KPDY4Egj3YOZkD5DOITRuMO8uFqdeLzT0
         LRsHywFhtAj7su3yDl5tjhqWdF+mvdzYhsxHPkLPeDLdqYKt6GWJZB8mCHu/p2rByKbw
         dWlj3e8u0Y5ynpRsgvvprlLzI3aGt3Sn2PNcEtP2Es5DYfTZieiOZLlBbpqzaZieIZK9
         INBdFaywoygSM2SU9Tv0L3EWzjhaE+ipRMg0q9TFj3R3oXWqdZsF19y+PPm1sJI35CkT
         tVHhQwJwVG8Vt+dLsP6BoXUvra7akIh0+3/qysbJVfdABQzpBSjNwE40B1VY3dFs6YHL
         BmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=l2YPXMptIRVUDg0/5cE6mEeIv9YZ982lwE8GUgZtShw=;
        b=AgZ+14jYqE9sdFqCiaY2ajLBZQvMZtX4lM9u/g/meFY0XrhR7CsqfqzgvQUkHCCXB+
         d60TJ4fioPvhMx2hQyj1yV8nGTFzprcL/w5uq56NQnmf35zBOLHkGVIkhoGewhUoL51n
         zg2nhdqJ6Y5qXN1M3y8jPUqhC3tno2TV/xhpmqBcmmGvBWEBpj+npCL1GPko1/ARJVa+
         hXl9iQfRkguj85U4d/+B/3geZ7UeHcDQzQcQBvV2AZNUFbZm+zZ8zv+sb0INb72U+KgN
         hmeNtFHaIhF1WSEERK/gfqxFI6noaMEyiy5qTQuY1RxbbJytO1AzjV9tqz//n2ZwICMP
         Dccg==
X-Gm-Message-State: AOAM533SBb3TN8ZXTJyKk6A1HMC4uQA4whQ2P+q86vJERJQF9FqyOBDh
        nV9i4YXvIjzKPzyT3ACBunyzkw==
X-Google-Smtp-Source: ABdhPJyJTkoDnJsWXj9rt65qzeyKTSNVAWRtPBJ39yltMrk8tHL5ZBppGS5gsV1MsL1EFIhyFojyXg==
X-Received: by 2002:adf:ec03:0:b0:20a:d0b5:a06f with SMTP id x3-20020adfec03000000b0020ad0b5a06fmr10045489wrn.669.1650899127504;
        Mon, 25 Apr 2022 08:05:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d64ca000000b0020aa97b0383sm9244610wri.113.2022.04.25.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:05:27 -0700 (PDT)
Date:   Mon, 25 Apr 2022 16:05:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v13 3/9] mfd: qcom-spmi-pmic: read fab id on supported
 PMICs
Message-ID: <Yma4tXvPQ+U89Whr@google.com>
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-4-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220323162820.110806-4-caleb@connolly.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Mar 2022, Caleb Connolly wrote:

> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> The PMI8998 and PM660 expose the fab_id, this is needed by drivers like
> the RRADC to calibrate ADC values.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/mfd/qcom-spmi-pmic.c      | 7 +++++++
>  include/soc/qcom/qcom-spmi-pmic.h | 1 +
>  2 files changed, 8 insertions(+)

Please change the Subject line to match the style of the sub-system?

Once changed:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
