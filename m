Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F705FB21F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Oct 2022 14:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJKMKf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Oct 2022 08:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJKMKe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2022 08:10:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD15F62929
        for <linux-iio@vger.kernel.org>; Tue, 11 Oct 2022 05:10:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id g11so3424094qts.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Oct 2022 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=POhII6F19HL9Jpz6l44lNoHqeI4O0KAnr15FsZzwSiw=;
        b=Gouqkf6y4M8S9bLJeUpRlj8ohNfnLapgEO84M6R9JakMD0N8Gif2k0bjnUix+nJlaY
         aigoLLsJhgckgsN37lxvsEeqheN/PjCikGZ1B8SZg3c+eyAuxMXcC9P43VcDydwt7TGb
         QczR4Oxg6MkLL5+9j+5Y1Dh6DsrM3h9vr0gTbjZsj3q4iQMjS5cYcH9zksxNM26r2QHj
         Vv38OgOKo99a8stbTioxeZtSdtvpjMBklsJu74Td4LYLLgE8Nr07wglT71hOkUpF0GNh
         Sj0fwxy9YLamX50oOY9oWLOMnPJ4c1KlgWS14r+AOmcUjzwC5doJPjO3PXyyEq+Ya4Vo
         +U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POhII6F19HL9Jpz6l44lNoHqeI4O0KAnr15FsZzwSiw=;
        b=GOHjQ9YJDTpoXHELGsc6E6RPU5VwYyn1/yRjObsZ8i+vsCAxrAolf9ZEUxetOQnNlF
         gwGv7KjXH362TA3X9Z3z/qEsdD1KSjqcnuSv9DQSmty0aOaHhvgAMrjCwt96GOSOi4nQ
         UcsrI93YKp28sg4oIusMlIjHnjAI1UvJuE9z6qOTxV1YIqckdH6YxyJWCWmq0g5sZLs7
         kUxP/j9E8of4T8GPkoJlbJNPoM1VX0ahVv1mlrs+pc+FwV+t/wZiVpx72Eq19VeiWB7a
         Oe65y6XA2OkKcfg+a94j2gU9qA6BVXs0teNGBbV98PcWJQXCygxgMBnpab8BWq4pXMf8
         6AEA==
X-Gm-Message-State: ACrzQf165oJ3PCEPASZIo0cUdU2y4cu8KnxN9mNimys/IMV8IVdup+v7
        otPEq7zcbSHFtplJy+Ek69UHPA==
X-Google-Smtp-Source: AMsMyM7zwLeaJwvx/qel0Do5JwTShDJSJhZp+q0wSCJHuxPlW2h1f5744flplIf8q7XZ16GfSLeDsg==
X-Received: by 2002:ac8:5f93:0:b0:394:13a:8ffe with SMTP id j19-20020ac85f93000000b00394013a8ffemr18530275qta.9.1665490231977;
        Tue, 11 Oct 2022 05:10:31 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a280e00b006be8713f742sm12771153qkp.38.2022.10.11.05.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 05:10:31 -0700 (PDT)
Message-ID: <1ce4ba01-074e-861a-e4f0-d5a0c9cc1fc3@linaro.org>
Date:   Tue, 11 Oct 2022 08:10:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Change the I2C slave address
 for ds4422/4424 to its correct value
Content-Language: en-US
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com
References: <20221012074446.726409-1-rajat.khandelwal@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221012074446.726409-1-rajat.khandelwal@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/10/2022 03:44, Rajat Khandelwal wrote:
> The datasheet states that the slave address for the device is 0x20
> when the pins A0 and A1 are ground. The DT binding has been using
> 0x10 as the value and I think it should be 0x20 as per datasheet.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
> 
> v2:
> 1. Subject prefix added
> 2. DT bindings validated

No, still wrong. Nothing was validated.

> 
>  Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> index 264fa7c5fe3a..1955b1a97cd6 100644
> --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> @@ -38,7 +38,7 @@ examples:
>  
>          dac@10 {
>              compatible = "maxim,ds4424";
> -            reg = <0x10>; /* When A0, A1 pins are ground */
> +            reg = <0x20>; /* When A0, A1 pins are ground */

Nothing improved here.

Best regards,
Krzysztof

