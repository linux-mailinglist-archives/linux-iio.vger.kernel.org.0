Return-Path: <linux-iio+bounces-17641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA51A7CA3B
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0791893355
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F7C15ECDF;
	Sat,  5 Apr 2025 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZfRhWha"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB786535D8;
	Sat,  5 Apr 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743870356; cv=none; b=BydO4Yh9m0sxLtw4Dl9aAJWwJ+v81gOCCY7NvGPx0NZ4v4Xl/Ghr0tL2O8p6tBBctOxwgGA8ohSim7ZgpX9ediaM/icK47l1hTxizpcnynebromk+1vW0o9myeQ9DleHiNdhG5oMGJODqdCeXowFh7Aa1BwuO6pzDISm213YBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743870356; c=relaxed/simple;
	bh=9R51YVvFpedGOOfa/HArTN7EaPaCOdkm9MmZsv4uSLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgGMkpjA7u5HfN77bjBQodKT6TFKWvrtt83oJy3JYIaaK+ctynqFbKlLrszT+Iu2o+Y/l1uvRhvY7qgnmhRh6+pEDZLtUg9yr/7irOnZ4w9hUBWa9Ybo+HrGo58+/HFfKNyAS67OoFw5kf/tAvrcAmpl7b5utmdNjabeUXnEf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZfRhWha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11A4C4CEE4;
	Sat,  5 Apr 2025 16:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743870356;
	bh=9R51YVvFpedGOOfa/HArTN7EaPaCOdkm9MmZsv4uSLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WZfRhWhaND4CSSKaZzuCrtrVZ1I//D39DgMH/uUXCLkRYnzwLHKlq4xU/mHJkSefI
	 icGw/QU8XV2ytk/sRzgwMmSR+3l4zEkz7lB+IvCgfIs0HfmHTDYyzG2Mm/yH+wEwJQ
	 O9nYIet/m965kkqts95bs1S+SPbxpsSV9zbnvG0j4CcPxB4g1e2+TJFwHS5cbcwkRy
	 MlN5Ru84fnbacK/ItTDcWtrFgU2YFSjNWycb84pDKrezC8NVRyyriz3C9EfRbGzrf7
	 szTQBb7bz6khdr293fnpASduFQJMRG5cz3BoL9O5RbEkMYpuCrhv9pece5qUjuU+lT
	 tZqp3C+4oIeLQ==
Date: Sat, 5 Apr 2025 17:25:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 7/7] iio: ti-adc128s052: Drop variable vref
Message-ID: <20250405172541.641ddb39@jic23-huawei>
In-Reply-To: <c42b1dc3-34d9-4419-ae2e-5bacffa070b6@baylibre.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
	<dda9e0710a9293a9f52e64c092f79afd4b719536.1743573284.git.mazziesaccount@gmail.com>
	<c42b1dc3-34d9-4419-ae2e-5bacffa070b6@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 15:49:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/2/25 1:10 AM, Matti Vaittinen wrote:
> > According to Jonathan, variable reference voltages are very rare. It is
> > unlikely it is needed, and supporting it makes the code a bit more
> > complex.  
> 
> There is also around 60 other drivers where we could do something like this
> in case anyone is bored. :-p

Hmm. It would be a gamble but also a nice cleanup.

We 'might' meet a case where someone notices it but seems fairly unlikely...

J
> 
> > 
> > Simplify the driver and drop the variable vref support.
> > 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > ---
> > Revision History:
> >  v2:
> >   - New patch
> > ---
> >  drivers/iio/adc/ti-adc128s052.c | 29 ++++++-----------------------
> >  1 file changed, 6 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index 0f93c6266527..0bfe4e558c69 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -29,13 +29,12 @@ struct adc128_configuration {
> >  struct adc128 {
> >  	struct spi_device *spi;
> >  
> > -	struct regulator *reg;
> >  	/*
> >  	 * Serialize the SPI 'write-channel + read data' accesses and protect
> >  	 * the shared buffer.
> >  	 */
> >  	struct mutex lock;
> > -
> > +	int vref;  
> 
> Units in the name are helpful: vref_uv.
> 
> Could also consider doing division in probe and storing vref_mv instead
> since we never use the microvolts part.
> 
> >  	union {
> >  		__be16 rx_buffer;
> >  		u8 tx_buffer[2];  
> 


