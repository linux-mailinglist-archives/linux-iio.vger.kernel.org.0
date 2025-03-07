Return-Path: <linux-iio+bounces-16512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBAA5639B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827B4176165
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427FC204C2A;
	Fri,  7 Mar 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="Q+km1ios"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5861FC0E3
	for <linux-iio@vger.kernel.org>; Fri,  7 Mar 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339250; cv=none; b=k9j3vjvwa9W2/AgO3esl0xh8jA1TLR2jLQP+FK0aDfAV1XOZ0o/5iOQUATsPvhgO0beAe8iKc0yJVvNaPF9Wn/OD0Zmdkf9NHXSNnEVurGrGYilz8YG606nUdQ/aQdv4kvVqda5tRQjit76BIr3/k9nTD4bRJowApOUbLdpBeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339250; c=relaxed/simple;
	bh=EOlxAY75X3y75FmTSYltFrdpLHUb9MhwojT4GfBHpHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BU7eFxxsGA0pDWUbfaXJkbivGgh/RwIdp/lETouqtZPkTspMm93VuZT4gmzOw91x0NHCuCEDX2IJ99sKwSJSCZFNEFjwyAwrxz9cNnUT0brOCIoNpSOv8CjSyvNEplzViLVGDHHz60S2a6ELMdHCOUVcgKWVbaLj32QLB5yg0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=Q+km1ios; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6fd4dcf2df7so16177797b3.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Mar 2025 01:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741339245; x=1741944045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Mpzl2g2Ql1mD+GBxk6knfh/edalweU17g5lOUxsW8=;
        b=Q+km1iosgOVCg1c/cVYg0XWToFQVFGoy+wBvwYQP5TBvGeRbpQ0uTCbFRao8YcCJ8M
         UyDIaHd9KduFS6WGRq5eWiE/UtJbg+eDqY0rh0Lh+YeAPSQwExKxCxwSuEmQM8M2IPpp
         koRErXQNR96Ixn1JDfRdiWMUE8x5PlUg4Vswk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339245; x=1741944045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Mpzl2g2Ql1mD+GBxk6knfh/edalweU17g5lOUxsW8=;
        b=RQTlAYiKCR5N5I7Sb8qpZwg6rc4hqijwk4qUirpwrUG9XGzsZxi3u9ALMN+r7/AFcK
         th6Pb5oMF5452rx/+131WF3MP6lROZRxd3LrWTbPiqModSTAlnsFsoW9GfXOHfcti5r/
         Dlh5/kk2TvOE9wxMdpmgDB8O7kWDybKjY8E/NwGr2/l2PiAbovM+s8I76f8EPCpGY8Zq
         11IA5afQekrlZTHjpuoj0WO+8JRHKOXCtOfHmk8IOHImjAbOYvdpwj4abqqBNOHmig31
         1eHffWX4FQsll2pqvzqF2FtWpcNL+yd5ywp2obXWOIMIdLYFUpxEaI1PLBNCTLwgdIJD
         E5+A==
X-Forwarded-Encrypted: i=1; AJvYcCUPReMxLHioulfog58yRDASU0nbfub5MQRr6BDSWY81Sa8Tj9Ttt71CzE/970zNQYvdTWd/QJIaRS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLj73zKmcBenJNO1uxgD815ll9Gj+phBcjUfjrbPVZjUmTuMj
	27/fhZNmm30izQOO+Mu1JyA3Sq/+JU5Pwa3D54l1GFi9bk47NbMsYJw86iilICS0vSc2/9TP6hD
	FTdgz//BPeGjsz6WZ6hr/NN5XCOn2avjYjoBb
X-Gm-Gg: ASbGncuBrr1JRTFdUhsp6CoAyIVOwIwg1TUFOIMX7b7tgEoO8uMsrwJr1AaAEhMcEgm
	LK/hM2janYsthzJ0kyaHnHAlpHcP+3kjpEy2SaxnzQzo7ToBCJdRHerk96eecXgrngBE/lIxAFK
	fxyPFFE+vH6/Aq0se3nxkobxIV
