Return-Path: <linux-iio+bounces-2458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF00C850FFA
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 10:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2791C21C70
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3B317BAB;
	Mon, 12 Feb 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLSlr0dQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483C179AD;
	Mon, 12 Feb 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731454; cv=none; b=ocs1kRrEiUswSnkn9/LYmrB+JRtXsgEwmgmPx897c2s+95hU6VTHw1JqSkQdXf+sB+PEozb8Gf202Q1yJfiNpjmfc9nTEr51TJEyHBF8EtQMSNR4seaoq7FuqY01moJzzT1z35hGJRyC6lkqAvpHKV+AdITacWynLZV2hbglT7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731454; c=relaxed/simple;
	bh=6cq7bzvGtQe0gxFL1s6LBuZDxFeaVMoUzBqAkQVTEl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmuZL3cKdAbT7yAG8Li95DzvLXvbMiX+3NAa8SSgnIVfgtbfwHEZGbmFgY3FqNc4+kSLxCeN/Op6MlBT/4PCibYXfg83pweDyZHDAv4ix4o6AlLN+ZlvbHw5PUxNRdh+LQDvG0s//LBptZ/n5zTeyQ9t5ROP/j+LElONok1OebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLSlr0dQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso39293266b.1;
        Mon, 12 Feb 2024 01:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731451; x=1708336251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cq7bzvGtQe0gxFL1s6LBuZDxFeaVMoUzBqAkQVTEl8=;
        b=NLSlr0dQ+h2uIGrSYghW8XG9SJ7eR++TfAfA93xBDjEOpWlAjsMG8VQXx0sP98YUHT
         mNLcZwcjVuVB33MBebNTlnATGbLNOo4zrzyNXyaEVUuq1Ff6KDMWY93yS2Qi380kRISU
         TB4uI4pdllTl7sa4ndUeRYVysyBn3VJEN90UehFrbTAx4cX/ktICj6tvnmwxlVCERClK
         G7GYBvHn++gKqPAXDbQauwsU9vJqM2r1KvHR0R2IdFQdH7Myxy9vxHFZZV/5XX6sfSZx
         hY5YKh1EVTHaehJZAcH+LJA7I0txYD10lqmKCahFdotYh2oVw4XD2g/WD94qtMPd9jTJ
         51YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731451; x=1708336251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cq7bzvGtQe0gxFL1s6LBuZDxFeaVMoUzBqAkQVTEl8=;
        b=nXmsIzyDnzyhoJuK7KhaNe7Fi4BevNNPojBUvppy62fNUA1TwErawBCchhuYC0rOct
         VXLFD2Ybkg+1li3cCa4yfsALRfq5rIGe6ZpY4PGvJu6btofPrhRomnzFBdNTQN7DthKa
         YhUJJXFl3QcRHEsNMBW3VNAiF3+4Mi8wAkjwXZCILp99hx8PQQbbEUItKFWBDa9CF7Cb
         p0Gc/kfkY5nFhbd09zUcTESUQnUb+XiQDkNATJjekChTYV0DZ5x2CnNRrnIctKPYRUw8
         d7BTFWrUqCK0t8QC0qSUTniDbO5nh2wqhovVmhlP7rTtlqSp79DxmFBJYn7rlYDfNorn
         44Eg==
X-Gm-Message-State: AOJu0Ywtkw2hHyX3O32quc0E5wfC4S/+I6X1tcu0rvbHVt2m+fDaHrCP
	ObYn+ULqDPbozFeMG5a19YTyPVzew2VTmFCTRpbf86Y7TIpp24PdF+NPeortTa2ZB8vuSP1JXIB
	Af4z8lbcufgNi7O+XNREQL+eg9kQ=
X-Google-Smtp-Source: AGHT+IE5Sc9bVjkJSckP+6TyFX9G+YR2tPeEruKyA3NQfab5NbqIcAMOPhbq5S2fjLEyeoyUZleS2pY093zU7Va7TBk=
X-Received: by 2002:a17:906:4ad7:b0:a3a:510f:97c0 with SMTP id
 u23-20020a1709064ad700b00a3a510f97c0mr4176926ejt.61.1707731451083; Mon, 12
 Feb 2024 01:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5769241.DvuYhMxLoT@nobara-ally-pc> <4956451.31r3eYUQgx@nobara-ally-pc>
 <CAHp75VcFXSfV4rPDaJcUVC92QGK3U55AqQqPo0WYKmpcKnw+eQ@mail.gmail.com> <13845892.uLZWGnKmhe@nobara-ally-pc>
In-Reply-To: <13845892.uLZWGnKmhe@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 11:50:14 +0200
Message-ID: <CAHp75VfcK35RnPEzBkt4D56WLRFtWHita4e9ZqcLzpqUbw+PcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Platform Driver <platform-driver-x86@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:30=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
> On Sunday, February 11, 2024 9:08:59 AM PST Andy Shevchenko wrote:

...

> > No ACPI_PTR() in new code. It's more problematic than helpful.
> >
> > Above for your information for the future contributions, as I said in
> > the other patch comment, I think the better approach is to enumerate
> > from an external driver under the PDx86 realm.
>
> Thanks for the constructive feedback.

You're welcome!

> I'm working to fix and re-send via
> git send-email. I think the ACPI match table method should be okay and
> seems pretty standard for a lot of devices. The problem in this case is
> that the identifiers are not currently unique to each chip.

Yes, that's why this portion is called "DMI quirk". And it does not
belong to the driver as such. In some cases we may have it inside the
driver, but here, I believe, and Hans can correct me, we may avoid
polluting the driver with a quirk.

> This is something
> that should be rectified with BOSCH and system builders and then in the
> future, the ACPI match table(s) can be updated, and the aborting portion
> of loading the bmc150 driver for ASUS ROG ALLY can be removed.

As I said in a reply to the other patch, it probably will stay forever.

--=20
With Best Regards,
Andy Shevchenko

