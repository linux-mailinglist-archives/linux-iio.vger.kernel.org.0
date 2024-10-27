Return-Path: <linux-iio+bounces-11416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F99B2119
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 23:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029011F2126B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 22:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F26188920;
	Sun, 27 Oct 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufUNLkDl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B617C61;
	Sun, 27 Oct 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730068860; cv=none; b=XsFcX4D3o5FJoxQsFPk8aOiV9nAiQN3AFSPOIIxfcjj7oBob1kgSQTjInvi6xvFzqAHZ6MgMnButfKyPZXgie4Fd2IbQmIHJ0jhH+OzA+UKNn/P/TsNrLNuzDLyn+caCR4kD3X8DTpGI7LsSgzVi69vu3P3pXxchIPrqBXP4uW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730068860; c=relaxed/simple;
	bh=+ojyfvyubxU3yXhMv/wXkSGsv++TvVB+TUKSzyUwArk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8v39kkCH2M6zoZ7W5yV2OTWoOIY5symiGjKJ3FyQKKn/EeplFyW3qBIovnLq7HGSpN5UXpeDmyJuNfVrzsKn6OQ4VDtoRw4Jsi5sLLI0YNmYQ8hNj50hlaD1+vtrGMQWm2MUdgtH8CXWCA6TEtspAKL0olu1Qdc8bf3Gjzl3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufUNLkDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368E2C4CEC3;
	Sun, 27 Oct 2024 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730068859;
	bh=+ojyfvyubxU3yXhMv/wXkSGsv++TvVB+TUKSzyUwArk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ufUNLkDlgoXa5Zhu/4p5Fymip2AIpBHA2PKltgKAwPqg7K3FHcUTKqRk6ECdSHxiZ
	 nMjRQ+oB92eH5S5rJHMNpucfdS9PdJ282bIe4kU1vGkd7EELCOqjtskiSPvo6YdcQ2
	 r6ABoU/+rsY9eS6H4pKS9KOqCRBePbvX8Ka7VuTV4TINpL7G9DibydIjRJ+Z9ZpbFk
	 x88Q+QrcMyN4f2WqKUbYfd+9m70VGS1XHYRURj8HzNuk5aaUW0+LHQ4ZmACfJCu4tr
	 jhyCTLxmhKIP/zUgGACsL7XkhzqwQbchHUImGXSitSgjqL5MMW22IucTL39Q1+YvTC
	 8f+WJveAB6SGw==
Date: Sun, 27 Oct 2024 17:40:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	dlechner@baylibre.com, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v8 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <173006885725.180935.8471883394882688009.robh@kernel.org>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
 <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-2-74ca7dd60567@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-2-74ca7dd60567@baylibre.com>


On Fri, 25 Oct 2024 11:49:35 +0200, Angelo Dureghello wrote:
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


