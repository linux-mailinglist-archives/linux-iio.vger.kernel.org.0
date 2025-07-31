Return-Path: <linux-iio+bounces-22168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA955B171B5
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AB417F7A0
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B02BFC8F;
	Thu, 31 Jul 2025 13:04:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354F43A8C1;
	Thu, 31 Jul 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753967056; cv=none; b=HHKxBKOCdhVhV34+ei+mBpqO1eoIB6ksR2Qp6wr1FsGaKX8At2LLzqmeWGm+RdbyBhBsfarpyw/zFpMEIDl30nMMOy4ih1DUC9xCZFXuH/Gmi4bF5l0lAYqP+K1DUxA7RKKhPtmKK/lvqtHyZF000YXyWljMIWb7Slnp8AiXIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753967056; c=relaxed/simple;
	bh=Gr5VIocSsSHBsm9aipkJffgAf8h2uKY4g13v57y4I0E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzlvrSxkhU0rZQiPLJ0j8iYXkzAFwTT7NPmbvDfEkyG5TE1oVbpg+SjwVjFNSOf9ZuTXNrrW9xk+85trpbROdiJEDuz2eU7XU3NJSeyW4aIGf5MUYp/7ZwTanx+r0RIZZlTlR3SaGIlKfjMrIoniEG18xwk3KDVSsypSb3eqRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt8PJ6wcCz6L5Cn;
	Thu, 31 Jul 2025 21:02:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E5BC11402EA;
	Thu, 31 Jul 2025 21:04:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 15:04:10 +0200
Date: Thu, 31 Jul 2025 14:04:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dixit Parmar <dixitparmar19@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: magnetometer: add support for Infineon TLV493D
 3D Magentic sensor
Message-ID: <20250731140409.00000029@huawei.com>
In-Reply-To: <aImVLWJP08_g23xu@dixit>
References: <20250726-tlv493d-sensor-v6_16-rc5-v1-0-deac027e6f32@gmail.com>
	<20250726-tlv493d-sensor-v6_16-rc5-v1-1-deac027e6f32@gmail.com>
	<20250727140559.1f6c1668@jic23-huawei>
	<aIhE5zwrPljqHqGX@dixit>
	<20250729200513.275e0d98@jic23-huawei>
	<aImVLWJP08_g23xu@dixit>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)


Please crop to the remaining discussion points.

> > > > > +
> > > > > +#define TLV493D_DATA_X_GET(b)	\
> > > > > +	sign_extend32(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << 4 | \
> > > > > +			(FIELD_GET(TLV493D_VAL_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4), 11)    
> > > > 
> > > > These are odd enough I'd make them c functions rather than macros. Burn a few lines
> > > > for better readability. 
> > > >     
> > > I saw this kind of data retrival and formation from registers as macros so I sticked to
> > > it. Having all these as function will also require a seperate function
> > > for each channel coz the masks and the layout of the bits changes over
> > > the register. Do you still recommend it as c functions?  
> > 
> > Is it more than 4 short functions?  I'd burn the few lines that costs.
> > 
> > s32 tlv493d_data_y_get(u8 *buff)
> > {
> > 	u16 val = FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << 4 |
> > 		  FIELD_GET(TLV493D_VAL_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
> > 
> > 	return sign_extend32(val, 11);
> > }  
> Okay.
> Will a single function with channel as arguments will be better?

IIRC I gave that a go as my first try before falling back to this. 
You either need a look up table, or you need to pass
a lot of parameters.  In the end it felt simpler to just have 4 small functions.

If you can come up with a clean and readable way of doing so, go for it!

Jonathan



