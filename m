Return-Path: <linux-iio+bounces-12621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A29D8280
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 10:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B043161DEA
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F801990DB;
	Mon, 25 Nov 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVD1zrZG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4687198A25;
	Mon, 25 Nov 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527284; cv=none; b=a4HqiAn5hbQ3ZTEq0SHxutleM+Sx0N9Sf5aEFqb70Exbuxp0grW0akjjHnsyFdEtn+cY166I95hLZwUmZgg7s8lQqX5xBGtLaKGRQQlI105vJ+eslXd0PAfp6Vm/H2DWJr5s/KZyu2cEP9kbtaTmrBFnZg+wC+uYxEg9H9reDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527284; c=relaxed/simple;
	bh=aEd8JicAIhvbCPxzPqoHzg82D93ao+tgZQjfIKhBIxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjHTXI/Sa5zvyCvSIIeCdG06Pqshv/WS6azpmlZ6vLhuYc4QHA+c1/IE+c8Y9MkTTuWXkGtrjd8wFSzwEpgTrc1ZNs1zuEveJkq4tJw87Mp7EQdMX7FKPtY+EhUYomaXE4PrWc7Mlurw4LK0LSeHDEtKZ8CH6JGKMDcpZB2cUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVD1zrZG; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53dd9e853ccso2188163e87.1;
        Mon, 25 Nov 2024 01:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732527281; x=1733132081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9wuvld3OUKP0Z53IhY2KuPlXHoSpFVfKj48/VMdmqw=;
        b=DVD1zrZGpRln2BD90M4ZhzMvcKz0Sm0S1KDSkbxIxDXUQhyzBa/mX/vqcFeXEXrPeK
         khXRc1xmV23NXtYsRtNpFY/hZX8sHvqT2kci3g5jGnynGWGF+Xijubt3zSNimqpegKmo
         fple0XxMuFR7TQP4eNsqhSIDLYb3ByDLkVVXiwBaucevf1wE0RAJmplpjxEkQ3quV9Cn
         7wnZEqnQcVhvGSwBsJb07ILR1o5hDH8TMWfShl1VazQ1lGDAJfivrqBGv8X7hO5tOF9Z
         QjPHituBsouzrVH+hCRGct4ph5vt/QT203z7mHjMbQEHaInMr/tE4Rn51zbUx8fXXA+G
         E/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527281; x=1733132081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9wuvld3OUKP0Z53IhY2KuPlXHoSpFVfKj48/VMdmqw=;
        b=PlHHf0GCdilAzNsKEwklL+W/0Qs6GbfjH0fnLjO+XU+8qTr+tiEfE7VfIgx8o0PZGk
         qGZrzHpPjHxWOgJBaiSK2qgc8PnDWlR9g9eLP2Mdw49zYmFNxzNlqofsYWKgi9nQE7rn
         KdDVWkt8pBQXfLPNKwXbF7ivwu+oWi12iCs6TfocVk6widf9sw0uglnx06RyZHO43bH0
         EjiabUOMvUT6KEO5JYWDLhFhuDGkaduLoUWOvwImhe2tuwueLQsTjVPb3ShAUuVisaSS
         rXkqz9w+etsA1/J92s1Y2oY67cNHXp1xytOy8Scza6Dm6ACDXR4oZ2Y+gFDRrbQ9GQQQ
         aZXw==
X-Forwarded-Encrypted: i=1; AJvYcCV+tZIHLqcY2o6GIacCwpBNZrTVA1lL+g/6AJIKYsgyKMM+6+1TI8EN6ROdJg3fQkmLdDgDa9+5wAcJoJ9D@vger.kernel.org, AJvYcCWhAc2MRBOma4yZi2Od/yQ4hecC/M2v+Rg1p7nFtb4DYE+lVTYadT/EkTcIx58Hp1qn4RayRXTZ6aTB@vger.kernel.org, AJvYcCXkzKCJSobccBFROeEulLEUoE5rMVFwB4HKdFZCYoRh91xN3j8Woh2fEtXI/UDsXF3uDHzOHK9+DS8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwWlw9uOnpgaUfROdm0mwDCUYZHCubOFgYxuxUjiLnipSEzil5w
	4XIZgz2S2c1A7gvF6ZaM5PBGvEggKojG2dQqCoak2o5cQl1UYudI
X-Gm-Gg: ASbGncuThXzJdqZRxfhXAVzHag20FlZ47iR5IP/QI5LUdASgKocznWXkDMi/MFd15az
	b4kHJovXoJPsTOmYjw4ij5ux1WlFa5moHnU5OJsSvB7RPPIzzrRJ3j6+NpD5hatK8VXTaotW/o3
	Nz38LvvbkRbHQTqDOJb7t2GHuGdHTe1EwKvIXWB9nAamKWS6GsJzyNOeiEVKF6oqosEY2g4ZzPQ
	eZaP35oBZ2nH6vSRP/MVVhDA+zMpPlzdco65LT2qWrZKu9lSlZ7AR6VjTwCRS0=
X-Google-Smtp-Source: AGHT+IH2bSfrof1H1g/If9fx94RrbmySHIGMr5WYjh6HzkcR7IBfZjdkbF15PwCGVeWGPT9q5mdpMw==
X-Received: by 2002:ac2:5688:0:b0:536:741a:6bad with SMTP id 2adb3069b0e04-53dd35a4cc1mr5876768e87.12.1732527280572;
        Mon, 25 Nov 2024 01:34:40 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ddab93a2esm1218463e87.257.2024.11.25.01.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:34:38 -0800 (PST)
Message-ID: <bda7eaff-1315-46d0-83b4-a14060c2af1c@gmail.com>
Date: Mon, 25 Nov 2024 11:34:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iio: accel: kx022a: Use cleanup.h helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732105157.git.mazziesaccount@gmail.com>
 <037985fe50fe79c79b9df95fa7b4e577378f9a60.1732105157.git.mazziesaccount@gmail.com>
 <20241123164223.25656985@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241123164223.25656985@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jonathan,

Thanks again!

On 23/11/2024 18:42, Jonathan Cameron wrote:
> On Thu, 21 Nov 2024 10:20:23 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> A few functions in KX022A need to use mutex for protecting the
>> enabling/disabling of the measurement while configurations are being
>> made. Some of the functions can be slightly simplified by using the
>> __cleanup based scoped mutexes, which allows dropping the goto based
>> unlocking at error path.
>>
>> Simplify error paths using guard(mutex).
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Now we have guard(), the main reason (I think) for the
> combined on + lock and off + unlock paths is gone. So can
> we just flatten those and do the locking at caller.

I did consider this too :)

Why I decided to keep it as it is, (even though we need the extra 
mutex_unlock() at certain error path) is because I kind of like the 
lock+off and unlock+on functions. This locking does not protect data, 
but really a sequence of operations that needs to be done while sensor 
is OFF state. It's almost like a doc saying that "please, ensure the 
sensor is OFF for the following operations" :)

(Another thing is that we do claim the direct mode in write_raw, and 
goto is still handy for releasing it. Scoped guards won't play nicely 
with goto. Yes, we could probably use the __cleanup for direct mode, but 
I still like the lock+off, unlock+on for the reason above)

Yours,
	-- Matti

