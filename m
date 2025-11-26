Return-Path: <linux-iio+bounces-26494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7164C8BE49
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9273A3ABB7D
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E748341069;
	Wed, 26 Nov 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+2v6hwu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D5335555
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764189723; cv=none; b=l6Scf59drlW3UR1sKQqtXafQB9tqq3lRAHQlVVsrogiZjRoDj2+h7ILN2MTz3c2iTZUuipNRSFwiflcceW4qimkZUTRXUnzsVElqJnVRpYtjok2mcsmN1vAFLtSuxeqMZwEg3MazRC19lXguIv6CW6fMaVoP7lyKio8A+Sw0p9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764189723; c=relaxed/simple;
	bh=gPkcXCQlXJNROTcaxmSAMs9kpL1cZWSI3zhIKPHcblo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nsAS4ov9kJHLDYLNFeULz8yG87z5x+fDTYwTASpbrh4REQlekiC2xbEr7+JlIB9LOtdS6yGLQjFX8u3F0kB3F7GWO+s53klT54ij7htKyp/i7pcpvlvZo3+ptr1d9vUR0j5zJJ3D53Hu8UAZhiFMi0J56sGVWAsSI7z1wqEQsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+2v6hwu; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93a9f6efebbso59048241.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 12:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764189721; x=1764794521; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beH/zrD36B/kWUfgdvNXJPmVrJ7wkbiE2Bb6drSFFqk=;
        b=V+2v6hwuCvAzGNmlsdu35q9KVu+fO7ZEvKUiA0sX9H11rGUERa9/UcnBPXzSPVx0Tj
         fK7BH2EWra+AglnzTSjaUbH6l53N36QICw5eOZK7A3KiKk8eRIFYQKS2XddVO+ATbrv5
         UhVvrLYWn91S7I1H9eI4kyGwRmE2IDcY8mhTaKdt8f0pY1ymnhVvOeP6bxewS5W+eJ4E
         yfGkPpz1r96wQmjemm+/5KtEIJDCqFHMadjRlp2JOS8TII5e1trFVffHWmYXC/MNfeh/
         Mp/JkTtwDs3/BxperV3XA+7SanSle7CTTsXHL/Y/Yz//C7xGIDE5nLeOFUV3v/yeuoAI
         e8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764189721; x=1764794521;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beH/zrD36B/kWUfgdvNXJPmVrJ7wkbiE2Bb6drSFFqk=;
        b=iKLA9MIberTFW2f+I7c+R6jqUqIv4vE5HOIjyaCOKpNvFW0q5goT8k0lAR5gGo6wFv
         v5xagc0gnbZv0X7K6IU0XNRMnptBs0QWrv0nb+bOFMW4zT9Mv0Gq2sc8T70eePruEBlT
         LU0uHbOFZMTMYuwOoPGLkOQMzMdeFzHN9n+JGw4tqwrlBiYavHntj4iYjbFIkJ0+k3gQ
         YMStOOQuOR3w2Vk+cjArsSOL2xoaYNxndDcS3HWLLbkf3isvZNX88Yk2h3CVREfrYLL9
         V94S0Ft14c56oDO6i+1u4oe9oXB8Yb5KHg4hotdBtOG8R+srNXbY07xP5AXa6isLd0T3
         NPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOn24SxevFwy1SwC8tIU744JQaDRQVDWUq5LNk6W7JcFWWEm4LMXBsXcB5L3F2CVbbByWrDVS80u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGi5pNn0I0yxWeEVzHPtbaT1cUaGIpkdFbvBxfNcxgdavv0ZgR
	yFMXgRt/Rko8f8qi1imwEkzsUYTLg9CExzq4WbOtWeeUj7PSLtY4vWCk
