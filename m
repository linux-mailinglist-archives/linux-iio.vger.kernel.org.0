Return-Path: <linux-iio+bounces-26473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6ADC87380
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973773B582A
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54BD2FC877;
	Tue, 25 Nov 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxomuv+L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D02FB0B3
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105799; cv=none; b=scaT/nfFVtSum4u9g+m/s9alRuFzaoZZnOjTLaJTJk1973YvZ/VpWHU9QmSqUQniPCfQ1mNX8sRdaXJ0i8GC3/EdsJj/Izz0McteheqWjYKzDo0TnVZtT0Jr+bbGFGQ4cteblREvB2W0ElDxx1IV2Gdc3iVxWVHjsmxlRjzomeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105799; c=relaxed/simple;
	bh=XW8A4SzGkXNACEumt8HO2D04lyJS8Mfw08PkaKSIHl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Urn1mimpLBJfsUa6RLCjxNBrOBq8EaxEVZU1H8noSPdSkqqcTYSQPPBsAgKy23Uqwofsh8MEcXG83mZnv01pdlyHKfPYOZ5hC8XLpUQ0q4bxtLVkTelFhe173yv7kLGpBdJIF9G16qBTFA6QrRoiGCA3s9hdXFnNOf5cIPnjykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxomuv+L; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc0e89640b9so3835725a12.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 13:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764105796; x=1764710596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4IPiaiC8wPPJ43L5jRER+JtLVLAZIm9IvLWnVk5O64=;
        b=jxomuv+LDLuWrt8BHvoPK9PCJoKFokds+p7JXcTxp33BbfVa5yluoYVGSy1rqC9dvh
         MN/6dLjD3TAUVFYjmoK0pxBVvD4e6mxdxKDTBWbFR9IMVAKjXy405uZnaulSSm6tdcaP
         vSwI6B7yqF0wMnjQGaI8NCi95wYpAiZvUG/66X0kmuoqsdf3YfB5yPk5Q+neT/5/1lCC
         Yzf+D3FTpt+VGN0kVxbpAIFOsQ9r+nOx6inPnNvdOb/fcw8hJMGw9KvmMFr+/p8CNFib
         GHut+daAkxA3VtnHPHvLekZoOE3EOsvjR759RUCEzAw9tZjQJ73CIg/SJ8DsIhEA1cWI
         hTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764105796; x=1764710596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4IPiaiC8wPPJ43L5jRER+JtLVLAZIm9IvLWnVk5O64=;
        b=dRa8NvIlcI+U+cxNqEFIa4oeBffGaqQSsxl5ssdZK4atHKFi09uyC25I3kfW+Kz9fG
         852CqiMF6XvUhtiTE+EneCNrzGMKbxZ+LyEJ3bgstlVLxk651zDTRpSlJSa9HXMXwPGA
         lCUKdXGMwkimpV7UFS+DqYS98CkYJD9fPZ5mdBVgfKawEYHWIpKNn4mDb/KFWvDbq/AJ
         5jw82bP77VTCG4pC5Nh8v05H7Y7DfTgwzb0uuhtP/ZAvdzgfVcInQ1rhAKichHWohDAL
         7D+jbhJ7VZBWXYVgBqJc1yjgrIk8iuBOXeFYp9aHGb5VdGK8jeBqDuBVSwGexbCUD7je
         Ns+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXcG3EXSQFQmE1YRHwmj+zgYO/LGXtC/llAO+bw3CEnjaAqmxDKOIsyhgUGSuhBwJldgKvCMSXZpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX41Z/N9s074XrXdP9LOib09xluDRtejPI7HS7M5RFutNxxvmA
	ggBezB+9UWMsigaoiMj8taMsA+StwPvpRn3JdEmHdDLrPlU4ALV4OMsK
