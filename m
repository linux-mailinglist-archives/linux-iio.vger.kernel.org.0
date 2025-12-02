Return-Path: <linux-iio+bounces-26631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B61C9BD73
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 15:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7795A3A7C76
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 14:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BFE1EDA3C;
	Tue,  2 Dec 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJjtyn7i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8518C933
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686803; cv=none; b=CsU/Q6iR/UKVqev5zKzTdbBboK9ZMssGILLZIdVyLIFdePprYu03mG54uNy8ADuAwm77gce8XMuPnVfTrTdnRow6D689ngQFzuoWyK+6t64A5h/o78KFmHpLMAL8WHA6Nb544sMFAtK5pFMXVQVLfBB259eh7pdu1SzNjaBABT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686803; c=relaxed/simple;
	bh=MoS7F23fetzjMdg5mb8OfGPgJPbLAfpu6CaMEvPxbyw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=eVhnTcWven8zuzFRfWXuWE5Y3dMj4+uKh5/zoySMSaGO5YtacuX00ei0h+Yn5DyoAWZI+O3XiTze9GEOov2AyQKv7xdbZA2dg2ReNIWVRQ0P6t9ccZFzDCdKmw3Up8R0/DW/exr92ekVP1Y+3EK1EM/fodLGZUy62kbaNWQu4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJjtyn7i; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dd6fbe50c0so2292335137.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764686800; x=1765291600; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DY7E3WB0ICOl9V1+gQL7qAH+nekudiHdVslHe/Z11Y=;
        b=hJjtyn7ibgr/tPL4uemKfTtNOgaKZyzYDpQk8XlaNNTI9VYl3yvr6YGsuRKMWXyGCO
         3cboKCZr9ZpYyMvdPUsFVREMHnCCV9JXkIJwcLcKdhRyyjx9Nu/k09Sk93aRQ0OR0cz3
         DKkN7efd4+C4kP7rCrjz24dTerBY0rtmMYoqnxAj1zJ1wBwzK6yv5hgvs0xSjywuQWlt
         Q69j2qDKLiaipIBUMMZvFOvgGX26BB9b4q9qsFWxgwlMKw32hrB3QPl/U0O+TzVJtz/L
         Bed+CegQaPHPWs4Xe8T7Vmmaljgt+AA0x6Jj9qB1BBGhnevVSp3xZ0aJWKLRXEzUum2W
         CRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764686800; x=1765291600;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DY7E3WB0ICOl9V1+gQL7qAH+nekudiHdVslHe/Z11Y=;
        b=wq4ChW+eYQcVAKzoHDshTnx0Esf8XdDIKoxYUn2pafhN/ToI+sq5cCGEEsUcUEukbc
         2oU7GAdKoR+iXtFtMcg27heWVnlJyEl37zWJtYZS/j/8joHg9iBav6KW4iAaRVTTy8m7
         NZv8REUoFIY3X5dHkth/HBM9prAg2/hr1v8KqXB0pVKC3VTphLKVbS5mPcWKqzvSmakZ
         6QG1Hy2Pl8+YhQGdqTrp5v6zlo3/wlBVVmvsEYN+pS9Kkg+yvTRyeQeAsQ3T+6KOHFMS
         jabvW4S/n+1Mmzsmm8MK/l9TBzlBTHODJOe4xX4u7DjPAOnTcAIKLKG+Ppwv86Tg09Ot
         ebJw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ599m/I24VBibXNrK3MgzeahOTUWB0cS8MdcQOiJQSari9YA7lJL/AEwaO8bMt0depEl5BnqgRBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+SGk71wNPOxukoDVSWvUf8Y5VR/FP2fDo3w2abpjAS4Lnm2b
	Jc9dc40wERUChDZhGVcJDw8Ofk2MFLt5xKhkr9rou3vO6HObwLBgI9x3
X-Gm-Gg: ASbGncs6c+8HrRQqbDALUbUUK+HkkvdePyMr+rhlZwxeLo+FJ8jBTUnZBIzaMBBxXX8
	UKec3vnzB5vTwCzQx6wvMXSeZYyUbiu8pN+edpy40zR6gDUmMVbDaPLVRVzTMhM+8qU2qVwadJj
	7uX1qDRJ+Bvz+USiy5I0T9LtyoF+wfT5WzyVHWmHIkvxBFYpE0YgSfNKb+44nzSMQFwW32uGzv1
	l1Rb8H6RwMEvsr/X0ZW47MFjwZqDjM9hhB47tEH25lTGXnFvvky8WBfJ1bH0cJFYIs9rkkw4clY
	AiZEozq11ktwQ+/aOemnO3wnV9DvXptDy5xsu96AS1LMM0COgrV6hZ6Udol1yQH3f/lOQiG/ogf
	QuB4QZCtRESreGRK6w5sIPzfNEP9VnMe0we2GMlyNFPKM+rqJmbz/hsbSOo8QOgpNVWTXpMPLti
	BQMps=
X-Google-Smtp-Source: AGHT+IEzulod+TcRd82XYq5299hF3YYW0eriJP67UXNInTYJ+ZnrHWKSPy0cJtoLv0clmyFSXlS9Ew==
X-Received: by 2002:a05:6102:4a94:b0:5db:d60a:6b24 with SMTP id ada2fe7eead31-5e1de342e84mr15526327137.22.1764686800032;
        Tue, 02 Dec 2025 06:46:40 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd7661ae8sm6582676241.12.2025.12.02.06.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:46:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 09:46:37 -0500
