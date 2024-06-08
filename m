Return-Path: <linux-iio+bounces-6076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02021901310
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55FF1F21CE8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD11C290;
	Sat,  8 Jun 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI+p40P/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77001C286;
	Sat,  8 Jun 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717868011; cv=none; b=s7B6HQEDw9nxXkzmaHz/kzemhVEI9pBtRPcITAr9KrvzOH1keVT1I+TQPyPiRyDMNCZdn0c35z9mX6bdYaL8quvicyDBqHAbgXPr4A3TVfhXYq7CbNHCC6QEunKn0UoDJl87ZAtum47rDCrdyx074kTDbw5J1l8nMmQMP7MizEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717868011; c=relaxed/simple;
	bh=Cs9lOa2WavPLN7oqK/3pwGjhjZXspdBdBObW8TWyNJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBAyhxpVr4DMpAcUfmghRtRk8v+xBRgKHuCpUJR0Gccrzfc9po4tIWXG615G7FElE8Lv/sRX+bNXe5JjbeCP3/Tr67ez+DSIk7kAClsODbjzzUWi/q4OkbUEk82uJe7D8fKxhrlChggOplTL+slczT0ob/FkeBBS5eXHqG/FtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI+p40P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84958C2BD11;
	Sat,  8 Jun 2024 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717868011;
	bh=Cs9lOa2WavPLN7oqK/3pwGjhjZXspdBdBObW8TWyNJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dI+p40P/rjOMkAAJBImUJkveglA+w5DQrPk3PBPecI+PYeeYOVuj2cv09+kAuVLfR
	 WVtdWrUF9/M7mqJgtiVi7yWZmGiCLXZt532LhG7Ud/MckSEFdmvHbqGugEzTC7oj5l
	 1umXp8i3qOnwIKFxidhGt2Tal6fi+qO+1JIrn+DtzpkL+7MMocyTmyeBL6dz2kpQgJ
	 Zie6vODafE1HGPF9IKEhbGyfpdDGxtK6eWyQ11TDOEE3rEVVe+3eBYG2W5daWgRMhy
	 viwnAAzeAHTS8lrI4gR86Y8/oRoalYyeXxTNp4QdRLj/ttrVtMDADPiKBeybRJZAwp
	 ZEtwbMKWq5AFw==
Date: Sat, 8 Jun 2024 18:33:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin
 Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: amlogic,meson-saradc: add
 GXLX SoC compatible
Message-ID: <20240608183322.1274e5e4@jic23-huawei>
In-Reply-To: <20240604055431.3313961-1-christianshewitt@gmail.com>
References: <20240604055431.3313961-1-christianshewitt@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 05:54:30 +0000
Christian Hewitt <christianshewitt@gmail.com> wrote:

> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Add support for the GXLX SoC. GXLX is very similar to GXL but has three
> additional bits in MESON_SAR_ADC_REG12 for the three MPLL clocks.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
FWIW series looks fine to me subject to the precursor series getting
posted to linux-iio (and hence ending up in the right patchwork!)

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index 7e8328e9ce13..b2fef72267b4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -23,6 +23,7 @@ properties:
>                - amlogic,meson8m2-saradc
>                - amlogic,meson-gxbb-saradc
>                - amlogic,meson-gxl-saradc
> +              - amlogic,meson-gxlx-saradc
>                - amlogic,meson-gxm-saradc
>                - amlogic,meson-axg-saradc
>                - amlogic,meson-g12a-saradc


