Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC7C7CC7BA
	for <lists+linux-iio@lfdr.de>; Tue, 17 Oct 2023 17:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbjJQPoy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Oct 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344110AbjJQPox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2023 11:44:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDA3FA
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 08:44:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32db8924201so1750012f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Oct 2023 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697557490; x=1698162290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6DtgUSYb0XXQqzXwICHZfgVDuua9U+i2U9Fqp8iMmb0=;
        b=QCGLfJFf2ZzI/2bUqj24KjLWmxNWUJZCCbbvJCUPdIi4I1G6sq5XGn/nVnZbsxFez9
         Mb7qRjg0oqbtsPZoQVjaK9j0JRWKhmxtIXMWvaqTboAgo575s3/GEeFA87OOhRdWvpCq
         cJZLFXgy0pcqGSTVAGyDiwDnEuPDAZZvJlzeVtUXNwRAFLLU4wI+blBezEMQ05QHiVzP
         MzCxsp8AjgSXlfvUroJGLSKeKYHSZHNmCzEEoKDOjRD7ur+9Mvef66UxJOdb13/SDHb/
         Ynjt7Mc210EwsiEbfeLTOciU4hHgxMgHVMAHKk288wtEC+9THfCa08Z2dNzdmqC8G/nN
         oUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557490; x=1698162290;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DtgUSYb0XXQqzXwICHZfgVDuua9U+i2U9Fqp8iMmb0=;
        b=jvqcdNhP2fEFngm8WKsWrprfUKdAiN+YLyOZq1YseTswGvQT87+uYGw5GGeRuD3Yof
         W/irPNPp/vVttHbUFpv46hDLSBOZN6CmJ7G8Vafvq9UgwWWgwVv3WdNnJ4zZ7wS2HuKg
         Prk8tGwMx3T9edgEvT3cGGRsf32PbBNZB+MLZkVQPNPK68iYa6culUvFWIBzSLXxWDxM
         zhOMjLaT1qQCzEGeCCfWGUzwDV5BLTc1loYjiBEkUIzYT5vzHHPNoLT1J2/56X+UcylQ
         QaYzXha1hnq5flxFAR3tXJ+E4DxnWdI1m7bUyJ3VO2P7MzOkiBnTm5OEfRuSUYBqd0+g
         MZeg==
X-Gm-Message-State: AOJu0YyYrppOIJosqzLGJxVb0MveaNPZOhG/wb39YehL0YI59tMPs5Gw
        ZxwyOy8/8IkfKQoWEbB/n0RKxA==
X-Google-Smtp-Source: AGHT+IFTjtJ39W3KRhn5QvvknkJMZLuJDABRE9FG1cQ66UJhKTucaLmK/XbihixPbEDdCbWGRVW60A==
X-Received: by 2002:a5d:68c4:0:b0:32d:6031:2824 with SMTP id p4-20020a5d68c4000000b0032d60312824mr2058463wrw.24.1697557490259;
        Tue, 17 Oct 2023 08:44:50 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f4-20020a056000128400b0031c5e9c2ed7sm33293wrx.92.2023.10.17.08.44.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:44:49 -0700 (PDT)
Message-ID: <69987d14-37d1-491e-99fa-9d0201112b67@linaro.org>
Date:   Tue, 17 Oct 2023 17:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm8350: Fix DMA0 address
Content-Language: en-US
To:     Nia Espera <nespera@igalia.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        Rob <Me@orbit.sh>, Clayton Craft <clayton@igalia.com>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231016-nia-sm8350-for-upstream-v1-0-bb557a0af2e9@igalia.com>
 <20231016-nia-sm8350-for-upstream-v1-2-bb557a0af2e9@igalia.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231016-nia-sm8350-for-upstream-v1-2-bb557a0af2e9@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/16/23 14:47, Nia Espera wrote:
> DMA0 node downstream is specified at 0x900000, so fix the typo. Without
> this, enabling any i2c node using DMA0 causes a hang.
> 
> Signed-off-by: Nia Espera <nespera@igalia.com>
> ---
Oh hmm.. I wonder if that's why I could never get one of the i2c hosts 
on 8350 to behave..

Fixes: bc08fbf49bc8 ("arm64: dts: qcom: sm8350: Define GPI DMA engines")
Fixes: 41d6bca799b3 ("arm64: dts: qcom: sm8350: correct DMA controller 
unit address")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
