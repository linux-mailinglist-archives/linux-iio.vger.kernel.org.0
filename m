Return-Path: <linux-iio+bounces-20746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD0ADDB5E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 20:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B60517A0E8
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB22571BE;
	Tue, 17 Jun 2025 18:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCuFygZp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE452219A79;
	Tue, 17 Jun 2025 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185266; cv=none; b=lDrQeQ83lHiohx3yXSILYHKBpB+rVm2//SvxC68nFB+Vw8p6dkZ6+ZNfVUwsK4FNUXb/wiXLLwMAIqbWUWq18yra+NkwzH+LRDmmwxEiQSRQbKAREXQQx6BSxwOsonH070zTaQoyhGBALT8dZ0DSQVv61+sr8FmJ/6C/OTOrSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185266; c=relaxed/simple;
	bh=lKT+LivCZpChLEpwppAaxNEigjPq2YzeLeNedsDCFu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVQYHYVWsWrS/EN05zi7SzOqZgT7raI81zVTl05CvP1QW8f0To/5wA3ljd5nmlqfCe421h+/NeIhlLblJ1tjFnU4KqjkBDGwoB9IET0hiXJdG+bRUStZIjGMxOsz/Psif/CteliwgRLV8uOI2CPzPN3Hh+6krTOeXRZT9KWElTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCuFygZp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad93ff9f714so1096939666b.2;
        Tue, 17 Jun 2025 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750185263; x=1750790063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKT+LivCZpChLEpwppAaxNEigjPq2YzeLeNedsDCFu4=;
        b=jCuFygZpRSIjAut91bwBlAafs92kKU5yPwM+5YyxQou3DBJcAtXQYrblXhzZah2KnZ
         7RS0GtZpdEyL4CnOhiACHYJ3quGPsA6My++iLGRyoHIim488oOeN3SthrM3lOQNgFU2J
         cc00mjgfvPvzkFs180FX+QbltyD17BBDkjtyRH11dMI/qlinQyZ4C13IYZXIGzpqNvGR
         Al+uPcYaTDPDMtp+27q79TXBPQ/CbXfGAbE9AKRkzJ+dpTp5n8uWZqJhpOx5O0DChZSX
         d5ulq+jFsso5O0MXF+YHHFF61wOhClcVPbwuKpTt1k20sKrUHZsTr6tT1PHLqEbzBzWb
         IOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750185263; x=1750790063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKT+LivCZpChLEpwppAaxNEigjPq2YzeLeNedsDCFu4=;
        b=lGhDBASZ/edQ7FkKWyWa5YcT65JshBgqT5vyjaQXm4Q+uQcYz4zdzoAk8AZDBTImvd
         Kb4G4uHxQmCIIpUxENp0820xrHGJ8i91c+b9T/v4Oo3fFaQRBRoAYtw6AwcKTaLBkPYs
         PX6mjq7rpD/VLklMjCHCqUiDzUNLbSHiIznsC1RmAJ3vA/LmepOuIm+2A9EBR74hb7TN
         S5unwVmjky3OxUg7O2if8IrUgBCRcbCLR4wge6bk4vlslpFYlx5ORd1o/NYBkPB1qLm6
         MXBJmD0K/oJDjtkLamvLdAdvxq82tAG1vmsyuoC/67qpQERmNPJ4MbWDXw9X0AqOnd0o
         V/sg==
X-Forwarded-Encrypted: i=1; AJvYcCUULCqAFSVMudGqNgJRvl3N0EUuNrZ55nlhfOFqBULToO2A6Grz2Bj8D7o1bkcl/IHoY1rUPjiiw68=@vger.kernel.org, AJvYcCW/LFW9XlrYi/0uZDutc4UgPbhdMkZY0xCV/cYjYkcZXUbFCyQXC3aKBmbfh/vbs45ZzbEsl98fwm5p8T1r@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzucXsXmfBrg7ZHMV501WeKI/FaYVOdkMi1ASdfzSI6aHxxhi
	kUYvzGTpFZxHTVd4jXtsDoW1akvpuvD5WYDsUDJDDlTaZ5O0xn2Zb23rHiifObhUvsMwfrEKHKp
	xy8GV0ir+qYbfw+fqqn9V2BuwQmWjWDhmv3W2
X-Gm-Gg: ASbGncvFizoS15JExNXeiuUNyffxIn6oKLV5iVoEi3OmFwdawWzl8VOIT8NQ8G0YRaZ
	i3ifS4QGderPcka2qdb0OvEnWLDWXLPMejdl1pC8McklKB1fC2WHZCnSVhhrey0ygea/Y+soCnQ
	11rgzy2lYWWZUbK3c0m8N1TuoGIplrKdbM0QjPowMdP3o=
X-Google-Smtp-Source: AGHT+IHpKXFzdzDT6KNbCdcOO5MoI7epaUZvX6IPgz0Yb0HPyzXTrHxEJLjX3+yQBj8mcAwUbIikY6JJtqMplZviVVk=
X-Received: by 2002:a17:907:72cc:b0:acf:15d:2385 with SMTP id
 a640c23a62f3a-adfad357b7bmr1483062166b.16.1750185263083; Tue, 17 Jun 2025
 11:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com>
 <FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <CAHp75Ve68H448v3Tgv930yoMYCCKVC3kefuP+Rermj7SaiP41g@mail.gmail.com> <FR3P281MB175775DBE90C5469637F3C66CE73A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB175775DBE90C5469637F3C66CE73A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 17 Jun 2025 21:33:46 +0300
X-Gm-Features: AX0GCFsDji8BZdcobaIKwiBIkoOAcTydMFV4jTG0Oi7REx-n2SYPb2Qz9s_nj4Q
Message-ID: <CAHp75Ve0aQLaRS1-J5WoCxUAfX+Y=s2oj4ZkVvUG1XysXopZxw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 5:43=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
> >From: Andy Shevchenko <andy.shevchenko@gmail.com>
> >Sent: Monday, June 16, 2025 16:33
> >On Mon, Jun 16, 2025 at 5:16=E2=80=AFPM Jean-Baptiste Maneyrol
> ><Jean-Baptiste.Maneyrol@tdk.com> wrote:
> >
> >> thanks a lot for having done all the work.
> >
> >Please, avoid top-posting!
> >
> >> Do you think it is possible to add a fixes tag so it can be backported=
 to ease automatic backport of further patches?
> >> Otherwise for sure all further fixes will have to be backported manual=
ly.
> >
> >The idea behind the series that it may depend on some kind of
> >cleanups. In such a case (according to Greg KH) no need to have Fixes
> >tag on a cleanup, because it's confusing. On the contrary the
> >infrastructure for stable kernels will catch this up. You need to
> >follow the Documentation on how to submit for stable (basically the
> >main hint is to use stable@ in the Cc line _inside_ the commit
> >message, as a tag).
> >
> >> The driver code is full of intXX_t and uintXX_t types which is
> >> not the pattern we use in the IIO subsystem. Switch the driver
> >> to use kernel internal types for that. No functional changes.

> >> As noted before the pattern is used in less than 10% files in IIO,
> >> So it's safe to assume that IIO prefers uXX/sXX types over C99 ones.
> >
>
> it is good for me if we can add Cc to stable.
> I don't know if I need to add the Cc tag here or when a fixed patch will
> require the rework. In doubt, here it is.
>
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org

It makes no sense here. This is a standalone change. It's not part of
any "fixes" series. You need to attach this patch to your series as
patch 1 and mark Cc stable all of the patches.

--=20
With Best Regards,
Andy Shevchenko

