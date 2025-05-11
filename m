Return-Path: <linux-iio+bounces-19443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E33EAB296C
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C477189255A
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937C2571C8;
	Sun, 11 May 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6Oi1tCt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41821EA90;
	Sun, 11 May 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746978472; cv=none; b=ENg7UCbhppVVWUL8ykDrYlSSc0t6KtRP0kour3ERZmEvHYQ3BZSXm9XueMISA14A+an52ypDrmKsfdjSE0BOdNcJLx13aEO5deKje50NJ/V+3zp0X1ZnXUflqrxicNp1DaqJq0SxMB9BLq6cVWQrCDfFfuV1aHDQLs9p1SCZJFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746978472; c=relaxed/simple;
	bh=apevVu4S4A3gC1ScqlvK4rzXGz+MNz8y2NyyBOx14c8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRuCW8Py139rF0Ss8k6ZKKOmlSPMmH72zERnUdSmf2qLPvh+4pYODY6tktYbtHiaqMsX/RWSdVPc11Byd6NTccjl6Hhki7meiblonKEiDYH+4TmkQVLR07SZ6wd5G5dC3kkSjg32iZHBLNm2ZiTCTsiS5Zn0zaJFjcDAaHutnwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6Oi1tCt; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30a89c31ae7so4836206a91.2;
        Sun, 11 May 2025 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746978470; x=1747583270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMIRT//FkWurqHCR5yWkHL+jcYZxgGvY2tq1kDCM/ag=;
        b=G6Oi1tCtrha8bDH5Gmu8PTk5bnvo3ZCQnJZ9TqVrS8hM3QRYlh7LNW+cN/GNUrwDG8
         KmXFnqRdjC0SRYEs1v13N7aDlAGZIn6gkmjB5P+aTdWSSSXrlxLzi7TCjH3DlbdoaP5N
         Kwx3UkOXbY7vJHdC4A80G+/+rnCKfVZNYaMby4dgQm0mfsNJA/aDjs6YHZS+q8a7IlLP
         QrVq3Ybq+SqcwONWafQEc/OlKpzKheETtb31+sc4a+s3U01z4Fx7HTDLFEi0SwEAPcdt
         YEWmvxVS7D7T2NEPbrarVEUTgqxg8nw+e1JfxUuhaDF0KZiSKG6AR7WzK2puggx5dQw0
         N5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746978470; x=1747583270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMIRT//FkWurqHCR5yWkHL+jcYZxgGvY2tq1kDCM/ag=;
        b=o4AjZG4ZUE88KgIr+Siy6xE7ocSiyWqNQhK8z4f0J/O/n0R93BbXer//wU+QdhvodI
         G0M8vIab3r/gW/czUWAAAF/4n3luLlJKFTu7WkUhjjtB2rjTSpn7kJPLLMiCI/vNJ8bw
         8xMB6IMBHKXxEAQYntpTPGjYZxsmXN8ez4FgLSqvASUFhDUn9QYozABIihU8qmAPKO2y
         QR66a9A4QU5OTnXAm5GI3VzOP6U++hjcfX8ZcZnNgRFjVG3OcTC1NSbP3EtUz3pct6We
         ELJ98ORkMw3tbb3lOn/IiemW1sMCAUoXmzxrazeaEunhyX2/ancSqrVz9wB0dck5GSdF
         dZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOrYFLI6gZu1DgNr+3ji4fQHaf6jiAiIDpYlsd3QdrBDwRvN31H9BjodOZNqdhqJmvL6cGura4Z05MpcrQ@vger.kernel.org, AJvYcCVsDNe59ycEliun2erT17o2kKjdekldqQB5w4OmUGm8c8yCpR/B4elRi7yYY2TpZfYjWZROkLJFSAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgxs8fQgrBrYcCWeUBErQrrIX7DBpS6tcaWfvQJyiH5MGHG82
	oSwdwdza2Y7M0Hh29PWme00vJdSm2hPB24a6OfUgcJs5HmhUwY4EPK39YFaF4uuAKOX1FzhyYCb
	aXjKkHvlp4ipYZq5xb8UtGaNs5pA=
X-Gm-Gg: ASbGncuBgMpFgkizg2gxwLXyuGxHws1XfwAd0trqykEz9YnCtjnur7jnXS6or7BaoM/
	tJQDO1T27gmnBP13J8T/3eX508bD/aVnKiaUNChrOdZxTmr9e+nB0ouEbiyC/MEmec6XcOTlYkb
	yP0AiB5v7JL5zdnGCSFYxFq0udFUVavMnTjA==
