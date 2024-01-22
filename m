Return-Path: <linux-iio+bounces-1826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3335835F0E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 11:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022921C231F0
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 10:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46339FF7;
	Mon, 22 Jan 2024 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="I3B1Yr6z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FCC39FE9
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917848; cv=none; b=lpTs8TwB2naNFNSrFLi2sO1DxwiXNF+OXErQQAAAYbYRvY/JJ4rTmUg0u7RAc67vXHCwYMFvDVXyY177UHYa+5NtLmVlIhpRkG0GDhPt7JwuNwKcFw0BGArSnuQbsYctyc+QZPjxKnDlBJ3UQ7xEqYgvx6BhFAzP69b8KMTLjlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917848; c=relaxed/simple;
	bh=M8pszskSh+59GT3YDDj2kTESCkFAakxa2ZaO1j5Q8Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfzMQ43of+BfpTcRuCsVwyAB0JGLPDVzuhxhecR7+1UPNaswzXg/FjoC2cS3RDjq9GfTi5Yp0QIb3Q2WJbOUGWox+w+2QehPuO1GcfMDWXTH3GacLZsQPm0iiHN/ETquG+tV4ff23SHe8dMwROkNnONmtYBknMHrdERAkfVMmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=I3B1Yr6z; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso1161963a12.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 02:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705917846; x=1706522646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ni6n5pqeZznTel6GtkjfHQ44EXROGMS+h3Fg1e6uKRc=;
        b=I3B1Yr6znb0vi9wz6wOHqDEKrWZP4rkZCZrZSss4+GiNn+XV4XipHkyIbOIA9Bn3zL
         i8MfXuHCIfKW0DtoovkckjFYvFDsxEf4bOOhPwi6OtcRMSvBtiVp0RibjWkXecDK+Xjz
         OxoeEDryvbw9LfBdgOfJpHG/KJbxfqB/yBUtDLDuGIdTzB1tHziZCB3/EItXa6db5eTW
         5IwA1/HW0HV3Nf0OoZS2f7FRCwdmtuoh1L6/tfGM6tukbf1PueulY867b38NKdADcqR9
         ojkTBqlnbXgSisnPc3blTR0AboVe4fSrISKq38IBosCLr17mRu/XQjun8zPBjXtnNjc1
         gjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705917846; x=1706522646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni6n5pqeZznTel6GtkjfHQ44EXROGMS+h3Fg1e6uKRc=;
        b=MM98GSVtmNd+HBFWb4O/mwBafUbhrKe1VIFzj8rQSGkF9wJyxk816zxdes0d8QSFtx
         A9kiHBEP9j2y6hzFrZzMeN/RoDtz4nXHLQD4FDb6lRXdrbPuMJA64hRZ64ZqVhIl4cT6
         BCSs+j2MEDGckb8C/yiT0KUl26Jr9490+cqaBQdd3myUXAEKSpbqcaSt2oN2RdfCeTg9
         R/cdMHeLPeJKF4f8FcmXqcZjaYiyJytZ34WiDUDChNtQqUAtO0g7ApIH43Dm3+86+1t+
         q216+OifBLMwYHgnNdIIngH++VZjrgNtg7ChG1zXv78bd2KHzjhpHiw2BpUBAXVfgTow
         +akA==
X-Gm-Message-State: AOJu0YzLIexzrfsuawuECDLyDIaQInJ9ah1IylXRZm5D1tW/AmFt/q9I
	0ls6fRlZBKZwPuDtxNmnoPQFCgs7fQlRwsYgYKVZKQr908E7a06Pl39iJlOPF2U=
X-Google-Smtp-Source: AGHT+IFWhdobP+x4boZi7f4u5ncKwhvFSizCjj2v4j7C2QB2eYDiA0ptZEh6KxLq9DgxXVQGvcYSPQ==
X-Received: by 2002:a05:6a20:9388:b0:199:b189:eb93 with SMTP id x8-20020a056a20938800b00199b189eb93mr1581609pzh.100.1705917846321;
        Mon, 22 Jan 2024 02:04:06 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090b004b00b0028cef021d45sm9304508pjt.17.2024.01.22.02.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 02:04:05 -0800 (PST)
Message-ID: <4031ee3e-9db5-4e36-8833-2f7fd6fad3ca@tweaklogic.com>
Date: Mon, 22 Jan 2024 20:33:58 +1030
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-3-subhajit.ghosh@tweaklogic.com>
 <20240121153655.5f734180@jic23-huawei>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20240121153655.5f734180@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/1/24 02:06, Jonathan Cameron wrote:
> On Sun, 21 Jan 2024 15:47:33 +1030
> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> 
>> Adding device tree support for APDS9306 Ambient Light Sensor.
>> Updating datasheet hyperlinks.
>> Adding interrupt definition macro and header file.
> 
> This is an unrelated change, so should probably be in a separate patch.
Understood.
> 
>> Adding vdd-supply property.
> 
> This one is reasonable to have in same patch as the new device addition
> as, whilst I assume it's valid for the existing devices, you are adding it
> to incorporate something that device also has.
> Could also be a separate precursor patch.
> 
>>

>>   
>>   description: |
>> -  Datasheet: https://www.avagotech.com/docs/AV02-1077EN
>> -  Datasheet: https://www.avagotech.com/docs/AV02-4191EN
>> +  Datasheet: https://docs.broadcom.com/doc/AV02-1077EN
>> +  Datasheet: https://docs.broadcom.com/doc/AV02-4191EN
>> +  Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> 
> Old links seem to still work, so why the change?
My bad. I will revert to keep things simple. No reason, just thought of updating.

Thanks for the review.

Regards,
Subhajit Ghosh


