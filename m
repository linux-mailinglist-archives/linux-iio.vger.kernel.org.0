Return-Path: <linux-iio+bounces-27909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4745D39766
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 16:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46FA300797D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 15:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF6331A5E;
	Sun, 18 Jan 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY2mP+4x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B31284665
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768749801; cv=none; b=L4bq/6p38wvj7YE48j9BoKYZWZSf3aah1WSCuDlunzrt5mMw8gLHrEjsV44IbvzAU9G1sy1VKnb+FDkjI4GCieJRaH0L3rlK2ulLKtkG5kG6VIVOmA5rhnm4p6g5W/sew9dTmHtz1+QvzjPDBQokJceqoCNZ8OwiU6qD6n3d29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768749801; c=relaxed/simple;
	bh=oDCpgvsXM4z2bwqDfi9aak6qgcm1ME6wpQjZP0HqRiA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XO4ACUwOri63jsMMtaUeOZGtQWIIegyQ0/zznRguUXm81+JMAUSR54tCoEA4tijpbEDBAzOBxf2Pd3zwvQJ0cKBkodfoD6xtQx4eI/spSJbHg2isT5egtM8ZrnlLLLZbzl5IXbuIXAK6s3x7D5zUOd2xqnromyams9JMkyMyozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY2mP+4x; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93f56a97064so1093149241.1
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 07:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768749799; x=1769354599; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3ZZgfPfki6qi1CLiANLanlgbVGTSpzfg25ShrKXaFI=;
        b=WY2mP+4xcyTdj74QdIdknnmTgCvfVPdlx8v3vjl3ZI1Fyc1RbUr8sG6SEEKJ3OeP/M
         WDsS9zool9YPkhlAef1IC8v2Yz3bM52Wq/Bew8uldYeoQyXEq7YGGjJUwSjA9nIIwWI1
         pRiSc27iV4mpMIqqDZOPck6y2ut1aRxvGJT92/E2uItWqAm0RrID6KfVTGKbqEt0Yxsg
         9h+k2r4SJAZ3QDTYrTyQ6TWIdRUWnxr0WOFT3o0NLxv1fL8H4Mt/pukI2yjC3gilxagH
         2PEmZzeuXq/5xMvQOYfqQTTwxHhPhsONMvGFY8llxfzv7BpWh2xtbirWel3IdPsLtc3+
         Yqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768749799; x=1769354599;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3ZZgfPfki6qi1CLiANLanlgbVGTSpzfg25ShrKXaFI=;
        b=IROuHVn88lHKXtiOzOx4KOcv2FrduLFzItITmuBMVxbLDo3MUrwGLWrBRQ3yaV1YXu
         fFpftCRYYBNzoztERoraLpDe3JnpZsYMHJudUFu6t/nmz4qoBOkgdnGvbZ4a/D02CXof
         uv7584/EqGAj2+225QtIjtL+fAUM4GP2YOzfqitAOaK6uMZuFj56fDZqGwz3CPg4UABr
         s9qyQNxXqxdBt8uZ8KZTWWeBvrpTNp8YgwPugoD+0ry4OGXcsDbJifdrf48jbWi3KCeS
         QdbqWPKSLULjc0AVqgqUlGUi604k2qHQ+BYnE0mOyAJiYqZ8BQYAJPxxyESk1iqJuGzY
         cvQg==
X-Forwarded-Encrypted: i=1; AJvYcCVTSV+uGoWKoDvwN099xaNyC15fAWguzV6g9ndQaCJOTJ2hYzjcGAV+ZhIxURA7PDWPSq7sfzoHA6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCU4oRoAzfrJaBooQ4f8qVfKi1EDH5u6F7afdpLl/9X7kF/Y/0
	9IOgrB6Zess+swNr0XeGOC7WEYzodkIKuVeq3HXOCkRbpf0HjuDF4I6skwAK8+tO
