Return-Path: <linux-iio+bounces-22224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F56B194F7
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 21:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002A43B0C15
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 19:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992701C8621;
	Sun,  3 Aug 2025 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqBEKkOT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C53F9C5
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 19:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754248628; cv=none; b=DyiBGEVAOsVP1LjwpNLJZdaKbjt2r/86KzzaIfs6WRYG6VIcMaxa2YGC1lNww1hfMC0WAv4YYOBe15ErasZsOw/tCQuY7vFFVLg7rtraq6KyTEzeR6wyrxwQk2ZWcVaNSRzefaz91vvtBnrgeHof1cxKYBd/KY3A7RxFGUQAx3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754248628; c=relaxed/simple;
	bh=jMZgQ4MaH39mmPSv6IwHKqyOqiXSog2RUT8f/B59QnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/RCrwH6H3TgOjAPiRj8gQycmVaVvk3MIDE+yZ/Lhk/XjLgIKASM346NG0lfNPhXXAlMq5QG7LsYOqeh1BRvOe34UIqjyhJt8qZo2ZAPW4UDHQK/jfXBCnss3LHraozNkar6b3qV9L8Dxw/UO8TyDzFcGHpo4ED89uLkn8ZVIXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqBEKkOT; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af922ab4849so503780466b.3
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754248625; x=1754853425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Redh1TcC3oylIeRcbk3pByRnGzJu/vqqZdm6Wyx5W8=;
        b=ZqBEKkOTrzZiSlRcKMXft12vb6VMst42GY1iqXIaDLNuenpeUIH9cNJHz4dApakLOi
         W33smVkk7mcHCgLl7qvEftLW+hQopp4+OE6J41BJA2vVEq42HbfBtFRaBZSHteSBnwgs
         72ESX11ZzL0PgYXcCS2W386yyASWqaPoWy5puCBiCUZAsMUKD5aY0f7+tVfpTaAZzQmq
         vBONNsGBshDfh3+F1f5fDxpi9TSkU9+YlDyyOJFsivwRWyN4xG9odCwy1GhyYydj1p4Z
         zDUmC0YAtxFN5WmjE+rsxKSQupsRh+tfRiiwQcc4B8ONos6ShhFbRnbnSAv3/ofvcJk9
         me4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754248625; x=1754853425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Redh1TcC3oylIeRcbk3pByRnGzJu/vqqZdm6Wyx5W8=;
        b=YaAJmDuCAHF9+XBdQM4+/6O0IbMZu6YxmmZomrzzjCbtioo1eB68vHulkE0kQusyqi
         KGPDfqh0beDBm0Yr6d6LouN7lB6Wvdc9YT+bTPuBOBeGItWvdP1uTWOzTdyRxhHBgV+K
         FHGG2DHVg8O1ABs2PGdWyppWK95gDrxgq+6crhLpIueO20OF84T06cFt8JjXVc9nhyFJ
         d91ug5VeMxnO2q56mfxTw82f3kaFt0PFFO8eTWIL9B9fwjqst0YuNW7RvpWYoOxHCP/E
         0fXne5rJUNurNppnOjp+IT3afbCgLxlzman0TO7shwllnQVhCHpTMIsVUA1bWbKuYGB1
         CwLg==
X-Gm-Message-State: AOJu0Yz4HX/LPvLjdKZwEUyswZMLUP2LRiDHBYGKk83D3l5ir3RfL8PV
	A71DDhsgrq5moIJRG2tS94/qp8vJyHScxpYyZJXSqta7wlvZYXOSMv/PCEA3IVMg0v4hu+tOwzc
	fq1Gws6R737iiFwhCh1EmQKURzPUBL60=
X-Gm-Gg: ASbGncvQkQwo+iM6IAKsoNjNVnsl1SQ4G/wggEq5F1y/UyUwgkTfEdsldiWxSKLd/mS
	cgqJWxaw6NO/ztdJEyfdV/CqGTTuZYPMupNnGq2v0RNT/R1qvO6yi8fpdrg8IyH/qwLNfpvPywK
	OVOxEgbikSfNWoWmruh/tYY9EQUDCyvlRqd99xBbIFiNvhTT4oifi2p9EN8RL/z3LnElFanVkg7
	yRyrgSrAA==
X-Google-Smtp-Source: AGHT+IGq4eYgOJgwKjfO7T4tNOvPwSWygtS3pfuE+Ixhj4jRByaejOU5bPxHnwcigJ8iehqZvfPEQDx/oYNoinhymWs=
X-Received: by 2002:a17:907:9407:b0:ae0:cc5f:88ef with SMTP id
 a640c23a62f3a-af9401af514mr695138666b.32.1754248624734; Sun, 03 Aug 2025
 12:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802164436.515988-1-jic23@kernel.org> <20250802164436.515988-3-jic23@kernel.org>
In-Reply-To: <20250802164436.515988-3-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 3 Aug 2025 21:16:27 +0200
X-Gm-Features: Ac12FXyLDlLfcWf6U54-2ShbRCl0g6bLOjwz_SgSJT7lhwxhptAX_oS9R8aNF-I
Message-ID: <CAHp75Vd0KUs25P8cHM8EaAdLbXcDASXLs_nao8Qoee-pqQUF4A@mail.gmail.com>
Subject: Re: [PATCH 02/16] iio: light: vcnl4035: Fix endianness vs data
 placement in buffer issue.
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
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> The assumption is that the channel ends up in the first 16 bits
> of the buffer.  On a big endian system, the regmap_read() will
> read a 16 bit value into the 4 byte location, leaving the value in bytes

16-bit
4-byte

> 2 and 3.  Fix this by using a a local variable and copying into the

a a --> a

> current location.

...

> +       int val;

Why signed? regmap API uses an unsigned type for values.

...

> +       *((u16 *)buffer) =3D val;

I don't understand this fix. Does it mean we simply transfer from HW
to the user space in whatever endianess HW does this?

--=20
With Best Regards,
Andy Shevchenko

