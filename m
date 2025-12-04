Return-Path: <linux-iio+bounces-26755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFE9CA4C63
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17F4F3016F8C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59162F83B7;
	Thu,  4 Dec 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT4yX61j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD44259C94
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869472; cv=none; b=iv1R2+npC2+LmROuEqux+A8J/ogNEFAxykWA1NCDkXMzMz4kNlQBmSvK1oMyVBDwa0r+rOkELdM5QUH35cX4MsB5OK8eM8v7s2LUzVi9yQpug3I34hdXPA4KllA4jONMOauuhcbBtvhn082e51ipPzKShcN8NGRfhwXMd+JMIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869472; c=relaxed/simple;
	bh=Esx9mFokG/UV+AY7kqpOxxAjdUm5ixVVhSJ6k0ZcV+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=R05B1ZHIwCzJhVDUXzPqPN4ntshpexgqCBNjdmtvoDlb2sifW4XwKAJPwnWZu4v/fmyhT/KHSitvItCsd9xo05OfH4jKRDnvSXXgU1OF8sP8djhq2YeNzamuwDCNWWFvjKnVqjYOBjCiVXZQ0O008iH7Coz7kvpfNliDuNlH/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cT4yX61j; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dbd1421182so1030383137.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764869469; x=1765474269; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw+EvpNnPRJxP20IZuJNEAzYLUTff2US5yBiiE9zOkw=;
        b=cT4yX61jaracH18ksyYPeg2prQmzU9ZIvH2M5sXkmUQflXOL15XGYjlIrHcchhvk4t
         JHgS+Pu/nN6JXL8Fwa0mOda8Yv460/KmZT76jeTPiMFE1gUHR0701+7uOivLPeBQz44H
         SZ2Ptt1IiclsHEq2kG4x7g70U2tAW79Fr7boXWtQA63KQWHkHHC1Pv9FM68xmh/DNCZQ
         6PJusDbgsYnX961E73PubKAFHCWO7uK+sBCqC03dj9XalrNe/x6j75sBZEt29jL/1VX6
         rbp3vOIa40z8d/4K0XZ93SKsT1hVc5lnsA7kZaJt+H34j7Q4UYP7hvs4PxeF1toNr8+u
         b7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869469; x=1765474269;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vw+EvpNnPRJxP20IZuJNEAzYLUTff2US5yBiiE9zOkw=;
        b=bq6fTbeqCS+D7/4WzGTL0P3hZku/BMMY4bFVfoUzNXOyCsjHw37VUSRBDbUjoLXmE2
         SmcgakgH1WvMkl6TLvNXWHfzdFHR8BDissPCTqWliHVNlvEyQJEehanxC73jrYg6ShyK
         BpZ6VlZCTPdf7acbkALjBn507pkZ+JnadBIhamdjpm8kfF5T+cq/5XhnIxw6dK0TN2uJ
         K8zqmmxfvC5/8Y4oYoD+6FveOimUKawvR0e6//LMLJoYkPlsPQozC2GrxdqCv8Gsoh9B
         Q85mX+Pge2I6bUBta8+iphDOFsP+YLDrdDvhbFA434Uh09mMjWzD22Y2U9jCuC/XuGHk
         +sHw==
X-Forwarded-Encrypted: i=1; AJvYcCVeIWjw329JNydx5XTddEigTkaBZahfpIUALPp73tOjWYKZKcKq9wsaP9tELjQ/qGn1d4OwtvKSdMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOShmQOg7VTSJXWzV+zCnowmazpmOAMjeGpRzU58reBvtYqhAr
	ZebuAWnupH1c9PdPABAyatXxAQazUs/hznpRQBoBGXxD2dY+esz4uLbd
X-Gm-Gg: ASbGnctrzrTlVBiI4nb2qWbXGRbnje+j9Ii0BF0v++qVhdNrNt7yWAf9tcnjlfcK05T
	iKvPuMF0DGDbS2Ki0wWJkrVzy8vL/oAM0/Ly3P9nLHcs/93gEk2lUpQrFeXKmgXBVT5O8rLIN3/
	w5+/uKcpLcEkywRJDphrs/7GX2Wtsyw7yl4JkRfUVBBsQeaqncJ+a7nnfD+LS/x8gMt+0Ccr4yy
	eLs0KIt7IozSC2P0IPSyoJ41wtt6k+Cx4V0VnAcQt0PP842LHUJbR/32Y65fbdaJ8FZIMk79YN7
	FRcQYVKydzr2eLg6CHPDFnQVPyZeGY7rAHFnFDNQNf7L1aQxni6/pIvLGxCgtEu8GFbxyYFiiIJ
	XFLtBzl+mQIaXXaP33tY42/56Gmd/xrGcsEtYJPQtLdweIPxluxHEeDfladdxWDg+8Z/VW4b2rH
	v58u4BZw==
