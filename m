Return-Path: <linux-iio+bounces-5937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A28FF562
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEAC1C25410
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1126EB5C;
	Thu,  6 Jun 2024 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CspXD7QM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548C4D13F;
	Thu,  6 Jun 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702858; cv=none; b=Jb0A+ypKSBU0YIYR1A3Q/c9dhuC38I5j8sxFdf4WbvXOTcxUHP9NTUkHTI8p4TX7iMyZeI1V7CD5/xcaOQYC6pZYhNFWRR4vcA1B0QAERQ57Ce54zAKDKfr9Kr/Aq2pUy9i2MWQR/KMHUOWMKJhYlB23vDZ0WWxCu9T31JumCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702858; c=relaxed/simple;
	bh=P0QkZtgUQjhtRPh66yB0oPQQs0jzQOCepM5SRTacekk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZytuL5QruzpVCnc2kH8FXUvZN+7SVtq8mthZq2A6kghc1ouHcXTssQ2F1W6qAb34TRxQz9K4601uoFxIlESs088I9Uzrtes8/0ks/K3/toopBZY211KQYvVxcC3yOIlLJvrF3iiwHW/a4GCGOHqWDQWo6tOLDyLHVLH5ycNBNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CspXD7QM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA373C2BD10;
	Thu,  6 Jun 2024 19:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717702858;
	bh=P0QkZtgUQjhtRPh66yB0oPQQs0jzQOCepM5SRTacekk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CspXD7QM7muSZaL7Q8b+IpA1ZXtUVeIhByTgUYvrCEis25tcxWvcSiWabz/0zmdKL
	 tz40yXgBvVzRt0/bLIb0ia6Pv3BBRBh5LvFbKEwKhsm9eAa1IQ00KHLgkSfPZE4lx0
	 +T1aDHd4bJUl7v5kS0kVd/XxvY7gRNZuNBkOtrvgdl1LI8mrZVICCi6S4fu2qiJ00d
	 a68/P204rh8+MAoTzDFFs/CEmqBQ6gBbfI51xGD3yia8i75FbFi/9FUvRKgiK79tKW
	 OAJwroFeDZtdH4XeccSqXxXUpxvAxr0fQ4xq+U+UfP3f+7+XvN9T4LYxZHDkPCYfN7
	 XO+Gwo5BmBYzQ==
Date: Thu, 6 Jun 2024 20:40:48 +0100
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
 linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
Message-ID: <20240606204048.2e06d995@jic23-huawei>
In-Reply-To: <3d364430-96c7-4f9f-98e7-e68b1e57f69e@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
	<20240530093410.112716-2-angelogioacchino.delregno@collabora.com>
	<20240602104048.14c75d7b@jic23-huawei>
	<3d364430-96c7-4f9f-98e7-e68b1e57f69e@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 11:04:25 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 02/06/24 11:40, Jonathan Cameron ha scritto:
> > On Thu, 30 May 2024 11:34:07 +0200
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> >   
> >> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
> >> providing various ADC channels for both internal temperatures and
> >> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
> >> usually on a 3.5mm jack) other than some basic battery statistics
> >> on boards where the battery is managed by this PMIC.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>  
> > Hi,
> > 
> > What are all the headers for given the binding doc doesn't use anything from
> > them?
> >   
> 
> The binding document doesn't use them, yes, but those are part of the devicetree
> binding itself, as those can be used by devicetrees to reference an ADC channel
> like <&pmic_adc MT6359_AUXADC_ACCDET>.
> 
> I think growing the binding example to add an "external" node using one of those
> channels is irrelevant, as that is "outside" of the description of the AUXADC HW.

Add a note on that to the patch description and that is fine.

