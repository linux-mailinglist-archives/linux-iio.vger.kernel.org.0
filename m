Return-Path: <linux-iio+bounces-6686-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0535E912BB2
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E3C1C26D25
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC977155740;
	Fri, 21 Jun 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQlTrf3/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3057E0F2;
	Fri, 21 Jun 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988364; cv=none; b=Rximcsk0RPfcBhh6Qh6P2ZyodXOHtzvClRi1vk1oePOmta5UwReovwRmtv3Vk72jm64EBTBnLOlTCHh2U6zZweSIT0RJSAOGujr7Q8UIuh9cn1v4mPKxQv5+Hd/jxXf1DwTE7bwMSMQuvtt3PHP7lj/86YAVPyZyZlou7RkqwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988364; c=relaxed/simple;
	bh=c9a4vLIJkJ3P/8LdOFh7Pi83Ik8ZSC6DYkmfiSsiFCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e2YN7K/aLHTF+Vs6eV4amGE/FXU1CEyDWaf+QzNsbtlvMj95u26EU21Wj5nD3oOu/XsUxgofXReMkEOcRKld0Wd2Hh8F/Jk2SmC1PvHc5ZSVLLxYhVPELICkX9Y6ESnn7WfB76S/TzPOaJHwLvRBe0wpziR4zSqiEtdAodSO/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQlTrf3/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70661cd46d2so275806b3a.3;
        Fri, 21 Jun 2024 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718988362; x=1719593162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dUjmX+O2nokx35KAY8OZK0MEvTs3f3VC9vgrX/kNQqs=;
        b=ZQlTrf3/BGDORx96ltoGByPcPfKKw7lKEOJgZ62e0Tl/xPSQwmbvlS/qN/hGsiRhQT
         PdIXcH9wmks37TdGZ6Hjb6Okg1HFpaRbFEAeOg43rKDYmqqO9wbFvvbqhr9UpZDoe1fD
         Q+tIDzQR5z1veJYuBzN08w9TCIG/L0zm3dZKZk+iUkP1S+txin9xWXHcm68R4wL6YtEU
         Aaw4I3UvvxZwKMq+6/6W2tHTvrR5rSb7gY/W6ynpkPfg/EPAHl3oxlNbzt+NtapCE39s
         zWQ2qz46Jdf+0496lnsLjfvojCxQ2LkB4ATVGHx+xL1TMGloIQFk2FLMbQbb3awRB0v3
         lVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718988362; x=1719593162;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUjmX+O2nokx35KAY8OZK0MEvTs3f3VC9vgrX/kNQqs=;
        b=pEoXhyqt0yLVdynqaZKqv6qfrlw7WZ0R2Ay4YCNdGDHMlACC/SCMQ9l0Z8E7cMeo+L
         KeAWtGVWowmOOgnhkPo3+pdZiIUGTlb+p/S1CDV5HtszLbCSyHdRi7IkLSosr1KBtW45
         BZ+RkmbG65psTkXRiAtv7a0dd2tjRQLn6vxmWscjYgx1yhnHCXPba3PIItRL/sfI+aC3
         38lqsvvplVoKosDSi16fIAZurophKF0tZtYiDZ5oJ8VJ89oeKo7+t8JlKMg43OdlGrh8
         nI3ATm8dOXHVE5+mqZnNuYJAQZRMEvykLVlTxAwqzg0C+dLxrtjW06P+/4qBs3iP8Tls
         Ey+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw5hmaAlbygjIJjlX7ABSNgrEAdFkkkuQpJUkiqtVBW36/VlPTEicdwaGFB0bSFQXP42PS6qUBPhUX2uv8YlIrjROAb96VZpdO7LhNxmyGDFpjICBcBP9uFTpDg/DP3likeb956J2FFgvOwHN5N+QMt55u6CuGNWGgeR+63JIL/YgtPus=
X-Gm-Message-State: AOJu0YzggVetg5+tIHU9wZfEVl/WoTIVXTu91FMfZ4UtyqXu97oRnQjX
	Hfo+lc7PfHr5sJvTCnZ+sz0BE+ndYy9Rknrt/PL70y2TP/FqJodQ