X-Gm-Gg: ASbGncty0AuPxLyenY/EhmjFPwgNfle6evZFGQe7aapeyzB1DN/jlVnyUcOY+Dptm2m
	3/mP9DPG60orPgffuPsLecPfal8wUxQQN12Oiq61Uda1FD4uI/KhxnT1oqu5Hob4mO2tsCoEGbp
	yIf8WDmK3YQGMl8ZfHtBtLWesmjAAk2HWqOAAyadDXVSZY0KZZVR4DfJpr/MGHAFMc/sogGo6x6
	PD/FbHMkB8Uvx64Lh+8Eg1LKqd659i7bo7KzhhU6gzx2NLBmrs+mQyEAWVAQgdGsBkra/VnJYMQ
	LoB17T4VvdLRysvfdDK7A/fVCaHs7+ljmdjos7vnEorK8jJs579cGRiZljc4O1tbYvP1Wuxb9tz
	+8v3G2/vyW7XfQycQMASuTalipyHB0+/mKQFrx4pK62GInvHnkl836T8aeZh3eN4MTpDl60f2jX
	cRpcPVSw==
X-Google-Smtp-Source: AGHT+IEepyxYSNYcT/rKhpiKM0CVI2kOD4MeYpfdJ9GWVSarvSkIZ5eJZUWsGFJcQABPF4R4jt7LSA==
X-Received: by 2002:a05:6102:598e:b0:5db:f031:84ce with SMTP id ada2fe7eead31-5e1de35f809mr7277275137.29.1764189720757;
        Wed, 26 Nov 2025 12:42:00 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c564c83f5sm8642800241.11.2025.11.26.12.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 12:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 15:41:58 -0500
Message-Id: <DEIX2829UYMB.8D3TGUFHXS10@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/2] iio: adc: Add ti-ads1x18 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-2-86db080fc9a4@gmail.com>
 <30a7e100-5919-4b5f-86cc-589283acd6cc@baylibre.com>
 <DEESNJT0ZQC0.39LYY6I1KWZ7E@gmail.com>
 <9fba8701-a9c2-45b4-9bc1-5c49813e72cc@baylibre.com>
In-Reply-To: <9fba8701-a9c2-45b4-9bc1-5c49813e72cc@baylibre.com>

On Sat Nov 22, 2025 at 10:56 AM -05, David Lechner wrote:
> On 11/21/25 6:24 PM, Kurt Borja wrote:
>> On Fri Nov 21, 2025 at 5:33 PM -05, David Lechner wrote:
>>> On 11/21/25 11:16 AM, Kurt Borja wrote:
>>>
>
> ...
>
>>> #define ADS1018_CFG_REG			0x0000
>>=20
>> I didn't define these because ads1118 dumps all registers (2) in each
>> transfer.
>
> Oh, right, there is basically only one register so we don't have to
> address it. :-)
>
>
>>>
>>> It is a bit confusing to have this here rather than in the buffer
>>> enable callback since that is also setting the config that triggers
>>> the first conversion.
>>>
>>> Having the spi_bus_lock() and enable_irq() in the buffer enable
>>> would make more sense to me too.
>>=20
>> This is the approach ad_sigma_delta takes.
>>=20
>
> I did some work on that with that module recently. I would not say that
> it is an ideal reference. IIRC, it still has some race condition with
> enabling/disabling interrupts in some cases. So hopefully we can do bette=
r
> here.

Oh - I meant haveing spi_bus_lock() and enable_irq() in buffer enable is
the approach ad_sigma_delta takes.

I moved them to set_trigger_state() to be able to use other triggers.
Furthermore if interrupts or drdy-gpios are not defined, we don't really
have to take spi_bus_lock() and doing it this way ensures that.

For this reason I would like to keep this for v2 and we can discuss it
further if you disagree.

