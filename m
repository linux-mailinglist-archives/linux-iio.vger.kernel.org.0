Return-Path: <linux-iio+bounces-13413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784C9F06E5
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD0B28475C
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926C1B413E;
	Fri, 13 Dec 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/sSkSqe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FD1A8F71;
	Fri, 13 Dec 2024 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079755; cv=none; b=et0Q5gRJfAaYyKRFKOH4URzgKkzk9ZulB1niHM0GMwLXAlEcGjFaGkr8HMILwTy3z6M7F/t/psrplasdafJwnk7L9uIf306tGl0O/id8SpLv2ATkv1VftBs/XAOiMS8/H6Wsyd4v/al3+eYWH7MEqtzwjpr6wf/uHnNhbjFCzXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079755; c=relaxed/simple;
	bh=3HHbI/8U1x533ln7X0lZpqT9A6MISkLGuUXtILr5Tms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O71Z+Y+NzV8WVPjpJoGsmmFgF+acb3OAMP9BVc2UmYuIxLBnRVAj2Y1raJZJspqI/+wzM4y8MKTy5jdk4ji3jt3XrXMUzeYCpbNQQwuOY9lzdFyCKI6vMx8EJd4dQW/W+w3AkS6YFRhzUoUf+kXvwcfZ0hn9gWcwN8WY1/PGBr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/sSkSqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53308C4CED0;
	Fri, 13 Dec 2024 08:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734079755;
	bh=3HHbI/8U1x533ln7X0lZpqT9A6MISkLGuUXtILr5Tms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/sSkSqe+OXO6gWM3BUfiYvAzjo/GeuhRK7BdMByEa6zsmrBzs/47cymXE+8GDKSB
	 FiuPjsBeaAtB1jl1R2g2e1wJB3QbcdEHCEXdQHi8Ze2CIR3ufyurTM19UdXi8nLFtn
	 NB9HbLwlm/d8yL4cIMMDc6vazidX8I3H0E2lTGTrwCjFKEiaarIw+nQsm+aW+qJg9f
	 Bx4uOQcKM5UgHdrPVLcGvuuk61SMIF8MFlg2ZX5GrkY+lU94CfJwrwOQ3Oadwr83G2
	 pc1VPxctrVF7sgItrnEHzM/aa9QI4wfh/wqLVPBEJvrKsO0zGrohPQJDXa4z9/z4Yw
	 easA8zgAFkfoA==
Date: Fri, 13 Dec 2024 09:49:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v6 4/7] dt-bindings: iio: accel: adxl345: make interrupts
 not a required property
Message-ID: <vndl6ovfuebbyck36li5xzhaatkbl7hbm3mdelz2j6s4ckrs54@da3npmwzgnw3>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
 <20241211230648.205806-5-l.rubusch@gmail.com>
 <iqdm3x6fhyosqkm4mdknf6ee2idizq3p2nt7rjqgtuzxr75iaj@tcdl2e6l5g2s>
 <CAFXKEHatgV9gYVCvcxmjce9qcHtVLhvQuuSuC7rxtqFa5XLtMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFXKEHatgV9gYVCvcxmjce9qcHtVLhvQuuSuC7rxtqFa5XLtMg@mail.gmail.com>

On Fri, Dec 13, 2024 at 09:06:39AM +0100, Lothar Rubusch wrote:
> On Thu, Dec 12, 2024 at 9:11=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Wed, Dec 11, 2024 at 11:06:45PM +0000, Lothar Rubusch wrote:
> > > Remove interrupts from the list of required properties. The ADXL345
> > > provides two interrupt lines. Anyway, the interrupts are an option, to
> > > be used for additional event features. The driver can measure without
> > > interrupts. Hence, interrupts should never have been required for the
> > > ADXL345. Thus having interrupts required can be considered to be a
> > > mistake.
> >
> > Partially this explains my question on previous patch, so consider
> > reordering them.
> >
>=20
> I understand.
>=20
> > And with combined knowledge, your driver now depends on interrupt names
> > to setup interrupts. "interrupts" property alone is not sufficient, so
> > you should encode it in the binding and explain in rationale why this is
> > required (it is a change in ABI).
> >
> > https://elixir.bootlin.com/linux/v6.8-rc3/source/Documentation/devicetr=
ee/bindings/example-schema.yaml#L193
> >
>=20
> The accelerometer does not need interrupts connected/configured for
> basic functionality. Interrupt declaration allows for additional
> features. Then there are two possible interrupt lines, only one is
> connected. Thus, either only one INT out of two, or none needs to be
> configured in the DT depending on the hardware setup. This also needs
> to be configured then in the sensor, which INT line to use for
> signalling. Thus we need the information if INT1 or INT2 was setup, if
> any.

I meant, explain in the commit msg.

>=20
> Hence, configuring an "interrupts" property only makes sense, if also
> a "interrupt-names" is configured, and vice versa. None of them are
> required for basic accelerometer functionality.

I know, I already stated this. But almost every question should have its
answer in the commit msg.

Best regards,
Krzysztof


