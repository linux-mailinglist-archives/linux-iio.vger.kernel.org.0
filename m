Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC81546E4
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 15:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBFOzN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 09:55:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35591 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFOzN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 09:55:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id q8so6439567ljb.2
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hAQoImk/jRnQhF0yKVxh1IJnyaK7LL1qd4XaytSAYs=;
        b=GMpXbALCHxaP59dc4IKZeV26GcyAtHHBJOUd6wEEzje50w2VsalRB/dZ8lXp8MCcvS
         pORJ97AUrCqQ3ibU5N+n0WQTk+AeKzeUfkAjUtefmezz1Iq/5FisBRIf2y9zU/iZfQcD
         zyOj0SwJqoy51k3o8S4sTcYW8WuG1SJd+7To5ZGvPBzQ+r8sLX99TNHbq4x14iRiyr69
         iBR1X57V8rbqydpRqQOnaDeolVt0Z7zxbFSy15CfqZAWedJxcnuDRu/edHePmc7bjw0N
         ShTxPTKkBmozVlD5omAxHfvSpazsR6tnlHw2UYB3dEhTB0oLx5gP+e4P+s0sfdDW0XrZ
         JM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hAQoImk/jRnQhF0yKVxh1IJnyaK7LL1qd4XaytSAYs=;
        b=QzNFclu2t6V64DMOYXqWdrhyjdO1mforI9wPwCZimxSozAM18iayndhFdAavC6tZyY
         OEGKnFfLLEwMbYWbr3cdX82Ur0d7Po/vOhmMC+0+1iV9KShTm9mwMVFeKfdJu6ln0V/B
         rtrfr7enceChyQjP8ma47WdUri3GsEoDufxmHOmVcytLqibutDSHAPHu2eHvF77h1od7
         nJM1MO7hHZ8psI4nFtoTz80e/KuoVOQV2CGshc+TbHF9K1Lz9q/w3LDfmIDp7WYAI9XK
         yjJZMBZleNQh4zwN8loVgs3CR4SsLNBcroVrJKerzmhWrfnLV8pOqA05YY3W7tDxT9YP
         Sjuw==
X-Gm-Message-State: APjAAAVYghq0w+FRlxSmTjEP21vQ9VgtFMj8YCFcCPMbrM5XXfIt+a1y
        jDple+PW1KuA62r1vwF09SiH1/eu
X-Google-Smtp-Source: APXvYqz6qopvNpAjQZbhSYGoOJc7i2Xh+wmWjKXqGx2ohhCvRWU37+heUfdLcX/sp6MTKbX3yThCag==
X-Received: by 2002:a05:651c:120d:: with SMTP id i13mr2272697lja.173.1581000910739;
        Thu, 06 Feb 2020 06:55:10 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id h9sm1544813ljg.3.2020.02.06.06.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:55:10 -0800 (PST)
Subject: Re: [PATCH v4 4/7] iio: light: add Dyna-Image AL3010 driver
To:     Jonathan Cameron <jic23@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-5-david@ixit.cz> <20200206114806.5180a415@archlinux>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9cc718bc-799f-f68f-02fe-695345d01dfd@gmail.com>
Date:   Thu, 6 Feb 2020 17:55:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200206114806.5180a415@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

06.02.2020 14:48, Jonathan Cameron пишет:
> On Tue,  4 Feb 2020 10:30:34 +0100
> David Heidelberg <david@ixit.cz> wrote:
> 
>> Based on:
>> - 3320A in-kernel driver
>> - https://www.spinics.net/lists/linux-iio/msg25145.html
>> - https://lore.kernel.org/patchwork/patch/684179/
>>
>> I decided to keep it aside of AL3320A due to different approach and much
>> simpler design of 3010.
>>
>> Tested on Nexus 7 2012 (grouper/tilapia).
>>
>> Tested-by: David Heidelberg <david@ixit.cz>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>> Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>
>> v4:
>> - SQUASHed: iio: light: al3010 implement suspend support
>> - switched from _remove to devm_add_action_or_reset
>> - implement bitfields FIELD_PREP & FIELD_GET, no functionality change
>>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
> 
> This is fine as is, but you might want to think about adding basic
> regulator control as VDD might not be turned on.
> Then there is the follow up question on whether it is sensible to
> disable VDD in the suspend path.

Nexus 7 uses always-ON regulator for the AL3010 VDD. It should be better
if VDD enable/disable could be implemented by somebody who could
actually test it.
