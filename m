Return-Path: <linux-iio+bounces-21924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B345B0F821
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE193A6A0B
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3B1F9406;
	Wed, 23 Jul 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idHk2KEl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FD1F5617;
	Wed, 23 Jul 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288207; cv=none; b=cJ6Ds/s2JM466osNcNoTSGrXRTtY/cceec47pDFioZhDpZ7rAiJ2QgUeneIL6WuOPF0u62UUBjE+2DQga24X7C7H//EMNFNWipvcAL3/k/pv02ZKtBNENn/TWkHh8JwmKctdTfjFtBwXx0un5jQEIaCawnNv4iTk82HGTSwaFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288207; c=relaxed/simple;
	bh=XRzabo+DQu+h1F9L/ij9Knih9rrXww9H/tsvoJcdIO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruM9t7e5Ay7OdZNAyDT4XsIHkS0JHHcala+ipT+h4uu3RSf7LuCcGoG5l06ty66t8mygPT4G+SfBw+vhNz/6zAJ8/S/L9uT+hYo+FDj9LHnvVF/UdtWRjeCAOgvKlbIXCo4N3FTIdCdcevMLbgTIderwJPrm+P3buBu7IHhqpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idHk2KEl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso117686a12.2;
        Wed, 23 Jul 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753288204; x=1753893004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oLVQ+wEF7L0i9K+mBIHWmF3qtu8o6QfrkYubSnBjN0=;
        b=idHk2KElHuGiaT65Uxir7hVuA/aTE8ftiOiOIe/53wKIEv2jMlDBGlKTeH9ryL5XyR
         hqjpB4rnF6/Z4tvPdFutc+OulGMhYLSJ5pSjv1eeKRjPXz2/CnMlIR8gTDVcQyFjDZ7F
         o9C9K7MpXIYHxQjWTqMsNYlYhU503CTYR+2wPWXfYzDZohQx4A/8BrWfMw5EfWvMpfLt
         VrRkEkLNbERVak55aYraor0bkMd41Ri7yPa1b0SkUuIppb3JB93JpfS8QsWq/8I80yX0
         tvK84EIiVQVMbtJ7XEFi10yK4RegrHG0uMe3LYdn/yr3Y/9zQmrBXXOI1EBzGr6bL2YF
         05VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288204; x=1753893004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oLVQ+wEF7L0i9K+mBIHWmF3qtu8o6QfrkYubSnBjN0=;
        b=AKRP+gEl9R8c5vf0GuKYB5NFFwyBVns1O0yBCUaNhWp9v/ilteTQKmoVkIB1yO7me1
         opbNdZ/FzsX3Tw5vKUJQM7EHdEI8lHlqX4lqUPXMJfSwzojuZWBtcoBj76ADhhkF622a
         RuQBEGMUUSPhyT0fEBsT/5x73USIouhOHJZEFraTuG976r5wPlKWx9QB03oZORIi/0qV
         DnVkG6QKB6addKXFn5JicufW4ENDmlZ3WaL42KNKXegAS7xFKrr7Q2wJojLIfcLK+lrL
         cwRqZ5eXTqCq0uKjYo7x8higU45hQOZQ/6OYZyWYl+L8D1WT2CKZd5yf5P8yFRsa6WA9
         /18Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTdVbVlBz7cp9JXAs0vs571sIr7Wp0KLMsj83DW0GiWQyK49qLhvExEBZZiylOVgY7Qlh3d2Ys@vger.kernel.org, AJvYcCWETsKtvOiSn20V6YthZR2Kbp02Pe62/9VuFDDab7nSvzcwdDs6sPkjUAXMn4Zxy2295aNscer9e7u2@vger.kernel.org, AJvYcCX/SXpu2hhuKxO977HJUK33sQGBJb4yxmQPrRcJlWk0P3OTCJMnaiZc/Rwf3IqyUVUEbNDrs22ieuNZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwkca31ntSGxNcrx3C+65Cx7AsvZWfcC51ORoF18BaPdqzGTt2
	xNj1sT2JL5u/AkICjm6zJY0R/NIiEOgawtv46ZscZilauUrq4Q7G8xC+
X-Gm-Gg: ASbGncsFzTEyH3CZiinn5W7THuWJy0RNaFVlcamJ5IaWYlMZD+VgZQW8lqzy29Dm3gr
	USWJTYHvux2d0PTWK7IdiZuALRTG/QiICZKNSP5Ho53xmLzX3tKW/5D8jK+3v8HirWwUDrtr+oY
	eYWYHz+JewLdYDIPRR8gLzNpCCZpKT6R+02gG6S/BME0osiEc9mQtr9YYt3kfJZR605t0d/glmt
	jGeDYo4nuYmazCtnvlS1gznkMGqZ1E6rzwgIOXAzJw1QXzNYjDuJ8lTjXEzyBcFjKCNEd6sbI3+
	mbwVCdk74OaHBGRwzlhNEchD8zCLsJklRXOmPjHpafe40O/DoQMnxn6mEf9+2AVE1BNjO4efaff
	yJuYbexQ5gBNog1vTGOkr9eiBFMKNLCZAmWyK4lI=
X-Google-Smtp-Source: AGHT+IE8R/cLesETtxNTKi6GADIN03ysXQ0xFDkmBNduvgzLi3IKVKIBX5o6E4+QQ7bIBNKgOSkiiw==
X-Received: by 2002:a17:90b:3f8d:b0:311:e8cc:424c with SMTP id 98e67ed59e1d1-31e507cdcebmr5060289a91.25.1753288204285;
        Wed, 23 Jul 2025 09:30:04 -0700 (PDT)
Received: from [192.168.1.143] ([49.207.192.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519b11d1sm2037415a91.5.2025.07.23.09.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 09:30:03 -0700 (PDT)
Message-ID: <8e5e1d09-0706-42b3-8ae1-00a0e2f5139a@gmail.com>
Date: Wed, 23 Jul 2025 21:59:53 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: cleanup: fix duplicated 'is is' in YAML
 docs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 ribalda@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com
References: <20250722170513.5854-1-sanjaysuthar661996@gmail.com>
 <CAFBinCCmsw=XGPtrk1XbphOu=OwhxmAiZ+2h4x_M-_f64Vo-7A@mail.gmail.com>
Content-Language: en-US
From: Sanjay Suthar <sanjaysuthar661996@gmail.com>
In-Reply-To: <CAFBinCCmsw=XGPtrk1XbphOu=OwhxmAiZ+2h4x_M-_f64Vo-7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/07/25 01:08, Martin Blumenstingl wrote:

> On Tue, Jul 22, 2025 at 7:06 PM Sanjay Suthar
> <sanjaysuthar661996@gmail.com> wrote:
>> Fix minor grammatical issues by removing duplicated "is" in two devicetree
>> binding documents:
>>
>> - net/amlogic,meson-dwmac.yaml
>> - iio/dac/ti,dac7612.yaml
>>
>> Signed-off-by: Sanjay Suthar <sanjaysuthar661996@gmail.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Thank you for spotting and fixing this!
>
> To my knowledge nobody else is currently working on amlogic,meson-dwmac changes.
> Meaning: with an ACK from the netdev or iio maintainers this patch can
> go through any tree (iio, netdev, devicetree).
>
>
> Best regards,
> Martin

Thanks for reviewing the patch. So you mentioned, now the patch can go 
through any of above mentioned tree, Is there any Action item left on my 
end related to this patch? Also will I be notified about when the patch 
will be approved and merged by the respective owner?

Best regards,

Sanjay Suthar


