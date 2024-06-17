Return-Path: <linux-iio+bounces-6332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A2690A4FD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 08:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9209A2898DD
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 06:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABB419642D;
	Mon, 17 Jun 2024 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldz+Km8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B19195FED;
	Mon, 17 Jun 2024 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604450; cv=none; b=FFTzN8vUBPpwjiHM2ShsmrvJ18kstKU7zpEOAQjFUZfEVGkpj7DTk069uBlUbD/LDyZarH3lHN9A4c9Z/7nIGhX42mSSs6qZM6V5U/T5gLZ0SRbV40QMNHJJENZiBTetr+fhQqcZHZUGAep8ZcvLDkLy2E7i2WJDg+3j64lYCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604450; c=relaxed/simple;
	bh=1qHT3ndHCQslu0fWxXaSamlwmG6qZY213KP8J4wc6mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XggaUux1SF859yT1Prgi4TdLbKarH6Gs7I2qDJjA4c2hdOkFSmAZk8C412eMbWBbmEgtyHKeraJ1tWkykC8Xd7/SGKGCeXOvbQe6UfRHFrK+D82dQi+/c+6Z3xc+tqHRfwtPdCjWb412/vgHThvC2Vx8m7b5JMJqL9qO/WQXwgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldz+Km8V; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5295e488248so4483564e87.2;
        Sun, 16 Jun 2024 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718604446; x=1719209246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i12zWNu8KlTv7/MNDqzK9U/bdW2I5k7ofAlbTITEnb0=;
        b=ldz+Km8VUda6LpFv41zY1+XgaacKyb8R3YlLP9+7T0y93d9+wBAHpvOE5DaI2te/FL
         zu7m239b3fw6bJOde5QZSNGmAzu33phKWYjVSW21HMuUdTvxjyMcR1IEo3LUjzbyua63
         uGwYqolvEho/oC9SJjiIy9JKrZ9n+KVZmFSVPiucWhPiOWogmssZWEIXzCHwy7CYaziH
         AzUP6RbdDaAOkkXQ9Nj8GwD5Iwp4ZCEpTec+cFmFtOAqYlg9yyybPVMlZc45+VXHgXgi
         XoF9q7tlKiAy0+G0+xGqUq8HCuPG6BJtpsxNuqaRIuUHGp3nZAn08aZWQv7GHvP5+nzz
         Drzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718604446; x=1719209246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i12zWNu8KlTv7/MNDqzK9U/bdW2I5k7ofAlbTITEnb0=;
        b=vTpsULKvszpd2lwdT3j3Msh3ZpRqfp4Mr/6KL4pXS+oqBkJW5/h4o77ze+KRlH95wS
         qUZp3jz2dLc9PWZfRW6ovK7iZ45Gp/CsxA6/P9LgbjovDROM1RLSb3uiUZTkku64W45V
         1gltiiyhZe1gSpNhcW/hgznQVCc50WOEXHAlcvvNaOzWM37a4CUnRq/zuAqfZzCX6ss2
         TH+b+bXf6tw8ucgRgrxUft84UG7SxMwEnLiC1bKa3GxRckKL9gMCuaCVK+/qPDKGl4Ww
         wXlXWJFuHd4sH+JdxeOpC9JRyMn2nPhb3nTyHuAbRpHJR8/6AVE79bDPa5KKRp4PR2+e
         Ti6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFnbfIgm9sjPlX14PZpdQekdaiK78Clf2hHPLW/dI9bneMEH04oROBrL4NaemQMa77v39EW5dXtoSo+eQWpdBB8wWnnSIjo+o6a3lZijN5XXqCHPNEGDvtujfFERLMJ8UvzjkCdIGB
X-Gm-Message-State: AOJu0YxO2JKy9Uj5KJH7i+am4/JVLS4siuqFWCk8jmOQO5IYNCVv0gl8
	kAuBXPtSVXvMPakKSk02wP/u49jZ/g7vXlXSzPH0lQhZV7uBaydN
X-Google-Smtp-Source: AGHT+IFOs8sWJOZ1Qx42nJmWJ/bSgd388ge+CDgPhz1DhWOXNvINt96KcZ4XUPBXgcEW8rI8sBWsCQ==
X-Received: by 2002:a2e:9b54:0:b0:2eb:dc13:2d6b with SMTP id 38308e7fff4ca-2ec0e5c57a5mr55168201fa.13.1718604445880;
        Sun, 16 Jun 2024 23:07:25 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c17b0csm12351541fa.65.2024.06.16.23.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 23:07:25 -0700 (PDT)
