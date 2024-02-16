Return-Path: <linux-iio+bounces-2635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7F857F62
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFDBB230C9
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB277E0F3;
	Fri, 16 Feb 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfRjuKEZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE512DD91
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093833; cv=none; b=PDeCIbTBVvqPo1uU3BKeLVGFNRlEx79VfU7C940V9kAMqAz395KnIeOchU9Xl9il2RNixueKJEU4iATql9Z66kJz5VQEfBMqifuErXXtK1/uhhBGZCFtpGjBj8YgBZIwNroqwQFvnoH/rMBZ0Yl6OUeH7Ps0pzQzsfHddlpgVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093833; c=relaxed/simple;
	bh=yIHsO9efKevhGzitzxx4ayO8IludHpMJJQoKFFaOmnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVE+nysIbVU0e5fsWkfOvcbBmK7dqF1wULrbu/QW737yhUM0L0pBd3sop42uVs7UrBNTrBANlxo2v9sL3jGxRm4Bupooc9YbegJ2vGwVDTZnYPSSYqTqd0Qp00o/gEWf/TJ2Ja5wicZa8dJrteOh/TdhM+V/PfgOAb/wMKlRZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfRjuKEZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1649256a12.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708093831; x=1708698631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDcCsdTinlH0m6x4xrL7sYUB/JDTjQqxf104ON7B9BU=;
        b=PfRjuKEZDetodr7bhIPK75SkGBqrV9AJ4e4+4Jw1Fx8KvfgQoJ0WBNKY80rA3KINLf
         azPRFXzF26rGw1XtvFOL69QBzzkrphXDRv6H+PwaUh3id4CyVEVRgL287KBgyji8uoIT
         pEe7Ldjv/2F54wzkjE34dglqqyMl+m4DRsv7ta/qp4dut/uWW0CBR9CAI3kdzNQv38Mg
         AsuSo2d3eJvlHp439TMcnPn88LtTMUFbW6FIuliQ5kAoGhWdcdEb+dAS4PDZm4uLbGV1
         vj+AaEqKBjv817zQZ+odXGtUOfrWG61V0eKmb4FWwA/Dg+xbKvYFfTZSurc0AFdKfUHN
         PJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093831; x=1708698631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDcCsdTinlH0m6x4xrL7sYUB/JDTjQqxf104ON7B9BU=;
        b=Jqb5jdPZxkIj5vET63qDcLwZKKFXh3+YXq4CTvaFRMVTBsVdMN0wt8qpJ8ux5KSW+q
         IHbKXgww3drVsQjSHB6K6ShJptB8kggdiOrnkUpqmRzX1wcg+2SI2UdqoMew/zaDkEDt
         xxganGHrfllWIQjIEGmHAg58edyNRNO46arB178TInEutq+DYo1SjUK0kp0EQmI5bZ0X
         sXisY4xBgT0eM3R89f//tYly72fhPtnP9pHQH4UDprsvNP4FlVfVgGZ4Qf+x6iyu0B4V
         74JNQWmQHknkGoDG9y27FLyFJXpBEExO2Q9AwexuRARVAWwwimTOHkA7+Gz91gOumEkT
         vyEQ==
X-Gm-Message-State: AOJu0YxDTfW32rJNFN9tpz8nkQsc817UmHt7HX5ytw6tYnG2x0RB8L+X
	7uV8oVtwG4bCrfwitN0doCmeyKozm2lYw+wL9OCIVrJFjXc3uHoQFnDwZVCmRHofjHdr6i1swwM
	VivBz0ykxhgGXjeSdwG0ygLvd9uU=
X-Google-Smtp-Source: AGHT+IF3nIdVKIMzWDRoZvX0ZH+e/XWdyTqfI8D8VfvKzBk/dJPyOoNv9fef1jOet63/0/1WYcc/Hemn2SAnx8t47zg=
X-Received: by 2002:a17:90a:e398:b0:298:c858:54a1 with SMTP id
 b24-20020a17090ae39800b00298c85854a1mr5003378pjz.9.1708093830354; Fri, 16 Feb
 2024 06:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
 <20240215182425.57334-1-jlobue10@gmail.com> <20240216113706.695b22fc@jic23-huawei>
In-Reply-To: <20240216113706.695b22fc@jic23-huawei>
From: Jonathan LoBue <jlobue10@gmail.com>
Date: Fri, 16 Feb 2024 06:30:10 -0800
Message-ID: <CAF6rpDwCx-0XnpSvkdHjpa+m-ztybjyUAzJGO25i+eT3QPx+Bw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: accel: bmc150: Duplicate ACPI entries
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, jagathjog1996@gmail.com, luke@ljones.dev, 
	benato.denis96@gmail.com, lkml@antheas.dev, derekjohn.clark@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Would you prefer if I make these small changes in a version 6?

Best Regards,
Jon LoBue

On Fri, Feb 16, 2024 at 3:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 15 Feb 2024 10:24:25 -0800
> Jonathan LoBue <jlobue10@gmail.com> wrote:
>
> > This patch adds a description of the duplicate ACPI identifier issue
> > between devices using bmc150 and bmi323.
> Title of patch doesn't reflect what is going on.
>
> If there are no other changes needed I can tweak that whilst applying
> to
>
> iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver
>
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> > Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> > Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> > ---
> >  drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/b=
mc150-accel-i2c.c
> > index ee1ba134ad42..353271e23235 100644
> > --- a/drivers/iio/accel/bmc150-accel-i2c.c
> > +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> > @@ -224,6 +224,19 @@ static const struct acpi_device_id bmc150_accel_ac=
pi_match[] =3D {
> >       {"BMA250E"},
> >       {"BMC150A"},
> >       {"BMI055A"},
> > +     /*
> > +      * The "BOSC0200" identifier used here is not unique to devices u=
sing
> > +      * bmc150. The same "BOSC0200" identifier is found in the ACPI ta=
bles of
> > +      * the ASUS ROG ALLY and Ayaneo AIR Plus which both use a Bosch B=
MI323
> > +      * chip. This creates a conflict with duplicate ACPI identifiers =
which
> > +      * multiple drivers want to use. Fortunately, when the bmc150 dri=
ver
> > +      * starts to load on the ASUS ROG ALLY, the chip ID check portion=
 fails
> > +      * (correctly) because the chip IDs received (via i2c) are unique=
 between
> > +      * bmc150 and bmi323 and a dmesg output similar to this:
> > +      * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen=
.
> > +      * This allows the bmi323 driver to take over for ASUS ROG ALLY, =
and
> > +      * other devices using the bmi323 chip.
> > +      */
> >       {"BOSC0200"},
> >       {"BSBA0150"},
> >       {"DUAL250E"},
>

