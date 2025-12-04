Return-Path: <linux-iio+bounces-26752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 655A7CA4B9D
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D85B03005D25
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EF2FF17B;
	Thu,  4 Dec 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM3+o/sW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB72F8BDC
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868718; cv=none; b=C3HCcjOp0qed1doSsWJIbpdFCkQIQu3mok3KOaQJrd9SbCgdAmjusi2WWAjljQF9VFjTTK30XIcOeEYRBjm31T+E84r2r82BVV02DTQ32F/PNSDSuaAqfOvs43o+FhuWk8YfXfrdTJsOhtDGFR89cAInto09vxQodaca4Nplxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868718; c=relaxed/simple;
	bh=w5RO6277pwEdoRV/iCWPDDTJbBvxzyRZV8oInYrd1Ks=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LURQRKJO6tQERFdK3FH0IJwRqH3am60rdvpzt+zUL3XDgowDaSuH3h3x6CkZdUnpfSWGy+vJFAXa3xPvqcMZvCAp0b/OyWbg2GdJS8V0cQEXYXZEJpVMVqquFmKVlpMDYHcweU6NiZRUyBmADBjMky0ymODPxku+Hja7ketTkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM3+o/sW; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6432842cafdso1032902d50.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868714; x=1765473514; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivAIPIWdEQpOqShwhFKKKcoQuY7GbJruOniXmCZT+v4=;
        b=EM3+o/sWuolwQSvrsBLdrRDywsuDMVVObAZtFG3wx18Agi63TSsxFXEK2qKZjiYXAp
         mAAS64aQYaKT1q/m80jdVdtKgOhARVE6mtK76unjujs9BoLl47rIb2KIM+7cha9+QeH4
         BC0Iy/b3bUaMJoIbYT3dywLwtcv0pmejmiZs8rkI0LeawHxGfX/f4J3e/8vg9tMrua73
         zGp2lCk99yAlYLm9UgNXDWMeF30jQ1FPhc+IzOJWkQCdMphgp4mTK+z51G3u9JxkMsiq
         +diDWNIsz6zcxdM5jr3D+tT3bbbL7cvRhIYsUQ4PawLbMKtWDQ3PlUGVU8Q+joNBPCoH
         s7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868714; x=1765473514;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivAIPIWdEQpOqShwhFKKKcoQuY7GbJruOniXmCZT+v4=;
        b=APGbOzJ9NC45763dgW9w50KbKuOoT63IlyCfzVL8Wuz2ciWNqiZWlsfdYmdxrN/L3v
         m5gQc772/tTlN62tb2GLo3wk0dlUmn/a5w7PW50r6KnoD9K3EoE9b0sURId/7DTQwdp5
         6UJWOSeGi6YJZG0CvdJ4RIyiZbERzqbL7wVCtP5M7R8l0E9jIJdgNjEymJILSNfMRAxv
         SA0tbNYVkdoSryGrS70tpTpu+DCCjGFfA/Pck3BNf8yF7zEoTs223siw+TG0I5O/3lD5
         xiCrMLxu9dQ7RNPpN4KxPme/Y2ipDXLtLUGP8oAVFA+s0HFh4qOJtoDTr6uITgp+7OHp
         14Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUl0UIncmh4XUApMMMjaetmMKmxahMdNOhMDum2QcsicemVIesRO+ndB4FdUqXLuok1qzEkeTAR1bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5hvyd0BfRCgwkVpt9TpuMKiP1Q/eRJfZaL7FDp3BZxb0NPS6
	xDARLz0IIRZqYqw8FjBPvQYdMT1dk5nYM3EHQj1WZJdrSA+rKjVJSCIA
X-Gm-Gg: ASbGncvCt+Hr0QXotAzmtv+UZGgxVkCnzHAQMEyUEqQbIvqd9XMYAicn4wzpx6LFjUb
	9PgVNQ0rRTjVl9MJjhA/hdfFWQ/coM785Xxi6nCr8xtsRjGOjMJ2xpzxJ52buuY5uo6axRX4QNZ
	OT3vtKs5rfstKVe7b5YRxKI5O3YaX30KAjX2TQ/7Gl6AUl/24484XLE5xHzwKYMi9AAuHVG+vpu
	zVHG7fOCbVrqbIsV043+NwfJzyt1fOqtlR+bs9LeVDOaaIa4YdbhhtTv0fKSnRURMkZ1G58Oau5
	zzJ77dvWjztLxx0iZbVChR9VNzxTBQxf5W2ilotwo7jrWuLLDMayLcSFyT98Zb+K2z2u0WlUkwU
	ldkb9v+GSwqbhWcPCPFtODiG+xZTVprAH2dlslZ4x01xsQzfcwjfBtHeN+rOGAjq7O2bo1baIml
	CC02c3Uw==
X-Google-Smtp-Source: AGHT+IFU4LjIIZEnMPIZfgYISjzHy2WuWRbeXPAd/C/KtX4PeTBWdjMsBm52g/3NTmdJv1w+Mg+DCQ==
X-Received: by 2002:a05:690e:e8d:b0:640:dda6:e957 with SMTP id 956f58d0204a3-64436ff2772mr5243894d50.36.1764868714036;
        Thu, 04 Dec 2025 09:18:34 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e5f5sm7330197b3.41.2025.12.04.09.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:18:31 -0500
Message-Id: <DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
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
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
 <3b80f8f3-c435-49f8-8c55-42568215bf0b@baylibre.com>
 <bf1c82f7-da25-47b6-846d-9f8427ee5790@baylibre.com>
In-Reply-To: <bf1c82f7-da25-47b6-846d-9f8427ee5790@baylibre.com>

