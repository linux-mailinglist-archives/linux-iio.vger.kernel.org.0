Return-Path: <linux-iio+bounces-13927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4AA01C1E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CE07A165D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Jan 2025 22:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA41CDFAC;
	Sun,  5 Jan 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLd/bpeZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FEC36B;
	Sun,  5 Jan 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736115773; cv=none; b=ur0FJ9geucdvhTcBr+Li4uDdbuMyilHF1zE/cf8f+oIvkn3fEKPF3BSrSSz2riee+5VgWovhfvABN8Ug85XvMv/qCXidj3MTHGAndXMrXu7O7gbRHL7kjhRtUMKYFUmJA+Jup04LUnwWfUH8B9zcX6KKjmwMVB2tZGbNH98vNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736115773; c=relaxed/simple;
	bh=T1rmPiBsF4oxZ5eblwm2G4vNoklpFfpNow9x1e322xc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krH15BosxRLEV0d5QKH1f4SoB24yEwMnJDuuU8q1GXQvUQPaK+w7gjtn5EitCVU5qSX3mhNAQhI3T0uN/FtRzFZbxNGS0OtVJZXx7edL8i15fdmXNv2qhor4FCOKd/RaHkqvx8b9qRo5TKDJQWh1qndod0bErJoHtSP6mYxArV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLd/bpeZ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e39a1af8379so2061432276.0;
        Sun, 05 Jan 2025 14:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736115771; x=1736720571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5l0tN5/exAK9v90H1pAawUOcmO8/HuuhKD9iJ+lDIQ=;
        b=JLd/bpeZDmbtWrisDX0lm+wl5AM9JHbLK0aGJ8Z/kZtTT4iW8wTzuGqzqSOR1cY+aj
         mv8xmufxaRp9Wo4o2T0kH1922nlm7ZS24tUQ7gCYjVZfgYlnmU04lCksl63VQ1KkzkRy
         HFzbTKePigOWxd4UP0950/Tg5Sqy0Dru6+/OH1/sf1C3Cq+Z/b/CPWn/amuDP3dqdF64
         In/xeEmJxtfJolzeiu8NN2+Rs795NzXFlHz405T0tvPK02NxoyKJbp3xIw1VfI2ShggE
         34TZt8SOPpz8lojWtMP1hc5z8voAKW8nSEHcdk3G3R76lGlOIHxSdKsIjBge2WhJ7U7+
         SHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736115771; x=1736720571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5l0tN5/exAK9v90H1pAawUOcmO8/HuuhKD9iJ+lDIQ=;
        b=HgqsF6IcX1MLs5C9UP06ng2CnymGSYVdRWv945qONHiwXHaQjfb8CvvyA5p75LG0Mw
         41bZ3QdsKX6CJ0A17dIHvioloSHUzkMM1H0rq70BBt6OHvFAcWL1tGclWjtyZdJG1Dpt
         MIMG1bmY73Gc5M6ZeBKZR38S8WlU0c6bZK4o5Cz4EKr7oOivtkab4QFqJFCXf3efhNYe
         oLD61hrQxSqDRWBp6z0xupRYxlTJBm/W0STQT7zCdeGhhtjkUfu8yXp9tOwERxwdqY5o
         DXGUq6RLyWoeqYv27hk7Mh8QG1tC0LuyqHWBh+Nae/8xKthn4FM5RKsDVAQYwCteTjc3
         tjhg==
X-Forwarded-Encrypted: i=1; AJvYcCVPAiDAK5zOr/7UTzFqu3uB3f5cBGOcOsrO5JeaNw5uDh5h5NwmNENkyheZeidsi0ycJ7gRFfoCdek=@vger.kernel.org, AJvYcCXJOjTSNI59I8s2PJtGrNW66wBfzIYvNpzCO5Z80x9Ops7rDa87CBjRHMKJdeit0FR20EwR/uwPEIUHzp0m@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUzL9JmcDTNuPxijbtvRY539u26QkSWzTbkT5WApMIm+mBexa
	iqEaNBAu6O0tGzEH0MBOzx68hLJq0B2yMmKs0erLLySKeklEWSPjU/0op/JWeXAoH79GbqiFZTc
	lKVZjoQaDVmM/jMqo3Aa7EXjRUMbmgg==
