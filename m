Return-Path: <linux-iio+bounces-27900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A8D3908A
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 20:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7945B301F8FB
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E492DEA93;
	Sat, 17 Jan 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giw/Gp7r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8D2877CD
	for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768678391; cv=none; b=CysgQYSELuv4NqtAErInXga6gaMnJ657sBFWyzHyVTpvUARjyLQVz02tC6ntkEFiSiphOPfyYRthW1O7tRdZg50Rw3WmNWtTnkcShIhNJCecXVJnLt78ZrnAGtmjNoDxlvLE4KRSYZPjVMMwi+mvZiNNOF64Y/0ZkbYzrHQUTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768678391; c=relaxed/simple;
	bh=XA5Os3nG8Cu1wG7aVk4y/cruV4b/sDP00pOQjMtqfwU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kz1Kj/Y+kj0MWrWvPWcCXst6hxI40irt7tdjZnQ+rW8CYA1qYQNl7laxsp2DfeUb9d+9sDaPi/2r6l+8XeSNW3DtP5b8tjRhm1T6yd9NBsJ6PVEx29ndaw3FCX5iI2l4X2CAX9GSm1dwQbUicF/AV+3dMDStqm7BI+VKCZ74OtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giw/Gp7r; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93f542917eeso1018616241.2
        for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 11:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768678388; x=1769283188; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/QjNU03Un5xr+pOfz4kD/Wx3TW7UJG3zU+9aNTvu14=;
        b=giw/Gp7rVeR8NaoPtQx120Y7Md6q70T3hlKZIqXa1Z0vgEtJb9nEROe4qDJdfZdgdP
         m1UQ7o+bqB2mxYfDxJN9/Rt4u4EV5ifSfM3D7ZgkcJ/ZtoGr7QLGQcaa2dcXRoF2cLkM
         Swr2cjy6GZPpcjAuHUsnbX8sopIVEGU1K1zdC0IZHGz0UZF9E2BpM5gAzO4DR9umkOp/
         neB3sMJ+a36Ky8LV2BVay4Wl34Zs3+qCiF+OPzs6JGoS1NyCtA1bHtHPjZ4uclWeEbYt
         OVPepibokkpmXTAUIkMFI/qt5ZQoeaK8rL/6nsd+y/iUeEaNAjgJD7Kg4buiF8Jb39EZ
         /7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768678388; x=1769283188;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/QjNU03Un5xr+pOfz4kD/Wx3TW7UJG3zU+9aNTvu14=;
        b=tKwXpeDKeHkdNjY7lZiU5E0Z9PZ+V0Tcrxcet7oeGq6tB7+dmyUlgVKJ6InH2klobQ
         lF9fmV+JFwioLtblLUUA5Q0IcFpmeQ6aqL3Z57pMzYZjcICe8Owa1wqbmTl4/mVHdbxm
         HVH11Vh+gHYc+kZQuJ4HY9aRjps6oZb0Jnq/YhwZiQiUQ1zL6gCDPmAlvuvor6aL/0l0
         0dOsllKz8yzTyb+rQRjyM225Q3aZ36fNBrPA44CVd/kVkTNWcBV5/pbpiEJIoucrzeN6
         YODAMqmgMBYmbB48Tu+yshZmiGbhvixqtTy27pJBN3KoX0pgDhTZo3kUyJEUG+XaMN6c
         3HIw==
X-Forwarded-Encrypted: i=1; AJvYcCUrDf27zr3KYtmUMWPmLJQHR9mwmW60K3EyxAhtbUwjMZsCPJmLpggI89rlAzyCrE3CygTwD+ZWbCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvriR622BGgAgAmflPqLYoBQ9JANHdiXR5+R0PCFV8tXSgLYJ
	yY+fh4lduYG2NpOMCCNPnCWls1z1+FyRjgEOat6TT1Kfn1oCGm+yPUWH
X-Gm-Gg: AY/fxX4v+l+WY/DOBvya0zattiW2PHmrtYbjp5wWpT7oK8SeeCk+p9GxEGaLUuO9Hu0
	r+r0CAjLFsjcs0ulUSOkmhzfCdGOeHVSnCDEDdxT/Kt8b/dxdgzu1WrjygKqQhEDNOafBEw4Kr7
	swttrnJACc45tPPNSJahFx9CXpa057cH0YiRJEGs9qVPD/qZtrP39M8dGfFAgduA6Etgq3Aanzl
	GmBQpsP7o0YJAOzAVlNFN+BQqASzKkscgG5LpnNhVd6ykE7rHVDurxtoNZvtxyT8w4TLNvGbNdn
	yK+S1tgZi6IAiyzbepJtUWQXJ+fhpr5Sy1BQAOh0RN0BhC/ERPewuQRVyAKAEFdpjcvm8sIOl0a
	2QPAIEjmHnet4KhokhQRlwBKIkCJJvOB2/OLzIvLEZwJfoLgahDvarYqLY4Y+eRUwAhjQeS5K4c
	rw2w==
X-Received: by 2002:a05:6122:3d48:b0:55b:74ac:72cf with SMTP id 71dfb90a1353d-563b738c487mr1679358e0c.17.1768678388225;
        Sat, 17 Jan 2026 11:33:08 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b7123621sm1573049e0c.22.2026.01.17.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 11:33:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 14:32:59 -0500
Message-Id: <DFR45QMTKRCN.2QC7P7DJDIDYD@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v3 1/7] iio: core: Add and export __iio_dev_mode_lock()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260106-lock-impr-v3-1-1db909b192c0@gmail.com>
 <20260116201847.3560a2e2@jic23-huawei>
In-Reply-To: <20260116201847.3560a2e2@jic23-huawei>

On Fri Jan 16, 2026 at 3:18 PM -05, Jonathan Cameron wrote:
> On Tue, 06 Jan 2026 03:06:56 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Add unconditional wrappers around the internal IIO mode lock.
>>=20
>> As mentioned in the documentation, this is not meant to be used by
>> drivers, instead this will aid in the eventual addition of cleanup
>> classes around conditional locks.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Hi Kurt,
>
> I'm being a bit conservative in looking to apply this so apologies
> if it seems like I'm ignoring you! I wanted to give plenty of time
> for others to take a look.

Hi Jonathan,

Oh -- don't worry. It's understandable for API changes. Thanks for
clarifying!

>
> A few comments, but if we go with this version I'll tweak the
> punctuation if I remember whilst applying.

I will fix the ones you mentioned here. Apologies if there is more.

...

>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 872ebdf0dd77..aecda887d833 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -661,6 +661,9 @@ void iio_device_unregister(struct iio_dev *indio_dev=
);
>>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indi=
o_dev,
>>  			       struct module *this_mod);
>>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestam=
p);
>> +
>> +void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_de=
v);
>> +void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_=
dev);
> This is an interesting notation choice as there are several locks embedde=
d
> in iio_devs but I think it is the only one we want to expose so fair enou=
gh
> if we don't see any false warnings from this!

The previous implementation also used __acquire(indio_dev) and I do
believe is the best choice, for the reasons you mentioned. Also the
mlock is inside iio_dev_opaque and we don't have access to that in
iio.h.

>
> Jonathan
>
>>  bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>>  void __iio_device_release_direct(struct iio_dev *indio_dev);
>> =20
>>=20


--=20
Thanks,
 ~ Kurt