X-Google-Smtp-Source: AGHT+IGrsJPwKwi1jlOYUQzwo8lxd+Ew14USoQhAVm/r2txJ+HqK22cv5vPxvTs7OkKcdLv/Hp/fLg==
X-Received: by 2002:a05:6a00:853:b0:704:20b3:fe21 with SMTP id d2e1a72fcca58-70629c3fd31mr12306265b3a.11.1718988362192;
        Fri, 21 Jun 2024 09:46:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba79eb75sm1335683a12.70.2024.06.21.09.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 09:46:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e275220-163b-4580-8dd5-316d6dfbd41f@roeck-us.net>
Date: Fri, 21 Jun 2024 09:45:59 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: iio: Add labels from IIO channels
To: Sean Anderson <sean.anderson@linux.dev>,
 Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
References: <20240620211310.820579-1-sean.anderson@linux.dev>
 <20240620211310.820579-3-sean.anderson@linux.dev>
 <0c74406c-291d-4b0f-935e-989fb2f870ce@roeck-us.net>
 <55dbe61b-c2df-4eeb-80ac-cc2c83e9cdd3@linux.dev>
 <1439bdda-0e01-42da-a8ec-7a51ee3a5a08@linux.dev>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1439bdda-0e01-42da-a8ec-7a51ee3a5a08@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/21/24 08:31, Sean Anderson wrote:
> On 6/21/24 11:22, Sean Anderson wrote:
>> On 6/21/24 11:08, Guenter Roeck wrote:
>>> On 6/20/24 14:13, Sean Anderson wrote:
>>>> Add labels from IIO channels to our channels. This allows userspace to
>>>> display more meaningful names instead of "in0" or "temp5".
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>>>
>>>>    drivers/hwmon/iio_hwmon.c | 33 ++++++++++++++++++++++++++++++---
>>>>    1 file changed, 30 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
>>>> index 4c8a80847891..588b64c18e63 100644
>>>> --- a/drivers/hwmon/iio_hwmon.c
>>>> +++ b/drivers/hwmon/iio_hwmon.c
>>>> @@ -33,6 +33,17 @@ struct iio_hwmon_state {
>>>>        struct attribute **attrs;
>>>>    };
>>>>    +static ssize_t iio_hwmon_read_label(struct device *dev,
>>>> +                  struct device_attribute *attr,
>>>> +                  char *buf)
>>>> +{
>>>> +    struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
>>>> +    struct iio_hwmon_state *state = dev_get_drvdata(dev);
>>>> +    struct iio_channel *chan = &state->channels[sattr->index];
>>>> +
>>>> +    return iio_read_channel_label(chan, buf);
>>>
>>> This can return -EINVAL if there is no label. Since the label attribute
>>> is created unconditionally, every affected system would end up with
>>> lots of error messages when running the "sensors" command.
>>> This is not acceptable.
>>
>> The sensors command gracefully handles this. There are no errors, and the label is unused.
> 
> For example, without IIO labels I get:
> 
> $ sensors hwmon_ams_ps-isa-0000
> hwmon_ams_ps-isa-0000
> Adapter: ISA adapter
> in1:         825.00 mV
> in2:         826.00 mV
> in3:           1.81 V
> in4:           1.18 V
> in5:           1.80 V
> in6:           1.80 V
> in7:           3.27 V
> in8:           1.81 V
> in9:         825.00 mV
> in10:          1.81 V
> in11:          1.80 V
> temp1:        +79.8 C
> temp2:        +80.9 C
> 
> and with labels I get
> 
> $ sensors hwmon_ams_ps-isa-0000
> hwmon_ams_ps-isa-0000
> Adapter: ISA adapter
> VCC_PSINTLP: 824.00 mV
> VCC_PSINTFP: 822.00 mV
> VCC_PSAUX:     1.81 V
> VCC_PSDDR:     1.18 V
> VCC_PSIO3:     1.80 V
> VCC_PSIO0:     1.80 V
> VCC_PSIO1:     3.27 V
> VCC_PSIO2:     1.80 V
> PS_MGTRAVCC: 822.00 mV
> PS_MGTRAVTT:   1.81 V
> VCC_PSADC:     1.80 V
> Temp_LPD:     +79.5 C
> Temp_FPD:     +80.2 C
> 

You are correct, the sensors code ignores access errors on label attributes.
Still, I am not even going there. If there is no label, don't create
the attribute, period. The ABI says

     Should only be created if the driver has hints about what
     this voltage channel is being used for, and user-space
     doesn't. In all other cases, the label is provided by
     user-space.

It should be obvious that this doesn't mean that you can create random
attributes and then just return an error if it isn't actually supported.

Guenter


