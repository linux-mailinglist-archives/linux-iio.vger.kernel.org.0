Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD336AD9EE
	for <lists+linux-iio@lfdr.de>; Tue,  7 Mar 2023 10:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCGJKq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Mar 2023 04:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCGJKg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2023 04:10:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA7951C9B
        for <linux-iio@vger.kernel.org>; Tue,  7 Mar 2023 01:10:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j11so29953113edq.4
        for <linux-iio@vger.kernel.org>; Tue, 07 Mar 2023 01:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678180233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4KehQSsVixMJJWuRw7s3LdlJRgqI4sOHnuD73adyhw=;
        b=aPheB6CyCtzLQcyQs15wilaMM+LszqQaVFybLn5CfXAu5xO5thutdXLENgiCzgMfhP
         9HWd8gKpJ7HdrEER+Uix8beEn6Z93pwRHcOEnHeVRQg8iSDmUEcIXydv/VPqZGA+jvxz
         d07qSPD6w7/JRKdJ6SZ793frQ4ZjjEd7lWIaZuzoRXd05L8YqznaiIzjbXCJScuQKJec
         Ml14CONFsva9X5g88QIU1VjSn6Z5rGgDhgfUOlTmTHkEpWMpqoAPnxP3TqekL9Olry0M
         5Zv2/+e5PvxfbwrOea3Rrf3lwuGV9C6HYNHFDbZt56Ir3ikwe2UFjXreVinrYaDej1UH
         yZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678180233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4KehQSsVixMJJWuRw7s3LdlJRgqI4sOHnuD73adyhw=;
        b=jC1j+Uh1umygThPuRFj78Ys5t+jIxtPh8pbX/vIvjCAESXu52MwnWAMjdWRT+sCVRr
         dK3L7uHhCytKyqrnNiMxvJi5pkvkaL54h7MwcN2I+yxTygRLkuRs3y6nuRqlqg5Zf23n
         VSsRHlM5xu+FCrH8sV8nQTK1bEv1+svs/usMaALGldtdwqH1U218GCmUKAdW1VFA4ZaC
         r4cGpMa8xezWCWANd6eoVk/Ai7trpvKwKa82v4XdMvu/Ei6WVcwYbkR/Bz9fCDaQLXfP
         UyIEJDDPOcv1vp4AwUpfzkz8DJlebv4vlqzvKAv3ofSN2jqX0GH/LoQiAHvvxjjvgszW
         NyPQ==
X-Gm-Message-State: AO0yUKXri24ywZ42D+0BdJ0jLLPIp43zuKvUEplMV9jY7eebAi94P/ni
        X4nBGXVAgJDdUgGZVpO6pUqviA==
X-Google-Smtp-Source: AK7set+uvHMHc+S7b3Eg98SNdL4BdIIaBDGkVOBA6O+W83CAEuoFo1qxvP5zZrXLkY/eEYB5nRWEhg==
X-Received: by 2002:a17:907:608b:b0:873:1b57:b27f with SMTP id ht11-20020a170907608b00b008731b57b27fmr18476622ejc.61.1678180233183;
        Tue, 07 Mar 2023 01:10:33 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:5310:35c7:6f9e:2cd3? ([2a02:810d:15c0:828:5310:35c7:6f9e:2cd3])
        by smtp.gmail.com with ESMTPSA id le16-20020a170907171000b008da6a37de1bsm5883596ejc.10.2023.03.07.01.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 01:10:32 -0800 (PST)
Message-ID: <f2bbda1a-b6e3-ccbb-d77a-8bdb42aca0ee@linaro.org>
Date:   Tue, 7 Mar 2023 10:10:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <cover.1678100533.git.lorenzo@kernel.org>
 <fecf1f20cc8e99fb8654cc733f14bd449ca7f87a.1678100533.git.lorenzo@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fecf1f20cc8e99fb8654cc733f14bd449ca7f87a.1678100533.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06/03/2023 12:08, Lorenzo Bianconi wrote:
> Add device bindings for asm330lhb IMU sensor.
> Use asm330lhh as fallback device for asm330lhb since it implements all
> the features currently supported by asm330lhb.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> index decf022335d8..b39f5217d8ff 100644
> --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> @@ -46,6 +46,9 @@ properties:
>        - items:
>            - const: st,ism330is
>            - const: st,lsm6dso16is
> +      - items:
> +          - const: st,asm330lhb
> +          - const: st,asm330lhh

You added it to the end of the list, but aren't there any ordering
already? If so, it should be put rather in correct place.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

