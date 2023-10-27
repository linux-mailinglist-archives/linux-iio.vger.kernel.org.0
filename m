Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE27D9668
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 13:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjJ0LVP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjJ0LVO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 07:21:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F59C
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 04:21:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so1852633b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 27 Oct 2023 04:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1698405670; x=1699010470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpDUNO6+wJLZCjUYYtsZ7P6CGyOdEndsDNhhPRxxHyU=;
        b=gFo5EbVYclVt2BOhHsAfhX1lwRYLEnz4iJ5cx2jcyKjqZ/gkajsCeWlkCiS35b/Pfh
         cIFLn/t8uig2fMxYU6SRCEoEp0ulYFoyF4Gp1r4BvrepjzNzwnWNUXlOKKt2m5OaKGe3
         voI1twkrqkfpGTCFYU2IZ5qKvhDxw4rFKar6+A577ypKyMD62TGp9+g/rk7WMbkkkHv2
         RYgbFOiSww6nMEzyLj90LnQeJKbvwVYcn64nWm+0U/IPWwEhDZj71pNpBW0JgX0ToKDc
         Hhrcqmi9NwG2tWXXNNuvoTsRj/hGWOtFI74t8m8RfxHg3R48anqLokUE69owhnud5Y0i
         /5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698405670; x=1699010470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpDUNO6+wJLZCjUYYtsZ7P6CGyOdEndsDNhhPRxxHyU=;
        b=MDkGP5qxkCmzh9EDmjdv5DbUXnt0IIAMDQP6i6YxuZ9GXDL5hhGb5x4j94II2rxq6k
         yCJrs7FUCo/qPIp/7L0qLRd6dIjUBdiBJ/KPF880jhcO8R7R6FKcMEbvSKJ9QdmyIaIK
         EhQmiB/v7CL4fouY9cgvQgYmDWyGdMrqVdbDZ30cyH16ZpUmweMdykWnd/KqGzAFBga3
         iCVXHlWtFFt5rgGD7Y1shE1df5tB37FPvyuteiXmiUVGIIQwARXLcurrcenUT9I0loll
         FpBOyeXiNM51V8WQFXuurMcIzon+DdJeDDO7Mep6xRUdOkWonY0fEHe2/komiyZ9CLSm
         V3Hw==
X-Gm-Message-State: AOJu0Yy3s0Qog/Q8k++2t6H7m3oZJq+vnJIDTBGTEW1jubVagh2cDPS5
        N/3qhareZXP/jXrP7rFjZQT2Iw==
X-Google-Smtp-Source: AGHT+IHr0HKYNWFJCCBhhVhyiRbjtCdvuHG6iPglG2lzT2vGoYkwfMDkR0h8WZF0FS9efvG0I5A3lQ==
X-Received: by 2002:a05:6a20:428a:b0:16b:cc6c:d728 with SMTP id o10-20020a056a20428a00b0016bcc6cd728mr3267886pzj.44.1698405670213;
        Fri, 27 Oct 2023 04:21:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:c232:f53e:32d4:5510? (2403-580d-82f4-0-c232-f53e-32d4-5510.ip6.aussiebb.net. [2403:580d:82f4:0:c232:f53e:32d4:5510])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001b9d335223csm1324994plf.26.2023.10.27.04.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 04:21:09 -0700 (PDT)
Message-ID: <9b9addeb-230c-48f0-9e50-78d30adeaf9d@tweaklogic.com>
Date:   Fri, 27 Oct 2023 21:51:02 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>
Cc:     Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026143532.39660-1-subhajit.ghosh@tweaklogic.com>
 <20231026143532.39660-3-subhajit.ghosh@tweaklogic.com>
 <341cb934-2e91-442a-a4db-2f69f79ad0b6@gmail.com>
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <341cb934-2e91-442a-a4db-2f69f79ad0b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Hi Subhajit,
> 
> It's nice to see the GTS helpers are used (and hopefully helpful). I didn't have the time to go through everything with full focus - so please just tell me if some of my questions are silly :) The comments I marked as 'nit' aren't really important - feel free to use your judgement on them :)

Thank you Matti for the review.
Acknowledging all your comments, updates will be in the next version.
I am glad that you liked it.

GTS helpers are great. It saved me a lot of complex and error prone mathematical calculations and coding.
I was surprised to get consistent Lux values in userspace across all scale ranges which closely matched with
my entry level Lux meter readings after using the GTS implementation. Great work.

Regards,
Subhajit Ghosh
