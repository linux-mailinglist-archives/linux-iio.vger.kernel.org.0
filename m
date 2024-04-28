Return-Path: <linux-iio+bounces-4599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB158B4D41
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B3F28163B
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056173510;
	Sun, 28 Apr 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdUep3LN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D37317F;
	Sun, 28 Apr 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325564; cv=none; b=QIcJTSf4Zqa445aGiUv5k1exoMehiu7hLKp4VK3UWAlq1+qCGMwWElFkE08VGImU/aQA4IUWYEywyJ6fKKF0jWKesv+Hl3NZvnvUaMS5enJ0Qo+YADlW5YGaxXat3iN9udTUYz7u7sgS1K+9n7sfTj8wSntt1oTSk+lKnfBi3JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325564; c=relaxed/simple;
	bh=BeTkXS2XpFoKpa5hMIIbxaIDcnbADrfmce2/K3SeXRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwTANmcAU5NOxJr1K5X1a8KCe5PJVvdt2Z5LC01ngtCNOlSJdfpP9GI3Q5CfcuUJsy+irzOXqrvJZIhgLsCEXoR5/en1h7QgXKBEoXmTdR4jFs3cfurLc1eXsE77UMcmpPqn0tSjvm9qsJzrs/7jedYfbOnhghyAaDbAEtnNf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdUep3LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD88C113CC;
	Sun, 28 Apr 2024 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714325564;
	bh=BeTkXS2XpFoKpa5hMIIbxaIDcnbADrfmce2/K3SeXRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PdUep3LNZzRyO/Fy8MgK58l6WrXMTD6FY6LV9R66XQK1j+PpeDilIy9BCQfY52duT
	 JRVgtlYjsv9hFQ0Hs5yUQCgfWG9gT4haPn46ytRKhNSdUeB55H3DMFg0N4ro4TdT2J
	 BK1uQSZQyZmauBr+PQPzC+ghDkAy5QeC9T7NmMWcVCRZYbdSC+U8/CzmIxLFuGZoY3
	 gHqxOg3rwWijYOEA9iw/x2CPnqyTAef030IB25EtUeyp48sWZ/STAgRbBdm839wUyx
	 OW96Fj7xnja8GKM1jplK9LWFYs6s1ELBvwUGgMUDU7qbDZ9tkWVAzdulMLLZVPGSVD
	 hQA5h3MPFno3Q==
Date: Sun, 28 Apr 2024 18:32:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 7/7] iio: adc: ad9467: support digital interface
 calibration
Message-ID: <20240428183231.644857bd@jic23-huawei>
In-Reply-To: <20240426-ad9467-new-features-v2-7-6361fc3ba1cc@analog.com>
References: <20240426-ad9467-new-features-v2-0-6361fc3ba1cc@analog.com>
	<20240426-ad9467-new-features-v2-7-6361fc3ba1cc@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 17:42:16 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> To make sure that we have the best timings on the serial data interface
> we should calibrate it. This means going through the device supported
> values and see for which ones we get a successful result. To do that, we
> use a prbs test pattern both in the IIO backend and in the frontend
> devices. Then for each of the test points we see if there are any
> errors. Note that the backend is responsible to look for those errors.
> 
> As calibrating the interface also requires that the data format is disabled
> (the one thing being done in ad9467_setup()), ad9467_setup() was removed
> and configuring the data fomat is now part of the calibration process.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>

One trivial comment.

I'd have picked up the whole series, but it feels too big to do on a Sunday
when you only posted on Friday.  Hence, lets let it sit for at least
a few more days to see if others have comments.

It might not make this cycle as a result.   I've picked up the 2 fixes
today to increase the chances those make it.

Jonathan


>  static int ad9467_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long m)
> @@ -345,7 +606,9 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad9467_state *st = iio_priv(indio_dev);
>  	const struct ad9467_chip_info *info = st->info;
> +	unsigned long sample_rate;
>  	long r_clk;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -358,7 +621,23 @@ static int ad9467_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  
> -		return clk_set_rate(st->clk, r_clk);
> +		sample_rate = clk_get_rate(st->clk);
> +		/*
> +		 * clk_set_rate() would also do this but since we would still
> +		 * need it for avoiding an unnecessary calibration, do it now.
> +		 */
> +		if (sample_rate == r_clk)
> +			return 0;
> +
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret = clk_set_rate(st->clk, r_clk);
> +			if (ret)
> +				return ret;
> +
> +			guard(mutex)(&st->lock);
> +			ret = ad9467_calibrate(st);
			return ad9467_calibrate(st);
> +		}
		unreachable();

not totally elegant but I think the early return makes more sense and we should
just use an unreachable() to squash the resulting compiler warning.

> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}

