Return-Path: <linux-iio+bounces-10129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FFB9905E2
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9F01F22A67
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA88216A37;
	Fri,  4 Oct 2024 14:21:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD6212EF7;
	Fri,  4 Oct 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051715; cv=none; b=jzsU/Ttga3zNkCkPYhNuJFzSf2I9hDfSzlb8i8amphHhR9wGqhN7tvZzlFrnuFXgpO7eCTEAUxofjOdg/gqlcmEi4uiNs/Ml5d0fx1d4B4v388KGMk9O2qNXFr6jaCp8Ele/Bx5PP0qc99YYN/cpvlHvRI+i6KmSYJNJQ1l/J+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051715; c=relaxed/simple;
	bh=jI4xt+mIZpaYYl14SmtbwUlqP+Roo8PdiS+CZnfbfMM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucvkRSMvwWp9XcOY2IgjQ6HQhBhtIV6ShwzBLAyY1hB7cAEoZ4fDLZ9Di4xOL6CLJLDA7XtPTLZLLZYjEbIjjAGQeDDdFxIiY8UshzccB2NjiGgjT8BSuCVi/a1eQ30kY1UZO/QwNNtEIQx4B6eubzmP6IUKcshRfpvSkRqaEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XKrMZ3sX1z67QqC;
	Fri,  4 Oct 2024 22:21:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3168E140A46;
	Fri,  4 Oct 2024 22:21:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Oct
 2024 16:21:49 +0200
Date: Fri, 4 Oct 2024 15:21:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Angelo Dureghello <adureghello@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, "Nuno Sa"
	<nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	<olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<dlechner@baylibre.com>
Subject: Re: [PATCH v3 08/10] iio: dac: ad3552r: extract common code (no
 changes in behavior intended)
Message-ID: <20241004152147.00003a2a@Huawei.com>
In-Reply-To: <zlfrwjnr6spzzmy75qifbdn3tuhsjsr3emxxrzoahejxf3ehem@ajymvtzgfuno>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-8-a17b9b3d05d9@baylibre.com>
	<20240929125753.789bda87@jic23-huawei>
	<zlfrwjnr6spzzmy75qifbdn3tuhsjsr3emxxrzoahejxf3ehem@ajymvtzgfuno>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

> > > +int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
> > > +			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
> > > +{
> > > +	int err;
> > > +	u32 val;
> > > +	struct fwnode_handle *gain_child __free(fwnode_handle) =
> > > +				fwnode_get_named_child_node(child,  
> > One tab more than the line above is fine for cases like this and makes for
> > more readable code.
> >  
> Aligning with c then line comes to long. 
> I can offer, as in other drivers:
> 
> int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
> 			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
> {
> 	int err;
> 	u32 val;
> 	struct fwnode_handle *gain_child __free(fwnode_handle) =
> 		fwnode_get_named_child_node(child,
> 					    "custom-output-range-config");

That looks good to me

> 
> Also, do you prefer 80 or 100 as eol limit ?

Prefer 80, but not at the cost of readability

> 
>  
> > > +				"custom-output-range-config");  
> > 
> > Align this final parameter with c of child.
> >   
>

> > > +static int ad3552r_find_range(u16 id, s32 *vals)
> > > +{
> > > +	int i, len;
> > > +	const s32 (*ranges)[2];
> > > +
> > > +	if (id == AD3542R_ID) {  
> > 
> > This is already in your model_data. Use that not another lookup via
> > an ID enum.  The ID enum approach doesn't scale as we add more parts
> > as it scatters device specific code through the driver.
> >  
> 
> This function is only used internally to this common part.
>  
> >   
> > > +		len = ARRAY_SIZE(ad3542r_ch_ranges);
> > > +		ranges = ad3542r_ch_ranges;
> > > +	} else {
> > > +		len = ARRAY_SIZE(ad3552r_ch_ranges);
> > > +		ranges = ad3552r_ch_ranges;
> > > +	}
> > > +
> > > +	for (i = 0; i < len; i++)
> > > +		if (vals[0] == ranges[i][0] * 1000 &&
> > > +		    vals[1] == ranges[i][1] * 1000)
> > > +			return i;
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +int ad3552r_get_output_range(struct device *dev, enum ad3552r_id chip_id,
> > > +			     struct fwnode_handle *child, u32 *val)  
> > As above, don't pass the enum. Either pass the model_data or pass the
> > actual stuff you need which is the ranges array and size of that array.
> >  
> 
> Cannot pass model data, structures of the 2 drviers are different.
> If i pass arrays, the logic of deciding what array (checking the id)
> must be done in the drivers, but in this way, there will be less
> common code.

I'd prefer that to having an ID register look up in here.

Roughly speaking looking up by ID is almost always the wrong
way to go for long term scalability of a driver as more parts
are added.

Jonathan


