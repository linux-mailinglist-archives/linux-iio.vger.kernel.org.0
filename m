Return-Path: <linux-iio+bounces-26602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE2C98E73
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 20:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F3FE344D85
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D962238159;
	Mon,  1 Dec 2025 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej0KO8hP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C52147F9
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764618426; cv=none; b=dcGO31NhMrZ/K0NqukqEg7cjKxyxvor21b4cTFQEnbU/xsk4jTVqW9kP0AkSp7jNe/c0TWRE77OA9KAtletqQN/2B2Y1su3uLhc8KjYrwtvoipXtFpo+yMD6uPxNPCHWy5FKLFTpQg5YWoE6BktF6AAk7wi6Xn7lM+7rc7GSWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764618426; c=relaxed/simple;
	bh=AkmPPwDEDqiDGbDd/c/qytly3OUEnrFljT7GLyvENCE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ceM68hvrWc53xBmeX8M4otrcUgYHMagQJJPxhQshlQh6p+k8i6sAYlfHgLTOoF2YAeYlZY7LTfXnn37GaZzgMG83ktXsqzyBUXRbs0FyZLONGZvFevupghADAjQlHpcQm+hU9ZwqTos4gC1UnreeHMfiUjRbOYr5hhTcajsnFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej0KO8hP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b302b8369so3069184e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764618423; x=1765223223; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2SwU7brTcuWQXz23QqjJKK8SJFGO+KNOCJ1yJZD+6A=;
        b=ej0KO8hPtkTqRH+ysDp7+saoFGDALE36QnooY0N8DaVCWO2u8adcPG7tfRGDrc6uwh
         ZX54wCvdEleBVE3y55E7edpG/AIP1+6rpwLwSb59Z+pJgQEKzoZo45+jlh+WXZJh+O1l
         IfpEPIegPQ4vzVd4/Obpy6QF7cyZAREui0FrZYjcaEXmd6lom71sMEZ7q9MRx8NYuhEE
         JoJnRCDcqUDCFrScaOGOimiF4CAs3Rfp7Dvx5b5x8XPuAb4N3FhN3ICQCNvjC2MTVZ+A
         9V+9kWRsxxxxGOLO6ZmyBky/OravGaNd0GrgZGAJCGPjgnthCo6ddQNKrFI8b78nnUL3
         Sv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764618423; x=1765223223;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2SwU7brTcuWQXz23QqjJKK8SJFGO+KNOCJ1yJZD+6A=;
        b=uU13KwX0ZBjR/EBTISpkv28HhCUvix/9S4WyDud3jXp8Ui6hoZFHoUgh4gUZtsYnIT
         9W6TD3Ks0okTxPeZlqQEsRQe0IIWrPAFV0BpQwv9LBwvND3hKxJ98bJzuGnvuCJ1rgk1
         VJDkxETpW8oNxm22Us5fKTiAhuUvsyg4liJNXkR81MNhUU/YjAdU+ZPK8Puo6t5WcExl
         /AA5Jg4Oelw42GlGRhMu++h26yn3f6EUHvt6KLWDqxLXmg/JukHue4qausg8XofxiRdk
         ycExt2ItZd6FN8gyYtS8tyaEGSrroik8L+zkYORCPGlV1mcMxAhFc+pAgHUpFvMei+jZ
         DltA==
X-Forwarded-Encrypted: i=1; AJvYcCXGKwABqHQP9jeB5VmKNrPOyU32HhQZgd8T+OkEenTpZBgKNGAf4PVTE+YiDqWn0Q4aLDMU2OF9gT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyNRbfDtLaSFaSJBUHY1no4q4mxHn8u66r+j41Lt2TQhuEIXlk
	ygCaYsXAOZvH92vrM3WgumomKJaGh5FlI+lqk0NvFo0zc42oa5azNMc/
