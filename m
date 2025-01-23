Return-Path: <linux-iio+bounces-14547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB71A1ACBE
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 23:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585F316B35B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96891D416E;
	Thu, 23 Jan 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tFxf07Np"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3E3C463
	for <linux-iio@vger.kernel.org>; Thu, 23 Jan 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671851; cv=none; b=jp/o9A3/ZY0AndVoop8IVzGfxMOsXO1ahbKU+JhZ8tNmXo8zi373NRcHQ4JKiOEnDI2fzoUC8XcPb/QCsX6fb9DsB3h+E6AaGMxKiODauU9t9YfjSRazOpNW+qa8qk3rjH8+K2D+gCCITqnMT9HEpTlnMZucFjCZF/Yqi2X/pGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671851; c=relaxed/simple;
	bh=yb2bm1Pv59pp0/eyv/03VuHbNfjDnaGLqdS8r/oT2nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlVzQi9W2VU3xyyCbhqp2Vq/Vl+lcwXB25nAtv+OCCZuDwHWoIjFpxFKbom/l3BoA1Z75ZdT4W374edNvz0LHIE/dX+mvMYLxdS24g0Yte6mZHP51yGLrzbkrzfEg085jW13uBktG0odnoj8V39Vpo0bNrKSZnXSJww151sX7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tFxf07Np; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2784cc3b-0b8f-4116-b34d-0de4ff56cf92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737671842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfFbufE/oZqYpKWLTE17oZPb84Hww5PkyDbRc8FQEe4=;
	b=tFxf07Npt3G59e0jExTBPWWrlv0Q6ZQzxnqAc+CuBqTZInnmbTdwYtTiVgttMaHfrCRx+m
	3kFCtUVwtMnNdfw+wt8J8iF0NVezP7bosn9yV7knS3/ybW85IH1XaOnCbfTo2bgW3/hUdp
	M9fi7Nz61+wCFxA3FigSB6/39PVoZUY=
Date: Thu, 23 Jan 2025 17:37:16 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-2-sean.anderson@linux.dev>
 <9f40295b-484a-48e8-b053-ff8550e589d7@baylibre.com>
 <46a7eba6-a705-4543-b967-e83ccc89e7d4@linux.dev>
 <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/23/25 16:59, David Lechner wrote:
> On 1/23/25 10:24 AM, Sean Anderson wrote:
>> On 1/21/25 19:16, David Lechner wrote:
>>> On 1/16/25 5:21 PM, Sean Anderson wrote:
> 
> ...
> 
>>> Could we make a single device connected to both buses like this work using
>>> the proposed spi-lower and spi-upper or should we consider a different binding
>>> like the one I suggested?
>> 
>> If you are willing to do the work to rewrite the SPI subsystem to handle
>> this, then I don't object to it in principle. Using a property would
>> also help with forwards compatibility. On the other hand, separate
>> busses are easier to implement since they integrate better with the SPI
>> subsystem (e.g. you can just call spi_register_controller to create all
>> the slaves).
>> 
>> There have been some previous patches from Xilinx to handle this
>> use case [1], but IMO they were pretty hacky. They got this feature
>> merged into U-Boot and it broke many other boards and took a lot of
>> cleanup to fix. So I have intentionally only tackled the unsynchronized
>> use case since that requires no modification to areas outside of this
>> driver. I don't need the "parallel" use case and I am not interested in
>> doing the work required to implement it.
>> 
>> --Sean
>> 
>> [1] https://lore.kernel.org/linux-spi/20221017121249.19061-1-amit.kumar-mahapatra@amd.com/
> 
> Fair enough, and I think it can be done without breaking things like the multi
> CS support did.
> 
> Here are a couple of patches. Feel free to resubmit them with your series if
> they work for you. To make it work with your series, you should just need to
> modify the .dts to look like this:
> 
> +          flash@0 {
> +            compatible = "jedec,spi-nor";
> +            reg = <0>;
> +            spi-buses = <0>; /* lower */
> +          };
> +
> +          flash@1 {
> +            reg = <1>;
> +            compatible = "jedec,spi-nor";
> +            /* also OK to omit property in case of spi-buses = <0>; */
> +          };
> +
> +          flash@2 {
> +            reg = <2>;
> +            compatible = "jedec,spi-nor";
> +            spi-buses = <1>; /* upper */
> +          };
> 
> 
> Then drop patch "spi: zynqmp-gqspi: Split the bus" of course.
> 
> In zynqmp_qspi_probe(), add a line:
> 
> 	ctlr->num_buses = 2;
> 
> And in the zynqmp_qspi_transfer_one() function, use spi->buses to select the
> correct bus:
> 
> 	xqspi->genfifobus = FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, spi->buses);
> 
> I don't have a SPI controller on hand with multiple buses, so I don't have
> any patch adding support to a specific controller. But I did build and run this
> and hacked in some stuff to the drivers I am working on to make sure it is
> working as advertised as best as I could with a single bus.

Your patches LGTM. I will use them for v2. Mark do you have any comments on this
approach?

--Sean

