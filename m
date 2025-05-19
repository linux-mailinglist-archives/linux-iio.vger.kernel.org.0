Return-Path: <linux-iio+bounces-19688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DEFABC0F2
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9A14A12BA
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E0283FFD;
	Mon, 19 May 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1/W6TgG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DB283FD7;
	Mon, 19 May 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747665311; cv=none; b=XpaN+AuUkKrZMt66/4UrR6NTNoP0twzjxEiFLazKXXq7KAPDIYhfwfzSD296/mLdB1qMcd6uwCuZNnUTYEGVxG8AedFrZxK7jTMAGciy4awnwA6QYWp4vMT83L6GYW2z4Bxn7HJFke4XHqc3o3IPQs41ajNgTa40cJSXeqqeAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747665311; c=relaxed/simple;
	bh=EdYqSC3OnTVL7lHMbCu9hjuY1ENmkraiXLuOLjZwOb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOVfYt6BgXiSiFj+EW0met1vavxrBY1D/fxrLUVIBHZs6Hy+Y3GOhEdb2il/KsKz41iTV70omagYtlVXouhBm/ZJgf6MoKaruIIc/uEy/Fbkw6TNKHiQPHWm8QNDD9thAIaOg1ckSs8EFSPcJtPUkEoFiPdoM2p9Ro6li4HY7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1/W6TgG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73712952e1cso4219644b3a.1;
        Mon, 19 May 2025 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747665309; x=1748270109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pid38UufCOGElYkiQ7bVeoF6QqOv7gV5gIGfwiGbags=;
        b=N1/W6TgGj1q3segwJUwxjJuQWaErHw9RHK0Nfy4SXVicp5uUYl5eG2ZqnlkSnz/DVw
         sXAcDjD8RsJz3KftDgW8GWjxOv4T3MlHt8tYP2G6+37q1wgEigVsK8Ak/FyIR8A2XYSw
         a2kPl/Zew0pgmRDvjTYFR2R4Kx3up5+f2Chete8ltvy/0Y1PKxF5sk7JCBuQja7fqA6s
         j8f3L8b0ULT4zMqnLy7xJaS/UKIL254foWeo5nY4fMeW1IhgzBdDDc1UpNUDaiv5QIj2
         JqUQ6ZWGO01NyR2U34awuW5zJkain6hO1qdPcojgfw5wjsuCl0Ou8vC26BSHStkOU7O4
         AFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747665309; x=1748270109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pid38UufCOGElYkiQ7bVeoF6QqOv7gV5gIGfwiGbags=;
        b=vOb5HcFWw08DYAJWUymDCY0RXgsUfGOu9wTnoKCaQq01vTw+neYA3dSXN7LcvjEgSr
         mDteC6NG3ds0lYSJxI9XafYOA2EoEtoOhY7wi0AiBsad7XAKSQ8E23js5XbU/FEzPTmU
         MICuzlbM5/iHUJy1W1CfWLk4P7z/TyiX/AjZEqi6VGseDxTELycSf6E8HT61K6FHwTpr
         zcYF6Hn0fTqrPQjuMDx76DDqf2I/QqTPpofm01uXquot8UcomDnjf6kd8l8cK1xv9sj7
         1zlbUn1k+GAWIWmQhyS39VgHDos2YMU8ok5lb5n2U2ocwI77/pXuxhUsQJYG8YXjJGLy
         J/kw==
X-Forwarded-Encrypted: i=1; AJvYcCUD62bmhJqolKeU6bwlcAVj/QaqmxQzZOixu4xPKaTrgn8J+/aYeSirvHgt4LwgnzqZGi4DV1vv03g=@vger.kernel.org, AJvYcCXHdasIR7NP0IsQFOZ6O/Gwz1ZbGEUFZt2zKhiw1dEC1lafWf5+8LDEe3sxZsgE9DPNkOBEn0ZRLUs1OA9c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84jmsmZd6UgcetOFqyZz8Dpl+vlxdCcM+gD5Qt8HV1eHDFe9N
	gg36GKGq+XU5ILgtA+Upm6POI7fNZC4uLc429wuXv7ydyBHM+sM/+CpyX7bwRET+seRfsN2Tj37
	XGUltYGb284Sc9JpN9uJeb5LC3VK1NJBHmaCF
X-Gm-Gg: ASbGncvU01OroAhcWddbihDqeB+s8KGWTkqmZSBqY77B1EXH/cHY4Fz1Tdbddes1MYD
	g43WtsNoNy0N2P9fp3iRM6oHpD+zKAkAKs6NZYtWfJTz2ZXmBho3G/mfpdiPlzHt9hwuymEzQtA
	5uBxlAvfF1lC/AJhA434l5P/5Te/KdXG497g==
