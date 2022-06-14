Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E3954B89C
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jun 2022 20:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFNS3j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jun 2022 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiFNS3h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jun 2022 14:29:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7E49247;
        Tue, 14 Jun 2022 11:29:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z7so12818991edm.13;
        Tue, 14 Jun 2022 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2hbagPy9DfCZIv7VzDsALXlfqRYHeR8658DIeJPqY1I=;
        b=Zcx+NxgKFFS0rz5/5ceFaZC0nRDR8x0TrYoQT1b4YSoye7qmTi+ZtWLJE5i+XFSBIy
         KBJXKqJsYGLrT+l2jghrDiaYNBEznL28L21Af9X4Paz+Yhd4lVyrH9AX5NsHWKLJwsbn
         MAuF9NDaFbg8iTBtVaS0XRs8jAhzjJDVoCCHgvZDA3k7T8PZn6WlEnSPbVgN4D8ky1yQ
         OgRY5rUrYzoWKeKkv/m+0FCpKIStZ56StzGpYgvCqvwFOq+PRRdMo9Wh6NE7GcmbY3Q4
         2aHGT4rJn+W1Y7z/eswomKzHUj/mWpAJj6fqSq7e3iX6cHVL1R33NIELJdUGEyQ+lCAi
         Lysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2hbagPy9DfCZIv7VzDsALXlfqRYHeR8658DIeJPqY1I=;
        b=WfuOBWIl/j39mBlaKmHcLOtxpGAQaLLF+LjU58McOGpXLEkX4EC9SlanX0TqFnHkAX
         aQb3oIuMVI4jL2VNQSgYVdHtv/2YApKeB1eUKdeWG34paBrXoXEfnSl65b+AM59bbw4Z
         QooJDb+njvKASqxWBCrkagSp0R8ayCm+QYafeOpPglbCwt8Cl8kBilGh9ob51uEbLa+z
         wK2dKEX+qIvuT8/72WnxTzfeQDxACoFt3G7CrYePZGeplWjS+aKGBKX16l7AvgO5h9o2
         eecJAxMcG15SuaiOb132a9H/9ZnCHjq+Cg2k48ODFpTr1nYImp6kU8UseDWMuX8D54W/
         s9Ig==
X-Gm-Message-State: AOAM532PTJgH8u+pMz8ewc/CWB+zWpQAft/u91armto3vs9VujqeaFCk
        FhVfwPYls9UHopnAbvM13RM=
X-Google-Smtp-Source: ABdhPJz+dWkxfnadgXrn6xX3lRffeVZwFY/donfPDomsyNzbT80reRO86qqnwzJKVSKcxi1X5krB2g==
X-Received: by 2002:a05:6402:1cb5:b0:42d:ddda:7459 with SMTP id cz21-20020a0564021cb500b0042dddda7459mr7827087edb.16.1655231374220;
        Tue, 14 Jun 2022 11:29:34 -0700 (PDT)
Received: from [192.168.0.104] (p5b3f7f9c.dip0.t-ipconnect.de. [91.63.127.156])
        by smtp.gmail.com with ESMTPSA id cf15-20020a170906b2cf00b007072dc80e06sm5235207ejb.190.2022.06.14.11.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 11:29:33 -0700 (PDT)
Message-ID: <5efcbaef-2ab9-9507-b3ab-d173ed350979@gmail.com>
Date:   Tue, 14 Jun 2022 20:29:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/6] mfd: mp2629: Add support for mps mp2733 battery
 charger
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20220614151722.2194936-1-sravanhome@gmail.com>
 <20220614151722.2194936-3-sravanhome@gmail.com>
 <CAHp75VcaU-KkCGZ0tczM6JKaVdGC6icGt0pbpC5sTf+0+ePamQ@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
In-Reply-To: <CAHp75VcaU-KkCGZ0tczM6JKaVdGC6icGt0pbpC5sTf+0+ePamQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Andy,
Thanks for your time to review, I try fix all the review comments

On 14/06/22 18:05, Andy Shevchenko wrote:
> On Tue, Jun 14, 2022 at 5:17 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>>
>> mp2733 is updated version of mp2629 battery charge management
>> device for single-cell Li-ion or Li-polymer battery. Additionally
>> supports usb fast-charge and higher range of input voltage.
> 
> ...
> 
>> +#include <linux/of_device.h>
> 
> What the original code misses is the mod_devicetable.h, and also see below.
> 
> ...
> 
>> +static const struct of_device_id mp2629_of_match[] = {
>> +       { .compatible = "mps,mp2629", .data = (void *)CHIP_ID_MP2629 },
>> +       { .compatible = "mps,mp2733", .data = (void *)CHIP_ID_MP2733 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, mp2629_of_match);
> 
> No need to move, see below.
> 
> ...
> 
>> +static int mp2629_probe(struct i2c_client *client,
>> +                       const struct i2c_device_id *id)
> 
> Why out of a sudden you moved from ->probe_new() to ->probe()?
> 
I was experiment to pass i2c_device_id table to differentiate, the used 
compatible. I will switch back to probe_new.

>> +       enum mp2xx_chip_id chip_id;
>> +       const struct of_device_id *of_id;
>>          int ret;
>>
>> +       if (client->dev.of_node) {
>> +               of_id = of_match_device(mp2629_of_match, &client->dev);
>> +               if (!of_id) {
>> +                       dev_err(&client->dev, "Failed to match device\n");
>> +                       return -ENODEV;
>> +               }
>> +               chip_id = (enum mp2xx_chip_id)of_id->data;
>> +       }
> 
> This all is a single LoC only + property.h:
> 
> #include <linux/property.h>
> 
>       enum mp2xx_chip_id chip_id;
> 
>       chip_id = (uintptr_t)device_get_match_data(&client->dev);
> 
sure.


Thanks,
Saravanan
