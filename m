Return-Path: <linux-iio+bounces-16674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D1A5964F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29F4164BE3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263FA22A7F9;
	Mon, 10 Mar 2025 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="qu5aO65n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B122A4FD
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613385; cv=none; b=YOKcMcEpbB3RoLSRdHGF4Gj0GilTRXCYOwHgmUjLs4Bl61X0BFsL/p2sV2beE8MAixOpl1+TpbT+RL9dX/vdD12YPv94dAMrsQmApHJqlQ4x9VIGu3duaGqGB9mKPdsnyDAgriCsgQWZYAW+KsViztY9sokEcaisKCiYEvkxIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613385; c=relaxed/simple;
	bh=Fsl2gHLVFCv7J2FAW8iDKqh8SzHWoEhhR1AJ9qbGxMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeL4zpBsl7Af5idibQj+pMWatm5R+AX43Ka7i5MxR1CngT7f/on2KrsVjjwYcvPP/WHRr+FbCuh5LEeiiZD92jGW96Q156u1lXr24+isZhoVVFl2sDw/OPmThrrSlmhzbJ7msuwnU5o+/aKBU1oWUYvKI8qFo551FoTDm7uLJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=qu5aO65n; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff07872097so936617b3.3
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741613381; x=1742218181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KxWhyFdVbsMG415LkqpI3V+a1EL8BtY2dzLTWy7ycE=;
        b=qu5aO65nh15rjiktsq3hgpMsp6WRPgwYIQOi/NGF4fjeSPkadJXBLbDaHh0NQsAuu/
         f6zrVOmXGho7OjaQmY2L29RCg5uoE1iLBin55DLRzNWnvek32qqZDe98/L6MIpJH50RZ
         RCcV9oAB7pcqlJHID61Med9SxLAeI8nyriqPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741613381; x=1742218181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KxWhyFdVbsMG415LkqpI3V+a1EL8BtY2dzLTWy7ycE=;
        b=MV/51i+deXsAYwLoXeMIF0GPZBBZGbOyxAfsPahPUSU2JOiUvy2BQL8GN4qgQutmFm
         0KrgnT6oBH0xdaR/GVULGYTlQusexsUgDgAXErRYNi/JO5ss6mV+5t+xtQBmu84WX+QQ
         CGhj6xGsxJ30Jr/lIGIhVLWGiKZSsXD9MaqahBQZwgSPvYGH84KCEtzxfSei7+fGKf/b
         ivNMIMYZWd3FzmAo4a/0hPYv4o/dPaWHxDuDQDGsSiuxYoCjWkdpYvTbexwWeB4dKAkP
         GK6kGpvVzk0ukjdbRHF5iMm0ey/QXnEvoNuBaLCyIChrqXmvPTrJ8BkQZGuRjC8bBZcm
         GS9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZEArHTEqU3lad1Mn3KhRTCJWWnC95PHlaxBxfNAQGNBsMP0NP28bjX8ULXh0B5GT7DejF22FNx7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkGNrNppIPPoy8rTRQi8ZuQDKQbuJ2uTM7xJrb3MpInCifI7Y
	F2dVG4FHTKFQJwmZVO4n8/DGQFtG/Ni1RyPwHtHjLr4k4noRwTB8+/m/8qM+zq7SfLiPTyjfkHh
	Gq6Qg9cVm8h8RgZiVRJL2S5M8cZvRLFE5U7by548iZq8EzJ3DmJ76
X-Gm-Gg: ASbGncvOuEsmekxOMxDXzvWr3WZIhYVMopHJ+TmCjyuDtmudF+7ntelDowpe5J0clTC
	5XLhSSh8qHYhX9chRqzLUeWd+BBq4jCtwFZT8X0X76fUOUF9X/iJlOsg1BameWYzukfehakFnUS
	5F/tm+Y1cokNhQKtIJXe9UPAV5jDg=