>
>>>> +
>>>> +static int ads1x18_message_init(struct ads1x18 *ads1x18)
>>>> +{
>>>> +	struct spi_device *spi =3D ads1x18->spi;
>>>> +
>>>> +	/*
>>>> +	 * We need to keep CS asserted to catch "data-ready" interrupts.
>>>> +	 * Otherwise the DOUT/DRDY line enters a Hi-Z state and it can't be
>>>> +	 * driven by the ADC.
>>>> +	 */
>>>> +	ads1x18->xfer.cs_change =3D 1;
>>>
>>> I think this is going to be problematic for reading/writing the configu=
ration
>>> register and for direct reads of a single sample. My suggestion to make=
 a
>>=20
>> Can you elaborate on why it would be problematic?
>
> This transfer is used for all SPI messages. So it means that CS will stil=
l
> be high after every transfer, not just the ones during a buffered read wh=
ere
> it is actually needed.
>
> This would be a problem if there were any other devices on the SPI bus.
> When the controller communicates with the other device, the ADC will
> still be listening and responding because CS is still high.

Thanks for the heads up!

This was a misunderstading on my part, I thought the SPI core would
de-assert CS if another device requested a transfer.

>
>
>>>> +
>>>> +static int ads1x18_channels_init(struct ads1x18 *ads1x18,
>>>> +				 const struct ads1x18_chip_info *info,
>>>> +				 struct iio_chan_spec **cs)
>>>> +{
>>>> +	struct device *dev =3D &ads1x18->spi->dev;
>>>> +	struct iio_chan_spec *channels;
>>>> +	int ret, nchans, index =3D 0;
>>>> +
>>>> +	nchans =3D device_get_named_child_node_count(dev, "channel");
>>>> +	if (!nchans)
>>>> +		return dev_err_probe(dev, -ENODEV,
>>>> +				     "No ADC channels described.\n");
>>>> +
>>>> +	channels =3D devm_kcalloc(dev, nchans + 2, sizeof(*channels), GFP_KE=
RNEL);
>>>> +	if (!channels)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	device_for_each_named_child_node_scoped(dev, child, "channel") {
>>>> +		ret =3D ads1x18_fill_properties(ads1x18, child, &channels[index]);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		channels[index].scan_index =3D index;
>>>> +		ads1x18->bufidx_to_addr[index] =3D channels[index].address;
>>>> +		index++;
>>>> +	}
>>>
>>> There is a small enough number of channels that we shouldn't need any o=
f this.
>>> We can just make an array big enough for all channels in struct ads1x18=
.
>>=20
>> Ack.
>>=20
>> Do you think we should just let every channel be visible in sysfs or
>> should we still control visibility with the channel@[0-7] node?
>
> Yes. It is normal to show all channels. The few exceptions, like multiple=
xed
> chips where there can be 100s or 1000s of possible combinations of differ=
ential
> channels possible. And sometimes for ADCs built into a SoC, we omit the c=
hannels
> that aren't wired up to something.
>
> It makes it much easier to write userspace software though if every insta=
nce
> of the ADC has exactly the same attributes, so I try to advocate for that=
.

Agreed.

>
>
>>>> +	ads1x18->chip_info =3D info;
>>>> +	mutex_init(&ads1x18->msg_lock);
>>>> +	init_completion(&ads1x18->data_ready);
>>>> +	spi_set_drvdata(spi, ads1x18);
>>>
>>> There is no spi_get_drvdata(), so we don't need this.
>>=20
>> I do however use dev_get_drvdata() directly in PM ops.
>>=20
>
> OK, so dev_set_drvdata() would make it symmetric.
>
>
>>>
>>> I think we could simplify this and avoid needing to use pm runtime (and=
 use
>>> even less power!). During probe, put the chip in power down mode. When =
doing
>>> direct reads of a single value, put the chip in single-shot mode. When =
doing
>>> starting a buffered read, put it in continuous mode and when the buffer=
ed read
>>> is stopped, put it back in shutdown mode.
>>=20
>> These chips only have two modes single-shot (low-power) and continuous.
>> Are you suggesting we shut it down using the vdd regulator?
>>=20
>> Either way, can't the system go to sleep while in buffer mode? If that's
>> the case we should still need these handlers.
>>=20
>
> I hope not. I would suspect that most IIO drivers are broken in this
> regard. I've never attempted to try to implement suspend/resume in an
> IIO driver yet because I didn't have an application that required it
> and it would be very difficult to get right without very extensive
> testing.

Then I'll drop it.

Thanks! I will submit v2 soon :)


--=20
 ~ Kurt


