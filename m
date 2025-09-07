Return-Path: <linux-iio+bounces-23843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4744B47A84
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E63BED1D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93024A04A;
	Sun,  7 Sep 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRMWKOTB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200563C38;
	Sun,  7 Sep 2025 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757241664; cv=none; b=UprO3hMtxRDjZl42+IiMaUhAqGjKqj1lf/oQKNwJGOypssFEv6PqbjOdwfMi5wjdPYZs/1YaAfRnnqf3GAyU7VGfBTGJEwa9AgRUfgRz7QkKrokboh48nmLPqhbSc/ZPsDe37MUGOiZVydLjvWHCiPItpcIOWKk0SN+cfv3HUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757241664; c=relaxed/simple;
	bh=uX0rV7pclo3u6iCygAi1uvxgHidCkEPhVgy6zlZMKwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDgqeSbttU6x5IaO1r27uX2RAECAbOR+6QqRrj4sRLG0U3GtQA7H2y9wpGjyHU1O9BWaeSDLYl8QeIMS8wo8IXgiuM80XW31kZXUYbEz6eMyf0BJgVhoO59NYSuMIW6RY92eZft9CBovdd4m3L9foyH/I9pbuX/QbbzDSRsMQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRMWKOTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C757CC4CEF0;
	Sun,  7 Sep 2025 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757241663;
	bh=uX0rV7pclo3u6iCygAi1uvxgHidCkEPhVgy6zlZMKwk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SRMWKOTBywY/HnTIOMiPnLTsYUW7fimuvyftSnacn+bcnkjFsV9jpUBabTUl7AeDy
	 8DsYRM9VYPEfmlsfB6/WR3kULKKDPYs9Nsp2DGhvXpNH0NHInisewm9eq1PrGiVRH1
	 G6c4drDixdP20zA1ZdkTeffU70QK3yoP17rR+w9Z4uXu1K5sJjcg79+Fn8uTOhI9Y0
	 p2JqxaVkW6SR3lY0Kb23ob7iEsw2aKqmclRXZWR7ABmpGCUTfsciPxUJ+dfp02f1hX
	 7Um12Ovw2pU5y4yXT0CB916JuPsR6biNC1ey93OdrQ4QzQDkY3pQE5t8yKbldpjb1G
	 uvZCkn0HnZNXA==
Date: Sun, 7 Sep 2025 11:40:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Karel Balej
 <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC
 ADC
Message-ID: <20250907114052.08658ac9@jic23-huawei>
In-Reply-To: <CAHp75VewzAN+tcJ9GrWESY38Uq+qeA4QH=qeaEV8g35H67GcMg@mail.gmail.com>
References: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz>
	<20250905-88pm886-gpadc-v3-2-4601ad9ccb51@dujemihanovic.xyz>
	<CAHp75VewzAN+tcJ9GrWESY38Uq+qeA4QH=qeaEV8g35H67GcMg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Sep 2025 16:39:05 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Sep 5, 2025 at 2:01=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemiha=
novic.xyz> wrote:
> >
> > Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> > monitoring various system voltages and temperatures. Add the relevant
> > register definitions to the MFD header and a driver for the ADC. =20
>=20
> Jonathan et al. The Q here is do we want to somehow make values
> spelling (in the comments and documentation) be unified with the
> Scientific Style [1]? Personally I find the article very useful and
> one style for the whole subsystem would be good to enforce (in my
> humble opinion). Thoughts?
>=20
> [1]: https://poynton.ca/notes/units/

I should have included in previous reply that I would not want this
driver stalled on that discussion, so let us guess the outcome and
go with the unit formatting suggestions Andy makes in this review.

The question of standardising on this aspect and documenting it can be reso=
lved
in parallel.

Jonathan

