Return-Path: <linux-iio+bounces-2552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF60854CE6
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFED282AE8
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C16D6087A;
	Wed, 14 Feb 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPMr9/ve"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455395D728
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924715; cv=none; b=EUo16t0xtUABAokYu0lhO20DqgF8GZDHszFjGbapsmOT4UpO9x0ODm9vg8myHqM5XMo6KNuxpCCbBm2TomZiT2vDVdD/iCSStbqTBTJsv1kBB759kt/KEPGEAB9Ae5iFr4ff6N87PK0qUmyyOETx5Uox6Yhwb/lQ6M5pu1AsUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924715; c=relaxed/simple;
	bh=cqLK0LceyFc+ClLG+c+4GIU6I0QZ9dfsIBe7ZZSRPzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHeStXZlVoW8lisD2raan+9hdal/1tXbfDZ8Cah8CxQ/DW6MeQfUavSbhN9Hg5/PXpD74mlDpSN/Q0DqyRpLZ90t00azRO2ag9DnHMho/Uo0WhwH8Xw84rsGn6bI3ujbJPd+72cV7Y29oamPPscJWTx0ZkGqcTXY2c05FIvx6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPMr9/ve; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so746503566b.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707924711; x=1708529511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqLK0LceyFc+ClLG+c+4GIU6I0QZ9dfsIBe7ZZSRPzA=;
        b=cPMr9/vegk5ak5amQZeZzoad3CpEh21En1WgWmAOYB8mQiaOC+K76MjJy2RWZ0u37n
         L/tzlEqApkHoqQDlzwMylixLD8chuNLd8pChVWdRnYtyP587GLl0onOrjsrq4fUsxeDq
         x8mN1K/bXv8zAeP0M8w+NZswt6f7qto/KakWM2nJZE2cdYn1FJfzYwtEYScBt0xVoQZx
         wXSVpFH4Zirw7FAPeA26A8ezhqm5TvChMA3Bn0ttLGJw2AocWMaCfA1HfI5f02bdBmNX
         hUv3OvtNQGqbKGWqcSPdlFa+pV14f4O7zkoCcN4V1A6STfEWLGuhvFWCLSf8w1eG5uNy
         SUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924711; x=1708529511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqLK0LceyFc+ClLG+c+4GIU6I0QZ9dfsIBe7ZZSRPzA=;
        b=IvqA1vmO2L5G4OqySuUYkfq+U8EM2mV1v8rM8Y4XhrYC/bh6F0miOAK7ap+QPz2UvG
         /LlKE0EcOv5LlIb8PY+wMDLokCSVYRCLwxHlIcAxFd6F+e4GggroEghXybjR41y3gRQQ
         TgfYujLWouFKKX9HINEu8Vm2mv0T/FZi2qUf95/gnJaC2HIvjnHEjsLmbY3rfFKaFrPB
         r3OZFH3IpQ5KZPyC/UYcD1fgJHq+VgwMc5gbknHbqdp6mFTfy3UGPA9H7jrCBpUSIu4C
         ToxjQvZ8Drpch17BGHGuwcvxrHjbAanHKbOYz6tPyiuuraKmjqkhFVBn+DNVdSCZMaEj
         Wt0w==
X-Forwarded-Encrypted: i=1; AJvYcCWWtOeVvp9FituQ93V3UWwSZiDxqRXgOqlAWCtWHtuI98MmHcg6SwrTqEXG3gzorf44fOL2KuItS7OvLex8gu21La7my09sGUx+
X-Gm-Message-State: AOJu0YyqWnwAxzFM/WgjjuLQE1ukVk7Bzo05MbNm4ShB7f5c1RKkWlgz
	ZbCnWjw8O5oq+ATp4w372e07TBBsxYUQiKZq92nMs1ZgrtjnEeCkl1kCT1BFWm5sa3SVWXvGKxm
	yID2paHDPtelQwRR1r/QWlJu1KaU=
X-Google-Smtp-Source: AGHT+IHy1hz27/M7CCJdy7jubkByV/ricy7SQ/1SaZu49K0sO2ILiJ0flMAUKXi3tBMoVliCrlHPAXO8cbdT1Hz4k0s=
X-Received: by 2002:a17:906:c950:b0:a3b:f043:19ab with SMTP id
 fw16-20020a170906c95000b00a3bf04319abmr2042211ejb.21.1707924711162; Wed, 14
 Feb 2024 07:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <20240213223910.27127-1-jlobue10@gmail.com> <CAHp75VermmAb3J8D1h-PkyAJ0ZH64vzB3vvQFZzRsr4Nr3o7+g@mail.gmail.com>
 <2192956.irdbgypaU6@nobara-ally-pc>
In-Reply-To: <2192956.irdbgypaU6@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 17:31:14 +0200
Message-ID: <CAHp75Vc+pb6YUhx7QOzWGQwmSgGmq2-7NjJHgOBSekKyqdVg5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:15=E2=80=AFPM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
> On Wednesday, February 14, 2024 1:39:19 AM PST Andy Shevchenko wrote:
> > On Wed, Feb 14, 2024 at 12:39=E2=80=AFAM Jonathan LoBue <jlobue10@gmail=
.com> wrote:

...

> I do not own a device with a bmc150 chip in it, but the same should be
> happening in the reverse situation where a device with a bmc150 chip
> starts to load the bmi323 driver. There is a chip id check in the
> bmi323_init function where a bmc150 device should fail at, and the driver
> should release the device. Without a device, I am unable to test that
> this works correctly or not. Logically the code looks similar between the
> two drivers.

But are those IDs different?

...

> Depending on Jonathan Cameron's preference about where to put the comment=
,
> and if he wants a v3 or not... If we want to make a v3, should I create a=
 new thread for that?

Sure.

I also recommend looking at my "smart" script [1] that helps sending
kernel related patches. Improvements are welcome as GH pull-requests!

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.=
sh

--=20
With Best Regards,
Andy Shevchenko

