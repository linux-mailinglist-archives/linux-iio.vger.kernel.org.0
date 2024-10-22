Return-Path: <linux-iio+bounces-10946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1729AB501
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 19:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C8B1C2251F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85A1BE874;
	Tue, 22 Oct 2024 17:25:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5B1BDA81;
	Tue, 22 Oct 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617903; cv=none; b=jwAW7VrVzHP49hSkSBY5DWSAsuxPXDD4KHqXmkcbhS3OjnYwF5x+xkVbdb35R+8y+z/DB0VI5Dd0e/JNOyuZgPS1v+wWWkuFs/rkkvvMtKMiKItLwwc9XIgFMi9A7ZPYbQqEG8sq2i7DfjJFfBjTxOfAztPb92fG7di2hyBR0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617903; c=relaxed/simple;
	bh=NjIFEcZKU2L1qHXmyWx4b7i5GYM04tGEhv9u6uJtOqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adTrBS/dtw8o5n0NjhgFoo5o1rmiWVR+gw39ThEAg88tqODhqJYAT5fuJxtUAqtb2yEc/7cLwMHvdAX2Jy/4fbVWrQsQdghqjlCC+k26HqLoHwpQvPDOQX/Agu9ezlLQtvvjTgaSfJ57P35ADmerw4jsXdFeMA0NckVWjNMw7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XXzXK5CpMz6K6HL;
	Wed, 23 Oct 2024 01:22:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 457D3140CF4;
	Wed, 23 Oct 2024 01:24:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Oct
 2024 19:24:57 +0200
Date: Tue, 22 Oct 2024 18:24:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rob Herring <robh@kernel.org>
CC: Vasileios Amoiridis <vassilisamir@gmail.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <anshulusr@gmail.com>,
	<gustavograzs@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/13] dt-bindings: iio: add binding for BME680
 driver
Message-ID: <20241022182451.00007ac0@Huawei.com>
In-Reply-To: <20241022134102.GA401216-robh@kernel.org>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
	<20241021195316.58911-12-vassilisamir@gmail.com>
	<20241022134102.GA401216-robh@kernel.org>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 08:41:02 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Oct 21, 2024 at 09:53:14PM +0200, Vasileios Amoiridis wrote:
> > Add dt-binding for BME680 gas sensor device. The device incorporates as
> > well temperature, pressure and relative humidity sensors.  
> 
> You aren't adding a binding for bme680, but extending it.
> 
> Drop the 2nd 'bindings' from subject. 
> 
> Something like this:
> 
> dt-bindings: iio/chemical: bosch,bme680: Add supply properties
> 
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |  2 -
> >  2 files changed, 64 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> > new file mode 100644
> > index 000000000000..e54df3afa7b2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bosch BME680 Gas sensor
> > +
> > +maintainers:
> > +  - Vasileios Amoiridis <vassilisamir@gmail.com>
> > +
> > +description:  
> 
> You need '>' to maintain paragraphs.
> 
> > +  BME680 is a gas sensor which combines relative humidity, barometric pressure,
> > +  ambient temperature and gas (VOC - Volatile Organic Compounds) measurements.
> > +
> > +  https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: bosch,bme680
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +  vddio-supply: true
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - vddio-supply  
> 
> These supplies can't be required. That's an ABI change from what was 
> already supported.
Hi Rob,

I thought for supplies the convention was that if the power is needed
for functioning device then to put them as required.

In case were they were missing in an original binding
allow stub regulators to deal with a DT that predates that.
Non linux cases are obviously trickier to predict but these
supplies must be on or the binding wouldn't have worked before this
point.

I remember I was very much on the side that they were optional and
convinced by others that this was the way to go.

We've added supplies for old bindings as required in the past
so probably broken someone if I have this wrong :(

Jonathan



