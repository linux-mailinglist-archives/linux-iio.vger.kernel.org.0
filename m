Return-Path: <linux-iio+bounces-17888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B3AA82D63
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 19:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380347A4957
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15362270ED3;
	Wed,  9 Apr 2025 17:13:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2723270EC5;
	Wed,  9 Apr 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218783; cv=none; b=AuGeTS+IYVVnw8WmA3LMo/rj0tGlDc0w4xSPLA2RxkKUbDTnS4iMzkVFH3NDBzSTGiScYGYkhMEzKVjlNW3+B7wXioXDwlXGMm63H7xpc86Vl2yQQsJ8A3+75Jd11x0jTo22GdKZqeJexgfiGLhxr67jBhcyFivWCdkYUi+FXYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218783; c=relaxed/simple;
	bh=s9Gi35I1sUGULtTOtFmgKjk2LcTE5lWCFnKHhQhu+Tw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sb3BeA6rNV6AIJmav5iY1Hy4Xjx6/+46PIBPZoQUZDeSlMAl5LgDyyDen5BLvztDiPnpZmGU9CWN13I4mv3vT99oI8V3nQnp4Adl/8Rjrwh2nzUwzcJ/gxzaz+Z81/CH1053vr0QkOq007ngabiyeOXQzoiWfgYWaLfiDyP0YC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZXqD94V21z6HJc7;
	Thu, 10 Apr 2025 01:08:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B4091402F1;
	Thu, 10 Apr 2025 01:12:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 9 Apr
 2025 19:12:51 +0200
Date: Wed, 9 Apr 2025 18:12:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy@kernel.org>
CC: <jean-baptiste.maneyrol@tdk.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: imu: inv_icm42600: switch to use generic
 name irq get
Message-ID: <20250409181250.00001c9f@huawei.com>
In-Reply-To: <Z_apXw_HoD0EHHY-@smile.fi.intel.com>
References: <20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-0-dab85a0a7c2b@tdk.com>
	<20250409-iio-imu-inv-icm42600-rework-interrupt-using-names-v3-2-dab85a0a7c2b@tdk.com>
	<Z_apXw_HoD0EHHY-@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 9 Apr 2025 20:07:43 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Wed, Apr 09, 2025 at 05:14:32PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > 
> > Use generic fwnode_irq_get_byname() for getting interrupt pin using
> > interrupt name. Only INT1 is supported by the driver currently.
> > 
> > If not found fallback to first defined interrupt to keep compatibility.  
> 
> ...
> 
> > -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
> > +int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> >  			    inv_icm42600_bus_setup bus_setup);  
> 
> If you use 100 limit, it fits now on one line.

I'd rather stick to 'just over 80' where it really helps. Rather than
generally switch to 100.  Maybe that day will come but I'm not sure it is
yet.

> 
> ...
> 
> > -int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
> > +int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> >  			    inv_icm42600_bus_setup bus_setup)  
> 
> Ditto.
> 
> ...
> 
> > +	struct fwnode_handle *fwnode;  
> 
> Do you need to include property.h?
> 
> ...
> 
> > +	/* get INT1 only supported interrupt or fallback to first interrupt */
> > +	fwnode = dev_fwnode(dev);  
> 
> > +	if (!fwnode)
> > +		return -ENODEV;  
> 
> Unneeded check, the below will do it for you,
> 
> > +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> > +	if (irq < 0 && irq != -EPROBE_DEFER) {
> > +		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
> > +		irq = fwnode_irq_get(fwnode, 0);
> > +	}
> > +	if (irq < 0)
> > +		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");  
> 
> ...
> 
> > -	return inv_icm42600_core_probe(regmap, chip, client->irq,
> > +	return inv_icm42600_core_probe(regmap, chip,
> >  				       inv_icm42600_i2c_bus_setup);  
> 
> This is now one line (81 characters which is fine independently on your choice
> of the limit).
> 
> ...
> 
> > -	return inv_icm42600_core_probe(regmap, chip, spi->irq,
> > +	return inv_icm42600_core_probe(regmap, chip,
> >  				       inv_icm42600_spi_bus_setup);  
> 
> One line.
> 


