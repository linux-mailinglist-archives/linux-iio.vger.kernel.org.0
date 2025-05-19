Return-Path: <linux-iio+bounces-19653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B9ABB9F3
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 11:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E44816B1FE
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20521FC7CA;
	Mon, 19 May 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dd1zGFWi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F341FE468
	for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647684; cv=none; b=ual9jwNcPI/U98zxrSjWZiOLx7OnF8pFNFrs5G0bbDSFTFv+1pEz0k/jfIzbhja/CDFanGsJeY8C+YwbowDSN/BJDX0NalGVUL+WuBIa0bYO2Ll3uh5OO7UILtb0lGMB8bq0SHNhOx/vHMlQYDR2PC/rEKZ3h+OPrJda3eYxC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647684; c=relaxed/simple;
	bh=1N8vBcWhIabGytynruQG56eLkX8CxqpQ09i3kQSPOCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlX+BupooTZkcUZohbxXxSOfU8w3EYZFnzI6TsceP99S9jMDOC/lWFeSIuCu8AAG8jfeClFHyqpXDao0smD3CK6U5u0zUmlpRZZ45trQcOvTl4rycau/Qi5tQF6zZX5mImdHlA5mpgJiGn+N4Z9HDfmTz2dqsDebdLltEYBN/ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dd1zGFWi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a36c2d3104so701052f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 19 May 2025 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747647681; x=1748252481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mkHsltLutO5Q2FogJQA4q6XiEXER0Twfd94ZZbKAnk=;
        b=Dd1zGFWiUp042yecqm0TkK0hJHhMHo9ZgqHARUfeUVjvHoFdV/7zedVZCVwcJkuUpW
         HSIhUyzc5xTYCEg39NWCKAzCNXc4Avb7p9aSavAIHT0o9RWWJG35tcYmpFW02XrGYaW0
         kVlbnVYBW9LrbGFLEen0zh8sk8kwf+NWQFtl+uI1Ofmg0Pd48PoAUfKheaOR7SOmLOkb
         pkXcqgJI4Xn8MGN8NWJTJ4JLcGBzHpHVNMDOU85x8onWlgMhezD4UqW1SxqPFZ3dFQvY
         D0acDT9xz4ao/0dMmNEk/58bfwAHc6FPYwb8i/TMuJHnt6Aajed5n7E1qDXnMuZsnQ9V
         bjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647681; x=1748252481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mkHsltLutO5Q2FogJQA4q6XiEXER0Twfd94ZZbKAnk=;
        b=Pv+7Q4US44abUAs5sJO6HuAXHUD9GW0jgjpdzANisH0BUeEoISsQ0ny4ZGvrTiz0rZ
         RTrKuyYuXo8hRZ+m0IUD9zvckCnQycaUCnrRqOytenKc0wKne0ImcHWL5F0H2iZ1fnu9
         HCRczpGfJ6wxD+oXh8iL6R2OVFXj1mvHKQRXtSjPEIMD2JFCo9urB3RQnRw5m33l2MzG
         RKXzbgjQBYKBSrsnJK5wk7odUsn9g8hzr48snQhDuelW4IrZzLeKj6l05S9qDIhiT2SC
         0XIRkbZa5SbxKrfsgkxHldd0+BrWo3bCkgBDb92WJnRQE0TIabgGzxxvnVYO+qc8z6WQ
         DD5A==
X-Forwarded-Encrypted: i=1; AJvYcCWPhyMJFpHS83SmH/5HBxprnoW/qR32Gpn5T2MO/leR95YwWt86ZaTfK31jrcojtP+a7I3CteCY2BA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qVPYatvqRSp9ouhMsvBf4VrA1rt67BROQD5ikadiX7Sjo9tz
	mern68mcnzD3Q+Go3op078v9LtqPwKsxNF3obW5tlKFhPLhT+ROMzgawAOtRnkFle44=
