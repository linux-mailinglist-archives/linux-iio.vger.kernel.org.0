Return-Path: <linux-iio+bounces-7761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485B938272
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 20:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B11C20D3A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A81487F6;
	Sat, 20 Jul 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbRXU4pG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B603D66;
	Sat, 20 Jul 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721499954; cv=none; b=RZehSLVEuWHo3G3DsccOo32MJBUB0Hu+4UUJt0lUPYQZV7ecbMinIBgNwV+dkgBYjCVpUlA48iB4ELCNiVNTo1nJJPZgYmRT62JIylS42eojzAgwo6UZVCmSFx6qQ1rorI+5xsO63LjR0xBN2D/DrB3qQsYqtAbYmc+YSjECVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721499954; c=relaxed/simple;
	bh=KJely22M3+yhnTl+J3dbH7rrQjHjW5E+nuepeaYqEyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buMle9b/a4yZArmk8bQVG+29A+pz58lmU7GdqvOlhm1cYWtPKCZEWBWj2xhsegQo6UOZlRThAe8qfGgJCbFXmKu7kdY7BKetaGPprtLaevtRnbpWvW/NrdYqEi/Vy9TPrE7NzfA9CyY1RHWjtdQYUmKE3orsq6SgjFLAO4FMGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbRXU4pG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42797bcfc77so21351555e9.2;
        Sat, 20 Jul 2024 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721499950; x=1722104750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f03t7wsKPSqK/MS13yIPFYXCUZggIVALlDvFU0rOu/I=;
        b=BbRXU4pGDYv6PwXrCk8PefNrAFb2yM04jsCDyIC7Jj1mXgOxZbkkKm6hxLYvbK9Hi2
         yC7aAr5kvMXDPYHtRd5rlUNvMOy4A7SniGbMpQ3dF3BK9SzZo766Uo1zZ6lfVWsbmmVd
         GdK0S5dpWeZQ0NWKmH8sESl7s9T+Mjp9ehzyVz5r2RexIBOGpW52rzzHsESiXiLJh4ln
         yG+U1/p2Sdl7h28Emf0z6wqWkLokGpWOunETJdbSKgcxYoNnhaSsnuH0DhGXU0iZZHRl
         v9HeZ24ZZpjBYD/GUIyO0pQtz15LVgN4zTknptDgGgwKQAKBGANFfd3eUp5w7xNv0Vwt
         OMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721499950; x=1722104750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f03t7wsKPSqK/MS13yIPFYXCUZggIVALlDvFU0rOu/I=;
        b=dcMt0kZJk3YtBmFAh0cAVI3FbR0YClTY/Gm1rBm4AEyscjUNh5tgZNP0u6G0ZS4Tvk
         H2AyajmtdiCl7KrIh6N3UmcuioI5X2SWXrZZyCOxC2X7v9kvZP/lxKRmto7eWKF8LZyY
         7kieVFLVshwrXzFxlgAhWEYTszlmnp+nYIa3xe/w2LQz1grKGeyixzzpx58t26hZl1CC
         7nWoeMLzAjhW48U2dsRfyiejSAhhYOLyF5YNLz+w/tVQd+rWoLyie41BJwO21yK7ujEv
         GKmEGy9MdBIrzkaCP1xBIQNtH4LPGF8J4x0KC5MSFd0kXobeo6gmPfDRBWjjUmwdhHpO
         KfWw==
X-Forwarded-Encrypted: i=1; AJvYcCUS0VtU+pmlSSVSu6IhoKxZJMNIndAYPxC9I5bRXgmbZCHBjdpDtqoAjVt4aRWd9C3OKJQP/9zx8nPsKdTPBr9ozsJ0mGAR6uuLFx8S/rxLD68/NHyXmNQaacxQLDhQpDxA7iRBear6islCZDnliSgvHjay9syWVlFN/RyUyzjbMfOjtg==
X-Gm-Message-State: AOJu0YxpNeBF1bqV2v1CFZmx90gSFxtr4Yx4qup8v52uBqbmjqRKbLi4
	vFFm+curLFZXTwRUfhRKoTmiqCVcJrH1yQ8uBQrg1YQhrjgT75nE
X-Google-Smtp-Source: AGHT+IEL8ncL5XoCPeag9TOnMDBkI9c8ZbRRbLnvvwQ4OiOqLhdvXNRVh1Ybr71HWQUWmeLVDPgplw==
X-Received: by 2002:a05:600c:4f45:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-427dc529c91mr12887065e9.17.1721499949997;
        Sat, 20 Jul 2024 11:25:49 -0700 (PDT)
Received: from ?IPV6:2a10:d582:37c5:0:b6a4:402e:7bc0:d8af? ([2a10:d582:37c5:0:b6a4:402e:7bc0:d8af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e42bsm93749375e9.30.2024.07.20.11.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jul 2024 11:25:49 -0700 (PDT)
Message-ID: <28b3a7e1-5242-4c73-9033-d69582eee73a@gmail.com>
Date: Sat, 20 Jul 2024 19:25:48 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: light: ROHM BH1745 colour sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, linux-kernel@vger.kernel.org, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Ivan Orlov <ivan.orlov0322@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240718220208.331942-1-muditsharma.info@gmail.com>
 <20240718220208.331942-2-muditsharma.info@gmail.com>
 <20240720172936.3a406f0c@jic23-huawei>
Content-Language: en-US
From: Mudit Sharma <muditsharma.info@gmail.com>
In-Reply-To: <20240720172936.3a406f0c@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/07/2024 17:29, Jonathan Cameron wrote:
> On Thu, 18 Jul 2024 23:02:06 +0100
> Mudit Sharma <muditsharma.info@gmail.com> wrote:
> 
>> Add support for BH1745, which is an I2C colour sensor with red, green,
>> blue and clear channels. It has a programmable active low interrupt
>> pin. Interrupt occurs when the signal from the selected interrupt
>> source channel crosses set interrupt threshold high or low level.
>>
>> Interrupt source for the device can be configured by enabling the
>> corresponding event. Interrupt latch is always enabled when setting
>> up interrupt.
>>
>> Add myself as the maintainer for this driver in MAINTAINERS.
>>
>> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
>> Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> Hi Mudit.
> 
> Rather than go around again, I've applied a few things I noticed
> and changes Javier suggests whilst picking this up.

Hi Jonathan,

Thank you for reviewing and applying the changes.
> 
> I also tweaked a few long lines.
> 
> Anyhow, applied to the testing branch of iio.git which will be rebased
> on rc1 once available and pushed out as togreg for linux-next to
> pick up.
> 
> Thanks,
> 
> Jonathan
> 
> 
>> +
>> +	i2c_set_clientdata(client, indio_dev);
> Trivial, but is this ever used?  I couldn't figure out where it if is.
> So I've dropped it. Shout if it needs to be here.
> 
This isn't used and can be dropped.

Thank you.

Best regards,
Mudit Sharma

