Return-Path: <linux-iio+bounces-16937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF94A6467C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034521893ED5
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BBF221D9A;
	Mon, 17 Mar 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="JRURzgKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E528221562
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202178; cv=none; b=J8Z8wVESO8a99ppdEkQ/MEp4xtIs771BtbmxaKZxksarfab0PgkAehHM/lzzeNhdttY8AHLfLWxEhY9+uaPdAK+1FK6HU9f8Q7dIXnVBzw5tKbnKCXEX6et97e+pjauPaPZejtvAoFt3D1+cK5LBDm4t2mu4fsIWvPvJBFB2qIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202178; c=relaxed/simple;
	bh=1dWEllRi9cT3TdH3a5RD12xiyKLkPsnBpGAgW3m7QSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VaF7Up4vHllzHyNUa/Vf8BuTkMrQuRh6RfucSHVUnccwzLZz5D7B/KCLXdXoLOthaNuDWCVB7WZidn/okmK4FXeSqLx7MFKzbTIBVP/XJg9vAiIOAqqFfmCmWTdpTbyeRtIbcLj/U1ox3jyvsZd33i0Jo4hv/FKYdepVjqFsyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=JRURzgKE; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f754678c29so45456467b3.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1742202174; x=1742806974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dWEllRi9cT3TdH3a5RD12xiyKLkPsnBpGAgW3m7QSU=;
        b=JRURzgKEM4/NrN7SoxKPBlD80hXT8o2Gx5xIJ7mhtgE67aTzbYbkNf4GZu5LkHDNNc
         JqAMqHUi98dfkwLASbOUOvSClCCJfnu7OtTN7PUfUyuvbnebxhMYffLxbUDad3C9EkMy
         u8t7p2UFUlH/m6ERw+nywS1otpYJliDNV5iKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742202174; x=1742806974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dWEllRi9cT3TdH3a5RD12xiyKLkPsnBpGAgW3m7QSU=;
        b=rZFvfb2F8BmAg9K84u5ow7mydn/wsAQ3i82KT2zYMbAeGkqoqXc01yx0Fejlr3xSIn
         jjieN4nr1bE4Lac61X8TjHef56jG/C4jfHaVr/Qx20Bsdm00PLEkMQoHs8UXxtRiR5S4
         XW3grf85oc6Ltjufyj4SDwEfFI5QGyTPg+gtDLEqQw/KkuhYDU06WTjOyVFdLuOvwUQy
         CYctfh2PXLF7FZKUKnKF4c60Qea7INQMjyd+HKJ2xzMpookm1ZjsLMi6hI4rvgobqjOy
         TwjetP+1jVegRlrQ1LCRkMLWMnZNZSf1DySeXkB/GHeBEoCsBWFffB0QM0oPgNDUMlyG
         L7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjDimB4tSvl8O7OgKyQ3ywOvun7fHW7LUXpFBxrqjBPdI04xDCz4au4CDVpkt8UI7SfbRw9cuIlbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FyCsYZif0I7nUdl3dBN5E0SFZhWHcIs1tDgSFKn0CAXiOgyV
	cmAkBWldSG7WjR4+1Rm5zAhGtPDMloG+BRfeTJOXbLfHxmRofbjs8cEm2wD2aCEffDqOd7xThN1
	GIuMrLCCewIHzdafgzBBfgLhIhAzH2iJezkMf
X-Gm-Gg: ASbGncuf/14i6n2ZXFImlJQsrLowqOhhHQhkIi+HU6WptWK9XcpObC9e5GRqzJt98rt
	xUZhEVXbKyOLCOxMguhAKT+DO+tlpm8fOJtZ5hlgTe582opIb16iU8hFCXfr5M//ENNtpoZfaZ7
	0Ik5KIdmboe/Vam/h+jGYj9TTAeo04Egl6xXoOMA==
X-Google-Smtp-Source: AGHT+IFxwLvIrrUJC3aUmydVs8gHzldE2CtZrPk3iBJuFIgcQ3Cb8CKXs59a+aYvfUL1UvqXTPtEmQm7tTPDDaq2sbo=
X-Received: by 2002:a05:690c:688b:b0:6f2:96e7:8afc with SMTP id
 00721157ae682-6ff45efbe96mr138552817b3.3.1742202174156; Mon, 17 Mar 2025
 02:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085030.3593-2-s.seva@4sigma.it> <20250315183644.04fd688b@jic23-huawei>
In-Reply-To: <20250315183644.04fd688b@jic23-huawei>
From: Silvano Seva <s.seva@4sigma.it>
Date: Mon, 17 Mar 2025 10:02:43 +0100
X-Gm-Features: AQ5f1JrJh9Jvyh-BMOeiJ3cLGqoPL_06gDHiu-ccqIer3cUbdFvbbDv_Z2xw41E
Message-ID: <CALKJsrr2T1enr-uzB5s5ijN5=VOag4sP32vob0QCv=a-k2T4pg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
To: Jonathan Cameron <jic23@kernel.org>
Cc: a.greco@4sigma.it, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 7:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 11 Mar 2025 09:49:47 +0100
> Silvano Seva <s.seva@4sigma.it> wrote:
>
> > Prevent st_lsm6dsx_read_fifo from falling in an infinite loop in case
> > pattern_len is equal to zero and the device FIFO is not empty.
> >
> > Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> > Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> I think you could validly have kept Lorenzo's ack given this was
> just breaking the patch into two parts. I put it back and applied
> these with them marked for stable to the fixes-togreg branch of iio.git
>
Yes, sorry. I mistakenly dropped the "acked-by" when splitting the patch.

Thank you,
Silvano.