X-Gm-Gg: ASbGncsdcwiG5QO1quJuFwczB4HvjvqjuIUaLbnE4MQ2EF37dG1gGm+SadtOQ//Stju
	OnfkPq5/qo6JxUjaCSGqpsAG6dSO1Ve4nD5oPMjHeiaHUuWcKA8b0/zVBBqyq4KywH2JwE1x8Dx
	RjI1F2aL+0FubUy9BxLE114UfGCnT+2vnF0D+AQEdqUzWKWWJHa+4qN2N5V6i6E9uvm0fUU+cWP
	aj5c16Gj07xTVF5k7B7lKQxV0rsT9UJaHGft+hgYqFM6SDtKginOYsE8MYsQikl/ZIMbMW9uake
	Fc1DhMLXZ6n0SYwRx3pGtwezJhSZsrJmezxK7ajcviZQbZnYbfAUuazUKz49VcN7Uc87vxsnsXv
	8apSQU0eFCpMuXus5q7WguQyNXee3sI0TUxgA
X-Google-Smtp-Source: AGHT+IFbj+WYBa3qzJuAo96O0EsxKbMiAB2DsVMptXbWkzDD93S6xvquNDnxGoJkRMYfSk9pZVte6A==
X-Received: by 2002:a5d:5888:0:b0:3a3:7351:6f0b with SMTP id ffacd0b85a97d-3a3735171ebmr1122593f8f.57.1747647680868;
        Mon, 19 May 2025 02:41:20 -0700 (PDT)
Received: from archlinux (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a04csm11974249f8f.23.2025.05.19.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:41:20 -0700 (PDT)
Date: Mon, 19 May 2025 11:40:09 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <shzx67wrpzaxje4vj6owwnof3pi5cuipdavd3k5svucyt5y527@mvytnov6zunk>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-5-91a3f2837e6b@baylibre.com>
 <aBz_Nlgx18UK2GIc@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBz_Nlgx18UK2GIc@smile.fi.intel.com>

Hi Andy,

On 08.05.2025 22:00, Andy Shevchenko wrote:
> On Thu, May 08, 2025 at 12:06:09PM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add gain calibration support, using resistor values set on devicetree,
> > values to be set accordingly with ADC external RFilter, as explained in
> > the ad7606c-16 datasheet, rev0, page 37.
> > 
> > Usage example in the fdt yaml documentation.
> 
> ...
> 
> > +static int ad7606_chan_calib_gain_setup(struct iio_dev *indio_dev)
> > +{
> > +	struct ad7606_state *st = iio_priv(indio_dev);
> > +	unsigned int num_channels = st->chip_info->num_adc_channels;
> > +	struct device *dev = st->dev;
> > +	int ret;
> > +
> > +	/*
> > +	 * This function is called once, and parses all the channel nodes,
> > +	 * so continuing on next channel node on errors, informing of them.
> > +	 */
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		u32 reg, r_gain;
> > +
> > +		ret = fwnode_property_read_u32(child, "reg", &reg);
> > +		if (ret)
> > +			continue;
> 
> > +		/* Chan reg is a 1-based index. */
> > +		if (reg < 1 || reg > num_channels) {
> > +			dev_warn(dev, "wrong ch number (ignoring): %d\n", reg);
> > +			continue;
> > +		}
> 
> But this will allow to have a broken DT. This check basically diminishes the
> effort of the DT schema validation. If there are limits one still would be able
> to create a DT that passes the driver but doesn't pass the validation.
> 

fixed all your points on other patches of this patch-set. Still your
emails are going to google spam, just could catch them on friday. 
Really not clear why.

About the above, i understand, but the check is actually the same as
in ad7606_get_chan_config(), a warning that fdt is not correct, 
i dont see a blocking issue here now, so not going to change it
in this next patchset.

Regards,
angelo

> > +		ret = fwnode_property_read_u32(child, "adi,rfilter-ohms",
> > +					       &r_gain);
> > +		if (ret)
> > +			/* Keep the default register value. */
> > +			continue;
> > +
> > +		if (r_gain > AD7606_CALIB_GAIN_MAX) {
> > +			dev_warn(dev, "wrong gain calibration value");
> > +			continue;
> > +		}
> > +
> > +		ret = st->bops->reg_write(st, AD7606_CALIB_GAIN(reg - 1),
> > +			DIV_ROUND_CLOSEST(r_gain, AD7606_CALIB_GAIN_STEP));
> > +		if (ret) {
> > +			dev_warn(dev, "error writing r_gain");
> > +			continue;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