Message-ID: <b462fbc5-0ee0-4bd4-b889-01c09853c407@gmail.com>
Date: Mon, 17 Jun 2024 09:07:24 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bu27034: ROHM BU27034NUC to BU27034ANUC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1718013518.git.mazziesaccount@gmail.com>
 <d43500621a2ad0811f58c8c7c87cbdc7b2abb8c1.1718013518.git.mazziesaccount@gmail.com>
 <20240615184757.2148f7d7@jic23-huawei>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240615184757.2148f7d7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/24 20:47, Jonathan Cameron wrote:
> On Mon, 10 Jun 2024 13:01:23 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
>> sensor. Use the BU27034NUC driver to support the new BU27034ANUC.
>>
>> According to ROHM, the BU27034NUC was never mass-produced. Hence dropping
>> the BU27034NUC support and using this driver to support BU27034ANUC
>> should not be a problem to users.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
> 
> This is an odd case.  I don't think a fixes tag is appropriate

Last week I was thinking this purely from a new BU27034ANUC user's point 
of view. For user of the new sensor it appears the current driver is 
broken. Hence this felt like a fix. That was last week though...

  and I
> don't think we can use the original compatible.

I didn't think so either back in March. However, I forgot what so ever 
plans I had while I was waiting for some internal decision regarding 
upstreaming of this... I just went back to the mail I sent about this in 
March, and I see we discussed adding new compatible back then, and I 
also promised to send this patch as a series of smaller changes... Sorry!

>  I don't mind breaking
> support for the non existent port going forwards and indeed dropping
> all indication it ever existed, but the old kernel's are out there and
> even getting this into stable is far from a guarantee there won't be
> a kernel run on a board that has this compatible but has the old
> driver.

I agree it's not a guarantee, but it would be the best we can do. At 
least some stable users would upgrade - have upgraded - could pick 
stable with fixed driver.

>  It's also too big really to be stable material.

I am not really going to argue on that. Asking for the stable 
maintainers to look at this and port it is indeed a bit too much. I 
guess we just need to live with having the b0rked version out there.

> So I think the path forwards is a new compatible and drop the old
> one from the dt bindings and driver.  Thus any new dts for a board
> that actually has this device will use the new compatible and avoid
> any risk of encountering the old driver.

Yes. This should be the way forward.

> Maybe we can be more relaxed - what actually happens if you use the
> existing driver with the new part?

I am pretty sure the world does not explode. I've not tried this so I am 
not sure if reading the register area where the removed data channel 
used to be is succeeding. My assumption is it does, but just returns 
garbage. Furthermore, I am not sure what happens if those removed gains 
are tried to be set.

So, not tried but I would guess that the read data would just be insane.

> I'm trusting you copied the maths right for the computed
> channels (that take too long to review!)

I understand the reviewing problem. I feel it is time consuming and 
sometimes very much energy draining. :) And I _really_ appreciate the 
work you do with reviewing and maintaining! But trusting me? I suppose 
we all make mistakes XD

>  So everything inline is
> formatting type stuff.

Thanks! I will fix the compatible and formatting. I agree with all of 
the comments - but it may take a while until I send the next version. 
I'm having a vacation and trying to spend my time AFK for next couple of 
weeks. My old motorbike and tiny boat are calling for me - so amount of 
code I write is (probably) inversely proportional to the amount of 
sunshine in Finland ;)

>>   	/*
>>   	 * The BU27034 DATA0 and DATA1 channels are both on the visible light
>>   	 * area (mostly). The data0 sensitivity peaks at 500nm, DATA1 at 600nm.
>> -	 * These wave lengths are pretty much on the border of colours making
>> -	 * these a poor candidates for R/G/B standardization. Hence they're both
>> -	 * marked as clear channels
>> +	 * These wave lengths are cyan(ish) and orange(ish), making these
>> +	 * sub-optiomal candidates for R/G/B standardization. Hence they're
>> +	 * both marked as clear channels.
> 
> I think just indexing them and not giving a modifier is probably better than
> claiming they are clear.  Leave it more vague basically.

Agree. I just didn't see leaving out the modifier as an option.

>>   	 */
>> -	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
>> -	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),
>> -	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
>> +	BU27034_CHAN_DATA(DATA0),
>> +	BU27034_CHAN_DATA(DATA1),
>>   	IIO_CHAN_SOFT_TIMESTAMP(4),
>>   };
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


