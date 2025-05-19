Return-Path: <linux-iio+bounces-19667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3FCABBD22
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 13:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F73B309F
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB0A277020;
	Mon, 19 May 2025 11:59:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F9277000;
	Mon, 19 May 2025 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747655963; cv=none; b=JwhrtvW0WPpij333sVg+B9y84rQte4unvBD272gJstr5yNb6ozHsXdfCUFn4hlENwpSRHQA/H0El2ogPH4eipcrZmXZm//9ZWp3sdESDatI2YvxlL8DxuhGnHaQG9g2yktpiPXobUI7mDVyB2h947uCio/ZrRGATeKwDgBtclBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747655963; c=relaxed/simple;
	bh=6NBMYYHlumnscftZI+cAkDcS8m3zloZvTXrJJ+nolNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaDs//KrrKhQOUBEGVbumBO4s+lzxoeRlWvkf6h3jYp+7/rEXMEzBTTp0i5oHHMrhY9h3MV/Ev8oSjkXsJpfSQRONHDZMJV7v4mRge4DXLbAa0UYi+rNnkK6e2U18JJQ0/fPoGeaZXoEFECDMERl4hKxq3b1+oVJAhxvdlfu8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: qo0X6FhxQBCothyun0c4vw==
X-CSE-MsgGUID: 5fusSoDaRgmgpskRh5KkQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="59781943"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="59781943"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:59:21 -0700
X-CSE-ConnectionGUID: II4KglnPTHi3jAGZGKfehQ==
X-CSE-MsgGUID: Mv6sraRQS+yPQQqE6ge5TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139095484"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:59:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uGz9H-000000031b7-1cGV;
	Mon, 19 May 2025 14:59:15 +0300
Date: Mon, 19 May 2025 14:59:15 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/12] iio: accel: adxl313: add basic interrupt
 handling
Message-ID: <aCsdEzm0ph_LfkWP@smile.fi.intel.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
 <20250518111321.75226-8-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518111321.75226-8-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, May 18, 2025 at 11:13:16AM +0000, Lothar Rubusch wrote:
> Prepare the interrupt handler. Add register entries to evaluate the
> incoming interrupt. Add functions to clear status registers and reset the
> FIFO.

...

> +static int adxl313_set_fifo(struct adxl313_data *data)
> +{
> +	unsigned int int_line;
> +	int ret;
> +
> +	ret = adxl313_set_measure_en(data, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_INT_MAP, &int_line);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,

> +			   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK,
> +				      data->fifo_mode));

Better to have these two on one line. It makes it easier to read.

> +	return adxl313_set_measure_en(data, true);
> +}

...

> +static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
> +{
> +	size_t count;
> +	int i;
> +	int ret;

> +	ret = 0;

Useless. See below.

> +	count = sizeof(data->fifo_buf[0]) * ADXL313_NUM_AXIS;

Perhaps use array_size() from overflow.h?

> +	for (i = 0; i < samples; i++) {
> +		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
> +				       data->fifo_buf + (i * count / 2), count);
> +		if (ret)
> +			return ret;
> +	}

> +	return ret;

Just return 0 here.

> +}

...

> +static irqreturn_t adxl313_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int int_stat;
> +
> +	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
> +		goto err;
> +
> +	return IRQ_HANDLED;
> +err:
> +	adxl313_fifo_reset(data);
> +
> +	return IRQ_HANDLED;

Why do we need the label? Same can be achieved without it by moving the call
under the conditional.

> +}

-- 
With Best Regards,
Andy Shevchenko



