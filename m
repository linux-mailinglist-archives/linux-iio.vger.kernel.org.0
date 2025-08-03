Return-Path: <linux-iio+bounces-22226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DADB194FD
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 21:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2421893847
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622C1DC985;
	Sun,  3 Aug 2025 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ0rjWk9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAF22EE5
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754249093; cv=none; b=FduRg5KkJJ3+hS4p+Lcw7/kNUzWlMBYFoEtfoHlr8VhcyAv68yAWhN+SNcj3FCJ2TiJGrjmL8WoyjWRsbGlBEdidoRtnwMINykOskx4h+buUcydIfc77k38eg9le8mkiBMEKUd4KJA2SsHXp6MFOCO4z7VAgk/0CLuIJz7q3bZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754249093; c=relaxed/simple;
	bh=MW8ougA2fRLswkS0vDi+cKusfKhQ0RK26JnkDZw1Fl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MukZTHs2qOX8KbgCy20kq8mSCxKcv0aRbt5PjYoIcPbjIhz/0gd7yCPtJDJtYED/jZ/z5Uya2riNUCPbkT+zoo8u305fOMpMGXi2h6cYPCoAkhzf0lc7/5oUSEKRmABsXXcttigQkXat6G1cICjHkQdhOQZQ/6TLO17H8nI8RFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ0rjWk9; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so780395566b.1
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 12:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754249090; x=1754853890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Diu+EcLjkyEliNAsjLF/fVIqpArPCOGlI7Ib0C3H5Vw=;
        b=MZ0rjWk9Xrh9UoN6Bm2aQW72WBDrrz9P6QCeHSmMp30Q87e06Nol/d9ynVLe4RwT+o
         ujqCBvU9K0Pc830+hEqLS1+EVLfWk46JPJh6KejuX90fdJTOtPX0FIZNB8GoFdxcfQ/7
         M5uqEjBXBr4gdt/UhgnLSIrOAr9iBusvO9sXg48BG9mvAPR3glWnpLh0zbAozEJmn74w
         BLH+VZIdrX2KNpstwSZuMRGGczVKaA/+r6ee2+cUdEdpWqlMmdjfi1PEzqCGYuf12eJq
         7sRUrLjEFXe+YQrZQj0VLDj1w6vt4hTvkXoTpCLG/I0XmjVLHMn9hnsXPfZGeO9bgvE/
         6bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754249090; x=1754853890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Diu+EcLjkyEliNAsjLF/fVIqpArPCOGlI7Ib0C3H5Vw=;
        b=psifEpR1tBwri81LjFk5m2r4FsC6d5pnK9pKMLmg89wF4Pq15Y6lGgP4H3TZq5fwD8
         LVeaCpD6Jw9IQS/Hj+/zzhlOn3tC+Jrp0bNcsTqtegBi5HTEh5g4mxgBjP2iGXohmS6B
         w+HiHXWjMNvBYFbJV8m1xPTYAlAGEiH2CB3EmHmIaHeXSemPdwrEIDeI214IAYtyiveQ
         Tw93BWjHoIztDsb1oXBT8s4AwP0Pfaf/IFjR4tjxs5w8Aau8721/+e9G6/39AIDWl0Bu
         18aF5TysLpKdO7qae9XoQgk90P3d7bME/9CsezObpDzjpS+6fYP0Agwd1vedatSnSwqb
         nl7Q==
X-Gm-Message-State: AOJu0Yx9T0QOWdAW2q7/tAyOj9b8Mdj8JPeohFV5LYtNWpc15KgJ4F3S
	JofjkkAFV01nl7kPRQBFXxmwQsLtrPumdeYnmLFKlOgYkNmEwOKEBVMxPTCebsrNK3ozx0kkW7B
	kYCTGzQLwwPeWQB0HjwcQr1XluGMfl8Y=
X-Gm-Gg: ASbGncsxb+TkxohXpS+D0lSlU7cJOdn7OUU4xs+EqIFeRucvjjEzs111tFA+VubFGn1
	UF3koiX8c3xi9+m4o19UHTjrpesyeNlonzXDFrQ4eHcuUlEc2QghOI2Vk6V/bYBEiHZiSxOAB2m
	lZFP/MiV0fSJBCLFqWnscrZNPQswN8YX+0EIf+bVS3SmoLYpl50SGgo+2i4U/e7EE7Pjy3MfAkd
	8cclSoVvA==
X-Google-Smtp-Source: AGHT+IFP9s4WB4mlTJEPKXLAiEH8vkzlPYiY5ng1da59K16BmdVKacOtMQfWo3dWj8dQtNyHuNNJ8NXICLqEXj1NOkM=
X-Received: by 2002:a17:907:c13:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-af94020a369mr685652566b.49.1754249089970; Sun, 03 Aug 2025
 12:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802164436.515988-1-jic23@kernel.org> <20250802164436.515988-7-jic23@kernel.org>
In-Reply-To: <20250802164436.515988-7-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 21:24:13 +0200
X-Gm-Features: Ac12FXygMoQVyyTPbJ2S4q3Av72YZkLibHxKfOZsBhEm_JhlrrbwcxFUFypA4aM
Message-ID: <CAHp75Vd3czzACQy4k1fUaFea9+ZG+y2dnz_3kcbG+x2g6xw_9g@mail.gmail.com>
Subject: Re: [PATCH 06/16] iio: light: acpi-als: Use a structure for layout of
 data to push to buffer.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost <astrid.rost@axis.com>, 
	=?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>, 
	Gwendal Grignou <gwendal@chromium.org>, Christian Eggers <ChristianEggersceggers@arri.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 6:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> Using a structure makes the padding and alignment rules explicit,
> removing the need for a comment.
>
> Also move the storage to the stack as it is only 16 bytes.

...

> -/*
> - * The event buffer contains timestamp and all the data from
> - * the ACPI0008 block. There are multiple, but so far we only
> - * support _ALI (illuminance): One channel, padding and timestamp.
> - */
> -#define ACPI_ALS_EVT_BUFFER_SIZE               \
> -       (sizeof(s32) + sizeof(s32) + sizeof(s64))

IIUC this definition is named in a bit ambiguous way. This size is
related to the driver for ACPI light sensor, but it doesn't mean that
size is derived from any of the ACPI specification, killing that is a
right thing to do, hence I like this patch very much.

--=20
With Best Regards,
Andy Shevchenko

