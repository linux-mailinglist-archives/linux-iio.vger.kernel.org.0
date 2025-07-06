Return-Path: <linux-iio+bounces-21406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A15DAFA675
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5603AAA46
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888B9288523;
	Sun,  6 Jul 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKunRz9L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAB126C17;
	Sun,  6 Jul 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751818867; cv=none; b=sUHnIDxZTJaoie5onJ4JGn5hmvXKWR4CZS3bKM71QElU/9Py2cQRp7L09iD/W2edwYesdUnM3maGB7l1NsZaeFBjmX4vhTq1McbHhhUK1keA4hd4BW/5b+QFuSBii4jsH6LjTFcfMSZVqlLgoDnpL7hyS4CfE2xqF0TkJmv+b+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751818867; c=relaxed/simple;
	bh=s/gn9GtzFMUtF25ZJhrsR6BTKwb/rLfVuCtTyXMxHZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPcO2OJwYpJGlAlEHloZ8WwvlBKjruO72DjfYyfeVt17oOZDQzeZ2MQgnZkZg0pQFvcX43RfB6m69G0myUJQ3YYDNUVqB0pG1pc4/yX80d3/ODeErbOYjNwFh69u7RI9zVhVViUhGkmxbrLEEYW5SsFaVfdpZ8KkPvISWZzlzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKunRz9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE67C4CEED;
	Sun,  6 Jul 2025 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751818866;
	bh=s/gn9GtzFMUtF25ZJhrsR6BTKwb/rLfVuCtTyXMxHZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKunRz9LcAslzbOB9u5xWBwBJ44zzOck6c2cUn7GswekO0W8RGblKv+46l9JpBy96
	 1D4MDN0RdUym/NnyrgfkJV/iYSrdx1anVuULPlhKgIPOq05izGhP2rvEORVK6tcWJH
	 pp9rBck+bLMRPrHVff4taAEj1p4WGjsaXEf9mR9dUJuHRXbJrMRer1Z21SDcsWEZo2
	 WUJNT8lNDClRhcoq1Bb2WTelZl9dIjTilZ7Mq1tad2F5d9Jg6DF5ySNVbigzi+3ijy
	 f3S3aQzPYizdvv5Y6gUXNUu4/bQElGnS4EzIvXbq10BijokGLTuOPu3zeFcsluusnQ
	 CAXTupcORMQCA==
Date: Sun, 6 Jul 2025 17:20:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250706172057.4252378c@jic23-huawei>
In-Reply-To: <20250630-losd-3-inv-icm42600-add-wom-support-v6-2-5bb0c84800d9@tdk.com>
References: <20250630-losd-3-inv-icm42600-add-wom-support-v6-0-5bb0c84800d9@tdk.com>
	<20250630-losd-3-inv-icm42600-add-wom-support-v6-2-5bb0c84800d9@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 21:47:30 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM as accel roc rising x|y|z event.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
This will probably cross with the removal of explicit
pm_runtime_mark_last_busy() but we can deal with that as a follow up.

Given I haven't yet picked up the precursor for that we can't just fix
it whilst applying this.  It's harmless to have too many calls to that
though so not a problem


> +
> +static int inv_icm42600_accel_enable_wom(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
> +	int ret;
> +
> +	ret = pm_runtime_resume_and_get(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = _inv_icm42600_accel_enable_wom(indio_dev);
> +	if (ret) {
> +		pm_runtime_mark_last_busy(pdev);
Here.

> +		pm_runtime_put_autosuspend(pdev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
>
> +
> +static int inv_icm42600_accel_disable_wom(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
> +	int ret;
> +
> +	ret = _inv_icm42600_accel_disable_wom(indio_dev);
> +
> +	pm_runtime_mark_last_busy(pdev);
and here.
> +	pm_runtime_put_autosuspend(pdev);
> +
> +	return ret;
> +}
> +
>
> +static int inv_icm42600_accel_write_event_value(struct iio_dev *indio_dev,
> +						const struct iio_chan_spec *chan,
> +						enum iio_event_type type,
> +						enum iio_event_direction dir,
> +						enum iio_event_info info,
> +						int val, int val2)
> +{
> +	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *dev = regmap_get_device(st->map);
> +	int ret;
> +
> +	/* handle only WoM (roc rising) event value */
> +	if (type != IIO_EV_TYPE_ROC || dir != IIO_EV_DIR_RISING)
> +		return -EINVAL;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = _inv_icm42600_accel_wom_value(st, val, val2);
> +
> +	pm_runtime_mark_last_busy(dev);
and here.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
>

