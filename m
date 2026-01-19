Return-Path: <linux-iio+bounces-27947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C96D3A45C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 585A0301D9E9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D957355819;
	Mon, 19 Jan 2026 10:11:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385E20C463;
	Mon, 19 Jan 2026 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817490; cv=none; b=sjrqCinJMGu4VxGCwZO8q1DiOrJ0QCSlJCE50k90FhNK9QLwpqXLJTbxMx0TSmInUY2yfUz5i6jk8ssW5/JV4t/5RO1QkH19RZ+GZDVBBR+d/vM69YiQI6/d379ZY8ttrqo+rY8W/rvRsbrFTFsMdQkjo6Zgrab+yoGt48V3Z0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817490; c=relaxed/simple;
	bh=57lEC4dXUpUv773+WZ6rBaiLlekOcOl648c/iA8uT6c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgHUjGwCyreFjVwryrsxj6KExoOy0zH2bLDCiewEUFhCLnLF/5vVuvZ0clQTuTLOYOo6BYy9m8IjLb1SZ/OEA+WTy263HpBvSVSAGAtANS/u384MAjsJKA34SbVhs40AKws2BQAPGn8J4SlESdfeOIgrcPMftiulZ2D6EpT4BF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dvmS91KXtzHnHDj;
	Mon, 19 Jan 2026 18:10:49 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BB5BA40571;
	Mon, 19 Jan 2026 18:11:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Jan
 2026 10:11:17 +0000
Date: Mon, 19 Jan 2026 10:11:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
	<sean.anderson@linux.dev>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] spi: Documentation: add page on multi-lane
 support
Message-ID: <20260119101116.00002664@huawei.com>
In-Reply-To: <ad688ba9-7771-4b64-a9d7-ec5100345460@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-5-295f4f09f6ba@baylibre.com>
	<20260114091024.390432c0@jic23-huawei>
	<ad688ba9-7771-4b64-a9d7-ec5100345460@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 16 Jan 2026 16:35:13 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/14/26 3:10 AM, Jonathan Cameron wrote:
> > On Mon, 12 Jan 2026 11:45:23 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> Add a new page to Documentation/spi/ describing how multi-lane SPI
> >> support works. This is uncommon functionality so it deserves its own
> >> documentation page.
> >>  
> 
> ...
> 
> >> +
> >> +For example, a dual-simultaneous-sampling ADC with two 4-bit lanes might be
> >> +wired up like this::
> >> +
> >> +    +--------------+    +----------+
> >> +    | SPI          |    | AD4630   |
> >> +    | Controller   |    | ADC      |
> >> +    |              |    |          |
> >> +    |          CS0 |--->| CS       |
> >> +    |          SCK |--->| SCK      |
> >> +    |          SDO |--->| SDI      |
> >> +    |              |    |          |
> >> +    |        SDIA0 |<---| SDOA0    |
> >> +    |        SDIA1 |<---| SDOA1    |
> >> +    |        SDIA2 |<---| SDOA2    |
> >> +    |        SDIA3 |<---| SDOA3    |
> >> +    |              |    |          |
> >> +    |        SDIB0 |<---| SDOB0    |
> >> +    |        SDIB1 |<---| SDOB1    |
> >> +    |        SDIB2 |<---| SDOB2    |
> >> +    |        SDIB3 |<---| SDOB3    |
> >> +    |              |    |          |
> >> +    +--------------+    +----------+
> >> +
> >> +It is described in a devicetree like this::
> >> +
> >> +    spi {
> >> +        compatible = "my,spi-controller";
> >> +
> >> +        ...
> >> +
> >> +        adc@0 {
> >> +            compatible = "adi,ad4630";
> >> +            reg = <0>;
> >> +            ...
> >> +            spi-rx-bus-width = <4>, <4>; /* 2 lanes of 4 bits each */
> >> +            ...
> >> +        };
> >> +    };  
> 
> 
> ...
> 
> >> +properties are needed to provide a mapping between controller lanes and the
> >> +physical lane wires.
> >> +
> >> +Here is an example where a multi-lane SPI controller has each lane wired to
> >> +separate single-lane peripherals::
> >> +
> >> +    +--------------+    +----------+
> >> +    | SPI          |    | Thing 1  |
> >> +    | Controller   |    |          |
> >> +    |              |    |          |
> >> +    |          CS0 |--->| CS       |
> >> +    |         SDO0 |--->| SDI      |
> >> +    |         SDI0 |<---| SDO      |
> >> +    |        SCLK0 |--->| SCLK     |
> >> +    |              |    |          |
> >> +    |              |    +----------+
> >> +    |              |
> >> +    |              |    +----------+
> >> +    |              |    | Thing 2  |
> >> +    |              |    |          |
> >> +    |          CS1 |--->| CS       |
> >> +    |         SDO1 |--->| SDI      |
> >> +    |         SDI1 |<---| SDO      |
> >> +    |        SCLK1 |--->| SCLK     |
> >> +    |              |    |          |
> >> +    +--------------+    +----------+
> >> +
> >> +This is described in a devicetree like this::
> >> +
> >> +    spi {
> >> +        compatible = "my,spi-controller";
> >> +
> >> +        ...
> >> +
> >> +        thing1@0 {
> >> +            compatible = "my,thing1";
> >> +            reg = <0>;
> >> +            ...
> >> +        };
> >> +
> >> +        thing2@1 {
> >> +            compatible = "my,thing2";
> >> +            reg = <1>;
> >> +            ...
> >> +            spi-tx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for tx wire */
> >> +            spi-rx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for rx wire */  
> > 
> > Whilst simple I'd kind of expect a multi lane case as the example, or this and
> > the multilane one? For me the comment that follows is sufficient for the 1 lane
> > offset case you have here.  
> 
> I thought that is what I did. I have one example that shows multiple lanes (ADC)
> and one example that shows the map (Thing 1/2).
> 
> But I guess you mean that you want a 3rd example that show both the map and
> multiple lanes at the same time?
Oops. No. I was arguing....
> 
> I chose these two examples because they came from real-world use cases that
> drove adding this feature. We didn't have a real-world case yet that used
> both the map and multiple lanes at the same time so I didn't include that.
> 
> >   
> >> +            ...
> >> +        };
> >> +    };
> >> +
> >> +
> >> +The default values of ``spi-rx-bus-width`` and ``spi-tx-bus-width`` are ``<1>``,
> >> +so these properties can still be omitted even when ``spi-rx-lane-map`` and
> >> +``spi-tx-lane-map`` are used.  

This comment is enough to allow you to drop the first example entirely and
just have the 2nd.

Jonathan

> > 
> > 
> >   
> 
> 
> 


