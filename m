Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E2B60620D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Oct 2022 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJTNpF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Oct 2022 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJTNpC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2022 09:45:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306550BBE
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2022 06:44:56 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g11so13695795qts.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2022 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhTsVyCoCN9J7vHV3+LHFRl6DSDyjLgInh88Ha3AdYw=;
        b=OkCy9t+DuyOUp1kiX5G08YdPsnAID9mOcGUnLsZZvP9ZRA05L15c+Bzopd4KOm6Sij
         y0ZMRB8Y/VyqckwpCV3PuSuFtEDFPEIHqWTli+mmJvlDD7eECDLcAfyvScT+DBiPmiOn
         SnZMm2Dl1WK8q88NJ1BKdLC5kdQC2147wMFzd/G70bOrPOCnjyNkOdQ0i8WDjLZM4lPO
         JKeRnFnGQaj64DuO8FI77AF9NWyPmvcpuQrmsS1k1x6JyHo/8IJWoQlnEP9cfGgRW9UK
         Jt3eOCR2/gULg173vgz8nHy0MESqEqmkZ8ylz4jH87o/cNiS1yhZQj4qZnREco+ORivR
         Qq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhTsVyCoCN9J7vHV3+LHFRl6DSDyjLgInh88Ha3AdYw=;
        b=L+kJB8+PcYU/32P3D3nxo5T5R5hnxEkalRZUIHtmL5/jCCLBHDCUAOhClJMpMiNZZQ
         VWIafW2AfBst9VyAEJxLCKzMy8Ki5dHUf7wsZz4omkZVLf0oCod24XBlaM/DmWTROjqg
         SSx0vaOxmL1Wa+wnRv6xAIWVX51wYvBXpYgejNo0dIESbKonkaIjtw7A6YyxcplxOjXd
         zbWMSZMRQ8qnqYTA9b/4z7LkoiWDUXJ1FGI0xSqL/UmuN4FFIPn5eA/znvHxwasRNFn0
         zec1UDlrrTQjW8XZSl375tjifz/llxyK79CqwyyzMckVI7TYzI10kjqbZ9W/eVg38Ij1
         nt7Q==
X-Gm-Message-State: ACrzQf2cnLBLy1KRMhx5LPrWcDe5bcgZkdwstB51oLI3gFaPoIgjTi2T
        xdWhUWHRImapREGyvV6/lzINsQ==
X-Google-Smtp-Source: AMsMyM6CrCDIzx17WZZfhiU5puqnAFNmO9pYHBMUjZkl4+2nl+iNtz8Fg0sMmgmCN95ATx8iULHI8Q==
X-Received: by 2002:ac8:5c41:0:b0:39c:d768:128c with SMTP id j1-20020ac85c41000000b0039cd768128cmr11031602qtj.269.1666273495413;
        Thu, 20 Oct 2022 06:44:55 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id az13-20020a05620a170d00b006eea461177csm7521184qkb.29.2022.10.20.06.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:44:54 -0700 (PDT)
Message-ID: <6f5465d7-a16a-6f07-98c3-526d3e16bc27@linaro.org>
Date:   Thu, 20 Oct 2022 09:44:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: Add KX022A accelerometer
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666263249.git.mazziesaccount@gmail.com>
 <aaf22c800b90f4eed1986782c8549bec5c9c72f5.1666263249.git.mazziesaccount@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aaf22c800b90f4eed1986782c8549bec5c9c72f5.1666263249.git.mazziesaccount@gmail.com>
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

On 20/10/2022 07:36, Matti Vaittinen wrote:
> KX022A is a 3-axis Accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g) and probably some other cool features.
> 
> Add the basic device tree description for the accelerometer. Only basic
> accelerometer features are considered as of now - new properties may or
> may not be needed in the future when rest of the features are supported.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

