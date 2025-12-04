Return-Path: <linux-iio+bounces-26753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4317CA4BD0
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A52133005C73
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23A2E8B6C;
	Thu,  4 Dec 2025 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSWbWoQM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B5C2DEA98
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868996; cv=none; b=DiqHdipx8OKF9s5D/RFopRowJm4pf3W2oPZh8MVcSzoTb6CBoMniM311GGaWh4KcEaOpXcSXomogBquWjznXK/V7LqbRjGFEpDssTqOu3YSwuHKlIMX3CMrSojDeJ2qx5EViqM5WUSd2qrKUi+q2Eg/lVlyQj62HSbvVOboBY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868996; c=relaxed/simple;
	bh=q5xXqvxWQqE1gpmDE7Px8HbivMv1gX/ZhfdYvrsTBM8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=dmbJYO26aKXFufNs2/ias2tPciF5YtWLm0DDzWoJ4ZMRcztmXw8yrl6//h32KpuRf93LHHs7aTv6CQ9PgMVH/IWr4dTpD9jleXa0jlj5Ir7scBfYGRrJmCa+0bf/LXAF6qIOF8q+jShcJbO+snzb4ZL5miEv+4FgWW7lFXazuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSWbWoQM; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c0cf4abso1309534d50.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868993; x=1765473793; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAM4QJRL7TLUdIu3CrX2GWOT5QNBVQH+Lm0teXvJT5Y=;
        b=PSWbWoQM6ZGbzKBVnHY9of30nJVBXGxtGiSL82BiL8UyK8fj1YYaq7Z9rOAeBa1VDL
         c+ku1PBjZ7SIR0g1ZkDYFU0MefjqMQ9aatvva681DUlHiD3uUvHIif9gdONR17rq5GlA
         fxMRaHPYngJGHMtNJLe6d4D7BBK+xY9l+CtsX4m5YFW6hZXoy3j+qhhLv1Djqd+aEXaO
         YVA4y26F7HNy7vMbrzMEjAK4yrpX9O+Gw3zBqfGNpClyRAXIrH8LeandW4PoXOODeApx
         KmUMeel9xhJQNWyfkKAAvure8GvjmgmRSE46GqT37TRZkXz7WwQh5K2gj2+IyRe72eIG
         tQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868993; x=1765473793;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aAM4QJRL7TLUdIu3CrX2GWOT5QNBVQH+Lm0teXvJT5Y=;
        b=YOrxhpPRYb05vSLtzpTwaxhz6WVNhNbFZzXotYxkFZFEiw/HmLwyzN3M/1GhqOUO7I
         rnabbv7FuVaQL0ThhYskvL/j+6tOYHXuD5nKTvXOQvw+kvkoaI5D1xZ3HizeQRC4UvXU
         unDQLaJuU3DfwuMlyZJLfFlzJAE4DlmsgMUdXPzs1KBd9lFSzxNEwjV9hWBPw6U6xHpw
         JQ6hJdHg00bEb6BUUZt3fRX97sUuCe6XPMEK77mop7smfzZDcm907j7nsy30k1227fKD
         Sgc2eYh3Z/aEPjcVjWwXiyorR5lTp0q5638L42oItIOuuV62xZx7DfYywu7K8gsbN1vB
         vH0A==
X-Forwarded-Encrypted: i=1; AJvYcCX0jBmsq+69sfnpEsJ4LbVOrE+vjb0H306gkMRNNGZwfFCVqKe4HdNfwnpq7aErBBAibsw2UaDMXCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QJOzvaFOsHzOGJ5/GrR/PbapW12Hoyx7sE/rXl9iv3ynnQ+L
	WwKmA/OTUm6qVWA3mPshtrUoSuRIVbnENkCn+grPt6VQwSz2r+G4692q
X-Gm-Gg: ASbGncudBHmlqPACrtIKYJ9jNH68aqcdFfxCXGUk8/7ouwP60Q93z2zSlu9UGLaqQu/
	Gc6ffmhQpqs8v/60WpGo1yC3jN4oDulclUFP9BwCPfpGFRebTqUX5gaChA2merfvdUHCrFxvaYH
	db+wd7TNK/tuvlZ0En+m/a1xEv3nCpW5v+f1QvDbRxcuuraFijR3TQNQGh7wfaeAQbmknSGNAS1
	vfwgSoS8ymHS92V1QGk+6MHsZx+QPM2uBb3tw+OqNVHdPtsQGMzD8TZHiNux2kyVsxG2o5/trIs
	c5GGhvRbqK9Emggq/X31BQpPpaRDQptO/a2RmpzALn4PFM6boIAu4Sm8YuTePYEB7JFdFymBtyV
	pIEYLetRUX2AwZk3GLSP31l7teeXCUWJUH7hE0Y79Bnh0lVdZgwAYhQKn2rUQDC9cnqwIiwO8AE
	cXLe+pPg==
X-Google-Smtp-Source: AGHT+IFjOCZVb+IDWIdHcYiF8fqeYL7n7SjobQErooIIfcbkYO12iyruJ5YzoluNctdStUMxNHUQDQ==
X-Received: by 2002:a05:690e:4007:b0:63f:b26a:225d with SMTP id 956f58d0204a3-64436fafd69mr5532629d50.14.1764868993293;
        Thu, 04 Dec 2025 09:23:13 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b7a72dcsm7386587b3.52.2025.12.04.09.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:23:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 12:23:10 -0500
Message-Id: <DEPLUDI44VU0.3CMJ0YOFXZOBR@gmail.com>
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
Subject: Re: [PATCH RFC 6/6] iio: light: opt4060: Use cleanup.h for IIO
 locks
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-6-b4a1fd639423@gmail.com>
 <e1048329-83d7-4947-a57f-afdf75fb1e1f@baylibre.com>
In-Reply-To: <e1048329-83d7-4947-a57f-afdf75fb1e1f@baylibre.com>

On Wed Dec 3, 2025 at 5:40 PM -05, David Lechner wrote:
> On 12/3/25 1:18 PM, Kurt Borja wrote:
>> Simplify and drop "hacky" busy-waiting code in
>> opt4060_set_driver_state() by using guard().
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/iio/light/opt4060.c | 52 +++++++++++++++-----------------------=
-------
>>  1 file changed, 17 insertions(+), 35 deletions(-)
>>=20
>> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
>> index 500899d7bd62..903963606143 100644
>> --- a/drivers/iio/light/opt4060.c
>> +++ b/drivers/iio/light/opt4060.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/iio/trigger.h>
>>  #include <linux/iio/trigger_consumer.h>
>>  #include <linux/iio/triggered_buffer.h>
>> +#include <linux/cleanup.h>
>> =20
>>  /* OPT4060 register set */
>>  #define OPT4060_RED_MSB				0x00
>> @@ -302,41 +303,22 @@ static int opt4060_set_driver_state(struct iio_dev=
 *indio_dev,
>>  				    bool continuous_irq)
>>  {
>>  	struct opt4060_chip *chip =3D iio_priv(indio_dev);
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
>> -					       continuous_irq);
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
>> -						       continuous_irq);
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
>
> The commit message does not explain why this was changed from
> iio_trigger_validate_own_device() to iio_trigger_using_own(). I'm guessin=
g
> that is why we also dropped the `!`?

Hmm I just assumed this functions were equivalent, but looking at the
code is not directly obvious.

I will look into it and mention this in the commit message.


--=20
 ~ Kurt


