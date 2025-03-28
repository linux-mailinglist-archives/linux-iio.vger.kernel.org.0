Return-Path: <linux-iio+bounces-17313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30288A74DBF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 16:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52097A62C7
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409614A627;
	Fri, 28 Mar 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8scltAu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E43594A;
	Fri, 28 Mar 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175876; cv=none; b=in2TwXYb6nIKCgzskKKP3TVBY9paCxxnccvMiTELX5ZOuY5oQ/EOvAGwHv8FwiFLoRiwv1m1CUjaPrTLaEPbPN2/Z1QN2ApYu6ZcjX831pPW+b5YRLMBh7sdNWArkZKm5aAFZeCzecCtCIgUwFVydQCnYd+LA44GWjQ+5zUFb2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175876; c=relaxed/simple;
	bh=4vnD+DHEqSBzz+VCa+lT52SFxyofr7XdlrOyU0bKZKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mt0juNASEe2bd0VyTHz6ihbvo77AhxEUjJDFEtHFCAL8sMaEg4i45NDvBb82VasF0hUyOotCxsWYF3/BOaA1G03KQPWyTUOVy4sC0pzIGazAI5pXAD9e9f6SEwSey9qvwlw7TB4l6qY/KDiyCUYY3NutiO1VAh2Pwu3Y7xND//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8scltAu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e636630da89so307977276.3;
        Fri, 28 Mar 2025 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743175874; x=1743780674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JEpnnBIQUbskXS0RqEeObZ5p7b6lVMjmPa4eVycTVU=;
        b=Z8scltAuVpXuYxUuTHlgmATPXKUpOe53JOZE0ATFcLXWRDscOYydr3c5O0NttWaVsv
         fChgy1CQ/1OFQf0RAUeR1szSXZQxpEvAcn2g6rBrI5qGTcCavlUvn89AbSsJyatQSadQ
         /J5QceZtq7TcqR4YJgkSNvbtkaqqbjAJgfLxaY6ecSLBh3RyYieKFiB+U2IGdJo/f80h
         YktxHmGg841azCdgqohasguKE/yFuswkmA8Vo4nXiSzyWUJHJtCl9iroE/9bNkboJ4g1
         GNmiqVpi2ZqUuNg1Z4VYWrCD3ZDnmlKsNcr/fQZDQZ5UJcMmLTf8bSqklEj615Dy24Ok
         Bnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175874; x=1743780674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JEpnnBIQUbskXS0RqEeObZ5p7b6lVMjmPa4eVycTVU=;
        b=pkfAzOOBPV7GgFcJNYe+dniRdZofHTKIo0Pjg/Nm20mgwABUpKT1zSz1dBm5DiHYOa
         5+sYhPmL1RCWfGcsJ8nHNIu8zwjGrKO9iJbjqn59L4/isqDpYNXqJiJaaClod6HAfbw2
         eri/wX6MEokg0og9wSnq+LKHIRfY0uAZCwe5+F3Ocd7Ik5jNP5J04Q2llRsRfsf9pF1U
         6JHKs7LMluFCMUdJheoUXPxkmfznCaWw199zMFlxFGSt4t5X1yAnSPtU9JwidGKS4Bum
         UD3rya5dJfM0FyHzH9slkq3gorG9R28LHUBeuwaJHSMIPcwal0mNbghDugiw364SeUkP
         EwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU952fHR73DrhbotetMzh5nVpyPQccted4vEsmNk5cXXHoHu5mpzAvHetKuj/JCD4gpo7Re59elCrk=@vger.kernel.org, AJvYcCVAuJ9vNLpTYUgJT9hg0M8kbQBCZkFh9QFGijFiCQzzq00YspIwvKjvx1SRks+npgX1sk6Qr/lxAubiPyBO@vger.kernel.org
X-Gm-Message-State: AOJu0YyulPy6LB3kuCxHZH+iN/U0xzF62PmrXanYlqyD3+3Bp8xsdwQV
	mSE0gIpH3Uap7s5x3JwkPV5k7pWSO5Zw8dzm+8+BpTDfwxxw8LFDtX7FhffAbc00GBAOYTf8t9Z
	FU7E8641TAqOObRMIFJqsSh+eCG4=
X-Gm-Gg: ASbGncu9JlWuOSEpXWJVtc8nDQVYndJMjUDtqKAFB95riECItmnFwUsNqk3kmv5BwCB
	whWHkB9ct8Q6WBpFhw4Cb26hINFVfisNENU0kOhTjGvTCXy0VA2fKmRTdMDiHVB3pIgiwlgOPAI
	xK4eO2Nh7OtjNZ0rnlvQHcUsHdmg==