X-Google-Smtp-Source: AGHT+IEQujdux4QraYp2XErML+qKO/H8lj6CXVbdb1YysmjPx5gDd7EVF0btGcmqCZdDMC/Z/LMbkw==
X-Received: by 2002:a05:6102:510e:b0:5db:e851:9395 with SMTP id ada2fe7eead31-5e50685ba09mr1439059137.7.1764869464743;
        Thu, 04 Dec 2025 09:31:04 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e5107cbc30sm962080137.1.2025.12.04.09.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:31:02 -0500
Message-Id: <DEPM0E265UO3.7LAESKGRLBO9@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Guenter Roeck"
 <groeck@chromium.org>, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH RFC 6/6] iio: light: opt4060: Use cleanup.h for IIO
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
 <17ac2fa9033104c3bf9260fbecc1c9a5b42fcbba.camel@gmail.com>
In-Reply-To: <17ac2fa9033104c3bf9260fbecc1c9a5b42fcbba.camel@gmail.com>

On Thu Dec 4, 2025 at 9:42 AM -05, Nuno S=C3=A1 wrote:
> On Wed, 2025-12-03 at 14:18 -0500, Kurt Borja wrote:
>> Simplify and drop "hacky" busy-waiting code in
>> opt4060_set_driver_state() by using guard().
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>> =C2=A0drivers/iio/light/opt4060.c | 52 +++++++++++++++------------------=
------------
>> =C2=A01 file changed, 17 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>> index 500899d7bd62..903963606143 100644
>> --- a/drivers/iio/light/opt4060.c
>> +++ b/drivers/iio/light/opt4060.c
>> @@ -22,6 +22,7 @@
>> =C2=A0#include <linux/iio/trigger.h>
>> =C2=A0#include <linux/iio/trigger_consumer.h>
>> =C2=A0#include <linux/iio/triggered_buffer.h>
>> +#include <linux/cleanup.h>
>> =C2=A0
>> =C2=A0/* OPT4060 register set */
>> =C2=A0#define OPT4060_RED_MSB				0x00
>> @@ -302,41 +303,22 @@ static int opt4060_set_driver_state(struct iio_dev=
 *indio_dev,
>> =C2=A0				=C2=A0=C2=A0=C2=A0 bool continuous_irq)
>> =C2=A0{
>> =C2=A0	struct opt4060_chip *chip =3D iio_priv(indio_dev);
>> -	int ret =3D 0;
>> -any_mode_retry:
>> -	if (!iio_device_claim_buffer(indio_dev)) {
>> -		/*
>> -		 * This one is a *bit* hacky. If we cannot claim buffer mode,
>> -		 * then try direct mode so that we make sure things cannot
>> -		 * concurrently change. And we just keep trying until we get one
>> -		 * of the modes...
>> -		 */
>> -		if (!iio_device_claim_direct(indio_dev))
>> -			goto any_mode_retry;
>> -		/*
>> -		 * This path means that we managed to claim direct mode. In
>> -		 * this case the buffer isn't enabled and it's okay to leave
>> -		 * continuous mode for sampling and/or irq.
>> -		 */
>> -		ret =3D opt4060_set_state_common(chip, continuous_sampling,
>> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continuous_irq);
>> -		iio_device_release_direct(indio_dev);
>> -		return ret;
>> -	} else {
>> -		/*
>> -		 * This path means that we managed to claim buffer mode. In
>> -		 * this case the buffer is enabled and irq and sampling must go
>> -		 * to or remain continuous, but only if the trigger is from this
>> -		 * device.
>> -		 */
>> -		if (!iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
>> -			ret =3D opt4060_set_state_common(chip, true, true);
>> -		else
>> -			ret =3D opt4060_set_state_common(chip, continuous_sampling,
>> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continuous_irq);
>> -		iio_device_release_buffer(indio_dev);
>> -	}
>> -	return ret;
>> +
>> +	guard(iio_device_claim)(indio_dev);
>> +
>> +	/*
>> +	 * If we manage to claim buffer mode and we are using our own trigger,
>> +	 * IRQ and sampling must go to or remain continuous.
>> +	 */
>> +	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
>> +		return opt4060_set_state_common(chip, true, true);
>> +
>
> I think that if we are open coding lock(mlock) plus iio_buffer_enabled, t=
hen
> iio_device_claim kind of loses it's real meaning. To me
>
> guard(iio_device_claim)(indio_dev);
>
> it's basically iio_dev_lock

It is! That's why I think if we go down this route we should rename the
API as proposed in [1].

[1] https://lore.kernel.org/linux-iio/DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com/


--=20
 ~ Kurt


