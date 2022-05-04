Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49575519748
	for <lists+linux-iio@lfdr.de>; Wed,  4 May 2022 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbiEDGYT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 May 2022 02:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiEDGYS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2022 02:24:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C619280
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 23:20:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so958546ejb.6
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2022 23:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S9kVssv7NOzawB6oy6PZFFqEWoy+1iZ0ddgQbndGXkY=;
        b=eaPtpKhP1noRcNSLEl8k7DRsmp1+3MImkuiSu7hO9CNuSBf/5vIEAIH6OKgLl3Vgfs
         DiuNCahXqDrm3TDxKTeBHztIQ2X4A4DvEcpu3jKQ6K0o0/1BYwYOcGfB5y6brD0c2zyH
         QL6ONvMa6Dbimne4AH7LJkUgiduWjnNosD6HI1qAfmWhAvKsMXz8WR2bO0kLOFR/9pt0
         f4qoxNXj/v29EwKAwkJa0ftgmaY0KnEDdVY3ov1TJg2vsxKrL4f5N5rlw28PVvwZXKl/
         ASvjmeeeY8p0kcTWbGoCywM07jJ0+VdDy/jroI3pT9w9iEnC6viLgDEXrSNzA/TGuvbF
         EH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S9kVssv7NOzawB6oy6PZFFqEWoy+1iZ0ddgQbndGXkY=;
        b=DdTGfWflA6bTfrrKvIY9GY/tMxH/VBQRFp101s7ZXkpgKdThtLNBfnC1kOM3E+MWWc
         N76Eba7zPNfbIOX2uwJ5Jl6dQtVL5H2W0OONRtvi75zXTnMw602hixAfmid4podSz3tM
         CDMrLm54Oa9uKM7cabJKrKjJ7A7JPRMiuO3n2qxuvQNZxNWEKVUqGkvpoU4gZv+kXtna
         HgSxFQcMfuzfIQZgyqaGPk+3Yhqxoql5MeUv865DUYr/jjZFy4N/GfySDbGW/BE5rpNT
         4I7BRa++zBxa9Q4hcrHd3avyG79I+9d3MAPRrMO7Wvuu5+4ukq0QPtkly8xENe/MwJ99
         YU3A==
X-Gm-Message-State: AOAM533RGa6qyDgs9uxmV6LA6IK+AdNH314kg+efcNKhp8q9vC3Fxtck
        Icp0aIouM/gXlnnhJtSbaLIKQA==
X-Google-Smtp-Source: ABdhPJzK4afMKmzSks36dzSJk3t+IoiFVAyPRNs2XhoB+rYp60IdxaXm9RDJbKDGhEIcmVXDSM/ypQ==
X-Received: by 2002:a17:907:2cc4:b0:6df:a036:a025 with SMTP id hg4-20020a1709072cc400b006dfa036a025mr19779920ejc.554.1651645241925;
        Tue, 03 May 2022 23:20:41 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5365230ejc.224.2022.05.03.23.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 23:20:41 -0700 (PDT)
Message-ID: <faaa4ab4-8190-3cff-998e-3b6a6d3ce27c@linaro.org>
Date:   Wed, 4 May 2022 08:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: sx9324: Add CS idle/sleep mode
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20220503193937.3794477-1-swboyd@chromium.org>
 <20220503193937.3794477-2-swboyd@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220503193937.3794477-2-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 03/05/2022 21:39, Stephen Boyd wrote:
> We need to configure the sleep and idle mode of the CS pins for this
> device. Add a DT property to do this so pins are in a proper state
> during sleep (either hi-z, grounded, or pulled up to vdd).
> 
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/iio/proximity/semtech,sx9324.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> index d265eb5258c8..b3aa2ebf9661 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
> @@ -126,6 +126,14 @@ properties:
>        UINT_MAX (4294967295) represents infinite. Other values
>        represent 1-1/N.
>  
> +  semtech,cs-idle-sleep:
> +    description:
> +      State of CS pins during sleep mode and idle time.
> +    enum:
> +      - hi-z
> +      - gnd
> +      - vdd

You need a ref to type (string).

Best regards,
Krzysztof
