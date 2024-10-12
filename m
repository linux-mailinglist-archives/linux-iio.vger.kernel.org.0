Return-Path: <linux-iio+bounces-10510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67699B537
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E8C1F22341
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E586188599;
	Sat, 12 Oct 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBrQ0QRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560421E511;
	Sat, 12 Oct 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740998; cv=none; b=D5Gx/uu8gOI1AHh6OyoZH+aLjFJA8sHxxkNKE+8Ugc3P524CE/wzHiXPaxIbsmjXEF5slGiHDxgwXbMm0DFWcXvqBMe0JFs2EW5B2NWYGY9NHtLXX7jwPYpPvOwm41wtq3qzoHq8pOZ1mpdHh7iL2Y/rRRQeUQqySZNLp3AxY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740998; c=relaxed/simple;
	bh=XsvQo9dzUjQ2rGz0X1hhFdrT2rCTCYJ8onxhfU97Vs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScJHEbZG/Qpty0svk15LRuHir1ZfeuFGda9BmnkuCNOOS6XVC/taEZ7J9S3wBdZSR9ZRkGwiX2DogQEfJ9zYCG7irddEMu1NGprb9spzdOXgTjew3/aN6jH0epLtWtxpG5XWD/fR3aDnMbF/RXbUUAiTVKTn2i6yoI84qvnT3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBrQ0QRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B554EC4CEC6;
	Sat, 12 Oct 2024 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740997;
	bh=XsvQo9dzUjQ2rGz0X1hhFdrT2rCTCYJ8onxhfU97Vs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sBrQ0QRcXYc13gzo64UchVnABgbbLpnq+4MljA+4TeiPUe4bIJ6Wgi1zUM4zgd/WG
	 gcl78xPZtwgZStbX0JhRymhdEA1keCmEZiiT08ptoGD6kQOhJqOvAxNNLCrA+WU2ZV
	 3piC5E2jM9Gu/BMPhwMV2MH6vKcOpS/qlamw/IoIFbd6hlQRx21RLN2llJz+oIZXwy
	 jQEQGrtpO6c54f4Bdc3uU8ZGygEiK1z1Hm0AztqMMQSHlXHX0Yn3D06ioUAiaaANUp
	 uOF9katR4egqVkIMFni/z+2CH3fr96b7IAH+DVCujWVIEtgThfT0/3xS/GtuuEPX18
	 li4BgWpAtibHw==
Date: Sat, 12 Oct 2024 14:49:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dletchner@baylibre.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 04/10] dt-bindings: iio: dac: adi-axi-dac: add
 ad3552r axi variant
Message-ID: <20241012144950.435815b4@jic23-huawei>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Oct 2024 17:43:36 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> 
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using a QSPI DDR
> (dobule-data-rate) interface.
> 
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.
> 
Hi Angelo,

If this goes to a v6, I'd suggest adding a very brief statement that
#io-backend is present because it is possible (in theory anyway) to
use a separate controller for the control path than that used for the
datapath. 

So a one line summary of that long discussion from an earlier version!
 
Otherwise this LGTM.

Thanks,

Jonathan



