Return-Path: <linux-iio+bounces-13467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 300E49F1FB1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 16:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA5018864A4
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B6C195FE3;
	Sat, 14 Dec 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjZ6BdjX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DA19580F;
	Sat, 14 Dec 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189881; cv=none; b=NBKJS4yLJxiIvwGnPfBIE45yJ25H3AAXIFMwzCE9Ai65cVgCwc96Q9pUHp/juQieIUGZO0fKsjzeJ5daZj5CVuwPnlkNltEQ1QeyoCFgtuke9/ls1ysRm8t8nm9j9c3TDcLWwceXf1CA8VTUXwJAsTOPn+gljANkpGuIQ3GMX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189881; c=relaxed/simple;
	bh=49EDXTKQ1i+wLE7y5mDs8unPY13DXvpWV0ecuv5j8rk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Y7WpLlnhW4wLMhtGgR/aKVJOygBbdBHBur6odZ/T8E6WYWeXf+k+3r9hADF3gRRCTGYUJLHJLpbQECEbDpxKxIUsPNmm9lx6EQOwk+YiZ9JMiObSCb+lrTne7+jjcTsMQmOqj4nngScIcxofICjZATLkvjY1Ujz9U9Viu0ILzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjZ6BdjX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd730so19274115e9.2;
        Sat, 14 Dec 2024 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734189878; x=1734794678; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKfoAFcF04yRARGS3xwHONhGEXP+gEiLX5MieeflBec=;
        b=YjZ6BdjXtmvLrSDSQWEiOmdWyBICCJlaGePUrJcqZALMjgQAqMsUjLCCPmxUerBmW0
         OttAPL+j7zAaITUaZKfso6ep/FD/cn+3TPbBoikEoFn5SiBy2lgKTKeym9hF7lScUU+j
         FR13AYKB24vyzpcTKZrvsYDDqQzte2VEl7d9e3LvI+jMPCoib0210U69kHF7Au7DWRxF
         +jYyrHSXaQbwoLYaUsx02+Cqz9wrOhAKDErvtSp1c53jnGTOMVw3sLI0x8wFo2b5vZMB
         ao7ZU86gltP59JTDa9hcrdLjpmzPseXLjSGVp7YkY3xOga1KMmtcBU2nFzmhWP2soo/u
         7T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734189878; x=1734794678;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HKfoAFcF04yRARGS3xwHONhGEXP+gEiLX5MieeflBec=;
        b=AGZp/so1nuvKQy1bMcskG4P0aFiFPbPleQHH7iI1Gjj3T5tH9rl+yY86HmSYf6P/3z
         vIPLctaw3uQgQbVo1mD3n4IJa+6ffNnk0iwhsgnwKRhPr0geUsvDmBL4AzYAR1bwP0NR
         VfSZDs/16Yq1R1egwsVHKxiqs/aU0YX7F/kFQtfVBaOjGQaWtcp6gv3A4xf3RipEC7Xc
         ycBKr4Ya+fImfM0xZeIiLEaSqGXSGHkBcX3ZkTnSyCEWAae6fL7aBN/03nYvCq1xPN+R
         01SZrTEApQsRC5nz4gfo+ZnaFRLl3wzytf0BsWSErICwu2qpIlPgvRxfRfnvwwmNc43m
         jqfw==
X-Forwarded-Encrypted: i=1; AJvYcCUoL8hbhi/JIKXH8qGJH0bkTLjScAvmtfniPVPQFVTVpX0WMKZvqp4G/f6mvzxD8yQQ2JG7eJKq4+KJ@vger.kernel.org, AJvYcCVR4R5bPg1VAN+As8rPWIs6hDf6LKJ2Nngb8nn6w/IlSaTOsMTsJSohZUxmlIInN5wZv1sGbbyaEHmsYXDw@vger.kernel.org, AJvYcCVYBOrBlJRYCDz8qwU7H7PSaSPmw1dnCToU3j/7fPVhxwh3j7Qnom5xyHHPpcGD2506RcxiTL0NONQF@vger.kernel.org
X-Gm-Message-State: AOJu0YzChR4Fhsnb2SFJQUcKzBEKuBQPismAJRhgZfGIOj3eIwjiMjv5
	ABtgtWPafNopnzkwKvRY+0J5H9MI9ax6jbj4bKxq9XfMD38JWKH0cn8HWw==
X-Gm-Gg: ASbGncvrFKbSStc792bmeeR8tQsu73rkyRK1Qo9KO+z2D16TGvYDPSWDF96UYJojX/6
	SHu60pV06dPAZsVj4qwFfy5aZrcB8pA730QqZNBM7QzRtiREweuOslRa6w6UVAV9TIPFwvA6+iI
	dOkRRxvASoj4LBI/Te+eM/FGsD1+S0q5P/9l0ibI2FCXUYYYHrKAv3g0E3JkQgDjzvFe+kvbgMe
	5DmN8UlXptodFFtcpeIKSinTXvQQn9o3p4KtPhvmVdn9MzXNAPnYLyu3G8OSPi8dHeUi6E4aVZb
	2YxUUkwpze0N+t0Q+/X1W+AtdZLWciBnjuN0h1/kUf820QZjsZKeW3sID2uViLq31Lc8mwUILTw
	a
X-Google-Smtp-Source: AGHT+IHFNxgLDoMYeLM2B1ZNg3KggxOqQSZnUBH3MKiNjTYOlJ0/dcxnkeOdbdE173hsFInieHPdZQ==
X-Received: by 2002:a05:600c:1c07:b0:434:9fac:b158 with SMTP id 5b1f17b1804b1-4362aa34e8amr52214565e9.1.1734189878019;
        Sat, 14 Dec 2024 07:24:38 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-330f-5008-acc6-6cc2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:330f:5008:acc6:6cc2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ef45sm82237365e9.26.2024.12.14.07.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 07:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Dec 2024 16:24:34 +0100
