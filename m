Return-Path: <linux-iio+bounces-28007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE4D3B74C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEFFF30090DB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CFC2C15A0;
	Mon, 19 Jan 2026 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXQDr7Na"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2E423B604
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851065; cv=none; b=cwAfgpgecvXKMCc2dWMDQasQxTLVUwQU9PEn6hXFJ2cZmGRPyGFfyfV6gPE3lDsDlXtGYNqIfjkEoV2EqFaKrg7y7qfuCi1JtOBHWvqiJQ+L1hApnAHbd14xzXQtNhYWIaZvrASCtYEuuHPnoQOr6SHKxekBtWSuLUleAL0/Jkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851065; c=relaxed/simple;
	bh=8ekbjBw6M/rsnNmO/cbzayaTuonKM33h9jOjhxZad3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=q1Dmfj6bcBq8XlzPqm82aDIGf699ZE1kA3PiYykTEfwDKiutQhqON94oTC4HNwLvG4d1g+J3wrMVXskViPyJRL3wWEEh/etELFq5UnsQVA/XXgC43oPR4s9ETLj298kGxpqC83bwhdb7SHYGLDEaH/eL51pU2bLODtuhEZ4P0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXQDr7Na; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5636bf70eb6so1183668e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768851062; x=1769455862; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSI/mMQ05DiSZvf3TBwxj/Af+SeoSoRBsI8Y3/TAqgo=;
        b=QXQDr7Naeb800YNykA01uCCTnGG3IZLuAkfN85m/9z3fPGTlkWwYPOa/22vyQUtIho
         TNWmzFPDNncifN7ptJlAtPBHq0xeKmepj7oDHsUOkF4zGpivutlLd49pVhq5/WGZiJoe
         XJJ8h7AuS706Ql+h617J+4idxJj6pFnPp20cdOf09hx/UiQnTb6mV6bshUlgU3rh2O+v
         K/c5ieIAxrw8CQiAue+62ceYO/4ezFvR7u8s8cV+7qrUeiEBkkYVPfOLpoYr0U/5NkMn
         adt9rwXbSfuGGmme/OtNVh1ge+ivTFQpImOnzBwQaes/eHEyOdijMlMuE7V7r9WtNaAg
         3Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768851062; x=1769455862;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mSI/mMQ05DiSZvf3TBwxj/Af+SeoSoRBsI8Y3/TAqgo=;
        b=kRz4aeuLQ+ZD8aTevQOiH7I7GaI8G3XlmKw3G/lBXdpR1yXiAbYX++w5ZKLbjt5heV
         ZnAxlotN+w2tQhUqt3cbdNrWbjjejXiX6jbRLFTM4DXoA5T8407g67zkYXiB1NsEhF+R
         EMRj5rX6EbAlFRYnjjIgh/fjh+Bmt45L5Y/FIORM0+ziZ3/X227iQxNY4wf34pnLvskY
         wdEz2nNFe7Nvdm9NhsPJ5oXvi+nxGEZC+AC1sxoyxJG8qoh2O4S4fAHbRCW+ZeKZ7wi1
         Rw5sn7w/kQD+E7wY8pfyegaUD04Brb6CknVk5cSmhmXN0tJRekBn6GQklpSNo1oMdaAC
         OzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdwpJjR02153p3lxpdtXCIgUldQ7T+/tspmDhDEPFXQlAxjd6xiUs8sWonpLVZKyvC5Q5t0aK4C08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFw4hx5KFM9x4+8YLT/kUgrjXu+IELK+piTEGRZkHhRWe4Nyck
	ZkIkjma3uJZ19BJ29OqLp/0IzqU5wibcyEm3rn0lUGSA3UejJM/khrhr
X-Gm-Gg: AY/fxX6jtdmNc8GGGCKzMaUjQwfUjlwVZQOMfwNahbsOev+EGytK84d2o0sQtiyXq1y
	b6HlfpCWtqpNurdxj9FDNMK5jlrhaJ80d/DYquBEi7LhEbxoDfn/zAnZ6ltJZl2iD+smD6SawGA
	XUoJ6AymG4lxj5NdjofN5jeXZLW2xIMEyOBvzuktTjitsaaJfNn4rVh9f9cBodES1pbn80J5TgB
	Y9MiBVIAzJWG9Qx3YeGgNQzbKHlkEnz0RDFSEFPNwRcfbaN17CAYcG/VAGrrPjssTzI1oNrFAnc
	OGBlYc+DFqkj3W2KzsDC4em2BmNbRSHzSVDvDtkOIAIkzjDpO1eqMPtiyX7WQzos0BN09ewyjpy
	xV/QSu+e/qBDqeA9L7s4YGntsFV3qwK50dXUE5Jw2NwT2YbOfJ//Ze8rCByvj2PPspVzjnoNgD1
	Yzrw==
