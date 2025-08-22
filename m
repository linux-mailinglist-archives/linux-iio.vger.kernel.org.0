Return-Path: <linux-iio+bounces-23129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1DCB30E2A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 07:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FD15A82CA
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 05:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49472E2286;
	Fri, 22 Aug 2025 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5UspzPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF8223DF5;
	Fri, 22 Aug 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841180; cv=none; b=dypxWL9+MEIvcksDxzlAQhugAikeVrZHVVTCpy7+2czimQlxh4MusO0SOkggYhbvhAo5uaCCrydnXLMRNNtc1MsjxcleSHAnbykt9eqciDTa5tcDGeQnqJYl63SCH4HnCafQtEXALOeyHCHVvLl3i2k8e4W3VZNlhjH9ZTYf8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841180; c=relaxed/simple;
	bh=DUOcddI3mXvRcjypV5McRymWt4WifssDE6eXu1LlC+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTOMQgMp4oxZEUBpLS4f5ZPHGo85WVSse9+s3E8FCIaW0PrUUZ05ZCPZ9hBIjEVU2AoxeUhZvcW04KTTtM83OecEaRRTfMrrf7FlxbkkvnBaAFrK3D7IQ/Y0MP1ubowAMAepQxSPX5wKqkKZpeTSjDNawpiCib/zE/ArFuxgVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5UspzPJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55ce508cfe0so1640239e87.0;
        Thu, 21 Aug 2025 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755841177; x=1756445977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cktSZhhDXy0hCif2W3DZbZQLN29cfh8CxR1aWKR6R68=;
        b=C5UspzPJPF6swIKGPttrOJ6ScqTd1tcK2fiLrmHobRYFDiTBdIK+IsSiIk9H69Wj98
         SGy8soQ8BcwLhDYl+eIaEIKy3nv8Eay0Cdw4RkszNVrmYxPjHL0TFkzSVc//fAxDKHqh
         Vc8jpR6uv4sdKm82AgsBJ6HLZXR65S/abuyxBdLYJGp+ugSHqTLjSrPLFlVd9MJPQnHk
         o8C0nggu2rpdJRBdaUs2JMyx+A5BPlpvRb6pX4SgN7bgULE4rfkWQYIVK51MVrQ+3x+H
         bhgte2K28l5KZh+1MysFxqWUHpGALlP7w8m8603tRebd/IbKls2bu+S7NVL3Kkkv0QW3
         g4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755841177; x=1756445977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cktSZhhDXy0hCif2W3DZbZQLN29cfh8CxR1aWKR6R68=;
        b=cKF301h0AYgB0ROcxLc2shgl9c9wKJ+YrF2agsiipsVJy7eupN9NkPeQBRw7Nn6Z7y
         Kf5FMdjapM54NEHtKLztEfvlKHtoHEZnbNud32UA6SKh8V+tgrYkUw11HpZiKeoVwC4Q
         bFu9B3Zm1MNFx6O54qclXU5aoKJC3xCAjm1cprArHcSqnCXs9D+9Mo0sv7+UaYn4GOPb
         wShqRIesBw0u06crGGkWIRq9iqk1UEb3fS6BRHvcuc1F9fu2ZQ/1v22UkxK8jMSRVm+y
         mRZsmxnkXs/zFy763TfkI+75Ms1frDNq/BwQyC6qWEh6flg7fxTj80E8RQv4DRSrK/Gg
         TT4w==
X-Forwarded-Encrypted: i=1; AJvYcCUdDBsCYP92d1Z9VqyJKBJttIrekOVsP2dii5z5xiBApn7c031wSixQQDIZBBiZIagDh3AjwBMk6MID@vger.kernel.org, AJvYcCVQptUJGtNhf4oZiu4sQj0EZ94f23tqqMvCJFMAmSfpa0VhFs3ul4P4jT9+PfanNjm9OdcRntKvTuQu@vger.kernel.org, AJvYcCXECMAWSgjhg+iFY3+lk23sufxWSX2CPiLfjdgz7+tAsi5KtzklRyJzyf8WYmY2ePEbk0RGSihJLhuF923c@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG7lanzLjHyh1VqT6Sk086QWKNxXXiiUgh/e1EQRa7e7zsRyF
	//kBzqUsDPj9sPZvytIU0SnzTO12/eaK83AyUHmLrPq0brRoa3zIo9Bx
