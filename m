Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC3657D045
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jul 2022 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiGUPub (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jul 2022 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGUPua (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Jul 2022 11:50:30 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8423BFD;
        Thu, 21 Jul 2022 08:50:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id va17so3945058ejb.0;
        Thu, 21 Jul 2022 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6c3wcMiJrn1UM/DKa9aWRLXTa5crPxp/oNNs3aCcNXs=;
        b=AgcBH8UQYsZTIG65ZlYzGrtH6Ga+wem2ScqqwmgfJfNlywpwzuyTaO+63CL1Qbz/pC
         2vgRUsqJZ++f80NwPsYFZpkQYJ5pIy1yCJjNMgu7VJ7KF5Gfcl2ZssdyWEELCjFRu8r1
         EFZS3ytryXuvgSBNc8y07JJ6a/8QGjg24FoWxltjtXZhA7x9bRJVCHGezFu4SGl85PBj
         HWzszl5i1RlE5OkfvXvdLDDQ4hcILVv3CF8MXKDU/VsauRaxj4l7BMdfE3IMtAwXFo+s
         LEV5pohe8tJHblEZSUqgi7qSN7TSCgn3x4bukuvoMAzuF8pyQiAPVeJOIyu5/lFUZM4p
         zU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6c3wcMiJrn1UM/DKa9aWRLXTa5crPxp/oNNs3aCcNXs=;
        b=ocPYpl/BHcsJZ7dPoN3oY5++AgZYUT3HqulFvwIxP/680BloE4O/CzQIsYl76TZe1W
         zQU5EO+0/bxxJi1/rFDbIF+qmvZVTbu0sKcoIZ1DMAeKWMlKN2JIAJ8HtESdCbZqqJpf
         AXqC5s5z/lj7sQx3ciMH4ep1+I9uiWmTBjfUdI95ZAro4FL3h0bkkXEHqBXchs3TM/E7
         EJSHtWxEDOAeRryuVZcPjvw/QXvTmpBn5a0S4uG3obR/lee4x08iLTS68h8FNf42zh1M
         BYd17evg6bK4guRiKh1H205WSvc56sJWnXAdL6YEROG+i/jDlRWe8QNHXXdXaBOrnJXu
         l87Q==
X-Gm-Message-State: AJIora+nzn1w2GgaDI8ET+54raX0wRkqej9jGX/sHktlx0jioVRoKp0z
        fgfUP9CzfgwL+kdIo0WikdE=
X-Google-Smtp-Source: AGRyM1urL56xv/AChL16dVfmWB8ytt3oLC4MBYWwwMzMMEMwjiOuq0lKW67mS3sCGTi9n5Pdw0ZC3g==
X-Received: by 2002:a17:907:60d1:b0:72f:42a0:f3f9 with SMTP id hv17-20020a17090760d100b0072f42a0f3f9mr17538751ejc.727.1658418627918;
        Thu, 21 Jul 2022 08:50:27 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f6fa3.dip0.t-ipconnect.de. [91.63.111.163])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b0043a85d7d15esm1174731edo.12.2022.07.21.08.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 08:50:27 -0700 (PDT)
Message-ID: <7d20978f-e17c-9bea-1436-68bcf4bd8524@gmail.com>
Date:   Thu, 21 Jul 2022 17:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/6] Add support for mp2733 battery charger
Content-Language: en-US
To:     lee.jones@linaro.org
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, krzysztof.kozlowski+dt@linaro.org,
        andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org
References: <20220615145357.2370044-1-sravanhome@gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <20220615145357.2370044-1-sravanhome@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lee,

May I know what is the plan for merge this change-set !

On 15/06/22 16:53, Saravanan Sekar wrote:
> changes in v3:
>   - fixed dt_binding_check error
>   - fixed spelling usb->USB
> 
> changes in v2:
>   - fixed spelling
>   - revert back probe to probe_new in mfd driver
> 
> I do not see a cover letter, but FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for all patches except DT binding
> Note, some of the comments regarding spelling were given, I believe
> you are going to address them in v3.
> 
> 
> add support for mp2733 Battery charger control driver for Monolithic
> Power System's MP2733 chipset
> 
> Saravanan Sekar (6):
>    iio: adc: mp2629: fix wrong comparison of channel
>    dt-bindings: mfd: Add mp2733 compatible
>    mfd: mp2629: Add support for mps mp2733 battery charger
>    iio: adc: mp2629: restrict input voltage mask for mp2629
>    power: supply: Add support for mp2733 battery charger
>    power: supply: mp2629: Add USB fast charge settings
> 
>   .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
>   .../devicetree/bindings/mfd/mps,mp2629.yaml   |   4 +-
>   drivers/iio/adc/mp2629_adc.c                  |   5 +-
>   drivers/mfd/mp2629.c                          |   5 +-
>   drivers/power/supply/mp2629_charger.c         | 208 +++++++++++++++---
>   include/linux/mfd/mp2629.h                    |   6 +
>   6 files changed, 212 insertions(+), 32 deletions(-)
> 

Thanks,
Saravanan
