Return-Path: <linux-iio+bounces-13383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD03E9EE0E9
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 09:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7264E163EA0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 08:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D820B805;
	Thu, 12 Dec 2024 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYuGrqh+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EDC1FECD6;
	Thu, 12 Dec 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991091; cv=none; b=rQRaOc5r3an+/2BW0l3qlMvaTRJ49bAPLeqyN99R9l5gTRCusl9OsSmOatiGpSvFjDCvCg5PPaV4n7l8VCD7CvqrWndBL1W0qv4Q7T+pG39u8w9FKExI5vRxLYQkdlaQx1L961D5D48QtT8sU3cs0jWBgeM28AsqWsrjZEoj5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991091; c=relaxed/simple;
	bh=aeQtjkwpV2j59R4fd0CzGkLXDmXpVmYnKfv+AhRGHt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFb4p6SdQdsn1RbGctv34y4agaLTJW20LP3Wc5UgcbfVC/sLk2AS6iCfJkb+wNdBMLQzaHeywzqfpHE4c+DuveUWGuCkyxMyKCULZY+bA2kodYGUkjaQr5rw8aYroBDfnB+ZCaQiaPn4O7GhnGjnK8w9Vploe3sfNK2lONpIRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYuGrqh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4313CC4CECE;
	Thu, 12 Dec 2024 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733991090;
	bh=aeQtjkwpV2j59R4fd0CzGkLXDmXpVmYnKfv+AhRGHt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYuGrqh+Au0n6c/9nQJtVydb7ZvrLTofLdxYrx7MrHypQV6rFolvuZBO9zyw/l2jV
	 sgznjo999E15acEghUxTCSd69oswcB6d1zzbS1In6X27za9fnR/yVhJlHuNbQAA1PN
	 nYmOZ64cre1EAB5++p4sKFKSdoNaJj3DVKRnYPYZ2KAaOTv7/yLrmDRgY1y8qYvIME
	 zm2Y+qDkJOtM+/PQmPZB71Cg1/5ekWdDFz7AI0Mx4xq8Yovawfov4I0cpXiM6sugEx
	 PkJH8+2r+6PSEWR0R1r6KXrogGLNwU5pvirUmQ6jZLNnglAhKUQUVHkxk+CI9EKblZ
	 Kaid+0jC4JaNQ==
Date: Thu, 12 Dec 2024 09:11:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v6 4/7] dt-bindings: iio: accel: adxl345: make interrupts
 not a required property
Message-ID: <iqdm3x6fhyosqkm4mdknf6ee2idizq3p2nt7rjqgtuzxr75iaj@tcdl2e6l5g2s>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
 <20241211230648.205806-5-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211230648.205806-5-l.rubusch@gmail.com>

On Wed, Dec 11, 2024 at 11:06:45PM +0000, Lothar Rubusch wrote:
> Remove interrupts from the list of required properties. The ADXL345
> provides two interrupt lines. Anyway, the interrupts are an option, to
> be used for additional event features. The driver can measure without
> interrupts. Hence, interrupts should never have been required for the
> ADXL345. Thus having interrupts required can be considered to be a
> mistake.

Partially this explains my question on previous patch, so consider
reordering them.

And with combined knowledge, your driver now depends on interrupt names
to setup interrupts. "interrupts" property alone is not sufficient, so
you should encode it in the binding and explain in rationale why this is
required (it is a change in ABI).

https://elixir.bootlin.com/linux/v6.8-rc3/source/Documentation/devicetree/bindings/example-schema.yaml#L193

Best regards,
Krzysztof


