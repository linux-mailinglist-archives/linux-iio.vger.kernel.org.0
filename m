Return-Path: <linux-iio+bounces-26985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CECB1DFA
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 05:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A57A30577EE
	for <lists+linux-iio@lfdr.de>; Wed, 10 Dec 2025 04:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315230F533;
	Wed, 10 Dec 2025 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCwhRmx7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737830E0D8
	for <linux-iio@vger.kernel.org>; Wed, 10 Dec 2025 04:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765339674; cv=none; b=Tl3Qu0Xvqy2uE9UauEYG2XxHGzD4hCnNZvZLMBnToNdhsGhyrh/aDrQRpFZt4l0Rg0OfOrRQfE8hQpsJgWOiibRPcnJtNj/q8F0god8OakJTonDODinQsM3dSwCO9UcxZDDyntsU6JkXzhADZS7DEkSl157SSmc/uOpuj0vZObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765339674; c=relaxed/simple;
	bh=i1gpkRHjj52HV/bqp8fIanguYj2f3n3g7/smx5nUqtQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bKMYhPFw4N7m+5ptlHcBsQS4LsW8kRzw2Xfyq2ufeab6ILwLHLlVnW108LPvhBJ7HuZPQv+VDsd/uBzH+nECSQuQ5M8bgadcGg5bPLjc8gT/U5j0ItwMEjNmALAGiACfhFFTq3O/MYE5dCKdpwog+NsQj54ajJpqDfzfExvlaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCwhRmx7; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbd9c7e468so2812140137.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Dec 2025 20:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765339672; x=1765944472; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCN+wOZwpo+EvlIubaoI595wTf7FwItvq914uZQahfk=;
        b=TCwhRmx7DKQcjs1fd2pZ00L5G2gMNwzG3ge9d5wMJcWkwm7PjeI0i1iAI+IvLQh0KY
         ZpT9+SvotPFyivH19cKXZMCiGBKTQfCddUiTeKmbN5XNpADMv2SDx00G6AL3RvK7KVz/
         F0htTaYiZ02mwLz5e1xPs2UE3v17LngYwg2LVceVWqwMBHkXBrCuaHaQvazM15FutHTs
         w0TweSXNXfttP2RmnSCPHYJ4cpGx8ZGHwWecGzHfpbqvP+ShIB6ECfFQ7Z5e+xyIWuq4
         4pdUa6QGZkGm87oxFzRC9sloq9NQ70PxgMUw2+or4Te8DtH9RfeTizWU9Z2BxJE0cWa5
         Jb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765339672; x=1765944472;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCN+wOZwpo+EvlIubaoI595wTf7FwItvq914uZQahfk=;
        b=H+3yVf/F+uwo55v3r3YxEAsrt92sf1r+flt29EtXV3k4+FvbBsKKHcuJ9Fbd/nkhCD
         3wjUrjIHnhVhwpkizQR0OD4cI31eweTH/C7EKhY7c7bRmhs5bq4d/HTFshW9u/Ij+gRb
         zhLws+v6W7tTYnGPbnSsAQAzNpS1Nd1arm3YipjIcnTYnY7xi/UV7cVPSbpVtt2ilgrI
         8odYyFXWtMPLrpqTxtEMqGKGKoEQcOcU05SR2Ae1571shmsNepHZt/AWsggW0lcq0hgH
         Up1lSgaJeio4LCHaxabOOqY9F0g3oDOHlqDz774W5eehStd5dVgLgE0kjeiPXWmDJ/vq
         MCvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2w5obcRwXhb0R9GxM8KdI+RMMQKIwR8QndxDt2wM5k4jCSQl7tTG8r+v4zQQdK1TR16NJ0+WEXrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQmtGLRdzeUa8aWddBza35ILY0fc1Ugl5gHcfFeoj1EbV5foo
	giop1JNTwhXhALSWi9nQ0JXHbo2/sRRgjRBDkNHvQc7HaAU0mA8vqPxWWxuq7g==
