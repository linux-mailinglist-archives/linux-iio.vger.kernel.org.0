Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF681525E31
	for <lists+linux-iio@lfdr.de>; Fri, 13 May 2022 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbiEMItO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 May 2022 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350744AbiEMItN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 May 2022 04:49:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0BF17390F
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 01:49:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z2so14908953ejj.3
        for <linux-iio@vger.kernel.org>; Fri, 13 May 2022 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AOlngjQgTSn6GmtShBqgjXLfwUmwXKNpLbvwbvRVOyg=;
        b=JPeKVgdXCRANIchrbjh6Wc29UyghmwZk5Kt/XFpS7q4q2iHfNs5Z1o/sIySdat8FJR
         LkJdPpsr7QNhLp1aPKNvq9NL7Ndgpp+FIf0TLwgWrqyUnuFOM/sc0+c3m09jA42hu4up
         UpkSvxcbyTcU7z0aKFEgW3NELq3+p1EM1zI9cKrtChdVmxlI/dRmvlcFN0Urg+Ho4S1L
         eCaPRw3Ye3/QQXHH6wrEaD8U83r60cXGEhcJLvLOIu3Wui3xGBgyxsRrJhEI6oF1qqMA
         a8zwkfwvYqML/Q7xeJSyvB3STf8s5ntDEGIQAy2HP1xufVIKKQmy+POoFX529ELFb3ZF
         baqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AOlngjQgTSn6GmtShBqgjXLfwUmwXKNpLbvwbvRVOyg=;
        b=jyji4TYjFi/CV1JPPCKbaR6JHEctkKSyJQqFcePncgYlRFKEuNvATu9kqmcDokRHRb
         7Biu+l0aPTau9r1dOrVlnKLAte8MAg/m8RhMpVRGni4x20zrWtbbLCEWuDfP6KPiRkvP
         hxuMwSPj+rSIO4XALp50kdY2nmdWMcv7YxvFwMqct6xQ4BkG0CjUKfPSGGTzqJLEgMXN
         LkTygBcct40E1BQMHSlKMmXhtkkvzM34uEFb/0vx/WrW4KOKbhJOP4lKGtMFx6W087Ge
         Hy0Dts1oJe3dnR/mOWf7WBju7ck2nVB3YxAxazdTkC7yx64ipQB2AdPQhCqC+RzWWfY0
         PIxQ==
X-Gm-Message-State: AOAM532su+hpAn7jvbyk94ANtvOvB1Gts9RHOcAs9vVxJhLa7BN5MFpf
        eCgnMGOXe9NefN61xMsFUS3n2A==
X-Google-Smtp-Source: ABdhPJz82mSV+lPh1KuUi0eEVEITLy7/amJuryJTfQ76xBcpYNPpO+sqBQBrGkKHpCLGVye3So9OFg==
X-Received: by 2002:a17:907:d0a:b0:6f4:98fb:f407 with SMTP id gn10-20020a1709070d0a00b006f498fbf407mr3208500ejc.219.1652431749926;
        Fri, 13 May 2022 01:49:09 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ca26-20020aa7cd7a000000b0042617ba638csm673026edb.22.2022.05.13.01.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 01:49:09 -0700 (PDT)
Message-ID: <75535c21-2890-b5bf-3c8e-62013a7c65b3@linaro.org>
Date:   Fri, 13 May 2022 10:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dbarksdale@uplogix.com,
        miltonm@us.ibm.com
References: <20220511190835.51046-1-eajames@linux.ibm.com>
 <20220511190835.51046-2-eajames@linux.ibm.com>
 <7b4f2991-1dce-77d2-53c2-c4c358cbfe77@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7b4f2991-1dce-77d2-53c2-c4c358cbfe77@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/05/2022 00:08, Eddie James wrote:
> 
> On 5/11/22 14:08, Eddie James wrote:
>> Document the si7020 bindings with a new "silabs,skip-reset" property.
> 
> 
> I missed the entry in trivial-devices.txt. I can push a v2 or a separate 
> patch for that.

In this patch, please. Anyway you need v2.

Best regards,
Krzysztof
