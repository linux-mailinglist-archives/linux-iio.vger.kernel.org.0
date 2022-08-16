Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90612595907
	for <lists+linux-iio@lfdr.de>; Tue, 16 Aug 2022 12:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiHPKzP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Aug 2022 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiHPKyv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2022 06:54:51 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A53D5A8
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 03:22:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x19so14294269lfq.7
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2022 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6y2krG3wAEmTknGGh9SWgv5ytZ0gHA2IN3Cns5M9GFw=;
        b=BtvhQgdITP9SVWq42oqxksbehGD1ih5Kbh9JO7DR9OnzuTHyzSYHB6tux+eSg54c8R
         /YYmMWImRp4q7iTHdyI5nHBhTJpLt2la8nLT0azQB5jK/LsSjdUnIQoM/3zv3toE+EpI
         YZ7zs9n4oNjIvf/+FgEx4t1GK4fsgric7tF1bPURpLnWGynjTeaurVY8oNs5Tiv6XpDm
         dAYw7Vm9fDYyInafZtJFjtfbeoUNRvIrPxMODgXeD/01TQWY3KvDwtzV4cE+Iz+LgdQS
         1XGyVCCU8wfLF08ObAyR7JD+vAwdJWREjjtaWjuXC1TkqV7+pMrWWfb/pTcvOdF9m+rn
         knvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6y2krG3wAEmTknGGh9SWgv5ytZ0gHA2IN3Cns5M9GFw=;
        b=0MVXZTsTdbFQkCW8f8Q9oxzXr4FRXeP+RJvk75kVzL377mQcrB4B9CCLYxtWZHJChX
         gAoNCI7pxrJV/vfclxEH8e6WPQLkRez9pFZL6eZlVffWngsPSqqjS4szPhMJcrXsPQ8s
         LRHaFmcNQX7TcYEI7sdKfrVYUw2FiAIvoPhM5+3oIoUUzjYMTwtXQbZgA2eZcnjZLWkw
         JpyYCteBKfVSwKfh4hk8jXcTPRU8GCI1bNzXEbvfR5W5AJRs00qrwD+lp+8/Hk5jqNsI
         gLYyn2ueAvp3HBu3NSg8Lr0EfvUW0rVJkYAKflp4LIG/qjRgOdtLP1D4BUK2r0r/Ryeo
         OXVA==
X-Gm-Message-State: ACgBeo2j+Fi+djX4UxBRfd8/RtMigQpP0VFZ0MXkmGfuAMXJFuwjDYBC
        d8YwAKLYf+yH6XhKWCSQwyD6HZrS6RN/k0pU
X-Google-Smtp-Source: AA6agR4DMyXo52/nUb1RZwWnixhPJUeaO3FFQ4Es1RNWx1ag+phFlD/ZNuPsKviV0NRpDtSdDjSUeg==
X-Received: by 2002:a05:6512:22c3:b0:48b:882d:15b8 with SMTP id g3-20020a05651222c300b0048b882d15b8mr7147821lfu.459.1660645353651;
        Tue, 16 Aug 2022 03:22:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1782:dd68:b0c1:c1a4? (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id a24-20020a19ca18000000b0048a7ce3ff84sm1332728lfg.285.2022.08.16.03.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 03:22:33 -0700 (PDT)
Message-ID: <99d7784e-e59f-b4f7-e275-935836e5d406@linaro.org>
Date:   Tue, 16 Aug 2022 13:22:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 0/9] Improve MCP3911 driver
Content-Language: en-US
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15/08/2022 09:16, Marcus Folkesson wrote:
> v5:
> - Drop remove function
> - Split tx&rx transfers in mcp3911_trigger_handler()
> - Moved Kconfig changes to right patch
> 
> v6:
> - Go for devm_clk_get_enabled()
> - Cosmetic cleanups
> - Clarify the description of microchip,data-ready-hiz
> 

Please include the diffstat (format-patch does it for you, but if you
prefer to use other tools - it's your job).

Best regards,
Krzysztof
