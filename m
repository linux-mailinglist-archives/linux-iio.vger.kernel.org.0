Return-Path: <linux-iio+bounces-2542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89166854637
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 10:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8681F29AC9
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC3A12E73;
	Wed, 14 Feb 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTTlayGn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25D12E76
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903397; cv=none; b=efxbh+zH1XGeJJs48Eo/jHJLWwYe2wTxFDk3PtqDxlHCBYSLqyGigNVrV/rmXPhEpQSIlO297HudtfoHTNRRxOIx9uCUHw6oDgYYC9DZeDN4CVhArMLo6DLGCJDWij95zITZ0Oq/nDQrcnhRse0mPiXP/xNDNGLRxWIoKWHb+iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903397; c=relaxed/simple;
	bh=OdZbv5msEDmrGyvE3HcUlTtXApG9EDlfcbGHaHlmHNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcvlZ8uvMu01j/Ebedv6XePorepZ+KDPeR1AAGtrjn4vj5S95uqVrU9juMGZ4N22Sf8DbrTyMDe8WYTL9ZFjZhV455XBlPcRYUOYlqOwKgICFdxYv6jkcMU9GOhp+KzkY8cbgLSXoUojUVe0ETeXjRZ6/PMJEkZTN+v3lJnK3Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTTlayGn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3d0d26182dso158311266b.1
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 01:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707903393; x=1708508193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duXubJDuMHzqlfME/O7t+BtaRMQutrkzJ/7uAGrkZ/o=;
        b=GTTlayGnEZ3/O2O7RDXVJi9Ifo5QdmbB0SO3rRhjyEGvH3oIhQ99Apkm1CVYaJPWTt
         GZY/3t+DmeZtHi9sdSOjMjsOj5deo3w79ZPi6OXJb9auZZWsbIGiMZHCphaQsNSQ/Qd3
         8ZLCVFS2q/7Ro+4T2V9qKHTUzdtgw+EO7Q3s/EP0ZrxdssO1Be4m4FNOf2c6NjMVZNFy
         9UPVIw2z/hyp55DWdoH5Jlb3/hgNoeqOPo+L3IfKQ3WRJCiJ9M5OqfvFX5JgQJZgM77v
         tTumIz1TVvmxJ/dzg9tm/Z5elxIpQslRa0HaxQ1EUp8GYdcIWRc5Q4VpHjl+eXv9v6rI
         mITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903393; x=1708508193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duXubJDuMHzqlfME/O7t+BtaRMQutrkzJ/7uAGrkZ/o=;
        b=A/mGUd5BXKHpTHQ2RP3zpZSit70pkAFKy1TErq7sHTBC2r8x5pA/5rWs9vCqhmF6At
         rsseIWzsVTdaK2QS4KuYeWeoVZvIY/FOwqEfGiLepBOYFJg8yNT1A850q1GTwrsue+p1
         3AYi5ELLZjSqUmKd3U6KeiqJxSfvbFHsA93tvHuS7NP1u5kPa9zY28wxUbBzHneXpppV
         1B4IFF2m1ictsQKSnqrd76QlnNV62LzuZ6Kfe++QVE7Cizb4Z81yD8lB+DgsrAmqMgVt
         GGMB7y6gcR5gUM8RjcGhapnkMSLUigXx0E3evL7efH4uey1mRv9aXe7sDtTkpsUTnTuj
         gCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv2iwH878JYtH9q1lzkUT7p/50TifSbr2c9D+Bq6aMR9ZUp4sFXY1QHxNbGgr7PCcMTWAPbBLfj9nhXJGD5rtQ2VBxLJSWPLrp
X-Gm-Message-State: AOJu0YzhV5kB2FSDyIGDgRaZPcDtXv7Jil5zwuTIoCk/+cMrvF8QMFp1
	1Irx/LjRZXyAemafzbs3/5Ud3lmCkHgdk/sA2ahlio8miOg3BkP6NN0vmDztsXxOVNIYTl7JfiK
	+zo7knd7dh0X9L1UzcFhcBzYbM5U=
X-Google-Smtp-Source: AGHT+IFhBooJ8/gUjZuvuW1tfd0LpEoFNrKKfLo3qTZhqrPruFL2kh0IpvThzFN7VPDJ8mJd4AMjxW/x5w4owlS85+c=
X-Received: by 2002:a17:906:408c:b0:a3c:c11b:e260 with SMTP id
 u12-20020a170906408c00b00a3cc11be260mr1229363ejj.68.1707903393333; Wed, 14
 Feb 2024 01:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <20240213223806.27056-1-jlobue10@gmail.com>
In-Reply-To: <20240213223806.27056-1-jlobue10@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 11:35:56 +0200
Message-ID: <CAHp75VdyQxpy5wT=X+0TKnd5x4uJzqcSJikHs2Mx-VOEzbnv9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: accel: bmc150: Duplicate ACPI entries
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org, 
	jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com, 
	linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:38=E2=80=AFAM Jonathan LoBue <jlobue10@gmail.com=
> wrote:
>
> This patch adds a description of the duplicate ACPI identifier issue
> between devices using bmc150 and bmi323.

With the remarks below,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(carry the tag if you send a new version)

...

> Comment describing the duplicate ACPI identifier issue has been added
> before the "BOSC0200" entry here.

Hmm...

...

> +/*
> + * The "BOSC0200" ACPI identifier used here in the bmc150 driver is not

s/ACPI//
s/in the bmc150 driver//

> + * unique to devices using bmc150. The same "BOSC0200" identifier is fou=
nd
> + * in the ACPI tables of the ASUS ROG ALLY and Ayaneo AIR Plus which bot=
h
> + * use a Bosch BMI323 chip. This creates a conflict with duplicate ACPI
> + * identifiers which multiple drivers want to use. Fortunately, when the
> + * bmc150 driver starts to load on the ASUS ROG ALLY, the chip id check
> + * portion fails (correctly) and a dmesg output similar to this:
> + * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
> + * This allows the bmi323 driver to take over for ASUS ROG ALLY.
> + */
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] =3D {

...it should be here. But don't resend, let's Jonathan to decide in
case he won't amend this when applying.

>         {"BOSC0200"},


--=20
With Best Regards,
Andy Shevchenko