Message-Id: <D6BJ0676105O.3LEEDK2CY9DHR@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Rishi Gupta" <gupt21@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: add support for veml3235
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>
X-Mailer: aerc 0.18.2
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
 <20241020-veml3235-v2-2-4bc7cfad7e0b@gmail.com>
 <20241021193933.59c2d2b6@jic23-huawei>
 <7323ca4f-2f79-4478-b2b0-2cfc350af7f8@gmail.com>
 <20241022192807.2f83dfa1@jic23-huawei>
 <3af77b51-d254-4c97-8faf-1dea29a4f9b1@gmail.com>
In-Reply-To: <3af77b51-d254-4c97-8faf-1dea29a4f9b1@gmail.com>

On Thu Nov 28, 2024 at 1:26 PM CET, Javier Carrasco wrote:
> On 22/10/2024 20:28, Jonathan Cameron wrote:
> > On Mon, 21 Oct 2024 22:21:22 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >
> >> On 21/10/2024 20:39, Jonathan Cameron wrote:
> >>> On Sun, 20 Oct 2024 21:12:17 +0200
> >>> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >>>
> >>>> The Vishay veml3235 is a low-power ambient light sensor with I2C
> >>>> interface. It provides a minimum detectable intensity of
> >>>> 0.0021 lx/cnt, configurable integration time and gain, and an additi=
onal
> >>>> white channel to distinguish between different light sources.
> >>>>
> >>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >>> Hi Javier,
> >>>
> >>> I missed one thing on previous review...
> >>> There is no obvious reason this driver needs to provide raw and proce=
ssed
> >>> values.  Unless I'm missing something, just provide raw and let users=
pace
> >>> do the maths for us.
> >>>
> >>> Jonathan
> >>>
> >> Sure, I will drop that for v3. I added it because this driver took the
> >> veml6030 as a reference, and that driver provides the processed value.=
 I
> >> guess that the veml6030 should have not provided processed values
> >> either, but it's late to remove them after the driver was released.
> >>
> >> Now that we are at it, what is the rule (of thumb?) to provide process=
ed
> >> values? Those that can't be obtained from the raw data and simple
> >> operations with the scale/offset/integration time/whatever userspace c=
an
> >> see?
> >
> > Yes. If the conversion is linear, then leave it to userspace (with scal=
e
> > and offset provided). If it's not linear then in kernel because current=
ly
> > we have no other choice.
> >
> > There are some historical quirks where a processed only interface got i=
n
> > then we had to add raw later (typically when we added buffered output
> > where scale and offset are important because processed values normally
> > don't pack well).
> >
> > Jonathan
> >
> >
>
> Hi Jonathan, I am bringing this back because I am not sure if dropping
> the processed values was the right approach here. I would like to
> clarify before propagating some approach that might not be accurate.
>
> This sensor is linear, and the processed value can be obtained by simple
> multiplications, but not just raw * scale as documented in the ABI.
>
> This driver is based on the veml6030, whose processed value is obtained
> as raw * resolution, where the resolution is completely linear and is
> obtained as sensor_resolution * integration_time / scale.
>
> That means that the scale is actually a gain, and the user needs to know
> the sensor resolution provided in the datasheet (see cur_resolution in
> veml6030.c) to get the processed value. There is a sensor resolution for
> every pair { gain, integration_time } in the datasheet, so there is no
> need to calculate anything, yet the resolution is not provided by the
> driver.
>
> Nevertheless, your comment on this matter was the following:
>
> > Why both raw + scale and processed?
> >
> > We normally only provide raw and processed for light sensors if:
> > 1) The conversion is non linear and hard to reverse.
> > 2) There are events that are thresholds on the raw value.
> >
> > Here it is linear so just provide _RAW.
>
> That is still true in this case, because it is a linear, easy to reverse
> conversion. Nevertheless, the user needs to look for the sensor
> resolution in the datasheet and then use the given integration_time and
> scale.
>
> Is that ok and desired for light sensors? I think that a more accurate
> approach would have been treating the gain as a HARDWAREGAIN, which
> would have been used to calculate the scale i.e. resolution to directly
> apply to the raw value. In its current form, the processed value is not
> what you get if you do raw * scale. But as you specifically mentioned
> light sensors in your comment, that might not apply here. Moreover,
> there are only two drivers (si1133.c and vl6180.c) that use HARDWAREGAIN
> for IIO_LIGHT, which makes me think I am over-complicating thing here.
>
> By the way, in_illuminance_hardwaregain is not documented in the ABI,
> only out_voltageY and in_intensity. But that is another topic.
>
> The veml6030 has been around for some time and there is no way around
> without breaking ABI, and the veml3235 has been only applied to your
> tree and maybe it could wait to be released.
>
> If everything is ok as it is, then that's the end of the story, but if
> the processed =3D raw * scale operation should apply, the veml3235 could
> still be fixed. And when it is too late for that one too, then I could
> follow a different approach for the veml6031x00 I recently sent to avoid
> propagating the issue.
>
> Thanks and best regards,
> Javier Carrasco

Hi Jonathan, this email might have gone unnoticed.

This issue is relevant for the veml6030 and veml3235, and also for the
veml6031x00 under review, as it follows the same pattern. Do you think
they are ok as they are? Probably not, as they don't follow the ABI
documentation, and after reading some other reviews, HARDWAREGAIN is
usually not the fix for something like this.
Should the gts helpers be used instead?

Thanks and best regards,
Javier Carrasco