X-Received: by 2002:a05:6122:7c8:b0:54a:1e96:e958 with SMTP id 71dfb90a1353d-563b5a79b75mr3945356e0c.0.1768851061928;
        Mon, 19 Jan 2026 11:31:01 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b70fea8csm2984342e0c.15.2026.01.19.11.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 11:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 14:30:53 -0500
Message-Id: <DFSTD80YOO0Y.1LLCJGT3GW0S3@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
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
Subject: Re: [PATCH v4 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
 <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
 <fef660dc-8c81-420c-95b6-cc8649971894@baylibre.com>
In-Reply-To: <fef660dc-8c81-420c-95b6-cc8649971894@baylibre.com>

On Sun Jan 18, 2026 at 2:35 PM -05, David Lechner wrote:
> On 1/18/26 9:44 AM, Kurt Borja wrote:
>> Add guard classes for iio_device_claim_*() conditional locks. This will
>> aid drivers write safer and cleaner code when dealing with some common
>> patterns.
>>=20
>> These classes are not meant to be used directly by drivers (hence the
>> __priv__ prefix). Instead, documented wrapper macros are provided to
>> enforce the use of ACQUIRE() or guard() semantics and avoid the
>> problematic scoped guard.
>>=20
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  include/linux/iio/iio.h | 65 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 65 insertions(+)
>>=20
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index fa671e120e95..4a0a77fcfa8d 100644
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
>> @@ -740,6 +741,70 @@ static inline bool iio_device_try_claim_buffer_mode=
(struct iio_dev *indio_dev)
>>   */
>>  #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock=
(indio_dev)
>> =20
>> +/*
>> + * These classes are not meant to be used directly by drivers (hence th=
e
>> + * __priv__ prefix). Instead, documented wrapper macros are provided be=
low to
>> + * enforce the use of ACQUIRE() or guard() semantics and avoid the prob=
lematic
>> + * scoped guard variants.
>> + */
>> +DEFINE_GUARD(__priv__iio_dev_mode_lock, struct iio_dev *,
>> +	     __iio_dev_mode_lock(_T), __iio_dev_mode_unlock(_T));
>> +DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
>> +		  iio_device_claim_direct(_T));
>> +
>> +/**
>> + * IIO_DEV_ACQUIRE_DIRECT_MODE(dev, var) - Tries to acquire the direct =
mode
>> + *					   lock with automatic release
>
> Should be just IIO_DEV_ACQUIRE_DIRECT_MODE()
>
>> + * @dev: IIO device instance
>> + * @claim: Variable identifier to store acquire result
>> + *
>> + * Tries to acquire the direct mode lock with cleanup ACQUIRE() semanti=
cs and
>> + * automatically releases it at the end of the scope. It most be always=
 paired
>> + * with IIO_DEV_ACQUIRE_ERR(), for example (notice the scope braces)::
>> + *
>> + *	switch() {
>> + *	case IIO_CHAN_INFO_RAW: {
>> + *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>> + *		if (IIO_DEV_ACQUIRE_FAILED(claim))
>> + *			return -EBUSY;
>> + *
>> + *		...
>> + *	}
>> + *	case IIO_CHAN_INFO_SCALE:
>> + *		...
>> + *	...
>> + *	}
>> + *
>> + * Context: Can sleep
>> + */
>> +#define IIO_DEV_ACQUIRE_DIRECT_MODE(dev, claim) \
>> +	ACQUIRE(__priv__iio_dev_mode_lock_try_direct, claim)(dev)
>> +
>> +/**
>> + * IIO_DEV_ACQUIRE_FAILED() - ACQUIRE_ERR() wrapper
>
> This one is correct style.
>
>> + * @claim: The claim variable passed to IIO_DEV_ACQUIRE_*_MODE()
>> + *
>> + * Return: true if failed to acquire the mode, otherwise false.
>> + */
>> +#define IIO_DEV_ACQUIRE_FAILED(claim) \
>> +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_direct, &(claim))
>> +
>> +/**
>> + * IIO_DEV_GUARD_CURRENT_MODE - Acquires the mode lock with automatic r=
elease
>
> Missing ()

Hi David,

I didn't see what you meant in the previous email. Sorry! I'll correct
it.

--=20
Thanks,
 ~ Kurt

