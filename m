Return-Path: <linux-iio+bounces-23527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EBB3D356
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A0F3B8039
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E9264A92;
	Sun, 31 Aug 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr17j01W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68621265620;
	Sun, 31 Aug 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756643869; cv=none; b=cfIEAReDz0noDb/RtCN8860BjJf7gZAZXEGgE6R49IesZKjTcLfCZRtfWOmErpnPhf/BXq+ByV1k3LcFaDrfd9ajt4hII9IDFAYNvHwQEf+XaCf6U23sRRTHE4mNAPaihQ2dDejqW8cH6kRVIx/EBBfnzaR3S0DHPAYmnJwmxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756643869; c=relaxed/simple;
	bh=4ekIaT6XktJE9IS20vPyjK4SVTe96ZVwvYEroL7WlvY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+v5ojJjVuzxazpJOipF+aXlTZZ2e/cF9Yt+LGN73fgOsJlGDRikswsO6zoO091NtVAlixURdEffEHC5JrxjSJENyzLr6LnwdWZPXGlBKgx9XRI96/u75CDfaaFOw7taqXArYA3dU04waj2tTH5S0QjoDoDNehNl9Xl/R12IrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr17j01W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945AFC4CEED;
	Sun, 31 Aug 2025 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756643869;
	bh=4ekIaT6XktJE9IS20vPyjK4SVTe96ZVwvYEroL7WlvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jr17j01W9uyPqzUR9Jusftu6WzTYkeITlwvWCBJjXW3L4U6I3/0bkKcgZho+yGoB6
	 00SylOr7LQZJIImX1pGW8WhHOIHdCEu7TdLmAfOnqn30Q4KOBSby4zOvFmm922GHo/
	 1byPxh2Cz4/jhJrrba2b8yJPkSqgHcZZmGtcN+ug4A9tc/h5BhhHrqx54JCxoBATra
	 XyhFJBeKQBW0LDO4rGdtaWYE9MZ2vSWPnrd9jw3CKqMoxDyiZN9vZr9Hkzf15t2V5O
	 62jjcM0KXjiiurGNOXSjYQ0bMSd1AUloncBwekQWwtjGCY4Xz5zS2e3T1gzsNfNdkx
	 4uEqQEek4KNQw==
Date: Sun, 31 Aug 2025 13:37:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ioana Risteiu <Ioana.Risteiu@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Add IIO backend support for AD7779
Message-ID: <20250831133738.5ba540c7@jic23-huawei>
In-Reply-To: <82a21a66-409f-4ec8-9351-365031b8646b@baylibre.com>
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
	<82a21a66-409f-4ec8-9351-365031b8646b@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 11:24:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/25/25 5:13 PM, Ioana Risteiu wrote:
> >   - Add axi_adc_num_lanes_set in the adi_axi_adc_ops structure to support
> >   setting number of lanes used by AXI ADC.
> >   - Add the generic io-backends property to the AD7779 binding to enable
> >   support for the IIO backend framework.
> >   - Add the adi,num-lanes property to set the number of lanes used by
> >   AD7779.
> >   - Move the initialization specific to communication without iio-backend
> >   into a separate setup function.
> >   - Add a new functionality to ad7779 driver that streams data through data
> >   output interface using IIO backend interface.  
> 
> It is more helpful for the cover letter to contain a high-level
> overview of why you want this series included in the kernel. We
> can look at the individual patches to see what they are about, so
> repeating that here isn't especially helpful.
> 
> For example, I would write the cover letter for this series like this:
> 
> The AD7779 ADC chip has a secondary data bus for high-speed data
> transfers. To make use of this bus, it is connected to an FPGA IP
> core [1] which is handled using the IIO backend framework. This IP
> core connects to the data bus lines as well as the data ready signal
> on the ADC. This interface can use 1, 2 or 4 lanes at a time.
> 
> This series extends the devicetree bindings to describe these wiring
> configuration, extends the IIO backend framework to allow setting the
> number of lanes that are being used, and extends the ad7779 driver to
> allow using such a backend for reading data in buffered reads.
> 
> [1]: https://analogdevicesinc.github.io/hdl/projects/ad777x_fmcz/index.html
> 
> > 
> > Ioana Risteiu (4):
> >   iio: adc: adi-axi-adc: add axi_adc_num_lanes_set
> >   dt-bindings: iio: adc: add IIO backend support
> >   iio: adc: extract setup function without backend
> >   iio: adc: update ad7779 to use IIO backend
> > 
> >  .../bindings/iio/adc/adi,ad7779.yaml          |  44 +++-
> >  drivers/iio/adc/ad7779.c                      | 192 ++++++++++++++----
> >  drivers/iio/adc/adi-axi-adc.c                 |   1 +
> >  3 files changed, 196 insertions(+), 41 deletions(-)
> >   
> 
> Please include a changelog of what was changed in each revision of
> the series along with links to the previous revisions. Tools like
> b4 can help automate this.
> 
> https://docs.kernel.org/6.16/process/submitting-patches.html
Whilst I fully agree with this, please keep the per patch change logs
as well as personally I find those more useful.  For those just
changes from previous version is fine.

Anyhow, other than this process stuff the series looks good to me
so applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan



