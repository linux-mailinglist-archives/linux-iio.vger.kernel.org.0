Return-Path: <linux-iio+bounces-24340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DD5B8E784
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 23:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8263A8DE6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Sep 2025 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926923CEF9;
	Sun, 21 Sep 2025 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFj0uXoU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A71514DC
	for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491398; cv=none; b=FNqjck9uBW/wpzoMZWaErpFD9aAtG+7GcD4T9rLfR8nvn6V6zGnxApEdD+NTnVGTAozF7qdIv0vCFI9S5LI8klT0NGNZ4DXK67KGWMpc5RCRF42fFnhTf0bEiIu3FTBuYLAi90mVVOrCYbo1KqWtQ4EyTd8wkVgCIUTBr/XABAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491398; c=relaxed/simple;
	bh=7eKHt9T539lDI5ArlWvRasiyebX1wFKURVFmnD+/P7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=holztyKQRylzEdaKk37SyBA1MFCpbsWkSyM8AQfLcxwZRmI3mzsFu+9Zt/mAo2x/6xwwSQrRBqaPMm4xsg0lkPs5Fo6TG08oacHTbGUdACrVfRUbWT2AugxI/wcG++dq3EJCPUTflm2OZYRuY15Ur9SAFonwHBpJyX9sBlR6V2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFj0uXoU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f0e9bd80fso1637836b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 14:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758491396; x=1759096196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7CnfhF+eighLL2wsAMK46dbIgkAQtWdpB+QZlY15tQ=;
        b=WFj0uXoU1Ly8ZsUgL7osWFU8SZbzdssuFFcgvvDdGSQk54UTK2f0jPpaE1xT815XFK
         gVCotJj9q2idVAfrwLhnvH2lO74UqljVd17ZJ4PhKvQ7gNbJirZa5WRhWBRX50C8ksOd
         z0nE2XhQ9TmGFVrc/IvH0O316Q6+9s24f6ZP/U0HZYkT9wz7QHhi4ivE5PivbIsv4u6X
         FvnOYEYRCs6iCanmC45v020pohx/low8yXdJRRCNgmhJbVzX1fdqYcakn9MVnqWFVSxf
         f6VbCHnLnqz3SOlo0qkGj15YFTB23/l2QvuzINW0i1GcLeEa7mjpCTqBhm6ivCNQ3S6E
         vGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758491396; x=1759096196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7CnfhF+eighLL2wsAMK46dbIgkAQtWdpB+QZlY15tQ=;
        b=k5SDKhiQS4jPhSpdhRJa3tSIEEpRIFz+KTHANmj7t0B1lvTszQvS2kc9nJsudjWAXA
         7HPhs4b7yUuQMS6xaSTSQrYa8sF4HyOShp0Ef7620U7SUCRvNx1kR+iWCwGVy7BwwVwE
         LVQlPc4xsnB8XCQwmAwM740r3a2JnwzlFreIlBtm8+CuZ0RMPDJdoqE3i7IX5N4ghMos
         uLqjFyPVunkiyPRHvkPrnHlLOdJiiDmDcMNFzrl+dhnsDGzrVQejyROw4xCqQZBNnmv2
         xFw8NNLvjYRk/VL0vm3/38519V5/WnQD5tEqVXxfLc1+8ohBzGhhsxA4EgtdhZMxw8EL
         fXiA==
X-Forwarded-Encrypted: i=1; AJvYcCVL8ZGRhqw1zlvrhwxDvpSpBPq+7cXpxyR1w4gLmI7BJaE3yMnFKok/4DSaAxuyJfOwZC/pxLChSIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrf3cuCJVV+wCdX9+uVqMyEL2P7eL3mh4eE+IS3BLr9x0RnmBB
	y2VNIwBqCfxoG41vf7npGGqyDpGG7V+8mZPgSRYsrZzev1/k0TVXkZEm
X-Gm-Gg: ASbGnctD7hgFQJQGJq/v1IL48QJtO4BR3MJvXPlqD2HRzwJR0cfWvihUHGx/ivbw8Om
	LzLOYFKosv+04NtN6fuQGAYKiywpwesGOkO+3140KSwuggnywOLzge/bPvCn3ZHM+/M9emeYNof
	ef19DRD3+S+SeDHFdHAuLWwaUUilT/DmdWzBbDdS9zWYFJik/o2HOD0IGO64yHHxyUci+qHJQ64
	u6uo5Ay4n5ZCgLRa3bvAFTifvuJZAKnFTba1zHTDZR1LlGBtOw4GqPUNp2rYZ07aALYo/DfVCQ5
	iZwKj+urQ39ZqRmD8LbR63LDIcAiGz6b3x6b6UldZ0imm4QzKYM0luSWVgkLUe14vktPO3/adPw
	qc+KBk7w1VeE702IQi3JgdguqkAK6rcOTxMZxj6h3TvSw50cAaMHy9sBW0/DfAjy8f+0LphwSkH
	sw9A==
X-Google-Smtp-Source: AGHT+IG3wff7D7xM/5mRWEzYjv8dMgdQPM8uIz6SaqKo3zf8tbMMGoaP9wBn1TY2YikTYlId+/Z0hA==
X-Received: by 2002:a05:6a21:6d9e:b0:263:5c8b:572d with SMTP id adf61e73a8af0-2926f4b4b7dmr13145041637.30.1758491395785;
        Sun, 21 Sep 2025 14:49:55 -0700 (PDT)
Received: from ?IPV6:2804:7f5:b08b:e4a8:7b4f:b63f:f2d1:1393? ([2804:7f5:b08b:e4a8:7b4f:b63f:f2d1:1393])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55186b8498sm7393808a12.12.2025.09.21.14.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 14:49:55 -0700 (PDT)
Message-ID: <18aec78d-7664-4555-a318-fe945dd84780@gmail.com>
Date: Sun, 21 Sep 2025 18:49:46 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] dt-bindings: iio: adc: add max14001
To: Conor Dooley <conor@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Kim Seer Paller <kimseer.paller@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1757971454.git.marilene.agarcia@gmail.com>
 <30f33a64da0339eccc1474406afb2b1d02a0cd6b.1757971454.git.marilene.agarcia@gmail.com>
 <8e88b601-1329-4cdb-bbd7-feb998c552e8@baylibre.com>
 <20250916-alto-vaseline-f8dafbab03e9@spud>
 <aM8gVOVEujP6Yzxx@debian-BULLSEYE-live-builder-AMD64>
 <20250921-paralegal-styling-17b66d975dcf@spud>
Content-Language: en-US
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
In-Reply-To: <20250921-paralegal-styling-17b66d975dcf@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2025 18:22, Conor Dooley wrote:
> On Sat, Sep 20, 2025 at 06:44:52PM -0300, Marcelo Schmitt wrote:
>> ...
>>>
>>>>> +  interrupts:
>>>>> +    minItems: 1
>>>>> +    items:
>>>>> +      - description: |
>>>>> +          Asserts high when ADC readings exceed the upper threshold and low
>>>>> +          when below the lower threshold. Must be connected to the COUT pin.
>>>>> +      - description: |
>>>>> +          Alert output that asserts low during a number of different error
>>>>> +          conditions. The interrupt source must be attached to FAULT pin.
>>>
>>> These descriptions read wrong to me. They __are__ the COUT and FAULT
>>> pins, given what David responded to above, not something that can be
>>> connected to these pins (if they were, they would be represented as
>>> -gpios rather than interrupts most likely). Unless you mean that these
>>> pins can have some other use and are only available on the COUT/FAULT
>>> pins when some register value is set - but even in that case saying
>>> "must be" doesn't fit since the interrupt property could be used to
>>> configure the device accordingly.
>>
>> COUT and FAULT are just two pins on the ADC chip that can be used to generate
>> interrupts. Would a description like the one below sound better?
>>
>>    interrupts:
>>      minItems: 1
>>      items:
>>        - description: |
>>            cout: Comparator output signal that asserts high when ADC readings
>>            exceed the upper threshold and low when readings fall below the lower
>>            threshold.
> 
> I think you should mention the pin name here, like you did below.
> "asserts high on the COUT pin" or w/e.
> 
>>        - description: |
>>            fault: When fault reporting is enabled, the FAULT pin is asserted low
>>            whenever one of the monitored fault conditions occurs.
>>
>> Best regards,
>> Marcelo
Ok, I will change that for v12. Thanks.

Best Regards,
Marilene

