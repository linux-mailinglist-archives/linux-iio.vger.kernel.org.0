Return-Path: <linux-iio+bounces-23910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C3EB50696
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 21:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5E97B21B3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 19:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D3302CD0;
	Tue,  9 Sep 2025 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3Q2Qku6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C726981E;
	Tue,  9 Sep 2025 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447418; cv=none; b=mDKj4lyRWBhzJcYy9b4BTduwSpbBDeW/IELyxML2RQAk1ullU2aUzw3eU4J/DLO7uwAqc3igzeEaveMBDDn/EKmUQd/ezEY/LqeL2Njt86myrevuroxVRxtkazF7hi8f2Ct1QAfO9wKHVwYAGTGD5BYrg/3w8NvR+ZdE2kQ1Ttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447418; c=relaxed/simple;
	bh=Ab/krwxEBryFIQpbwzFXZi9qd+HMlUE2gBgmoHPVehU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plPqdP8JYUuuzcJDUGN1+SzNsUxy2O9+F58mFD91UVVljh8EgV8Ya7/ZbNMiz05EhgsZJtKRSeknoboZnanYgq3tSFGw1cjvdBDJBGOXGL0z8F6Jdq9unmEOun2RHyTbxtaysAerV2tOllrqhmJ2RWeoNccKKSaPyMjMiiqUOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3Q2Qku6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-336dd55aae1so54276011fa.1;
        Tue, 09 Sep 2025 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757447414; x=1758052214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM6V8elEeXq7KqJyC7/filg7rPjxfTV/y44qIQKgxpg=;
        b=I3Q2Qku6nYamMDSq4Xe+aC6CIbZLD5iEHInTJg+ZhNRlpWm+/rzhRDYmpS7nCO8m0v
         MizotoxohHBs5rplprYZLnLJ317TJibC/m1Nxibh2y5Gzzb5XDwSYioxfiPa3JBLxqw0
         OzR1LFXzBxskYq4mHo4sAmJjMkl0x+7ZG3C4jkeQ54FUNfGo8GBo703OJMiEIZ8/VmbQ
         rVeWI2ebvsTd0fyvsojgSsnzxfZCxh4G5Vt8ltg/rlifyLow6r+BT6tY48PLFx0uNWrc
         ntlsxSQ1Ugf2MLArsHARlLVczrs8ILxw1PFExzrFp56on9XQf9Nx5AoKt0tJthh/oAda
         S/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757447414; x=1758052214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM6V8elEeXq7KqJyC7/filg7rPjxfTV/y44qIQKgxpg=;
        b=dSwZt1ySmIWKemWfVA9wkkHm3zqWvyxgt4+TBo/oVo5jCh/hCaqq3HE8v5zyBBcCu/
         rNE0KGCo8S+n4sNQk2xP7UYIbdUtHNQyWBCWgWQmJ9yuu0Sp81PGxxV8ZkQcWvTYAl7x
         WZGMM6MXOnFixsYJjNRCnA+YIg/7QrtbEO/JgazsMNK53n0ixSbwlHtJSb+vCYcRxftn
         q38uNdSJq2nZE3iHPA+c/3vthhN7TtSoOWV7snvJtjN9IKNk1n30zTRM12z6TvBRuSAJ
         h3j/rjE9YKGUFVxtVFLnIavopBEkz1dsd7K4k+/n9fGZCw7xVLqJxJjhbGEOROaQtbH+
         86jg==
X-Forwarded-Encrypted: i=1; AJvYcCVT7tUQWHnAr4dvGjhbfn00MZ/b9W12xzoHIrIAmJSDhK+HNQBxBjkc+0s3M4MudxTAw4xM+CrGkSA=@vger.kernel.org, AJvYcCVspL6TD8x1O0WLmIQE6W3z1KXZtLxqQAkdWlyaZIxGKdiHl6zyNtQt1/uTXcXz0/IYXpdWO5sTtI9rCTny@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzo5Lumy8lsrhyayl5T4KMBNS3uHzslkJiyALxpRC/OddN3ug7
	9RCnaXeWoUEC/cmRD7ugtaIu0h1HzlQUzrvyPzGk+n7Wm3bwGkn/860tg0l7drvsdIPPUSQ3vdl
	tXMKSLkRvICEiNPz+mUc1MvV7Rsw5ySU=
X-Gm-Gg: ASbGnct0iu7Ya3/fI6diMfNnNpCFIqulrMVhglV9kS9PYSW/Km5Dg9Ivfm6Bir5Fu0D
	ToRXYXAsm3EzSdlBw+KTdS3P1nX7TJOOYFyKR/Muf4pBX7sgVv7nuxOsv+TNEvaIV3bxyGtwu2H
	zCgvGeG9RdFhsxmhCufriAjhLihCP1O28FuBTE7rDrIJ06LDNX/8SwfweSJIRlSnzPPXYo0KqKW
	Wfl2jDeYF27zJ52A/BEOQ+XKxfa5hQfo33wJ+68
X-Google-Smtp-Source: AGHT+IF48B3SpayJfOIz4IYQVTCT0C3uay/q3WzQLKowGlC90htPAr4abmLETG0lIXTQQzCexVKVKXkL621fZuf33Mw=
X-Received: by 2002:a05:651c:20cd:10b0:337:9dfc:f4de with SMTP id
 38308e7fff4ca-33b4b23056dmr32928121fa.7.1757447414111; Tue, 09 Sep 2025
 12:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906034225.12401-1-akshayaj.lkd@gmail.com> <20250907105557.7bab8bfe@jic23-huawei>
In-Reply-To: <20250907105557.7bab8bfe@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 10 Sep 2025 01:20:02 +0530
X-Gm-Features: Ac12FXyX_W0YfMilGyW-sdl7JZKHet0VZU0YZ2BtgcumAOi6Tgm1Ut5kNlZvL5k
Message-ID: <CAE3SzaRrfN2bDP=LO9O3WMrGr6atgTCv+pCE0h7x6zGTJj1Uew@mail.gmail.com>
Subject: Re: [PATCH v6] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 3:26=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat,  6 Sep 2025 09:12:19 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
>
> > Implement runtime power management for the LTR390 sensor. The device
> > autosuspends after 1s of idle time, reducing current consumption from
> > 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the data=
sheet.
> >
> > Ensure that interrupts continue to be delivered with runtime PM.
> > Since the LTR390 cannot be used as a wakeup source during runtime
> > suspend, therefore increment the runtime PM refcount when enabling
> > events and decrement it when disabling events or powering down.
> > This prevents event loss while still allowing power savings when IRQs
> > are unused.
> >
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
>
> One missing bit of error handling. Otherwise looks fine to me.
> Wait a while though for other reviews before posting v7.
Thanks Jonathan for the review. Made the necessary changes and floated
a v7.

Thanks,
Akshay

