Return-Path: <linux-iio+bounces-9808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C01988F83
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F381F215D2
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E651885B7;
	Sat, 28 Sep 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bx4+U4+F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF282125DE;
	Sat, 28 Sep 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531447; cv=none; b=EVTeRmuhmNb+ayXr3549HJJBErZKppXT9opq5pTkZCM9Ev84vK0NjprDciT9jgyEEbDbDCCnsAbHbLpK4TYlLHxlhSYi38pWbrvRARacfc9DAEgsuopaCpeeyvcA6rZ9TxctKLx6WCFaWZaJGfsVihoOinGP0FsWrn5mQ+KfB4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531447; c=relaxed/simple;
	bh=ebIdiMVnr7YdFN3py+uVaU4t4rlZhbCkOPHsLHlqKXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jp8TcOlVyCNGvDgXELWiM5li9bBH6IJiRFN0amgb4TZZp4syrioa0gi/cEujI1GfP0TYkaClNOgsTCyHLo1Sryo29F70H3h9jU9rFuv8sD9g6BRrSvH9Y2qd0VPfniXgG2LIxiV6FEBwpxbC2dqhaHFuGrqp1PedbIhnF66Bb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bx4+U4+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB65C4CEC3;
	Sat, 28 Sep 2024 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727531447;
	bh=ebIdiMVnr7YdFN3py+uVaU4t4rlZhbCkOPHsLHlqKXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bx4+U4+Fi8G4U/FSQGjtIv+7qDTNquTnZ8Nejf4vnd3WDzXyaUJYR4m5BeHAsWKTS
	 /Xr8z9cSFpry2pkzXDeSI0UIQrr5bg8smhU7vMdGkkOM4199hWQBOv9zKuD+C0TpTb
	 j04TqP9akDaY0iwcI2doAOget/g0hjoTvmJE0/31PPeydjaymI6p6cl4sQvmgVF0e7
	 lahMwvBo8IRSwb2yb4D5v/sQBM/w1AogMqkwrrfG70Htz03Tz+Wn9Ujs8BSo/uoUV5
	 tMLRdfikeFpIClnh1usKuy0bmEsAwAym/cpzLQDkFyWitYXMBGTveZmIg0W3INRcxV
	 uPm8oFaYiP+Dw==
Date: Sat, 28 Sep 2024 14:50:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Auchter
 <michael.auchter@ni.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad56xx: Fix duplicate
 compatible strings
Message-ID: <20240928145049.74dabfee@jic23-huawei>
In-Reply-To: <CAL_Jsq+oJ71ncJOLH_ozyKgO8N0Dq85nvXM00cpOE24wUprXjQ@mail.gmail.com>
References: <20240910234440.1045098-1-robh@kernel.org>
	<20240914151806.66c58bfd@jic23-huawei>
	<CAL_Jsq+oJ71ncJOLH_ozyKgO8N0Dq85nvXM00cpOE24wUprXjQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Sep 2024 10:22:19 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, Sep 14, 2024 at 9:18=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 10 Sep 2024 18:44:39 -0500
> > "Rob Herring (Arm)" <robh@kernel.org> wrote:
> > =20
> > > adi,ad5686.yaml and adi,ad5696.yaml duplicate all the I2C device
> > > compatible strings with the exception of "adi,ad5337r". Since
> > > adi,ad5686.yaml references spi-peripheral-props.yaml, drop the I2C
> > > devices from it making it only SPI devices. Update the titles to make
> > > the distinction clear.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org> =20
> > Is this an urgent thing, or can it wait for the merge window after next?
> > For now I've queued it up for then in my testing branch but can yank it
> > out and send it as a fix after rc1 if that is useful. =20
>=20
> Sooner would be better. It's now a warning in dtschema main branch.
> The issue is not so much the duplication, but that which schema gets
> applied is not deterministic.

Shifted it to my fixes-togreg branch. I'll do a pull request for that
fairly soon (once rc1 is out and it's had a little soak in next)

Thanks,

Jonathan

>=20
> Rob


