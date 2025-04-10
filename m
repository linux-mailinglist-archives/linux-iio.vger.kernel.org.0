Return-Path: <linux-iio+bounces-17924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A5A84B38
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 19:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95AC9C2DB8
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281C6256C8A;
	Thu, 10 Apr 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkGIMLbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B225280CFF;
	Thu, 10 Apr 2025 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306671; cv=none; b=WZNnsWMxUikC1WXAe9WowAzfD4ahbOb7z8U4rT/csen2BJxSt2kPmn/4HMpRIoXp3D/DfmZluxJe7Ars/IqJiHuhttZNyFsIEy++goIzTEpFONH8hXmdG4XTbWpLmF74MZ3uEOsxLnFlD4XEF+3gvqhoNSbOVgUsZFAdiVvz36Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306671; c=relaxed/simple;
	bh=hvK+r8u4ehHwBGfvg9hXcYZ9N7mpdlPQnqx70AmnfdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgaBy86+UFDSf/4JisqNE6fp7r540MtbJBX9d2NahY/dPvsfMzyUR6T+ex3/JAbj2yO2p2nAujo/BR4OSES1lcOImUgkMRtImt3vfQmHAdnMBFkGIqckOKx0u/7/IIsUo3Vlz3mlCX8dH8XpIL++75DoOogE77S/fHYzqQqGrt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkGIMLbt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301cda78d48so1047373a91.0;
        Thu, 10 Apr 2025 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306670; x=1744911470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fZUr611D9Y49mKKSbrF8pOMrUq9vV9e68fYVtbb3jk=;
        b=IkGIMLbtpbSc4ssjssXGV+ROGZsegZucjQ//Ly+XahYHLNnqfbBTUXXIx1QKOephJG
         o3roXxxr2B2OgG7L56VkAoPsc26MbCLGCxtWwDNvJjGvTP5vqn6rt9dNy0AxapHnaQvO
         2wOY/LwhUqdS2ueJe95HJlvhOdSWAvmorAtQMR+LZkL30BAmyP2y8pR2WbosUzlSZodw
         1EZHdv2ZLW3XK+naqgvd/eN6m79noq6+873mcmqchCLkoG0FK3dTpr+CxIGqo6AU9JDT
         b+fg9hSNZaQ3bMeU5WtseHD/i3CXb55TcEst4DbMI1qxLGDohwHULsYiKiZvpYhNzEyD
         qP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306670; x=1744911470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fZUr611D9Y49mKKSbrF8pOMrUq9vV9e68fYVtbb3jk=;
        b=KYZfm858V2Cu5Zl5I1kRnBBAtVcHZamoxrPajlMz2MZts4TVYpRSgKazOBe/pJZPkU
         iCp02nXPzZoMA84ECZ56JfDGhlPM7QLNMvv6FrEecfG9LPJI3N187up3mC4vmb2x6RHu
         5UcaAT6HD3D4ab0B5OUdfDL1Xb1e5eoPKfICn9Z6EmnFJ6i9DCIjfxTAEn2iQlGvwyGr
         X2PGbyRdoxnCoEkv5+OV6nnLBxZnwfT654CFkPQb9dlQKOBGMRet5msALhVxzjHJ+w99
         Tzxq/DPlaFAGT4oRqn6Zfa7+N+P/7lvlPXduVM5hk2pJ9Wy7ECmKJ8umQUiz7omYLZWn
         c0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK/bHmwqfTNuUeVsv4koYiVNWi1lK2C2xG07qjEwsuhqK7qPecMzVzt1TyKx+nTAmsVE3EYJATy1MZWoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0Hk3ivW+H9R+Ar7SYSIT7G/NBS6Z4hv0pICSRMDbpmSS3zgQ
	UKA+R9f61x3QZ7sgAw4bl9CSPUuMX15zbbuvLCtUABTZ9IXbM0Yv
X-Gm-Gg: ASbGncsM9+8zGgfOfH18+3bgvdmpMpoLaj/QPUZ7zl0Wy5zbRS21uwaWs4mOBeFylbp
	CgNfUQbjmBD/JMrOzU9kRSExcK65tDdDBhW69Xivv/RRLjDlFqF/rFky6rPuvjK43WuRtY99D6N
	bSHA3GfyF49SHn3yN5IOktrtcZ5Zmd85dhfa1NRFMHTBicOkAlXzfbGNELOBKKCxneQo/7M6c07
	F+DaakWZrgOhpoQwCe3OCRdEjw+1N6w/G5ZVtne1+0M2DFqnM1cTcNGAeixlGw+8hnsoMDrFkTG
	0zWFAU5VEmJrVGNUfcLH4HubKn7jLh/KwN8b0xiFKZHEsSAOefuUYeximpH+DehNimbFINlU/Nj
	6sDahuUj2UmPXhRa+Pfj4Vc+/dqsC
X-Google-Smtp-Source: AGHT+IGv33rsFxoqiNSW8pC79wnDRQXqI712F2DMj6QJ7tSmzJTZYH0sZUwUxDLIHUgjoGZIg55r1g==
X-Received: by 2002:a17:90b:1ccb:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-307e59996bfmr6069146a91.18.1744306669677;
        Thu, 10 Apr 2025 10:37:49 -0700 (PDT)
Received: from ?IPV6:2409:4080:204:a537:70f5:9c3d:61d0:62b9? ([2409:4080:204:a537:70f5:9c3d:61d0:62b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b62973sm33616095ad.24.2025.04.10.10.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 10:37:49 -0700 (PDT)
Message-ID: <b9add3a4-9ec8-489f-9390-29d6ed49ba14@gmail.com>
Date: Thu, 10 Apr 2025 23:07:43 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable
 rate
To: David Lechner <dlechner@baylibre.com>, cosmin.tanislav@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409202945.205088-1-purvayeshi550@gmail.com>
 <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/25 20:21, David Lechner wrote:
> On 4/9/25 3:29 PM, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
>> uninitialized symbol 'rate'.
>>
>> The variable rate was declared but not given any value before being used
>> in a division. If the code reached that point without setting rate, it
>> would cause unpredictable behavior.
>>
>> Declare and initialize 'rate' to zero inside the 'else' block where it is
>> used. This ensures 'rate' is always initialized before being passed to
>> DIV_ROUND_CLOSEST.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   drivers/iio/addac/ad74115.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
>> index a7e480f2472d..26770c68e5fa 100644
>> --- a/drivers/iio/addac/ad74115.c
>> +++ b/drivers/iio/addac/ad74115.c
>> @@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct ad74115_state *st,
>>   			return -ETIMEDOUT;
>>   	} else {
>>   		unsigned int regval, wait_time;
>> -		int rate;
>> +		int rate = 0;
>>   
>>   		ret = ad74115_get_adc_rate(st, channel, &rate);
>>   		if (ret < 0)
> 
> I don't see how rate could be used uninitialized since we are
> returning the error if ad74115_get_adc_rate() fails.
> 
> Also, initializing to 0 would then cause a divide by 0 error
> if that value was actually used later in the code.

Hi,

Thank you for the review and explanation.

Understood — since there's a risk of misuse later (like divide-by-zero), 
it's best to leave it as is.

Best regards,
Purva

> 
> 


