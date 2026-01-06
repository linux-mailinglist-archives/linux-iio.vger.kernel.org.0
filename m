Return-Path: <linux-iio+bounces-27502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA77DCF961E
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE6730136C1
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2E128640B;
	Tue,  6 Jan 2026 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAh73Qwj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C223C503;
	Tue,  6 Jan 2026 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717401; cv=none; b=ahHeBiLVE/2ZtkGrzlghzjIK4Od0UFpkog7wifi+gOuOH/cxvb5TqTjLeH8aIBY6Gbd4AGfz3bSvHgCYnnBwhr9DyCpD7DZJug9iHRW6hhFKkDeMFLLQTsOuzQU1RA7oaeCZKzIjNwUNNB7uXreOPZGnJz4BvqShhcSV8sD2zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717401; c=relaxed/simple;
	bh=TBTjPQd1m6fV59MMvkLlwy6k7Ok+ct13DlXVo9ZfGkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOYTJyCo6nCImpXGpXNvMUx6hg4lV1LlzVlVbTcB9HhVYOk3E8s4s7Qf0O6yekuuGI9zDyuNPeKPzKrraX4THMmPFoQ6uhhHeOcvL6OLOGf6GocLfgHckDS/wNPyUvV0qeSXjWxresluIUSotLWPAGlPLV6BuuWhnqfIn13utO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAh73Qwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D6C116C6;
	Tue,  6 Jan 2026 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717401;
	bh=TBTjPQd1m6fV59MMvkLlwy6k7Ok+ct13DlXVo9ZfGkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAh73QwjUfbmQjOtmE65wGKBO0YJsDX4XfgbE59p5t5TrA6pok0nHmDRrJ5jrizlG
	 pLFv76eDhYzrTk7XZQfroE3ZUauX5t0nB0zb+Zvy4X6A5f+K4JQBjfBm1Gi/4F48dg
	 +64/XyKiYsDyGd7WkUMkKU2/v0DI8aD2ECp+sZ3c/2fvFuBHi8EJEgQIa8RTZmjkiN
	 QJkEVTsUufGzb4ON+SQsF05elZ4mgV7S/5WirhQN2suKi1yw024TymiUK/OSS4hi8T
	 9Wb+VIOQ5wnae4qmbYXrAcPKEglZIHNoWCSHBBYAuBJfHsIuiM2FzA5M3W7v3+F+ea
	 StrfMYaztK5PQ==
Date: Tue, 6 Jan 2026 10:36:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-spi@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: Re: [PATCH v4 6/9] spi: dt-bindings: adi,axi-spi-engine: add
 multi-lane support
Message-ID: <176771739996.2222090.14758454921102802504.robh@kernel.org>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-6-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-6-145dc5204cd8@baylibre.com>


On Fri, 19 Dec 2025 15:32:14 -0600, David Lechner wrote:
> Extend the ADI AXI SPI engine binding for multiple data lanes. This SPI
> controller has a capability to read multiple data words at the same
> time (e.g. for use with simultaneous sampling ADCs). The current FPGA
> implementation can support up to 8 data lanes at a time (depending on a
> compile-time configuration option).
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v4 changes:
> - Update to use spi-{tx,rx}-bus-width properties.
> ---
>  .../devicetree/bindings/spi/adi,axi-spi-engine.yaml       | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


