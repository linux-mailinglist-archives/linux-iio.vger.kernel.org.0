Return-Path: <linux-iio+bounces-27385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE144CE00A7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD8AF300AB3B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A114E32570F;
	Sat, 27 Dec 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdE0gYR9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF401C862E;
	Sat, 27 Dec 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858414; cv=none; b=js3SFv0yYQHMJdexC987mYyv9QIF/CWyrBGoLCaJbGLBmjHWgCA7t3Ka13HefgB88AIzYgmglD38aCbMKEeVosfyJw2KU7gAi3AVW/y68Wj/31r3Ckj6nHrG+CdgePSextL/u/aIGvwA1QQ2ZXliTqQMnnPlY29ppRIxIVmKZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858414; c=relaxed/simple;
	bh=2jrcd7lNMsv9NaWukXznHnm1ByuLbgKXfqHus+woNhE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDa0Hn0O3uqvvRqc2onTmocH1MJkjJY+hnRMF1rrNhrT20qUU4pJSnGI2Kwyl/OXrd9IOGJ+AL7g4A+5dUOhi0VYUN78gpedloWxrjzb6ZyOFH7X1alFUgSYb74MNr3GCWjoCqxUdjn6lwRSzRY7UvsvahGDWRXvjpZgOV2390w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdE0gYR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9152C4CEF1;
	Sat, 27 Dec 2025 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766858413;
	bh=2jrcd7lNMsv9NaWukXznHnm1ByuLbgKXfqHus+woNhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QdE0gYR9JdTt8+OOaCACTsUWDjQKZEMsvGBmxR5+JmSBdhCyEmwhbrFoSlcM9wghW
	 jvPY79gKcbz5bbxNTGGsq840+J6FkYx/LqXXRO/rg9o0UCMjw65zv04LW5Vhd+/Q8R
	 nZSfoP3i8NfXFmKwq14t3JblSWeBVvVm8YnFHWHBTtjTneXMjKBWQv84PfO6X3MWL1
	 Uu1n/vh3PMS8J3vYFlv4yiRrWoiOHIOtz3ie90EqwH8BJp6WREzR+VyFvNqL1cg0j7
	 6XzkB0KaNRXXYAc1bJRb5UZUbEGAfBnYW8PTiVvKX4XIBsPCi3FjUEO0v/KGPPYUha
	 +G1n8HW4rTvwA==
Date: Sat, 27 Dec 2025 18:00:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: lsm6dsx: Add alternative ACPI mount
 matrix retrieval
Message-ID: <20251227180006.139c64e2@jic23-huawei>
In-Reply-To: <20251223025351.3099978-4-samuel@dionne-riel.com>
References: <20251223025351.3099978-2-samuel@dionne-riel.com>
	<20251223025351.3099978-4-samuel@dionne-riel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 21:53:51 -0500
Samuel Dionne-Riel <samuel@dionne-riel.com> wrote:

> This uses the SLA0 matrix, which is how the SMOCF05 configuration
> exposes the mounting information for the accelerometer.
> 
> On a limited sample size of one (1) unit, the SLG0 matrix is the
> identity matrix. It is unknown how the SLG0 mounting matrix would
> logically affect the data, if it differed from the identity matrix.
> After all, the IMU is mounted as one single unit, its mounting can't
> differ on the gyroscope compared to the accelerometer.
Hi Samuel

*sigh* More ACPI creativity.  Thanks for your detailed investigation.

I'm a bit curious why they didn't use the ones Microsoft defined
for windows but otherwise fine to support this.  A comment on the
approach below.

> 
> Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 49ac17806e720..4bf1f7f7552d1 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2707,6 +2707,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  			return err;
>  	}
>  
> +	if (!iio_read_acpi_mount_matrix(hw->dev, &hw->orientation, "SLA0")) {
> +		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
Whilst this 'works' this internal call is pointless as we already did this
if there was not match on ROTM just off the context visible here.

I think the way to do this cleanly is probably to have an st_read_acpi_mount_matrix()
helper that tries ROTM and SLA0 in turn.  Then have something like;

	if(!st_read_acpi_mount_matrix(hw->dev, &hw->orientation)) {
		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
		if (err)
			return err;


	}
> +		if (err)
> +			return err;
> +	}
> +
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		if (!hw->iio_devs[i])
>  			continue;


