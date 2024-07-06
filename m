Return-Path: <linux-iio+bounces-7388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83649293B2
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF331C21102
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB07137930;
	Sat,  6 Jul 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cx5ydO/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719F135A40;
	Sat,  6 Jul 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720271222; cv=none; b=Zx10/Q1uepCzukfmhikZyCiCLdHFgzTmwjGJOC0aSxwBauM7oLoRmONSo0At4YgQMwMuVksDhiWvqfUBrzuEJEBYDZAKVdyXJdh1HQZUk0rZ9anElCD/huabNwi4HNbp9youZ6CmNo3JQwcgJWSn6J2P2XK5XwXhGQl4BobBymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720271222; c=relaxed/simple;
	bh=LrAtF9S8dBofDJWB2KD8pDGKGOXkjkSRuhluE+pjONU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=POGVW0HPVU2wyvCN5pe8iZKuZUGvH6lBlOn2eKXiEZ68K/iIWdnDMgO4V44GgOecUa9O80elhkrIHJ/5LsOGB0DH+J8HntpCh5jcmNQXHIqifX35y3WlRKZ07F/DA2uL/mZ8FisClQUdIqTLdF4sAppgv1GEAXnLS9pDXZ9apS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cx5ydO/J; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720270585; x=1720875385; i=markus.elfring@web.de;
	bh=14TLodw7s/2J8eZrvZkejp9GR+Ll8ZAolyhN9V2rcuk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cx5ydO/JyEOrQ+dKaa0MhH/jlujkDDZyfn7lo/IeULbwD66UhVSqkl4xTz61Kd3W
	 yWsDmRTfn/kl2i9oyXqKIxut6dNE1nJ/ILZjB+T2XE3+mTcVH5MJtU/eXtB/gyqT7
	 TpzPphE4wv3643uPjd/3OWDlBxCZb48hZut6rmyolM9ssVhvKZFrgy3Ba+hxFKkq4
	 M1quctPC1UZN7ixEl32Oysf1EwzKxBPbl6Q1BaD6Kx7gchyZkfc7hlgafXac7D37/
	 fvlUY/MwY4i4KUl+rjulCEBVHniD4OGonS3FyW1Ti2WN++esXLd3HIHDMhEoKtA79
	 JOG6jp2tbpUDmw3E/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M604f-1sSWjS2X6p-00DwFB; Sat, 06
 Jul 2024 14:56:25 +0200
Message-ID: <4d47b8c3-2f36-4325-b288-0faa40f876eb@web.de>
Date: Sat, 6 Jul 2024 14:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guillaume Stols <gstols@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com>
Subject: Re: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_guard
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqUKgTvEnWS8bI1jYTwGjfK6bBvMbgyGPpRGexeA5u5IuJe9gxD
 dZSBtn2sHFQ3s0jtxY7j+dIiBbOqndp6g+kfgS0H49CoSeJhNS3H0dgkhIgXDpkfGg2L1F/
 n+Oukuz2QaF8XE8Drj4lGgkKaPZTF19jMVFEYzWAThtig8ARBRJlGlFOkCC0HH41bAo4w4Q
 grd512AxW2jWRr45aCUyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1RYAwqcg0ic=;AvT02GhXX9HyeFBkZWOTk9IMVqN
 7HWOggn40I2bqZKyMV20tcgFojyGdpaw+Ycjo+E2hAqA3crje4bIMb/Y0t2UOE+vlrVWJY9q1
 jUHiRP/Pv5t76+V3trzRxETsTEHFXH4RY5Z9TlZhnAi+gO1MMjXU8stCYHoojYeqOxQ2AAXCt
 3+VS+snek2KdaOLGrdLgUYD7/Olzsdrcildsx/GD9K/eh8ZlylUu33Q01JESa4982Z9/nkRT3
 MfnVbDSi29A4XT80HXlqtJ3q2TEZxwOxi/jzYVSdtMoFlbgXgfg81m/t5jAxSL0JpoEKp8BUb
 6yEtPRNKeSH8jRrm42i9C5ZFkO32TdCKeFxE2dNZmNPo/BZF1eSto2dHDyZIgTvPoc0LeUHUY
 bWBlq6HAHFIJeLU1VofvCgq5ABtPCh8WL5VuUf0vDIv0ZVR2yT2u/guLzqS1Qk21sJhZ+3Z3I
 hVVqqVU5Ck8khw2DcJNsUd30wMayaF5BKd7IBEGH/YdG5SaMp6UqaJ1NJHH4YUS4gj5wVDL1m
 Jt8bXcp1VyEVeVlx3HVtAz3Ma+oPyLMR6VZeJGWGXCnyOdA6Bet1t/tricX7lpDsuFmUmI1aP
 iRxH0jS3TAK4eH7MQbL1vyCJ0bIqyYXDHN0ItCip2as55+4dqJVulDPKlUaZwSM7ex5ITOrdH
 iuoGHQiCePyiBn5nh0j1WYRuLy2IjqIDXXro1TpOXfpCcuSuQTap42fzrVO77mjj9vRM3po7V
 untROKfhToPRJe1MOCi+wlRRigpOenLtYxok0Z0iFTUouP94nqFUO8WU0YMGuyXqQUYmsvNjl
 xvnw6qXFiPEuCcLOFdCjAkVnDsvxhesc+2FVH3YjBFtkA=

> Switching to scoped_guard simplifies the code and avoids to take care to
> unlock the mutex in case of premature return.

Can such a change description become more imperative?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n94


=E2=80=A6
> +++ b/drivers/iio/adc/ad7606.c
=E2=80=A6
> @@ -124,19 +122,19 @@ static irqreturn_t ad7606_trigger_handler(int irq,=
 void *p)
=E2=80=A6
>  	ret =3D ad7606_read_samples(st);
> -	if (ret =3D=3D 0)
> -		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> -						   iio_get_time_ns(indio_dev));
> +	if (ret)
> +		goto error_ret;
>
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +					   iio_get_time_ns(indio_dev));
> +error_ret:
>  	iio_trigger_notify_done(indio_dev->trig);
=E2=80=A6

I find that these control flow adjustments do not fit to the changelog.
They can be offered in another update step (on demand), can't they?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n81


There are no scoped_guard() calls performed in your patch.
How do you think about to use a summary phrase like =E2=80=9CSwitch mutex =
calls to mutex guard usage=E2=80=9D?

Regards,
Markus

