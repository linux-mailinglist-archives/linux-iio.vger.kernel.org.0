Return-Path: <linux-iio+bounces-5122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1C38C959B
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF8F9B20BAD
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD74F881;
	Sun, 19 May 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4kP6sFw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B84AEDF;
	Sun, 19 May 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716140491; cv=none; b=Mb5NBE/olmjrdrHK3sXXVbuwXHf90hFfLdJwp4Z0iqFRRqjO7/FqG/dUR52rTeQOjUq6PUHceATd5x5QpssBntolQK2y/sZRvolCQ9ux4iF4ViW09khw0TcdyXCkr1MK83gUd3yUlqXxtZN4urDXbpmdCQk+ZixJY46s3TpAYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716140491; c=relaxed/simple;
	bh=3X5gVOifa2obU56urc8799IYLnQNDhoLeW9pQ7MAPyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKbmYIHqGBZ2/kRxAJg3L6VyHh9pQLDQL7azuM9qGizoFu+8POmFKck5fOZaWIQhbbgtbUUkWgKhlZqiwRUFD3NdO9ATNUhkzOawbaWsoqc5mQcJhBELN5q5810j1hSMA3PXIJKh3SzJRng0pWcUi4hyAkuKO3/OArR0hVUp184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4kP6sFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE88FC32781;
	Sun, 19 May 2024 17:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716140491;
	bh=3X5gVOifa2obU56urc8799IYLnQNDhoLeW9pQ7MAPyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h4kP6sFwM0sk8Znco0WYoe3Ub9AxDoA/eEQ/5K8lOwYxMfczbR4PprIGtH71Xbrus
	 +h5gIBBACSVgdo2A0idLUrAOu277ncPBlATSm6nlYkArxaAf6ijk3VyP1z3OqfQKVc
	 tksfFVDC3OurDMJskGy2E9iT/wUFhy8NomCY+Qp2iTauiVztovF3C9wfv2VOBKo351
	 Ou3t3y4M4Z64qBIGSaORfFa4JSMaWRmCGWkycFtsQjJiSXWCa+njzg9O5VOEP4kJwb
	 ZSlugpj4+SmqPADmBoJpYKVF20B/QdyQWNWlhRRkGdIOTRUzIksADPu3vvGjHSRD9X
	 p1JLj5s+oCUfA==
Date: Sun, 19 May 2024 18:41:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,axi-adc: tweak example node
 name
Message-ID: <20240519184119.7fd75ab9@jic23-huawei>
In-Reply-To: <20240513141906.GA2534611-robh@kernel.org>
References: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>
	<20240513141906.GA2534611-robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 09:19:06 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, May 10, 2024 at 04:04:38PM -0500, David Lechner wrote:
> > It is always recommended to use generic node names for devicetree nodes.
> > The documentation [1] of the AXI ADC IP core says "The most important
> > part of the core is the Receiver PHY module.", so using phy as the node
> > name seems appropriate.
> > 
> > [1]: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > index e1f450b80db2..9cad4c439045 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> > @@ -57,7 +57,7 @@ additionalProperties: false
> >  
> >  examples:
> >    - |
> > -    axi-adc@44a00000 {
> > +    phy@44a00000 {  
> 
> phy should be used when there's #phy-cells which is not the case here. 
> 'adc' is somewhat standard. Or maybe it should be tied to 
> #io-backend-cells.
> 
> Until we have something defined as ti what it should be, we should just 
> leave node names alone.
> 
> Rob
> 
Unapplied.


