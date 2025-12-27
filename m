Return-Path: <linux-iio+bounces-27386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 637EFCE00CB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282B13019889
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184EA315D41;
	Sat, 27 Dec 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZiDoon1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06D205E25
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858659; cv=none; b=jU76HSW1MxHsYP8QTZPGW0/lNTq0+ot+kBuyLSbuw2KdKIoCsoMp80st+0EToBA913Jtb2Z5bh1j0nHf5oEGBzP/boJcFnQxDDalV4pNQBrsHiskT4gViCpSyOMk+iCM3q8eRsH/IhuTyEXUEpw4+D/fb7BmzXMxu9lZUuOYaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858659; c=relaxed/simple;
	bh=lqrS/zjIYx40Yg8PlnjUuTxP3jx36eCAmsTfFvh4quo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=LrdGu67iihjHJBRAXFBOgD0Dq2xMjGx4Xofjrt3H1tz0IYzwWGwY+TYnOMpqWEgHpwMt4NmXIxtCjowGII99lMwpYZg16K3+FLnU5E3MSaLOgpPim57DRjQt4aUGdp2ECVSHwY+JwVfXJ+xdsTBpyS064LkKQVAhRsvZIgsQG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZiDoon1; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b09d690dcso2860371e0c.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766858657; x=1767463457; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndiaKA3zHdfMjEHzp3S9OhQFlmAtLm0Pa+LsGTsnIAs=;
        b=OZiDoon1r7hsJnckhJgzGiXZ+9VEqmrq1gJCcZ3Hgqm0ma//tR7hEpZI4OWmOzDzGC
         Gr2ApO4KV/FMytdVWzOy8ahxf5Pk0WSV2z3C1kGZYlYGLVkgMI9WWmAET4Bb53migPsi
         ntP7y3bgo52i/lbBcaxNKMe22gv8zLzE2lHnCC6c2/0CFNnk7Y6HIKOWPJnKFuK3UKj2
         MVz6Wn2LwNcVE7nOwqHo8Gt34tZkSAkQbgpAWf+m5W7ceNU/Y0HM7yghF38QoJxQjCbz
         o9sDNHeDKGqrm7k5NONo1DRnIBE9hwShtb0SfPYi86lKwb9T4X5xv9VEkNDKTnLWi/eB
         2+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858657; x=1767463457;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndiaKA3zHdfMjEHzp3S9OhQFlmAtLm0Pa+LsGTsnIAs=;
        b=gJvj6ZMKPS2V51cEKTpsvn40+RH9QMOksZZvi8RuTvFjwBUpBPaezLfYw9SlrcwY4B
         p05mtjb95iWCQiph/aeFYxA8s+X90LaKmiwL02ELIDWtbpljFz/sz1kvzVLbxpiDwhKS
         f3Op5DmWkBXoeA5tuH2G1zwCuNj71iyUplLnXOHuWDFIjBTgbdS+elRWQ/cy8eb7Psmi
         AvgCJ4YdcxzwV55oC54Y6CFhr7Jx6jOH+38KR9zWZlE5Gs+tMSXW8gS36lkOke7JfGal
         P6RYr8s92Y/j0mtbwCpEKUJfVBqmUJdZB3W8XlsWCD9WZ1XNWPF8rNFzvgsCZ/eZ/niL
         HXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUSCOL36E8+jKulFdX6XuyEOByDFK/IIv1LEU7n+C36VqMyw5fhqJu1RYqn1oVBKotwgIIVjE3jAJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2gZZUtU1GUfy7JfuG+6+jL28wcxzQUxPgxzYRnMoJdi9loPw
	XXNxKL5kqHoQDbyfnHZaXADh0vQqXr0fn69rkW9rUp7dUVZrY47vTHtY
X-Gm-Gg: AY/fxX65JqCRL1U2+zvBY+4v9CAnYTcMMRwBtKa2spH6TgGuAyakQPWGMxtxL4cQ+k1
	Id/hYm07XfxtmVmYrHnAzK97tiPM7+JN7vRsczRkSxMzUVQXTlRSglfbCTwn/hvZaqroin96cOz
	XbrYh6wuwZVnJxFcmMKycIp6RTGb26wBMs9sJUEZd+OFCsQLe/pbrFRpd3dn1rzz9/YHyBflrJs
	BGMZ724Y4FTGobDyQJJTyNPolSvaMPMkiuuwtmIwMfPoq0JH1Aq1ouk/dOs7jHAMN9Z9LIzrMZf
	j4ux73Yn2jFJJoAvqB1/6RkyDGOVtiPshwGxLPLEvWUQsqz+rzXXuFKAZUO6JRV8rLaZ37TKXlj
	jfLR9z/gptAX6DUXV4EtCRw534VnTtVb3GZeowbU7UZszsCRMJOxIqVnkGmtaQjSi6FjEZ55KPz
	Nbjg==
