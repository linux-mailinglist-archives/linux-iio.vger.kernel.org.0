Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BD8377298
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhEHPZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhEHPZz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 May 2021 11:25:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BF4C061574;
        Sat,  8 May 2021 08:24:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso10529931otg.9;
        Sat, 08 May 2021 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CQrb2ccioAuJwkBkkjkm5++a5tjwhsHDADyhrpZzW54=;
        b=t07xTn2HoLS9AeU1/ytNJoAPweLLNw954qEeA9gzfDz6O5k7lG48JLPMp1Vp+riTdf
         vWKbEqMesrhHs2YG4UMSg8WyGQvbrXbe2cwJjAwttIvVjG8GYmAuaW4Etf0Ai0Xtf1tb
         /YvfnVAywgDwjMhbgUMdv70rb/mtHgkkZjaRkRuzNhXsIGaVrLLdeJruaMGrFu/kp4kn
         cnka4RB6ya+6G1YOeD7UE2KHtHUcDsWi+yLMKBR4J/a8tPckQYKWk4tLVjOfSAtpVIMA
         r9ha3jLB06Qe1mAdOIu5/GhXlkjK6vNODwPVGptDq5ueByaux3lyKlqP1+Mpvys/khj1
         l+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQrb2ccioAuJwkBkkjkm5++a5tjwhsHDADyhrpZzW54=;
        b=R5JFn49g5LmY6sk7DHFlezze2rI6NSSf/H0DUaQkpsGyx/P+XgsxbDuSWXjjdzwpzV
         MOW/Gsb8mpYfXjJlysJwaCB2DgrwJQ/fT4jT1Xz5aaMyDjcK0F4GbHA78Fawnfa+EbJf
         W16uLW+Gd+5KPz2FOQOBC3x54t3aaPL9i9YFF5IKbxwfJ2XYGu13q6xHzWkreCwpsxfg
         6vg3w57SychHy0/1fkCSUZi2Bd2GgcFHJBwt7ExLNXWD1+060+FnocdZ5n4ISWnoYRvE
         7CHJY5IWMPTaEiQNPpvELkuJZYK/VkR41BBZbcMM+koTXDWBop/zJYUV0AC6g5RD9HmR
         J5nw==
X-Gm-Message-State: AOAM531MyP6ybOx0VCSylf9vzYXNZcjmPiUoYpvjLXWoh5sf7bt2WBQU
        kHEvjIVFxslA+G6HcqK6N9U=
X-Google-Smtp-Source: ABdhPJyr8ffp31pRO2niJ3tEPlem8Q6Wl/yZRlGmOHegbe6pcD/Ot79LBlaTTtZ61eDK3uWi1gMzmQ==
X-Received: by 2002:a05:6830:1505:: with SMTP id k5mr13714612otp.45.1620487490738;
        Sat, 08 May 2021 08:24:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r10sm1053663oic.4.2021.05.08.08.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 08:24:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20210506034332.752263-1-linux@roeck-us.net>
 <20210507103154.00006763@Huawei.com> <20210508030936.GA3879276@roeck-us.net>
 <CAHp75Vfa3GT9bnimxw7EJsJyRF8HZP3PGsUNikSScuNiU4qArg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] iio: bme680_i2c: Remove ACPI support
Message-ID: <27cdac1a-6df8-6650-17fb-7dcdeaed66c5@roeck-us.net>
Date:   Sat, 8 May 2021 08:24:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfa3GT9bnimxw7EJsJyRF8HZP3PGsUNikSScuNiU4qArg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/8/21 12:48 AM, Andy Shevchenko wrote:
[ ... ]
> 
>     If you like I'll be happy to send you the coccinelle script I wrote
>     to play with.
> 
> 
> Please share (maybe even thru GH gist or so?)
> 

https://github.com/groeck/coccinelle-patches, subdirectory 'acpi'.

With "MODE=patch", it "only" touches 258 files in the kernel,
and 43 files in drivers/iio.

 From the other comments it looks like we would need another csv based
match table, something like

ID, "valid" | "invalid"

to override the results from the published ID tables.

Guenter
