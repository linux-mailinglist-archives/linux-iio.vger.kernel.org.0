Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D72F6DED50
	for <lists+linux-iio@lfdr.de>; Wed, 12 Apr 2023 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDLIOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Apr 2023 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDLIOc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Apr 2023 04:14:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F90A101
        for <linux-iio@vger.kernel.org>; Wed, 12 Apr 2023 01:14:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kh6so9003415plb.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Apr 2023 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681287266; x=1683879266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tdz7ziJAx1J5fOg+gUbjH9qYWYL3+Fjw0+c8dzkluac=;
        b=Vc2BG658MmLcxZiSH+aVkLklMJRS85ZAoJWVikCJvOnk2fjH218RYLGRns6CHyX51k
         tNZ37a3y/VY6WSBvmkS1eEGYJiWnMqMuWdZuKi38CJUvWLdgrXFnVmBh4wwAbYDStoDp
         c5tJsxt5c11oDtB71H4cXXfc+TYD/acDORtRcQNbHqi35FVaiBWn8RTt84RmiIi8aJ9Y
         mFYOygGkPm7nTZkpMbsK+a2LGV3QutyXsKGqjS2TJVL2LOau7hesBaQ3QVRBz0FZ4Lzn
         8VqK/tjSbSKgVvoZ9QiVQWyQF70iYh8v6o1d7KNKf+AUCSybhSlXGKi8PTCvhsUyUhhb
         OJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287266; x=1683879266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tdz7ziJAx1J5fOg+gUbjH9qYWYL3+Fjw0+c8dzkluac=;
        b=U5hWtzDb3GHhmdOeHXGaKyPa5yLtOopqM0kMgAmq1s/SGK4gOXDz727akNgdMR4VEs
         AdhcxJBPXZ9RJF8b12s4PpkjP9OYaN6GgFTfWenZirke7lXLMEObGNRXZFBj2dBV92h0
         SUMZmceK4mR0vFknnLtAcuxMk+17fbzuCE8JU6EQb6yr+BEHTXuAEkXT/OBg/7mSq7Jx
         Fm5zxdMBJQwX7Fof8OVBbLeCAh24IUDK0RGsRpoH0R11sa7LHP87AyEeLCxtr2h1QIeF
         6se9+rOLo/1qLlzD2rpDgZZXZjs9cpjItv+78TPhCGr0bzRag7+oym/+NWeg6C0yqQIT
         OHOQ==
X-Gm-Message-State: AAQBX9cZg6F+enb4iJqDnpfcQl61I8cHRgSIloJypgLrEkicYbhAH5Ml
        6xoFXjKGrQ8FTriiQMvxB6rSLQ==
X-Google-Smtp-Source: AKy350bwirretxOjUgXWQfxnpm13d+NcWFP7kvr4Zrrq4AGPa/W4fP/xWA+HmJTQRxjqvF+mtocsvQ==
X-Received: by 2002:a17:902:ec83:b0:1a1:dd05:39fe with SMTP id x3-20020a170902ec8300b001a1dd0539femr19724889plg.4.1681287266615;
        Wed, 12 Apr 2023 01:14:26 -0700 (PDT)
Received: from [10.220.157.239] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902779100b001a19bac463fsm10978498pll.42.2023.04.12.01.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:14:26 -0700 (PDT)
Message-ID: <84dc7f75-8802-ef3c-8c61-b2e4e0bcfe04@tweaklogic.com>
Date:   Wed, 12 Apr 2023 16:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: Document APDS9306 Light Sensor
 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
 <7e98fefa-da9b-f07f-eafc-688b54011e64@linaro.org>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <7e98fefa-da9b-f07f-eafc-688b54011e64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Krzysztof,

Thank you for the feedback.
I will change the subject line.

Regards,
Subhajit Ghosh