X-Gm-Gg: AY/fxX7AhG9EOsjUbxSVs9FlFgLBX3kMyy0e5GStPEwehIA2W5dq8rI4WZJHs7lUMkT
	qwpGXis0GyJqd4crzVzBoRL6QjuIXYOSbnS6jdRkPB6A5MZ1ZIj9NoyXuhfvzjke6QxR8wiCwQf
	5p4gAjWfrrpHG28JyjVw/7s6DtFk0RoQzMeukb9T6NzxEyW5MlivQ2TlFQ4ae1wLsVfh0NC3wca
	oXu9eg+CJpH4WqdXWzhXFoewNJ+COJqyWgE0oq3cI1QAYq3972DGUx7+fuahfq7whXjbFciK2XA
	9+iFrjoy8SfEhp/+mfUSHuM1PX5OTFl8EkVIdj5UT6tC6hPHhy8H+KheO5BakQVcZ5u+VI3hQmr
	cXoX9vR1eVj5mk54093F0pAkMUpyw5+ZeRJbnaS2OwIjkLZFvTgFoICSXOZkHJ38mO021ZoMsvs
	B3KFo=
X-Google-Smtp-Source: AGHT+IHM30DvWmYtT07T8M42FAxd4lX1UgnTiBhKzv5t+gCOoi7mVGJuQlvB9Bjp4pGe49Z4oPi6Rg==
X-Received: by 2002:a05:6102:390f:b0:5db:faa2:f3e1 with SMTP id ada2fe7eead31-5e571a3b7eemr309836137.15.1765339672002;
        Tue, 09 Dec 2025 20:07:52 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93eed6c41c6sm7781948241.5.2025.12.09.20.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Dec 2025 20:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Dec 2025 23:07:49 -0500
Message-Id: <DEU8OOETPWRO.12I8HY6SHTQAA@gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Tobias Sperling" <tobias.sperling@softing.com>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251208-ads1x18-v7-0-b1be8dfebfa2@gmail.com>
 <20251208-ads1x18-v7-2-b1be8dfebfa2@gmail.com>
 <CAHp75VcOVpGbb3UBm+QQrw25=yU+J624c29ptMk8yrJpNEL=jA@mail.gmail.com>
In-Reply-To: <CAHp75VcOVpGbb3UBm+QQrw25=yU+J624c29ptMk8yrJpNEL=jA@mail.gmail.com>

On Mon Dec 8, 2025 at 3:19 PM -05, Andy Shevchenko wrote:

...

>> +/**
>> + * ads1018_calc_delay - Calculates a suitable delay for a single-shot r=
eading
>> + * @hz: Sampling frequency
>> + *
>> + * Calculates an appropriate delay for a single shot reading given a sa=
mpling
>> + * frequency.
>> + *
>> + * Return: Delay in microseconds (Always greater than 0).
>> + */
>> +static u32 ads1018_calc_delay(unsigned int hz)
>> +{
>> +       /*
>> +        * Calculate the worst-case sampling rate by subtracting 10% err=
or
>> +        * specified in the datasheet...
>> +        */
>> +       hz -=3D DIV_ROUND_UP(hz, 10);
>> +
>> +       /* ...Then calculate time per sample in microseconds. */
>> +       return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
>
> If time per sample is in =C2=B5s, the associated frequency is in MHz, so
> the correct constant is HZ_PER_MHZ. What did I miss here?

I was very confused about this, but the dimensional analysis works with
HZ_PER_MHZ so it should be the right constant. Thanks!

...

> Other than above, LGTM!
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thanks a lot for all your feedback!

I also found that the sysfs ABI specifies millivolt for voltage final
calculation and millidegree for temps. I will adjust scales to comply
with this in the next version.

Do you have a suggestion for this? I can keep the ADS1018_FSR_TO_SCALE()
macro but it will get a bit more complex or I can just hard code the
scales and document the calculation. I'm inclined to do the latter.


--=20
 ~ Kurt


