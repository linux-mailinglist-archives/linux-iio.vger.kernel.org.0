Return-Path: <linux-iio+bounces-2718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B223859150
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 18:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52706283252
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C907D414;
	Sat, 17 Feb 2024 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOFO3PIs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723657D407
	for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708190946; cv=none; b=llLZuTZGeuuYvCrt1Bdrz0VfIC5A4hhKjTtpa8PxDKwKGhDUReTCSnACkmFrkTCrwP7qszqRvr+uHHYggNBBgPmvIVmHYNkgsAzWxQsgOI+W3D4073XI4zhJOJ40/vB8O1obkCSj7Dlnwnm80QTvc4t19RqfZfY+5uRt4t0Teks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708190946; c=relaxed/simple;
	bh=Dj/6AkIkjLC7bPv1qU3NzvYtFki/yiHmYfDBexN/h6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2w26bwipsdK0pAaDvhH35qaY0T2wDokrIUyL9oWtVJUh6gqWvw1RFc8OGdrCK0/r4MMFp2NLUrUz9sHNNOlJicpcZSoQq2MssrrrDhyQmM0llXg2aAsAoIzYMfKuXiDf+0gKJL+oypAMAsGyz1IyvHiXO/OREJ9vqRnlaedW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOFO3PIs; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2997c5fe6abso23621a91.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2024 09:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708190945; x=1708795745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGXKzvETzQ7leFQdJxZdd/q58yII5wG0Ske8BeFA464=;
        b=fOFO3PIs0kCkGrj+48W3TX3mNmUvd2grf9CEtlrORwhdT4YjUbsqSXh7PQqsUaZz6a
         ZmAUNf3wGGYS5cYvf+8HwCc4/q3Yitcl9SO8qXlkd4oodln6/S7rM8XKYJVYvtVcUg09
         LzytvTAbwS1L//I4+1WB0bX7Wn62nM4LmtyYG5foM5OOeVyx+qjKyyakIT10OuAnnCiB
         sAN3UOP7I90crm4g71vcggFmL17jz8a9dtj99RikICqyDHusApgWpn3WpSFqnjNJJcbx
         7RE/NY8ywRpBwI3jSRoFzt/HqBQU0hCcjKg4Ghul9IZSmOhU/mtRAJAH2p6RSxvaYjMf
         EIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708190945; x=1708795745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGXKzvETzQ7leFQdJxZdd/q58yII5wG0Ske8BeFA464=;
        b=qwbhbeYUQtJlasr+lOSOD7qp55wSePbF+nFafkvgliRKTL6KzXZledVJp1t0+S1Z2O
         Ghy4j3AEsgZs09J5aPDzuTLrrfISyDM3d/+f8fkYw+6jEvymrI7EBrqF2ObWcQnQbqQH
         p5D03yVmPREAkvZvwUYTFui8HVC2t1iVCOG4GtAMJN1O14M2VSYw3YVfaQ9w3GUxAyPo
         xgu+HmK2kJ1KUGJDidQPiroU8e66BXbcmdWHF2fC5rSMo4YxT/R7wgsmUImWYufjOPJf
         UkSaEoza6CmB8wiZfdgtSNPh7pwJ/+S0VXP9YkL6ZasfFhet1gv0y8B9Z2XkWNoyqOLF
         Hi/A==
X-Forwarded-Encrypted: i=1; AJvYcCW3RXNL8K7vrpeDV+keTLONO04LNgA6it1/4TFOIQ3vwe3YxE6e0mVkMxhqBeNr8GYAXng3OjtiH6Sdsc4hZ7nuZrl3C9OCiB1T
X-Gm-Message-State: AOJu0Yzud0X8JIV8f+NHwHBQg0O7yUPLmGS0ErubdQzyh3iVEnrW8F3+
	Bi1TLBDE3pQYmIZip9PC+UrW9H7pJICPnK1nGbqJUdM+VTvGHrYNm5/lesiikZD9A90bE6QSoES
	nWGbPE8Ax9SB/Jm9nGtZcrPFiBTOnxW7LJBM=
