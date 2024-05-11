Return-Path: <linux-iio+bounces-4965-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84318C3262
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC764282451
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F756B6B;
	Sat, 11 May 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbJCldCR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3356B63;
	Sat, 11 May 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443562; cv=none; b=NSMgg6f6IGV8T2zd7SAIETXs+Sy3re9yia0LPRHq+5B3xssYg4uXvuQvLwaAFUvXq4xB/UORN5LzdvXlFyYtimH3ZxY22mcUDtx98eYiKslZGKD0oLj2UJBzoVf8iDJtb1UfuXOQQ7YZ8IeLOVdHqB7aZMeBAMnkplm2rjrkF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443562; c=relaxed/simple;
	bh=/A2yW0GWCa0BY2qKORT6qVkFEJQCUjFJUdsF2eSvF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myzkXI5C5qj5rXMsdGCT/FK+xX2/UJP4YTSOGCUJtnqME1pifgG8Sx1/rsfQF+hZwVJKgjLYDxuW7EfPZddIOIL0R0Jglr7VP/MEjYjsw8cbaWeBPYBS3/NjMpqkSGLUTbVWaIR6gRmClAV/hD1t6WyVKyokSZz8JI73KrydzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbJCldCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64D6C2BD11;
	Sat, 11 May 2024 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715443562;
	bh=/A2yW0GWCa0BY2qKORT6qVkFEJQCUjFJUdsF2eSvF5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nbJCldCRTNrcdTE/yiVppJZOg7XEMEoULI4ul6/3uawlMO4XTYl8qbp9PaqQO2K35
	 W1cUYlebjibwpGMjATexf8hj9NRWlC0du+yDag2AkMIzL6KH96rHaEbGbk9+vk9//9
	 0ZBqEAcYQzX4Pn56R/QtClOFIbxk6XwFvTbNhPiBcqsysibkiH8MAdD6AFmDfkBzqH
	 rjAoTCCiLwUx7gbuCLleoYR5Ga+vPdlECqKwarTTN1NGwc129xPNlpd9w5QUC/F9an
	 DOL2zxOKyplIdShljROtqAlVMe5ehDyMmZh1Evf4OycPktDi69uRySDXb/OK+mtkHJ
	 C1SiebxGNVUfw==
Date: Sat, 11 May 2024 17:05:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: add ad35xxr single output
 variants
Message-ID: <20240511170529.742e6e6f@jic23-huawei>
In-Reply-To: <CAMknhBFUUCvxbuHz0pPKd-KBcG3zfXNr8wu=AnrZx0C495RKOQ@mail.gmail.com>
References: <20240510141836.1624009-1-adureghello@baylibre.org>
	<CAMknhBFUUCvxbuHz0pPKd-KBcG3zfXNr8wu=AnrZx0C495RKOQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024 10:39:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, May 10, 2024 at 9:19=E2=80=AFAM Angelo Dureghello
> <adureghello@baylibre.com> wrote:
> >
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >
> > Add support for ad3541r and ad3551r single output variants.
> >
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml       | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml=
 b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > index 8265d709094d..17442cdfbe27 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml =20
>=20
> It would be nice to also add the datasheet links in the description.
>=20
> > @@ -19,7 +19,9 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - adi,ad3541r
> >        - adi,ad3542r
> > +      - adi,ad3551r
> >        - adi,ad3552r
> >
> >    reg:
> > @@ -128,7 +130,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: adi,ad3542r
> > +            enum:
> > +              - adi,ad3541r
> > +              - adi,ad3542r
> >      then:
> >        patternProperties:
> >          "^channel@([0-1])$":
> > @@ -158,7 +162,9 @@ allOf:
> >        properties:
> >          compatible:
> >            contains:
> > -            const: adi,ad3552r
> > +            enum:
> > +              - adi,ad3551r
> > +              - adi,ad3552r
> >      then:
> >        patternProperties:
> >          "^channel@([0-1])$":
> > --
> > 2.45.0.rc1
> >
> > =20
>=20
> Since these are single channel, it would not hurt to restrict the
> `reg` property of of the `channel@` nodes to 1.
Ah. I missed David's email because threading goes weird without a cover let=
ter
and hence duplicated his comment.
Please add a cover letter with a brief description of the series to
your v2.  Means we get a nice title in patchwork as well!

Thanks,

Jonathan
=20


