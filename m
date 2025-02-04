Return-Path: <linux-iio+bounces-14971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE3BA2742E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE333A1358
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4834212FA9;
	Tue,  4 Feb 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRFGvPVe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D8212F8A;
	Tue,  4 Feb 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678452; cv=none; b=idHtVPXmHtjEavLUtFHsEzmpWZ0jvjHKkeX7xK4NzFvVJvS01p30YSAS/T0MehfQujepgcAUui+frOxKYj05pmtRI9ah4/NqnRLeBRYjaVs+gkq1FE6Mk3fJz0sJRvoiC85J4tnfuDLRMjC1m86X9TPRc2ZWHe2EbUOagbNncls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678452; c=relaxed/simple;
	bh=pDIrLSWeJy3dSviTwtlL26N6vEc9xdkdW7yRlu7mu34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoxaLJi09F5Y8QxbIKSkWyaPxApBM/mTpmmsUGKQmm1CCmSiWxAEQJDk25C0ZCMvrbM2YfV8DF+jFFAtxR+uC/htKfxTg2nYeVNzhehjXekA/P8raQ0N61dHJAU/fxFPfw3r6hxxKKtygsAMAjptaiaHtk+AilxMeCk7Lgh1BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRFGvPVe; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5b139ff355so88382276.2;
        Tue, 04 Feb 2025 06:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738678450; x=1739283250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6ppOGuQxsGBAVyDtbXsUiqr4A+WwEVa9piMUHvHBME=;
        b=QRFGvPVetoCgEYA4NMbCzHF27z1m87QPZb+qxpVNRbtXmAo57+q9t0D4beE7Jfxy0S
         Nlli0iz+MpagsEbiM/MURP9Y7AtxipAQtB/Wsua8raTUTRM7GqDMuCZmKU9B45H07ebA
         AwwQWGPJ2Dcl7NiQVWqKs1fwenqgmXzAchSA3RikrYyGufiA+kCWitlu/OJsifA9+kjp
         gRWBx7VB+Y5UaVIh/PXKWrc+SaRhHFWRPPoPnNxl40M+AV0iyjSeb6fbW3DKk8wWsN6u
         GlYG+m05PsW2DopU6ZXz5aPohMZt0AYDGF2DOkuvQoRU8jhR2vH9V1a8b7yJ8cohFm3q
         ifuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738678450; x=1739283250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6ppOGuQxsGBAVyDtbXsUiqr4A+WwEVa9piMUHvHBME=;
        b=qrqYaaqKAJC18bANlW1uIA5EACelPXWrqnCV4gU0RpQCpTD7BZF2t2qoeunPru0vsR
         6MWfANXE3ULHQl/ntkNuUaRKvD8Tdpp8vc1QNXpCWMZj9fLuL/dHi2vtnB0N/pqZ8baN
         86BBJ+5z9uDNGTfBUYBP8K0O33w4TQhcpplUFMGT7shma714u/ie7UP5f8W+w7EIBqMS
         WtWwLwO83rT9tv0za4hSXKHGv10FMIaFjcGbOCSxN5J1o7C+TV2+H+D4Uc/L24psAZ90
         Vxgz3K7VXCZiikKF/BkyJmNJvKwUcpkcXzFAYVI1k5oscmWpaz1jWig5dLayHHo/HjoU
         62/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7h1v+iBmOUzao2WMqc1muSQhFU+GX0G+D0LfeJ4YqEnKpG+7Sh0h2v+tv8f+ND06WmAD7ehAbN7w=@vger.kernel.org, AJvYcCXB+9NyITeu0eT9yHwiYrqauL/2jcfSjwC05/u286gnnXLQSTcbhXX8MZxjAHooR2C72Hu1Qo5J5khcD9HK@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqx3SI6NVvgc+C9s0PEtvp+CU1RfX9qhdnWlWCReGGAtTtzxZ
	GVZY1EmWpnxekQYrK3/Czrm5pDZJhwNRmiUOQyk6H5g16qg12T+vrCWORKu+RbSazkXcIoA0tuH
	LtpRHYUrCf9EQIgsn7ZLXCOpGC7c=
X-Gm-Gg: ASbGncuiCFIOIauxwneMS2i6z3yTQ53Iu58u2+T9xvFEs7tGKHgwQwTIIgNaXCQnhPQ
	l4TGKINQXjFssYwGMQ0twbhCCHNhP+lxRwpw6XAx2faTl1Y3YGmMzfNFN+KpVAt9+rJcvmLME
X-Google-Smtp-Source: AGHT+IG9SEi9BUmXP2moaKFAV3VsV1S0Rn5fTPNf3QFRKmrmxjJxox4l1v+JcfHj7CBPl1Oi9WvQ1QzmqnSgLN4J8hA=
X-Received: by 2002:a05:6902:1589:b0:e4d:6e39:ce19 with SMTP id
 3f1490d57ef6-e5b12ffda21mr1290570276.4.1738678449970; Tue, 04 Feb 2025
 06:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128120100.205523-1-l.rubusch@gmail.com> <20250128120100.205523-2-l.rubusch@gmail.com>
 <20250201163559.015b343d@jic23-huawei>
In-Reply-To: <20250201163559.015b343d@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 4 Feb 2025 15:13:34 +0100
X-Gm-Features: AWEUYZkylprq0_pNxdcg0WQgFbs-f61zjz1EW_8_xNWOAp_l3FuCeB2LTTU3ZKI
Message-ID: <CAFXKEHaaYXpcQ92ahWwuBbsCJYEzCi=tUSkpjWMkzhfrCOT_Tg@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] iio: accel: adxl345: migrate constants to core
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Feb 1, 2025 at 5:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue, 28 Jan 2025 12:00:49 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > The set of constants does not need to be exposed. Move constants to cor=
e
> > to reduce namespace polution.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Hi Lothar,
>
>
> > -#define ADXL345_REG_INT_MAP          0x2F
> > -#define ADXL345_REG_INT_SOURCE               0x30
> > -#define ADXL345_REG_INT_SOURCE_MSK   0xFF
> >  #define ADXL345_REG_DATA_FORMAT              0x31
>
> Normally I'd be entirely in favour of this, but...
> I'm not sure we want to leave one random register here
> and move the rest.
>
> Se can move the stuff that isn't register related, but
> for the registers I'd prefer to keep them in one place
> and I can't see a clean way to move them all to the core.c
> file. Even separating reg address and fields within it
> makes for a harder check against a datasheet etc.
>
> So I think all we can move is the fifo size :(
>

I understood that it could be one of the first follow up patches to move th=
ose
defines (parts of them?) over to core, as here in this mail:
https://lore.kernel.org/linux-iio/20241214123926.0b42ea59@jic23-huawei/
Anyway, I already had presented moving the constants before, when you
had decided to keep them in the header. I thought you changed your mind
on that, but I don't want to bother you with the same issue over and over
again, probably I missunderstood that here.

I leave the constants in the .h file then, no problem. :) I can understand =
the
intention to keep the things rather together in one place. There seem to be
pros & cons for both.

>
> > -#define ADXL345_REG_XYZ_BASE         0x32
> > -#define ADXL345_REG_DATA_AXIS(index)                         \
> > -     (ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16))
>

