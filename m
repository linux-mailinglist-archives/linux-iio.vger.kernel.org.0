Return-Path: <linux-iio+bounces-8682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A095B0EF
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 10:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD4C1F26A60
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A081216EBE6;
	Thu, 22 Aug 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i7uUTlCD"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB81CF8B;
	Thu, 22 Aug 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316776; cv=none; b=d3BKsXTkz4W2UPxpl9g8ZxnHwOCGj+YHPRXbggnItKe7aI7egEm/bEMe7kv4tFGlSti0YR+vCJO8XoeJxbnm8AiM9GRUI8hFVKPSjR3d47+hyTE0kHqg4tf098UVnSfpt9KZNMTgyyTyRmzGpkYEUF5a6X3shYU01ZCv01SQsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316776; c=relaxed/simple;
	bh=/fECh7ipAai6eCx1RusnLoT6gkdwRDlMT8OybqpP7jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJjJRaJhPCpJ5qRz14VUmeeKBkXqcPj8BQPeGfbV7wSZT0XXky+OwYX3Ra0/KwSGZiA9CIAhgbJLhuv3aIcqmFCE+CNi54aOi9VfN2rhpN09Al6plKBPAUbGZxqvgI57k3gHkyjt31fZMmXv3JwCVQz81MYQ8CbGTeQ2thuDL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i7uUTlCD; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E82640014;
	Thu, 22 Aug 2024 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724316771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UIGzrVaAQPnYlVfpyNoYN2nYYqPJiVh7oMdysgcqNU=;
	b=i7uUTlCDY8YsUUZ29X9DOU5fWK/bhszXgWeO6WruYIikgph+s9xbgkwZovwoqXkPZrcUjV
	gWHBRw8LP7eeMPVL3rAbAmaevFhCJ8fWboLzIrVM03CwV5hp5ohhIM7qJuuIuuyUS/XBQi
	an6YctOHY6YyEkox7+7u84nnsV/i+UZ9HovjLh/CG+f5xjMdL844pm0qbaNHKhArzz2bom
	Nn7nY0Ihc3xVwUDV3OYmQKdkwHvEH3j/3d7OUBQblE/bAJO1g6+XrX4ZHadiFZV3QVfulH
	xKnrDsbGSCAZm8OYq/TSibGYG+akOpMxizy62KrOg66O1+m2H/oKuFE6+CJopg==
Date: Thu, 22 Aug 2024 10:52:49 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto
 <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc:
 sophgo,cv18xx-saradc.yaml: Add Sophgo CV18XX SARADC binding
Message-ID: <20240822105249.0fd64d67@xps-13>
In-Reply-To: <20240821-unholy-statutory-7aa884ebf857@spud>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
	<20240812-sg2002-adc-v4-1-599bdb67592f@bootlin.com>
	<20240812-unwary-mongrel-9f6758bf624c@spud>
	<89aabfbe-79bf-4da7-be44-b6cbd92b72a9@bootlin.com>
	<20240820-borough-latch-17d785301aef@spud>
	<20240821094150.5787905b@xps-13>
	<20240821-unholy-statutory-7aa884ebf857@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Conor,

conor@kernel.org wrote on Wed, 21 Aug 2024 16:29:42 +0100:

> On Wed, Aug 21, 2024 at 09:41:50AM +0200, Miquel Raynal wrote:
> > > > > > +      Represents the channels of the ADC.
> > > > > > +
> > > > > > +    properties:
> > > > > > +      reg:
> > > > > > +        description: |
> > > > > > +          The channel number. It can have up to 3 channels num=
bered from 0 to 2.
> > > > > > +        items:
> > > > > > +          - minimum: 0
> > > > > > +            maximum: 2   =20
> > > > >=20
> > > > > Is this sufficient to limit the number of channels to 3? Aren't y=
ou relying
> > > > > on the unique unit addresses warning in dtc to limit it, rather t=
han
> > > > > actually limiting with min/maxItems?
> > > > >    =20
> > > > It seems like I can't use min/maxItems on this property. I think th=
at it is
> > > > using size-cells + address-cells to deduce that the number of items=
 should
> > > > be equal to 1.   =20
> >=20
> > Looking at dt-schema, I couldn't personally understand from where did
> > the error messages reported by Thomas came from. There are clear =20
>=20
> I think the complaints are on a more meta level than that. He provided
> an items list
>      properties:
>        reg:
>          maxItems: 1
>          items:
>            - minimum: 0
>              maximum: 2
> but this list only has one entry as there's one -. The first complaint
> from dt_binding_check is that having maxItems is not needed with an
> items list, because the items list contains the maximum number of
> elements.
>=20
> The second one comes from cell.yaml:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/meta-schem=
as/cell.yaml
>=20
> It either allows a single item, with maxItems: 1 or multiple items, in
> which case maxitems must be greater than 1. That's where the "anyOf
> conditonal failed" and "1 is less than the minimum of 2" stuff comes
> from.
>=20
> I hope that helps?

Ah yeah, makes sense. Thanks a lot for your feedback!

Miqu=C3=A8l

