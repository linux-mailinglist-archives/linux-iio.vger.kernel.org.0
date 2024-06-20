Return-Path: <linux-iio+bounces-6644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D870C9112C1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 22:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D5C283F1C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB91BA867;
	Thu, 20 Jun 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N75if0Yp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867F171A5;
	Thu, 20 Jun 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718914117; cv=none; b=WSlvtRZwV/C2H2AOIUeAwLn+m2y5IjGG7rLHwFvpfXsiV9HeUzXY5IJrV0geNOeomRV80OwMsMRk3CYJkSAqT/+URrVxq8K+vLjZS6GVuWtS+BW8rM5/hxC6rxZBJ0vchgFVuH91kbcTawbxgDsyJxamqFNUKw7NFDHd7SZm5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718914117; c=relaxed/simple;
	bh=9ykYoSNL6xmwMxQWQZVNhQtBkPMtS79EfXSuMEMNCAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvkeR5gMLWfKl662NK0JOrNv1b0sy5O/i1Q5m9XRBGD9OBBp/GKVpptXaPWJf2hAkPIKD7a4Q6JaitAWcKEgFDMFWPjgCEP94Tn6GbVbqFhlQFZh/KjyMmlMszcVbdAyf7uutADxdBIE+vCeURGM83dJ0PCcaW0Aei8zJSmSmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N75if0Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82450C4AF09;
	Thu, 20 Jun 2024 20:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718914116;
	bh=9ykYoSNL6xmwMxQWQZVNhQtBkPMtS79EfXSuMEMNCAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N75if0YpkfH5WOAzXHn03Pd198BU3ZCm8jLXIFD/UIoMFTiMm3WfVVVxlDzkExTgK
	 VSU1CjhaXehgcsgTfIqNgU64Wm6LvDgBnhk5vXxSBLtN7nv6GN+I53AqeRTz5tQr9r
	 wqgpcQH3ja/qHgSwhnFq5UEHE7CGYbfWtlH5162DEF9UkZ/QD/GvpDgHw23Pi8wwKq
	 sEZbrAMvdIH6JFcOOJH7himkVVDNv2VyhLM9snrOz5LSZvAKpBwi5mAYqlcc1oghwN
	 YcmDE3OQe3Z4/ikxyJnuY+qvvubswEn2QpxMkH0tOafOGKz2JPCvrI2n5KT0t0EGop
	 m+yo0kRA+aFTA==
Date: Thu, 20 Jun 2024 21:08:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
 marcelo.schmitt1@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: adc: Add support for AD4000
Message-ID: <20240620210827.2b46a718@jic23-huawei>
In-Reply-To: <f877b9a1-6cd7-41c2-ac26-46516e0340da@baylibre.com>
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
	<e77a00d1020baa178cb6a0201053b66cb27c39a9.1718749981.git.marcelo.schmitt@analog.com>
	<f877b9a1-6cd7-41c2-ac26-46516e0340da@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +struct ad4000_chip_info {
> > +	const char *dev_name;
> > +	struct iio_chan_spec chan_spec;
> > +	struct iio_chan_spec three_w_chan_spec;
> > +};  
> 
> I understand the reason for doing this, but it still seems a bit weird
> to me to have two different sets of specs for the same chip. I guess
> we'll see what Jonathan has to say about this.


It's very common, though for a different reason.

Normally it's for cases where we have events (threshold crossing as similar)
and the interrupt is optional. In those case we have channel specs with
and without the event.  In this case the change is small so maybe
the code to set it up on a copy of the chan spec would be fine.

This is simple though so I'd keep it this way.

> 
> > +
> > +static const struct ad4000_chip_info ad4000_chip_info = {
> > +	.dev_name = "ad4000",
> > +	.chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0),
> > +	.three_w_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1),
> > +};
> 
> or could just replace all of this this will spi_w8r8() and have
> a one-line function.
Good point. I'd forgotten that existed.  Better still than
spi_write_then_read.

Glad we spotted some of the same things. Sometimes it's weird
and two reviews are entirely unrelated issues throughout!

Jonathan