X-Google-Smtp-Source: AGHT+IGjnnG8vv4xO+caWb7tXE+5eX5letdxuWCa2dqrkVQYGbQAcyXvsH8hHsNbsdnMBoZFjJEd9XyaNr0FbNoRmLk=
X-Received: by 2002:a05:690c:2e03:b0:6fb:9c08:496d with SMTP id
 00721157ae682-6febf3c2cbcmr145437107b3.30.1741613381151; Mon, 10 Mar 2025
 06:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132124.52811-2-s.seva@4sigma.it> <Z8nDzyVO596rW0Mf@lore-desk>
 <CALKJsrqc__ZeLoZ5V+hBxVMU+Crpv_YG0KM69N1CXuHc_rM-FQ@mail.gmail.com> <Z8sFdGG4bDyALrsi@lore-desk>
In-Reply-To: <Z8sFdGG4bDyALrsi@lore-desk>
From: Silvano Seva <s.seva@4sigma.it>
Date: Mon, 10 Mar 2025 14:29:30 +0100
X-Gm-Features: AQ5f1Jqlt8x3XDDC0Qws37se1RFz7E06-AKjm0dhbWcj-KGZMrT7yJ5yVF6Day4
Message-ID: <CALKJsrodHaDdra2ZMzHkHmcZy+KMwbaO5jTSkSOx5S27SByecQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, 
	"open list:ST LSM6DSx IMU IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 3:40=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > On Thu, Mar 6, 2025 at 4:48=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel=
.org> wrote:
> > >
> > > > Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functi=
ons
> > > > from falling in an infinite loop in case pattern_len is equal to ze=
ro and
> > > > the device FIFO is not empty.
> > > >
> > > > Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drive=
rs/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > index 0a7cd8c1aa33..7f343614f8a5 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > > @@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw=
 *hw)
> > > >       fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
> > > >                  ST_LSM6DSX_CHAN_SIZE;
> > > >       fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> > > > +     if (!fifo_len)
> > > > +             return 0;
> > >
> > > I do not think this check is necessary since if fifo_len is 0 we will=
 not run
> > > the for loop, right?
> >
> > This check is present in the st_lsm6dsx_read_tagged_fifo() function, i
> > added it here for consistency. I agree with you that is not strictly
> > necessary.
> >
> > >
> > > >
> > > >       acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > > >       gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> > > >       if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
> > > >               ext_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EX=
T0]);
> > > >
> > > > +     if (!pattern_len)
> > > > +             pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;
> > >
> > > same here, I do not think pattern_len can be 0 since hw->sip must be =
greater
> > > than 0 in order to enable the FIFO. Moreover, this check should be so=
me lines
> > > above since we have already divided fifo_len by pattern_len here.
> > >
> >
> > There is a situation causing the subsequent for loop to never
> > terminate, hanging the kernel boot process: given a system which
> > doesn't have an hardware reset line allowing the kernel to
> > re-initialize the IMU hardware, in case of an hot reboot the driver
> > probe() function attempts to flush the FIFO, which may contain some
> > data, while the hw->sip is zero.
> > The complete execution path is the following:
> > - call of st_lsm6dsx_probe();
> > - allocation of the st_lsm6dsx_hw structure via the devm_kzalloc,
> > zero-initializing the sip field;
> > - call of st_lsm6dsx_init_device();
> > - call of st_lsm6dsx_reset_device();
> > - call of st_lsm6dsx_flush_fifo();
> > - call of st_lsm6dsx_read_fifo/st_lsm6dsx_read_tagged_fifo via the
> > fifo_ops function pointer.
>
> ack, I can see the issue now, thx for pointing this out. I should we shou=
ld set
> pattern_len to ST_LSM6DSX_SAMPLE_SIZE or ST_LSM6DSX_TAGGED_SAMPLE_SIZE if=
 it is
> 0. Can you please move the check before updating fifo_len in
> st_lsm6dsx_read_fifo()?
>
> Regards,
> Lorenzo
>

Changes done, I sent the updated patch in a separate reply email: I
hope that doing so didn't cause any trouble.

Thank you,
Silvano.

