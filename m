Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935396D3778
	for <lists+linux-iio@lfdr.de>; Sun,  2 Apr 2023 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDBLCQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Apr 2023 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjDBLCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2023 07:02:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025EA1B7FD
        for <linux-iio@vger.kernel.org>; Sun,  2 Apr 2023 04:02:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so34469359lfb.12
        for <linux-iio@vger.kernel.org>; Sun, 02 Apr 2023 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680433328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pjhc1Lo1QXYK2mc4fR/wxw9auCD3+2lFp524CK7hL6Y=;
        b=tyAGxMFBhmZJy+ulZ0XKhvsvMUzut8UKQE4FyL74OwsQPgR2c8nHfGvlKOa9hxEfX7
         6Zn6cxKNQ32LPexpnvN3qU/E9qjK4d3AuWQTgzBsSItmoL7nKfT08R1jL3/fh/cSczRr
         kjaiCwP8kvLO0O0UJWih2/+Z5c8XbR0gUsteu85009UfSUmyvTJAVMxiIoJVyos0TJhn
         /EMz7E/CdrRAtvOEt3/VHZzGhTMJP/KI/HvcjERvuz/FaubABjJw0am7tC27GvmpQu2M
         aiXJ19/P4OhkJvgSxD/F6m3F9U0V4eDpX4KFQrvkkao/Nj9kx3FF95wec21rASzT5V1g
         ZJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680433328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pjhc1Lo1QXYK2mc4fR/wxw9auCD3+2lFp524CK7hL6Y=;
        b=Yu2tBr46Hw+TCA3mHaGdYXp4PzYRpc5EAm5DylcajmGaFCbxe86by44KrEMnUAb90q
         zMRf+sTHXLKbu8PSPpP+5bqXFf8FjErPdb7m//sn5E3DXmHmcCVVTxRwRUbDHbryu1yq
         NuZzhl1Ry/FbV+enhv2EPtOoAsWZRiYyTslgmvmhzFfjTcyafAg7AibJC96YEVoIkxjL
         aRd438tCK8diePANwnPY6ZFu/CyNy6aGZfKMAofYu+zvKAQ0ieLMp6PjiRlY3r0ArXPJ
         wFwEqbzpsFlbCoNEZJKRqZrzPwAwjaXE1x9lr5CsI8goWrjwpsFR4da9dKPiuZdIhnVo
         H7mA==
X-Gm-Message-State: AAQBX9cw6QLRWhB/+WD5ttk04bfC9VyvmQVWCt7ol2faMK4F/LUMnRJk
        y53smqlwZ+9v0hWWD2MehurBeQ==
X-Google-Smtp-Source: AKy350bu8YnYwg18cMuvag24DooQIAFYaj0Ey1Op3Ruxhphu9lurkoQl/DaunlE/8FmWJGqlyZdGUQ==
X-Received: by 2002:a19:c502:0:b0:4e9:6097:add8 with SMTP id w2-20020a19c502000000b004e96097add8mr9359450lfe.32.1680433328117;
        Sun, 02 Apr 2023 04:02:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id t18-20020ac25492000000b004cc7acfbd2bsm1237120lfk.287.2023.04.02.04.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 04:02:07 -0700 (PDT)
Message-ID: <33430a31-b9da-5f1c-bae0-9ec6f24fda99@linaro.org>
Date:   Sun, 2 Apr 2023 14:02:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/22] arm64: dts: qcom: pm8350b: fix thermal zone node
 name
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20230401220810.3563708-1-dmitry.baryshkov@linaro.org>
 <20230401220810.3563708-3-dmitry.baryshkov@linaro.org>
 <47efb05a-d1e7-a3c5-c423-4eb53fe86386@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <47efb05a-d1e7-a3c5-c423-4eb53fe86386@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/04/2023 13:34, Krzysztof Kozlowski wrote:
> On 02/04/2023 00:07, Dmitry Baryshkov wrote:
>> Correct the thermal zone node name to remove the clash with
>> pm8350c.dtsi. Remove unused labels.
>>
>> Fixes: 5c1399299d9d ("arm64: dts: qcom: pm8350b: add temp sensor and thermal zone config")
> 
> Please describe the observable bug from that commit being fixed here.
> Any future clash, which did not exist that time, is not a bug. It's future.
> 
> Naming changes here are more a matter of style, because the old names
> were correct according to our coding guidelines, just not precise (c
> instead of b). But node names anyway are not important from the point of
> view fixes and adding such tag will cause a needless backport.

It is needed. Including both pm8350c.dtsi and pm8350b.dtsi will result 
in one thermal zone overriding another one.

-- 
With best wishes
Dmitry

