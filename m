Return-Path: <linux-iio+bounces-23585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A9EB3EB89
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 17:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9648480F39
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C5AD5A;
	Mon,  1 Sep 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCOPv9GN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1CC120;
	Mon,  1 Sep 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741651; cv=none; b=LPguODsFZ/SKIamYG77HozoiN3CLyCtMRPlhD3+tbDTxw6oQYqltLwu25ZhFbXyBeIi5J/JSgZQcMM4efJ08yYAGACbvHGJvZeYdokaVo7ZyA7mwXGLDP9NNc+cyWodi4tMZycXfl4U5NjpfJP8Cvfs0WZ244FuwY1Vvo4HGX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741651; c=relaxed/simple;
	bh=wa+P+5C2QklAj8Tff8d1WA47VG0WDkRpFOQeI5jH5BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8hH1ngUzt80cDWGU2VzKKmNmvhV/0lIzr2On/PCqoD/ly+KRHDTy3ZZ/Lm2PP6JI+BikgF9kThCGpyTeMwkKGgzaSQb5saqx76ziJbw8+fnRPo9M575WKbVHcd2Ti2nKxkYcguszrpVe7Dl1G3V2EOrb037xGlz3DsDr4FkC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCOPv9GN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40704C4CEF0;
	Mon,  1 Sep 2025 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741651;
	bh=wa+P+5C2QklAj8Tff8d1WA47VG0WDkRpFOQeI5jH5BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCOPv9GN9mU/VGTOe0Uja1TbqBQ75MZg2Wv2NumnbXESsXNbHB1lA6GINIM9WJODi
	 m+L/cLxyhT+QyM8J8r/JryemdohC3wgifyK6Ydgz6GuUEQs0bFahL28xD74vvWOtxT
	 MYTKrYbkZ4V4qJ6jIHX0cxuED4mbVHx0cEEx6BR3rXeegamJDjwl0hyntj24kL6sN7
	 A/r0fnxZ0NQChVosKaiUMpOGKHL+wg5hAV0/ZZUFla5x85jRnw5TG6jgX7EzCkqLaD
	 QoP8n5r1bLd6o20FoG++feL7OwizR9n2IXLT5tfzsr7DK19gx9umWhZ61+oOh/vsdJ
	 aImYkmTiXa1wQ==
Date: Mon, 1 Sep 2025 16:47:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lakshay Piplani <lakshay.piplani@nxp.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 jonathan.cameron@huawei.com, akpm@linux-foundation.org, chao@kernel.org,
 jaegeuk@kernel.org, vikash.bansal@nxp.com, priyanka.jain@nxp.com,
 shashank.rebbapragada@nxp.com, Frank.Li@nxp.com
Subject: Re: [PATCH v2 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor
Message-ID: <20250901164717.6cba2d50@jic23-huawei>
In-Reply-To: <72c3ae7d-cb54-4a1b-a27a-9e673ffaddcc@kernel.org>
References: <20250827103105.2472328-1-lakshay.piplani@nxp.com>
	<20250827103105.2472328-2-lakshay.piplani@nxp.com>
	<72c3ae7d-cb54-4a1b-a27a-9e673ffaddcc@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 18:46:32 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 27/08/2025 12:31, Lakshay Piplani wrote:
> > Add support for the NXP P3T175x (P3T1750/P3T1755) family of temperature
> > sensor devices. These devices communicates via both I2C or I3C interfaces.
> > 
> > This driver belongs under IIO because:
> >   The P3T1750/P3T1755 sensors require interrupt or IBI support to handle
> >   threshold events, which the hwmon subsystem does not provide. In contrast,
> >   the IIO subsystem offers robust event handling that matches the hardware
> >   capabilities of these sensors. Therefore, this driver is better suited
> >   under IIO.
> >   
> 
> 
Picking out one thing that made me curious.

> ...
> 
> > +static int p3t1755_write_event_value(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir,
> > +				     enum iio_event_info info, int val,
> > +				     int val2)
> > +{
> > +	struct p3t1755_data *data = iio_priv(indio_dev);
> > +	unsigned int reg;
> > +	__be16 be;
> > +
> > +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> > +					   P3T1755_REG_LOW_LIM;
> > +
> > +	if (val < -2048 || val > 2047)
> > +		return -ERANGE;
> > +
> > +	be = cpu_to_be16((u16)((val & 0xfff) << 4));
> > +
> > +	return regmap_bulk_write(data->regmap, reg, &be, sizeof(be));  
> 
> Now I wonder why regmap does not handle your data format?

This device does have a novel definition of register. There
are 4 of them, 3 of which are 12 bits zero padded to 16 and
the other 8 bits.

So, I think only way to wrap that up fully in regmap would be
a pair of regmaps one of which has only a single register in it.

Agreed though that using bulk accesses is not a good plan.
I'd been assuming that was actually a pair of registers, not
a single larger one.


Jonathan


