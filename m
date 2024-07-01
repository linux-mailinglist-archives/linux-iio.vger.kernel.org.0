Return-Path: <linux-iio+bounces-7110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF88191EA68
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 23:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32910B212F4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 21:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9316F0DB;
	Mon,  1 Jul 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ1EAWN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C6383A2;
	Mon,  1 Jul 2024 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869580; cv=none; b=RI5z7bvWSAV0RFUb1Ifki71aOvkJxhnjcU3AqV0gSV7yOQuj5OslTysZzZQuZSvoFQfOXPV/6v8tarYswLeAoNTIEU4J9nsHJHuEMLcs6ohQ4W6eoiliJBuWXBxKJsxpbRM5MU4eNSkd8ZA7amG2LKoMq5EgQl7QJFVNTZS7qck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869580; c=relaxed/simple;
	bh=30ll7tqXtKC8oZ4rgbOLXRJeaa/WCz+0NNsWVRq5X0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wv3HBo1k5dsLpXcZpC+kM70DID+gskEXUuI9YePM61Lw+M8/rZYa0/a1XeKJKMtf0dcAFvC91ksAmUM0VwFYP6JEQdZ0h90O5mp5VOcOiogut/iNWhMwQQJw+H9gFyq5J4dDmjfsgWe2NDAabx4uEZLvif/bL90Y9el8nMAry8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ1EAWN/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4256f102e89so23631135e9.0;
        Mon, 01 Jul 2024 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869577; x=1720474377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaE7T2xExijUWC/YXmEs75U7t9rARciDYbj+FKSksYs=;
        b=VJ1EAWN/ARhJfnJZKvXuJQ+V279EzHnzsZZpMfQKL4qxAbRNhszknc1XL1LhwjxauU
         WpqcTbJgivWyOo06D4bjc/SLgLaYYCqpVNHLeA++9xJ2kpOTsGGZycCgVtQe9H9TvFT9
         9zZECm7o/7V1sSHAYU7hXjSxHoDmBcfQxET6/vKGybTDLUvJMHqzWgof15GsTZVtBpVd
         ErZtf5ZHAiIIpQl4mTiv4+U/NTG0/rK1vPYr1ZLUPgJa7l48D+uhJ6+Hy8c1amZ4bIG7
         9XCDGUynuBgW/1aZBg38TpoJvx+/PUFIZCT/Q4zAvtmcmj7G4TvPO4De2oBk5lE3Rugf
         1aJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869577; x=1720474377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaE7T2xExijUWC/YXmEs75U7t9rARciDYbj+FKSksYs=;
        b=EiUG4AcnbOd1KPNnuNVVDyBMGgzbUQbP8wKVO5XDkiD3QHf5E/Vi+ybtE3Fd2hO3gB
         l/wZYkbqgyD8L6FHuZXcTL6nAG73dOO9tzqQLIiaTeLZLOF/DZXKnANunXna9CUvWR/J
         xdKzZSUeVGDvBxQzNLlDbG+dLcM5A9576xT6wVzXZ5fejjOXT4bI9zdH9Ut4pm1MSHDW
         z2yJ7ZGYzk6uN5ElihQHZclt2PkHPKWeu+m8h2n/eQsvp2knUyRY8lFMOHzo2fZglY43
         CPcn+Vp7pQ5LSiKV4j/pyU3v4uY4512fR+EWvud+v7djifXb9hszrW5kSvU/ogSF7Fj2
         yNtw==
X-Forwarded-Encrypted: i=1; AJvYcCWr0zQT894HMFSbWn4E5PtDJd3mC3f/IKmuJYxatGMfXvy43VCsYRC55+q3l5J6d4ZqVmy8woU3FNER/+bgpOZDrxpNfaZjStiJKKVLN7vSCx9JTgFX+3w0K+n5rGr/dN3BIGPjYg==
X-Gm-Message-State: AOJu0Yw+toWV+4I7LZDku6Q076s+3sGpyPccnnBNPBYaAUbzV1DXVgm4
	OyXnl+jJmWjmz7S4tYho2uV/kd/2gE4+IoEp37C2pICKokKPnZSA
