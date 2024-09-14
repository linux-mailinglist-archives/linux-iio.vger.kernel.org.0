Return-Path: <linux-iio+bounces-9547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A29790BD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CACF1C21B92
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048241CF2A5;
	Sat, 14 Sep 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRP2iosR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F2168DC;
	Sat, 14 Sep 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726315854; cv=none; b=WuDEg3kKMXtPy0V2/lZpOmh/x6/jajdkDm8i8czNkHQN5H9DJNc6pfozMv4TYI5JAvfT7TkdDaoBB6scT7E13z17FfDQVNhjOzu51KgJ4lSM1gb/x7PKubSsT6z4cuiWaHhgJAwanLr2WPgH+FAaPT6qgQVLyw8VRmli0fx38kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726315854; c=relaxed/simple;
	bh=7zfBbPUOwuGq6k4kTCSoj/fUKtI2VqXQUWYglUXnR7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcrzZ5pyoirr4GxebsFp6V0FltE8vUCJeDJsrcJ3UILkBCwVkQzlyBUe/5SDgBtVgcCJHsoPJ/mQRN9gdireuvJJe4OONSMmk4/np8Uj8GvCaNZoIU7lL6NVYv6VxIX1GZfmzlt0NF/dCvH1ElXdLE4bR8lC3q4HBjaEbsIU6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRP2iosR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cd46f3ac9so28836595e9.3;
        Sat, 14 Sep 2024 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726315851; x=1726920651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=atbRt76fSiiFgPJDTOxAbEt766tHZwSxaaq1qvgXc+Q=;
        b=hRP2iosR3KHG5xbXzDKDEp4XlYpmMU2sXC7WQjAlU46QQumgsxRN74MMfB325BfLVu
         IAq5MYKviRWOBS38rmUKF0HZrGz0DMuWTZEL/kcB4dyevDs+yAlpQLojLHy/2zYedsF0
         JnMEKQHRVwOt0x4LgsVBP5+em2sR3ptFpmpV6oRxHTNEZJQDlAuZJe32jPQWeDGfKbNX
         SfwNE4zWsC4cFjf12dXw6pV9kjB5jgYeyz4S2mhaUldE/tiNuisoNcrSLbwIy32V/8b5
         i1UrJW0LLqVV5N+rSDoWn0rQA5iHeF0I5ns9qySVEYbEGWbAVAA10LZmjb3TpKBOWnNo
         vI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726315851; x=1726920651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atbRt76fSiiFgPJDTOxAbEt766tHZwSxaaq1qvgXc+Q=;
        b=lTW5SA73aawz8VehiDyo4+77k8Xjn0sPRuuJ5T3zuEAKWoT1LUeP35RxrIrjBnRugU
         WDZasI5DVveErRopEJdfWqoMb1ed05Gblp2edND6j0j+K6d4jHtqyiOUSLiEk2g8AruY
         r7A1LIeBGLc7b5hOCgx6ZMNh+LDZ0M7wqsUdOZz8lzQdHOXmtkXPDowFetWwwOCIqz/W
         demGJDhOrlYCqCgYczwNIVVl6ASfFRR+0gLlqeHwF96H/XIkLR6EPEWNoIyOpMQGrdgM
         dCPdvWWxegp/Ea06jppPm48V5MqSDcn2fWsfQQUsWv5qzG4Tj6VIciq2oWQLp4jx3WvK
         pk+A==
X-Forwarded-Encrypted: i=1; AJvYcCW3E00/hDvxt+dGON8MbGsxewuMFjx1bG1WHdeCYVTp5PoLpPiRQVp0VLdhUKd2MSDTwbQLV2oLMvQHIRxv@vger.kernel.org, AJvYcCXRyR+P0F7CWbO0DaoH9SG1A+fxhktXtpjGbHuS5jr0PHjxFvN1gxyYIsQAAQWc4CPvnK5rh35oVnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygdT3QbnwBJHscg+UsJrSoFCBsqB3rH23uCRVMDji6bIG5MuAt
	27pSHDo6jdFKCPouYV87g0h9BiuplB+v8M/A4ryNto30tvlDSuMw
X-Google-Smtp-Source: AGHT+IG3rAqojPgtnJ16nBrEI6Ogk8q5nEGvEg9D8GyHkIKGYLzM90U9atZauBTGXL8Co/QHYqSfrA==
X-Received: by 2002:a05:600c:45cf:b0:42c:bad0:6c1c with SMTP id 5b1f17b1804b1-42cdb54e480mr67738655e9.18.1726315851054;
        Sat, 14 Sep 2024 05:10:51 -0700 (PDT)
Received: from [192.168.1.127] ([151.49.241.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da24215d5sm17083815e9.32.2024.09.14.05.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 05:10:50 -0700 (PDT)
Message-ID: <84c6a027-284c-4985-8125-d46a04c4ea5f@gmail.com>
Date: Sat, 14 Sep 2024 14:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: bmi323: fix reversed if statement in
 bmi323_core_runtime_resume()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <273b8f96-0d32-4913-bc6b-e91b391e7d7c@stanley.mountain>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <273b8f96-0d32-4913-bc6b-e91b391e7d7c@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/24 09:54, Dan Carpenter wrote:
> This reversed if statement means that the function just returns success
> without writing to the registers.
> 
> Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index d415b6542089..a56259c6434e 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -2232,7 +2232,7 @@ static int bmi323_core_runtime_resume(struct device *dev)
>  	 * after being reset in the lower power state by runtime-pm.
>  	 */
>  	ret = bmi323_init(data);
> -	if (!ret)
> +	if (ret)
>  		return ret;
>  
>  	/* Register must be cleared before changing an active config */
Hi,

Thanks for spotting this. May I ask to add an error message in that if case that will also print out the ret value?

Thank you very much!

Best regards,
Denis Benato

