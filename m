Return-Path: <linux-iio+bounces-11657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8AB9B6EC4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 22:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433B4281BC5
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1684F21503D;
	Wed, 30 Oct 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3Amj9hj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF91EB9FD;
	Wed, 30 Oct 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323507; cv=none; b=h2ITlYFhxqhOt/8NO7hxx8a3fsVIJaopf05i+c3BJC6zX1nFa+8e+L95Eu5FBsjpQrTXBrg5GMKgAFN5u0roZ3zp2CqIFnMYUiKj+1T+SFTMHHs5qgq61XN0SG+OlUEcxraVjk9Le+4uWM7gZ2q0BZ3hlX18kJgcWdUARo9fpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323507; c=relaxed/simple;
	bh=HqMNgKCMVJf0qZFzcCiaUNfllfqVoCmIcc6FTWRTOLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKDWkiWFtj1lFia9fYPurlUkbuOXq92G1vHWrWhd3Es7ekgeKbepw54jOHtN+8J2tkLfw+aw04+vXwfi/B9ZZPkr4t8Bc6Z85NigZIbT3ZnHgqC16X7s756VDsTpBsr3z6m27C8JcY7TpgbsPH2xtzcBL5teY5ouxr4Tj3OTHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3Amj9hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2314CC4CECE;
	Wed, 30 Oct 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730323507;
	bh=HqMNgKCMVJf0qZFzcCiaUNfllfqVoCmIcc6FTWRTOLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3Amj9hjHHB/5N2J3vUBEOL8o4Rp+AL7IPLsdojeZ0fr4nVXY73pQ+mPrz1ei/5N+
	 WUkcIGUOykvH+tKcS1Gta9FPMXXtrKXBBDEXDbky59xJO9BnFDCBRqriWy1gyml3mN
	 je5hPo0KxRM7VXOqKAyGO5a2Uunc1wv7MBKmYxZUUF1Ue9mkGPBFSGGNKT0oF7ljUZ
	 SUEq7wPT68Ep8cujOtB/PfeAO3lLc9ymh5lJp5W3HlLDDk9gwnlIpQHaPPMiL4r4FY
	 voSkFBOkYrkxTb7QZQ03Wla0Dc08w6STFGfJyMgTd3iUZ2DYtfkYthGwKv40fQzvjw
	 zTtYVvSs6KaEw==
Date: Wed, 30 Oct 2024 16:25:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <angelo@kernel-space.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	dlechner@baylibre.com, devicetree@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <173032348133.2084422.16647794815032410489.robh@kernel.org>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
 <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-2-f6960b4f9719@kernel-space.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-2-f6960b4f9719@kernel-space.org>


On Mon, 28 Oct 2024 22:45:29 +0100, Angelo Dureghello wrote:
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
> Note, #io-backend is present because it is possible (in theory anyway)
> to use a separate controller for the control path than that used
> for the datapath.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 69 +++++++++++++++++++++-
>  1 file changed, 66 insertions(+), 3 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




