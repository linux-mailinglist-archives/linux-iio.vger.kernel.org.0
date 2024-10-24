Return-Path: <linux-iio+bounces-11166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2959AEFC2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 20:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A91C212AB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1C11FBF4D;
	Thu, 24 Oct 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4GW7oxK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774071D6DA8;
	Thu, 24 Oct 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795204; cv=none; b=WLNHpfhZ6k2LIm7EOqOVKhVsqQJ7x4Lf1Oq8t5nA6Bd6+iB+Lbp/7gVCLZecRJ0+PA0yXX1LK7ZaOBjfg4QLneguIzTtuJbPulVn+uKNw0Ilo1ELJ4QlNpDge+w5x6M6EpnBcwXY6BynQjrr+3mKJ6Rsh+5cLJM4w/b58oyMQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795204; c=relaxed/simple;
	bh=4+YrPRcVqMv/fQgMPW18Ct1VG4fvCCwxL+EmtKMS/pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gv+q7dyZC+gBUBtfC2MqabMhrJqMdA4FuXRkPBkzF23sFdUfDmXlHgaIRsKELNVZ3lQg8lq7KHXp3FmuGmByBaR9a8CHeEN9acInZ+4Tbw0502ctRYhJZVhavYbDiQOXaEnuP7qEOyP3ycre8kfCFLtgMdvj+TSoSBQXYa8oAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4GW7oxK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so880372f8f.1;
        Thu, 24 Oct 2024 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795200; x=1730400000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zBKIyJG0eb63XPWiOYyVTmMyMntjgMmdVl1A8H6/SA=;
        b=J4GW7oxKQc0uJWAd0Q4JjHO/kG+cIKj/BWK6aqLMM/0Ol9BhCcBAfNAy+w8FBXvrUp
         AvTkbCRZsfOOlScJaU1i6sjSg4zcbUFYvz4hMaZ6+N3bK+IJCO7nftunjcioFx6JfKhT
         X5vJQD472DPrSQbdWCH0QXU9kVvE6y5iRLjC74NshQ5Ihkou5AnbSw+Hp4uvlHaKrZYV
         klu4xfYaiIKIVQh6akQXbEZ2NSrsVGOQlGepMluGpU7+XwKFuG1tB3TLChBZE+MUdMov
         jk/Z04YWKZuo+l/KG7q5mOjw8ZyDHIc710KDXl8QtG/ousmMBDiReYb34Nx6UxRPM/cv
         +6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795200; x=1730400000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zBKIyJG0eb63XPWiOYyVTmMyMntjgMmdVl1A8H6/SA=;
        b=Ik7ND6U7r3AftdY4bNi16D5VsC02ggUW1KRl/t7zv9bO3G55viTdVX/c1alYfRFHaR
         Wl3NE7YeEOB0J0IyxfcCSruirmrEgybpMzRoAeVwkHmQD6EMWUAnMV7Ffo8MCrmEEwY+
         K7Ejk/diH1WYEIxKMWkv0VCbeaUs/mvpG7hFhgUYHMJIbHa2IS6q+tNliVkChpdJ+gb6
         7Oxbr4WYMKY5hLQi40ciACktrTXP5dp9EHvQBs5Ue8c5KXKLWii5lJuxrFhAHQ/rii07
         6TUN3vBkV9xP35vwWgPb+tFeP2hyA6qdBe71SWAampsIpL2me34dhqE/i03pChhpfSml
         hgvg==
X-Forwarded-Encrypted: i=1; AJvYcCU1+rQo7V1z+SnpoG5zORk4Cdp5sJFEOosmG6XXanhb/HtmczH5GiFj+I8x0pOjDdH9PxImEsvAHQc=@vger.kernel.org, AJvYcCUM2qION/McsyNVXGFyGpkILejY5t4xlqhWWR5C87mu5MEZ1b5LpVucX3gv7br2+GuOFPOR8DZuH4GCMRdt@vger.kernel.org, AJvYcCXosaGxx0pQHPl85OyMdkFJGP/YFgyJ9ZvjynQWbX7SzwbMoSKOtizfGsniPi4hiky3JjSztU76JO8oUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEEkZN/JGDZqcXSUn+enboNK90azXaBmcU2CMQhBypWmFlezi4
	BD4EreWp6zgtmXuWrw+4L1FDEZ8gAmW2HfnEtdnHYebU1QWvTY9N