X-Google-Smtp-Source: AGHT+IEt3YsQ16Ja+hPdKAIDcJSN5YL91+ALBOvWfzpZrEhCsvPN0RDDOFPygmWyxVpwJbPQCn5RREsMEGu0ilC2UJ0=
X-Received: by 2002:a17:90a:e602:b0:299:29bd:ee1f with SMTP id
 j2-20020a17090ae60200b0029929bdee1fmr6231436pjy.0.1708190944600; Sat, 17 Feb
 2024 09:29:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6rpDwZaCJOpLEYayVW8_aXQwKdpcLCDSRjbTNk1rr43EPriQ@mail.gmail.com>
 <298cba01-25a7-4c5f-92ee-e8d3254f2eca@redhat.com> <20240217172219.600aff63@jic23-huawei>
In-Reply-To: <20240217172219.600aff63@jic23-huawei>
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Sat, 17 Feb 2024 09:28:53 -0800
Message-ID: <CAF6rpDwL4KKPgrjdBQ=7=KkGJqBtVncEXoy7pBQpOYcF9ta_TQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add bmi323 support for ASUS ROG ALLY
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	jagath jogj <jagathjog1996@gmail.com>, Luke Jones <luke@ljones.dev>, 
	Denis Benato <benato.denis96@gmail.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	Derek John Clark <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jonathan,

Thank you. Yes I saw my error on the from lines in v6,
but I thought that would've been a silly reason for a v7.
A better reason might have been to add the reviewed
and tested by lines for Hans.

Yes I think the comment lines went over once indentation
was added. Sorry about that and thank you for the
adjustments.

Thank you all in this thread for your patience, help and
guidance, and hopefully if I submit more patches in the
future, it will go much more smoothly.

Best Regards,
Jon LoBue

On Sat, Feb 17, 2024 at 9:22=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 16 Feb 2024 19:45:07 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
>
> > Hi,
> >
> > On 2/16/24 19:16, Jonathan LoBue wrote:
> > > From: Jonathan LoBue <jlobue10@gmail.com>
> > >
> > > This patch series adds comments about a duplicate ACPI identifier
> > > between devices using bmc150 and bmi323. This series also adds the AC=
PI
> > > match table for devices using bmi323 to allow those devices to load t=
he
> > > proper driver.
> > >
> > > Changes since v5:
> > > - Updated patch titles
> > > - Add patch description to cover letter
> >
> > I have just tested this on a Chuwi Hi13 tablet with
> > a BOSC0200 accel. I blacklisted the bmc150 driver so that
> > the bmi323 driver would load first. The bmi323 driver
> > "successfully" fails to probe and after manually loading
> > the bmc150 driver (to fake a module loading order of
> > the bmi323 driver loading before the bmc150) the accel
> > works properly.
> >
> > So from my pov this series is good to go:
> >
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Regards,
> >
> Thanks.  I've tweaked these a fair bit for minor things whilst applying.
> 1) Author (From: in the email) didn't match sign off. Given address was t=
he
>    same I think I'm fine to just fix that up.
> 2) All the lines had a leading space.  Deleted those.
> 3) quite a few lines went just over 80 chars - I've rewrapped the comment=
s
>    to avoid this.
>
> Anyhow, with those tweaks, applied via the slow path (it's not a fix as s=
uch
> as the right driver was never loaded) but I'm fine with a request for a b=
ackport
> of this to older kernels after this is upstream (next merge window).
>
> Some of those would have been caught be scripts/checkpatch.pl - make sure=
 you
> run that and either fix ever warning or have a good reason why not (there=
 are
> often good reasons so don't take that script as a rule book!)
>
> Applied to the togreg branch of iio.git but initially only pushed out as =
testing
> for 0-day to get a head start checking for anything we missed.
>
> Thanks,
>
> Jonathan
>
> > Hans
> >
> >
> >
> >
>

