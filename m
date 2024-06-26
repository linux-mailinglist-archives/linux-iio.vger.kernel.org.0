Return-Path: <linux-iio+bounces-6944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F0917D3A
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 12:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925DE1C218F9
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD9176AC2;
	Wed, 26 Jun 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip7QHt2j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318ED16B72D;
	Wed, 26 Jun 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396281; cv=none; b=h4goJYXMRAjVgise7WzufYgXOecjUvSPgc6dREjvCLGUNgg0TK7sYhKH9Roxksqq7erx3nShro/G/1TFti6C415DA5IH+94zqaK9QzrxF7ACSe+F5Xa/yqe35yevVGZbEBq93VZUZ8XTNBdbYdiH9calWiCv7ks0TiyEyXaDu00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396281; c=relaxed/simple;
	bh=ifsho1Bpq9nFHxZtpGWLKZc4cVE13J0jAOZZMdP65X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgXC/Af0Z5Vjnp2LTjsZF7fsAb8iVKdODZuK6OgRre8/dYtGocR5wGqZy+RuNQACvPdGs5LKwPlJBlJjS54qp+vHvZKRC0Z8y3qVwUbpeAnIZDlRCz2CVRqVinQCcip8J6UrZ1E3GDuGi+MEDEYquCU7HVuAwSyMM6iB+cFSdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip7QHt2j; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-706642b4403so284274b3a.1;
        Wed, 26 Jun 2024 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719396279; x=1720001079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgRjjv+UP/7lm1V37OQnaVVn/e2alB6NrehAon7l1SA=;
        b=Ip7QHt2jMsPMmoBaMFmjXE2TviHU4OTP8E9QVfDqUP/OVJwYoSuQBIszJ9+eA8jxSP
         cnXw3XVrwkUvx7WdivlCCffngwYhsCYxYE2deEYB/HI/yAsg7pILPUxwjPG1EECHJAlf
         F/BkUr5plD218kHPyyNT0RtqKVChDDHBSIbk5G49BqBkDFPXVrjZSkHC/W1puAOAghzi
         O2ZmqcCGjzlTFx4GVAmQY0FB5nwp9n6k6I03dUZjTqgokZc4vm4xmClS4m7E3dWta0dq
         lYz9FSoh6AYBLArdhB+4hPNhrfZqrOZYBKCrhAMNQb2D3A4PBCJjjmfVVQLSG7I/H+6h
         WEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396279; x=1720001079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgRjjv+UP/7lm1V37OQnaVVn/e2alB6NrehAon7l1SA=;
        b=nxNDTs0hc4Gcf1ax3oV3nC11OhByBAUtzaa3zQOeNc95Bi6H1TuGm/WNzM9pv9Vjf8
         6ew9DARcCKrVZlqmnPF01JTbD1MJ/U+JfIF0eolWI+5C4DOi5pwKnWrkqJkHhBMj1g1E
         cEHqjzJwaQM91uRLqm0oqBOe4L2qMXhfrTSxxeuX8ubGQb2hf2BkETWIqWAA69SzZXIK
         NwLvQ2cYaecnqHhOMGJoT/OcyqrxSVXgheg/ruRHt0ERKTwpYHLX3A5Q/3zWTfkTLjiL
         Z5cmzic3VqdCPDdxyTZFCjLPZ2dtwc9vam6MA9wVpOca1lRpOh+LIUL7kDFOWu6xaGEu
         RC/w==
X-Forwarded-Encrypted: i=1; AJvYcCX6gt3MPJQaf5E1vug78qRVKOv6NYFUtd1IiwLN/3pfzGc1rb2ct7jeo37Bx0GeGDWLqfjt3l+iDVjlsQ+SMD96v0MVJaiMI7xBogvjDrgONHtr0uE1f52m+7y9lv1/JXtfDRFy/wir
X-Gm-Message-State: AOJu0YwC0g8oEZ3Y6aVfarNwTvTiX/3U1HF8Xe1fTHvUUCImRhDrvk9D
	fNh/XKiWBTJeYwZDEr12qPuQnSxmSvY63urP2gv7mLP5l87vBTZL
X-Google-Smtp-Source: AGHT+IEER2UCavTXJi/FlU8MU0ShwRAGb4SL9KXt5/X+KhaI9FfOna5CLUxNmo5hWkK4meu+BA6YOw==
X-Received: by 2002:a05:6a00:6708:b0:706:1bfd:4e8e with SMTP id d2e1a72fcca58-70669ba21b0mr13728619b3a.0.1719396279345;
        Wed, 26 Jun 2024 03:04:39 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067e71fa78sm5801985b3a.125.2024.06.26.03.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 03:04:38 -0700 (PDT)
Message-ID: <5bf89431-7344-4a5a-bc02-12ce0f729c5a@gmail.com>
Date: Wed, 26 Jun 2024 18:04:29 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v8-2-0c224e3bddbc@gmail.com>
 <9fae9adb-1b78-4f7d-94c5-6aed661ec614@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <9fae9adb-1b78-4f7d-94c5-6aed661ec614@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/6/26 16:34, Krzysztof Kozlowski wrote:
> On 25/06/2024 17:58, Yasin Lee wrote:
>> A capacitive proximity sensor
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
> ---
>
> <form letter>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> </form letter>
>
> This should be clear:
> *Tag is "received", when provided in a message replied to you on the
> mailing list.*
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Thank you very much for your review and guidance.

I understand now when to add tags like Acked-by, Reviewed-by, and 
Tested-by when posting new versions.

Best regards,

Yasin


