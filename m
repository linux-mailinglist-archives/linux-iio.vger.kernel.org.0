Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F14E5695
	for <lists+linux-iio@lfdr.de>; Wed, 23 Mar 2022 17:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbiCWQiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Mar 2022 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239165AbiCWQhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Mar 2022 12:37:47 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB57A98C;
        Wed, 23 Mar 2022 09:36:17 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id t1so2524379edc.3;
        Wed, 23 Mar 2022 09:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xID/y6FVW34VZrnvCf0b9HExW6zMhF2WBK1VWecEDPg=;
        b=w0+URP/NpRTVuwxl77Qr9I1OZgMlF1MyeKnVHinI1L+kCHCaJ9J4tvFxXn3IN3Qoj4
         oQWGhpQAHTJO8TOO+D7o4CHU50feAlqx912PsKAtDz+0I3+wc8mKwlywwkJPrSW8FkJX
         lx9ItOYJZKa0PHyD4PcOk0Tm3yuusVWEAhMD0qRQxefmFdPNy2fbaBEMyNMdqrVTOxlH
         ykbKPE3mgIg+rpgdVVymXSLp/AdMddjkFjqsKfn2nKZOK3wvLyBYELBHhGo35iZ4vxJM
         X2lKDUL0Pq7ATs46kPhrHTq18pak8qUVOHCzDV+JoJrq1ekfsbKsF504gFXgaxIaszJU
         ZHVw==
X-Gm-Message-State: AOAM530bzso8sbAiv01vXpCeoSDAgbe9tZsnGBCGl8gGBM514XyWeuSk
        mK23wY41wtB1xRSo/bGhqVU=
X-Google-Smtp-Source: ABdhPJzJZKppkCgdf9Ls3orQM6PkVRgexV03RFrCKXVAejBsgpE0V7ijjVuq3fJFMNQ3F6dmcebOxQ==
X-Received: by 2002:a05:6402:2747:b0:419:4817:ba22 with SMTP id z7-20020a056402274700b004194817ba22mr1128020edd.253.1648053376177;
        Wed, 23 Mar 2022 09:36:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id z22-20020a17090655d600b006d229436793sm122598ejp.223.2022.03.23.09.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 09:36:15 -0700 (PDT)
Message-ID: <6c263c20-0731-3ef0-692e-76126ed0466f@kernel.org>
Date:   Wed, 23 Mar 2022 17:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v13 4/9] dt-bindings: iio: adc: document qcom-spmi-rradc
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
References: <20220323162820.110806-1-caleb@connolly.tech>
 <20220323162820.110806-5-caleb@connolly.tech>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220323162820.110806-5-caleb@connolly.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23/03/2022 17:28, Caleb Connolly wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
> PMI8998 and PMI8994
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