X-Google-Smtp-Source: AGHT+IEpsLzXFPEzmy4zrWIrvVUEqXohjQGdn+FCw8LyBsBeen4Oob7AQE+wX/+QDbambzv94QxKiw==
X-Received: by 2002:a5d:55ce:0:b0:360:9223:b07 with SMTP id ffacd0b85a97d-367757299a0mr3602904f8f.66.1719869576706;
        Mon, 01 Jul 2024 14:32:56 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:a6cf:581a:1e41:3fd0? ([2a10:d582:37c5:0:a6cf:581a:1e41:3fd0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257d9c7f18sm82678655e9.40.2024.07.01.14.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 14:32:56 -0700 (PDT)
Message-ID: <3ececd1c-8331-4007-8e75-a000425ccd3c@gmail.com>
Date: Mon, 1 Jul 2024 22:32:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] iio: light: ROHM BH1745 colour sensor
To: Matti Vaittinen <mazziesaccount@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240625220328.558809-1-muditsharma.info@gmail.com>
 <20240625220328.558809-2-muditsharma.info@gmail.com>
 <98c87420-e88a-43ca-a8af-2fa751b85d4f@gmail.com>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <98c87420-e88a-43ca-a8af-2fa751b85d4f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/07/2024 12:32, Matti Vaittinen wrote:
>> +
>> +// From 16x max HW gain and 32x max integration time
>> +#define BH1745_MAX_GAIN 512
>> +
>> +static const int bh1745_int_time[][2] = {
>> +    { 0, 160000 }, /* 160 ms */
>> +    { 0, 320000 }, /* 320 ms */
>> +    { 0, 640000 }, /* 640 ms */
>> +    { 1, 280000 }, /* 1280 ms */
>> +    { 2, 560000 }, /* 2560 ms */
>> +    { 5, 120000 }, /* 5120 ms */
>> +};
>> +
>> +static const u8 bh1745_gain_factor[] = { 1, 2, 16 };
>> +
>> +static const int bh1745_int_time_us[] = { 160000,  320000,  640000,
>> +                      1280000, 2560000, 5120000 };
> 
> I am not sure why you need these tables above? Can't the iio_gts do all 
> the conversions from register-value to int time/gain and int-time/gain 
> to register value, as well as the checks for supported values? Ideally, 
> you would not need anything else but the bh1745_itimes and the 
> bh1745_gain tables below - they should contain all the same information.
> 

Hi Matti,

Thank you for reviewing this.

Just had a look again at GTS helpers and found the appropriate 
functions. Will drop these for v7.

>> +};
>> +
>> +static const struct regmap_range bh1745_volatile_ranges[] = {
>> +    regmap_reg_range(BH1745_MODE_CTRL_2, BH1745_MODE_CTRL_2), /* 
>> VALID */
>> +    regmap_reg_range(BH1745_RED_LSB, BH1745_CLEAR_MSB), /* Data */
>> +    regmap_reg_range(BH1745_INTR, BH1745_INTR), /* Interrupt */
>> +};
>> +
>> +static const struct regmap_access_table bh1745_volatile_regs = {
>> +    .yes_ranges = bh1745_volatile_ranges,
>> +    .n_yes_ranges = ARRAY_SIZE(bh1745_volatile_ranges),
>> +};
>> +
>> +static const struct regmap_range bh1745_read_ranges[] = {
>> +    regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
>> +    regmap_reg_range(BH1745_RED_LSB, BH1745_CLEAR_MSB),
>> +    regmap_reg_range(BH1745_INTR, BH1745_INTR),
>> +    regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
>> +    regmap_reg_range(BH1745_MANU_ID, BH1745_MANU_ID),
>> +};
>> +
>> +static const struct regmap_access_table bh1745_ro_regs = {
>> +    .yes_ranges = bh1745_read_ranges,
>> +    .n_yes_ranges = ARRAY_SIZE(bh1745_read_ranges),
>> +};
>> +
>> +static const struct regmap_range bh1745_writable_ranges[] = {
>> +    regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
>> +    regmap_reg_range(BH1745_INTR, BH1745_INTR),
>> +    regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
>> +};
>> +
>> +static const struct regmap_access_table bh1745_wr_regs = {
>> +    .yes_ranges = bh1745_writable_ranges,
>> +    .n_yes_ranges = ARRAY_SIZE(bh1745_writable_ranges),
>> +};
>> +
>> +static const struct regmap_config bh1745_regmap = {
>> +    .reg_bits = 8,
>> +    .val_bits = 8,
>> +    .max_register = BH1745_MANU_ID,
>> +    .cache_type = REGCACHE_RBTREE,
>> +    .volatile_table = &bh1745_volatile_regs,
>> +    .wr_table = &bh1745_wr_regs,
>> +    .rd_table = &bh1745_ro_regs,
> 
> I am not 100% sure what this does. (Let's say it is just my ignorance 
> :)). Does the 'ro' in 'bh1745_ro_regs' stand for read-only?
> 
> If so, shouldn't the read-inly registers be marked as "not writable", 
> which would be adding them in .wr_table in 'no_ranges'? Also, what is 
> the idea of the 'wr_regs'?
> 
There are some read-only (Manufacturer ID and Data registers) and some 
readable and writable registers. I will rename these to 
'bh1745_readable_regs' and 'bh1745_writable_regs' in v7 to avoid confusion.