X-Google-Smtp-Source: AGHT+IGdke/4NeyT6qDSRbpkKH5aoNfIEDb704nwrs8q3Ju7R51He0MyWXurFC9o4U2xYBWWiIebrxsmMDo9zakW8GY=
X-Received: by 2002:a05:6a21:502:b0:1f5:9208:3ac7 with SMTP id
 adf61e73a8af0-2170ce3c81amr18627084637.41.1747665309213; Mon, 19 May 2025
 07:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503190044.32511-1-gye976@gmail.com> <20250504152441.13772899@jic23-huawei>
 <CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com>
 <20250507204026.11a260ef@jic23-huawei> <CAKbEznuG6-+cKOOVSvyw30Qra_6yVruA0cvpcK5Gqp2_kcPHcw@mail.gmail.com>
 <20250515084937.432fd168@jic23-huawei>
In-Reply-To: <20250515084937.432fd168@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 19 May 2025 23:34:58 +0900
X-Gm-Features: AX0GCFu8G08MUu9LKYDr4PBVDBDAiXgAXSTnTKQyQmETQ_rlhWPPhXlmVMNEk2k
Message-ID: <CAKbEznvr1kcyfkocba021zBLJv208GNDHGxW1JCkg=mxAFyQ=w@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices requiring
 top half
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 4:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 12 May 2025 00:47:39 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > Hello Jonathan,
> > I=E2=80=99ve referred to your previous comments and implemented the ide=
as.
> > Thank you for your earlier feedback.
> > I now have a few follow-up questions and would appreciate your
> > thoughts on the below points.
> >
> > On Thu, May 8, 2025 at 4:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > >
> > > On Wed, 7 May 2025 00:55:27 +0900
> > > Gyeyoung Baek <gye976@gmail.com> wrote:
> >
> > > I'd take a different approach (slightly) though it's more effort.
> > >
> > > Step 1. Tidy up current situation.
> > >
> > > Patch to convert all existing calls to devm_iio_triggered_buffer_setu=
p()
> > > and iio_triggered_buffer_setup() to not take a top half function but =
replace
> > > that variable with a bool early_timestamp or something along those li=
nes.
> > > Replace the h in struct iio_poll_func with a similarly named bool.
> > > Bunch of plumbing to make that all get filled in correctly.
> > >
> > > Then in iio_trigger_attach_pollfunc() check that bool and if appropri=
ate
> > > pass iio_pollfunc_store_time() it to request_threaded_irq()
> >
> > Now we have both the existing `devm_iio_triggered_buffer_setup()`,
> > and a new version with the additional arguments of that.
> > Should these two coexist for compatibility, or should the before one
> > be replaced by the new one?
>
> So the aim will be to replace the existing function.
> How to get there is indeed an excellent question.
>
> I'd want to do it in one go, but as it affects a lot of drivers a
> single patch is probably not appropriate.
>
> So we'd introduce something like
> devm_iio_triggered_buffer_setup2() with new parameters
>
> Move everything over to that then a single patch to remove
> the old function and rename it all back to the original.
>
> Alternatively we could find a reasonable alternative name to avoid
> that 'rename all at the end' patch.
>
> devm_iio_triggered_buf_setup() perhaps?
>
> >
> > > Step 2. Make what you want work cleanly now we only have that one han=
dler.
> > >
> > > In iio_trigger_poll_nested() we can't know if that flag is set and I'=
m not
> > > really keen on trying to get to this from elsewhere. We have previous=
ly considered
> > > solving this case via whether the timestamp is set or not in the thre=
aded
> > > handler. I've never like that much as in theory timestamp 0 is valid =
(was
> > > a while ago). The rpr0521 light sensor has handling for this.
> >
> > What I'm trying to do is a mechanism where device drivers can
> > automatically get timestamps without manually handling them =E2=80=94 s=
imply
> > by setting a argument to indicate whether to capture the timestamp in
> > the tophalf or bottomhalf.
> >
> > But there are cases like the rpr0521 where the driver sets the
> > timestamp manually within its own trigger.
> > Would it make sense to extend this to automatically set the timestamp
> > in cases where the driver uses its own trigger as well?
> > To that, I believe we would need a unified interface that can cover
> > all trigger types (e.g., interrupt, software trigger) that invoke
> > poll() or poll_nested().
> > Would it be the right direction?
> > Or would it be more appropriate to consider only the top/bottom of a
> > consumer device?
>
> I'd like to avoid grabbing the timestamp for particular drivers
> that never need it (as they want to grab it in the thread for
> reasons of how they work - typically the capture only starts
> when then write to the device).  Other than that I'm not against
> having it grabbed in drivers that 'sometimes' need it whether
> or not it turns out they do.
>
> The dance is that we can't see the right information in poll / poll_neste=
d
> so the best we can do is see if someone already filled in the
> timestamp in the handler we are currently running.  For that we need
> a flag alongside the pollfunc timestamp.  Care will be needed to ensure
> there are no races though as we might clear that flag just after another
> top half interrupt has been taken on a different cpu core.
>
> I'm not sure yet exactly how this will work.  Needs some experimenting
> and thought.

I think it would be possible to avoid checking whether the timestamp
was overwritten, by explicitly specifying which of poll() or
poll_nested() is being called in the `iio_trigger` structure.
I have submitted an RFC patch on this, and I would greatly appreciate
it if you could review it whenever you have time. Thanks!

Best regards,
Gyeyoung

