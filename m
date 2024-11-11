Return-Path: <linux-iio+bounces-12149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A0D9C44A8
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C01428342D
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 18:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C651AA1E6;
	Mon, 11 Nov 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjn9VNgF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE661A7066;
	Mon, 11 Nov 2024 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348658; cv=none; b=VS0AEkG7ekrZ4i8YUkdjHzwlfGhRQP/eq3QU2swwnjepbnuW/Fd+GhPt3jp2BERnivhwNUHG6Gq9LfEfQgZGmFhm0eGY451JDKifwhqt4WndL4NkkTKQ1xBsY/DLttz+Yt2wcI5I4MEbWCTH1JvHW3IbgETcHH3WxH0UcgxyQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348658; c=relaxed/simple;
	bh=2rRfR0LAyjcJJH/QKC/GhAZcwpyTWAfMPNqw+ohUHi4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cu0X1O8fj841lKDv46qkPWeSm+sg7JuvXt0920TZsZlASODNcMIg0LEEUHDjyI48WkmO6YIKe123/1jx9UI+xx4lu26ZVcrAgs9ND5COvFaXXFSGD03lUsUO9dxWjGK4jagxcxWK+Xb/TQQO7eZsO3mbk6FNs5+X1IR5n1TSapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jjn9VNgF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2118dfe6042so16635825ad.2;
        Mon, 11 Nov 2024 10:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731348656; x=1731953456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ou+pakJnN8GqsivMPkhl1TNQ2JSe3WqaNFbGvCJlURM=;
        b=Jjn9VNgFn6lAEpvxf5fxfrFBG/UnALMkUC8cLwPNZi+JD1vqnEe/VckP415aoqT8TI
         ejizRmcPHztfIiSTHU5WFpTIQRJgJb1JWT/1EGOsWf/A8M5laxB69PoGT+DP0Al2FNX+
         BXqD4+Th6IVkY+LvdEHtal2n5ejQL3vWjDWIqqqfFIXegqMrelAMfVnaXPcYrbuBxsyj
         5zsWPPebQB83KXeUUOo7C7ab1AjXAASuehjmaQFB0Lf19uJuLvz1hHkS9w539UGbw9xU
         5xksfAiQGTqvBuycu6/TiRCEDdSPgk89dDZwJ5xQ6j7lZ4FYcJnZgol7XNb8GYhVo5uk
         +4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348656; x=1731953456;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou+pakJnN8GqsivMPkhl1TNQ2JSe3WqaNFbGvCJlURM=;
        b=KMCqFKZ5h0gUyS5ePwtDQ3zmFyu+jHuH3dqfyMtT/L31fxwH/vqReLk7OVweWtLFi9
         k1zHaJueM40Jko0GdvW3uzcJW0lpS9qUEJtGGNxBi7gzVuOH8zNPmtrAu6AZAVjxVnzV
         NSH2EpxzGLMd8uo2/I6RcuxYgtv6OMx02k9kDjtvEhdW2YCH1sNkhDeofV6ukn7ZU5qB
         9ivzI5gG0QAEjHFmmhxvm13qlFDd9ygJ2hiV+hPJ8UBE9ybkIPR4hx2Tps7bR4OzgdRy
         TdubXR8LnLFNyAiWpBpxvXg7bw59IO9/Kb/zTEGG6w9VsHkPLxRCX6fVFrbkWhMVg2aV
         zb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBnDdidLsVMWAphlzQiDHnA7y2bDYjSsOcHcuJBdkkOCv/K24mLF1XYevkpYK79ijzfLToa8Ig4+sK@vger.kernel.org, AJvYcCUuVOPptgtALvJcgbk1yj7pt5ppvvwrwaSS1PR+DASBr6KDlHYo91096QRCtTpezikFn9VtwDwhD/16kg==@vger.kernel.org, AJvYcCXDp6ANlWACr3BGMe2zAiAvMOmMgZ+0lA1AqNl5S5QzoCrb1VM3ALXe8vgkL57ySvgRex/m8yCC5E+e+Kpl@vger.kernel.org
X-Gm-Message-State: AOJu0YxWTI51PADgR0OKLAOj/nacAac67qZHU4QbTYnGy6T82t8OXuVd
	Z4V0KtHVOPZ1RSlxIM4igy+m3WCwU+VANNPAsxiPs4pcAJBgNCLJRU5MAQ==
X-Google-Smtp-Source: AGHT+IEyM4w+bqgLpiyEoaQvV2sZGwHKl/UVHBGsIq5HXpnePLWUsiA8UymSNUOxXTSnqCLnhu1Vsg==
X-Received: by 2002:a17:902:d50f:b0:20c:cf39:fe2d with SMTP id d9443c01a7336-21183533a62mr202214645ad.5.1731348656518;
        Mon, 11 Nov 2024 10:10:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e58316sm78945275ad.188.2024.11.11.10.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 10:10:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e8921251-02bb-409e-88d0-d635e7d08929@roeck-us.net>
Date: Mon, 11 Nov 2024 10:10:54 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hwmon: tmp108: Add support for I3C device
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jean Delvare <jdelvare@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzk@kernel.org>,
 linux-hwmon@vger.kernel.org
References: <20241111-p3t1085-v3-0-bff511550aad@nxp.com>
 <20241111-p3t1085-v3-4-bff511550aad@nxp.com>
 <41995c8a-8b05-4c56-b4a3-5f275a88b899@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <41995c8a-8b05-4c56-b4a3-5f275a88b899@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/24 10:04, Guenter Roeck wrote:
[ ... ]
>> +static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
>> +{
>> +    struct device *dev = i3cdev_to_dev(i3cdev);
>> +    struct regmap *regmap;
>> +
>> +    regmap = devm_regmap_init_i3c(i3cdev, &tmp108_regmap_config);
>> +    if (IS_ERR(regmap))
>> +        return dev_err_probe(dev, PTR_ERR(regmap),
>> +                     "Failed to register i3c regmap\n");
>> +
>> +    return tmp108_common_probe(dev, regmap, "p3t1085_i3c");
>> +}
>> +
>> +static struct i3c_driver p3t1085_driver = {
>> +    .driver = {
>> +        .name = "p3t1085_i3c",
>> +    },
>> +    .probe = p3t1085_i3c_probe,
>> +    .id_table = p3t1085_i3c_ids,
>> +};
>> +module_i3c_driver(p3t1085_driver);
>> +#endif
> 
> While looking at i3c code, I found module_i3c_i2c_driver(). Can we use
> that function to register both i2c and i3c in one call ?
> 
Answering my own question: No, because devm_regmap_init_i3c()
does not provide a dummy function if i3C is not enabled.

Guenter