X-Google-Smtp-Source: AGHT+IHHtkHH4bClarTQDPoQzJBWegMQ1mtMdNXXRANxaeOJkqAsFxaY0+fzNWLiByrID1GLClFedxR/3JsQiqYQR4Q=
X-Received: by 2002:a05:690c:638a:b0:6fd:41e1:83d8 with SMTP id
 00721157ae682-6febf2b4c1dmr37667517b3.6.1741339245381; Fri, 07 Mar 2025
 01:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132124.52811-2-s.seva@4sigma.it> <Z8nDzyVO596rW0Mf@lore-desk>
In-Reply-To: <Z8nDzyVO596rW0Mf@lore-desk>
From: Silvano Seva <s.seva@4sigma.it>
Date: Fri, 7 Mar 2025 10:20:34 +0100
X-Gm-Features: AQ5f1JqmBKwjE_TVrDfV6pHyPYuuWGyYdwJGFXT_yavn6fnYiy4Nyw8ICQE4AUs
Message-ID: <CALKJsrqc__ZeLoZ5V+hBxVMU+Crpv_YG0KM69N1CXuHc_rM-FQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, 
	"open list:ST LSM6DSx IMU IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:48=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
> > from falling in an infinite loop in case pattern_len is equal to zero a=
nd
> > the device FIFO is not empty.
> >
> > Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 0a7cd8c1aa33..7f343614f8a5 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw=
)
> >       fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
> >                  ST_LSM6DSX_CHAN_SIZE;
> >       fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> > +     if (!fifo_len)
> > +             return 0;
>
> I do not think this check is necessary since if fifo_len is 0 we will not=
 run
> the for loop, right?

This check is present in the st_lsm6dsx_read_tagged_fifo() function, i
added it here for consistency. I agree with you that is not strictly
necessary.

>
> >
> >       acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> >       gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> >       if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
> >               ext_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0])=
;
> >
> > +     if (!pattern_len)
> > +             pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;
>
> same here, I do not think pattern_len can be 0 since hw->sip must be grea=
ter
> than 0 in order to enable the FIFO. Moreover, this check should be some l=
ines
> above since we have already divided fifo_len by pattern_len here.
>

There is a situation causing the subsequent for loop to never
terminate, hanging the kernel boot process: given a system which
doesn't have an hardware reset line allowing the kernel to
re-initialize the IMU hardware, in case of an hot reboot the driver
probe() function attempts to flush the FIFO, which may contain some
data, while the hw->sip is zero.
The complete execution path is the following:
- call of st_lsm6dsx_probe();
- allocation of the st_lsm6dsx_hw structure via the devm_kzalloc,
zero-initializing the sip field;
- call of st_lsm6dsx_init_device();
- call of st_lsm6dsx_reset_device();
- call of st_lsm6dsx_flush_fifo();
- call of st_lsm6dsx_read_fifo/st_lsm6dsx_read_tagged_fifo via the
fifo_ops function pointer.

An alternative solution to solve this situation is initializing the
hw->sip field to a sane default value in either the probe() or
init_device() function.

> > +
> >       for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_l=
en) {
> >               err =3D st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUT=
L_ADDR,
> >                                           hw->buff, pattern_len,
> > @@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_h=
w *hw)
> >       if (!fifo_len)
> >               return 0;
> >
> > +     if (!pattern_len)
> > +             pattern_len =3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
>
> for the reason above, this is not necessary.
>
> Regards,
> Lorenzo
>
> > +
> >       for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_l=
en) {
> >               err =3D st_lsm6dsx_read_block(hw,
> >                                           ST_LSM6DSX_REG_FIFO_OUT_TAG_A=
DDR,
> > --
> > 2.48.1
> >

