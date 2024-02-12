Return-Path: <linux-iio+bounces-2457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E18B850FED
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4F52852C5
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652A179BF;
	Mon, 12 Feb 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYVDyWC2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECAD208C1;
	Mon, 12 Feb 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731220; cv=none; b=OahqgKpHB0V9cAlRq3pMauVs/vXWRzAj/jIfYS0hHcprCqgTd3LD+b4SiB1YcWOhwbiPZ/EjJA7VgOODzK80r2CO2MEGPd8DpBxBJzXrLoap3p9zJuyRMY9Id13c8iBys2QYgC4CCZjodWeNz8LCWA1Q4WLG2dGNqz2SStcYfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731220; c=relaxed/simple;
	bh=XBAv6+/WDIdBHhbXdUmSNymHLMnwS+MTIxGvQX8GmQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7mkfQ+LvQwR0N/j3XOUMEX5OBXaMmh+cjgm+Z7sAqNlfWbB1rlSbqluF+0zWtuUP/2voA0sYV9IX5nxlpmJMK1Vu85g1LmMDm/tU2lLbbAYrMxrYylY5Isja3LPmEFufUmvKRix0R0bnVkcJe33UDV2AeEsaPj24BmeHHy/cRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYVDyWC2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a383016f428so315002066b.2;
        Mon, 12 Feb 2024 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707731217; x=1708336017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBAv6+/WDIdBHhbXdUmSNymHLMnwS+MTIxGvQX8GmQE=;
        b=FYVDyWC2hfZzGhFoLi8BjYlA+d1x2mxBLH2Ohr0GpXOCk36Gs0vmjn2DJMCoxswWaY
         YpqU1kDd3dgE9GFmaOLBeJic+i6SF0oFMRvykaxa6SRm08wrluyVN6hKP9bXYR/0xQdt
         ILDKVk7Gv4CON62kcTPbqXA6n2B8AQ6txXSluDC6RgLKUYMvGcpY8yAGY9IpmIKf/UnS
         i10FOu2WZ1Wt4/k0ZfcFlmYhuAt0GJwuJ2gyATKWmjnWs1e+ZcC/noi+PhfW5SImePHv
         ifDybBKKaqND6eGgASLlGBHZbueb6Dgv1n7KmtB0M+mz15P+GMXzq5aWD5NprW/zd+yS
         rpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731217; x=1708336017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBAv6+/WDIdBHhbXdUmSNymHLMnwS+MTIxGvQX8GmQE=;
        b=MuD4dQrgiS1ZoOvqmP+cAPzKmm3iu24ozrUjMI3prZLEGNKT7E2rvm3/gv0xBiI11/
         XN4E/Gdiuc4XIQEGSnCDkG6MUPHEc60vhqbx48QLbSbFEif8WgOkeo1yrw/UtWKli701
         aPSGHUkso4+1+mR7BnHR5hXpgXMSZSMUDZjMUDLBDIqM/f94o3zcOMajsGCAGzmxomSx
         Lfx5YNoDjY3n8a8AUhiuc3JPxu7fxP5ubMOaoZv6AWNxmku57K8dZ2s4p3q2jb6MxHut
         Lv1fKkcJd0NNYmCJ2gxeIo6sVTuREQFG4SAQ33QW9uG/OwdGOr9kqcRf+T2XP324oz/S
         m9ng==
X-Forwarded-Encrypted: i=1; AJvYcCVMMAv2I7yp0RO74tggtJ0Wv/uUQJFYRIRg/zEbgpjwm46BiUbsrSBslfTfeLSv6QI/9UMl+xZJMINmTR6C2GhVFMRPt5YJkYbY50VrCeWF1QR8BWVRAGoCe5UM9cYzo6eMfUUQEzAnV7gNMK57Ug==
X-Gm-Message-State: AOJu0YxTh3mVxP6VAEzJit5ceNcUHG59e/WpzNcRF8uMztab3j7icvfa
	Qj3DO/IWY+2DYOWVF1ZwUjKnYFVmXgoqfFfQYPY/tE3W9qYE/QJCqyLUr8nvFfxNE1C31FDLnAV
	niBi/oFlL/A4YkWEms9ZYPwuoazY=
X-Google-Smtp-Source: AGHT+IGRZkxJRUffn++Co7cADidLNLk9FdUdzeHUzjLzf6Tht5DAmiuOzZFr4BxTcSDaLlcGwF6kF0M8z2WY69OOMNc=
X-Received: by 2002:a17:906:288d:b0:a3c:1db1:41fc with SMTP id
 o13-20020a170906288d00b00a3c1db141fcmr4944786ejd.41.1707731217341; Mon, 12
 Feb 2024 01:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5769241.DvuYhMxLoT@nobara-ally-pc> <12437546.O9o76ZdvQC@nobara-ally-pc>
 <CAHp75Ve71Lb4PsGLGY5b_LNVn+Dk8z0Ags9rrWptSp8ot-UpRg@mail.gmail.com> <5292442.31r3eYUQgx@nobara-ally-pc>
In-Reply-To: <5292442.31r3eYUQgx@nobara-ally-pc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 12 Feb 2024 11:46:21 +0200
Message-ID: <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: accel: bmc150: ASUS ROG ALLY Abort Loading
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: Hans De Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Platform Driver <platform-driver-x86@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 9:21=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com>=
 wrote:
>
> On Sunday, February 11, 2024 9:04:56 AM PST Andy Shevchenko wrote:
> > Something went wrong, please use `git send-email ...` to send patches.
>
> Will do once I can test the suggested updated table method.
>
> > Please, make this as the proper table (see many examples in
> > drivers/platform/x86/ folder on how to do that).
>
> This DMI board match and aborting of loading the driver is hopefully
> a temporary portion of this patch. The ideal fix is that BOSCH informs
> ASUS and other system builders of the proper and unique BOSCXXXX
> identifier so that BIOSes can be updated with those and this portion
> of the patch can be removed. As it stands now, this is the "band-aid"
> workaround of having conflicting (same) IDs for different chips.

Even if fixed (which has to be done anyway) it can be undone in old
firmwares =E2=80=94 there is no solution to make all affected users update
firmware. Do we have real products on the market with the wrong ID (I
assume we do)?

--=20
With Best Regards,
Andy Shevchenko

