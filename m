Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2205795A5
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 10:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiGSIz0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiGSIzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 04:55:25 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA1B493
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 01:55:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v15so12842802ljc.1
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 01:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C5tPAjfHeyt/9nWoLPgh1ePITZuoZDz+EVcIyo6GRic=;
        b=P8EVvDbX+vDNJWC6YPt2XRMkePfxHBOFUzfB/GzDN/oWC53/JZTdvY+sNIcgefaM/2
         ayN+Ls1HhSfNOESiFimoo+GkbVw2v5gdmizhv5Kqgi6AWVd2haBSymVChNsB46/BnjeS
         DtWmBvvJieqSJ0TtQGxEOiwi3ZGDpfCawDQNmXw3Ha4F27zLk1Q9qemFsysx4DtHJv6c
         5XGEjB+IKbtC0XbETRdlMckSdGSBzD9UsMePRYT5GORVFXrlayLdzgGQP4YZDindAF1j
         B1Ei6DE/5TTcIUWOXT5KskVy9jFDoTTUNjkKkAHVEyAtWKh6sh1EtxLEqagVy9hqiMcZ
         eHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C5tPAjfHeyt/9nWoLPgh1ePITZuoZDz+EVcIyo6GRic=;
        b=HNekU6caRph3Z2OHGqgT0I1XITWTMW3Ly8/bXbY2UXJBFMig6zXHXgRVgRGH3p6rln
         iAYIV2tx1ZW92Ey/UtOS7jXDMIZRNkQI46zNXjk7mSTTLOigqyruTJnQ23JcQBigdrfX
         4DzAWIqyGNsOCfS07TFuuwVc6AzOmBpuTCjDyHsyNdD/M3yxf3r/OJn3JcwSJmh1e/z8
         fDWLmEBbKTuPyJ4rUfQZgBbS2B4UT67m9Z3bRT3XdmfKHfbzOVCryreUT5mTWbniaMAz
         g3jsERPPq2IZBi0DAeVbe+eQYzMMCkZAnn3i6zQwBkqJfVgQmcqtScz/C0+arAMDGCPW
         wfhQ==
X-Gm-Message-State: AJIora8p09iCRrQfGEDldKkDVAeuiabqJA7icwWFXe/7Rv4PB/BEgh+M
        FrpyIkf3lf06cQj4rEeAoVHwXQ==
X-Google-Smtp-Source: AGRyM1vKlIrJ95bllAqZdARLwJ8lPVKoeAGGpvR8DLdWf6hjC70dveXwiPaYs5ilNo5PMO6XSpemQw==
X-Received: by 2002:a2e:bf18:0:b0:25d:6852:c949 with SMTP id c24-20020a2ebf18000000b0025d6852c949mr14332401ljr.85.1658220922476;
        Tue, 19 Jul 2022 01:55:22 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id p21-20020a2ea4d5000000b0025a6e47056csm2579971ljm.124.2022.07.19.01.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:55:21 -0700 (PDT)
Message-ID: <c537ed21-92f3-4c2a-f775-66bc5421f22e@linaro.org>
Date:   Tue, 19 Jul 2022 10:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: Add compatible for MT8188
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     srv_heupstream@mediatek.com, zhiyong.tao@mediatek.com,
        guodong.liu@mediatek.com, johnson.wang@mediatek.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220719014657.28714-1-hui.liu@mediatek.com>
 <20220719014657.28714-2-hui.liu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220719014657.28714-2-hui.liu@mediatek.com>
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

On 19/07/2022 03:46, Hui Liu wrote:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add dt-binding documentation of auxadc for MediaTek MT8188 SoC platform.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
