Return-Path: <linux-iio+bounces-7107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C936891E7E8
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 20:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2031F22BCC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036216F830;
	Mon,  1 Jul 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX88dpFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACB16F298;
	Mon,  1 Jul 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859262; cv=none; b=RWlff9E2soYQRynLeOtYNACJJbVCCbWw9FbSH2c8/3TWlNlJmoLrQSQlmDQEd0vR4/70cqWppzRsHevpVtEZBS3Xw8hfMROPt3ouHdYphxlVHG8RknkYhA4rYMl17arbm7YO3fXIQv2gSTJ+vuLq+uWcYK6J4+c+elM5EgyTR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859262; c=relaxed/simple;
	bh=b9t315kB2irXXTEOqh+BPq5CDd3WoseJBjsx1O8vZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6YldDyzk3mEsHqlpF3HAlYHIw9Mcr4xtWezkz+wKs3Mq975tI1QGor76iiKqFJ16crDywq6EWMVlVDyIHFQa+dZHo7KA9KtCBQJII1exmHiz42w3ohnQ/Cj5iKcLroQhJvZdC/iVrlAdA+BX3k0kmmwi13yg3R7/TI32fVU1Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX88dpFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD09FC116B1;
	Mon,  1 Jul 2024 18:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719859262;
	bh=b9t315kB2irXXTEOqh+BPq5CDd3WoseJBjsx1O8vZSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fX88dpFKO878qmBPMIG3r5lwS2ifsBgzlaZduktbIrYVmU/6VJf1obFf44anDXWnj
	 bq0pX6Znv9d8lZ+NGsuUm5BcO84WNxJJcJ9bCoIn1Ff8k3OwVsKVH9l9rh0jZlaXSo
	 vQurBqp789lZAI3w2Prz3qDD+ugCN4NNqdadOYg56BrSmXNUM8obZxOPuCnFH8pFpq
	 WMzSrEvPR0mE+sikN668ATSUPsi1XKeRDgp098UAHSba52z7o0CxoDcwq8JtnG65pV
	 sXIR9fHY/CRLXtW5Q46XxpjDFu5SLP2RMYjdgCFRC0GnlSra41TnX3p67DVB9ycr+u
	 MwZYgw0UmUCOA==
Date: Mon, 1 Jul 2024 19:40:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, andy.shevchenko@gmail.com,
 kernel@collabora.com
Subject: Re: [PATCH v2 0/5] MediaTek MT6357/8/9 PMIC Auxiliary ADC support
Message-ID: <20240701194052.2702a3da@jic23-huawei>
In-Reply-To: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 14:30:03 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Changes in v2:
>  - Dropped 'mfd: mt6397-core: Add support for AUXADCs on MT6357/58/59 PMICs'
>    as Lee J already applied it;
>  - Added patch to describe the ADC subnode in the MT6357 MFD binding
>    and moved the example node from mediatek,mt6359-auxadc.yaml to
>    mediatek,mt6357.yaml
>  - Added 8-bits {s8,u8}_fract to math.h
>  - Addressed reviewer comments on mt6359-auxadc driver

Applied 1,3,4 to the IIO tree. I'm assuming the mfd dt binding update
will got via mfd and the dts via appropriate SoC tree.

Given time is tight I'll gamble a bit and push directly out as togreg
rather than normal exposure to 0-day first.

Thanks,

Jonathan

> 
> AngeloGioacchino Del Regno (5):
>   dt-bindings: iio: adc: Add MediaTek MT6359 PMIC AUXADC
>   dt-bindings: mfd: mediatek,mt6357: Describe Auxiliary ADC subdev
>   math.h: Add unsigned 8 bits fractional numbers type
>   iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC
>   arm64: dts: mediatek: Add ADC node on MT6357, MT6358, MT6359 PMICs
> 
>  .../iio/adc/mediatek,mt6359-auxadc.yaml       |  33 +
>  .../bindings/mfd/mediatek,mt6357.yaml         |  10 +
>  arch/arm64/boot/dts/mediatek/mt6357.dtsi      |   5 +
>  arch/arm64/boot/dts/mediatek/mt6358.dtsi      |   5 +
>  arch/arm64/boot/dts/mediatek/mt6359.dtsi      |   5 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/mt6359-auxadc.c               | 606 ++++++++++++++++++
>  .../iio/adc/mediatek,mt6357-auxadc.h          |  21 +
>  .../iio/adc/mediatek,mt6358-auxadc.h          |  22 +
>  .../iio/adc/mediatek,mt6359-auxadc.h          |  22 +
>  include/linux/math.h                          |   2 +
>  12 files changed, 744 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>  create mode 100644 drivers/iio/adc/mt6359-auxadc.c
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
> 