X-Google-Smtp-Source: AGHT+IFWibzz1lQvEgrwAVuLTAi11+cCr8d7hzsIJdC+gKZ+mnn8eilh8OS9AJPz0NtnIoyNuGMUVS0IsE9CzmODIHk=
X-Received: by 2002:a17:90b:3c0a:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-30c3d65e441mr18951434a91.33.1746978470054; Sun, 11 May 2025
 08:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503190044.32511-1-gye976@gmail.com> <20250504152441.13772899@jic23-huawei>
 <CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com> <20250507204026.11a260ef@jic23-huawei>
In-Reply-To: <20250507204026.11a260ef@jic23-huawei>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Mon, 12 May 2025 00:47:39 +0900
X-Gm-Features: AX0GCFtLZhxA6Y6KxoO7N2eXBNn4pYEcwjZdV0aRJVREMWk3P180KvIBdmXReis
Message-ID: <CAKbEznuG6-+cKOOVSvyw30Qra_6yVruA0cvpcK5Gqp2_kcPHcw@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices requiring
 top half
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,
I=E2=80=99ve referred to your previous comments and implemented the ideas.
Thank you for your earlier feedback.
I now have a few follow-up questions and would appreciate your
thoughts on the below points.

On Thu, May 8, 2025 at 4:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Wed, 7 May 2025 00:55:27 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:

> I'd take a different approach (slightly) though it's more effort.
>
> Step 1. Tidy up current situation.
>
> Patch to convert all existing calls to devm_iio_triggered_buffer_setup()
> and iio_triggered_buffer_setup() to not take a top half function but repl=
ace
> that variable with a bool early_timestamp or something along those lines.
> Replace the h in struct iio_poll_func with a similarly named bool.
> Bunch of plumbing to make that all get filled in correctly.
>
> Then in iio_trigger_attach_pollfunc() check that bool and if appropriate
> pass iio_pollfunc_store_time() it to request_threaded_irq()

Now we have both the existing `devm_iio_triggered_buffer_setup()`,
and a new version with the additional arguments of that.
Should these two coexist for compatibility, or should the before one
be replaced by the new one?

> Step 2. Make what you want work cleanly now we only have that one handler=
.
>
> In iio_trigger_poll_nested() we can't know if that flag is set and I'm no=
t
> really keen on trying to get to this from elsewhere. We have previously c=
onsidered
> solving this case via whether the timestamp is set or not in the threaded
> handler. I've never like that much as in theory timestamp 0 is valid (was
> a while ago). The rpr0521 light sensor has handling for this.

What I'm trying to do is a mechanism where device drivers can
automatically get timestamps without manually handling them =E2=80=94 simpl=
y
by setting a argument to indicate whether to capture the timestamp in
the tophalf or bottomhalf.

But there are cases like the rpr0521 where the driver sets the
timestamp manually within its own trigger.
Would it make sense to extend this to automatically set the timestamp
in cases where the driver uses its own trigger as well?
To that, I believe we would need a unified interface that can cover
all trigger types (e.g., interrupt, software trigger) that invoke
poll() or poll_nested().
Would it be the right direction?
Or would it be more appropriate to consider only the top/bottom of a
consumer device?

> I wonder if the following would work.
>
> In iio_trigger_attach_poll_func() we have access to the trigger and
> the pollfunc.  So if the pollfunc flag for wanting an early timestamp is =
set and
> we know the trigger is going to use iio_poll_trigger_nested() then we cou=
ld
> wrap the registered handler in a local one that calls the iio_pollfunc_st=
ore_time()
>
> The additional magic needed here is that today we don't know that about t=
he trigger.
> So we'd need to add a bool to the struct iio_trig to indicate it and set =
that
> for all drivers that use iio_trigger_poll_nested()   bool nested; will do=
.
>
> It's not perfect as there are driver that do iio_trigger_poll() and iio_t=
rigger_poll_nested()
> depending on path. To handle those we'd need a flag to say don't overwrit=
e my timestamp.
> at91-sama5d2-adc.c is the first one I found.

> There are ways to make even that work but lets skip that for now as they'=
d
> slightly complicate things. That driver won't call the timestamp capture =
in
> some paths but it doesn't today so we are no worse off.

--
Regards,
Gyeyoung

