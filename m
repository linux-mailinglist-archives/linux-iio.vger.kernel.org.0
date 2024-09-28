Return-Path: <linux-iio+bounces-9849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693398909A
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5D71F224D5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22D343ABC;
	Sat, 28 Sep 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKODqdx9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95A52F71;
	Sat, 28 Sep 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727542055; cv=none; b=RCmTzQuvyxlTcpzMfMb3Lq4a3lJTrG+w5ng/IJr9FBL2tNPkoSr7X6Bdo+XA2CX1ypC6mNyXh/g8ytBFILKc9sxzn3w4k31wLL1v4MTPC8vaHFweeNRxbF7sxI4M6MaIydXGZ4K3W2w1nj9ngyFhqdhaeDORJlP5jFNCrjQnwNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727542055; c=relaxed/simple;
	bh=XBwQYhto9eQRyzppeCrM5Ft/X8D4Ia0CMaJXH5MTD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWY023sBGx2EJ7Zi+b2m2GK/2W54RG7K3A4E/cSiIhkEtyIXzF0ydP1eo015DMFWKWHeU/oMLsnz85gfoPz44VDdEJYC52WY6jQP/ceAXJwzv2/kwNbVzDVEd/IdZCAjJUOuCBszqBge7NVWDIEV7XRKnZuB/ywQNUNAW14aq+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKODqdx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D8FC4CEC3;
	Sat, 28 Sep 2024 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727542055;
	bh=XBwQYhto9eQRyzppeCrM5Ft/X8D4Ia0CMaJXH5MTD/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKODqdx9t3ZVR2XQnG+tuL8SnmYeeLyVgDqikMIJ7I7GyfFMEx4Agao+5v6lRe9m1
	 fM4iqbuQxRuQ/5EjX62mpRkpUN9jetVxugxgXjAW7azc0hlMdc6JHtgt8cnijvyPkn
	 Vw2qwzkHo1aWOhncb77ddFQE4P095ify2kMenOBSEesx7Y9l4vN1Vn0R3PC30jzgeJ
	 VTT/9pXGkvFYOtgdSzxe/ucTAiE1Qmj4t8q5rQxrqT3c73aal16SzsMpcBiHfdXr6W
	 uT+1Ax2X9b5PxRCBbTli/yAfivehy3al4NTNF5OXCklef37V3hGpJIaKlgL2u4n9oq
	 8Iz1D9xY0ulXg==
Date: Sat, 28 Sep 2024 17:47:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add support of IAM-20680 HP & HT
Message-ID: <20240928174726.6f6b4f0f@jic23-huawei>
In-Reply-To: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
References: <20240923-inv-mpu6050-add-iam20680-ht-hp-v2-0-48290e0b9931@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 16:53:20 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> Add support of IAM-20680 HP & HT variants. These chips have better
> hardware specs and a bigger FIFO while retaining full compatibility with
> IAM-20680.
> 
> Changes for v2:
> * Send patches to the correct list (devicetree was missing)
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Series applied to the testing branch of iio.git which I will rebase once
rc1 is available.

Thanks,

Jonathan

> ---
> Jean-Baptiste Maneyrol (2):
>       dt-bindings: iio: imu: mpu6050: Add iam20680ht/hp bindings to mpu6050
>       iio: imu: inv_mpu6050: add support for IAM-20680HT/HP
> 
>  .../bindings/iio/imu/invensense,mpu6050.yaml         |  5 +++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c           | 20 ++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c            | 10 ++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h            |  4 ++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c            | 10 ++++++++++
>  5 files changed, 49 insertions(+)
> ---
> base-commit: 1504ee03b6e48187348d20f6efc74e7d93855728
> change-id: 20240923-inv-mpu6050-add-iam20680-ht-hp-f5a42a96933b
> 
> Best regards,