X-Google-Smtp-Source: AGHT+IEmFYQlbFSKzS7Ov/gG/q6U2el7ppLAitV7rPzJjK8PneAM2r3Vc+d+PwkkA1le/1MwNu8aHgYeP8wjsbOeY9A=
X-Received: by 2002:a05:6902:4792:b0:e60:974f:a03e with SMTP id
 3f1490d57ef6-e6945c0ecedmr4065411276.6.1743175873641; Fri, 28 Mar 2025
 08:31:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165049.48305-1-l.rubusch@gmail.com> <20250313165049.48305-5-l.rubusch@gmail.com>
 <Z9ctSODRTxI53jAY@surfacebook.localdomain> <20250317105540.4b4a586f@jic23-huawei>
 <CAHp75Vc=c=0yhtaKuiE4mZTTzQdrPywt89E7A1GuHha9=V=GUQ@mail.gmail.com>
 <CAFXKEHacRWoGz59FYJJyYjOsg5CBTAFYPdwobvmF4jUqZJJAqw@mail.gmail.com> <CAHp75VeNXZB_sbrvLAdo-KunNeq2WwPVpA6AsF7t2P1TiBLB5w@mail.gmail.com>
In-Reply-To: <CAHp75VeNXZB_sbrvLAdo-KunNeq2WwPVpA6AsF7t2P1TiBLB5w@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 28 Mar 2025 16:30:37 +0100
X-Gm-Features: AQ5f1JqoKbADJZ3Ri2LYCfLFxCDTqU_d6R-Yia0wpFersMD6wGhcpUV3R8wsvCA
Message-ID: <CAFXKEHbyc5t=v6TiX0vZNgZtJCG9d8-KSDv64UzmtyZU6BnZmA@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andy & IIO ML

On Wed, Mar 26, 2025 at 10:33=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Mar 18, 2025 at 11:45=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.=
com> wrote:
> > On Mon, Mar 17, 2025 at 4:52=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Mar 17, 2025 at 12:56=E2=80=AFPM Jonathan Cameron <jic23@kern=
el.org> wrote:
> > > > On Sun, 16 Mar 2025 21:58:00 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > Thu, Mar 13, 2025 at 04:50:39PM +0000, Lothar Rubusch kirjoitti:
>
> ...
>
> > > > > > +   int ret =3D -ENOENT;
> > >
> > > Also note, this variable is redundant as far as I can see, just retur=
n
> > > the error code directly.
> >
> > The pre-initialization of ret is actually needed in the follow up
> > patches. Anyway, I can return -ENOENT directly here.
>
> Just do it when it's needed, I mean that this patch can survive
> without ret variable.
>
> > Evaluation of the sensor events in follow up patches then uses the
> > ret. It is also possible that reading sensor events fails, then the
> > error is returned. It is possible, that no sensor event happened, then
> > it will fallback to -ENOENT. And, of course, if sensor event happened
> > and could be handled - no error is returned.
> >
> > Is this approach acceptable? Say, if I'd describe it better in the
> > commit comment? Could you think of a better approach here? I think
> > returning 'samples' here does not make fully sense, though. First,
> > 'samples' is not be used outside the called function. Second, I have
> > to distinguish a case "no event handled" - This covers then all
> > remaining events like e.g. OVERRUN, DATA READY,... which still need to
> > have status registers reset, but won't be pushed - currently this is
> > coveredy by the 'return -ENOENT;' fallback. Third, I need to be able
> > to return error codes.
>
> But does the 'samples' contain an error code? Perhaps you should just
> make it do so...

I'd like to direct you to v5 of the patches. I'm returning 0 now for handle=
d
interrupt and/or read FIFO elements, or a negative error code in case of er=
ror.
I guess somehow I could not see the problem initially. Nevertheless, when
preparing v5 it became clear. I did a small adjustement and hope v5 address=
es
the issue in a better way.

Thank you, Andy, for pointing this out to me. So, no direct answers here,
hope it's ok.

Best,
L


>
> > > +   if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> > > > > > +           samples =3D adxl345_get_samples(st);
> > > > > > +           if (samples < 0)
> > > > >
> > > > > > +                   return -EINVAL;
> > > > >
> > > > > In the original code it makes no difference, but if you are going=
 to share
> > > > > this, I would expect to see
> > > > >
> > > > >                       return samples;
> > > > >
> > > > > here. Why the error code is shadowed? If it's trully needed, it h=
as to be
> > > > > explained in the comment.
> >
> > As said above, 'samples' is just internally used inside this function.
> > Basic question here also,
> > since intuitively you'd expect it rather returning a samples number -
> > should I rename the function
> > to make it clearer?
>
> Perhaps renaming helps, but still, I don't see how a negative return
> value can fit here. I would expect a negative to be a meaningful Linux
> error code.
>
> --
> With Best Regards,
> Andy Shevchenko

