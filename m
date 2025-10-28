Return-Path: <linux-iio+bounces-25564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D852BC13E06
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85C4F4EB340
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1152301011;
	Tue, 28 Oct 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL6qyV9f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F72DEA68
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644219; cv=none; b=OzWA+VxNUMW2hiZsSDOvq0XIV4/GZ/fLfTv2WXMcao//U47hkpCcqCkuLj0c6mXVdd16Qwq/2J3yQoktknD53uGrN/fxSB2M8HAUoJXF9CYoaWfS+t8LrlWtOcjpJy1L4MiOlbfEu650RkO0p6pAGg/X0/QhrS0WbQK4Zsy0OGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644219; c=relaxed/simple;
	bh=/5SjHDf+g60VeDF7tKkxP5WygZLqUjkEHTHrJsfqiiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRegmFk7ylptR3pj7/x6PqwOAznVzN37aNYYKyRGJ8SuW3UuONjDnEyekGjnyoO3V1Ty8z3vldI1yh5HId7Ejpxj1EJwugz7yMfENOpMzuXD/YqSx8AdtGaRy1S7vxFasPvtN/H9mPUCOv5MVjKnsFjfSABYhq/Ykm227+16tBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL6qyV9f; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cdba2663dso4120460a12.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644217; x=1762249017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jG9v3PVJPIbaBd5kVxUl8s2RTs4/RBdrWqQvfRNMgQ=;
        b=SL6qyV9fyuwT/n4rxBfYCX5zs8fHpPP90jK3U4Vt5CsoZ2bMrJY8HphPYd8HSPWIew
         CqHK4aSg2tUYWrn7nhYIaF06oT4oA6UpQobpAstzci02/884Gvfsv6EHTI68pBk/r8kf
         ylvcC8re7p1gkVn5NEX6uFqLU4NH64TxfMzyVQNDSwM0897cLqlbrqeVIClVWWvkz6rc
         9zkuW2VEmqNPwvKUnEJ+RcmYBvzw6JJg17rectYf4+CCbZZvc0ZLSQTfQ1+32n3nSzly
         zKPFnkZ7JTzgvjK40fTAFsiXAavgAbEeIQ6Y8VqqnH2to5Y1Jua5yHEeRq94W80dOFzQ
         7PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644217; x=1762249017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jG9v3PVJPIbaBd5kVxUl8s2RTs4/RBdrWqQvfRNMgQ=;
        b=XXbbRydO9FKb9QLUjGpS3DwzH5cS+J5oTom3EqTWXth2PaLL3mbhGYtQ1urVBHtsK/
         gTwr4V0tXdVXkkIgv7WhYumHK6m6VK3I3j9qh+FxfPz0COZDG16aA6gob202HWjGOCFv
         XYODl8NAlbX/6vnZJvQcucnJi5FApx9EIWVk6djjDv8V6wJ3qC1Y8iBXKpyBnO5Aqwui
         dsmjRU/ASJXf/pmSKiQ10dGq0ST4LXo4MxHOnnNxgfV59YICWhbZNlKTdC6/RCOvD/na
         8F0uZsmp0GzbNzuVO7ZV19kMsS7WVCGIaZNSNIzKO79iT8Ia/Ty1Iewp+I0/50HvHzex
         eNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqxfZQ0Hmu16lX/cDpvj4mnySCVlUDEyxk3s47j3IHQx/tpQ+iuDe33HqIJtmYkRZjsIN8oVicQ58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOVS5yVfw71hH5n0s1D+B7PNK3FkAxwPJFdMT8mxBX/HLA3IK
	pBJP+sqUfBFqi1C4+o7e54IL+LxdJBFijzW6CIFmUcB+dc1xD9F8XA6wjbp/eDGn5TnjAa6KXJx
	xsE1q8OwCMWPXp3A9ugicFd5mg8WUxPY=
X-Gm-Gg: ASbGncvXXMA4Q9hlTUkrxvLkn7jpyLIizoftjE9zAMNLR5u/bBZWiRnyt5OOVdSYVKv
	QBumIM38WTKzmdlm1CFVimIHgug0wVZR4jwHpir4otMfeCydS1Js5Un7pAsHFONeTzIytdp1zOR
	yns0dixY5Tr4qDkBbgNfTsqp5q5wD+FcJD36SSdGTXM1wzPGNlJkh0QdH/Ss4tDh0V15YYa2sIm
	B8lN4UhUY4o7jBQDYgOPitKXYl73lRi3w1o4/Ye7kRUE2x6re/uCPm5esVDWatCyxTYCFk=
X-Google-Smtp-Source: AGHT+IE2gOBCubvPoKT3rGM6v15n2dbkd2eHauDGUIwO5XTEfAeytVe1qP5Mq5hcSyYkW09TvDxnGMeavjeB3G54Bl4=
X-Received: by 2002:a17:902:ea0a:b0:269:8d85:2249 with SMTP id
 d9443c01a7336-294cb3821afmr36873395ad.22.1761644215891; Tue, 28 Oct 2025
 02:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
 <23069e05-82d3-422f-9af7-fc100d4d1466@baylibre.com> <aQCITnF4kft6g64z@smile.fi.intel.com>
In-Reply-To: <aQCITnF4kft6g64z@smile.fi.intel.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Tue, 28 Oct 2025 15:06:44 +0530
X-Gm-Features: AWmQ_bk4u-dbbnMYGRNeHJ1bkT0p71uvtHg2Ff8MalXPQTncpZhceKlNJkV7h70
Message-ID: <CAL4kbROq0ko9RT0VENAUsk5j621U8LNkQKz7CxQNk7=C23p7aQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: fix kernel-doc warnings in industrialio-backend.c
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, olivier.moysan@foss.st.com, 
	jic23@kernel.org, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy, David,

Thank you both for the reviews and helpful suggestions!
I've sent v3 now, which includes the consistency fixes (changing
Return: to RETURNS: across the file) and the other points you
mentioned.

https://lore.kernel.org/all/20251028093326.1087660-1-kriish.sharma2006@gmai=
l.com/

Appreciate your time and feedback.

Best regards,
Kriish


On Tue, Oct 28, 2025 at 2:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Oct 27, 2025 at 10:35:02AM -0500, David Lechner wrote:
> > On 10/27/25 4:21 AM, KRIISHSHARMA wrote:
>
> ...
>
> > >   * iio_backend_oversampling_ratio_set - set the oversampling ratio
> > >   * @back: Backend device
> > > + * @chan: Channel number
> > >   * @ratio: The oversampling ratio - value 1 corresponds to no oversa=
mpling.
> > >   *
> > >   * Return:
> >
> > I guess it would not hurt to change this to RETURNS: to match the
> > rest of the file either.
>
> Good catch! KRIISHSHARMA, please check the whole file for this as it's no=
t a
> direct mistake from kernel-doc perspective, there is a mistake from consi=
stency
> point of view and hence needs to be addressed.
>
> ...
>
> > > + * RETURNS:
> > > + * Pointer to the driver private data associated with the backend.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

