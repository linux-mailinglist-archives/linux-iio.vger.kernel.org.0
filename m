Return-Path: <linux-iio+bounces-12986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E129E1421
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 08:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3196B21F6A
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42D18FDC9;
	Tue,  3 Dec 2024 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3WbDip/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36518B470
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210622; cv=none; b=kM8OZrHnAav8wY3Y7qKQH09oBxxK1ndXW6XOjjIRs5LaKib2u3+X825UiOjloMdtV7mOY9MEIFkycn3BztcULFHG13FnbTnVEQekQMD1wRLPimEmCpFA4TDOfzJkVpOC6Vu4VMYBw9CWPb793pxcaIQzpLaL2uTJpWIVCIw6VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210622; c=relaxed/simple;
	bh=sfsrLHQenVwdb3gi3yEoCkvl6ivRHHYrDS51eqUQFvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svDsS58rjt1pMIX7tJZ8LuGfQZuotUyVuhzbqmYsDn9LR/DXfOULHTG5+RWe8TUHdoP4MZmK6mJ+7fIGnHrM1qNmIoAMmVB4cUMffEsbJdsCvie9NpaCv1hAYGT8tVbCYWdRq0zjET4p2xKpaJisFVttEaALb3M9cZI8U9YN4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3WbDip/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a36b82b7so4620585e9.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Dec 2024 23:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733210619; x=1733815419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/91xuqITk+GltGA0sI0HtdBhv+y0RGaZqN6WSvqLMfg=;
        b=b3WbDip/Y+u9FiiRSUCJO6KCKPpCNtRnsdZgrZaUtwThSj6jSVXjRDQmEe/mfhOzu9
         YR3M2vNvldWo57UoDHtGeGIa7BKK0vQaUX7Xf/rDcSMiQkt9FiggGqznNrlLVnOTfRWl
         gSvcZebKiJj36VL18PKuv1V3PekiQfZEm7alFWGURFRbOCFZfl9z7Xx9mS4GE98TJRi/
         aLXnpLiFOAga9vjeJppYEWQIhqs+TKoqOWGAj0Dafk1jOhuQfxnpVbI7ymcFPAPuY5gk
         mRfLjGcIcmF9Y2MTmWawoC0IaMA8DfNJMwJdl8IL+D8cgtCywrPrU0IOvxtGmqDC4kAA
         XKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733210619; x=1733815419;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/91xuqITk+GltGA0sI0HtdBhv+y0RGaZqN6WSvqLMfg=;
        b=e3XPMNX4f37u17+L5jVSN4fkuKs2VGHU8HH5mXEWHBEGoHh2sMUJ2DA6QYQFKP6HJm
         gT0rB5XmjLR/exLAkjfFk89aAkrrDiZJJopsEH8YNf8qfH09CdEYCf4DSx9Ec9iimbD9
         UYVd1aZOq/p3ZoMcOGEvEeEETVBUUNpSeR60UkeQx37ZCi92uJQICB1jwYyetW+mVelv
         KtvXWYp+Zi3oI0kBOOOh/zwZ9SZZVltoq7rZleqaGCT4cjD9lN0Rkm4CwcFNh+Msh5XG
         8Nu3UvuhESGGM+6XiXCXjgzE6qq8IK3vvcUa9+3CE45Roaf7fuYSxE3mHrycWKQmGXeY
         bsJA==
X-Forwarded-Encrypted: i=1; AJvYcCWKxuFrNNvAc7vrfm6FR7cBJ3MjeQ553s8v7KSmh+rifphhV3Fdcub3rPZCLnlyp4A7iA5RcwemFBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw17kjYiuYdumBcsCGmdpntlVadNuKlujdWrFJCA8DHo0792ZIf
	Z8+cohpUHS5C7ayIslBdPMZ+1ansEaRcvmbKzHk2Z7dYvKyR/J+mMbm6oKn6Sag=
X-Gm-Gg: ASbGnctHQYmulzvMrXKOWQgvrMs60cmr4EJdANObYiPU4Zh2kCRep3vXc7ad98lgKFI
	XoUocSfNYRbe5L0nCBXjIP8U8PlzDTv3g5PpaN/l1SiiZDsJQBf6aVecBGIMNDFgfmH3LM5Clca
	3eUTcRC9N8mmJNA/JZQQBvfBhjEw67q8v0e+ci0mmSBWthYtUBCd3KdMqKKyQ7JpvR6AXNHK0SL
	f9XbfVScVu0XDA9YWnQMMmFR5GVLq0RKIy3KFrcaAo5RwgeY3rgPbHi8EENlmgZcLm7
X-Google-Smtp-Source: AGHT+IGEf4xa3iUiO68cVMCRutIBsMDpZkfAInNM5pRE6IApqH/YMYOCMXQv0XInIkRbVlFj4ThwWA==
X-Received: by 2002:a05:600c:511b:b0:432:7c08:d0fb with SMTP id 5b1f17b1804b1-434d28e4323mr451805e9.3.1733210618676;
        Mon, 02 Dec 2024 23:23:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc11sm183154845e9.4.2024.12.02.23.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 23:23:37 -0800 (PST)
Message-ID: <e5960ea6-c3f3-4cb4-a93d-adff20a665e2@linaro.org>
Date: Tue, 3 Dec 2024 08:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
To: Vasileios Amoiridis <vassilisamir@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: ak@it-klinger.de, jic23@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
 krzk+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 devicetree@vger.kernel.org, ajarizzo@gmail.com
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <20241202181907.21471-2-vassilisamir@gmail.com>
 <173317237354.3142409.6212368803030680874.robh@kernel.org>
 <Z04u8eAvytu-y8LH@vamoirid-laptop>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Z04u8eAvytu-y8LH@vamoirid-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 23:04, Vasileios Amoiridis wrote:
> On Mon, Dec 02, 2024 at 02:46:13PM -0600, Rob Herring (Arm) wrote:
>>
>> On Mon, 02 Dec 2024 19:19:05 +0100, Vasileios Amoiridis wrote:
>>> The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
>>> in the device-tree.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>>> ---
>>>  .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.example.dtb: pressure@0: interrupts: False schema does not allow [[25, 1]]
> 
> Hi Rob, Krzysztof,
> 
> The error is in the example, I put the tree from the I2C example to SPI
> but I used bmp280 which is not supporting interrupts. Will be fixed.


So you sent a patch with a known bug or just did not test?

Best regards,
Krzysztof

