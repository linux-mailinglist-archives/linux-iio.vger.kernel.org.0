Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72F16DEC4B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Apr 2023 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDLHMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Apr 2023 03:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDLHMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Apr 2023 03:12:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADBC5BA2
        for <linux-iio@vger.kernel.org>; Wed, 12 Apr 2023 00:12:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f26so20239122ejb.1
        for <linux-iio@vger.kernel.org>; Wed, 12 Apr 2023 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681283533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20NxWQfu7PegmR8o2TW3jbG60xzKoW5JlKk1pLi3MVk=;
        b=ifEb6C0R/XP32vAVfxk35tZQ5NEGs5Ujp8nvXHAWnyQmhEA1nhPNI+njR+Du2uqEKx
         K9S6X8zj7ofPflCfF+S7KsKfdSBEbFzxsKyayAhNslmRbeJDD1AI4H9B3h1r6eeKAlMe
         JT0OIiAqSJ/oQu++Pfm8WyUPzXPXbyOW1YSH5rVR3IxWb6y/D2nWuPjXb/OpRnRLkfoe
         f6Y/2aoPonjexPDPAS7RgDh1Xqw9zrwsUxE7RZeXthRs3C2zEtgjljVt8FUI8UKIWWun
         vKYVO7y5HuBnFwajYudTuMWVh6XQxMC8CqJxtSNQAv0Qa7wa8AO2i3ShZvVNRdpTC1t8
         5G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681283533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20NxWQfu7PegmR8o2TW3jbG60xzKoW5JlKk1pLi3MVk=;
        b=7iUfKogcrqh5RY8ZuqhAed2yPnqE1cnn3K0b20tC+GB1Co7BQyMv3yPVKgu60P1qqK
         TZnoTAel6R8WltSVIKUI1cfajrGU2MUkADyEVnJZON+tQtLJcjf762dz4BqnR5Zef9US
         nHqj8k/RqnS7/IaXLHf8DjkAL9Nxef3sGGl6VX7QkainatifoFO/xxG2bkCdDEbgEefI
         +56VSTAo4nAHhfBWc7+JrDuHHHVog47fTUiDY0U0TgGaT10iPHAfqXM24JlWvw3twOzi
         IgmTQP3aquDMjm30zKaFvANA+1LYbTXKtGzkM6oe4Mt3s7RcatAotpWuVfBleJftUlta
         KPxg==
X-Gm-Message-State: AAQBX9fahwCDs3Q52Y4qilkCavwAuLlMakKdzULCdSdEeajoyt/0BlbR
        aVSpssjunJpDZMyWDrg8D2ZIxA==
X-Google-Smtp-Source: AKy350YmkEI2tgNQNV4yU8eK/xvG2fPNOxH4v21/n+cYhBNKjefVMOQZN5nw5RA1THkfprKhX879kg==
X-Received: by 2002:a17:907:8a24:b0:94a:3ff1:53ad with SMTP id sc36-20020a1709078a2400b0094a3ff153admr13430307ejc.75.1681283532867;
        Wed, 12 Apr 2023 00:12:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id nd11-20020a170907628b00b0094e570909c7sm438648ejc.67.2023.04.12.00.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:12:12 -0700 (PDT)
Message-ID: <7e98fefa-da9b-f07f-eafc-688b54011e64@linaro.org>
Date:   Wed, 12 Apr 2023 09:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/2] dt-bindings: Document APDS9306 Light Sensor
 bindings
Content-Language: en-US
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/04/2023 03:12, Subhajit Ghosh wrote:
> Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.


Best regards,
Krzysztof

