Return-Path: <linux-iio+bounces-15286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E90A2F5CB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 18:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48B43ABB29
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28C25B66F;
	Mon, 10 Feb 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q2OapXjo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A94690
	for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209600; cv=none; b=EZXjt/nSmNTHcW9Te/EZMk+5O1+/WDzlCr40wDuqwr9heBcpuQ+81OaH9j6qW/sI4YffdMcSh1WWwB5EguopujwPd7IHDb0ervQ2acd5lPcMk0FNqpE8vwDH592zZWktHEEm08jwiHEJRO13IVJYOEHdZyZyabDBaPUeOYEW7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209600; c=relaxed/simple;
	bh=+A98k+sAmcufovTNHfyvEfQSqcf8dQP3+Dh9ctdYW9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ree2o6RoECdGnEC2CaDyZEhJpFtH1o/eK2U1ZHh9fnBza27+zZoHOwK/w12dva7KBjo9qK6HJZrEq9CtquTSsDYzuF7iYJETjwyaYdQCkj5YrWWMohzF3C7XHUDEmX9byMFbqV02aJnGbQSrWjMX2hBBN7pib0wu4GYfCrKrA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q2OapXjo; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e1b1767b3so2738652a34.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Feb 2025 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739209597; x=1739814397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6W94naQLRK8+y/4SYAmK1yTZPlK/Dfg6vhKB3u1G0kI=;
        b=Q2OapXjowMxN3rv4r5TIJPytNz70LqlQQho4JBP92mAIuMGgH4I1UOD1LYyFxuCj9t
         yu+BUl4qUYK64rgGcqH5ghpjzBtXqAl2/2O1p4i9bCesqnBPDclvz6MtXcWgIVjaeoUh
         5opkkm0/D9ydqk3efng4P4mXR7H++CLrHZQDRNylt07pYydFfPW/4FomHay+Jck6QXVP
         H94nu0xSjn6buZYXBETDkD7t+0qDcAR8o5jMZSHDBruoKxPvbxV3cuvKwE5JvJX5TBKD
         wqzGCa7AjBnLR+AjbHElRiBAAZ4RqT3NNiCmAsAhpGxXPw/NCYgNA4z6jnWrFk+hw6B3
         +NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209597; x=1739814397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6W94naQLRK8+y/4SYAmK1yTZPlK/Dfg6vhKB3u1G0kI=;
        b=eshwD6fm0B4Z1FwAN9MTSKkbDFkl4ep1W5z7/UaQP50Kqa6kz0jO6xXMt5FE0IRu/k
         0LcS37YZX7lck9HIuop/IVwY5mSZCzzbPoJLkOS29gsPYJURDoUsrJp7PGUTII3iHGt0
         wcZeZ6tAsmTV9hju6setEYXgWRvhzzcB7k3YBBKPbZfWjDXmaym5ywDqaFlE31eW/g1h
         weyoibwAolu4SFl5XTMzwMfVY2rOhKt4gkYnLi8/WtyBY9RR4epVvZlWn44z2coVhEYd
         7YcoLDysI3tOxqW5nctMSPX0zx6dCvy+vBA4wvr+BaklCMMShx2OH4+QN2CGyNviDdas
         rcBg==
X-Forwarded-Encrypted: i=1; AJvYcCXfq4igSykmsDdlcbVnf6eu0akJumKnRIFADKlBlwSyV/EZQ561p1t+QJtslk89NK6bQtuZwXCj9AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcS2fGDaBZo5/3xon7mix1P3gwgLUleAkcHgl3QL5n2X0w7UW
	r/eFKxjxCAj+xFQbFVWrPcS8qMffD8pymAHZXIRjljAJa9wThtPeFpUHMn3GIZsm5USDa+PtIjR
	L
X-Gm-Gg: ASbGnct4UNyBw/duZl93omUeBVMxiOZ9P+G5gzg2crceY1trj88OmpUbvaigioNSs3g
	+61DAJxzaEP448c6Xpak63DGZsIBDFwMzQfodXdYngE9yXwjUDfjdeAWUBwYnHJql432BHKPgJN
	EY2SevxI/mM7WUipAuoovNnPWhmwdAUrciwS1UZ2GOnyN/Uts2SyBrjmmVNMVMCbmCVf+GGxEjt
	nzi/OHdD6F7EEQvY3nxsbLWmbWnSniS1n2fzLeopSi6aRBEXZMM9TZfYGYf+bngqq12SsjN8Zt3
	0SKRqHCcto73Jm0UDlX/DJDeLC4QW1vFbnqAflzaaNaEJy9GXk1u
X-Google-Smtp-Source: AGHT+IHZxsWqhk16Yq2a28IYDcgso03pKQZu8ttYmH1MomN7nDCz9XbgOBKfi0bwYMWBia0JaAre0w==
X-Received: by 2002:a05:6830:3741:b0:71d:415a:5d18 with SMTP id 46e09a7af769-726e78c8ddemr350102a34.3.1739209595255;
        Mon, 10 Feb 2025 09:46:35 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc545bc40esm2541831eaf.29.2025.02.10.09.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 09:46:33 -0800 (PST)
Message-ID: <c0f6e439-973c-43f2-bf6c-6a64551161cf@baylibre.com>
Date: Mon, 10 Feb 2025 11:46:31 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] dt-bindings: iio: dac: adi-axi-adc: add ad7606
 variant
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 Guillaume Stols <gstols@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Alexandru Ardelean <aardelean@baylibre.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
 <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-1-160df18b1da7@baylibre.com>
 <173920794511.669517.12561205201983200892.robh@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <173920794511.669517.12561205201983200892.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 11:19 AM, Rob Herring (Arm) wrote:
> 
> On Mon, 10 Feb 2025 17:10:51 +0100, Angelo Dureghello wrote:
>> From: Guillaume Stols <gstols@baylibre.com>
>>
>> A new compatible is added to reflect the specialized version of the HDL.
>> We use the parallel interface to write the ADC's registers, and
>> accessing this interface requires to use ADI_AXI_REG_CONFIG_RD,
>> ADI_AXI_REG_CONFIG_WR and ADI_AXI_REG_CONFIG_CTRL in a custom fashion.
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>> ---
>>  .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   | 70 +++++++++++++++++++++-
>>  1 file changed, 69 insertions(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

Caused by missing dependency from v3 that Jonathan already picked up.

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=02ccd7e5d81af4ae20852fc1ad67e7d943fa5778

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250210-wip-bl-ad7606_add_backend_sw_mode-v4-1-160df18b1da7@baylibre.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


