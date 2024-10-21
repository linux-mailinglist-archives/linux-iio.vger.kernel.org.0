Return-Path: <linux-iio+bounces-10908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D29A90F1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87ED91F22992
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133BB1FCF47;
	Mon, 21 Oct 2024 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9SSSWrp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317041F427B;
	Mon, 21 Oct 2024 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542088; cv=none; b=NQNqJQoY6xfV8StSSU5OGQAY4vI//4En0pk+9bQaBpGYYdI44akZ9EHqQkpLZX78k/24F67kUkoR0w+4zMBCLEzhffebGmI+if9P0IQZgtszQhmZ8Uk+Z/sK76WIfGbmVG6DiLO/IaPmNXex5EZez7+Yf+4ttT+gy3sqv5KrQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542088; c=relaxed/simple;
	bh=R+gOOGAklFEQGI0nkzHeeDMAoaevyRkwP50dEhOj8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rR7+Ftxx4osQ3A5fcIboH11iD3XSiZC1HRJYTelgSDPwaQjeVGL2QbmMwHG1lHb7lJrIN8sHqqhCvJUc4ryjNywKiw8cMQucBeq3dMXPzqn5P/FTW1vOGSfIAaK9FOF/73RL7MJ/J/BtyI6OZmV3+tC5/xfTCHMYUqmWzZi4hIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9SSSWrp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315abed18aso45359145e9.2;
        Mon, 21 Oct 2024 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729542085; x=1730146885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETwqIgaEaWZWq8p1KWUUuaqTNZpld8gORejo7TS2iGM=;
        b=P9SSSWrpetQ3MlNeIfdTKa8fY6ImDxi64YmWHhmlGGHkRnBOEc9U2WjhLtQpagHx28
         JkyjcF5YRfZ5eKWqVqrj4x5c44o1ff8rGpt7hhMBu8bvCol7yLmmdtcey6J/HOKVMBGU
         Pyg2QoQo0PWvq2bwAvGSdP77vCYGoN0bm+Y+QLjIThseIr4+GuOwQP2PjrB5FJr9GGrQ
         aDhmcGfEw06VTzZx1GAcqp2er+uE89LU85bHVXQU1oPQ1LOX4LsXQei1ZB2+BLGKQ90r
         e5e/GiHl+0qvvEGHfMH7P/KmnFexKu+9wa3KkrOxQcg/5V+T6U0S5D2eKDvOeHojNYkU
         OzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729542085; x=1730146885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETwqIgaEaWZWq8p1KWUUuaqTNZpld8gORejo7TS2iGM=;
        b=tMT7d6jeyiOd8BZ7YwhNL1twZHYnQPjiIPKV0IADdCGSDjtjaylQnP5OTsy3uhq7h2
         1DN9Lkzp1jTrXAsTNFJffxhStdBvsmzmGW0IMHQ2Pxb97cY/Ah90x7gwkkPTNg6lU0Ax
         BuZh6Q9mtRUVjTbTL5odZfC+NcKE8DD+k5VfvkCRV3mj4ctELa5Rxn7cQyp+rJ6MkDnO
         jdwZreoplaHe0rXkiysj3HcBjjPo/Al62WO8ljP+59ERbwlXKGXIreAGDNbmu2zUCW2n
         r2MicFTIyNYW5xjUykJrDuicHTRkPQiSLfZipBo1c/bU3C6VdlK200XApuDs+ZfJBJN3
         tiRw==
X-Forwarded-Encrypted: i=1; AJvYcCUmWcfmnanyWyVTB1xqoScqwtMwq1MigkpHzcrMnQp/TvvN5IIut0eVEXqeTWkwf4PS16yZIwKzQqP1@vger.kernel.org, AJvYcCVbiuHtbclVaugbggEZMX6JL3ui2R6SgQkpb/GjDMHr2SUAhlOAva+qWX171BpHSZabrc9jLMO1depi@vger.kernel.org, AJvYcCVuIkiQJrv1Of1bZhxsIpSZoZl6c392YMGNSiLnOpzyY+A1kgQa9NcJSSVE915M1bKoO+X8rc5lb3sgSHCG@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUWvth5kLfJ+MrNwtoi5DynOvnQx9TQ34cWcXxYLUNVu5VSRo
	zMVKNYjMIxiIGGCyy+M4fB/wNF1kT18I3bGduc2tj5YuVFUdONfQ
X-Google-Smtp-Source: AGHT+IGVVGSfdMbtsRugGWZp78jGrNvSnWTFMzRnlwfRC3rmuPC8NGNwxqfitJG5qc0cjfHe9g/v/g==
X-Received: by 2002:a05:600c:1d85:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-4316163332dmr95215565e9.7.1729542085150;
        Mon, 21 Oct 2024 13:21:25 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:23d:d91a:ee8e:da73? (2a02-8389-41cf-e200-023d-d91a-ee8e-da73.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:23d:d91a:ee8e:da73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc401sm65980675e9.43.2024.10.21.13.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 13:21:24 -0700 (PDT)
Message-ID: <7323ca4f-2f79-4478-b2b0-2cfc350af7f8@gmail.com>
Date: Mon, 21 Oct 2024 22:21:22 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: add support for veml3235
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
 <20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
 <20241021193933.59c2d2b6@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241021193933.59c2d2b6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2024 20:39, Jonathan Cameron wrote:
> On Sun, 20 Oct 2024 21:12:17 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> The Vishay veml3235 is a low-power ambient light sensor with I2C
>> interface. It provides a minimum detectable intensity of
>> 0.0021 lx/cnt, configurable integration time and gain, and an additional
>> white channel to distinguish between different light sources.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Hi Javier,
> 
> I missed one thing on previous review...
> There is no obvious reason this driver needs to provide raw and processed
> values.  Unless I'm missing something, just provide raw and let userspace
> do the maths for us.
> 
> Jonathan
> 
Sure, I will drop that for v3. I added it because this driver took the
veml6030 as a reference, and that driver provides the processed value. I
guess that the veml6030 should have not provided processed values
either, but it's late to remove them after the driver was released.

Now that we are at it, what is the rule (of thumb?) to provide processed
values? Those that can't be obtained from the raw data and simple
operations with the scale/offset/integration time/whatever userspace can
see?

Thank you and best regards,
Javier Carrasco

