Return-Path: <linux-iio+bounces-19201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C65AACA31
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 17:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC844E1DDC
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4A8283FE2;
	Tue,  6 May 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaszKUbc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75754283159;
	Tue,  6 May 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546940; cv=none; b=I7YrOODGSvKSaXDSSyhM2MRMKZKE79aV+EQZbHaGBLgNXSPZ4ZGwfxpHoHDKIw1XUmiwwtkQ2wZpIVKwWIwOYgP2QGkpQjWLHnO7xct/ICUtyi22Imgm36IYpFVNAmFa59bLwBcVqCjygI0yUhIXq90SXxJwr2KaojyqSB4NJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546940; c=relaxed/simple;
	bh=mCFQ+ucNuyMo3C5xld3jMo5WkJTHaPdSBRjzt64xstg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E68Ez4F6bI8U1U3dnFOjH52esD6wMl/Fl9Z09weB9EwL/dOl374J2hqmSXr9CKcaRimfIrjwXzx6ikgwAU6G5CqOl5qEnHZB2V3tocYgslRKqZHgS2A61K00ehR/IX+yc9lSYgv91K5ReH9Gcvk4mqoLOOjY2qi6joB37azdpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaszKUbc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33ac23edso64254465ad.0;
        Tue, 06 May 2025 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746546939; x=1747151739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgR5FUf+57QhLp7U3yKuzQJoQ3wyAe9WAkKlCi6IjmE=;
        b=XaszKUbck6YenAp3KNhMDNQSaeh41aEVPyCey5z44QWV1PchCVgr29fhWbOXvqeI5O
         PDA4u7kxa/DEQykafnmW+6+2k8+OKtAhY+XZrG3RRN0sma7FZziFm6STzHIqQ8Hjtfaa
         1JrRgSwWkjcSJZlCVbGhLAQCjeY6AmoynHXldoARiXkj95+qZtP/mPVRCwomtdsRddAn
         q4KrlsPgrytfUT7AiLHUz6lUNGrvmiacnifSD19NRcgbj7UYrnFOKW3YyvZxfNh0rbZ8
         IDff9hZXXFNVV5EvXIxL0ckuJ2I8Y2ia12KnjLleqA/yILRb5skPj4hqrsqNEi3PNQbU
         vsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746546939; x=1747151739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgR5FUf+57QhLp7U3yKuzQJoQ3wyAe9WAkKlCi6IjmE=;
        b=H+pJDelK9njR0aOf6gQEPz9gdeLDPF0uqkLFhE/UfuDeOMzPnTuQqTrRgO24jR4BcD
         gc+x+VVCiW51an8wTYnAXvFdYXPlI2zQ6sewCg6fl3BUE+xuFw/+WhLz2dNjghMb4pqZ
         wqHdUeA+7v7ctD7sw4m3yx/+IPO0AEnWoRwx3CJYfssPclURlgpQgpxFgxhjK5JWp4uN
         uujCuojZWtw9e67dT3ocAdZ53zmdiZ85rdngxKZmLZR1jC1AsKF5eLESEEIf6hCMgG0n
         ZGkVcr2jjhLw+CL0SRlGRPPq+v9MXq2oXIf2j+ffu0iF5KfoYmVc88+eaTACauCFKYEx
         IbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY+2VHQT+3yEJbat9cHd6HbwLKHrvOEdIXrqFHnOlfVLldlApv05IZo+UR5XvPV1wg7F3UEviq+Zg=@vger.kernel.org, AJvYcCX2JYmocNlkN/eRVPsER0GEZrYl8PqmKbc9SP7gHIsRMiDFvzKW7anYu4Vfy1Y/en1NXc8+uQJ+DG7BSXnj@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUKxk27V7KDd5tKpd+YFd35aUHGhEV2dlGRyLZ8ffzycMGDRl
	wno9kg2SyrnrbRt3TiEaaDS0/fiPEoG4izSO6OaRALtio5yiI171JqqttY9DwSwTghv665ySlNS
	Z+hihxCp2RPp/p5RH31xm9Kyzi70=
