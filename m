Return-Path: <linux-iio+bounces-19261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8056AAEC76
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A617B1178
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1E628E5E0;
	Wed,  7 May 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJPP6b6J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D828B7CD;
	Wed,  7 May 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647451; cv=none; b=gD2wdcUO2Ju7bghOnAquFuWhpQ5SPBTc+S9gNNT8nZ7MMBgj1QBVfdHi6nlIdqT3LnADMaNhjN4YDI+T1YZi+LhPCTm2FqSiYw94Q1EnakqzDd9mi+kJwP7dAaOdj4O3JWyEXJHaNQWPtMim7wRUrrGPV5o4DJN5GZ5b8NHeqeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647451; c=relaxed/simple;
	bh=3K/lkvfFCs/82QJBISbca7YT7L6y0PkB4hRjS4NLTPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8NuvKJORrd5F/gwRlP2u43M3lSPms6O7bpiFT24/IImvd+5icDIkFTqGzrvqFh5qnA9y5e6AA1rcvqbY0yGMRCWrb+WkBEIdN1NEW6s/bak4bFE+WVkm7wWWPLYl/iyeRxAcOVTCmZJYRk15fGX2esGTh1j25VV44fmYKwGv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJPP6b6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971BBC4CEE2;
	Wed,  7 May 2025 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647450;
	bh=3K/lkvfFCs/82QJBISbca7YT7L6y0PkB4hRjS4NLTPI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJPP6b6JhvABdbIrF7lmXfQt6Tu3HuuqG9VFadfM25ZFeJ6NDzqcRd2p9FUpXPUb9
	 7GRSVsG1qmDbuARLCppknxhRlqXccrhQ56Wx1h1DJvlUM5HqX+WEzAax2SrBpv5GpN
	 YpCJEqrjlER1QWjNpm+o7pgtg8uFOFCTMbIznLITd112w5ANrF0o79VxW3Jx0WbYJl
	 h9qY3JvfwUvCF9OnBk6WfabJ7uW/9/hY3silNDszSP0NBnzfds4ShjltISileRlCcQ
	 BNJAV6RsEKICoX2UABWmze2KA3wVHC/jEEIMc0n1Q5JD0vCOBQVupSnVYr3vU1N4iw
	 lEERR8qoRN9Pg==
Date: Wed, 7 May 2025 20:50:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 20250505163919.6d805db2@jic23-huawei.smtp.subspace.kernel.org,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v6 02/11] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250507205040.3a1eec14@jic23-huawei>
In-Reply-To: <aBpgFQ+/KBXdvyWx@JSANTO12-L01.ad.analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
	<128de2793d6d5424ad152c394faf1d51f0d56e0b.1745605382.git.Jonathan.Santos@analog.com>
	<20250505163919.6d805db2@jic23-huawei>
	<aBpgFQ+/KBXdvyWx@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 16:16:37 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 05/05, Jonathan Cameron wrote:
> > On Sun, 27 Apr 2025 21:12:16 -0300
> > Jonathan Santos <Jonathan.Santos@analog.com> wrote:
> >   
> ...
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -65,7 +95,6 @@ required:
> > >    - vref-supply
> > >    - spi-cpol
> > >    - spi-cpha
> > > -  - adi,sync-in-gpios  
> > 
> > Maybe worth requiring oneOf adi,sync-in-gpios or trigger-sources? 
> >   
> 
> We cannot do that because we defined that self triggering is enabled
> when trigger-sources is omitted (is this case adi,sync-in-gpios is not
> present as well).
Ah. Fair enough.  More complex but we can constrain to never having
both adi,sync-in-gpios and trigger-sources at the same time.

> 
> > >  
> > >  patternProperties:
> > >    "^channel@([0-9]|1[0-5])$":
> > > diff --git a/include/dt-bindings/iio/adc/adi,ad7768-1.h b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> > > new file mode 100644
> > > index 000000000000..34d92856a50b
> > > --- /dev/null
> > > +++ b/include/dt-bindings/iio/adc/adi,ad7768-1.h
> > > @@ -0,0 +1,10 @@
> > > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > > +
> > > +#ifndef _DT_BINDINGS_ADI_AD7768_1_H
> > > +#define _DT_BINDINGS_ADI_AD7768_1_H
> > > +
> > > +#define AD7768_TRIGGER_SOURCE_SYNC_OUT  0
> > > +#define AD7768_TRIGGER_SOURCE_GPIO3     1
> > > +#define AD7768_TRIGGER_SOURCE_DRDY      2
> > > +
> > > +#endif /* _DT_BINDINGS_ADI_AD7768_1_H */  
> >   


