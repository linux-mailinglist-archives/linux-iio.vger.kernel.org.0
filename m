Return-Path: <linux-iio+bounces-349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E577F8C44
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B124D28140B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201729420;
	Sat, 25 Nov 2023 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK82r4cp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF0B65C;
	Sat, 25 Nov 2023 16:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42535C433C7;
	Sat, 25 Nov 2023 16:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700928493;
	bh=+JdvZzFz1fUXLr7nCkndqXtxJjfFTBUCZxGIR3myW/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XK82r4cpxnh9hdFs2xGKa0X1tALGw0LxQ1t2THSEhxqG76NMMrS5TELZ2Y7cjfUz1
	 9x0nQUCp9Gbx4GA2D7xj5X5s2tLvIM9oelKKTxWMFlDOMW+CeVcEhPYFcwkn94DRAE
	 1ebETkgDslvfycoGPAlUPjmlH8+XVd90RSJYwBW4mRiomWagnPqgOpMWexMGeWsuh/
	 jQ4SU/Oqbq6i8U5NmgP9ohB2ENdhhxjH6sUnlmJT3snaU8DY1kjbfjxgrDQdmaF2gI
	 FMRXp9V1EXuAHYb6g+EAB8u0TsMRk6R/rA9JrP3l3ZOvcTmnyF9fuQkpEUVUpgv899
	 ZFZ4wf0DLKpIw==
Date: Sat, 25 Nov 2023 16:08:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
 <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] Add support for AD7091R-2/-4/-8
Message-ID: <20231125160804.63c30be9@jic23-huawei>
In-Reply-To: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 13:29:12 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> This series adds support for AD7091R-2/-4/-8 ADCs which can do single shot
> or sequenced readings. Threshold events are also supported.
> Overall, AD7091R-2/-4/-8 are very similar to AD7091R-5 except they use SPI interface.
> 
> This has been tested with raspberrypi and eval board on kernel 6.1 from ADI fork.
> Link: https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7091r8
> 
> I ran get_maintainers on driver files but completely forgot to run it on the
> yaml doc, my bad.
> I made the changes requested so far.
> For v2, I also ran dt_binding_check on iio testing branch to check out for any
> additional dt-schema issues. None reported.
> Didn't see any other warn after running Sparse, Smatch, and Coccicheck.
> I get a warn from checkpatch about IIO_DMA_MINALIGN which I don't know how to fix :(

Fix checkpatch :)
It has some exclusions for some of the warnings so probably look at what was added
to avoid issues with __cacheline_aligned and friends.
https://elixir.bootlin.com/linux/latest/source/scripts/checkpatch.pl#L515


> 
> Change log v1 -> v2:
> - Added device tree related To/Cc recipients.
> - Removed extra print of error code
> - $ref: "adc.yaml" -> $ref: adc.yaml
> - Fixed defined but not used build warn
> - Moved dt documentation of required properties to after patternProperties.
> - Removed incorrect return before regmap_update_bits().
> 
> Marcelo Schmitt (7):
>   iio: adc: ad7091r-base: Set alert config and drvdata
>   MAINTAINERS: Add MAINTAINERS entry for AD7091R
>   iio: adc: ad7091r: Move defines to header file
>   iio: adc: ad7091r: Alloc IIO device before generic probe
>   dt-bindings: iio: Add binding documentation for AD7091R-8
>   iio: adc: Add support for AD7091R-8
>   iio: adc: ad7091r-base: Add debugfs reg access
> 
>  .../bindings/iio/adc/adi,ad7091r8.yaml        | 101 +++++++
>  MAINTAINERS                                   |  12 +
>  drivers/iio/adc/Kconfig                       |  16 ++
>  drivers/iio/adc/Makefile                      |   4 +-
>  drivers/iio/adc/ad7091r-base.c                | 114 +++++---
>  drivers/iio/adc/ad7091r-base.h                |  64 ++++-
>  drivers/iio/adc/ad7091r5.c                    |  55 ++--
>  drivers/iio/adc/ad7091r8.c                    | 270 ++++++++++++++++++
>  8 files changed, 549 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
>  create mode 100644 drivers/iio/adc/ad7091r8.c
> 