Message-Id: <DENT9F7BM1O3.1XA58W93TC6AQ@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Tobias Sperling" <tobias.sperling@softing.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com>
 <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
 <18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>
 <DEN50VFOIB5O.1ENBKI6JQ0ZC@gmail.com>
 <248b009e-0401-4531-b9f0-56771e16bdef@baylibre.com>
In-Reply-To: <248b009e-0401-4531-b9f0-56771e16bdef@baylibre.com>

On Mon Dec 1, 2025 at 4:53 PM -05, David Lechner wrote:
> On 12/1/25 1:47 PM, Kurt Borja wrote:
>> On Mon Dec 1, 2025 at 11:07 AM -05, David Lechner wrote:
>>=20
>> ...
>>=20
>>>>>> +	if (iio_device_claim_buffer_mode(indio_dev))
>>>>>> +		goto out_notify_done;
>>>>>> +
>>>>>> +	if (iio_trigger_using_own(indio_dev)) {
>>>>>> +		disable_irq(ads1018->drdy_irq);
>>>>>> +		ret =3D ads1018_read_unlocked(ads1018, &scan.conv, true);
>>>>>> +		enable_irq(ads1018->drdy_irq);
>>>>>> +	} else {
>>>>>> +		ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->r=
x_buf));
>>>>>> +		scan.conv =3D ads1018->rx_buf[0];
>>>>>> +	}
>>>>>> +
>>>>>> +	iio_device_release_buffer_mode(indio_dev);
>>>>>> +
>>>>>> +	if (ret)
>>>>>> +		goto out_notify_done;
>>>>>> +
>>>>>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->ti=
mestamp);
>>>>>> +
>>>>>> +out_notify_done:
>>>>>> +	iio_trigger_notify_done(ads1018->indio_trig);
>>>>>
>>>>> Jonathan et al., maybe we need an ACQUIRE() class for this? It will s=
olve
>>>>> the conditional scoped guard case, no?
>>>
>>> No, ACQUIRE() is not scoped, just conditional. I don't think it
>>> will improve anything here.
>>=20
>> Maybe I'm not understanding the problem fully?
>>=20
>> I interpreted "ACQUIRE() class" as a general GUARD class, i.e.
>> =09
>> 	guard(iio_trigger_notify)(indio_dev->trig);
>>=20
>> This way drivers may use other cleanup.h helpers cleaner, because of the
>> goto problem?
>>=20
>> I do think it's a good idea, like a `defer` keyword. But it is a bit
>> unorthodox using guard for non locks.
>>=20
>>=20
>
> To take a simple example first:
>
> static int
> ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *c=
han,
> 		 int *val, int *val2, long mask)
> {
> 	int ret;
>
> 	if (!iio_device_claim_direct(indio_dev))
> 		return -EBUSY;
>
> 	ret =3D ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
>
> 	iio_device_release_direct(indio_dev);
>
> 	return ret;
> }
>
> using ACQUIRE would look like:
>
> static int
> ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *c=
han,
> 		 int *val, int *val2, long mask)
> {
> 	int ret;
>
> 	ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
> 	if ((ret =3D ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
> 		return ret;
>
> 	return ads1018_read_raw_unlocked(indio_dev, chan, val, val2, mask);
> }
>
> It makes it quite more verbose IMHO with little benefit (the direct
> return is nice, but comes at at an expense of the rest being less
> readable).

This is verbose yes, but we could avoid having two functions in the
first place and implement everything inside ads1018_read_raw() with
ACQUIRE(...) on top.

>
>
>
> And when we need it to be scoped, it adds indent and we have to do
> some unusual things still to avoid using goto.
>
> static irqreturn_t ads1018_trigger_handler(int irq, void *p)
> {
> 	struct iio_poll_func *pf =3D p;
> 	struct iio_dev *indio_dev =3D pf->indio_dev;
> 	struct ads1018 *ads1018 =3D iio_priv(indio_dev);
> 	struct {
> 		__be16 conv;
> 		aligned_s64 ts;
> 	} scan =3D {};
> 	int ret;
>
> 	do {
> 		ACQUIRE(iio_device_claim_direct_mode, claim)(indio_dev);
> 		if ((ret =3D ACQUIRE_ERR(iio_device_claim_direct_mode, &claim)))
> 			break;
>
> 		if (iio_trigger_using_own(indio_dev)) {
> 			disable_irq(ads1018->drdy_irq);
> 			ret =3D ads1018_read_unlocked(ads1018, &scan.conv, true);
> 			enable_irq(ads1018->drdy_irq);
> 		} else {
> 			ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf=
));
> 			scan.conv =3D ads1018->rx_buf[0];
> 		}
> 	} while (0);

Here we could use scoped_cond_guard() instead, no?

>
> 	if (!ret)
> 		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timesta=
mp);
>
> 	iio_trigger_notify_done(ads1018->indio_trig);
>
> 	return IRQ_HANDLED;
> }
>
> So unless Jonathan says this is what he wants, I would avoid it.

I will submit this as a separate RFC patch. We can continue the
discussion there to avoid delaying this series.


--=20
 ~ Kurt


