Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0907BFB12
	for <lists+linux-iio@lfdr.de>; Tue, 10 Oct 2023 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjJJMS6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Oct 2023 08:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjJJMSz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2023 08:18:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC81DA
        for <linux-iio@vger.kernel.org>; Tue, 10 Oct 2023 05:18:52 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5859b2eaa67so3034582a12.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Oct 2023 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1696940332; x=1697545132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/uEl57rkB9FlUc8/Z3IPGgI3YZRBzcpqKdiv4r4u1s=;
        b=Lm8NHp89ZTc1yIw7DQiuYLMD2DwyugXiiwUDN6hC5oevK3OKa9X6nlPx+oNbDdAlqv
         d03Wey1yPycLxV1ADWVSCMSEEZUngFQZxPdOfx4u1nMAKLC0RGiEEdbrstfMqUEmAeIi
         D3pWh+gpsxJr7DxvqYf/UYNiNUwdBgDnvufwUm9yBopNRoffjsf0Z/0rzL1Aijj97poU
         1Pnl7yLDb7ghgZOtmFewjNbmw5srWcnIdiqh2IMrOq9jfiHlVNdhzmvk8hQ1ka29qWwP
         iBldJk5Xqs5l+eebWgGlyN+3WKYWK2uXvsod51ZYlzYwq2efiJ5N6nOJHHJL4KZqIrJR
         KvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696940332; x=1697545132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/uEl57rkB9FlUc8/Z3IPGgI3YZRBzcpqKdiv4r4u1s=;
        b=YLHXwOw2DAUn6NlLU+4tMKa4F0/dZnm4zIqtzopTXHEVnU1Mobps766WG9HCxX50B3
         dEzmeArFjMLImrWf1I/hQXmecSKOd6RubJWywSSlsV9SoUw72LA+rDVljhprcN8du7H/
         kxGT93C0tmyD61VZ/f1tri+fH45ihitLQTwUTz/ZMnOOywu2LlPTk/mtDuEjGHUEBzNp
         qscLV7GuEf8uyFDvZiKlrEQaUYYBZkPw0l/fNaJG4k9LHpGrNgT+Eh7t6Jt+/3Mk+OLY
         6T6/924qDl7jhLYXc/Q/+uxS1NpH51D88Kd5ZdWy/gMY8IAPIgORiF60Wi5K5eOiP+Nh
         9eSw==
X-Gm-Message-State: AOJu0YzgevdNAL/UwYe2mn7alCwmkx0dOE9Yl9AzKpdnoYSZHR80ARvI
        JX+57fHQHa3kOvgpDH0vnaZIIg==
X-Google-Smtp-Source: AGHT+IHw/JvHNya/HvLyiP3273/LTzyAj8keMwXYe74c2W6FN1+g3m3s4WDbkHEV195vAl+vK+qsew==
X-Received: by 2002:a17:90b:1d03:b0:26b:5205:525e with SMTP id on3-20020a17090b1d0300b0026b5205525emr14171953pjb.42.1696940332153;
        Tue, 10 Oct 2023 05:18:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:4346:670f:8942:33b? (2403-580d-82f4-0-4346-670f-8942-33b.ip6.aussiebb.net. [2403:580d:82f4:0:4346:670f:8942:33b])
        by smtp.gmail.com with ESMTPSA id ev7-20020a17090aeac700b00274922d4b38sm10128842pjb.27.2023.10.10.05.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 05:18:51 -0700 (PDT)
Message-ID: <83bb2425-aff1-6359-37f4-4182d4f8ed05@tweaklogic.com>
Date:   Tue, 10 Oct 2023 22:48:43 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
 <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <2c6ff28f-9031-beb2-f8d0-e7f12b0a07b4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/10/23 19:22, Matti Vaittinen wrote:

>> +properties:
>> +  compatible:
>> +    const: avago,apds9306
> 
> I see the driver supports two different variants of this IC, differentiated by the part-ID register. Variants are named as apds9306 and apds9306-065. I wonder if we could/should have different compatibles for them?
> 

Yes, we can. It makes sense. I'll implement that.

Regards,
Subhajit Ghosh

