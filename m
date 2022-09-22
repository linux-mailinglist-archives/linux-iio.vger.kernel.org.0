Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BD45E6C8B
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiIVUBl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiIVUBQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 16:01:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA65FD58B3
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 13:00:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k10so16472766lfm.4
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bCiwncdJqpgb7P5S0TpB+XoxsRbwUn8DYxI3YMSkMYo=;
        b=Oz3qvEbImSq37OahCNhMXoxa17l4RsmfMka4I2qV64tzP8WMpgSsGh72D0pIjj8qSF
         epTs/qEwjjLK6Zqqm6KlRzSPs+FiADmskRniIqzPqOfJGDDwMlqPf6obSYCyJcjjFHTi
         VD87fkCuSSYgU7DuWaBoNUB215GKhzk1voxijgADgLZu8KHTS0lxNLsGcMl/XbnjY4PD
         uSbi5wxR2U3Qdjn+TN0c/lxFtSL1lGkYi335LE/hFEwA+ZnYscH+io8O7fqBl7SWTO08
         c+HpyZdId6Qiptr4HUADDosiWM1leoJ5N+bnJ9J81/4d382SPX2f1oiqwG5p5d5PJ7sY
         czeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bCiwncdJqpgb7P5S0TpB+XoxsRbwUn8DYxI3YMSkMYo=;
        b=t89xs5cjLVkQIrUNVuFuNaScEOt3OehaellGhiiLUYV+FGZyLQ6dt6QtIG5Hr1XB6K
         VOCJDOIyLCtT5tkgggVwOcyx+5Kwk9cT0ayTsGZVkKRkKp7X9glE7NHKhwUwaejlC7hB
         Jc8RAnm9T578V6rqzzyBy8fm1ZQEpeZEVZ96cD8x0vIbc1ebQcJ/qGMFmARamig4f6OU
         tSV9cUB95ol4A/AybKNKpC0pWWeL7cw60YLOf8ZIkOH8ra5dOFcSq9MOlb1LqyPxrxfP
         Uwzy5lOysEz1/ve44VkEdXPGNCAPgZ/MjNiyW7xxm+Myvsl19nUPQa7KEp744f/FuDY9
         7h4g==
X-Gm-Message-State: ACrzQf0epyDcSHGo7x18bucVnYM/Nbv4/4WUjYiSa4gWaQB/UNMCcwJK
        XWW7YfDXxtOfi7L1KeO4/Zx4tg==
X-Google-Smtp-Source: AMsMyM6kYBsTTyEGQHfEM6Eu0F5XL/gHvYhJKxDc+Ge+NexsZ7VIKkmMofK72J3j3lDrnsrv3KGXRA==
X-Received: by 2002:a05:6512:6c9:b0:49a:51d4:d517 with SMTP id u9-20020a05651206c900b0049a51d4d517mr1972732lff.329.1663876818804;
        Thu, 22 Sep 2022 13:00:18 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j16-20020ac253b0000000b004948378080csm1074393lfh.290.2022.09.22.13.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 13:00:17 -0700 (PDT)
Message-ID: <a34d9ee8-8bf8-3158-7fe6-cbde513aa1a7@linaro.org>
Date:   Thu, 22 Sep 2022 22:00:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7] iio: adc: mcp3911: add support to set PGA
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922194639.1118971-1-marcus.folkesson@gmail.com>
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

On 22/09/2022 21:46, Marcus Folkesson wrote:
> Add support for setting the Programmable Gain Amplifiers by adjust the
> scale value.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> 
> Notes:
>     Based on
>     Link: https://lore.kernel.org/all/20220815061625.35568-1-marcus.folkesson@gmail.com/
>     
>     But with tmp0, tmp1 and tmp2 removed as those are not needed.
>     Link: https://lore.kernel.org/all/202209220648.Wb6EtPat-lkp@intel.com/
> 
>  drivers/iio/adc/mcp3911.c | 104 +++++++++++++++++++++++++++++---------

No need to cc-us. Use scripts/get_maintainers.pl.

Best regards,
Krzysztof

