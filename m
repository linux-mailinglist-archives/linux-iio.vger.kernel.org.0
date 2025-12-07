Return-Path: <linux-iio+bounces-26902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297FCAB729
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AF153007D69
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FD2FAC0A;
	Sun,  7 Dec 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDI7AlOG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EE2F9DB1
	for <linux-iio@vger.kernel.org>; Sun,  7 Dec 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123306; cv=none; b=W7gjJhR/aF6Nxe7DOp9twQixxCjMzSBkj0+vm0j0nTFXK9gnyqR7MzJlMs3ViqK7Y6K5UQ0vyA+Wd/MbK/vvt6/CDfETNit4hB3DT77yrJtsXxuMgTc2d5P/nEHvbgVlyTiaRdosXGvGeAGIXjH2vu/j+fFs1nSbNnRmDAtVViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123306; c=relaxed/simple;
	bh=OEhy1mSjNpamFECm1jJtSYsYz8ITe9v3+SeG6L/8GLc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=aGJzBf/EfUmVEmrGmCmGIyvmhiEvtVBX1zgdvQlcOYvQUYO/MlQfuVIZiluxYGIJgkXpK7lCCORT1L3ueYAce15vCm+uB1pBoHJ4DlSdt3asxv7/Yc8h4ATkxHaDJPISk+xx+77hCq4I0EYebarkMHlQnfpK6s1F8/I9DLf1XL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDI7AlOG; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55b6a66f155so1439465e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 07 Dec 2025 08:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765123304; x=1765728104; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0Rw/MbOznktlH2P2DJM5ffLSklgstzEurns4jQ2o0k=;
        b=BDI7AlOGSP6KRr69b/cO0IiB9GIMqgeuWTowOhRYYlZ7d06nXiUzfSHw21FzcD7h/9
         aWsWJCkjnHsMhIhlomjOlsRDlR1My9mXvxFVBT7SFFnw78UFOqfsQbL1BrnlN+bDfagd
         rb+Jzh8uNW21y0IxTa2+6hZ3VPvmbI1CCIpO6FpF/uIV6t3wSuRTD5dSZkFobV2LzIXp
         tljVmElzHsLgKapEAYSgW9fDTvG4v6uqfcoFvHgXDepj+wGdDXMMD3rqAc7w/Ubi5SyB
         P6BVJ4WRco+B/qVK8odmL3DutXPECWb/LWgADVSF6I15q92AP8xLZAKpX/wJnhbti+LQ
         Erlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765123304; x=1765728104;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0Rw/MbOznktlH2P2DJM5ffLSklgstzEurns4jQ2o0k=;
        b=nSFGpfDTJndA0md2O2IezU5JGoykhbHybv6CWpq/T47eT4K4eKa8VFwgkib3mtOJsa
         aEMqKw4C0rXYpVvOYrcS0Krjej/dfrriNBe/uykr+3OFkKEFLVLe1VFSU04X/TiPkzGJ
         KZ83nEVbGIwNxemQax8z8OcMENRbpkDdxGpj4KLpzTuQL0NadH80CiF0WSD8T9QaISQB
         /pcUut77gRtcE6oy1w8OAbSKpqEzb1ta0ciQvVN90pA2J4nhctpPepVe0h2rmwZud9O6
         8SfWRZerq53Np+ZvDZLdr4S2MoqxGh5aFZsNCREwQoRla1H3PLY2TvRB9sefR4dRFz/X
         s6YA==
X-Forwarded-Encrypted: i=1; AJvYcCW2bVVinmT8EPNiCniDYQX4pRi6rz974/eSAc+RrVFJkmKO5+iLP1VxkXGQ1s0HQanYin3zlXdjC2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxNjBzOWeAIG2cd0B/Lp5j9uzLJW90B8WoRh4xEAwrKLjdvRt
	GNPuS0JrdlS7EiUIEARuH40p9PASxiXU36n/0lL1uudN7fkklL8D9b9G
X-Gm-Gg: ASbGnctwBQmz3h1c42OG5FpT2fpjwZ/+Gu9bihjhLBf5bfPPtXyq+neVw6x27cm6MU5
	PI8Fo0wt3/Ez2A6FTFkUWSIzZXEb6WP3gbU00fR7QGqgSELuBQQhYWFMyQwA+TI6OmDCcCpYT07
	biadsiDz1ypZVlg4OwJFiaGfsEHqffu4BbskWQjRDsXL+rVmTFXAjHc6ARZhEjusIgDv8rYuOIW
	UkNbj9WEQQW5X9qFMB3ZFa5ig3ozJ23AXOnRwa1jXikOwMEIF97WoYZklde0cGldFSS4xhz7OPe
	nTZfm65Py1c3nHzAOZf1VDzx+g8pMEHCfi/4M+R9zdj3YSVodO+clAGfl/puKE28W3MsEbR8Wa7
	NEpXxR8kQI8ko+EDjFseJEoATk42x0tBVDiD49EOd0dMhRNtKmn/KjvQ/zQymbUdn6LTwD8Jx68
	+lM28Gp+hDBaH+Vw==
X-Google-Smtp-Source: AGHT+IEd1s2/cdC54zlP5xWA4F3RiMXXRVV/EIR9gDDx714AsiMHtOJsrXsa8/RpUNdA5gxI5H+UCA==
X-Received: by 2002:a05:6122:8b89:b0:55a:63c3:f7a7 with SMTP id 71dfb90a1353d-55e846c912bmr1528578e0c.14.1765123304065;
        Sun, 07 Dec 2025 08:01:44 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55e6c939f4dsm4919019e0c.10.2025.12.07.08.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 08:01:43 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Dec 2025 11:01:41 -0500
Message-Id: <DES3ZMFGDP6A.2LQ1WHH17P7JS@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Tobias Sperling" <tobias.sperling@softing.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com> <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
 <18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>
 <DEN50VFOIB5O.1ENBKI6JQ0ZC@gmail.com>
 <248b009e-0401-4531-b9f0-56771e16bdef@baylibre.com>
 <DENT9F7BM1O3.1XA58W93TC6AQ@gmail.com> <20251206192750.03469a87@jic23-huawei>
In-Reply-To: <20251206192750.03469a87@jic23-huawei>

On Sat Dec 6, 2025 at 2:27 PM -05, Jonathan Cameron wrote:
> On Tue, 02 Dec 2025 09:46:37 -0500
> "Kurt Borja" <kuurtb@gmail.com> wrote:
>
>> On Mon Dec 1, 2025 at 4:53 PM -05, David Lechner wrote:
>> > On 12/1/25 1:47 PM, Kurt Borja wrote: =20
>> >> On Mon Dec 1, 2025 at 11:07 AM -05, David Lechner wrote:
>> >>=20
>> >> ...
>> >>  =20
>> >>>>>> +	if (iio_device_claim_buffer_mode(indio_dev))
>> >>>>>> +		goto out_notify_done;
>> >>>>>> +
>> >>>>>> +	if (iio_trigger_using_own(indio_dev)) {
>> >>>>>> +		disable_irq(ads1018->drdy_irq);
>> >>>>>> +		ret =3D ads1018_read_unlocked(ads1018, &scan.conv, true);
>> >>>>>> +		enable_irq(ads1018->drdy_irq);
>> >>>>>> +	} else {
>> >>>>>> +		ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018=
->rx_buf));
>> >>>>>> +		scan.conv =3D ads1018->rx_buf[0];
>> >>>>>> +	}
>> >>>>>> +
>> >>>>>> +	iio_device_release_buffer_mode(indio_dev);
>> >>>>>> +
>> >>>>>> +	if (ret)
>> >>>>>> +		goto out_notify_done;
>> >>>>>> +
>> >>>>>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf-=
>timestamp);
>> >>>>>> +
>> >>>>>> +out_notify_done:
>> >>>>>> +	iio_trigger_notify_done(ads1018->indio_trig); =20
>> >>>>>
>> >>>>> Jonathan et al., maybe we need an ACQUIRE() class for this? It wil=
l solve
>> >>>>> the conditional scoped guard case, no? =20
>> >>>
>> >>> No, ACQUIRE() is not scoped, just conditional. I don't think it
>> >>> will improve anything here. =20
>> >>=20
>> >> Maybe I'm not understanding the problem fully?
>> >>=20
>> >> I interpreted "ACQUIRE() class" as a general GUARD class, i.e.
>> >> =09
>> >> 	guard(iio_trigger_notify)(indio_dev->trig);
>> >>=20
>> >> This way drivers may use other cleanup.h helpers cleaner, because of =
the
>> >> goto problem?
>> >>=20
>> >> I do think it's a good idea, like a `defer` keyword. But it is a bit
>> >> unorthodox using guard for non locks.
>
> Agreed. This one is weird if called guard().
>
> I'd not be against a defer() if it existed, but my guess is Linus Torvald=
s
> will just say this is too weird and helper function for everything before
> the unconditional cleanup is the way to go.
>
> People did mess around with __free() for cases like this but that is very
> ugly given no 'constructor' occurred so mostly those got rejected I think=
.

Makes sense.

Isn't there a "defer" proposal to the language spec? I think I came
across something like that in the past. I really hope this is the case.

>
>> >>=20
>> >>  =20
>> >
>> > To take a simple example first:
>> >
>> > static int
>> > ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const=
 *chan,
>> > 		 int *val, int *val2, long mask)
>> > {
>> > 	int ret;
>> >
>> > 	if (!iio_device_claim_direct(indio_dev))
>> > 		return -EBUSY;
>> >
>> > 	ret =3D ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
>> >
>> > 	iio_device_release_direct(indio_dev);
>> >
>> > 	return ret;
>> > }
>> >
>> > using ACQUIRE would look like:
>> >
>> > static int
>> > ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const=
 *chan,
>> > 		 int *val, int *val2, long mask)
>> > {
>> > 	int ret;
>> >
>> > 	ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
>> > 	if ((ret =3D ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
>> > 		return ret;
>> >
>> > 	return ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
>> > }
>> >
>> > It makes it quite more verbose IMHO with little benefit (the direct
>> > return is nice, but comes at at an expense of the rest being less
>> > readable). =20
>>=20
>> This is verbose yes, but we could avoid having two functions in the
>> first place and implement everything inside ads1018_read_raw() with
>> ACQUIRE(...) on top.
>
> Agreed - there are places where this makes sense but I'm not keen
> on lots of churn to inject it in places where we already have
> the two function approach.

I agree.

>
>>=20
>> >
>> >
>> >
>> > And when we need it to be scoped, it adds indent and we have to do
>> > some unusual things still to avoid using goto.
>> >
>> > static irqreturn_t ads1018_trigger_handler(int irq, void *p)
>> > {
>> > 	struct iio_poll_func *pf =3D p;
>> > 	struct iio_dev *indio_dev =3D pf->indio_dev;
>> > 	struct ads1018 *ads1018 =3D iio_priv(indio_dev);
>> > 	struct {
>> > 		__be16 conv;
>> > 		aligned_s64 ts;
>> > 	} scan =3D {};
>> > 	int ret;
>> >
>> > 	do {
>> > 		ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
>> > 		if ((ret =3D ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
>> > 			break;
>> >
>> > 		if (iio_trigger_using_own(indio_dev)) {
>> > 			disable_irq(ads1018->drdy_irq);
>> > 			ret =3D ads1018_read_unlocked(ads1018, &scan.conv, true);
>> > 			enable_irq(ads1018->drdy_irq);
>> > 		} else {
>> > 			ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_=
buf));
>> > 			scan.conv =3D ads1018->rx_buf[0];
>> > 		}
>> > 	} while (0); =20
>>=20
>> Here we could use scoped_cond_guard() instead, no?
> Just in case this comes back. Please no! =20
>
> scoped_cond_guard() manages to thoroughly confuse compilers.
> It got so bad when we tried that originally I went back and reverted
> all use of that in IIO.

That's good to know!

>
> Thanks and very wise to not yet use it in here as that discussion
> may take some time given there is naming involved ;)

Glad I can help :)

>
> Jonathan
>

--=20
 ~ Kurt


