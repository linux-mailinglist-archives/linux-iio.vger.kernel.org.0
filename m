Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01151546CE
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBFOvh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 09:51:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33628 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgBFOvg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 09:51:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so6442603lji.0
        for <linux-iio@vger.kernel.org>; Thu, 06 Feb 2020 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I0ht39g3wz0a7Uiv+x3fzJJ+to99KRkz7b3na5152wo=;
        b=SF7ZwWqm6Id+TbMRneD/XkThx+5ujrqg4uF9DGDsuNzT+3BXHANYn9aF8a576zXW2H
         PQ4f9CVjNmQM5lgdsQRUhwVn7s6LEMeC1VgkbeJa05HZslUwVaDqvINOBqaGYz54cBIM
         joJUJxBcZZxucVpNkX9lLJ7Uvt/AvIMNv0Wm5X0AQ8gNxzyeb+ubYgkCEinKGWYAeyQX
         yInk224WWtClDPZkVop9O/K4z9lDcFsM6eQBYdmSYKKpAfFj2+rUm+6pR1sxjW9ta4H+
         0E9igV84RpOBUryHBB9WJYECIdw+JXbo+bVDFSMxBf7lz8LfwDQppXAQmffjdE60yEfb
         2beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0ht39g3wz0a7Uiv+x3fzJJ+to99KRkz7b3na5152wo=;
        b=GS19VeSk3SqI9OQec8395h3F3PTUqnQxP4klKMWsjI4Lhyb8HEVN8R9E437PwnOYYy
         RBLjONUvMXwe52HjZv7+ZcbL62UPBvCZXP3pM26JzJwO6adfxd1jpQrX7FhQKkXBZfBB
         ZFVlUCsPEDcZE4KSRuIr//OYwC4fpwNlew1YW0c54RlDtX/X/sw2wLUuEQJxcdOvRQyK
         64N9YmZDMS042kkg3Os7E2Dg8riCCo0oZu+eMIt8QUgrD40Ccj/o+59m3eg5yFtOWZod
         81bNw+972vIEAB9McIVCc3tlCmZs88gKVyp/YlnnkXtHKpcJ8EWe78GsPNVTYCLEUqd2
         aWTw==
X-Gm-Message-State: APjAAAXeMeMhA5vf/32/ihx57N3mMm6fu+xhsWOaIjAFINKDrqs7Icp+
        Y0Kv5rRjxzGNj2UYps4WBJ3meigc
X-Google-Smtp-Source: APXvYqxW+v9V3fAi6PZ5UbICUgL/BQTJ04yW1rlL1VWOE4oHCK7mKQV8EDmx3limhaQ72JZImFmGkQ==
X-Received: by 2002:a2e:818e:: with SMTP id e14mr2279139ljg.2.1581000693420;
        Thu, 06 Feb 2020 06:51:33 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u16sm1498385ljo.22.2020.02.06.06.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:51:32 -0800 (PST)
Subject: Re: [PATCH v4 3/7] iio: light: al3320a slightly improve code
 formatting
From:   Dmitry Osipenko <digetx@gmail.com>
To:     David Heidelberg <david@ixit.cz>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org
References: <20200204093031.616409-1-david@ixit.cz>
 <20200204093031.616409-4-david@ixit.cz>
 <791299ad-c8e0-a94a-7dbb-780473c8346c@gmail.com>
Message-ID: <d66d93b2-6046-3f9e-80b0-1e7694e902b2@gmail.com>
Date:   Thu, 6 Feb 2020 17:51:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <791299ad-c8e0-a94a-7dbb-780473c8346c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

06.02.2020 17:50, Dmitry Osipenko пишет:
> 04.02.2020 12:30, David Heidelberg пишет:
> ...
>>  #define AL3320A_CONFIG_DISABLE		0x00
>>  #define AL3320A_CONFIG_ENABLE		0x01
>>  
>> -#define AL3320A_GAIN_SHIFT		1
>> -#define AL3320A_GAIN_MASK		(BIT(2) | BIT(1))
>> +#define AL3320A_GAIN_MASK		GENMASK(2, 1)
> 
> Looks like you forgot to compile-test this driver because the
> AL3320A_GAIN_SHIFT is removed above, while it's still in-use below.
> 
>>  /* chip params default values */
>>  #define AL3320A_DEFAULT_MEAN_TIME	4
>> @@ -90,7 +89,8 @@ static int al3320a_init(struct al3320a_data *data)
>>  		return ret;
>>  
>>  	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
>> -					AL3320A_RANGE_3 << AL3320A_GAIN_SHIFT);
>> +					FIELD_PREP(AL3320A_GAIN_MASK,
>> +						   AL3320A_RANGE_3));
> ...
> 

Ah, my bad! Sorry :)
