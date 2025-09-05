Return-Path: <linux-iio+bounces-23770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7CB4565E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76BD5A3044
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018302D23BC;
	Fri,  5 Sep 2025 11:30:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C72343D93;
	Fri,  5 Sep 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757071813; cv=none; b=b71B1dsMkpGqAIqRDZUvtkuVAtkrkaArTRZ2FdEbBsK33n4vCl3NG5Rbqn4B/KkAzeIijYhAm+TE3gpEkShVKP0jR4e9gmr8QHXA5n9AAA0jh1lmP97UiurxWdttmbkgNOF1mJOWtwbWetoW8g8sa/qu92bnCuvazPsfjRF6img=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757071813; c=relaxed/simple;
	bh=zZUdFcHQdplrd87XGHnTotjQT+LmlMsdcMKJPBMo+7M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfc5E4EqYPnNBqztvjyLGUh/XlupgwwmRkRWGTNg1uJStKlKyhrvxyDSwmZjiK5KGv0Zwi7rM7Dvo60YPQwnDT5dQEFx63WCaYz5bHjzA4s11cQG0yPSGgOXg1FtgA6hKkcymdQ+kJ42YYhV8E+Y3Otuw3paZG9TThGY2waLp68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJDbY21trz6M4wc;
	Fri,  5 Sep 2025 19:27:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DDFF1402F1;
	Fri,  5 Sep 2025 19:30:08 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 13:30:07 +0200
Date: Fri, 5 Sep 2025 12:30:06 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Michal Simek <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>, Salih Erim <salih.erim@amd.com>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Anish Kadamathikuttiyil
 Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
Message-ID: <20250905123006.000031a9@huawei.com>
In-Reply-To: <610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
	<610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 5 Sep 2025 10:41:44 +0200
Michal Simek <michal.simek@amd.com> wrote:

> From: Salih Erim <salih.erim@amd.com>
> 
> Add devicetree documentation for Xilinx Sysmon IP which is used for
> internal chip monitoring on Xilinx Versal SOCs.
> 
> Co-developed-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Co-developed-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
> Signed-off-by: Anish Kadamathikuttiyil Karthikeyan Pillai <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../bindings/iio/adc/xlnx,versal-sysmon.yaml  | 235 ++++++++++++++++++
>  1 file changed, 235 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
> new file mode 100644
> index 000000000000..a768395cade7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
> @@ -0,0 +1,235 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/xlnx,versal-sysmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal Sysmon
> +
> +maintainers:
> +  - Salih Erim <salih.erim@amd.com>
> +
> +description:
> +  The Xilinx Sysmon provides on-chip monitoring and control for the supply
> +  voltages and temperatures across the chip. Since there are only 160 supply
> +  voltage registers and 184 measurement points, there is no constant mapping
> +  of supply voltage registers and the measurement points. User has to select
> +  the voltages to monitor in design tool. Depending on the selection, a voltage
> +  supply gets mapped to one of the supply registers. So, this mapping information
> +  is provided via description which contain the information of name of
> +   the supply enabled and the supply register it maps to.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: xlnx,versal-sysmon
> +
> +  reg:
> +    maxItems: 1
> +    description: Sysmon Registers.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: Interrupt line for Sysmon.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  '#io-channel-cells':
> +    const: 0
> +
> +  xlnx,hbm:
> +    type: boolean
> +    description:
> +      Exists if node refers to a HBM (High Bandwidth Memory) SLR (Super Logic Region).
> +
> +  xlnx,nodeid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      PLM specified sysmon node id.
> +
> +  xlnx,numaiechannels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 64
> +    description:
> +      Total number of sysmon satellites close to AI Engine exposed as channels.

Feels like some use - would make this easier to parse.  xlnx,num-aie-channels.
Similar to the next one. How is this related to the number of child nodes?


> +
> +  xlnx,numchannels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 160
> +    description:
> +      Number of supply channels enabled in the design.

Given you have subnodes called supplyxxx why is a count
of those needed or is this not counting those?

> +
> +patternProperties:
> +  "^supply@([0-9]{1,2}|1[0-5][0-9])$":
> +    type: object
> +    description:
> +      Represents the supplies configured in the design.
> +
> +    properties:
> +      reg:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 159
> +        description:
> +          The supply number associated with the voltage.
> +
> +      xlnx,name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          Name of the supply enabled

Would the generic property "label" be useable here?

> +
> +      xlnx,bipolar:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          If the supply has a bipolar type and the output will be signed.

This is very generic.  We have it described for ADC channels already in
bindings/iio/adc/adc.yaml.  Why can't we use that here?
That binding does rely on matching against 'channel' for node names though.
Where a 'type of channel' has been relevant IIRC we've always added
a separate property rather than using the child node name.

> +
> +    required:
> +      - reg
> +      - xlnx,name
> +
> +    additionalProperties: false
> +
> +  "^temp@([1-9]|[1-5][0-9]|6[0-4])$":
> +    type: object
> +    description:
> +      Represents the sysmon temperature satellites.
> +
> +    properties:
> +      reg:
> +        minimum: 1
> +        maximum: 64
> +        description:
> +          The sysmon temperature satellite number.
> +
> +      xlnx,aie-temp:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          If present it indicates the temperature satellite is in
> +          close proximity with AI Engine

This one seems unusual.  I guess it makes a configuration difference
of some type.  I'll look at the code to see if that answers the question.

> +
> +      xlnx,name:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          Name of temperature satellite exposed

As above. label tends to get used for things like this.

> +
> +    required:
> +      - reg
> +      - xlnx,name
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - xlnx,numchannels
> +
> +additionalProperties: false