J
> 
> Cheers,
> Angelo
> 
> > Jonathan
> >   
> >> ---
> >>   .../iio/adc/mediatek,mt6359-auxadc.yaml       | 43 +++++++++++++++++++
> >>   .../iio/adc/mediatek,mt6357-auxadc.h          | 21 +++++++++
> >>   .../iio/adc/mediatek,mt6358-auxadc.h          | 22 ++++++++++
> >>   .../iio/adc/mediatek,mt6359-auxadc.h          | 22 ++++++++++
> >>   4 files changed, 108 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> >>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
> >>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
> >>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> >> new file mode 100644
> >> index 000000000000..dd6c331905cf
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> >> @@ -0,0 +1,43 @@
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
> >> +
> >> +additionalProperties: false
> >> +
> >> +required:
> >> +  - compatible
> >> +  - "#io-channel-cells"
> >> +
> >> +examples:
> >> +  - |
> >> +    pmic {
> >> +        pmic_adc: adc {
> >> +            compatible = "mediatek,mt6359-auxadc";
> >> +            #io-channel-cells = <1>;
> >> +        };
> >> +    };
> >> +...
> >> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
> >> new file mode 100644
> >> index 000000000000..03ebb1d23953
> >> --- /dev/null
> >> +++ b/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
> >> @@ -0,0 +1,21 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >> +
> >> +#ifndef _DT_BINDINGS_MEDIATEK_MT6357_AUXADC_H
> >> +#define _DT_BINDINGS_MEDIATEK_MT6357_AUXADC_H
> >> +
> >> +/* ADC Channel Index */
> >> +#define MT6357_AUXADC_BATADC		0
> >> +#define MT6357_AUXADC_ISENSE		1
> >> +#define MT6357_AUXADC_VCDT		2
> >> +#define MT6357_AUXADC_BAT_TEMP		3
> >> +#define MT6357_AUXADC_CHIP_TEMP		4
> >> +#define MT6357_AUXADC_ACCDET		5
> >> +#define MT6357_AUXADC_VDCXO		6
> >> +#define MT6357_AUXADC_TSX_TEMP		7
> >> +#define MT6357_AUXADC_HPOFS_CAL		8
> >> +#define MT6357_AUXADC_DCXO_TEMP		9
> >> +#define MT6357_AUXADC_VCORE_TEMP	10
> >> +#define MT6357_AUXADC_VPROC_TEMP	11
> >> +#define MT6357_AUXADC_VBAT		12
> >> +
> >> +#endif
> >> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
> >> new file mode 100644
> >> index 000000000000..efa08398fafd
> >> --- /dev/null
> >> +++ b/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
> >> @@ -0,0 +1,22 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >> +
> >> +#ifndef _DT_BINDINGS_MEDIATEK_MT6358_AUXADC_H
> >> +#define _DT_BINDINGS_MEDIATEK_MT6358_AUXADC_H
> >> +
> >> +/* ADC Channel Index */
> >> +#define MT6358_AUXADC_BATADC		0
> >> +#define MT6358_AUXADC_VCDT		1
> >> +#define MT6358_AUXADC_BAT_TEMP		2
> >> +#define MT6358_AUXADC_CHIP_TEMP		3
> >> +#define MT6358_AUXADC_ACCDET		4
> >> +#define MT6358_AUXADC_VDCXO		5
> >> +#define MT6358_AUXADC_TSX_TEMP		6
> >> +#define MT6358_AUXADC_HPOFS_CAL		7
> >> +#define MT6358_AUXADC_DCXO_TEMP		8
> >> +#define MT6358_AUXADC_VBIF		9
> >> +#define MT6358_AUXADC_VCORE_TEMP	10
> >> +#define MT6358_AUXADC_VPROC_TEMP	11
> >> +#define MT6358_AUXADC_VGPU_TEMP		12
> >> +#define MT6358_AUXADC_VBAT		13
> >> +
> >> +#endif
> >> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
> >> new file mode 100644
> >> index 000000000000..59826393ee7e
> >> --- /dev/null
> >> +++ b/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
> >> @@ -0,0 +1,22 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> >> +
> >> +#ifndef _DT_BINDINGS_MEDIATEK_MT6359_AUXADC_H
> >> +#define _DT_BINDINGS_MEDIATEK_MT6359_AUXADC_H
> >> +
> >> +/* ADC Channel Index */
> >> +#define MT6359_AUXADC_BATADC		0
> >> +#define MT6359_AUXADC_BAT_TEMP		1
> >> +#define MT6359_AUXADC_CHIP_TEMP		2
> >> +#define MT6359_AUXADC_ACCDET		3
> >> +#define MT6359_AUXADC_VDCXO		4
> >> +#define MT6359_AUXADC_TSX_TEMP		5
> >> +#define MT6359_AUXADC_HPOFS_CAL		6
> >> +#define MT6359_AUXADC_DCXO_TEMP		7
> >> +#define MT6359_AUXADC_VBIF		8
> >> +#define MT6359_AUXADC_VCORE_TEMP	9
> >> +#define MT6359_AUXADC_VPROC_TEMP	10
> >> +#define MT6359_AUXADC_VGPU_TEMP		11
> >> +#define MT6359_AUXADC_VBAT		12
> >> +#define MT6359_AUXADC_IBAT		13
> >> +
> >> +#endif  
> >   
> 