X-Gm-Gg: ASbGncvu4Jc7fAiKIGVd/H8zs1VZCv6Aqf1Frf/0+IlaNBZMImBDzuac7vzgMw2d+Gj
	d9Or8w84TO97TQxI1SyceYVhIRWJFyBVqaDtSCX1QR9hZQFmBvcUYCpxIzQx/sPKJBpU2S18ZCo
	is6X7EHzT8G1IqwtAj7kfwi5zt5qI1Cv4cfGaHRJ5EX9I5Oujk7zF6Q++1kO2xwcE9D/g305Yvl
	mKXtZyfGeL3Bqo5ShAt51VdRDvx4QeD2EB8sIUvnBIL38Qtfxqm/9RGuRCHUa+hnod5PM89P1Ad
	T78svP6vVdyhRzXxI7dFjPIe17Fr0FQmEHJkOXgqx250sbg7mtWJjO9v6IjRE0dANpdcgZswGbD
	fDlR7Isrpe0RmuNXsN0WkWZX5YVjiS4WFBlvn6pD1uFR7SQxu5aVK/zHIGXOYGRXMR1fge1djvO
	+TbNY=
X-Google-Smtp-Source: AGHT+IFdQlgDjn1LUPHReBm14miSwkL8ekDjE0cyhua5Y4fRBWhxH4K9ZBeoTPcaldW02MqLA7962w==
X-Received: by 2002:a05:6512:260f:b0:55c:d5f8:7866 with SMTP id 2adb3069b0e04-55f0d3e3306mr539973e87.57.1755841176778;
        Thu, 21 Aug 2025 22:39:36 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef47387esm3297633e87.164.2025.08.21.22.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 22:39:36 -0700 (PDT)
Message-ID: <4d4120fa-3a20-4cc4-a078-ee94e03229f9@gmail.com>
Date: Fri, 22 Aug 2025 08:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
To: Andreas Klinger <ak@it-klinger.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, lars@metafoo.de, javier.carrasco.cruz@gmail.com,
 arthur.becker@sentec.com, perdaniel.olsson@axis.com,
 mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com, clamor95@gmail.com,
 emil.gedenryd@axis.com, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250715085810.7679-1-ak@it-klinger.de>
 <20250715085810.7679-3-ak@it-klinger.de>
 <aHdWAUMMH43tIqV4@smile.fi.intel.com> <aIMy_BHJYNA20k-x@mail.your-server.de>
 <aKbqLpJMCxJd3QXW@smile.fi.intel.com> <aKdrO7DE8ky2DBu2@mail.your-server.de>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aKdrO7DE8ky2DBu2@mail.your-server.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/08/2025 21:53, Andreas Klinger wrote:
> Hi Andy,
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> schrieb am Do, 21. Aug 12:43:
>>>>> +	part_id = le16_to_cpu(reg);
>>>>> +	if (part_id != 0x0001)
>>>>> +		dev_info(dev, "Unknown ID %#04x\n", part_id);
>>>>
>>>> For 0 it will print 0 and not 0x0000. Is it okay?
>>>
>>> I just tried and it prints 0x00 if the part_id is 0.
>>
>> This is interesting... So it's not 0, nor 0x0000?
> 
> No. It prints 0x00 on my BeagleBoneBlack with kernel 6.16.0-rc5.

I think this makes sense because of the '#' -flag. The "0x" is appended 
because of it, and this consumes 2 characters from the 4 character 
field, leaving only 2 chars left for the value.

What I find interesting is that gcc on my PC does:

         printf("%#04x\n", 0);
         printf("%#04x\n", 1);
         printf("%#04x\n", 10);
         printf("%#04x\n", 17);

0000
0x01
0x0a
0x11

gcc version 15.2.1 20250808 (Red Hat 15.2.1-1) (GCC)

It'd be nice to learn why the zero is treated differently? Andy, did you 
have some insight as you asked this?

Yours,
	-- Matti

