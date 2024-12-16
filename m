Return-Path: <linux-iio+bounces-13531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6899F2AFD
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E167163A79
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 07:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF151F707D;
	Mon, 16 Dec 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6yzxI9J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5B1F4E4F
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 07:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734334658; cv=none; b=uo2VuuT9k51IpI2oor51ypRzRTazH/3ph09SlcZXIXyS0ckbSP8OLn/1jQJ2krkZhVJ2Yi+Lyhax81WheQchc5BfjqBpFWtGgrfV7fvA3xdojYv9JKBWa7tBJ8XMmNvzVL0FOU5vmgTJ7ZGF6jSgbNTHAbYABbze1MVxWieU+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734334658; c=relaxed/simple;
	bh=ySbUeHsJajhfRKUiywu1frisiVMGaOT9had59qODIoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUwQZPCiJH9FVYvEaOI211W30r7Dk2aXJlFVXoYMTVXLuacb2DCQgRbvJsmsjUqS5ZNs12JaSawO//pqc29VfEacGCStL9AZqYx9tf9A8tI+V4CRelnWDnCpwuWTtXVRFzToGhuxyuv8zKl/XB6bnS2/caYfQIpZkA/lRgQxpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6yzxI9J; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so4165733e87.3
        for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 23:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734334655; x=1734939455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6+/Apea2I1My/IGdGD1hf5TLqjg2dg0NfZEAgAOVjM=;
        b=j6yzxI9Jk3VlHcopI9/KkT+w+0Z9jXu6mDLNuhoppcN0UmEWvFLFvquehLjQZr05yK
         45hGAMPl8CKd+vHU9ywW6FpvkjyC8DjYtWAacuF2vjcGA3v+/i0ldiD1QBxvv74rae39
         LZ1rm0yAaAKwuAfmPX7CfN0Z70neDqZ+kYbsBhzihJC5IGKvTho3NOXXTsPEpWuQ2BbS
         rBt49LIzbaJ9Hk/k1IO6Zh72pHpVrs444ZGK09H2BExNFsJl7RVJ7YhzXA5dhXTJ9qLU
         6Ai0YiuIVWv2VPtEZiaLffStLzZ95PLchvxjIfrDyzt9o8c/zuidgb8zXAUeOkoda9n2
         3T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734334655; x=1734939455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6+/Apea2I1My/IGdGD1hf5TLqjg2dg0NfZEAgAOVjM=;
        b=UYUY+L5xqc1kwDBAPkkAOShGCnCalr69E63K/UhJ06wiTRqcIHXPVnuEb9LTEVcV8K
         fMsB70ltJaSGkQkCt9XFu89/jS7rBtGOK4d9/2rAp9JfqFJv7id0+WLu/VRwmR5wO6BM
         6Qp4Cw6RlyeRhJaZPh2AwcbGl9Jrn8umwR297t/bmmhcb+MpLoS+fxL8qwhzZWQ8xMtV
         JCR83ssXbVuZduTMrVN7Rc5q9pFlWw/8XPgu1nDlCUySh8tZfp9OjYqzgmyeSgcixmQX
         w8SYl4uONvT/yAStQNdESfY2RAR8HVNQCPwhb2p9EQUZUJQnjxW6hiSJ+pIBBk4XQicl
         +prw==
X-Forwarded-Encrypted: i=1; AJvYcCV1cNFwacZvH1mGdMYuyF29wioh6UtO9UTdy579O/H+f/rsRs3sQH/3ei+g6g3fZW0vQuLfNCDm7wY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xGBAbSqUgGJXl+L4SH3XzWl7Uw/JJ6cRZAXbFFdk0xGa3oeV
	/FPBm5gx/QWN8F2F8RfoMWm8GgqRyZ6AJubq25avcrTdAJCL+k6G
X-Gm-Gg: ASbGncuH0JLK+xr4uvCPP35cidm9QsOCK5XdvvcQsaNbeu5AUMImcm+WWZQGB9kRsLa
	o7iCJ68aEQkJ/PKTYyu5tKd7Y/O5YXUdNlL2aWxYYiw9HeJSUl81jiQrVVaqQXinQHd3XI3apZG
	J+4mo6W5ekr7jmG4khVOJxcQaAk6Ps2MUl3WSRgCzKV2LkeI9LaHIVOy9jLptGFTzkT1wIllsA3
	DdO1RtYjR+ouiAhTXw2ua6nlDXMqeuCjggooE5ZLGblw4SgWtwPiBgs08bhS/JKKe+Pqg==
X-Google-Smtp-Source: AGHT+IFtwWxfflhEogA+CIAav5gB/u+HqGLW+v2wXd1QFOKlLgtsoMru1I/N1rbPEjitZVJ9NBXEhg==
X-Received: by 2002:a05:6512:68c:b0:53e:3a73:d05a with SMTP id 2adb3069b0e04-54099b71a9fmr3343997e87.55.1734334654475;
        Sun, 15 Dec 2024 23:37:34 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c204e0sm741115e87.246.2024.12.15.23.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 23:37:32 -0800 (PST)
Message-ID: <09872de0-d4b8-4f68-bb93-51f5804b14d6@gmail.com>
Date: Mon, 16 Dec 2024 09:37:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/20] iio: light: Use aligned_s64 instead of open coding
 alignment.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-9-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241215182912.481706-9-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2024 20:28, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Use this new type to both slightly simplify the code and avoid
> confusing static analysis tools. Mostly this series is about consistency
> to avoid this code pattern getting copied into more drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/rohm-bu27034.c | 2 +-
>   drivers/iio/light/rpr0521.c      | 2 +-

FWIW:
For these two (although I'm not maintaining the RPR driver)

Acked-By: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

