Return-Path: <linux-iio+bounces-6876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA191613F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06D21C23126
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD11487DC;
	Tue, 25 Jun 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Rr4tfF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69F1474A0;
	Tue, 25 Jun 2024 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304282; cv=none; b=uI1ViZwci1KPnFSK3LFZ6TWaX7iC2hJV9eohk3eCuEIr3+7hbicQeMnCEuRl+emh/ZxtZgx5K5BIxHDdr8+ugPXMfimaBncJaBNU8Ij6uLqnT4oqFTP5jh1Vbe8F1AxGLtdrXRBXE4lSg0x7CeY2/sW6yh7h6TDARtaFFiqSqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304282; c=relaxed/simple;
	bh=xUg0rQqgunv3C6E1wc77h0goZpObVGnyK7NbTOiHJ90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5hwFvJ6Z7/iW/ojZQkyTtjqdskQk6rfUJjzKeoQd7ickTtqeqp5U3dsz2DxKtFJR15dwvMRiXpzwBepsr265b30c4fIn9b/hQu3GiOlPuzSbvvT1OeUIsgMRwJImgAwF8z93WthY6puBruE8uYMLFKSmw7cggb9ngHsB/ZtmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Rr4tfF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066a3229f4so1992425b3a.2;
        Tue, 25 Jun 2024 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719304280; x=1719909080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soJUFs1bdM/i3y67PY3b9MKyzoy5nB0Fdohm8CoWotY=;
        b=j1Rr4tfFwcEXRnOG0GxDXK6j7Lvgdgpyo+JAgeOPZRBko6vRdN+Y9y17BFJtPXiGsi
         k8XZc85tQMMKJIxmnUOtlb48/lJq9fTdPXEbFStIkhXxdjCYsEB0Wr9V12ebZfAZq0zn
         mj3mig8GVSUalSPLQ9ZAJr5NxcX56mGMMd0EN+QgghG0ra6URUfEuE8ApkJbDy72AZWI
         nlmnlv+vLNILMSXAQTDTR7ND2+6pZbZuWrtVCjT9qLPh1DI34wEEfUKY0bMbr+aMjDUp
         fD5n+X2wKXlmt6WUx7Aeu72mzQULsCr+UfB8sOrXUEu6frxCRJbm5lhdbmcIPkyeApTw
         2lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719304280; x=1719909080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soJUFs1bdM/i3y67PY3b9MKyzoy5nB0Fdohm8CoWotY=;
        b=ViBUNUyzC8xRGDs1FKfL1sIP9jVYNec04/RLXyljtFh+t11ZTfpbFdKNf6he3MaYKA
         3HuqBC1AK3YA06Yz9lJswl3xCptD5Nc3Fkr3UtMCKaiyRBvfe7AKiLD3ETMhNX6ICAMA
         6fAPTdt9tESMdGBc93BZeBUkpRDhb82mfOQerHYfDpNKOXNehM9sHSBIvJU1M3tBuIsH
         7tbUlukjL+sotBjvPIxvpEPjBdezymTMXMSIHFOgnPujOk8f1gy+dPaGhRMkHU+fKXdj
         +fGFYsCKr/oWYTiIf1M2ihqwsulAAjdL3exF5XSlCEWhycfEET6fAB/Fjq3M3LKWsED+
         +8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzWHaAJTzR1aJIWDjumdDCnJPiP8TFjiUE6eisRFjsdeeOVwK7ef1mbwQQyX7k/JuTjNeUi8RKOj8S87c9KpyiMvKEsg1sNQnXA6LnY1nu6uiTWw3wKux3t+TN4c3JBOQPaqwGPIWy
X-Gm-Message-State: AOJu0Yxw5PpStmeZH5FcJWj9mR12OhM0AmMeHOq9bmt0mK11GaJBkLkF
	pS3ROo+P9vAY7tKs/RaBAxB5cn/doykZsa38lIbZJ3U8Gwy8D26b
X-Google-Smtp-Source: AGHT+IE+0bMo+J8hu+dF5oaFvw/zMgYPwTxFLomzmLZUQHmj67yX0huPHaBSHAKh6ZnMEJLfuOq21A==
X-Received: by 2002:a05:6a20:8422:b0:1b5:8552:3922 with SMTP id adf61e73a8af0-1bcf7e32860mr7623809637.3.1719304279829;
        Tue, 25 Jun 2024 01:31:19 -0700 (PDT)
Received: from [100.90.230.39] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55db329sm10094084a91.26.2024.06.25.01.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 01:31:19 -0700 (PDT)
Message-ID: <30600f33-71bf-4abd-9de6-1c7c07e94d77@gmail.com>
Date: Tue, 25 Jun 2024 16:31:09 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: vendor-prefixes: add tyhx
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v7-0-b1d65b221811@gmail.com>
 <20240625-add-tyhx-hx9023s-sensor-driver-v7-1-b1d65b221811@gmail.com>
 <8ce23bc6-e742-4851-9a26-ca2ab947005d@kernel.org>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <8ce23bc6-e742-4851-9a26-ca2ab947005d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/6/25 13:50, Krzysztof Kozlowski wrote:
> On 25/06/2024 04:15, Yasin Lee wrote:
>> Add vendor prefix for NanjingTianyihexin Electronics Ltd.
>> http://www.tianyihexin.com
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> This is the only one which could actually happen, but still after 15
> fake tags I don't trust you. Where was it given?
>
> Best regards,
> Krzysztof


Sorry, I think I misunderstood the meaning of these tags. I will remove 
all of them.


