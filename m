Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B19F2D4AF6
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 20:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgLITuY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 14:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbgLITtY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 14:49:24 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35754C0613CF;
        Wed,  9 Dec 2020 11:48:44 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v85so3017644oia.6;
        Wed, 09 Dec 2020 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=19G5L9YUDXmxI3uSq/S+oJKSbuLCcM6JRD0UmuNglzM=;
        b=acQ5wZEedJ7MuUO73ClQhDhIhaivdFvMPo9Ss7yiZYI+CZ59KtWvIbQmkFefSMexlr
         LJMGMpzTv+3d+Od1oWUnWe4IP2AH+Vz5SaT0LV18GYB4hZB+8D57halSB9WOJjWiRL5u
         wDqqjA3FSQduxstz+FSHbAG7FBnyguFiHcjYfgLsX+76Fs6fiTGJ5ZHdNF7vWZUw9DPb
         04H1GsTA7HksNm7Tskwj6Ax0NF254qzwhBBfuVh+nvvVCAoeUhaQnWJdvz1kB6DAJpIH
         bJlpI6VGKHYRTSk02VGdZ46vWMsrUSuP4nS1AaOmF3I1Vj4y01claQVNrBvQL/GOqnVC
         gAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=19G5L9YUDXmxI3uSq/S+oJKSbuLCcM6JRD0UmuNglzM=;
        b=EqV7cxdy5DdJ757kDj7VMzn1naKWJ8cbIceRORU7dF+WmNc/tsm3x1qMggsp7OlmVA
         1NutHRMx1L9uTtWSeoMrDM5fiSoazgaIM7ZwQBXK/Cfkwsv/l1nuQ86sjquWuMnxmpXY
         CALTfqBF2a5aL3sj1Xz42Wg4b5sJbZU8Ft4ieg3NgM2iE/R2xEYCOMX+gE5KR0wisvvN
         Cid6VKRyMbZVazGHwZPSBnn6B266MuwWkXNmKEX7iGkJt96Xe3mR0O00fHBtaWigB+Bn
         V3T2sVF+vFBTM+gZFEcn+JmOdiSe/EmcvrXg6Y0181y21QfSjHa4Vx0mH/vXyqtniUfW
         5p8A==
X-Gm-Message-State: AOAM530rsLV4LBnImkSi7+Se7TErsltR13s0sXeF3anELhKO2KwJP0yY
        NRWV7mD64OwEv7CK4H6WDqBq7u4z6L8=
X-Google-Smtp-Source: ABdhPJwhTjFNVs8f2/svBvPxzy5ZWVu7y2lHjC1OKQW8EXMIdh2DoTFxUNG4aXDxpCE7FTlD3n5tmA==
X-Received: by 2002:aca:b3c3:: with SMTP id c186mr2859416oif.39.1607543323218;
        Wed, 09 Dec 2020 11:48:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j46sm533101oof.36.2020.12.09.11.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 11:48:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: IIO Driver for TMP117 Temperature sensor
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-hwmon@vger.kernel.org
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
 <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dd7f7015-aed4-8628-0f23-e144fdacc9e7@roeck-us.net>
Date:   Wed, 9 Dec 2020 11:48:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/9/20 12:11 AM, Alexandru Ardelean wrote:
> On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>>
>> I have this TI's TMP117 sensor with me and I was thinking about writing an
>> IIO driver for it as a hobby project. Is the IIO subsystem the correct
>> place for this driver? if yes, can someone help me get started with this,
>> I haven't written an IIO driver before. I have this sensor and also a
>> raspberry pi with me for testing.
> 
> This could also fit into drivers/hwmon.
> Looking at the HWMON subsystem there are more TMP drivers there
> (TMP102/103/108/401/513).
> The first 3 seem a bit more similar to TMP117 (in terms of register map).
> 

It would probably be better suited for hwmon (it has limit registers,
suggesting a common use as hardware monitoring device).

> Let's see what others have to add.
> But, all-in-all whatever driver you end up writing, the easiest method
> is to copy an existing similar driver and extend it.
> Sometimes, a part can be added to an existing driver.
> At a quick scan through existing drivers, it doesn't look like TMP117
> is similar to existing drivers, so it may require a new driver
> altogether.

I don't see an immediate match either, but the tmp102 hwmon driver
might be a good start.

Guenter

> I may have missed something though.
> 
> Thanks
> Alex
> 
>>
>> --
>> Thanks and Regards
>>
>> Yours Truly,
>>
>> Puranjay Mohan

