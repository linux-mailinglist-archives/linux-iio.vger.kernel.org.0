Return-Path: <linux-iio+bounces-7423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53E929C46
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 08:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66248B212CD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36B21364;
	Mon,  8 Jul 2024 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JYGrp/jb"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDA1CF90;
	Mon,  8 Jul 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420225; cv=none; b=P7gp4RTWUaz/grRPqXEp8xaiIxJGnRbdDJlLsfkns7dzPIlqb06/HIn72d7+so8iCjvTLAHalLG8I4wIHYtGP1zSvZ2dUZbqrLU3IL8JmeOr5blUw/CjvBJiaq+XYkgwN7R7oH3S5x1WathiuuATUwSz+Y4njQjSu8N+ET2BTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420225; c=relaxed/simple;
	bh=7CYSbK5rhtMafkmq7zadDDSYcUr3Oi5h8UsgVpGhdp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQhWzSKh2fFhOACo7YGFPvF/248BCuGsKlWDzOedFH/PHztocd3RI6O/6Vg7EvpWCVN5t/iJFFZ0PD4otYznHqbzFRkYtsHBUBgp9NzLvBOctDw7l9cOZsDVRsdgwmSQ+c4H0Ju8HHkVyIXZPP0W8uFpW9qRXcgPgEdu/AOD2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JYGrp/jb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F62F240009;
	Mon,  8 Jul 2024 06:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720420215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sdxky0F+LThwvrFQTzQMNsRMRU9pBlRvq7QUYvXBQk0=;
	b=JYGrp/jbfYx0cFgQcLI4vhKOzitq/Kar2e5x7kr2kjzP+1PTfRk0JAsIrQmLfvoIyuHo/v
	arrUu/cJVU2JDt3qBFk7QJgdicftvJL6UtOqaVNkM+DNCeRCwlRYNIQdILK1IZLUHrL57v
	86mQliPtjg9hO4N/uAITEtg2HUKW7kejkzJ837uqDwmahE0exeatkmx3TRgIJXuNKy5k9Y
	9+dzNubFPbkKLP8bfVOZPO1IgZCEb2xF+x87xQ2FCB1pGiz3qGpwIC1idGbRvFTkA7cKzr
	9KLF8sHa8Mn2QUSrAccoy4d0ZYwpHNmQfPO9tnOKmGlbua0qmqKNrvkW3h/1dw==
Date: Mon, 8 Jul 2024 08:30:11 +0200
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
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc:
 sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
Message-ID: <20240708083011.058d0c57@xps-13>
In-Reply-To: <20240706-remote-undergo-3b9dfe44d16f@spud>
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
	<20240705-sg2002-adc-v2-1-83428c20a9b2@bootlin.com>
	<20240705-unaired-pesticide-4135eaa04212@spud>
	<6b5459fd-2873-4c26-b986-882413b8d95b@bootlin.com>
	<20240706-remote-undergo-3b9dfe44d16f@spud>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - enum:
> > > > +              - sophgo,cv1800b-saradc
> > > > +          - const: sophgo,cv18xx-saradc =20
> > >=20
> > > I don't think the fallback here makes sense. If there's other devices
> > > with a compatible programming model added later, we can fall back to =
the
> > > cv1800b.

I'm sorry but isn't this slightly disagreeing with the "writing
bindings" doc pointed in v1? It says,

* DO use fallback compatibles when devices are the same as or a subset
  of prior implementations.

I believe we fall in the "devices are the same" category, so I would
have myself wrote a similar binding here with a compatible matching
them all, plus a hardware-implementation-specific compatible as well;
just in case.

Thanks,
Miqu=C3=A8l

