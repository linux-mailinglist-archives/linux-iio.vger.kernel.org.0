Return-Path: <linux-iio+bounces-11287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FFF9B05D7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136901F23F5B
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816D1FB8BD;
	Fri, 25 Oct 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DV+qhtQY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734271F754D
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866600; cv=none; b=YZHLxIHAKhH35FicXEl3G+AXFfcWuivmwOX3uiOYrOa31mwf8kxd1/HBGP6LKUcrKhbW3X5Q1rPR/kKfI/Y6LIoVSl6bph/ZbsbeEr6ULte6T4ITPiAmnPp+I8sFo91h9dUHM2loVpasndPIwojM0YSemgezoBY58TTB3OrKCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866600; c=relaxed/simple;
	bh=pTftS9bMzZrb3oqKTgBMUbVyt0Jac+cE/be9TqBysXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoDjqAk7m0T77t5tEzNr/ejxji2WACzfsHu1r6YcrBlu9/ygDnjBGvv1YYpFz2klkT6YGGI1Mr6dD1crIbXDnob402qYcgZN1CAwCgOUafPbXHeCttQ5Am1Fawl2MokwzzfdaKlFBC+cryHw6HYhYNFic10xwV2fHDw/HXli32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DV+qhtQY; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e6089a1d39so1043081b6e.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729866597; x=1730471397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hgsH8M46R374DX96A094+C1Sk2ZSQRIVp+udp7ZiHw=;
        b=DV+qhtQYObO3aA6Enr6n4R6mT6QUE2TIrIdD+JlUvYjSiZNBqbgTsxHxL6wFaf9PCL
         t21vG9k0tNN/Ux9Dk96sI73ZZh+yVewDAevHGma3vUPIrFzRw5rKS3WfE2+BxNvKA5c4
         RxN1/ePEInOzgovwwGqPhG70QzCv/guqhTAag1GL4vRROMKs5uDbqx6k0MKmI+pm6dT3
         Wg/Z09WKup/ySfpYYjNChOstmjueK/KD91ZtxfKn6ZLX1epf+PBpGb+hnRIMSq1Vn2bq
         lDdxZd0pOw1wu7YtcekMP61cx5Hadrm8LiOn5NZyVr/Co7zKJXVg39uYZWzPfua15Eyd
         7NxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866597; x=1730471397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hgsH8M46R374DX96A094+C1Sk2ZSQRIVp+udp7ZiHw=;
        b=L+sBM5n19BgPivSxAU5I8ZCQ7K43GexvLJ+deqCDgccdCoTUXwPRehUwQQmWXtG+FZ
         WaijEQoYpBqfGYIud/xFzcUZq4xRrJ/1Nk8bY0E7NK20qsoYaGzz4J7ZF8KbFOziDhDH
         Xzh2Jvwits5dqUFl8pi78RzS8kdhWJDRbX/B/zaOHIzzXA0BMcaHYVzbassAARpcqHZ3
         Vo7WTAOmGTELGv5o2YUyz94k0APUvpXnsPMmqjq/hFXr8AdptEAnwHpZkmmOQLCBLcLQ
         725PfzIPdKklL022AwdQwu6+sZUSYBhfB41SZvj0QsbknYfiPd5CO6Hf/HrybmrIhqO6
         DlAA==
X-Forwarded-Encrypted: i=1; AJvYcCUyXQ5WoxQZnNnvIm7gVqwosOrNnM9qLh5+pJpj+FLlriqBqtRgf060wtihqOokAyjtk6idyJugcag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYt3Uw4wkbuyxf1clVqSzrKZGr4K2upFaQoZ2a/E+NeEFfqAI
	Eb5iSw0SLKaj0ed3uS4HnWIyKjXr/Yq4VC4yuDvXMqAkylgq+hfjZl9vFd5uEek=
X-Google-Smtp-Source: AGHT+IE7uXQFXMZnIIYfSrbQaV5eC3DgZSr8FIpbdhTtwMJtNpEwUy+GoBKmo71g+DIf/sQ7MtT9Tw==
X-Received: by 2002:a05:6808:2dc4:b0:3e3:bd1c:d584 with SMTP id 5614622812f47-3e6244e40d3mr10131691b6e.9.1729866597497;
        Fri, 25 Oct 2024 07:29:57 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b0a95sm223353b6e.42.2024.10.25.07.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 07:29:57 -0700 (PDT)
Message-ID: <f3351a7f-318b-42d6-aa1a-e8279eb06b78@baylibre.com>
Date: Fri, 25 Oct 2024 09:29:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <60452f83-28a1-4a80-8e90-1f1ed32a594e@baylibre.com>
 <CY4PR03MB33996900AAB90A050375CBB39B4F2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CY4PR03MB33996900AAB90A050375CBB39B4F2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/24 6:35 AM, Miclaus, Antoniu wrote:
>>
...

>>
>> See the ad7380 driver as an example of how to impelemt this. [2]
>>
>> [2]: https://urldefense.com/v3/__https://lore.kernel.org/linux-
>> iio/20240530-iio-add-support-for-multiple-scan-types-v3-5-
>> cbc4acea2cfa@baylibre.com/__;!!A3Ni8CS0y2Y!4LS7UI11XqIHRgT3ckx76VYn
>> CyeikpTumyjO0qDTn7eF7Fd-
>> jFFL8yqpYcMAxP_u3VC09bfIAB7gW_rvGoM_sEA$
>>
>> Also, I would expect the .sign value to depend on how the
>> input is being used. If it is differential or single-ended
>> bipolar, then it is signed, but if it is signle-ended unipoloar
>> then it is unsiged.
>>
>> Typically, this is coming from the devicetree because it
>> depends on what is wired up to the input.
> 
> This topic is mentioned in the cover letter, maybe not argued enough there.
> Yes, the go-to approach is to specify the unipolar/bipolar configuration in the devicetree.
> But this is a request from the actual users of the driver: to have the softspan fully
> controlled from userspace. That's why the offset and scale implementations were added.
> Both these attributes are influencing the softspan.
> 
>>> +	},								\
>>> +}
>>

The cover letter did not get sent, so we did not see this.

Still, I have doubts about using the offset attribute for
this since a 0 raw value is always 0V for both unipolar
and bipolar cases. There is never an offset to apply to
the raw value.

So I think we will need to find a different way to control
this other than the offset attribute.

