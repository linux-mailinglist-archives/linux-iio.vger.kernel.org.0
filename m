Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8443D14B4CA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgA1NXA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 08:23:00 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43543 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1NXA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jan 2020 08:23:00 -0500
Received: by mail-yw1-f68.google.com with SMTP id v126so6445129ywc.10;
        Tue, 28 Jan 2020 05:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XkZYELoimGvZaAW5RBxWL7cGk2TFSREoOSfJlXIP9Vg=;
        b=ewsejym0mCr1Ke8POn4UD4mjF5wH29knENLueIwwvPdcbt+amzwmgCS3Zi0IDJaq0B
         yZfZF1/mznPPZOAxeL5C3Uw3ifQwUQh/pthk52IqTIUBdsuAVceDf9qzgBhuL6S3jtFh
         cT/FmyCtooXdfCOtYUxgjm5KapidE9WeFVxsuhu2VvnkFQXUChV3F1lRtAnscstgTXhS
         6J502JETrdA7ub9FfFGunvuYx7rSAs9MP/g/G1X0ofFynmPEdLp1TbKP+R0fMxm0lgI2
         kc/7g5KrbU3aT/6i1/5Po7a4Jl6rOEgnWaP85W4hbywy8YHT9tZPMBGS7dRvkk0x6Zlo
         Rhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XkZYELoimGvZaAW5RBxWL7cGk2TFSREoOSfJlXIP9Vg=;
        b=NxVH6rdW1gjVzYONtdJQB47mP+nJQKrgwfXVMjNkYUo3LAhI2LTGQL1l1WlLR3kCMq
         Y0bJJNwkNzaZDpfNdHg8x3TgxVpwIjv1zZL1aRVJ//sOoi1zETUt/L3jNq0uvmObr0ay
         wEmwv2AaCzuCp52+sFn6Ls5iW8wyqGvTy7hSSg7UCndkxuaLqEdr4t6nLXaUNKZEHRMM
         fSOFdsRTTTsJDzgRjsLqAtm8rqCQUNozY31wRJBvyVSZxE7WEZViFHBKvWSifTUp8Zey
         ggte5YbV5DNvPoP8UaOE8ZUvaL+lgIlX7rrb/S69LO3ikiNPsRX7GHtUhaVaAqLCPsgS
         LRsg==
X-Gm-Message-State: APjAAAVU6WAJ77N2EIVnrIQAyl4HIMkHsQuubi1QfpqtRRWgSRUPrpD5
        UsbMUrQ4pd/2noPmc0Qr4oAhQKhr
X-Google-Smtp-Source: APXvYqwUR5d09oL3MsIocx1dJ/ALYSnzLGEzt90SxTJDw3vrlpABD1JdKOJR+9gyt9+3SAPBZ4Kh4Q==
X-Received: by 2002:a81:1889:: with SMTP id 131mr14998832ywy.277.1580217778469;
        Tue, 28 Jan 2020 05:22:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9sm8364217ywh.55.2020.01.28.05.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 05:22:57 -0800 (PST)
Subject: Re: vcnl3020 hwmon/proximity driver
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cb21d1285e04a8a7a3817398629431f69aeebf2f.camel@yadro.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0e2f88e3-b7d3-9dd2-50ce-011be09d53c9@roeck-us.net>
Date:   Tue, 28 Jan 2020 05:22:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <cb21d1285e04a8a7a3817398629431f69aeebf2f.camel@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/28/20 3:31 AM, Ivan Mikhaylov wrote:
> Hello, I want to make driver for vcnl3020 but not sure where should I put it.
> It's similar to vcnl40xx series which is already in iio/light/vcnl4000.c
> but it perfectly fits with hwmon intrusion detection concept
> (intrusion[0-*]_alarm), so I'm a little bit confused.
> 
> vcnl3020 - proximity sensor which mostly using for intrusion detection
> vcnl4020 - light and proximity sensor
> 
> Doc's links:
> https://www.vishay.com/docs/84150/vcnl3020.pdf
> https://www.vishay.com/docs/83476/vcnl4020.pdf
> 
> That's what I think about possible ways:
> 
> 1. just iio/proximity/vcnl3020.c
> 2. extend functionality inside vcnl4000.c with ifdefs and dts stuff and maybe
>     rename it with generalization inside
> 3. hwmon driver for intrusion detection inside drivers/hwmon
> 4. both iio/proximity/vcnl3020.c and hwmon/vcnl3020.c
>     Example: hwmon/wm8350-hwmon.c + mfd/wm8350-core.c
>     So, just make proximity driver, do the depend in Kconfig for hwmon driver
>     on proximity driver and use proximity driver calls if would be needed.
> 

"intrusion" in the context of hardware monitoring is for chassis intrusion,
not for intrusion into an area. This driver should reside in iio.

Thanks,
Guenter
