Return-Path: <linux-iio+bounces-13380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F59EDF50
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 07:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6B188A793
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 06:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433A9176AB7;
	Thu, 12 Dec 2024 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaaAvcBx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FA52F2F;
	Thu, 12 Dec 2024 06:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984274; cv=none; b=Ffq2kPsJAwJi8sPLnzN4fnudZJdpxUaTUyH/CoxS3rmNL9Fd0uLjfInmkT5ZFvxCXdKI8y53XMEhoVRUTSGayyOModsfvEEsBRjwerrJS6RGPcO0NjmFb1QMnHmq0eXwYpKWkDRX0fMevn5t99iHCIypV4k2ChOmJB66x2A9bFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984274; c=relaxed/simple;
	bh=z0wCHdsFAyliWjoWOt2nTZ6s0NP/IH8NAWGlVLnM68I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZXD9svTKiTv2RAbaMWqt9XTaDcEXbSKqVF4LSjQv4Dv7oKMXI30ughiTAd6nGAvV9Ge29Y87OeUeK0fIGETUoLbMUBtSYxUpYSfBHBFU5L1/5/CfTvHBaeggIV6KQqyPZQ07cdvg00LEenS5VNAnFYNMq5LjzpC2nUYuhXUT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaaAvcBx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728e81257bfso191555b3a.2;
        Wed, 11 Dec 2024 22:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733984271; x=1734589071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OB14yXnaDRenrfW6VKpIxUerYDKvM4it7axAjB6Xkus=;
        b=LaaAvcBxSNyY44KG1Mp6ALWVg7X4MFvsJPDLFPqeAdIC9PSHNRCUkPsdJVHX0i4PYv
         ++YFZaYsOpyh88J7wzXnACVyllDx5hxohJTgaKCXvnrRmvhBBfx8hbTdb6fr3WHN0eSy
         6n9fpbvLWRPmGI54lIHp0Ji7uZfwgu74cBdHt0xAb0m0B7HjG9+3QkO+f6abeQJSKhoq
         zVU1fe31JHeLRsmiZAP/etCJxuV46G+4f/ZSt2lvOIdhZqgpOJPq3k1sYJByjHm5Uupo
         Z+bomFKdMHlhpTPLgUP4HGGJtCT4klpyphQDS0UcGrbnfEcWZasXTa3NwwZUgGMJT7o+
         a/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733984271; x=1734589071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB14yXnaDRenrfW6VKpIxUerYDKvM4it7axAjB6Xkus=;
        b=KNevEvrY0IiJdsayDZ1LPpgVsAxXC94+SaMoXS7oL+myw+z79gGCky9lRa8ZV/X4/v
         h+uEgwSbxFI6WCvMxJq69h3vAJbvl8kwwEcwl4KFy11nGGJCRK1lzXChCpxLvilkfdjB
         CoiuiqVdme3uv94vrvsI36tYNEWV/ARBpA0YYUST6hiHn38MA+xujBWEohj2w1mAL71a
         uVmZn/A42ywedAXQBbrdQt8q/SjPK5Ygafka72atTFWQTUTuaQpfDPP/SkLDf7uI7l4a
         d6TB7yPVX5hTRbB1oHTUZlq00JBpT7W9yxxHflcOUyIyLTS6bUC6f83kyMTjbOoqr2Ok
         /e1w==
X-Forwarded-Encrypted: i=1; AJvYcCW2qxuA5sGM3Ow/b+GRNI9xH96rVLcGP6pvGjTSoN5ojYQqlWF8YKC6GPZr1tTsYEiJIz6lXk5yPmRAkgCb@vger.kernel.org, AJvYcCWOOoYu/ams2g6iUzE6FJUvBGPNrZRPgGBNH0XH5z3uOqNcHuLM8BakCrT8FoK9E+OFT9E0Krb751e5cA==@vger.kernel.org, AJvYcCWwHhOo7ffI78yIGcdd9fr8YHbme5HYVrD2+mkHdp62anfA+ZgvAQH5cxI5Tpt2vNShD3clcvnhf4kq@vger.kernel.org
X-Gm-Message-State: AOJu0YycLfkOjHT7S1cnOF0DwvFk1b3iyqp7xRG713/iHzfeOjgNHdaj
	XUwG6ygwQ7RaiMIiLj08vKFa9x+1sCmH7aaFo0Ml+bLHOUL1gfW5Lt66bw==
X-Gm-Gg: ASbGncvT6OnmvOAMU5o0HoLpLHV6ryNrRJAFA77pwEKyFi8ohxkQKbkOSCD3qPrYWpr
	24Pv/PkRrSJjOu0NncOMXJzBvGFQ8L8AsuLWyrbVPXi4gkD1jsr08OGfc8GDl/UOv/lmgog2WWa
	4BiWcLjYkWLvd1q+XH0BnN9uuy3/IMOUL6fTa+AYaABW21seP5GonYMrIrF9IlW3Af16rCBa5uA
	sMCk2XeWQ19HmzL18KV8oH7TZrPyj7UvcSPyJhURAPOle0gGBjDn57CJ/zRc2eqO5DtRBFQX+kD
	9TBlCLsIWu0nvLjnBfP7it48VvbWXg==
X-Google-Smtp-Source: AGHT+IHblaJEJ5H+W9MatmBvSfd4ArTkVWJ/P3YibXyQrCQoe1J8/rQCP3+PTFK+KxiKsFcadojfkQ==
X-Received: by 2002:a05:6a00:2d97:b0:728:ecab:51e3 with SMTP id d2e1a72fcca58-728faa0cd89mr2622925b3a.11.1733984271416;
        Wed, 11 Dec 2024 22:17:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f9ff3909sm5745952b3a.77.2024.12.11.22.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 22:17:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5b53cffd-ae7f-45e5-b265-8e700d753275@roeck-us.net>
Date: Wed, 11 Dec 2024 22:17:49 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: Add support for D3-323-AA Pyroelectric IR
 sensor
To: Hermes Zhang <Hermes.Zhang@axis.com>, jdelvare@suse.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: kernel@axis.com, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20241212042412.702044-1-Hermes.Zhang@axis.com>
 <20241212042412.702044-3-Hermes.Zhang@axis.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241212042412.702044-3-Hermes.Zhang@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/11/24 20:24, Hermes Zhang wrote:
> Add support for Nicera D3-323-AA Pyroelectric IR sensor. The sensor
> support to config the threshold/filter_type/filter_step and return the
> detect result in sysfs attribute.
> 
> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> ---
>
...

> +
> +static DEVICE_ATTR_WO(pir_threshold);
> +static DEVICE_ATTR_WO(pir_filter_step);
> +static DEVICE_ATTR_WO(pir_filter_type);
> +static DEVICE_ATTR_RO(pir_detector);
> +
> +static struct attribute *d3323aa_attrs[] = {
> +	&dev_attr_pir_threshold.attr,
> +	&dev_attr_pir_filter_step.attr,
> +	&dev_attr_pir_filter_type.attr,
> +	&dev_attr_pir_detector.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(d3323aa);
> +

I don't know what this is, but it is most definitely not a hardware
monitoring device. I don't see a definition of those attributes,
so I have no idea what they represent.

Maybe this is an iio device, but given the unusual attributes
I am not even sure about that. Jonathan, any thoughts ?

Guenter


