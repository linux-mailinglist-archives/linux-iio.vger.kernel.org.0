Return-Path: <linux-iio+bounces-13409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 921749F0600
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED50A1881EA7
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5119D8AD;
	Fri, 13 Dec 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5k1o8q8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD961192D70;
	Fri, 13 Dec 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077239; cv=none; b=c8DnfnTAwadU3ToFj3WjxwoknksLcXdpV0l5FvSWBoiuw7uuTkr20y8ZKEHf+CLpBJ1mLarb9ZYegMq62Jk5vfWv28blyqn8nTwMxwGYopewCywXAgZQ0h665YpLMk+bq10v36U64AFmA1OJ4rmh8U8wTSHZshuPcYQ+AXUZCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077239; c=relaxed/simple;
	bh=lMngbI0/z97n+hdCLmt0jLziyBdQJ7fRHaH2DkZPF0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHhJn+5lhCmFWN/wbqP1uq65WL0PJ3OEx2kpBLTGbkhkkQqulos9r6iFCnm5/NOym18tHFzJPWru2ZWyEut033UHC7vaJPhK1S/KrwsqQoDTwPtYUZFopn1aVYYhXNf0XhzUd+UOJ0w8hORXS0DilIgthMLNSV6qh47ixNdOI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5k1o8q8; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3c88163a00so187153276.2;
        Fri, 13 Dec 2024 00:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734077236; x=1734682036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMngbI0/z97n+hdCLmt0jLziyBdQJ7fRHaH2DkZPF0g=;
        b=V5k1o8q8dacPx/N9ECUsAyofa0FMACOsD0vyBaYJ16OBxc2sGYylcynnDRit3TIIO/
         nnwyDoTq+SMzmaeU9WdLKmOPBIak6YLHZ2AklgdJlvVocs1NMro0EKwyiSjHnQCjEbD0
         qpPDVdzxQLB9IqqVmFizXO7cxDnLHizAOKlF/GH6rDEKFjEpQC7+WxE7Zs/JqQTZsX2r
         RPsLsPywGyycEGyDvA6ntGhptvJAcF0Gh0oqihrFz+lohZLb2YsrdrpH3nVXqq0NQIJ7
         kC1n4VTD/Kd8l8SLvTjZXUaFaaV8O3ehBnyN+MS/ALKF6IuN2+c0gl8vQQNeWVLvXMJS
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077236; x=1734682036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMngbI0/z97n+hdCLmt0jLziyBdQJ7fRHaH2DkZPF0g=;
        b=spdmGsZhvrthQTa95a1o+chJirztIhHZKicFIL1S5qZGJGEPjyjtFhZ/x7r67G5Iq8
         K5QqUPQciUlG41dbtJ3bnRcEgDicUSa3hXc2HyH/BNF5nbB68ynZhYqX5j8ZMbo50N3r
         ASK4Dk/blgxDxGWLTqkFsy9TjJZ2k/u8CHXQWYmxKFNcNnghxNXNLCf/u1YjwPPxQm1X
         l/LYvuuKfEtkFbeGYBMtH3c0xYculhGFnjc3styXe1sNhq4rmQ86tHoa4fZiwcp84wl+
         u0d6edcGSWJ/kSZla2G3DMNcKlJt+W7sBbGqRY8frsrF/gKmJmd8XXqkEGZsZ+xlLip1
         tuAw==
X-Forwarded-Encrypted: i=1; AJvYcCUrv95YwZiAzfKxYj4uve81Fd3hgaa9KL+kml6gx5BbVC1xX0t6OFgGjMfjYfPNDHf/mmonVHxtJyp//gLn@vger.kernel.org, AJvYcCW95XXeqv/erBrfP34bwvtZfLNzA3Quq9vaDo4K1IzRJ6lfXM/8SbiINy023+FC5NM32JVEzpmSR0Zn@vger.kernel.org, AJvYcCWOab9Y+eMMjfuFvPRHqEo0m6nf8WdeaQYiPormdRPyLd9WS+p9JFqtNFrVAmdXM3ycV4ghyqFC/ndE@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4j3vsf2e0kPcMj7ezxA9/pJbkMzItUI6FVY2tOsej+CJylQj
	VnX7aEV45ojHHveRAp3ruHJLGFYnEwZ0pzP0mtGR+dYba/X7z1sW/99DvS5LZl2LzZX1fV8GnQ4
	oVAH4+WzNCPkUpu32rPkceLDbUMs=
X-Gm-Gg: ASbGncvvUfh24vBWLaJ2cPQ8qgvwN/cr8YG1LKXXg/Rvf4UJCr7vv4o+EIV+H5Vos/y
	ICd97v6rXaVsdK4ElsE3ONx1ZhyXc9mk2xnfwyQ==
X-Google-Smtp-Source: AGHT+IHln3GREML7DSIIx+2UAC2Ue9EF+yfWddVt3c1PyKWO74it203O7aM9MJ+fsu7FSNHL/nCpazUmIlfqwgNQqDE=
X-Received: by 2002:a05:690c:3588:b0:6ea:8a23:7679 with SMTP id
 00721157ae682-6f279ac3723mr7759957b3.1.1734077235665; Fri, 13 Dec 2024
 00:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211230648.205806-1-l.rubusch@gmail.com> <20241211230648.205806-5-l.rubusch@gmail.com>
 <iqdm3x6fhyosqkm4mdknf6ee2idizq3p2nt7rjqgtuzxr75iaj@tcdl2e6l5g2s>
In-Reply-To: <iqdm3x6fhyosqkm4mdknf6ee2idizq3p2nt7rjqgtuzxr75iaj@tcdl2e6l5g2s>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Fri, 13 Dec 2024 09:06:39 +0100
Message-ID: <CAFXKEHatgV9gYVCvcxmjce9qcHtVLhvQuuSuC7rxtqFa5XLtMg@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] dt-bindings: iio: accel: adxl345: make interrupts
 not a required property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 9:11=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Wed, Dec 11, 2024 at 11:06:45PM +0000, Lothar Rubusch wrote:
> > Remove interrupts from the list of required properties. The ADXL345
> > provides two interrupt lines. Anyway, the interrupts are an option, to
> > be used for additional event features. The driver can measure without
> > interrupts. Hence, interrupts should never have been required for the
> > ADXL345. Thus having interrupts required can be considered to be a
> > mistake.
>
> Partially this explains my question on previous patch, so consider
> reordering them.
>

I understand.

> And with combined knowledge, your driver now depends on interrupt names
> to setup interrupts. "interrupts" property alone is not sufficient, so
> you should encode it in the binding and explain in rationale why this is
> required (it is a change in ABI).
>
> https://elixir.bootlin.com/linux/v6.8-rc3/source/Documentation/devicetree=
/bindings/example-schema.yaml#L193
>

The accelerometer does not need interrupts connected/configured for
basic functionality. Interrupt declaration allows for additional
features. Then there are two possible interrupt lines, only one is
connected. Thus, either only one INT out of two, or none needs to be
configured in the DT depending on the hardware setup. This also needs
to be configured then in the sensor, which INT line to use for
signalling. Thus we need the information if INT1 or INT2 was setup, if
any.

Hence, configuring an "interrupts" property only makes sense, if also
a "interrupt-names" is configured, and vice versa. None of them are
required for basic accelerometer functionality.

Thank you so much for providing me the link to the annotated
example-schema. I'll try then to set vice versa dependency of
interrupts and interrupt-names and hope.. I'm sure you'll let me know
right away if I'm doing something wrong.

Seriously, thanks the link is really helpful!
Best,
L

> Best regards,
> Krzysztof
>

