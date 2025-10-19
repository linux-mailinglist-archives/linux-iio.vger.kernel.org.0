Return-Path: <linux-iio+bounces-25273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B1BEE828
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F28C4EA665
	for <lists+linux-iio@lfdr.de>; Sun, 19 Oct 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9462EB874;
	Sun, 19 Oct 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQwT8yy+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0B2EB846
	for <linux-iio@vger.kernel.org>; Sun, 19 Oct 2025 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886175; cv=none; b=mdE1vzBK/ZhaLcrAjocx9tn0WltsvfSC+Tl7soU5a/bN0XVM9lGzPOjMte7N2PEstZZ36bOQ4dWnRVlZN62cW6+I1tIAra/clVJhesK3faxI404D8QWCn9nXCSqDWmFnLfddybdjCPjYLoftoxFH+IZ4g04XwWYZNJ/UvTkHZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886175; c=relaxed/simple;
	bh=thfAJOE7VvV2d0iq3uuYmkecASflPVIVOrCkHSWAP0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTa20M+SCZSZHpl4xaBc/l6ngXq2v04jciCugfrmdHOnThPbqCuclG7MtnIY0NHBqYeGtJaUeYtV6nDgm41r8ypyCuWPEQ270IhPEDIZRqW+QwWvsznbC1fQCmFKutWGhYez9HqGleieAZEiFGddhPlVkRhofscrtKGk+2v8ycY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQwT8yy+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6271ea3a6fso2265146a12.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Oct 2025 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760886172; x=1761490972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z8sB9nRGtypw1eEej1buMuUePw14QOxaqC7fWlM0wc4=;
        b=NQwT8yy+WU1QVmbS+8y2R68Jlf3dW2vuTfjCbxB5rQMqwQOFURYoT8FHzacVm2zmkS
         c8iYn9ygO/jK53l4Xxmg6R8FIlXvsIg5Tg1wGD1fdfXLdOjoH5bgOZmt12q4HlU+2rrR
         KPa/KF1R6p10zD9DssU3YnekBmR7iz4vymx6EFZ1BZlqFaQZElWm4Z1IfZCvLwGdQShC
         VmHZIoLPbFv+Vz0Fd4f91xaGrOfN1uUu0vvDcW84RWE+wMn3t7VqXynX+7FeMEMJHcXQ
         rYCiz/wF5M6n0YqDNqlUcFX//WlOGwc1oVLQBrdzlzVJOaynPq2HJL4KvZw6RDk440Wq
         OMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760886172; x=1761490972;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8sB9nRGtypw1eEej1buMuUePw14QOxaqC7fWlM0wc4=;
        b=ZALToeEQcdLccGtPT9erqeQA/K47rbMNTFEfc20rpXzduzJzUlVfXtAY9pqH5+mDXm
         yoTKOe8SGlQ3XEwUetKKOqJOK2YcSX6eehxv2RoOzjFbEHTpmbcdmMY2abvA7cTt2GQ2
         3ZlHMvai1Rfjv222lpyE5qo9g2NZIXGxjvyK6Cww5mC5f9RiDrN0jdVRYnSN1O4hrk4G
         Pa9BVhHSHahl42rvHmH20AwLJTXlaQfEHditAKbbS48LicKdkXUr3uGaPA2exWVogMFw
         ANCcKy8KmiHUKxvK5HuThyra6kj8ecU2Jsi+T2WCliIuaIMjTkulll1zjRCO9ofFXCC9
         3Qrw==
X-Forwarded-Encrypted: i=1; AJvYcCWLXfDILE4SFKK0xuKnsQwGQX6zGQzutUOUX/az5aBwxIqluPwbtV7kBFEJmFgSwFabpFXGKyxZosA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnKZx20Sg+tybMQfVULaPxS3YucRLQfLopo6GFpJB4gZTHcAE
	+6EA+N5DoX4Pl0UCzsclvI+4Jz2FfOvOf0zLflwEZz3Kjdwadvmj2eoi
X-Gm-Gg: ASbGncvY1rhl1fd840j6dljGLyOlAxe1LHFwNTcfeHMT7yTjLqzkQTeKNp5kZT2Eb56
	L0hVQsKw7busPOqdTVlT+5QintxPDL3RLG8ItFEBvcMTWVLa0/ENOBuR8g8Kz1r1xMHteGnSpUd
	CiJ/1vNQLXbvCb+h5P00tbQcCpwaV0rgEWVtJOmN3xOmCFbkQSrwe8JN4nUDxa7HzTfa1wg30uB
	y36EK6N/A0+XOfca/pIWISTJKg+7oB9TLMCRDAV7Y1KGtDJjdQ+Np81FP/6hGqRHZTJMT7/A4jU
	fmQkNePrpzeWoaN9cBDAUVIR0oP4Ms48XNM8OYOusg2M/AOyXZ1QvgbrmoC/QkSo4qmUvCIU503
	imsZgKQJVj/kSxlVe3KAYOxc2diqD+VYEmZPCaDB6DRACqn+WZg9wGmoCw4KIFeUbabg9Nt22yP
	ToNbwX8ZsZuYbDB479GwScJaU6YBrruGc6tzPnLknbKYMLscBe
X-Google-Smtp-Source: AGHT+IE+nG9GGkTpmIQrHyKApNJgVKecmEYim0JEEJhW2H5jA2ig/9w5Qg5pcWTNC+Hq+ReKrls+jg==
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id d9443c01a7336-290cb65b8e4mr124763045ad.48.1760886172156;
        Sun, 19 Oct 2025 08:02:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fdc0desm55409025ad.47.2025.10.19.08.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 08:02:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4193c55-e2fa-4689-aae7-b0520909127d@roeck-us.net>
Date: Sun, 19 Oct 2025 08:02:49 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Adding support for Microchip PAC1711
To: Jonathan Cameron <jic23@kernel.org>,
 Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
 <20251019113146.74c3f236@jic23-huawei>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20251019113146.74c3f236@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/19/25 03:31, Jonathan Cameron wrote:
> On Wed, 15 Oct 2025 13:12:14 +0300
> Ariana Lazar <ariana.lazar@microchip.com> wrote:
> 
>> The PAC1711 product is a single-channel power monitor with accumulator.
>> The device uses 12-bit resolution for voltage and current measurements and
>> 24 bits power calculations. The accumulator register (56-bit) could
>> accumulate power (energy), current (Coulomb counter) or voltage.
>>
>> PAC1711 measures up to 42V Full-Scale Range.
> 
> Hi Ariana,
> 
> For devices like this where the datasheet explicitly calls out usecases in
> power monitoring e.g. for "Portable and Embedded Computing" (amongst other
> things) there is always a question to answer wrt to whether the correct
> place to support them in Linux is in hwmon or IIO. Note that, whilst this
> has long been an informal policy I've become more strict on this after some
> concerns were raised in the last cycle - the presence of similar devices
> in IIO isn't necessarily a sign that was the right choice, but it is worth
> looking at the history of those divers as it may provide more insight into
> why they are in IIO.
> 
> To address that we ask that:
> 1) Drivers for this sort of potentially borderline device are +CC to hwmon
>     list and maintainers
> 2) A justification for IIO making more sense is included. That can be
>     based on what cannot be supported in hwmon (high speed capture being
>     a typical item - that doesn't seem to apply here as it's only 200 sample/sec)
> 
> Anyhow, I've +CC relevant folk so if you can reply with that info here then
> that would be great.
> 
This should really be a hardware monitoring driver.

Guenter