X-Gm-Gg: ASbGncuecAxXkIhL0ruWiHm99RSSasWtJEtO0N31ZYOksxHRRdgK+EmlJP7yeHXLa49
	Jj1Ce4e4ukn9Hpk1E5g4c68n24O26jSdS/NQ95Q==
X-Google-Smtp-Source: AGHT+IHbrvWSuZKo+9o41z17p9Ux2e55cyZLDTk7yC+qftH5Ifr9x6R4Z943H35oHrI23WozKKgQeS+8eiXX4a7kwsg=
X-Received: by 2002:a05:6902:15ce:b0:e4d:25c6:c3b1 with SMTP id
 3f1490d57ef6-e538c1efb27mr15514102276.1.1736115770783; Sun, 05 Jan 2025
 14:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228232949.72487-1-l.rubusch@gmail.com> <20250104130916.5a25b5bd@jic23-huawei>
In-Reply-To: <20250104130916.5a25b5bd@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 5 Jan 2025 23:22:14 +0100
X-Gm-Features: AbW1kvbJ1v7qgA19J-tvHDKqPBpgZwftBXH59UfMbUwVKX5V-wxmXA4gzw7H1rk
Message-ID: <CAFXKEHY7C_75oyO2E7LRQKgDjoEGrBWfZmKT737R6GCj4ykq1A@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] iio: accel: adxl345: add FIFO operating with IRQ
 triggered watermark events
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan, find my answer inlined down below.

On Sat, Jan 4, 2025 at 2:09=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat, 28 Dec 2024 23:29:45 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > The adxl345 sensor offers several features. Most of them are based on
> > using the hardware FIFO and reacting on events coming in on an interrup=
t
> > line. Add access to configure and read out the FIFO, handling of interr=
upts
> > and configuration and application of the watermark feature on that FIFO=
.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Series applied but with a tweak on patch 3.  Please take a look at the
> testing branch where this will sit for a few days,
>

The patches w/ adjustments are looking fine at the sensor.

[Do I need to say ACK here, or the like? I guess not.]

Thank you so much for applying. I verified several watermark settings
and could observe /proc/interrupts increasing with at a higher and
lower pace, respectively, as expected. I could turn the feature on,
off and back on. I saw the measurements on my sensor as they used to
show up before.

I'll continue with the implementation of the sensor features, and I
will have a more thorough look at it anyway. I really appreciate the
adjustments. Again cleaner!

Best,
L

> Jonathan
>
> > ---
> > v8 -> v9:
> > - move FIELD_PREP() usage to a local usage in adxl345_core.c
> > - remove ADXL345_{SD}_TAP_MSK macros
> > v7 -> v8:
> > - remove dt-binding quotation marks
> > - add DMA alignment
> > - fix indention, formatting and text alignment
> > v6 -> v7:
> > - reorder dt-binding patches
> > - extracted FIFO specific from constants list
> > - reorder constants list in header patch to the end
> > - verify watermark input is within valid range
> > v5 -> v6:
> > - dropped justify patch, since unnecessary change to format mask
> > - added separate dt-bindings patch to remove required interrupts proper=
ty
> > - merged FIFO watermark patches
> > - reworked bitfield handling
> > - group irq setup in probe()
> > - several type fixes by smatch and tools
> > v4 -> v5:
> > - fix dt-binding for enum array of INT1 and INT2
> > v3 -> v4:
> > - fix dt-binding indention
> > v2 -> v3:
> > - reorganize commits, merge the watermark handling
> > - INT lines are defined by binding
> > - kfifo is prepared by devm_iio_kfifo_buffer_setup()
> > - event handler is registered w/ devm_request_threaded_irq()
> > v1 -> v2:
> > Fix comments according to Documentation/doc-guide/kernel-doc.rst
> > and missing static declaration of function.
> > ---
> > Lothar Rubusch (4):
> >   iio: accel: adxl345: introduce interrupt handling
> >   iio: accel: adxl345: initialize FIFO delay value for SPI
> >   iio: accel: adxl345: add FIFO with watermark events
> >   iio: accel: adxl345: complete the list of defines
> >
> >  drivers/iio/accel/adxl345.h      |  77 +++++--
> >  drivers/iio/accel/adxl345_core.c | 338 ++++++++++++++++++++++++++++++-
> >  drivers/iio/accel/adxl345_i2c.c  |   2 +-
> >  drivers/iio/accel/adxl345_spi.c  |   7 +-
> >  4 files changed, 404 insertions(+), 20 deletions(-)
> >
>

