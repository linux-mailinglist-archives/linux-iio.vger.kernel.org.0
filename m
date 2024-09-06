Return-Path: <linux-iio+bounces-9245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516196F5D8
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512D91C240CB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802E41CFEB7;
	Fri,  6 Sep 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CHOcpzL0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EB1CEAB5
	for <linux-iio@vger.kernel.org>; Fri,  6 Sep 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630736; cv=none; b=MsHNonO2gS9CslBwaGZz6AZyyd0w3ZpI6onrdNsALl95aImgwPR0GpsqKH0mA09V/TyEoGR/2sXmOfcqtlqh9qP7F18WEGk2oNdDdtpACVtuAjeGv5cci3JkOWDXsV4AjDIh6k1qCU5Nx8XEZnlOLuq+vqLKUGrtGABlKPCr2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630736; c=relaxed/simple;
	bh=ZnnnIr+K1A4FDAgDbTsI4z4N0wjchTOUn7euwi8txNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkBxVm1yVqay9Wj7m+GTanD5J9TIW79JD7F0sv5lCvenulDO2aDVyV0coLxIQHEB6h74F0XKGnv199qHtPEt1HDyONlT9rjXqXPhoBL0KIB0Z7lKdxpdZ35CwnbxlKlKBhkel6Ey5jZYxsEx7M/RIssjPQa5iLAw+3xV6de/vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CHOcpzL0; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5df998d7a44so1212257eaf.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Sep 2024 06:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725630733; x=1726235533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7F65YX/r9NBIT9OJBVYtcMbH5MfEewbpA3UhTv1Hc38=;
        b=CHOcpzL08COsi3DA8nod4leSZHxUQXENZUwPw0Z6g6mMq3bny3dfIosn1VL5RWzRBP
         J/hWTADAr+KAo5VQaCwy+dc2493tb/V572u2LuKFaefvkiO4mrpqs0wmyNWmUHCI7/zE
         v6jgHBbAoe1kYxvb/GdrP5Jk01NoV7E46yl/l1GTcCSxHVyrgD+iRqhK3Q3XCS0JGJ1v
         RzxhMY+dWb5t6ZUt0Ljj1/cbtuO3ucdGq48/gDAMEkN08K7+Z/4BpcFD8JG5NTIWQ9Xx
         xg9bp2QnYr8wx8J20hiFE8w72GU3+mpmJvi9TeFJUdiHp2O0rKjwJ77MhRHLJiyXxIUn
         UQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630733; x=1726235533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7F65YX/r9NBIT9OJBVYtcMbH5MfEewbpA3UhTv1Hc38=;
        b=HHLLQ8WoI+M82CdY90BvugJ7rcg79GfEBqnCDoPIA5BY34DFRqX3MhL35QxP1XL4hw
         EJsFnRXtwPtTIv/GfUQjvQm9QjBmCwqCFnT0DlYyjdU2Ud1hGBvb9BrK0f1rgHoMqaEJ
         UiW1kKas9Nx4owzh4m8PMZMgHG8RGwO3WdfU1Ur9tW2TJJuB0Drl4MsbwLEpVrWxDreo
         bIUOK6QpmXjRQpavvu9ezEzMrRzYF8N/FbE74Jq4tl0p0urulvB6FWetT+G7/d5lo39i
         ykg+t8e3XHHcz7IBk29/mVt8iQ9djpZT1fXglXoXUIZXHyzOK2LPZo4gJb7ZoBekLNYo
         b0hA==
X-Gm-Message-State: AOJu0YxXgDXrJUv1Zb0l3T7+ZDOYJNe1h64jBDt+Jua6gCH2+ClDMcV5
	hkcelW1HnAGzmwjG7gs5JwrEOeBNOeIU11GKLONd24oO3ZRnv9w40WgtdX25c3c=
X-Google-Smtp-Source: AGHT+IER7xfw1Yyx+nyfJspkCGKpanLKB+G2/swE0L8dMzDsGxWsy0bEMNxwH5FdtTBW88Syu8yO2w==
X-Received: by 2002:a05:6820:621:b0:5da:a4a7:8f6a with SMTP id 006d021491bc7-5e1a9cd68damr2960294eaf.4.1725630733327;
        Fri, 06 Sep 2024 06:52:13 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5dfa04bda37sm2981801eaf.21.2024.09.06.06.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:52:12 -0700 (PDT)
Message-ID: <b8dfda0c-11fc-4b2d-b47d-f234cde87cfa@baylibre.com>
Date: Fri, 6 Sep 2024 08:52:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of child
 fdt node
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
 <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
 <35d882417c0a9c37e51b878790e2fa31dd0a1d63.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <35d882417c0a9c37e51b878790e2fa31dd0a1d63.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 12:42 AM, Nuno Sá wrote:
> On Thu, 2024-09-05 at 14:19 -0500, David Lechner wrote:
>> On 9/5/24 10:17 AM, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>> Change to obtain the fdt use case as reported in the
>>> adi,ad3552r.yaml file in this patchset, with the DAC device that
>>> is actually using the backend set as a child node of the backend.
>>>
>>> To obtain this, registering all the child fdt nodes as platform
>>> devices.
>>>
>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>> Co-developed-by: David Lechner <dlechner@baylibre.com>
>>> Co-developed-by: Nuno Sá <nuno.sa@analog.com>
>>> ---
>>>  drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
>>> index cc31e1dcd1df..e883cd557b6a 100644
>>> --- a/drivers/iio/dac/adi-axi-dac.c
>>> +++ b/drivers/iio/dac/adi-axi-dac.c
>>> @@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device *pdev)
>>>  {
>>>  	struct axi_dac_state *st;
>>>  	const struct axi_dac_info *info;
>>> +	struct platform_device *child_pdev;
>>>  	void __iomem *base;
>>>  	unsigned int ver;
>>>  	struct clk *clk;
>>> @@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_device *pdev)
>>>  		return dev_err_probe(&pdev->dev, ret,
>>>  				     "failed to register iio backend\n");
>>>  
>>> +	device_for_each_child_node_scoped(&pdev->dev, child) {
>>
>> This should use fwnode_for_each_available_child_node() so that it skips
>> nodes with status != "okay".
>>
> 
> device_for_each_child_node() already only looks at available nodes IIRC
> 
> - Nuno Sá
> 

Ah, you are right, I did not dig deep enough.

