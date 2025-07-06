Return-Path: <linux-iio+bounces-21381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB0AFA445
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEB43A34DB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61D1E3DF8;
	Sun,  6 Jul 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFpAC89f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCC19CC27;
	Sun,  6 Jul 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796265; cv=none; b=eZjKkDY3M45+9rFNXV8afFBAofKEJmKhoQHH39JdDH7mbXNhcg02im78lGotc+qquMHeiETTY2YaPeUxWG5V8S6zFdHSExSYjRaDC8sTBbVnaD3tkxo65o/pgo4B9LOwbVkeyBfNHI3E0e7ImppeF54L/vJvYVairyYDqNbG3bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796265; c=relaxed/simple;
	bh=sfZPxovac7wExNUkxvV6YrqzR6NA/S1RS721Zk3YH+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oqe4sZu8Jj7+ekqMvs6z3pVgfOuEgT/1pwCGPJJENsWqwoxQ75a6nkcrGXRJmHOaNufv6khdp/srzaFfTElWWjFsY9ICVceg4dVzxoSZPCz1pRrCEUqQUUcSRV72OAK39Q3DuaJY75GMqzTiI6oOC1yikVBnF7hi+4Evjw4VUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFpAC89f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B482C4CEED;
	Sun,  6 Jul 2025 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751796265;
	bh=sfZPxovac7wExNUkxvV6YrqzR6NA/S1RS721Zk3YH+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BFpAC89fLI9LG8L6sxsNAqnH1e2grHdj/j36sOZ8uyzB1LFOzxuvRFj576BROHVHD
	 frWJXMGayWJhFH8fXn1Cl2hrAWdCMO6QWpLWJOAAyGhXbaQBotefB8BCu7LUwv3ewW
	 MHw2W1b3pzxV3ugoeZNyhYQUIUAqOQObdYszXQG4T9yOgupw71rX4Jdd+rbMYoY1LT
	 ykbIbh6mq5o00qZ6TiZggaPbsV/Src65UmMLwrziHQrvfcCVu5bsGfE53nM4QdbY5/
	 goXIUEVr7BjUcpSEHYtwGDb4vNKp6oYav6l0CksRNa+eusbi9J3tORk7pG9JgE0ShZ
	 PTqiLEzSL+xCQ==
Date: Sun, 6 Jul 2025 11:04:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 00/12] iio: adc: ad7173: add SPI offload support
Message-ID: <20250706110417.5182f679@jic23-huawei>
In-Reply-To: <aGToIInJLMHmB4ay@smile.fi.intel.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
	<aGToIInJLMHmB4ay@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Jul 2025 11:04:48 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Jul 01, 2025 at 04:37:48PM -0500, David Lechner wrote:
> > Here comes another series for adding SPI offload support to an ADC.
> > 
> > The primary target is AD411x, but since this uses the ad_sigma_delta
> > shared module, a lot of this series is focused on that.
> > 
> > To start with, we have some cleanups to the ad_sigma_delta code, so feel
> > free to pick these up as they are ready as they generally stand on their
> > own.
> > 
> > Then before adding proper SPI offload support, we make use of
> > spi_optimize_message() to reduce CPU usage of all users of this driver
> > during buffered reads.
> > 
> > Also there is a new dt-binding and driver for a special SPI offload
> > trigger FPGA IP core that is used in this particular setup.
> > 
> > Then finally actual SPI offload support is added to the ad_sigma_delta
> > module and the ad7173 driver.
> > 
> > This was tested using EVAL-AD4112ARDZ on a DE10-Nano.  
> 
> This version LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied 1-7 and 11-12.  Mark picked up 8 and 9 from v2.

Thanks,

Jonathan




