Return-Path: <linux-iio+bounces-9935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8423798A7C6
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4718B25136
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2E91925B7;
	Mon, 30 Sep 2024 14:50:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182919258E;
	Mon, 30 Sep 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707805; cv=none; b=RFhn13fdPM4RvUojtAuwgRFUMpuBEmfIFnB3nHlyYO/1he0mYtpW9Nkrg4+26D6Md1d1x2NPaoKVV6lAPJtgUu3PcvWPbR8pqLJgnLlRugQFY3snj0ZEqH1B4rbOz1dmQ8df0QWvZetlY5DYltLtZLC2Lm1yGNZ3Rw8356Vvv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707805; c=relaxed/simple;
	bh=TfmtS75kWC5W9a+jK++P0hyVvmDVltOuZCz4t340fvQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DugC6KxlIiUOSupDDLDZfzMaPlYoQAtfF/G/GNqDB2uQ3Z0Jxpn2AafVDDqecAHXTsnRkq4unZTfsgDudm9Z5c8WWaqVr1n8WXsv9yEqLvN//v300BZDANXmFJc7LH/SmkJ//xya4ZioFkbNHKe3uAsYrtN2tLdMr+5K0HIoN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XHP5H137vz6D9js;
	Mon, 30 Sep 2024 22:45:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F43D1404F9;
	Mon, 30 Sep 2024 22:50:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 30 Sep
 2024 16:50:00 +0200
Date: Mon, 30 Sep 2024 15:49:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, "Nuno Sa"
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	<olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<dlechner@baylibre.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <20240930154958.00004507@Huawei.com>
In-Reply-To: <oh2xoym6dwvfn5lbzx3j5ckd3gfzvl2ukohrs4ukumkv6kzwi5@ume3z224gjta>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	<20240929115150.6d1c22b3@jic23-huawei>
	<oh2xoym6dwvfn5lbzx3j5ckd3gfzvl2ukohrs4ukumkv6kzwi5@ume3z224gjta>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 30 Sep 2024 16:15:41 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 29.09.2024 11:51, Jonathan Cameron wrote:
> > On Thu, 19 Sep 2024 11:20:00 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >   
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > 
> > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > a physical bus for AD3552R and similar chips, and acts as
> > > an SPI controller.  
> > 
> > Wrap is a bit short. Aim for < 75 chars for patch descriptions.
> >   
> > > 
> > > For this case, the binding is modified to include some
> > > additional properties.
> > > 
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > index 41fe00034742..aca4a41c2633 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > @@ -60,6 +60,18 @@ properties:
> > >      $ref: /schemas/types.yaml#/definitions/uint32
> > >      enum: [0, 1, 2, 3]
> > >  
> > > +  io-backends:
> > > +    description: The iio backend reference.  
> > 
> > Give a description of what the backend does in this case.  I.e. that it is
> > a qspi DDR backend with ...
> >   
> > > +      An example backend can be found at
> > > +        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> > > +    maxItems: 1
> > > +
> > > +  adi,synchronous-mode:
> > > +    description: Enable waiting for external synchronization signal.
> > > +      Some AXI IP configuration can implement a dual-IP layout, with internal
> > > +      wirings for streaming synchronization.  
> > 
> > I've no idea what a dual-IP layout is.  Can you provide a little more info
> > here?  What are the two IPs?
> >  
> IP is a term used in fpga design as "intellectual property", that is
> intended as a functional block of logic or data used to make a 
> field-programmable gate array module.
> 
> A dual layout is just 2 same fpga modules in place of one.
>  
> I can add a "fpga" regerence to be more clear.

IP I was familiar with.  I'm more interested in what each IP is doing in this
case.  Or at least an example of what sort of split of functionality might
make use of this.

Jonathan

