Return-Path: <linux-iio+bounces-8180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F173B9468F6
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A954C1F21A2B
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F614E2CB;
	Sat,  3 Aug 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9KK2mjM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C967A0D;
	Sat,  3 Aug 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722678972; cv=none; b=Z/qSGaPtD2JbntqtuwF0wbyvtvoQxZmhUszA48jLaI0M7CP8cNa974/uSbylWrSy/EeGfyDQO9RCw0EIbyJH56FvSCJ7ftopTl7BmaZtvLyNmwnOz79FfqPQhynGqpR3aZ6Tzhfd5mJs6Vp4Boo53yiKRkA9iqVWEDyKwJ6u2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722678972; c=relaxed/simple;
	bh=47/3SOn8zR55hwRJ8t7MP9wfeMJUry2d4J4v7KYbJP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXcjt9NQ0FckvTFS2SdZPfrFAdpCiXePhvJ6vMp8Yh8tTv2mJIMhqyurPU92QglTfcRzmEaUouF4bUWEGRacuHOwrU/0gHzavfv4sGxzpuUusflW+OJCz+zYdzcLWd4QDRpEbh2Bj1/NEGcLw7woLOyyt6/fA8fapBbfYgeKseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9KK2mjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B824AC116B1;
	Sat,  3 Aug 2024 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722678971;
	bh=47/3SOn8zR55hwRJ8t7MP9wfeMJUry2d4J4v7KYbJP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y9KK2mjMODSjQ3Mckjik0/1bOK185hC79Cme1Ufws/i9e9f1sxZfIpNrvRIqIi4rZ
	 eTHEoWu9PfB62RSA92YPNZ1FF2ZnQj9Ep2EbWnpi2IzuKc1aqE7gXHg1AvOAIY2ymo
	 PEWUD5ZER27Umuz81QvRPfyFrnJR6CYoohAFalgAeFrC0cNboue9sAX2GQR6+k5hzl
	 SbjEBBEir1IGVtH9Ng1lSNnRqOK0uBz/GjdFLj4NlbFH5ai0KHqD21EtjcxD/jl7ri
	 yX5h+wWbnheXJjbsb2B9RF84LPPohu7DWwQPw7Z3oaVguBz4zBBZc8q2YeW2YZZ51X
	 9u9sZypLIa1eQ==
Date: Sat, 3 Aug 2024 10:56:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, corbet@lwn.net, marcelo.schmitt1@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Add support for AD4000 series of ADCs
Message-ID: <20240803105603.14459d43@jic23-huawei>
In-Reply-To: <a76c50b6-b1a4-4e99-b353-51ee3454ef0e@sirena.org.uk>
References: <cover.1720810545.git.marcelo.schmitt@analog.com>
	<a76c50b6-b1a4-4e99-b353-51ee3454ef0e@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 01:04:54 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jul 12, 2024 at 04:20:00PM -0300, Marcelo Schmitt wrote:
> > This patch series extends the SPI bitbang, gpio, and spi-engine controllers to
> > support configurable MOSI line idle states.  
> 
> The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:
> 
>   Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-mosi-config
Thanks.

Merged that tag into IIO and applied patches 6 and 7.

Jonathan

> 
> for you to fetch changes up to 96472f18a4affdaff5013a836c48375f1eddb4a4:
> 
>   dt-bindings: iio: adc: Add AD4000 (2024-07-29 01:19:55 +0100)
> 
> ----------------------------------------------------------------
> spi: Support MOSI idle configuration
> 
> Add support for configuring the idle state of the MOSI signal in
> controllers.
> 
> ----------------------------------------------------------------
> Marcelo Schmitt (5):
>       spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
>       spi: bitbang: Implement support for MOSI idle state configuration
>       spi: spi-gpio: Add support for MOSI idle state configuration
>       spi: spi-axi-spi-engine: Add support for MOSI idle configuration
>       dt-bindings: iio: adc: Add AD4000
> 
>  .../devicetree/bindings/iio/adc/adi,ad4000.yaml    | 197 +++++++++++++++++++++
>  Documentation/spi/spi-summary.rst                  |  83 +++++++++
>  MAINTAINERS                                        |   7 +
>  drivers/spi/spi-axi-spi-engine.c                   |  15 +-
>  drivers/spi/spi-bitbang.c                          |  24 +++
>  drivers/spi/spi-gpio.c                             |  12 +-
>  drivers/spi/spi.c                                  |   6 +
>  include/linux/spi/spi_bitbang.h                    |   1 +
>  include/uapi/linux/spi/spi.h                       |   5 +-
>  9 files changed, 344 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml


