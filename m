Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25A145DD6F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Nov 2021 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356089AbhKYPbg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Nov 2021 10:31:36 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40710
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236010AbhKYP3d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Nov 2021 10:29:33 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBF2E3F1D6
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637853979;
        bh=amcl3GANIPe7PKb9EAnOXSQfzXD0HZLDodu/ulsFM2Y=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=r/jq9lxyTbNHbODkAYW7JeB/gtUJ2NCV8f2N/HuIhYuKHgXUt6RfCR7JZdhXSewJX
         GoOgPC1BRf3lwFgcR8SB0307h8+JTN3hSMFXvQmVQ5s4C+rJOvdzuYzUoEC1dYC738
         2+j1br7GIZfbv3607bk50FbYmgjIITEBz7Dn7JRIppzjsTtd2wtev3F7/weN8UEl1Y
         jMHsurGjfHw+FF4oDikJXeAJYMfVEKQI9ZDgJ6kBUb01Z4B/VEPGaz/dHM+q1Nt23P
         fV1vCPN0tYiOabUK8tic/RJZ0U4EVSRoVPxeu71cp51uk6rqIjR8B7gL9Dd4sDCrZ5
         d3+yriWyZt8hA==
Received: by mail-lf1-f71.google.com with SMTP id n18-20020a0565120ad200b004036c43a0ddso3365393lfu.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Nov 2021 07:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=amcl3GANIPe7PKb9EAnOXSQfzXD0HZLDodu/ulsFM2Y=;
        b=6bG2e4TkRzlHx3pQA/78Atu7fHzXsC3NuQvGUpPOL2hv6zjI0SgeqVAf1ZDk/ujMBq
         vUgek/7Sf83ElSZKtZM8iuUJ61oAaIX7s6mS2maB9YxtIQHhhm/gwfy5aeNcooEYyGdv
         Qks62TScvmcxYR0LB2BmwCLBrsKMdoBBXMENk0SI6VJvRGogXABjLMjtYxFGLyXKEmpS
         xJXN2gMIN5swVovIdxJN0RgSDKODjW3hLVX32cAH2ZLuo/wB78c4d5L0XRKFYciLBLWI
         bBH4hCiaB4L4NHnBCPwlQElGngn4usU1HtBur94HMllxL7XX0KgHstMD/VyokY4YDb0i
         3WYA==
X-Gm-Message-State: AOAM532THJsGjP9L7XedjVTjo9vojhJOop/fAfl2ILjQObM6Sibvl9UH
        3bneRQ6jvTQvT1FMBWjc3+vIiXu4zIqftY9i1mr3hAXcsaWQVphlt9ZkBJih7M62YkS7rh43493
        sucgMIaCRFLZusJB248mHUkppW02HMMZhBcG/tA==
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr23946191lfu.18.1637853979335;
        Thu, 25 Nov 2021 07:26:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn1+RB7r3XOlGNO+ahbHGIswkd1Eeqf82NkcTdL785D/0mOk8ak+h7JW+P5FnFls+yKf4Cpg==
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr23946175lfu.18.1637853979173;
        Thu, 25 Nov 2021 07:26:19 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w16sm285015lfa.271.2021.11.25.07.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 07:26:17 -0800 (PST)
Message-ID: <3fec093a-df46-6096-3f66-891734a5f140@canonical.com>
Date:   Thu, 25 Nov 2021 16:26:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dt-bindings: iio: adc: exynos-adc: Fix node name in
 example
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211125152154.162780-1-geert@linux-m68k.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211125152154.162780-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 25/11/2021 16:21, Geert Uytterhoeven wrote:
> "make dt_binding_check":
> 
>     Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: ncp15wb473: $nodename:0: 'ncp15wb473' does not match '^thermistor(.*)?$'
> 	    From schema: Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