X-Gm-Gg: ASbGncsxNte0ER8Oh1TQVLLtdQ23NpIBTOIFC4MrsccsaWF9v0mI6MXxdtVSdO1mFsL
	8BKiTvz4PDvUDtDbBDe/N/XaxkMa7PtNEYheYsjOKaonYVlF9ELVqfU2DK+uL7HRodHKdSyjRuO
	kN77l0QVq9O9gFk5dxN5j+RG3Ln+nVg32j111wFnVBXtD3zxC1rfwFT7RZCTZCKJiOao+qiXn4u
	HCV81j9lCdLde+P66Fjuah9N2layykDa9513jkCOYuHvX0pHMpZxuCJI5RcnuQLBI44vJ8XQkcK
	IZZhFyf668qLZdLGT/keyU+/+d3bwaDAw8rxkkhm420lXMpu17zp+SQnAMdYNkgVn1oM85CydoB
	a8uZ+bwMfoMB6+05xjsCi1fOPwdll+Si8GPJmKiW5vXTKZXc3mHwq7WkzdMzFdxHg8nE6rYrwME
	VOKkCmGhm9Yd7z7PjFgyKJfkhXz4uN2jI5gPJygcS7CKKbhtWbMrjRekr7oTXyZ+Dx
X-Google-Smtp-Source: AGHT+IF6D8g2wIy+N6TKTf0dz5XOxIIs00ONhYLTRePucR1HQFiuvK+uZSIsc+LE+bc5dfe4y+fV4g==
X-Received: by 2002:a05:7301:100a:b0:2a4:3594:72ed with SMTP id 5a478bee46e88-2a7192a78d9mr9719248eec.28.1764105795955;
        Tue, 25 Nov 2025 13:23:15 -0800 (PST)
Received: from [192.168.68.63] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc53169csm63700374eec.4.2025.11.25.13.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 13:23:15 -0800 (PST)
Message-ID: <61e860e7-fc3b-49ad-bf6a-9745f205d52b@gmail.com>
Date: Tue, 25 Nov 2025 13:23:14 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
 <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
 <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
 <aSWPnRBRdPS8vnir@smile.fi.intel.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <aSWPnRBRdPS8vnir@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/25/25 03:14, Andy Shevchenko wrote:
> On Tue, Nov 25, 2025 at 11:45:22AM +0100, Konrad Dybcio wrote:
>> On 11/25/25 12:35 AM, Rudraksha Gupta via B4 Relay wrote:
>>> The bmc150_accel_set_interrupt() function assumes that the interrupt
>>> info is provided. However, when no IRQ is provided, the info pointer
>>> remains NULL, leading to a kernel oops:
>> Hm, are you sure your device really doesn't have a pin connected to
>> the IC's interrupt line?
> I don't know the actual case here, but in general such a design occurred
> in real life. So, shouldn't be a surprise to see another polling only mode
> connection like this.
>
I unfortunately don't have the schematics, so I can only reference the 
downstream kernel:

https://codeberg.org/LogicalErzor/Android_Kernel_Samsung_D2/commits/branch/downstream


The above is my kernel tree. This is based on:

https://github.com/LineageOS/android_kernel_samsung_d2/tree/cm-14.1


but with a few added commits on top to help me navigate the codebase. 
Notably, I've removed all .c files that wasn't needed by the downstream 
kernel, and verified that it works by flashing the kernel with 
Cyanogenmod running.


Based on the device's config:

https://codeberg.org/LogicalErzor/Android_Kernel_Samsung_D2/src/branch/downstream/arch/arm/configs/cyanogen_expressatt_defconfig


There is no .irq defined for the accelerator:

https://codeberg.org/LogicalErzor/Android_Kernel_Samsung_D2/src/branch/downstream/arch/arm/mach-msm/board-express.c#L2100


I also couldn't find a hardcoded irq in the driver code as well:

https://codeberg.org/LogicalErzor/Android_Kernel_Samsung_D2/src/branch/downstream/drivers/sensors/accelerometer/yas_acc_driver-bma25x.c

https://codeberg.org/LogicalErzor/Android_Kernel_Samsung_D2/src/branch/downstream/drivers/sensors/accelerometer/yas_acc_kernel_driver.c


This seems to be confirmed upstream too, where one has an irq:

https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts#L420


and others don't:

https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/st/ste-ux500-samsung-kyle.dts#L439

https://github.com/torvalds/linux/blob/master/arch/arm/boot/dts/st/ste-ux500-samsung-codina-tmo.dts#L506


Happy to split this patch series into two, just let me know! :)


