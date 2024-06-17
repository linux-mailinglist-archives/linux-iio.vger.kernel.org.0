Return-Path: <linux-iio+bounces-6414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294090BB22
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAE72841A7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E517F397;
	Mon, 17 Jun 2024 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+IuhJ1u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D91BDEF;
	Mon, 17 Jun 2024 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652806; cv=none; b=mpxJ3NJizMoMSZNRcuJlnqySGwP6LDKO1bsj/+habRAZsAAcOSumbW3pYO1Rn8Rcj7UqE90iAxe3E68OlVTM4VqxrYCsNaAc/orsYUm93b4CkQaIvmjuXRJr5/8sU1iE74Yg+qb661UHr09SKakG841Rd3ZsHQwKCRqcOEz4vSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652806; c=relaxed/simple;
	bh=3XAO2VM0TXU6x8XweVvJD4YnI+f4rCAeGuLNKtf5XE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJ00o7RSxDkH7vYoymSgRP1aN1/KhFkvFx11619NvOyAfxC+nO+iMkfwz7aNfTbmjR+XNZ8ct+MPaSl8TOYcroH4g/oRwCV4cHZG5x/G3+GMZzSN4hKsYc88ql+MzzHq1ArB03ALO7q3z9Pv1Lxp/GBZ5ah4k4Txvv2h+cQR0DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+IuhJ1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB2C2BD10;
	Mon, 17 Jun 2024 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718652805;
	bh=3XAO2VM0TXU6x8XweVvJD4YnI+f4rCAeGuLNKtf5XE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r+IuhJ1uBSHjfadYASAvVJHfyMRxZTTpm+snaD2bLSHMAi6vmpcthDw/cDHndzhVU
	 THVJsbfhoghlvFkOcqesR+EsZRZwd55HNJU4A+HR9P1cfAxkrocwVBxJqdPK5ugo+E
	 i89KSDV57oDvnv6z+rvIhHPNSC+uCs92sKaAW2wFAnnyLsKTM0UciMIasQkrhKLnrW
	 rsixpHiljYTjYOqJTHf3NGITJQF7maTBqiH0pRaYOTRJ7g7PgDceuAY1feWocVVHpY
	 VZKRiGsfV9Ai40Zy3F1UbX7zLjsNkcdPcek4+hSp+m2dBP1UPN71qtjV/8I+Tvo7g6
	 y1z1f8pgITJ3Q==
Date: Mon, 17 Jun 2024 20:33:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, lars@metafoo.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, andy.shevchenko@gmail.com,
 kernel@collabora.com
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
Message-ID: <20240617203314.641e84a9@jic23-huawei>
In-Reply-To: <e71a38a9-7a92-4156-a7f0-52f71d461d61@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
	<20240604123008.327424-2-angelogioacchino.delregno@collabora.com>
	<20240605235239.GA3455504-robh@kernel.org>
	<e71a38a9-7a92-4156-a7f0-52f71d461d61@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 10:00:55 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 06/06/24 01:52, Rob Herring ha scritto:
> > On Tue, Jun 04, 2024 at 02:30:04PM +0200, AngeloGioacchino Del Regno wrote:  
> >> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
> >> providing various ADC channels for both internal temperatures and
> >> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
> >> usually on a 3.5mm jack) other than some basic battery statistics
> >> on boards where the battery is managed by this PMIC.
> >>
> >> Also add the necessary dt-binding headers for devicetree consumers.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   .../iio/adc/mediatek,mt6359-auxadc.yaml       | 33 +++++++++++++++++++
> >>   .../iio/adc/mediatek,mt6357-auxadc.h          | 21 ++++++++++++
> >>   .../iio/adc/mediatek,mt6358-auxadc.h          | 22 +++++++++++++
> >>   .../iio/adc/mediatek,mt6359-auxadc.h          | 22 +++++++++++++
> >>   4 files changed, 98 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> >>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
> >>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
> >>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> >> new file mode 100644
> >> index 000000000000..6497c416094d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> >> @@ -0,0 +1,33 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: MediaTek MT6350 series PMIC AUXADC
> >> +
> >> +maintainers:
> >> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> +
> >> +description:
> >> +  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
> >> +  in some MediaTek PMICs, performing various PMIC related measurements
> >> +  such as battery and PMIC internal voltage regulators temperatures,
> >> +  accessory detection resistance (usually, for a 3.5mm audio jack)
> >> +  other than voltages for various PMIC internal components.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - mediatek,mt6357-auxadc
> >> +      - mediatek,mt6358-auxadc
> >> +      - mediatek,mt6359-auxadc
> >> +
> >> +  "#io-channel-cells":
> >> +    const: 1  
> > 
> > Why do you need a node here? Just add #io-channel-cells to the parent
> > node.
> >   
> 
> Because some boards will want to avoid probing the related driver, as that will
> trigger a reset and this may not play well with ECs (namely, some Chromebooks),
> which are reading the same AUXADC block.
> 
> If I avoid using a new node, instead of just using `status`, I'll have to add a
> "mediatek,disable-auxadc" property to the parent node, which isn't pretty...

Rob, does this answer the question to your satisfaction?

If you are fine with this I'd like to queue it up (with the typo in one of the
patch descriptions that Andy caught fixed up).

Thanks,

Jonathan

> 
> Cheers,
> Angelo
> 
> >> +
> >> +required:
> >> +  - compatible
> >> +  - "#io-channel-cells"
> >> +
> >> +additionalProperties: false  
> 
> 


