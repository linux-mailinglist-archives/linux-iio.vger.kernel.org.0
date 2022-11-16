Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7440B62BB82
	for <lists+linux-iio@lfdr.de>; Wed, 16 Nov 2022 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiKPLYZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Nov 2022 06:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiKPLYF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 06:24:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA063D1
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 03:13:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j4so29011351lfk.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Nov 2022 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wLgF14FPV3MMp8MVY1j5SEgYli+B2HEyuas1yt3mYcI=;
        b=TKetFqG72xs6ufxtsSKBRPlPPUakkfH7z99Mbw7EISMf0QjR25oKA1NdDbN99tKWA7
         NZMwqmcjVi5HU0fuyB/qnFkso5Cs85ZibRbq/78cIUglXHWG1J8P+8jesIl2fYStmLhU
         G7P1h8pV26hjzQsniCFYa+G0DD4cxmUBAYkY5fQBfmcGPwCGl/WyTmTVvol1qmqzIRst
         SY0tY66Me8GXezWQyIvebVgfAHnbar5398E5WASA0gyOZEbr9VbxAWmg/xgr/WUMmP9J
         vACZNQ7dHU5Ca2cwF+eRLWi6udE6kxNmFH/jfVINogXbRAFdQawEoMtzOSXjfB3/NGgx
         kH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLgF14FPV3MMp8MVY1j5SEgYli+B2HEyuas1yt3mYcI=;
        b=vHVVZkMON8Zos76pQdKD7HfhwJ7Db68XIuZJZVqBqDiCOtEP6lkCJFa/EOgTSYb6QG
         MleuogbnGM/yCQ6tYXAPus59dzc1LxWmdnKnrED3t7ovtNyEstIIC3DJn2AWjkPhgmL5
         7USnJAQCKcQaYPa17ejCa3nThCSSQK2sSqfxiyFxkQ43Jyu5OCPfbd7vL9c6jDPjaWkJ
         WFFT3Wa3Az5NCR6TAnMCm78Ikm5nsTVKGkF2vS72qt1ibj2P0WOLqZGhgSngzGzUh0qp
         lVfrUvbWP5xELwE5+4p638TNogm7cdY1kzx2Amuw2WY0Ud2+hycIrQjnzxV3liB733v9
         PPqQ==
X-Gm-Message-State: ANoB5pnRfeCn/tf4/5XAkZVJazoNjKXAYWjMHi2tTEREeDD0UtN9dVUu
        Oi9MkpE1TgAY0ydNLKrPSMmZqg==
X-Google-Smtp-Source: AA0mqf6pWHapmtWXCvWQ+ycAbVsNQKPW6aT9onNGtzpGYOpC5dSpz+cHqCPl4fcDi3T3ed+VPSp4Hw==
X-Received: by 2002:a19:5e0a:0:b0:4b0:4b08:6873 with SMTP id s10-20020a195e0a000000b004b04b086873mr7729398lfb.329.1668597217301;
        Wed, 16 Nov 2022 03:13:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24201000000b004a44ffb1023sm2568265lfh.57.2022.11.16.03.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:13:36 -0800 (PST)
Message-ID: <8e0a9ef1-6abf-1073-0ee6-c60c313fad77@linaro.org>
Date:   Wed, 16 Nov 2022 12:13:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] iio/adc: add documentation for adc ad7927
Content-Language: en-US
To:     Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221116104453.3207-1-edmund.berenson@emlix.com>
 <20221116104453.3207-2-edmund.berenson@emlix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116104453.3207-2-edmund.berenson@emlix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 16/11/2022 11:44, Edmund Berenson wrote:
> Add the ad7927 compatibility string documentation to
> ad7923 driver.

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> 
> Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
> Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>


Best regards,
Krzysztof