On Wed Dec 3, 2025 at 5:34 PM -05, David Lechner wrote:
> On 12/3/25 3:50 PM, David Lechner wrote:
>> On 12/3/25 1:18 PM, Kurt Borja wrote:
>>> Add guard() and ACQUIRE() support for iio_device_claim_*() lock.
>>>
>>> This involves exporting iio_device_{claim, release}() wrappers to defin=
e
>>> a general GUARD class, and then defining the _direct and _buffer
>>> conditional ones.
>>=20
>> Commit messages should say why we need this.
>>=20
>> Also, this seems like two separate things. Adding a new claim/release pa=
ir
>> and adding the conditional guard support to the existing ones. So perhap=
s
>> better as two separate patches.
>>=20
>>>
>>> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>> ---
>>>  drivers/iio/industrialio-core.c | 12 ++++++++++++
>>>  include/linux/iio/iio.h         | 20 ++++++++++++++++++++
>>>  2 files changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
>>> index adf0142d0300..da090c993fe8 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -2171,6 +2171,18 @@ int __devm_iio_device_register(struct device *de=
v, struct iio_dev *indio_dev,
>>>  }
>>>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>>> =20
>>> +void __iio_device_claim(struct iio_dev *indio_dev)
>>> +{
>>> +	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__iio_device_claim);
>>> +
>>> +void __iio_device_release(struct iio_dev *indio_dev)
>>> +{
>>> +	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__iio_device_release);
>>> +
>>>  /**
>>>   * __iio_device_claim_direct - Keep device in direct mode
>>>   * @indio_dev:	the iio_dev associated with the device
>>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>>> index 27da9af67c47..472b13ec28d3 100644
>>> --- a/include/linux/iio/iio.h
>>> +++ b/include/linux/iio/iio.h
>>> @@ -10,6 +10,7 @@
>>>  #include <linux/align.h>
>>>  #include <linux/device.h>
>>>  #include <linux/cdev.h>
>>> +#include <linux/cleanup.h>
>>>  #include <linux/compiler_types.h>
>>>  #include <linux/minmax.h>
>>>  #include <linux/slab.h>
>>> @@ -661,9 +662,23 @@ void iio_device_unregister(struct iio_dev *indio_d=
ev);
>>>  int __devm_iio_device_register(struct device *dev, struct iio_dev *ind=
io_dev,
>>>  			       struct module *this_mod);
>>>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timesta=
mp);
>>> +void __iio_device_claim(struct iio_dev *indio_dev);
>>> +void __iio_device_release(struct iio_dev *indio_dev);
>>>  bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>>>  void __iio_device_release_direct(struct iio_dev *indio_dev);
>>> =20
>>> +static inline void iio_device_claim(struct iio_dev *indio_dev)
>>> +	__acquires(indio_dev)
>>> +{
>>> +	__iio_device_claim(indio_dev);
>>> +}
>>> +
>>> +static inline void iio_device_release(struct iio_dev *indio_dev)
>>> +	__releases(indio_dev)
>>> +{
>>> +	__iio_device_release(indio_dev);
>>> +}
>>=20
>> It was unfortunate that we had to drop "mode" from iio_device_claim_dire=
ct_mode()
>> during the recent API change, but at least it is fairly obvious that "di=
rect"
>> is a mode. Here, dropping "mode" from the name hurts the understanding. =
These
>> could also use some documentation comments to explain what these are for=
 and
>> when it is appropriate to use them. I had to really dig around the code =
to
>> come to the understanding that these mean "don't allow switching modes u=
ntil
>> we release the claim".

I agree.

>>=20
>> I would call it something like iio_device_{claim,release}_current_mode()=
.
>>=20
>>=20
>>> +
>>>  /*
>>>   * Helper functions that allow claim and release of direct mode
>>>   * in a fashion that doesn't generate many false positives from sparse=
.
>>> @@ -690,6 +705,11 @@ static inline void iio_device_release_direct(struc=
t iio_dev *indio_dev)
>>>  bool iio_device_claim_buffer(struct iio_dev *indio_dev);
>>>  void iio_device_release_buffer(struct iio_dev *indio_dev);
>>> =20
>>> +DEFINE_GUARD(iio_device_claim, struct iio_dev *, iio_device_claim(_T),
>>> +	     iio_device_release(_T));
>>> +DEFINE_GUARD_COND(iio_device_claim, _buffer, iio_device_claim_buffer(_=
T));
>>> +DEFINE_GUARD_COND(iio_device_claim, _direct, iio_device_claim_direct(_=
T));
>>> +
>
> When I made the comments about keeping "mode" in the name, I forgot
> that DEFINE_GUARD_COND() only extends a DEFINE_GUARD(). So I understand
> if we need to make names that fit a certain pattern rather than what
> I suggested.
>
> Still would be nice to have:
>
> iio_device_claim_mode()
> iio_device_claim_mode_direct()
> iio_device_claim_mode_buffer()
> iio_device_release_mode()
>
> Just really annoying to rename iio_device_{claim,release}_direct()
> everywhere since we just did that. We could keep both names around
> for a while though to avoid the churn.

If we rename iio_device_claim_direct() (which is huge), maybe we can
pick shorter names and more descriptive names while at it? I was
thinking something like:

	iio_mode_lock()
	iio_mode_lock_direct()
	iio_mode_lock_buffer()
	iio_mode_unlock()

Shorter names will also keep lines short when using guards.

>
> It also means that we should remove __iio_device_release_direct() and
> iio_device_release_buffer_mode() to make it clear that there is only
> a single "release" function used by all variants of "claim".

I agree.

--=20
 ~ Kurt


