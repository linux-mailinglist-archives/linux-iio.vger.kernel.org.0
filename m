Return-Path: <linux-iio+bounces-10010-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D720298DFD0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 17:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC401F2A1CF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965241D0F5A;
	Wed,  2 Oct 2024 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cFXvov9E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59281D0487
	for <linux-iio@vger.kernel.org>; Wed,  2 Oct 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884331; cv=none; b=l4Z/Nk1qs5waeP45hYapfOELaGJuTVLxwPDjZLDjUimnXBA0XhKBKUuGOOwAq5J9YPp7kErVfhU3fNE00lkX73JiPY5dYf7VNF7fRh8zOp8JM4ai8RbwcqgDnyBjaiGWJIsMLnFt5psqblSAUJJ9MQ7/KY+1xMsmTAFUj/70STU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884331; c=relaxed/simple;
	bh=DPOBMVOFtBxq64pYAj3gYwkHHn943QhY1vmX9X1ELuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW/wW+JLQ+Liq0H1BcOGCxywLqg2BNgASnwjnneeF6QGPUPPewnFHN1kYN1Ni9BP1+IccVrJRTa/w/PJxgPf5d9DvNzKfbnM6dbi7H0XDA1HzgZV1lMTtZp8UJ2IaXtVlMTX3Vk/NTivdvhKq2eGAWv7jqN6m2BVWI9jrJp2STE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cFXvov9E; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cd831ab06so2888486f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Oct 2024 08:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727884327; x=1728489127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XkqFkShsZW17goxJbUUEu8c6bpmyrXaccB+BjouEhx0=;
        b=cFXvov9ENTVYE7mqZ6IkH9s5HqvEf0SKtZ4Ey7Khae6tnGWUyAA/oBN7wsEnWkOUSF
         WBsYcHuY+d7gM7DhKkKQclkLn/1WlFNvYknY3iJYHmsWQEv9otvYMVdeaGuvBT0Lqjgz
         LjByxYhuKYYhLb3SdqHfXbLpuGKr6CambxGsKYlwI2Mzk5iYq6c8vf//72WFndjc1OVS
         kDJ2Dcm/94ba91cT8NjauOwJX+z/qxflPPQQIhdgMIAmD5BTEhtWkXacVqP+kDAyJLvB
         4lmJJSOgkQKPTR52N2hBTFPBJeTkI545huCrqCvk9w6vlEsd2C6rbdQaC0/Y/EeFslXg
         bObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884327; x=1728489127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkqFkShsZW17goxJbUUEu8c6bpmyrXaccB+BjouEhx0=;
        b=QMdAYkE+SfTDVYBM0520akqnT7ALJkNI5Rg6qjMYP/7DxKCkqC1rQyzlcEo7uNF8vq
         DP3+6t9NPjpwAK82FoEqkNHXuhhPBJBGmwAcDgWpxcVzzoTkqgw0a++pW8yDWeu9sE/2
         JBEB+kkfzKOVtmNRA1lqlFonAuJ9tK0wmQEORszISOvgZ6vyrWK6FtnMMmkyCEU+xHMh
         OxZGAVLYw7wLB/vmmGVEfk6ZBWt4omDJseE4J3DzPKVG+eMBBIYjIKQnLaU3HU4n2ChM
         7uMViTbxvlimAA9qfPHi7N1hxOwflhTo680Hx1yYoXcPCsppN6WDsd/p4p3TpcgcbsyT
         VtIg==
X-Forwarded-Encrypted: i=1; AJvYcCWW0e6ziIPHUbHhM7FrDTsPHAX1G4neO8SbzqAJez/LSc1EPejce1ioPPRaur6gN8xQxGthFJZAG8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxirZeMYYy8TW74WHumEmai2KDxyl+a6s0PPg8WOC+4u0snVcn
	eQOd4EA8vJ6ojd9SH17ONGt46w6w081rCOn+waSJ3caS5PSFdk8pv6k4t7axB+g=
X-Google-Smtp-Source: AGHT+IFXMW0efT+6z4FvuUo6EF/E6vuy6aUKegSmExgoi0ybBCxjbP/IeTYXT59s/kqUyFmcD3C6Mw==
X-Received: by 2002:a05:6000:186c:b0:374:ba23:4b3f with SMTP id ffacd0b85a97d-37cfb8a621emr2336627f8f.9.1727884326764;
        Wed, 02 Oct 2024 08:52:06 -0700 (PDT)
