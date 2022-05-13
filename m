Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1712525E7C
	for <lists+linux-iio@lfdr.de>; Fri, 13 May 2022 11:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378613AbiEMIuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 May 2022 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378595AbiEMIuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 May 2022 04:50:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325782B09D4
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 01:50:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z19so9139377edx.9
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8jAsS4nRtgEk6rcldXqtPG7tB5vr/ix0aGhyeOjtgAY=;
        b=kWQCU6xHWr/DfLEn/JOSCnxo6nu28XgiljX5rE3ZtPqyaNN1q0OZ80RN3Uo8ygGYgf
         4UH5U25ybipMbPkvotqsrNS3NM684meI8S3ST7kboogbtF/cewUUCMeGua6lY19paoUv
         H5Ns2xn+b94WaX0iCzpFUrE5GU+5+Tug66wPJ8lX+5s04cRbwf4/z6pyeH83dH9I4TiO
         ccGVxTcJJwSTHsSc0APJ/IblRWa49UUfbVSJPEbJITfNmRK3exq09lFLahRGtX+Nm/jD
         jwJJhm3edGzhzMwklLJXtXNQAnq/R85i599SaI6JmZoT7UHC13xn8RlciL4y2bCrAn7l
         YEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8jAsS4nRtgEk6rcldXqtPG7tB5vr/ix0aGhyeOjtgAY=;
        b=3ZQenx0O+8BvWrnVjt2/lgtsFHjFnEciDjo2PZbfp3PvXgjoU3Pekpz/C5SyCBy7C4
         nP2NeMkyUq5IDIesHHzefm89e2OnDxJRUs7TC30eUuOYXyDTLGb1djWO3cxOJJcmpzpD
         5cEKBu9dGgzK9nagdxTLl1Ncr8IwTtrcjPlF49owxf34Qrd3JAHkIDdL/Q6VBh4FmMrd
         mFOQxs1DIqMTXAntY3y0OqC53LLVeRdcxU4+CQPnlF3fMtO4VJ9jiz9juIK44excdQGs
         57EfHSfbbCvPxKaVSOPGkQlMxNkC2/EFVddVsm4sXIgVQX0yV9U3vvX2yfu2KgZ8HFTL
         tfUA==
X-Gm-Message-State: AOAM530xkTo5qu05basYf3CwZNPXCJOYczOilbXl7JzGi0loVt0jUj2r
        Ag3JvargIIJ09LvSgGOstKFWLg==
X-Google-Smtp-Source: ABdhPJzzTyiEdIj6zR27mqFC7p+P/WTJ5S/2her3sMB8727W4T5vdDimn/X7j1JFAnKBvjdwBm8TPg==
X-Received: by 2002:a05:6402:1399:b0:410:9fa2:60d6 with SMTP id b25-20020a056402139900b004109fa260d6mr39588000edv.35.1652431807826;
        Fri, 13 May 2022 01:50:07 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hv6-20020a17090760c600b006f3ef214e60sm522542ejc.198.2022.05.13.01.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:50:07 -0700 (PDT)
Message-ID: <f18e1934-ba8d-fc4b-dca9-9ceb1a265c53@linaro.org>
Date:   Fri, 13 May 2022 10:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com
References: <20220511190835.51046-1-eajames@linux.ibm.com>
 <20220511190835.51046-2-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511190835.51046-2-eajames@linux.ibm.com>
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

On 11/05/2022 21:08, Eddie James wrote:
> Document the si7020 bindings with a new "silabs,skip-reset" property.
> +examples:
> +  - |
> +    si7021-a20@40 {
> +        silabs,skip-reset;
> +        compatible = "silabs,si7020";
> +        reg = <0x40>;
> +    };

As Rob's bot pointed out - you need to test your bindings. See
writing-schema.rst. Don't send bindings which do not work.


Best regards,
Krzysztof
