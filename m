Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDABD781CB6
	for <lists+linux-iio@lfdr.de>; Sun, 20 Aug 2023 08:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHTG4T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Aug 2023 02:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjHTG4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Aug 2023 02:56:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F53598
        for <linux-iio@vger.kernel.org>; Sat, 19 Aug 2023 23:29:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so33546541fa.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Aug 2023 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692512950; x=1693117750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uc6r5jrTl5KRxyULV2rwJI3udN950yCQjtWBO1UHlTE=;
        b=A188BHQPbmwpEsQTM+O3IWYN/sJ+IGMzg0pNy7H09QX3+hs1UJ03dS701+yBeYbWsz
         vQCr34Ui9zvNsIc+BMqDA5ppu5HVfTaUCNmYJsfkMqxUkFI2CFdRhsFAVNm68Eq4fdew
         rivzw9rDqunEQt/FH7Lr6TS/mEEbFNpI69sBt4+zqQgcB1IqE5TPVQMbOJ51e5UTDhTV
         bdNfuylUfspFU6T8I23s9pppWFgfp9Hu8yACDrXA/QJ3xNhTggfM8KdBxavQKf/vaGn2
         f1AUrpufiIJDoCnG8htpXOwOhjhW5cVqzDZAT5PNN6E7PKtUIai9MK4xtGUzhtfsK3Br
         STsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692512950; x=1693117750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uc6r5jrTl5KRxyULV2rwJI3udN950yCQjtWBO1UHlTE=;
        b=EtuGDj/X5mAruk4wVfZpxWpnG9c3RdctOM3GpFI8rI/zREwciXN/XnuIcYWv0tRt1Z
         mw4Yvh8hHo1l6psf0Z2RYIEo4DMTrFDgbrx8t0NfsroV+UzKvOFH5Q0zkKeomCL5I9yp
         LxhcK4Sj5p3LTXgZlKxcFuzOMDlQ7qoEa3trJ5l2jtbwL2SR/pZRjO4j6qmN005zRBUn
         l4G3pksNsxKQ3m96eCH8V4k8Hmh7dhQcZaPASycF/DfJpqgLY0DHirFu8MMqIzZqxRES
         3Xxc7RONw4JhQQZV21OxsqQWGR5+Scck4w8C3uZfKEiZWJrWQauZmxJbumW5tsRL5t1w
         8XGw==
X-Gm-Message-State: AOJu0YxiZUARvGSczMT4jyR34JzcFnh2v+ny/z/NMR+WNhquAmDfcBjg
        LrSP7id5LxwlG77bnzITmdemmw==
X-Google-Smtp-Source: AGHT+IHGiLfTKXd3POBlHix4H5KyMKF6QEFcujN4xuJyCP7MzrXaQscwFy+zspuseAs8dz2GHwW3BA==
X-Received: by 2002:a05:6512:39ca:b0:4fe:82a7:814d with SMTP id k10-20020a05651239ca00b004fe82a7814dmr2334975lfu.48.1692512949514;
        Sat, 19 Aug 2023 23:29:09 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id sb25-20020a170906edd900b0098ec690e6d7sm4029867ejb.73.2023.08.19.23.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 23:29:09 -0700 (PDT)
Message-ID: <a5c01c63-9914-65d6-7b08-090e08d491a0@linaro.org>
Date:   Sun, 20 Aug 2023 08:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: iio: adc: Add TI TWL603X GPADC
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230816202614.324457-1-andreas@kemnade.info>
 <426d78d6-9fa6-bfeb-b36a-fba264097a27@linaro.org>
 <20230819221903.726a1c39@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230819221903.726a1c39@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 19/08/2023 22:19, Andreas Kemnade wrote:
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: GPADC subsystem in the TWL6030 power module
>>> +
>>> +maintainers:
>>> +  - Jonathan Cameron <jic23@kernel.org>  
>>
>> This should be rather someone knowing or having or caring about this
>> particular hardware, not subsystem maintainer.
>>
> Hmm, I have the twl6032, but not the twl6030. So probably
> Tony (OMAP-Maintainer) or me?

Yes. If you have a device, it's even better, but "caring about" or
having datasheet is enough.

> 
>>> +
>>> +description:
>>> +  The GPADC subsystem in the TWL6030 consists of a 10-bit ADC
>>> +  combined with a 15-input analog multiplexer.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,twl6030-gpadc  
>>
>> Devices look fairly similar. Same properties. Why aren't they in one
>> binding (enum here instead)?
>>
> I hope it can be done. See commit message. Maybe my reasoning is wrong.

The parent device binding can expect the compatible for the child and it
will have the same effect in total as $ref to this binding. The only
difference would be that running dtbs_check on parent binding would not
spot all the issues in the child node. One need to run dtbs_check with
both bindings.

For an example:
Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml


Best regards,
Krzysztof

