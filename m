Return-Path: <linux-iio+bounces-27383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4FCE0080
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0DE301919F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B4F2405FD;
	Sat, 27 Dec 2025 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XazrX/3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2815CD74
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857905; cv=none; b=ePJzTw+wxW/WH9B3nDgeZ+HN095I5d5g+57q+UD5Ioc2/dWPJjLI0jtcOSTW7QR1w9v8PbrhVKhjSS5EjtskjFgFDblgB19iEy/aDMRs0l8PvlTLDJYveVJl84x1AlAN0WRLHjeZfdXNuw6tpbVWBrrrfXvkcd4VpGOcE+gDNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857905; c=relaxed/simple;
	bh=Swu1AsoD2uKVKIsO16rFYanR9wkyI2Uyh69Ficn0+3k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KBtoCIAphSnVjQ9yX0tzmG4srS03Hj5F1QwS7JB765iNSdW4vop01jS9/Qb49nESM2gSIPl9SPOy5mJxrlHEXh/8Gshy+s1QPzXYFsHGWXmQipmzu3xMIDla+4tr/yZjxJfm/nQpSqikcoZ8PCSyZTOn00EBe4PDB+c1PIPtGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XazrX/3C; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso4876070241.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766857902; x=1767462702; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmFzJPPSFZ71FHxxZJBuKnxU6e6Q71MdYKBIZQXMAjs=;
        b=XazrX/3CzQMYvbReDqM73WJlsCCM9wqN4jd6B7zfyvpXiiWyGurthpOqDbJoW9/BYE
         ATahx+qomKphxY0qIL2kI3dlsoFpRO6IUPFHjw0h3yJ45SroLJEEeH3YUA3kK/Y+nPVR
         7KQ3DxXqKS7Zb99mPXbkPtIixxSBV/1PoAJDog4MVZZU1jPfGHPUxSFxYqzl1Xg9BXF9
         tJ/dBBnYqOHk3WUX3QbP6mGQ0csP4Byzfi9E+ZtJFE/U1Rkc394qe9NY/Yhu6Vw3UzFp
         beAM67bhftAUXF8l7+vXbRYAXEaUSnaBT1klrRaSuLtryNv4pBtMU/1bJdYVVRQRxgVq
         2zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766857902; x=1767462702;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vmFzJPPSFZ71FHxxZJBuKnxU6e6Q71MdYKBIZQXMAjs=;
        b=Hv3M7oUHZrf6cNIN+hbf4gz8W43ZnCtP25j3tN/fAaM9CbPZt1ZvoEyn0fEsvcTvJW
         aKhx0CV2HLLHnsk1YKxdYy2oprI2YyvbFEfAvU8Z9OHWtazxbMqBUq+f6EjYFXXn2IFm
         +aiBBEunMI1z7nKSGwle1iAjjSCUuFyIkB33lRwuTSHcsdc8mRGQ8uAxe6XMY4SJFJ7C
         dw4o56tJHnO8dKz9r4HgGSf43JY69rzbSXPUoqhJ1nadQYbV36jy82jkLTC9IdbVCx0F
         XD8VTJ5LakWxFgntQGNSaJm61nmTS2J75tCUyePPJqY/Bv2qBZxmS6pDQINWp0H7Uw9v
         FibQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDJgFvdjoX5c6wxwPwQ41jGW3hKpovYUWQdRSXR6ZaYk7rUaKkqnsyXXvzp904RJlIdAIQS4j+NYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Avw5t06/yEEI9mJ9AJ1CJOpLqNxPzKGdps6qyx7LSQ1KWYVD
	YqZINX84GRqR0s0/4Zn+zBtP4rHoiBqNJfngFyP4SL2JjF8RecYwzp5u
X-Gm-Gg: AY/fxX4zrCeSf4n819NBGO/IknR6skQOJ/HsnU05aeduj+tXxgDFdmvsKooWUUsMqEG
	Uywn6jNMf1SYTXrSWWABnOUWo86F3l7T9OBbAmDLbqSi6+JVecykkkk9cFRE+XpJcyNK8q1Lc4z
	iO2SQts7RJcTw/+zHnomLU/UP5lIpAPU1INszdrEQ55r4Qb7BcHWnARg9eYkYcrnQuls3p80yn9
	wO3ht/3GiFES+v1ZIaloVr8Vle3E3ipbZrr8fArXnZFE1FAl7hf86tMxyR/h0kGLWwZYXbRiPCM
	gb3e+lHkw9r1bE2Cysks9wlVZ/NW4hzVyVdRKOFcfT8cMlm7ZNcaCecDidPIWuuPSbhcCxUjRUg
	X41Qy1FMO50gxnuVRSZaEHuNoS01hCct+GLhgdoYECdBaPjtStwvA2ktcFdAe036Q7pzCBYXY80
	Bw/A==
X-Google-Smtp-Source: AGHT+IGKy3LCwmWTq56Z8fUz0bj3S63XBFyo48A59tnEZ/yi1Ul7cN7lZGg0NVGTKJhH2jVih4glzw==
X-Received: by 2002:a05:6102:5113:b0:5d7:dddd:5709 with SMTP id ada2fe7eead31-5eb181a50e7mr8023956137.0.1766857902259;
        Sat, 27 Dec 2025 09:51:42 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5eb1ac64f63sm8447665137.10.2025.12.27.09.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 09:51:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 12:51:39 -0500
Message-Id: <DF96UPJ1TKP2.2U8D76HGLPT09@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 1/7] iio: core: Add and export __iio_dev_mode_lock()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
 <92d07935-b2b5-4cf3-bd45-654d77cdc23b@baylibre.com>
In-Reply-To: <92d07935-b2b5-4cf3-bd45-654d77cdc23b@baylibre.com>

Hi David,

On Tue Dec 23, 2025 at 12:19 PM -05, David Lechner wrote:
> On 12/11/25 8:45 PM, Kurt Borja wrote:
>> Add infallible wrappers around the internal IIO mode lock.
>
> Not sure what "infallible" is supposed to mean in this context. Maybe
> referring to autocleanup?

I meant wrappers that do not fail i.e. return void. Should I word it
differently?

>
>>=20
>> As mentioned in the documentation, this is not meant to be used by
>> drivers, instead this will aid in the eventual addition of cleanup
>> classes around conditional locks.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++++++++++
>>  include/linux/iio/iio.h         |  3 +++
>>  2 files changed, 33 insertions(+)
>>=20
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-=
core.c
>> index f69deefcfb6f..1cce2d1ecef1 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -2171,6 +2171,36 @@ int __devm_iio_device_register(struct device *dev=
, struct iio_dev *indio_dev,
>>  }
>>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>> =20
>> +/**
>> + * __iio_dev_mode_lock - Locks the current IIO device mode
>> + * @indio_dev: the iio_dev associated with the device
>> + *
>> + * If the device is either in direct or buffer mode, it's guaranteed to=
 stay
>> + * that way until __iio_dev_mode_unlock() is called.
>> + *
>> + * This function is not meant to be used directly by drivers to protect=
 internal
>> + * state, a driver should have it's own mechanisms for that matter.
>> + *
>> + * There are very few cases where a driver actually needs to lock any m=
ode. It's
>> + * *strongly* recommended to use iio_device_claim_direct() or
>
> I wouldn't even say "strongly recommend". Just say "use these instead".
>
> In the exceptions, likely the autocleanup version should be used as is
> the case currently.

Sure!

--=20
 ~ Kurt