X-Gm-Gg: ASbGnctvSn2DxITpMqzR5W70bd10fSCrd914MD7y+q6MIeG4OFcHqAn7uQO3LyMa048
	8A2eBlLFLcO9bLKxvpNlQItIy7zo7A1oHmCsjzsvfzSOl1oeLFDrjQiTH/nmSxINlYLA8VQDBAc
	RlV1nwr7UE2Z5rBSmhFIfPmFtNTbDDl2cRRgDe4MFtjC01GipDQzBnC3Rbg82JGzq0naO0Kd8Rg
	zRzSvXW3d0dC18R3owGzw+n7FN2VU/OLq+W8X8CN0sFWWZBUXs2QhhO8T86/vaSpVizL5U6cdUf
	Aoa42fS6TUZ6g/Brvc+FuRyPlcha4q/SnYY4xIUgIRJE+zyCv9FTGReabKHIcc6B5ynf68x0LH2
	6CPlY6fHXZfZQX0niArQlTOeDVGpIzLmlCxufR/UrhsYtVT6RiDfePbmW74ny+aHDlZlvF0TBes
	NwCdsgkkFCwoWvqbDw
X-Google-Smtp-Source: AGHT+IFtbwHx7ggOA0nfUhQeEEf9VEJmcC81IM6QKOuFmoRpxOaWAK4K1w+iiLeaHDL2epZXSr5uUw==
X-Received: by 2002:a05:6122:1796:b0:557:ddc4:dea4 with SMTP id 71dfb90a1353d-55cd764c2d1mr10337077e0c.5.1764618423379;
        Mon, 01 Dec 2025 11:47:03 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf5186d0csm5633068e0c.20.2025.12.01.11.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 11:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Dec 2025 14:47:01 -0500
Message-Id: <DEN50VFOIB5O.1ENBKI6JQ0ZC@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Tobias Sperling" <tobias.sperling@softing.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Andy Shevchenko" <andriy.shevchenko@intel.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <aSsBdJZDWcadxEHC@smile.fi.intel.com>
 <DELPNLNPGQSM.1YDTB81AG0RAY@gmail.com>
 <18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>
In-Reply-To: <18fbf486-c1cc-4cd2-af12-ffa093fa9ce7@baylibre.com>

On Mon Dec 1, 2025 at 11:07 AM -05, David Lechner wrote:

...

>>>> +	if (iio_device_claim_buffer_mode(indio_dev))
>>>> +		goto out_notify_done;
>>>> +
>>>> +	if (iio_trigger_using_own(indio_dev)) {
>>>> +		disable_irq(ads1018->drdy_irq);
>>>> +		ret =3D ads1018_read_unlocked(ads1018, &scan.conv, true);
>>>> +		enable_irq(ads1018->drdy_irq);
>>>> +	} else {
>>>> +		ret =3D spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_=
buf));
>>>> +		scan.conv =3D ads1018->rx_buf[0];
>>>> +	}
>>>> +
>>>> +	iio_device_release_buffer_mode(indio_dev);
>>>> +
>>>> +	if (ret)
>>>> +		goto out_notify_done;
>>>> +
>>>> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->time=
stamp);
>>>> +
>>>> +out_notify_done:
>>>> +	iio_trigger_notify_done(ads1018->indio_trig);
>>>
>>> Jonathan et al., maybe we need an ACQUIRE() class for this? It will sol=
ve
>>> the conditional scoped guard case, no?
>
> No, ACQUIRE() is not scoped, just conditional. I don't think it
> will improve anything here.

Maybe I'm not understanding the problem fully?

I interpreted "ACQUIRE() class" as a general GUARD class, i.e.
=09
	guard(iio_trigger_notify)(indio_dev->trig);

This way drivers may use other cleanup.h helpers cleaner, because of the
goto problem?

I do think it's a good idea, like a `defer` keyword. But it is a bit
unorthodox using guard for non locks.


--=20
 ~ Kurt