Received: from dfj (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65e4sm14111501f8f.61.2024.10.02.08.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:52:06 -0700 (PDT)
Date: Wed, 2 Oct 2024 17:50:45 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 08/10] iio: dac: ad3552r: extract common code (no
 changes in behavior intended)
Message-ID: <zlfrwjnr6spzzmy75qifbdn3tuhsjsr3emxxrzoahejxf3ehem@ajymvtzgfuno>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-8-a17b9b3d05d9@baylibre.com>
 <20240929125753.789bda87@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929125753.789bda87@jic23-huawei>

Hi Jonathan,

On 29.09.2024 12:57, Jonathan Cameron wrote:
> On Thu, 19 Sep 2024 11:20:04 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Extracting common code, to share common code to be used later
> > by the AXI driver version (ad3552r-axi.c).
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> For these, main request is to move them to a namespace + GPL is
> probably the appropriate choice here.
> 
> 
> > ---
> >  drivers/iio/dac/Makefile         |   2 +-
> >  drivers/iio/dac/ad3552r-common.c | 173 +++++++++++++++++++++++
> >  drivers/iio/dac/ad3552r.c        | 293 ++++-----------------------------------
> >  drivers/iio/dac/ad3552r.h        | 190 +++++++++++++++++++++++++
> >  4 files changed, 390 insertions(+), 268 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> > index 2cf148f16306..56a125f56284 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -4,7 +4,7 @@
> >  #
> >  
> >  # When adding new entries keep the list in alphabetical order
> > -obj-$(CONFIG_AD3552R) += ad3552r.o
> > +obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
> >  obj-$(CONFIG_AD5360) += ad5360.o
> >  obj-$(CONFIG_AD5380) += ad5380.o
> >  obj-$(CONFIG_AD5421) += ad5421.o
> > diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> > new file mode 100644
> > index 000000000000..624f3f97cdea
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad3552r-common.c
> > @@ -0,0 +1,173 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +//
> > +// Copyright (c) 2010-2024 Analog Devices Inc.
> > +// Copyright (c) 2024 Baylibre, SAS
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include "ad3552r.h"
> > +
> > +const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] = {
> > +	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
> > +	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
> > +	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
> > +	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
> > +	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= { -10000, 10000 }
> > +};
> > +EXPORT_SYMBOL(ad3552r_ch_ranges);
> 
> GPL and namespace them to avoid poluting the general namespace with driver
> specific exports.
> 
> EXPORT_SYMBOL_NS_GPL() etc.
> 
> 
> > +
> > +u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
> > +{
> > +	u16 reg;
> > +
> > +	reg = FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n);
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs((s32)goffs) >> 8);
> Hmm. Not sure the s32 case does anything useful here.
> Also this is a little messy from local view of code. It is not obvious
> that only BIT(0) can be set here.  I'd be tempted to mask that
> before passing to FIELD_PREP()
> 
> > +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)goffs < 0);
> 
> Why do you need the s32 cast for this last line?
> 
> > +
> > +	return reg;
> > +}
> > +
> > +int ad3552r_get_ref_voltage(struct device *dev)
> > +{
> > +	int voltage;
> > +	int delta = 100000;
> > +
> > +	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
> > +	if (voltage < 0 && voltage != -ENODEV)
> > +		return dev_err_probe(dev, voltage,
> > +				     "Error getting vref voltage\n");
> > +
> > +	if (voltage == -ENODEV) {
> > +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> > +			return AD3552R_INTERNAL_VREF_PIN_2P5V;
> > +		else
> > +			return AD3552R_INTERNAL_VREF_PIN_FLOATING;
> > +	}
> > +
> > +	if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> > +		dev_warn(dev, "vref-supply must be 2.5V");
> > +		return -EINVAL;
> > +	}
> 
> Obviously this is legacy code, but why do we care in the driver?
> If someone has circuitry or configuration that is wrong, do we need to check
> that?  I guess it does little harm though.
> 
> > +
> > +	return AD3552R_EXTERNAL_VREF_PIN_INPUT;
> > +}
> > +
> > +int ad3552r_get_drive_strength(struct device *dev, u32 *val)
> > +{
> > +	int err;
> > +
> > +	err = device_property_read_u32(dev, "adi,sdo-drive-strength", val);
> > +	if (err)
> > +		return err;
> > +
> > +	if (*val > 3) {
>


 
> Usually we avoid setting values passed back on error if it is easy to do so.
> I'd bounce via a local variable and only set *val = drive_strength
> after you know it is in range.
> 
> > +		dev_err(dev,
> > +			"adi,sdo-drive-strength must be less than 4\n");
> > +		return -EINVAL;
> Is dev_err_probe() appropriate here?  I haven't checked if this is called
> from non probe paths so ignore this comment if it is.
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
> > +			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
> > +{
> > +	int err;
> > +	u32 val;
> > +	struct fwnode_handle *gain_child __free(fwnode_handle) =
> > +				fwnode_get_named_child_node(child,
> One tab more than the line above is fine for cases like this and makes for
> more readable code.
>
Aligning with c then line comes to long. 
I can offer, as in other drivers:

int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
{
	int err;
	u32 val;
	struct fwnode_handle *gain_child __free(fwnode_handle) =
		fwnode_get_named_child_node(child,
					    "custom-output-range-config");

Also, do you prefer 80 or 100 as eol limit ?

 
> > +				"custom-output-range-config");
> 
> Align this final parameter with c of child.
> 
> > +
> > +	if (!gain_child)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "custom-output-range-config mandatory\n");
> > +
> > +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "adi,gain-scaling-p mandatory\n");
> > +	*gs_p = val;
> > +
> > +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "adi,gain-scaling-n property mandatory\n");
> > +	*gs_n = val;
> > +
> > +	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "adi,rfb-ohms mandatory\n");
> > +	*rfb = val;
> > +
> > +	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
> > +	if (err)
> > +		return dev_err_probe(dev, err,
> > +				     "adi,gain-offset mandatory\n");
> > +	*goffs = val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad3552r_find_range(u16 id, s32 *vals)
> > +{
> > +	int i, len;
> > +	const s32 (*ranges)[2];
> > +
> > +	if (id == AD3542R_ID) {
> 
> This is already in your model_data. Use that not another lookup via
> an ID enum.  The ID enum approach doesn't scale as we add more parts
> as it scatters device specific code through the driver.
>

This function is only used internally to this common part.
 
> 
> > +		len = ARRAY_SIZE(ad3542r_ch_ranges);
> > +		ranges = ad3542r_ch_ranges;
> > +	} else {
> > +		len = ARRAY_SIZE(ad3552r_ch_ranges);
> > +		ranges = ad3552r_ch_ranges;
> > +	}
> > +
> > +	for (i = 0; i < len; i++)
> > +		if (vals[0] == ranges[i][0] * 1000 &&
> > +		    vals[1] == ranges[i][1] * 1000)
> > +			return i;
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +int ad3552r_get_output_range(struct device *dev, enum ad3552r_id chip_id,
> > +			     struct fwnode_handle *child, u32 *val)
> As above, don't pass the enum. Either pass the model_data or pass the
> actual stuff you need which is the ranges array and size of that array.
>

Cannot pass model data, structures of the 2 drviers are different.
If i pass arrays, the logic of deciding what array (checking the id)
must be done in the drivers, but in this way, there will be less
common code.
 
> > +{
> > +	int ret;
> > +	s32 vals[2];
> > +
> > +	/* This property is optional, so returning -ENOENT if missing */
> > +	if (!fwnode_property_present(child, "adi,output-range-microvolt"))
> > +		return -ENOENT;
> > +
> > +	ret = fwnode_property_read_u32_array(child,
> > +					     "adi,output-range-microvolt",
> > +					     vals, 2);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				"invalid adi,output-range-microvolt\n");
> > +
> > +	ret = ad3552r_find_range(chip_id, vals);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret,
> > +			"invalid adi,output-range-microvolt value\n");
> > +
> > +	*val = ret;
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> 
> Jonathan
> 
> 

Thanks,

-- 
Regards,
  Angelo

