Return-Path: <linux-iio+bounces-23844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08066B47A87
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6C93C28C6
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 10:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAC259CA4;
	Sun,  7 Sep 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYMwViw3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B21C3BFC;
	Sun,  7 Sep 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757242279; cv=none; b=D8w3BcSrd1fb5ws0/S8rm957AYmtu8dILZI8KtXr89MUI8uS69kBBukkRlm6NrAoZqtiweQ+IpeoOG3n9dCNLTvwOuieE4gckCe968ZF1vFjuU7JYTiLRP2a6mTPdjgh3HndsOnXDJHELBr69+XAffKQD2BoC1Li0sXLNMzPEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757242279; c=relaxed/simple;
	bh=o9+gEMBASfwEqE0eaUXisDtl/cNttKx6f66yZkkhXZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCg4TsZBQ4og2bvWhRoa1f4BZcQEQIq/CNzw7spJcugb5moXJmcS6N7X00OIOfSZmuVKsiR83E3bgUQ5ouvRXk1I2sFOGZgd3EZbVP8CCl+XawZ4rTI//hlsIgfGcQtsyRuBtcW8b3yIXLn7BYvYOR+GJ2yjJt+9qxa/5Tw/g98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYMwViw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574E6C4CEF8;
	Sun,  7 Sep 2025 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757242278;
	bh=o9+gEMBASfwEqE0eaUXisDtl/cNttKx6f66yZkkhXZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hYMwViw3t7//kFBTeGs/6vhLS0LE8CIkvXotb6fXTMCYlQkVNZdcAGU/YXbXoMCe+
	 /WjtxAyg/ExTuqEY498RgUyq4PfxGA4NYFg8lUfdz/CGoc0WIsBAaRyRt7BRnwEwU5
	 8/ljCWWIrB961LIe3mz/HxD4RyDgI/BI77qis34m6wORmHYfk2vI9Ewukf4UXVlLpy
	 yJ9jB9DboegEisrnv80jmlf/GPN1t1B8DBJOmtHy7DJImaLh3Q/AGBc7AdJjPhR8n9
	 iyLCkYuee3xhcSMFvhV+KpegYf33ZlX2e5Pwr+UN1YaOWXjSfFwQK1w2jmnLG9jbl8
	 eng4w1WzQZMoQ==
Date: Sun, 7 Sep 2025 11:51:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: "Erim, Salih" <Salih.Erim@amd.com>, "Simek, Michal"
 <michal.simek@amd.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>, "michal.simek@xilinx.com"
 <michal.simek@xilinx.com>, "git@xilinx.com" <git@xilinx.com>, Anand Ashok
 Dumbre <anand.ashok.dumbre@xilinx.com>, "Kadamathikuttiyil Karthikeyan
 Pillai, Anish" <anish.kadamathikuttiyil-karthikeyan-pillai@amd.com>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: iio: xilinx: Add Documentation for
 Sysmon
Message-ID: <20250907115107.03aeb8d0@jic23-huawei>
In-Reply-To: <fec12cd9-4709-42ca-b0e5-38f67b63a41c@baylibre.com>
References: <cover.1757061697.git.michal.simek@amd.com>
	<610690b9cc4ab3854b56df550b688b4cc72a5653.1757061697.git.michal.simek@amd.com>
	<20250905123006.000031a9@huawei.com>
	<5f21169b-39b8-4fcd-b7d7-e5bcb1885549@amd.com>
	<IA1PR12MB7736D056E505103AC246DC2E9F03A@IA1PR12MB7736.namprd12.prod.outlook.com>
	<fec12cd9-4709-42ca-b0e5-38f67b63a41c@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 15:44:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/5/25 9:21 AM, Erim, Salih wrote:
> 
> ...
> 
> >>>  
> >>>> +
> >>>> +      xlnx,bipolar:
> >>>> +        $ref: /schemas/types.yaml#/definitions/flag
> >>>> +        description:
> >>>> +          If the supply has a bipolar type and the output will be signed.  
> >>>
> >>> This is very generic.  We have it described for ADC channels already
> >>> in bindings/iio/adc/adc.yaml.  Why can't we use that here?  
> >>
> >> no issue with it.
> >> And likely
> >> Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
> >> should deprecated it and start to use new one.
> >>
> >>
> >>  
> >>> That binding does rely on matching against 'channel' for node names though.
> >>> Where a 'type of channel' has been relevant IIRC we've always added a
> >>> separate property rather than using the child node name.  
> >>
> >> Is this related to supply/temp channel name?
> >>
> >> I think one issue with the binding is that current schema allows to define
> >> supply@1  and also temp@1
> >> but both of them have reg = <1> which is not allowed (duplicate unit-address).
> >>
> >> Salih: What does this reg value means? Is it physical address where that sensor is
> >> placed?  
> > 
> > Reg is offset index to offset base of the memory addresses for each. Supplies and temp values
> > are located in different offsets.
> >   
> 
> Sounds like the .dts should looks like:
> 
> 	adc@f1270000 {
> 		compatible = "xlnx,versal-sysmon";
> 		reg = <0xf1270000 0x4000>;
> 		...
> 
> 		supply-channels {
> 			#size-cells = <0>;
> 			#address-cells = <1>;
> 
> 			channel@0 {
> 				reg = <0>;
> 				label = "vccint";
> 			};
> 
> 			...
> 		};
> 
> 		temperature-channels {
> 			#size-cells = <0>;
> 			#address-cells = <1>;
> 
> 			channel@0 {
> 				reg = <0>;
> 				label = "aie-temp-ch0";
> 			};
> 
> 			...
> 		};
> 	};

This works for me. Alternative would be something similar to what we did for
dt-bindings: iio: adc: Add AD4170-4 
Where there is an adi,sensor-type property in channels.
There they two types of channels were the same underlying hardware, it just provided
a way to constrain the other properties in the channel nodes.  That differs
from here where, as I understand it (Salih?) they are different hardware blocks
so 'reg' is an offset into a different set of registers. 

DT maintainers, I think this discussion would benefit from your guidance!

Thanks,

Jonathan




