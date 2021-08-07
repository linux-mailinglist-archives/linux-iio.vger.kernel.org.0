Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBA3E3681
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHGR3L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 13:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhHGR3L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 13:29:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0D4C0613CF;
        Sat,  7 Aug 2021 10:28:53 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m10-20020a17090a34cab0290176b52c60ddso22898200pjf.4;
        Sat, 07 Aug 2021 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sH9/gFiOfTFml9LQpIHkfOtJ8Tsmqta+a8u1SsJFnSA=;
        b=liPrx6e59kt9lNfas53RXB6k75gSXJxAQgP7o+2JzBVUWgMrPBJrkVLE5ftdAJRkkY
         1cYZOSoW2EOgMz1MmId7B+seUV1DRTRcNE/dwWJx6oUGq8IuEIW57kxSstTaxZfH12W5
         mBOJXVNk6oss8cSdHDMxP8L0ytQqUgVVYKPBbi1wgAyf0uVPQGKHss7Abus3q4qPwEF4
         7QMaOjVV3tNppRFMrdf9lozsvXF1jShwMdwZqoXOYYe/KjhSbaTflS2lh3MzcDwWCxcy
         nLpyYsn31cbK+5Q8VDd7YXV8MQ7aZGyvQMLRz8W7Ou0WPnmyU72E/P7iA629WL1oai/D
         CJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sH9/gFiOfTFml9LQpIHkfOtJ8Tsmqta+a8u1SsJFnSA=;
        b=nEddUELx+QFp53rwLuO9ShY1qBn4MGKPplC1mF4eLJlbjkStHB5RfZ3b1dLkAX8NxM
         eOnRBGtbDKw6RLIxMOasOKmBkTQYheC/MgCiSAIz3NpoD5oVx5InIuDcJeUiBw16Cl//
         6yBsxIBiY6Rf7AlZQTDQNAdvXwVVSa3KwSoX47wxmGgrKs35hlPcv70iWIifpVmFcZxD
         VIxTCvInChhPdn6CwZni6S8bgKdhG3Zpc1w+Ie7U/0QcXXV+XSu4n2wedQyud1H36qve
         jLlKFGL++FQ5mZknc1Rc212CcUbGyEs5RfI33OZ1Tp1tk9toJ5KTMd218r3vutnMyEPI
         cRvw==
X-Gm-Message-State: AOAM530WeyFUN220HMPEUek5vURet8nLqE7t31QIbG8XG/h9fvdj4Kl+
        zkZA1Uf1jzGzWKIlYp6lDLJtKZtGFdGjiiqV
X-Google-Smtp-Source: ABdhPJwvnoedds8YRvRjz25MejobDVWp0ra9lfuVisKF0KsCsvqCx/MLBuGBC/HVbjFlgW40b/Vg9A==
X-Received: by 2002:a17:90a:d596:: with SMTP id v22mr27443100pju.51.1628357332189;
        Sat, 07 Aug 2021 10:28:52 -0700 (PDT)
Received: from ?IPv6:2409:4072:92:61e9:38ed:54e8:b166:da11? ([2409:4072:92:61e9:38ed:54e8:b166:da11])
        by smtp.gmail.com with ESMTPSA id u16sm16700949pgh.53.2021.08.07.10.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 10:28:51 -0700 (PDT)
Subject: Re: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
To:     Lars-Peter Clausen <lars@metafoo.de>, Dragos.Bogdan@analog.com,
        Darius.Berghe@analog.com, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20210807050900.10075-1-dmugil2000@gmail.com>
 <20210807050900.10075-3-dmugil2000@gmail.com>
 <9de74da9-14b6-1533-e394-c7c8b056bce2@metafoo.de>
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Message-ID: <c5b787e6-8022-ff53-bd78-4e57b80485f2@gmail.com>
Date:   Sat, 7 Aug 2021 22:58:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9de74da9-14b6-1533-e394-c7c8b056bce2@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 07/08/21 5:47 pm, Lars-Peter Clausen wrote:
> On 8/7/21 7:08 AM, Mugilraj Dhavachelvan wrote:
>> +static const struct iio_chan_spec ad5110_channels[] = {
>> +    {
>> +        .type = IIO_RESISTANCE,
>> +        .output = 1,
>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET),
>> +        .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>> +                        BIT(IIO_CHAN_INFO_ENABLE),
> There is only on channel in this device. Why are some `separate` and others `shared_by_type`?
> 
No special reason, I'll put everything into 'separate'. Fixed in v2.
> 
