Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851616DE8B1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Apr 2023 03:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDLBN1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Apr 2023 21:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLBN1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Apr 2023 21:13:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E0D3A82
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 18:13:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b145b3b03so86167b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Apr 2023 18:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681262005; x=1683854005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47JWytzW6tKcdWIVgQfUOvNuOZmwQBfMnKJsin47bkg=;
        b=MA7Xut+0Mx6aNBeny0ChuyEDSPMfHi4bBteGpR0FVrMUlIeSDOoE2V1p/Przhl8kBn
         8dOrZJtNGjmE3lIVZTbDkNsSl9LKyS31+761JHBkS1OnU8o4RGHS6Y9s8S9MfpSudTPX
         yWBWlEznDjV/a9FKMC04LXhYMTqogkqtJ+VWhEE+84nxJZUfEV6I7c4Z80I+NRrA4Wj0
         dhGVwqewj8eZk1xccDBRZJrlRZRmK/JOZB+rEHy9gthdSUsaTfs25QUrww6YZ8WHnJ4V
         TA9Afs7LV3R05TRTruJM5dXM3JMg8fF0+ovVPPsCF2FdlPX5d+q5EmL+7rXbLR3+7q42
         6IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681262005; x=1683854005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47JWytzW6tKcdWIVgQfUOvNuOZmwQBfMnKJsin47bkg=;
        b=sWbuBbSIMjBLyHWJW3WC3UyIwC38wPJzcOZLgj/Hi5c/mglXx7+6i1JXPeMp3PY6T0
         k7VyXMUvyh8ODgCGwmVpOo2VPb+agBgOe6UQBSt4o9Mc3FUqfe9+gw7Iq3MxKxTxFCu4
         9jVsBg5LpWQVk2jJfwfNzyvEv7pgSf0mEF4B+aWRYlbQcS23yZFTp2t1ZXROj1zP7m7W
         3Umxuh9PLpOU8uprSirk35oX4w7+gVX3JYKfVUszLBid/UHvEqq0m4RhXgB3RCqJAULZ
         3GV4OpfZD2VT+Ovx9cmEzyJJkXOtRqEUW9OnYJPnWmdRB2X2G7oQa//NtkNe6nOJjizr
         KpjQ==
X-Gm-Message-State: AAQBX9dyw8ENzSyDaUVAugZw4VLc7ZfSRfNmLmWXagTGDNVUszhl5taq
        Fsuc46JcAdGOn+ctwa3ngny1Dg==
X-Google-Smtp-Source: AKy350Z9WFanmSoSkJqt7MLlD83/KpDYo/Iu5TMx9ojeYnlRK6Z+dRcaNpYIucUkKTPdWYL5a0/oUQ==
X-Received: by 2002:a05:6a00:26ee:b0:63a:4ef:ae31 with SMTP id p46-20020a056a0026ee00b0063a04efae31mr1189875pfw.3.1681262005255;
        Tue, 11 Apr 2023 18:13:25 -0700 (PDT)
Received: from [192.168.1.105] ([124.148.71.115])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b00593e4e6516csm10410332pfm.124.2023.04.11.18.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 18:13:24 -0700 (PDT)
Message-ID: <f623ae8c-8821-9552-7fb7-06f6cc200200@tweaklogic.com>
Date:   Wed, 12 Apr 2023 09:13:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: Document APDS9306 Light Sensor
 bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
 <168121603157.2780605.18056732208268371049.robh@kernel.org>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <168121603157.2780605.18056732208268371049.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,
Thank you very much for reviewing the patch.

> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
Thank you for the above steps, I did not perform them. It will
be fixed in the next revision.

Regards,
Subhajit Ghosh
