Return-Path: <linux-iio+bounces-21993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B1B10F85
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD521CC85CB
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20C2ED15F;
	Thu, 24 Jul 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cckyl+oK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569C2EA754;
	Thu, 24 Jul 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373818; cv=none; b=qfd/mtb394/X8bm6ARRtKD0U9OeLeeNkIdBxjjfNxsdiuSTcgIgsZ1uteQG4Lpz3kLw4UoiNlLDQcsdoCMhb8RJx6u4I5WKvV/V7niNY8k4n+BzMO2uql9O9jkXoM7G2IG3DcnA4YEc3fz3FSBCjjfNYBwhWZLoC3jCRtPbxIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373818; c=relaxed/simple;
	bh=2lxhqRJEYvirtSGgA1Lfp6ysChdGuMnHDQm9ylhEJig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvB8Z1agRhcQwSDDlljpmde7FRCm1ZPcHlgNq2Djzm5Y9G8SUpZS64jqaKgO8nYKoyhT7Xn3NFr5XRoRPWTPRm0IZ5d7z17XbVLp7EkK23ek+kpgGnIUwXtP+Wvi5H8Fr4mwN5xAKMMhKum8eH/vwqYPe/1sP7yc0jo27iKAzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cckyl+oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01862C4CEEF;
	Thu, 24 Jul 2025 16:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753373818;
	bh=2lxhqRJEYvirtSGgA1Lfp6ysChdGuMnHDQm9ylhEJig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cckyl+oK8xMZpeJHkZU/5htouaFPDpD4LCSLbdt6EBTRV9C8nFG9xkhUV/2WpIlzR
	 /W2W5b20u2IRYYw5J7uk5bjf9Qg9ITaWljFyvHC00BMkbeE/MMk5s65YLht4/PJUaz
	 IlHf5D8ngg+RjsuK8Y1g27UJ/mwbgV7e3x12geRLoAUNVwNYjVAdqKi3INzgBUJYOL
	 ggLcwuwbJqQOAfEQ9wNRS0Rz8Et75QuhvdV0ZjO/nL/Wep6ycYj+NN8VNL/vGUb7JP
	 HKhT3c34NrCF7jU/rPmnmJGoNkhoKJzQUOTjdedCo43acOO1gO1cHNVcvx5V4FHT4N
	 ykqMOh40M3FjQ==
Date: Thu, 24 Jul 2025 17:16:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iio: imu: inv_icm45600: add I2C driver for
 inv_icm45600 driver
Message-ID: <20250724171650.68e8820b@jic23-huawei>
In-Reply-To: <20250717-add_newport_driver-v3-5-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
	<20250717-add_newport_driver-v3-5-c6099e02c562@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 13:25:57 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add I2C driver for InvenSense ICM-456000 devices.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>

> diff --git a/drivers/iio/imu/inv_icm45600/Makefile b/drivers/iio/imu/inv_icm45600/Makefile
> index ced5e1d9f2c10400cfa4878146672d41f815c22a..371585e29e92e78a30c7d40c1389548fa22a999a 100644
> --- a/drivers/iio/imu/inv_icm45600/Makefile
> +++ b/drivers/iio/imu/inv_icm45600/Makefile
> @@ -5,3 +5,6 @@ inv-icm45600-y += inv_icm45600_core.o
>  inv-icm45600-y += inv_icm45600_buffer.o
>  inv-icm45600-y += inv_icm45600_accel.o
>  inv-icm45600-y += inv_icm45600_gyro.o
> +
> +obj-$(CONFIG_INV_ICM45600_I2C) += inv-icm45600-i2c.o
> +inv-icm45600-i2c-y += inv_icm45600_i2c.o
> \ No newline at end of file
Check for these and fix them up before v4,


