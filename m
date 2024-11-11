Return-Path: <linux-iio+bounces-12159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1E9C4611
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E0D282E97
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3C1AAE00;
	Mon, 11 Nov 2024 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCg+RWBA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122C8468;
	Mon, 11 Nov 2024 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354253; cv=none; b=hvlPwjjJZScjJHRyr9nXugv0XwPIPuNgHkXUD9gEVozV3h9BUBYKXoqCyfl2foDTSavyBQ7UzivNITN5ajIosxwKe9bChe5mToPMxPzHsGPH3DLNkUMCjk/uP4G3eZMcX5uo8vEUL5IkwCyuNKSRkNg5XjSm7DC9fDH3RXgyrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354253; c=relaxed/simple;
	bh=L8cCX/CiNY4NkwsSEVjWSf/YB50YSShTfzUQNn831IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiSxSqICsYS2gnrS2LQ7j/yIX3T48oRczJcfJ/Pr/AiQlRcUXwiXQ2zQjmZwZ4uGm4tqAk5Zq1gfdp9Kntu/mv+4ZxKHSoQ1AqcGDND93+sNUGcJlS3Ljtt6NMaxKWMz04pUJVHGjsYnqrpWaciX7+CQT4DlfMh60WQGRuMn9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCg+RWBA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso3715110b3a.3;
        Mon, 11 Nov 2024 11:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731354251; x=1731959051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=veL2tYK9DnM4z6o4abrBRrurn0HQ49ytttUvm/62mK8=;
        b=dCg+RWBAFA86NkvGV+90lqPfASVzgf9Zuhscs41bJNSdm2+JX7q7lpSJHfwjOWRk1b
         +gHwfEEvUCf4rn8YCB8qquSEc8RyUDBqWrSssw/ITili42NomJbGBUynL9BhVM5BOSoN
         jxTI2nPLlADWMrdQxvXuHICjGyMzCkIDicjB6dMnvzUXGGv+gzQQmZtasywCKvV7nngw
         lH0/RiTNnvqDfsjSDOX6XAROu5WhAVtmkQ8GXJTbhHbKSLy3gEFjWeVxP/9W3TtarY2v
         r24cbVh3hbfBpYIaU4Gl5ItML2auyUf9xTyFf163TAJXr2bTzX2YkSI00jRMEe+T4a90
         JGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354251; x=1731959051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veL2tYK9DnM4z6o4abrBRrurn0HQ49ytttUvm/62mK8=;
        b=beoQlPtaoqKYwFbaoCKswRqyPlzyM6b6mbZiXt3Op5i6ut3D8jVoKuPOjE9wQ4Gq3M
         9ErxyiJjysxtU53zsaoyohKFGDyychSQOf9k10PQxpoIQaQVkZu6oPYk+AfSz6uRwZ4P
         Xi9GF6GIn/QDdmo2BtdMqD+/PItCg+KmDxBCvvHPlzSyMWpqgjHZIw+RAZKoy7hUXWFt
         Tn237iRgC04rgiHTOW5hvUiQjXdFWhxNdAAGDLV3IAGzRYVYTzAQvlqKvmOU0TLIhhAG
         LjRXxFK/GXwvYpInLOmMO+yhWIaE9evDWmaOMe4TEdHAfmlPZn8wUBUFZ/Hd56n5OFfM
         YZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPMPQfrm1r8ktT24syiX1kdwyV7WwnUQfDFqa9KGdKZOVtcUF95pcDd1jH1cEn0NcOIVInyCltPSIQ/Q==@vger.kernel.org, AJvYcCWzZ+aWv7GORkkAEf2bWjVn89Oy3+WmezFE8D0bgwtsRadR2iTBh7iFcalngiMug2AyDx0fPo7gv8wr@vger.kernel.org, AJvYcCXMprR8WsKVKMxqshsSCp5s1HGVBrAEtYKY7DgJXrf0mrHQ34X8FMg8O2r/8ncqCjIfq1NdHzaR4BwLD/Au@vger.kernel.org
X-Gm-Message-State: AOJu0YyavAoCzoTkj6oTNvoakqka0sWwluVI4CTY9s1JNmEs2ORoVztW
	3OdBp7L91NFB4k4aftWXVxYWPJAmf+JQbSUqm1+7u6efz0PgDVa7
X-Google-Smtp-Source: AGHT+IFHOCYxbg/qgY0GkJoG21foSSu1yr68jbLBsGuJy//lwDOcCwcIED/7dEbbGDOoCDv3wOZogQ==
X-Received: by 2002:a05:6a20:840d:b0:1db:ec0b:f2dd with SMTP id adf61e73a8af0-1dc22b57940mr20555533637.44.1731354251186;
        Mon, 11 Nov 2024 11:44:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f65bd27sm8880023a12.81.2024.11.11.11.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:44:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d1221ad1-2705-41b3-9dc9-05a3038e0cf2@roeck-us.net>
Date: Mon, 11 Nov 2024 11:44:08 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hwmon: tmp108: Add helper function
 tmp108_common_probe() to prepare I3C support
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
 <20241111-p3t1085-v3-3-bff511550aad@nxp.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241111-p3t1085-v3-3-bff511550aad@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 09:32, Frank Li wrote:
> Add help function tmp108_common_probe() to pave road to support i3c for
> P3T1085(NXP) chip.
> 
> Use dev_err_probe() to simple code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I applied the first two patches of the series, but I am holding back this
and the subsequent patches since I don't know how the kernel handles having
two drivers in a single module, and one of them fails to instantiate. I did
not find a matching example elsewhere in the kernel. We may have to use
the method used by the st_lsm6dsx driver - essentially splitting the driver
into three parts (i2c, i3c, and common). That would be overkill; the alternative
might be something like the approach used by module_i3c_i2c_driver(), but with
a set of #ifdefs around (some of) the i3c code.

Guenter


