Return-Path: <linux-iio+bounces-19221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315EAAAD6AC
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D8546255A
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7892144A8;
	Wed,  7 May 2025 07:00:40 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4716E863
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601240; cv=none; b=UWI+XD6dTha/Rbv5NO/sjIcCTYGZ81BBfcRRWyYlETDnfVtp7OCFzMByqCDPMK52fvC39V4WhmM5k7WZWht7gqA0ZULcBcZwBV8pK9IW6Ux7BpeaSAKgMLHXE0LHlwkAfOLzA5esZAqFapsDuuQN6xqGYrM1xjSVLCQURsD8vyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601240; c=relaxed/simple;
	bh=iqeAMUETe8lP7uoHYOGKtQHS1AVSzKUx4h6sXRPHZus=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E+0yiBuxgzh8yKgeeuNI+NNgjYrvLvj08J8xGoJDqOOYeIivYtR+oJo2/ocfsGqoR16LVgUs+KqeBC8HXBW/UbU6B7J69a1grz1Qulsu7R4f3Ov0rOJWdaEQzhrWzQJpbxHTErO9otyXfRE2fGyZfNlpV3hDsDt5d6ocTReMwhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jic23.retrosnub.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jic23.retrosnub.co.uk
Received: by mailhub-hex-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <jic23@jic23.retrosnub.co.uk>)
	id 1uCYNP-004TI3-9G; Wed, 07 May 2025 07:35:31 +0100
Date: Wed, 07 May 2025 07:35:27 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Dan Carpenter <dan.carpenter@linaro.org>,
 David Lechner <dlechner@baylibre.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
User-Agent: K-9 Mail for Android
In-Reply-To: <aBpWXB8c8RSjYBtD@stanley.mountain>
References: <aBoBR5D1UMjsSUfZ@stanley.mountain> <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com> <aBpWXB8c8RSjYBtD@stanley.mountain>
Message-ID: <FA0C8BC9-FD7F-44B7-A4A8-EA5E5BC6C8C7@jic23.retrosnub.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BlackCat-Spam-Score: 0



On 6 May 2025 19:35:08 BST, Dan Carpenter <dan=2Ecarpenter@linaro=2Eorg> w=
rote:
>On Tue, May 06, 2025 at 09:25:00AM -0500, David Lechner wrote:
>> On 5/6/25 7:32 AM, Dan Carpenter wrote:
>> > Hello David Lechner,
>> >=20
>> > Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
>> > from Apr 22, 2025 (linux-next), leads to the following Smatch static
>> > checker warning:
>> >=20
>> > 	drivers/iio/pressure/bmp280-core=2Ec:1280 bme280_trigger_handler()
>> > 	warn: check that 'buffer' doesn't leak information (struct has a hol=
e after 'comp_humidity')
>> >=20
>> > drivers/iio/pressure/bmp280-core=2Ec
>> >     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
>> >     1226 {
>> >     1227         struct iio_poll_func *pf =3D p;
>> >     1228         struct iio_dev *indio_dev =3D pf->indio_dev;
>> >     1229         struct bmp280_data *data =3D iio_priv(indio_dev);
>> >     1230         u32 adc_temp, adc_press, adc_humidity;
>> >     1231         s32 t_fine;
>> >     1232         struct {
>> >     1233                 u32 comp_press;
>> >     1234                 s32 comp_temp;
>> >     1235                 u32 comp_humidity;
>> >     1236                 aligned_s64 timestamp;
>> >=20
>> > There is a 4 byte hole between comp_humidity and timestamp=2E
>>=20
>> Yes, this was the intention of this patch=2E
>>=20
>> >=20
>> >     1237         } buffer;
>> >     1238         int ret;
>> >     1239=20
>>=20
>> =2E=2E=2E
>>=20
>> >     1279=20
>> > --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, size=
of(buffer),
>> >                                                         ^^^^^^^^^^^^^=
^^^^^^^^^^
>> > So I believe it leads to an information leaks here=2E
>>=20
>> Aha, so we should e=2Eg=2E do memset() to fill the hole first=2E
>>=20
>
>That works, or you could initialize it with =3D { }=2E

I tried to track this down the other day=2E
What are compilers guaranteeing around
that vs { 0 }  and holes?  The c spec has only recently standardised on { =
}=2E

I'd love to stop using memset for these=2E


J
>
>regards,
>dan carpenter
>
>

