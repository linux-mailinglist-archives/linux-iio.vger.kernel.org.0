Return-Path: <linux-iio+bounces-21994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89FB10F8D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3224E5CBA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659F2EB5A2;
	Thu, 24 Jul 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYTChBJe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615022D6611;
	Thu, 24 Jul 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373900; cv=none; b=dhSQ0gOkMJ/JVy+Xz574K3GusLvAmRRuh+ZppzcfMmtwT6sveAhf2BLWAAzVjc57dk5+SX6H6kJUc5gQZEhVXZkXm/cXrHSGerWwqtNDIJQv8BxL4PbY9m5vM1cQ7ruht2RJRIZpqYltlGNoNpEPfz/Q0MWkcmTD2Jxw8rrEi9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373900; c=relaxed/simple;
	bh=5uXWgZ17vXgqnlMvvfchoHBed3PsSQansHdP/cKKAWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MShMRpxlOI96q7B4yHN9pfLDbSoSPo5C6qm8PJfr2zh1W/jctJk9N/2FIZpKusvVTXNXQ2Jde/EW6KShV720JUYoOyDtaApSHP8e8PuhbEW03Ee6Qf51+qfthoYRxhNX5EpD+uoULOlbAoKIwBFN/GCvE+z04W/qWx3aZ62VpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYTChBJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E897DC4CEED;
	Thu, 24 Jul 2025 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753373900;
	bh=5uXWgZ17vXgqnlMvvfchoHBed3PsSQansHdP/cKKAWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VYTChBJe9dLgHX+CNn7d9y1Yz0NOOh+pyQAOc8y4SOeVwmV2gQl1UUENu7b8PSego
	 D1HWR8gUmFNOWE4vMgK6rJIPPcZS7u+Ym6T9i3bX23kj4sGAToqz3leoeHJXBWqD/a
	 AhnN5zbdXh9Pbt6QUvfXCiRoevLIRfr89+UD7cCzVJ6cMkfNwmsFHmw5sXZm6nUL/F
	 ZhVcJCFLenyEK7AM8YTeLv7Oyg6C4yCT84R0JleZE4kMELta4/TkpfBJjyiHxFbliI
	 OtOc4YtK4qEnz/SzMN+8vGlq7Oyo9XM1HgiXJfcXQZh3kMZF6wR/DMvV6/cSkXS3bf
	 e3yWjT4fdRD0w==
Date: Thu, 24 Jul 2025 17:18:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iio: imu: inv_icm45600: add I3C driver for
 inv_icm45600 driver
Message-ID: <20250724171811.55b0bc0b@jic23-huawei>
In-Reply-To: <20250717-add_newport_driver-v3-7-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-7-c6099e02c562@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:25:59 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add I3C driver for InvenSense ICM-45600 devices.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
A few more trivial things in here.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9db249ca53ec3fecb0f85792a353d05463f52acb
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c
> @@ -0,0 +1,82 @@

> +};
> +
> +static const struct i3c_device_id inv_icm45600_i3c_ids[] = {
> +	I3C_DEVICE_EXTRA_INFO(0x0235, 0x0000, 0x0011, (void *)NULL),
> +	I3C_DEVICE_EXTRA_INFO(0x0235, 0x0000, 0x0084, (void *)NULL),
> +	{ /* sentinel */ },

no comma on sentinels.


> +static int inv_icm45600_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	int ret;
> +	unsigned int whoami;
> +	struct regmap *regmap;
> +	const int nb_chip = ARRAY_SIZE(i3c_chip_info);
> +	int chip;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &inv_icm45600_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i3cdev->dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
Use return dev_err_probe() for all error messages in probe.

> +	}
> +
> +	ret = regmap_read(regmap, INV_ICM45600_REG_WHOAMI, &whoami);
> +	if (ret) {
> +		dev_err(&i3cdev->dev, "Failed to read part id %d\n", whoami);
> +		return ret;
> +	}
> +
> +	for (chip = 0; chip < nb_chip; chip++) {
> +		if (whoami == i3c_chip_info[chip]->whoami)
> +			break;
> +	}
> +
> +	if (chip == nb_chip) {
> +		dev_err(&i3cdev->dev, "Failed to match part id %d\n", whoami);
> +		return -ENODEV;
> +	}
> +
> +	return inv_icm45600_core_probe(regmap, i3c_chip_info[chip], false, NULL);
> +}

> 