>> +};
>> +
>> +static const struct iio_event_spec bh1745_event_spec[] = {
>> +    {
>> +        .type = IIO_EV_TYPE_THRESH,
>> +        .dir = IIO_EV_DIR_RISING,
>> +        .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>> +    },
>> +    {
>> +        .type = IIO_EV_TYPE_THRESH,
>> +        .dir = IIO_EV_DIR_FALLING,
>> +        .mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
>> +    },
>> +    {
>> +        .type = IIO_EV_TYPE_THRESH,
>> +        .dir = IIO_EV_DIR_EITHER,
>> +        .mask_shared_by_type = BIT(IIO_EV_INFO_PERIOD),
>> +        .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>> +    },
>> +};
>> +
>> +#define BH1745_CHANNEL(_colour, _si, 
>> _addr)                             \
>> +    {                                                               \
>> +        .type = IIO_INTENSITY, .modified = 1,                   \
>> +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>> +        .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |   \
>> +                       BIT(IIO_CHAN_INFO_INT_TIME), \
>> +        .info_mask_shared_by_all_available =                    \
>> +            BIT(IIO_CHAN_INFO_SCALE) |                      \
>> +            BIT(IIO_CHAN_INFO_INT_TIME),                    \
>> +        .event_spec = bh1745_event_spec,                        \
>> +        .num_event_specs = ARRAY_SIZE(bh1745_event_spec),       \
>> +        .channel2 = IIO_MOD_LIGHT_##_colour, .address = _addr,  \
>> +        .scan_index = _si,                                      \
>> +        .scan_type = {                                          \
>> +            .sign = 'u',                                    \
>> +            .realbits = 16,                                 \
>> +            .storagebits = 16,                              \
>> +            .endianness = IIO_CPU,                          \
>> +        },                                                      \
>> +    }
>> +
>> +static const struct iio_chan_spec bh1745_channels[] = {
>> +    BH1745_CHANNEL(RED, 0, BH1745_RED_LSB),
>> +    BH1745_CHANNEL(GREEN, 1, BH1745_GREEN_LSB),
>> +    BH1745_CHANNEL(BLUE, 2, BH1745_BLUE_LSB),
>> +    BH1745_CHANNEL(CLEAR, 3, BH1745_CLEAR_LSB),
>> +    IIO_CHAN_SOFT_TIMESTAMP(4),
>> +};
>> +
>> +static int bh1745_reset(struct bh1745_data *data)
>> +{
>> +    int ret;
>> +    int value;
>> +
>> +    ret = regmap_read(data->regmap, BH1745_SYS_CTRL, &value);
>> +    if (ret)
>> +        return ret;
>> +
>> +    value |= (BH1745_SW_RESET | BH1745_INT_RESET);
>> +
>> +    return regmap_write(data->regmap, BH1745_SYS_CTRL, value);
> 
> Would it work if you used regmap_write_bits() instead?

Yes, it should work. Jonathan suggested 'regmap_set_bits()' for this and 
it looks like a good fit for this as well.

I will look through the regmap API once again and update similar cases.

> 
> ... Sorry, my reviewing time is out :/ I may continue later but no need 
> to wait for my comments if I am not responding. I've too much stuff 
> piling on :(
> 
> 
> Yours,
>      -- Matti
> 

Best regards,
Mudit Sharma

