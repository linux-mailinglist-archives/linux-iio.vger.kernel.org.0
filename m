Return-Path: <linux-iio+bounces-17834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4088A8161F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67157461C8F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C001241683;
	Tue,  8 Apr 2025 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiN6JWfA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271F22F145;
	Tue,  8 Apr 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142191; cv=none; b=c/aXlCSK33RH79SxQivhzv5nx1UKzYX2krW/3bJA5jV3ufN9ktBqWsXjqrqdtAO14Ov7qOVsh0Y2fN+T0eXwekAAwEsuPJfhAn0EqwXEAC4gS4X5sjbfG/GJGfg1VoF0gdfu2DTB/NQBgcS6uMd+BTvCc/LqmWtjVGlCGqY+P/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142191; c=relaxed/simple;
	bh=qjwrFyqSZiIBplQuQi4BEbeIde22oGa7JC/EofrU9aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4cd+U9sWBBQgtkMa8xsfGLNup105OensLJ71LFTlZTP9uEmytMmq7zzrXdT5d37aLwc853ABUNqEhvVheyovEc44MUqNcDvsJTqWBy2DdU9ehx/l5IBUv22ezXkFv1CZ3hZ7uXM7giXmWUCZkeNH4DfycwiDBL6sgvGhyCltjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiN6JWfA; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso4787358276.1;
        Tue, 08 Apr 2025 12:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744142188; x=1744746988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6cDbUybM1KG7HZRBqaHKVMVEzJc7+qySRY9tjTb2U4=;
        b=NiN6JWfAMwSfrqRpxXXFwJLrxioDGhUPRrHcvOUitJvYxjOQvbVIao6+09C9Xj0mV3
         2Qzi69Dd4S82gG5j1+yNQPvtegpYeC6Y3WfqY90zMd66fUOH7JRpxJPFhqKriwb6saVD
         J8aHXNNOLk6u4EV4PFV/aYdFjAXzRuP3leAZfevE7xuGqZl6x5NidEapjTtniEuksrdC
         Psyqs+vZUtn1Dof2mlNt3pNnapmpMfIiGaOcButhZLfkSnGsG4T9aXIbohpFYV//efO2
         DYjpPAIIWxx9j7Az/GNhQ/GxsbUnTYZvsL2lPMfqsBDRGVosuYBzGJGyiJErCjDVfrLz
         TWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744142188; x=1744746988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6cDbUybM1KG7HZRBqaHKVMVEzJc7+qySRY9tjTb2U4=;
        b=OLfKPeNyV8qvPVy0Al16gnb3g+rh4BXvOSrHyUDqcMy/hOLa8bwe08Ngt9JnVe5huk
         0dNwk1tq9NPbZPEHf/ji3unhArFMHq3eOycOE4P7jRXpvVYLM55wMqZAbGgyUGpSvvqi
         S9OEfGzJMv1n7wzVRcRfi/f/MxXnCMBXemfla484ZLkwpHUDpNUfP80UTH+4r3/9LGRl
         iDh0maGM6al21xQXUzLNC53wj1E2wSFbE11Esl6mxj9iNOJ3rnu+zokOuv2PaC/de/vZ
         KxOZ8XQe7CJet1DHAjf8ayTInZpFo1V3CL1rYJchMyqLkJStEaC9vm11U5JMAsgSsGAC
         i6eA==
X-Forwarded-Encrypted: i=1; AJvYcCWFHeBeptErLDCYN/43nZVCfvvq4GH3bhjpyaZ8y+l8PkZe6+2g7lFzPhvhx/0m6pDsdQppUedxYqmSud4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJZM5syLjLHinyDK/JoXFreWCDz6c+B7UyYujVPLaeX0APvyMr
	4ncBHs+LZz63O/kXvSS4QV6NpHKMeY+wtG7V8JjUoUVRDgKZPiSIiM1op5BlOT00NozyBfBQ7hg
	RLJQV7KmNI38DY4UGYsodMPqWNFY=
X-Gm-Gg: ASbGncsepYidNd7DQQ2QTF7OvzS4qxB0xQCUBZJtIA0JABz/ul5vM3IvDrV42+CO1eo
	p75oOPaJKE4l/MoqtiCfQCXXUmlNgFJPIzMm4BP/s2EQYDE1PPNMJa6wkXz+EjtL7b1xfnF1R6+
	7oIfVz3bqCZtdlBPmYvA3bv7Lk5F48YGhJyFOACL/wBZ8EvW98SsMfdlm1900=
X-Google-Smtp-Source: AGHT+IH0R09ialjzR7tBCVZSJpPb1eM5DyxBf37vmd2V9TKgBmQHBgF2t7u9Ira6Et6V2dHcNRqnHToxvM78YRXL21w=
X-Received: by 2002:a05:6902:2381:b0:e6d:e429:1d70 with SMTP id
 3f1490d57ef6-e702f5c7df7mr29068276.12.1744142188598; Tue, 08 Apr 2025
 12:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330135402.105418-1-simeddon@gmail.com> <20250330152044.18cf81f6@jic23-huawei>
In-Reply-To: <20250330152044.18cf81f6@jic23-huawei>
From: Siddharth Menon <simeddon@gmail.com>
Date: Wed, 9 Apr 2025 01:25:52 +0530
X-Gm-Features: ATxdqUH9sgSrCRUYQW9CwHIhT1t8pCayapMz7lxbogfE6j6N7Se-rKUcJD9Z6HA
Message-ID: <CAGd6pzP470VDxGoP4e_2hVXsKrJhnhbv-WgFzCq7tMX9RjOLwg@mail.gmail.com>
Subject: Re: [PATCH v5] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, 
	Michael.Hennerich@analog.com, lars@metafoo.de, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 30 Mar 2025 at 19:50, Jonathan Cameron <jic23@kernel.org> wrote:
> > +     for (int i =3D 0; i < ARRAY_SIZE(regval_bytes); i++) {
> > +             freq_cmd =3D (i % 2 =3D=3D 0) ? AD9832_CMD_FRE8BITSW : AD=
9832_CMD_FRE16BITSW;
> > +
> > +             st->freq_data[i] =3D cpu_to_be16(FIELD_PREP(AD9832_CMD_MS=
K, freq_cmd) |
> > +                     FIELD_PREP(AD9832_ADD_MSK, addr - i) |
> > +                     FIELD_PREP(AD9832_DAT_MSK, regval_bytes[i]));
> Looking at the data layout here, this seems like an interesting dance to =
fill two unrelated
> u8 values - it's not a be16 at all.
>
> I'd be tempted to split the freq_data into u8s and then you will just hav=
e
>                 st->freq_data[i][0] =3D FIELD_PREP(AD9832_CMD_MSK, freq_c=
md) |
>                                       FIELD_PREP(AD9832_ADD_SMK, addr - i=
);
> //with masks adjusted appropriately.
>                 st->freq_data[i][1] =3D regval_bytes[i];
>

Hello Jonathan,

I briefly went through the datasheet for the device.
From what I understand, the device is expecting 16 bit write operations whe=
re:
- First 4 bits: Operation type (frequency/phase)
- Next 4 bits: Destination register address
- Last 8 bits: Data
so these fields would need to be combined into a single 16-bit value regard=
less.

As I am unable to procure a testing unit at this time, I=E2=80=99m hesitant=
 to make
changes that could unintentionally break the existing driver.

Would it be acceptable to limit the scope of this patch to introducing
bitfield macros and addressing the remaining feedback?

Regards,
Siddharth Menon

