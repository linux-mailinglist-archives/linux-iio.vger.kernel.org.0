Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18962B5BC
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 09:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiKPI5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 03:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKPI5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 03:57:06 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4E1142
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 00:57:05 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g7so28486957lfv.5
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 00:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7WaCkJfBU1XrjLx/laORO0kFx0/ouT65DQIux3eehM=;
        b=yPwsSCdLChMt44FWg4kEj5FFqhBjRc3q7wcpmfnqZGhaEKwekmBnNYFK5N+NqYq1dJ
         dk2QKTqJmhSXeNSZTsif4XBRRWh9DveM5mgZ3R1zY0NcbTRnF/T2o60hDvYBzJcsZNiw
         QB16tGOptREK1HjKZZQ6/JoSx06ycrn79tZA47PX6tzUA2Xzel8n+0xVwMvXirVHhePL
         62DsgPqSpC2+x76pAsCxh3LU+7sU+tChsyd0Mb2PuCyIMphBGZ1UdqXX33mHkYGRbE78
         iOPmEFduZrTVDeWpUqzO/MiYTqIGXAO+he6QpsPPjbAlWUGBE6SD3NC3EKFIuPegjStJ
         EazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7WaCkJfBU1XrjLx/laORO0kFx0/ouT65DQIux3eehM=;
        b=ur2h6ZNVcFN94SGAD5GwyMqqaFHdA+5JhkiXtemETM3DONxmw7O1dZ6K/r7/4zk3gc
         sD2gTAn9mJA1MjuY90pUMQHcwdjNl5tFO27JZ6NP1UIFWyX735Yrj9gWQ1LU8CSN8xq/
         3FOK1ixISMlSwkB/zern3LVvSjzmTsWRFJM6u9a3GPNmEjDpqMqPiAp9GIkHNQzTihia
         DlL4Nm7EiyFmosEvL2gurjXo92xPcfbrbq3npp1zg0wUKuWGgdriChH2+W5xKSPZK6qp
         p9GiuAU2GjDPExaXB3ViVAh/q2sbwgWogQjX/ApLa1zOx97wWRfBGyzvEZ1nLTYzKavr
         fezQ==
X-Gm-Message-State: ANoB5pkbed/TuTsyCl/+U5x9/Rf0EAJcD/DmWARDIEGGSKDd/gQBSQd3
        n9tcJec0vMGv/qu546khzarwPA==
X-Google-Smtp-Source: AA0mqf5sxo91obHx/cnFnXf2THhs58wsaasMnEBM6EyLxWfDwrftz5rLdNgVJ/zSP+jll/bM673GlA==
X-Received: by 2002:ac2:5f89:0:b0:4a2:c2cf:a297 with SMTP id r9-20020ac25f89000000b004a2c2cfa297mr6407307lfe.286.1668589024006;
        Wed, 16 Nov 2022 00:57:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k14-20020a05651210ce00b00497a3e11608sm2504897lfg.303.2022.11.16.00.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:57:03 -0800 (PST)
Message-ID: <513a2dc3-d053-6e4b-a125-394cf1f6c81b@linaro.org>
Date:   Wed, 16 Nov 2022 09:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 05/11] dt-bindings: mailbox: qcom: Allow syscon on
 qcom,msm8976-apcs-kpss-global
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-6-angelogioacchino.delregno@collabora.com>
 <14947ae2-c8d4-de86-ce9e-29175e73cbb2@linaro.org>
 <9f3e88fa-0aaf-2edd-366e-c3f5b2269dba@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9f3e88fa-0aaf-2edd-366e-c3f5b2269dba@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 16/11/2022 09:52, AngeloGioacchino Del Regno wrote:
> Il 15/11/22 17:44, Krzysztof Kozlowski ha scritto:
>> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>>> MSM8976 supports SMSM, which needs this node to also be a syscon:
>>> move the compatible to allow that.
>>>
>>> Fixes: bcc8d70f912d ("dt-bindings: mailbox: Add compatible for the MSM8976")
>>
>> I am not sure if this is still a bug. Maybe just a missing feature?
>>
> 
> This changes how you use this mailbox across the entire devicetree (as other
> nodes will not use mboxes = xxxx, but qcom,ipc = xxxx as syscon), so I think
> that this is not a missing feature?

Whether it is a bug depends on existing usage. If none of msm8976 DTSes
use it the other way, then it is just incomplete or missing support. Not
a bug. If existing DTSes use it as syscon, thus you need to add syscon
to compatible, then it would be a bugfix.

Best regards,
Krzysztof