X-Gm-Gg: AY/fxX6Z3ePPZvG3x+H628TqV1ain02CNcamDZ/5X0OMN2Uz3S5jLATawiEMwu37djt
	b64Si8ps36t4wwN8O+By1SvV8YBR/BVWkoYfuO7PTbg4vbqYsHfRKZ66Y7L13787q79dGc9L0Zr
	F/sfKgdayYUXP1rJQZrfhFi35ZiX8K8VQBeTNFF1gIFqZIVGP/czCqsEWgR/8NU+RIBHDkMyDCd
	DZSMn9a4dEy/yJE96cUx4eQAZI3ZEzY4yYqDunvjC449O/+JHu70nI+CET3dC6UZHd5OfjQ4yz2
	foib+bXp7Qg3VsArWNqu7T+kQW0bNtA0pA4lwLTIzepPmIDF1u8Cj5XZxOq2B9m341Ln7MEhd1K
	3X3wDmYFWKyreH+c8YjfYewPa71DTQhsgF4JuUenCmLSzqhL6PllMBtS30xEYoEyuabV4YzWZqo
	fjNQMZH01ZeCrD
X-Received: by 2002:a05:6102:dcb:b0:5db:3b75:a2aa with SMTP id ada2fe7eead31-5f1a701cbe2mr2430397137.18.1768749798940;
        Sun, 18 Jan 2026 07:23:18 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f1a69444f0sm2595579137.7.2026.01.18.07.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 07:23:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Jan 2026 10:23:10 -0500
Message-Id: <DFRTH0GI1UPO.12NSSABBNSRST@gmail.com>
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
Subject: Re: [PATCH v3 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260106-lock-impr-v3-4-1db909b192c0@gmail.com>
 <27cf1ec1-545b-4e44-8229-852f8bdae116@baylibre.com>
In-Reply-To: <27cf1ec1-545b-4e44-8229-852f8bdae116@baylibre.com>

On Fri Jan 16, 2026 at 5:03 PM -05, David Lechner wrote:
> On 1/6/26 2:06 AM, Kurt Borja wrote:
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
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  include/linux/iio/iio.h | 71 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  1 file changed, 71 insertions(+)
>>=20
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index d8af0456f966..c795f731f2d8 100644
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
>> @@ -740,6 +741,76 @@ static inline bool iio_device_try_claim_buffer_mode=
(struct iio_dev *indio_dev)
>>   */
>>  #define iio_device_release_buffer_mode(indio_dev) __iio_dev_mode_unlock=
(indio_dev)
>> =20
>> +/*
>> + * These classes are not meant to be used directly by drivers (hence th=
e
>> + * __priv__ prefix). Instead, documented wrapper macros are provided be=
llow to
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
>> + * IIO_DEV_ACQUIRE_DIRECT_MODE(_dev, _var) - Tries to acquire the direc=
t mode
>> + *                                           lock with automatic releas=
e
>
> I don't think it is usual to put the function parameters in the
> doc comment like this. They don't match the actual names anyway.

Hi David,

This format of kernel-doc applies to function-like macros too [1]. I'll
match the name of the variables though.

>
>> + * @dev: IIO device instance
>> + * @claim: Variable identifier to store acquire result
>> + *
>> + * Tries to acquire the direct mode lock with cleanup ACQUIRE() semanti=
cs and
>> + * automatically releases it at the end of the scope. It most be always=
 paired
>> + * with IIO_DEV_ACQUIRE_ERR(), for example::
>> + *
>> + *	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>> + *	if (IIO_DEV_ACQUIRE_FAILED(&claim))
>> + *		return -EBUSY;
>> + *
>> + * ...or a more common scenario (notice scope the braces)::
>> + *
>> + *	switch() {
>> + *	case IIO_CHAN_INFO_RAW: {
>> + *		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>> + *		if (IIO_DEV_ACQUIRE_FAILED(&claim))
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
>> + * @claim_ptr: Pointer to the claim variable passed to IIO_DEV_ACQUIRE_=
*_MODE()
>> + *
>> + * Return: true if acquired the mode failed, otherwise false.
>> + */
>> +#define IIO_DEV_ACQUIRE_FAILED(claim_ptr) \
>> +	ACQUIRE_ERR(__priv__iio_dev_mode_lock_try_direct, claim_ptr)
>> +
>
> If we always have to add the & at the call site, could we just
> put that in the macro instead? Then the parameter would just be
> claim instead of claim_ptr.

I'll add this in the next revision.

[1] https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentatio=
n

--=20
Thanks,
 ~ Kurt


