Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0831A6D45
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbgDMU2X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbgDMU2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 16:28:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7015EC0A3BDC;
        Mon, 13 Apr 2020 13:28:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a201so11031326wme.1;
        Mon, 13 Apr 2020 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OeSCZwWNk2GdRWHlov24w7UM8GmbVCkWur+VkAQ99Ws=;
        b=YqWmshBWMn5UQPyWR6yFC9tNGVDjCnDDqf6vO3QvUYuCMcT3DbsyegS6Lzn6jSd2l3
         exDcDzzVZyGFdxHCGJe/6SxS8xMI24PIvd7Ps3W6QzmnUiqx1UXvlnqzCSUfncl7vgpf
         +0nl2fA/Gvz42Dsjuv9CBUtiV7wCaY5lMWPPGbbP15UlKkAOyZgmHc+ikByQQoSzOJwh
         knoHHbBD3/KdOK0xSccZlUj/prmwsuZwz2TgFn75OCqmQJ8y4fOgUuqN0mNsN8fKDQ/S
         Wm3o0kATyf+J914fkYoDEHcw8YjiE91lviemmzvc7K7pQ71kDOff/Ql0nX5y0DHkehoh
         oB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OeSCZwWNk2GdRWHlov24w7UM8GmbVCkWur+VkAQ99Ws=;
        b=ACylyUOGmxGyBfL655J6/zqS8pEaP1AxEup+1qapcpqRQ+z0W4GoSk/1NQq0UILfNv
         NtPxsIU+dK2/lhmAN2HAlrr5D7aZ/zGRsQOzCDssMjfw212AQqwHdbDkh7pGZdvJQtOB
         RPm+Pp+gcy6tmspAYL3RuiB6EUdtBG3UXPTRrOBeuL6/jvW5KEzJvTMGzNFa6rmZ4Pem
         uHOrC7ikyducFXPZwYmg2DLYnFuL/wzkql2R60KsZOtM8iK9AgrpRZS3QkREiZ709MfM
         LPgFIG0hVFxQYlXfAC1EtsC+DnJzjLUflmna8L7BBeEX1P3NZ7Z4Hp9v4srndoiq+PqO
         /pmA==
X-Gm-Message-State: AGi0Pub+3PJkV4kj4fGNF9HDGGMA5ReJaayfRDfVUcywh9QQFi+yrSM/
        MzwowL9jPQ7XLCINOEVDvjpEHWOz
X-Google-Smtp-Source: APiQypKsqlZyeqoGmxf937j+AErRAD4Dp8Mb4+omURIQxGq99TgD8GoUXTrKM5dzVydg0OeHnx5nQg==
X-Received: by 2002:a1c:f218:: with SMTP id s24mr20142974wmc.98.1586809700701;
        Mon, 13 Apr 2020 13:28:20 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6AD5.dip0.t-ipconnect.de. [91.63.106.213])
        by smtp.gmail.com with ESMTPSA id c1sm15380322wrc.4.2020.04.13.13.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 13:28:19 -0700 (PDT)
Subject: Re: [PATCH v8 4/6] power: supply: Add support for mps mp2629 battery
 charger
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20200413173656.28522-1-sravanhome@gmail.com>
 <20200413173656.28522-5-sravanhome@gmail.com>
 <CAHp75VeYFY1CW4AH+D4HAgzppMZ5J8dL8kKPYmcwsXNVGNSYjQ@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <6cfab0a6-c3eb-bd9b-6572-b49e3205524f@gmail.com>
Date:   Mon, 13 Apr 2020 22:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VeYFY1CW4AH+D4HAgzppMZ5J8dL8kKPYmcwsXNVGNSYjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 13/04/20 10:10 pm, Andy Shevchenko wrote:
> On Mon, Apr 13, 2020 at 8:37 PM Saravanan Sekar <sravanhome@gmail.com> wrote:
>> The mp2629 provides switching-mode battery charge management for
>> single-cell Li-ion or Li-polymer battery. Driver supports the
>> access/control input source and battery charging parameters.
> ...
>
>> +static int mp2629_charger_probe(struct platform_device *pdev)
>> +{
>> +       irq = platform_get_irq(to_platform_device(pdev->dev.parent), 0);
> Why not to use temporary variable dev?
>
> This should be platform_get_irq_optional().


Platform_get_irq in turn calls platform_get_irq_optional. It was 
suggested by Lee and is it mandatory to change it?

>> +       if (irq) {
>> +               ret = devm_request_irq(dev, irq, mp2629_irq_handler,
>> +                                IRQF_TRIGGER_RISING, "mp2629-charger",
>> +                                charger);
>> +               if (ret) {
>> +                       dev_err(dev, "failed to request gpio IRQ\n");
>> +                       goto iio_fail;
>> +               }
>> +       }
>> +}
