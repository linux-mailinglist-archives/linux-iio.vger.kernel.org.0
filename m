Return-Path: <linux-iio+bounces-17168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2612A6BA8A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 13:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2CB4A2744
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9D223321;
	Fri, 21 Mar 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVlivOTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029771EA7D3;
	Fri, 21 Mar 2025 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559443; cv=none; b=E/nXcb7jmEoMFkKNg/HYoJrdHFF1+m2ZI26m8QeixN62/C9xpBpYEbgzMFV+3Y+FThoo+j2Vcju5qAx2C0sU3W4/4pkhALT0l+F7ZaaJ8vSPkJwR3/PxVAWnBzFAJYFcVa4sG4oVsCu7jqxGoQQq9u9/PXc8Ur5UwzepSdDU4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559443; c=relaxed/simple;
	bh=cIluY58eXJ8/RQXgIUFT3QKic2JAI0P6NMVeViB09Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OuVchqLP7UMYwlKvVv5HRjSFhWVSOdb5YhcSGuPfsbyQREVjShKnnO7q8Oq7P6lnLk+ybHJ+7sQ4+Ky49zCpRH3n41G0hm/jBaNgzRpF9aDhpsVHzP00e4/xd+klENrYbr3xfZPTgw4DXtrC3U5oC1Ce4mPYhHRvSstui5UQvws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVlivOTS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so2109026e87.3;
        Fri, 21 Mar 2025 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742559440; x=1743164240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y++E3QM/+OlZGiMTt82VJKu3ygbbvpQrY9C12dsr9E=;
        b=cVlivOTSEYXMqPK4ZZUD/M+OAsKAeZwFU/VAoj49kJ3GQ3QkB/go60QDkzqfiR8Yap
         U2UeVciK6IZyvcNRF94rtsS+9JSY5mULjAGIcySp6fIbZDyJRS0B/uF5mlbun8IN1n8/
         +x/grRz403NDofhXzOnU7oYQRC9G0un1BCspMWIgVbFx+Pzr260Ulmg+lXCQfOjPhl0i
         vVK2BXfOLVe1nyK0vR+mBozcOLsF3omRdr/IL4zenRRitygMrWAudSncWvZYZvN5rjE7
         1qSBo3ViFOri4gU9J3lXL2yY1NImMRuLK3sqqVsZynYHx4k1QUgcDLgJxCn6CskY7q0x
         B9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559440; x=1743164240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y++E3QM/+OlZGiMTt82VJKu3ygbbvpQrY9C12dsr9E=;
        b=MxY6fc+vo3XLp0Brw3vDUqRR3ZbORJt2JeTsfbZnkBspTm5v+zIQyyiOmLX9nB4Vd4
         9IK/eqXzTorhepU9+Um0tNB9zA1dngk5EsxOmHuxlNCeYHyMhazTjvgaxrrkPwgSdsyG
         6PdDTEAj1JOP/IpWaBkB8tnSODERutAiORmaZv1V3e887RNaohFKTP0J3u9NoJ6kNaMr
         x8cXQ5Lm0NEapACyH7N0IBXCq8wRvgH+89pbM+qtEgdUqZKS1wUpt7+tKDFUQWndwvp/
         0E9UQmBOs0fn9dA9a9jK1ETDtoegaNAyzIgFe1NqMb+jy2TRqyek0gp9E4lnR3uPq4NI
         YZYw==
X-Forwarded-Encrypted: i=1; AJvYcCUaPHUq3/b/ZZBgJJKqjhfzMBKNUY6zXT1A8oANPYt+wheF0vVmPqn9nI2uKr/kHJJDgUecOp5zFDzvn8H0@vger.kernel.org, AJvYcCWW6o7yB2q32nDMiJ+d0Jskk84EhIa1knyISMyvQ/W9rxvqI2HDmjNdWi804JgXpI1uaqZ2QHtbaVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2st40NhFm+tv3lU4yllyfTA27/5ZKRAi46LqdHqin22bxLoO
	Uz/TQKoc/46hQ9uq6N4s/o+tHziAwid5kriWvibyrsDKmcnX7NFf
X-Gm-Gg: ASbGncscnr358WPdgvdr3pOcZn5PLHAV6Gli0exozTea/LUvi7hKUU0B5lvhYSuZUBV
	ylWU6vStDqj0QYEo0N4FYU36yxb45aWDvtP0+sPNya1vHGYYYgfHUrtKc+gljb9rb09p8UMZepR
	MZruDrODfo4Hwag1NJUifo/Sem1M83tZaQTzyXvxIqhSY24m9qL+CG+Qj87ruHqWt8N553hhbwh
	d7NeQWyic+pomvJJLl6Y18HgL7pD2w0/24t9aZomxqTyannr+cyuLVYkCkGJK6CCGtQ9XVYawiT
	xi7gjiCzkV8XM1wOuhAE/+DbLN09iiqfZvSBkEFUrvaBpSu42uUPnwkDzhnJQv3qsC8nWHOfXH2
	I81hPMNzwJPVLiaEBgx8t4qyDcg==
X-Google-Smtp-Source: AGHT+IHqRMaHra6e/jHBBV6BTUpxRHoTVBUxm6beSsZXBMq2Y74+//1Fj66/yf2GvtNr4Sd2fi5EvQ==
X-Received: by 2002:a05:6512:3e2a:b0:546:3052:41f3 with SMTP id 2adb3069b0e04-54ad646cfaamr1336167e87.3.1742559439666;
        Fri, 21 Mar 2025 05:17:19 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad650827bsm166322e87.168.2025.03.21.05.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 05:17:17 -0700 (PDT)
Message-ID: <1e236993-47fc-45e9-913a-e0615787581a@gmail.com>
Date: Fri, 21 Mar 2025 14:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
 <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
 <ae33de64-1ba1-4bd2-a139-3f0b5986f41e@gmail.com>
 <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z91WS-DoKoIZhRNs@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/03/2025 14:06, Andy Shevchenko wrote:
> On Fri, Mar 21, 2025 at 10:01:00AM +0200, Matti Vaittinen wrote:
>> On 20/03/2025 15:16, Andy Shevchenko wrote:
>>> On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
> 
> You can get rid of all of these by simply using __le16. I do not understand why
> it's not used so far. I thought that bits are mirrored, that may explain the
> case, but now I do not see any problem to use __le16 directly.
> 

This discussion is going in circles now. That was discussed in the RFC 
review with Jonathan, which I did also tell to you during the v7 review:

...

 > And how this is different from treating it as __le16? Needs a good 
comment
 > about bit layout.

You don't think:
  >> +struct bd79124_raw {
  >> +	u8 bit0_3; /* Is set in high bits of the byte */
  >> +	u8 bit4_11;
  >> +};
suffices? It's hard for me to think how to explain bit layout more
explicitly.

This was discussed during the RFC review. I explained the rationale why
I rather represent this as two 8 bit variables than le16 with
(mysterious to me) shift. As a result, Jonathan told me he's not feeling
(too) strong about this (but also warned we may see follow-up patches
converting this to le and shift - which, by the way, is harder for me to
understand).

https://lore.kernel.org/all/bb403ddb-5c6f-4286-8d80-3ede40f94dc2@gmail.com/

...

Yours,
	-- Matti

