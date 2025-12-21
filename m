Return-Path: <linux-iio+bounces-27290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1754CD445E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93286300795D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49B309DAB;
	Sun, 21 Dec 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWB3cU3S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08223093AC;
	Sun, 21 Dec 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766343446; cv=none; b=KBJIyOnMUZPtMbF4fQqX+F4W8Ae3eZLlCT21csvtr5faTV/Wbh4R4L3ripSN3Hjj35eW5WuernziAv6zf04aVTxH4XtZUqwCrA0YWQmcSskY+6fEk4EOW+JZkCYOQ59svCmpTYfKmjyW2juTKcBnw6mNbiXlALe95MSzEeTs5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766343446; c=relaxed/simple;
	bh=lR5rejZHjAKu1vr8f+ap+f4znDOGloNIQ1y+C75VKZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlnF+OVtU+r9BPTs8quuilMXZAFazizieelD7rMMf9RYBFfcrU+qi8ICI/IKZAcf7SwSuZoz77zpjZLy25Yboah5+HSmPyN9kb8i4rjbs4L1NT8h49hD5UNpb/44KwneQgaBc9JVagViH5BeOxv82tt+Iy6A2DrIhZzsZyp2wYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWB3cU3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09E3C4CEFB;
	Sun, 21 Dec 2025 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766343445;
	bh=lR5rejZHjAKu1vr8f+ap+f4znDOGloNIQ1y+C75VKZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWB3cU3S91k7I+0VnmIZPg9+5hF8e94Dl6zszZ8mGQSVfPJx4e4sq8t5tEicKv3z/
	 OoChXwARUeTJ0rsCxh+5DFiE0JLDYqU7mtvQGbLdU7l0CcuFeQ9AggGjahg7Ow5gXw
	 h/RjPgqQLz1bMJBNtqUasWSDA8JI78TZFyf6ScQiQld66feCYyG9TOIvbnnJguH/Zy
	 CVqfRsQ954OOf5IAYRy69pIvGACYbjB7fk0NF/pLdtfQCNUJXyWiKIV6Jt0Fs6JuxD
	 wKK2f5AoVqYGXMnpo+HmEGkSKzMhmECywyc9Mzo/dTJIsEm9VxZgIKEHQvhnFk4qqd
	 UAUlQVLY00bSQ==
Date: Sun, 21 Dec 2025 18:57:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ajith Anandhan <ajithanandhan0406@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
Message-ID: <20251221185716.65b442d9@jic23-huawei>
In-Reply-To: <5926ca19-c204-4abc-9e59-86a797b63b5c@baylibre.com>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
	<20251109141119.561756-3-ajithanandhan0406@gmail.com>
	<5f15284b-159b-4860-b58b-35c624e2539f@baylibre.com>
	<8e2c73ca-3746-4b2a-9d85-c12b51a69059@gmail.com>
	<8ad18de5-53cd-49ba-8e84-1e8c7e5bd627@baylibre.com>
	<15106906-3bcc-4187-87d9-c838fe99b583@gmail.com>
	<5926ca19-c204-4abc-9e59-86a797b63b5c@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Dec 2025 11:42:15 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/15/25 10:49 AM, Ajith Anandhan wrote:
> > On 12/15/25 10:06 PM, David Lechner wrote: =20
> >> On 12/15/25 10:13 AM, Ajith Anandhan wrote: =20
> >>> On 11/18/25 7:34 PM, David Lechner wrote: =20
> >>>> On 11/9/25 8:11 AM, Ajith Anandhan wrote: =20
> >>>>> Add driver for the Texas Instruments ADS1120, a precision 16-bit
> >>>>> analog-to-digital converter with an SPI interface.
> >>>>> =20
> >>>> ...
> >>>> =20
> >>>>> +#define ADS1120_CFG0_GAIN_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 GENMASK(3, 1)
> >>>>> +#define ADS1120_CFG0_GAIN_1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0
> >>>>> +#define ADS1120_CFG0_GAIN_2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1
> >>>>> +#define ADS1120_CFG0_GAIN_4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2
> >>>>> +#define ADS1120_CFG0_GAIN_8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 3
> >>>>> +#define ADS1120_CFG0_GAIN_16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 4
> >>>>> +#define ADS1120_CFG0_GAIN_32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 5
> >>>>> +#define ADS1120_CFG0_GAIN_64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 6
> >>>>> +#define ADS1120_CFG0_GAIN_128=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 7 =20
> >>>> We could avoid these macros by just doing ilog2(gain). =20
> >>>
> >>> I understand your concern about unused macros. I've kept them for doc=
umentation purposes as they map directly to the datasheet register definiti=
ons, which makes it easier to verify correctness against hardware specs als=
o I'd prefer to keep it like this since it give more readability Shall i ke=
ep this as it is for this initial version? =20
> >> I would argue that if they aren't being used then omitting them would
> >> save us the time of having to verify the correctness in the first plac=
e.
> >> =20
> > I understand your concern about unused macros. This was suggested by Jo=
nathan earlier. =20
>=20
> Jonathan is the maintainer, so if he is fine with it, he has the final sa=
y. :-)

I don't care strongly either way.  Personally I slightly prefer
to see full definition of a specific register rather than just some
fields so we now what else is being written to 0.  For the
case of registers that aren't touched at all it can be a lot
of noise to define them if there are lots of them. For one
or two it can be better to just do it even if they aren't used.

Anyhow, I'm not going to be fussy about it either way!

Jonathan