X-Gm-Gg: ASbGncve57gS1j0jnqWvR1nWpQ/1h/CipU+x+HPNDkxtKW9ttvqZ33r9i1kBBYYsfmI
	meXNezsqpxfC9sdH66CfigmVs+hAniYgs6MlbLdcS3wImR6P/RUjWl69aNJeXdNXgZtOoEf7SYq
	KKoIOPMWR21lB8iJjejRTJguo=
X-Google-Smtp-Source: AGHT+IFQT7YE0wPz7OxIzXL3HY1tUyH9E5KZ0IigNFCx542OaM6J2+1+qSLFAdPCTYJM1AXpAoX0OxanubYRe/Hhg6w=
X-Received: by 2002:a17:902:ea0f:b0:22e:4b74:5f66 with SMTP id
 d9443c01a7336-22e4b746322mr28489255ad.42.1746546938637; Tue, 06 May 2025
 08:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503190044.32511-1-gye976@gmail.com> <20250504152441.13772899@jic23-huawei>
In-Reply-To: <20250504152441.13772899@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Wed, 7 May 2025 00:55:27 +0900
X-Gm-Features: ATxdqUH9epeIH4jzPRzk09llcEw5SL3ADnjkWOTdNmRvxdHmR3Qt9xb21jLxo0c
Message-ID: <CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices requiring
 top half
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan, thank you for the review.
I would appreciate it if you could review my additional comments.

On Sun, May 4, 2025 at 11:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun,  4 May 2025 04:00:43 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > Some device drivers implement top-half handler,
> > which is not compatible with threaded handler trigger.
> > This patch adds a validation function to reject such devices,
> > allowing only iio_pollfunc_store_time().
>
> This needs more reasoning.  What makes it not work?
> + what do we mean by not compatible?
> I'd expect at least a reference to it using iio_trigger_poll_nested()
> directly.

Of course, even if the IIO device registers a top-half,
`iio_trigger_poll_nested()` ignores the top-half and only calls the
bottom-half, so it works properly.
What I misunderstood here is that I thought there were other IIO
devices implementing a top-half other than
`iio_pollfunc_store_time()`. So I assumed that the TODO was to block
those.
I had confused it with the IIO trigger's top-half handler, apologies
for the confusion.

---

> It's unfortunately hard to tell whether a top half handler is
> actually needed or not.  As a follow up question, what cases do we have
> of top half / interrupt context handlers other than iio_pollfunc_store_ti=
me()?

No, it seems that `iio_pollfunc_store_time()` is the only top-half
handler for IIO devices.

---

> Maybe we don't need this code to be this complex any more at all
> (i.e. could it become a flag to say whether the timestamp is useful or no=
t)
> rather than registering the callback.

my new understanding of TODO is as follows:
    - Since `iio_loop_thread()` can only call
`iio_trigger_poll_nested()` and not `iio_trigger_poll()`,
      if the connected IIO device expects a top half such as
`iio_pollfunc_store_time()`,
      then `iio_loop_thread()` needs to directly call
`iio_pollfunc_store_time().`

Would my understanding be correct?

---

> >
> > +/*
> > + * Protect against connection of devices that 'need' the top half
> > + * handler.
> > + */
> > +static int iio_loop_trigger_validate_device(struct iio_trigger *trig,
> > +                                             struct iio_dev *indio_dev=
)
> > +{
> > +     struct iio_poll_func *pf =3D indio_dev->pollfunc;
> > +
> > +     /* Only iio timestamp grabbing is allowed. */
> > +     if (pf->h && pf->h !=3D iio_pollfunc_store_time)
>
> Why is iio_pollfunc_store_time useable here?  It's not going to store the
> time if we don't call it...  We could special case it probably but we'd
> need to ensure the call is actually made.

Yes, If my new understanding is correct, `iio_loop_thread()` needs to
call `iio_pollfunc_store_time()` directly,
depending on whether the IIO device's top-half is NULL or
`iio_pollfunc_store_time()`.

--
Regards,
Gyeyoung