X-Google-Smtp-Source: AGHT+IFMdahookWFrofSUU63LPPQg44mNjDOGme9X4c0o3pENxZxJbB959KtW1Yruxhnf1OpDcjZQA==
X-Received: by 2002:a05:6122:3c86:b0:554:b32c:6f76 with SMTP id 71dfb90a1353d-5615bebc60bmr7329206e0c.15.1766858657125;
        Sat, 27 Dec 2025 10:04:17 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5615d1665f2sm8376920e0c.21.2025.12.27.10.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 27 Dec 2025 13:04:14 -0500
Message-Id: <DF974CHWQ5BL.MW4NYZU499S7@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v2 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-4-6fb47bdaaf24@gmail.com>
 <f5ef483b-12d8-4ed2-9637-af993c3f8b7d@baylibre.com>
In-Reply-To: <f5ef483b-12d8-4ed2-9637-af993c3f8b7d@baylibre.com>

On Tue Dec 23, 2025 at 12:23 PM -05, David Lechner wrote:
> On 12/11/25 8:45 PM, Kurt Borja wrote:
>> Add guard classes for iio_device_claim_*() conditional locks. This will
>> aid drivers write safer and cleaner code when dealing with some common
>> patterns.
>>=20
>
>
>> These classes are not meant to be used directly by drivers (hence the
>> __priv__ prefix). Instead, documented wrapper macros are provided to
>> enforce the use of ACQUIRE() or guard() semantics and avoid the
>> problematic scoped guard.
>
> Would be useful to repeat this in a comment in the code.

Sure!

>
>>=20
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  include/linux/iio/iio.h | 83 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 83 insertions(+)
>>=20
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index f8a7ef709210..c84853c7a37f 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -10,6 +10,7 @@
>>  #include <linux/align.h>
>>  #include <linux/device.h>
>>  #include <linux/cdev.h>
>> +#include <linux/cleanup.h>
>>  #include <linux/compiler_types.h>
>>  #include <linux/minmax.h>
>>  #include <linux/slab.h>
>> @@ -739,6 +740,88 @@ static inline void iio_device_release_buffer_mode(s=
truct iio_dev *indio_dev)
>>  	__iio_dev_mode_unlock(indio_dev);
>>  }
>> =20
>> +DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
>> +	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
>> +DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_buffer,
>> +		  iio_device_claim_buffer_mode(_T));
>> +DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
>> +		  iio_device_claim_direct(_T));
>> +
>> +/**
>> + * IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) - Tries to acquire the direc=
t mode
>> + *                                           lock with automatic releas=
e
>> + * @_dev: IIO device instance
>> + * @_var: Dummy variable identifier to store acquire result
>
> It's not a dummy if it does something. :-) (so we can drop that word)

That's true :).

>
> Also, I would call it _claim instead of _var to to match the example
> and encourage people to use the same name everywhere.
>
> And for that matter, we don't really need the leading underscores in eith=
er
> parameter since there are no name conflicts.

Ack.

...

>> +/**
>> + * IIO_DEV_ACQUIRE_ERR() - ACQUIRE_ERR() wrapper
>> + * @_var: Dummy variable passed to IIO_DEV_ACQUIRE_*_MODE()
>> + *
>> + * Return: true on success, false on error
>
> This could be clarified more. Based on the example, this sounds
> backwards.
>
> 	Returns: true if acquiring the mode failed, otherwise false.
>
>> + */
>> +#define IIO_DEV_ACQUIRE_ERR(_var_ptr) \
>> +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_buffer, _var_ptr)
>
> There is no error code here, so calling it "ERR" seems wrong.
> Maybe IIO_DEV_ACQUIRE_FAILED()?

Here I'd prefer to keep it as _ERR so users can make the immediate
association. But I don't feel strongly about it.

>
>> +
>> +/**
>> + * IIO_DEV_GUARD_ANY_MODE - Acquires the mode lock with automatic relea=
se
>> + * @_dev: IIO device instance
>
> It would be helpful to explain more about the use case here and that this
> is used rarely.
>
> The point to get across is that it is used when we need to do something
> that doesn't depend on the current mode, but would be affected by a mode
> switch. So it guards against changing the mode without caring what the
> current mode is. If it is in buffer mode, it stays in buffer mode, otherw=
ise
> direct mode is claimed.

I'll add a comment on this.

>
>> + *
>> + * Acquires the mode lock with cleanup guard() semantics. It is usually=
 paired
>> + * with iio_buffer_enabled().
>> + *
>> + * This should *not* be used to protect internal driver state and it's =
use in
>> + * general is *strongly* discouraged. Use any of the IIO_DEV_ACQUIRE_*_=
MODE()
>> + * variants.
>
> Might as well add Context: here like the others.
>
>> + */
>> +#define IIO_DEV_GUARD_ANY_MODE(_dev) \
>
> Accordingly, I would be inclined to call it IIO_DEV_GUARD_CURRENT_MODE()

I like this better.

Thank you for your comments!

--=20
 ~ Kurt

