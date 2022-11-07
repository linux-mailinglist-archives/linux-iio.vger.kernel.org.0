Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA0E61F466
	for <lists+linux-iio@lfdr.de>; Mon,  7 Nov 2022 14:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiKGNdc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Nov 2022 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKGNda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2022 08:33:30 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25221617E
        for <linux-iio@vger.kernel.org>; Mon,  7 Nov 2022 05:33:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id x21so16242633ljg.10
        for <linux-iio@vger.kernel.org>; Mon, 07 Nov 2022 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i57enyEe7YJLxfdkLS1d/5SoH8XBZS2h/SEFBvV1a/s=;
        b=LBOP4/YsGY2gsOLqZXMuCIid3YNS3ERQw1+TNRPToYNeLarezhiNLZxTGPa8CtBCzE
         7qxI1nN31qzHX0kBBF36DyNXoPZjXd9KcLSiT/O2U2/rJL70xIHPNeJBnywYvms31yWM
         cYlNM8b9AaEEywcgyo27FAKPu6ot9CUIrxrEmYRe/XY2UKK+Wg5106iCjUvVFxTdNiNL
         7XkefH4LRDWycRowZhRIzv0EWDm4aZvI9yoxtHbmhfMb4I4MVTZ8LRQ/7uEACsJNYNPE
         fuldMWRAe28gmfArUFZpifWHxxFGdesszPTl9NPpramSJgenmmUfMfMMXBcZR1/XOsst
         VM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i57enyEe7YJLxfdkLS1d/5SoH8XBZS2h/SEFBvV1a/s=;
        b=QnCif2wPv5oTqyez1Mg8lovx4GYzWwn5QZ3k/tbH0sWdNJjGeI9At/6QnvekYSP+oH
         Mjt7OO9TCViRrjEzxQ8DywFLyEYuc12f9KzQXtyrp8fXID+0N2qIhu6nGUHjWEWKqPB6
         CkSmwuP3v+RCa5opl1EfrSsPrKhcw/pTLqEidhRR+lTvy7hZ8BWJoZrB/SIVb/+rfE3p
         lYWsB2dlk7pfoauDmJ3TBRKJ+Zi9SkWtznZnplf/4U4AdqRsn+naENx7PRy07RI0cTDE
         8tEbktVYxQJe8x/t60j0uVIDeNvMUmpA85t+geh3KQTuCSY1l7BhyizBkX1Uk8VzXHxP
         rfeQ==
X-Gm-Message-State: ACrzQf3kcPr0nKUyN+xNmtnpe9JAyhfirAM6008jfR8MRDEI55KF4xg6
        eNrNXL3XrnGg/hkuk10dvKea7A==
X-Google-Smtp-Source: AMsMyM6ys2bfMq4DAdu6ozFPUfKC15Y60kr8o3Xu60fH9zr1JaGfkZH+Ia3+9cQ6i/DinUAtQBgA3g==
X-Received: by 2002:a2e:9c97:0:b0:26f:be44:5349 with SMTP id x23-20020a2e9c97000000b0026fbe445349mr5283381lji.348.1667828007386;
        Mon, 07 Nov 2022 05:33:27 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id 8-20020ac24d48000000b004998d9ccb62sm1250717lfp.99.2022.11.07.05.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:33:26 -0800 (PST)
Message-ID: <541d9d1a-5030-c68f-2fe3-6ea62b5e9eb2@linaro.org>
Date:   Mon, 7 Nov 2022 14:33:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: frequency: add adf4377 doc
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107120243.57344-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107120243.57344-1-antoniu.miclaus@analog.com>
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

On 07/11/2022 13:02, Antoniu Miclaus wrote:
> Add device tree bindings for the ADF4377 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