X-Google-Smtp-Source: AGHT+IEsGZJIIe29uE60geoHHgxX9PJyxDhEUiavnq0WCA0WBSxVtJZeza6I9PyBcxncDlMHitXw+A==
X-Received: by 2002:adf:eb06:0:b0:374:c84d:1cfe with SMTP id ffacd0b85a97d-37efcf06b6bmr4317147f8f.21.1729795200342;
        Thu, 24 Oct 2024 11:40:00 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:937a:2f15:cf5f:c6fb? (2a02-8389-41cf-e200-937a-2f15-cf5f-c6fb.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:937a:2f15:cf5f:c6fb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a58cd2sm11908117f8f.55.2024.10.24.11.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 11:39:59 -0700 (PDT)
Message-ID: <d5a57cad-7311-4075-8b6e-04f22ed510f7@gmail.com>
Date: Thu, 24 Oct 2024 20:39:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the char-misc tree with the iio-fixes
 tree
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
 Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 linux-iio@vger.kernel.org
References: <20241023141015.0ec5346d@canb.auug.org.au>
 <22f9dbb6-ba5e-4c85-8aa2-6090008e7da4@gmail.com>
 <20241024184108.6eb3bdf0@jic23-huawei>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241024184108.6eb3bdf0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/10/2024 19:41, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 20:17:30 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> 
>> On 23/10/2024 05:10, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the char-misc tree got a conflict in:
>>>
>>>   drivers/iio/light/veml6030.c
>>>
>>> between commit:
>>>
>>>   de9981636774 ("iio: light: veml6030: fix microlux value calculation")
>>>
>>> from the iio-fixes tree and commit:
>>>
>>>   ed59fc90f38a ("iio: light: veml6030: drop processed info for white channel")
>>>
>>> from the char-misc tree.
>>>
>>> I fixed it up (the latter removed the line updated by the former) and
>>> can carry the fix as necessary. This is now fixed as far as linux-next
>>> is concerned, but any non trivial conflicts should be mentioned to your
>>> upstream maintainer when your tree is submitted for merging.  You may
>>> also want to consider cooperating with the maintainer of the conflicting
>>> tree to minimise any particularly complex conflicts.
>>>   
>>
>>
>> Hi Stephen,
>>
>> I doubled checked the status of the driver in linux-next, and everything
>> looks as it should: the first commit applied as a single chunk, as its
>> second chunk affects lines that the second commit removed.
>>
>> Thank you for fixing it up.
> 
> Not quite. This was a lucky merge issue as it highlighted something I'd
> messed up.
> 
> A rare case of a fuzzy application of a patch picking the wrong block but still
> giving a very plausible looking diff that fooled me.
> 
> I picked up the fix via a different tree from where you expected.
> In char-misc-next / iio/togreg there is only one instance of this code block because
> the larger driver rework removed one of the two that was in the tree that
> iio-fixes is based on (effectively mainline).
> 
> The fix got applied to the one that is going away (which is going away because
> the scale makes no sense on the intensity channel) not the illuminance / IIO_LIGHT
> channel that was intended.
> 
> I've move it to the right block with the side effect that the merge conflict
> should go away.  Javier, please check iio.git/fixes-togreg to be 100% sure
> I haven't messed it up again.
> 
> Thanks Stephen for your hard work on linux-next!
> 
> Jonathan
> 
>>
>> Best regards,
>> Javier Carrasco
> 

What I see in iio.git/fixes-togreg is right in the sense that the fix
fro the processed value (commit 63dd163cd61dd) is only applied to the
processed value of the IIO_LIGHT channel, and not to IIO_INTENSITY.

The processed value of the IIO_INTENSITY channel should be then dropped
at some point with the other patch, as it has already been done in
linux-next/master.

Best regards,
Javier Carrasco

