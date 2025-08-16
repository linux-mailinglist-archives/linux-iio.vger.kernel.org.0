Return-Path: <linux-iio+bounces-22803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC72CB28D9C
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10DA5C791A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2B28F935;
	Sat, 16 Aug 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+DevFe9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A73E10E0;
	Sat, 16 Aug 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346667; cv=none; b=huA9pVRDcMY7cEOvhRCnaX5uTokhi6DnfGnzmUg2ynFG1ZpEjiHU0WKkpKhQ/B17VnVAkbGW8oFkiRmIEKFdboauqlet8FsWTxoHlqsEYwTxP/kS0fDlSFScWz0BTmTjF3pnbS6QS7L1IdGDRdbacMngtTBQS3mKEUsPCucYnOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346667; c=relaxed/simple;
	bh=/dLj6WjSDP7wb8oyPvV9ImK34/aw73WrfwTlFUcB8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhwEFxvcWryvh7cxrBpxEAe64J7gUborhwWQ7lh/5rJNEng/Zadee6JRJ4Q8VhvqBHypUvpisFunRTVPR6IzC0VZDjVcPtGyh+rmqgUGFHAfzQbu4ljAqsHxP6h4sTyvLoc9V86XsqU4QkTMBb1gQIkC6ExBjFwNHoHFcJ2vg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+DevFe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB233C4CEEF;
	Sat, 16 Aug 2025 12:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755346666;
	bh=/dLj6WjSDP7wb8oyPvV9ImK34/aw73WrfwTlFUcB8e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f+DevFe9U8VgQ+DbiRsdyPynv/JxjOQqcpA+yNhV6oo8ruiKizoZhGShNC3mXZPOS
	 eyTsPC/nMJHvh/g1a/0CHWjeximKj94vnX9QyL2A2NESEf/CVOM0POV2sR/jYrEGuB
	 FMQWX+EqJPw2M53sT5qDIi9JN70r0Q9Tr7aZVnNduIFgHB0z1ECq6IB7hua1POUP6O
	 /TGJ3PGYLhU908aw1vXoaO0NfLy2YVgG7m0lQ9x0Sjw9CFta7vYM1wG1sG2M7GNaAQ
	 qzRa5Mab7ihOauXAisldwf8gbVKWNJ1AqbRhAIfMdJx4z69dlaeqo/Vgz8BNb6QNZM
	 k6ZasqNPVKslA==
Date: Sat, 16 Aug 2025 13:17:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Cc: remi.buisson@tdk.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 9/9] MAINTAINERS: add entry for inv_icm45600 6-axis
 imu sensor
Message-ID: <20250816131737.64905aa5@jic23-huawei>
In-Reply-To: <20250814-add_newport_driver-v4-9-4464b6600972@tdk.com>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
	<20250814-add_newport_driver-v4-9-4464b6600972@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 08:57:23 +0000
Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org> wrote:

> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Add MAINTAINERS entry for InvenSense ICM-45600 IMU device.
> 
> Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
Bus specific patches and this one all look fine to me.

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e3b0109a23045926d6a7e9659afdab0a6dbf7bed..c4aa2102ef398130074d20dd5b9367ce3fa51968 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12621,6 +12621,14 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-inv_icm42600
>  F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
>  F:	drivers/iio/imu/inv_icm42600/
>  
> +INVENSENSE ICM-456xx IMU DRIVER
> +M:	Remi Buisson <remi.buisson@tdk.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +W:	https://invensense.tdk.com/
> +F:	Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
> +F:	drivers/iio/imu/inv_icm45600/
> +
>  INVENSENSE MPU-3050 GYROSCOPE DRIVER
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-iio@vger.kernel.org
> 


