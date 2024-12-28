Return-Path: <linux-iio+bounces-13841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE39FDAFD
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3158F1621F7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB618A93E;
	Sat, 28 Dec 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDEmm4Kh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAC136672;
	Sat, 28 Dec 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735397244; cv=none; b=WESfMk+1D7JE/VtouRe2loTYDbvTdcKiymS0hV+Muh793wk+DVQ9PUscD+/LCMjdtQB2O0oc6JilmYKKrt0LYabI3XGVWU87wCDxbR70OSnobbzpaO9ubL2000D+OPSn3KgVkYH8IaJ6pwxBAIGYzB8PhlqBjze1OQWbvuLzUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735397244; c=relaxed/simple;
	bh=3NC4sRJjCu3y/JxQgabEfXKmeDT/DTP90TymP/FIa84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvO2pqwyV6ZZtbHlD0V6TZwhVxgNQafb+jONH+KMylspQBQhb3/DWRHpyewEPC3u5njOa4lCNoj0+VBSPQenhQIvMKpfskPA/pwW9MZ/MhQ2KAeY2D7jxFNsZIje2nq3NJnNbhyaUH/IJW3IMiknCH8sVSWQe94i0astRZPqmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDEmm4Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C11FC4CECD;
	Sat, 28 Dec 2024 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735397243;
	bh=3NC4sRJjCu3y/JxQgabEfXKmeDT/DTP90TymP/FIa84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDEmm4KhCICtKgnI3p9ModSSldAY/3cTlHoiij0YOLuv7hIlhuupORg5x69IKtiqT
	 qFZtJWCOHkjfXahW+QD2jcfcSWDebB3S76f2BpCAk11+dBs5N3YE2DB//rizcoB8f7
	 7WGOhRlJtz39CGeDzkWj20GmHIXvX6ZVlKW1Ltf8yf6/u8xMXbxF8UXe8Dsv0M7ZTn
	 b7DdwMhL9B81iX0F3MTB9Mrs9//3aXy6svdfxGxdGECKpu57TOqCtIwHCu93hi11WN
	 OMDUr12Ii+2RNRE6sfqDaA+g032cKySH49SLavtn/qHOfh1rxUJ/P5z7C1Hg866i8K
	 XLQuFnZEMy4yA==
Date: Sat, 28 Dec 2024 14:47:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 7/7] iio: accel: adxl345: complete the list of
 defines
Message-ID: <20241228144714.2c1db6a8@jic23-huawei>
In-Reply-To: <20241225181338.69672-8-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
	<20241225181338.69672-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 18:13:38 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Having interrupts events and FIFO available allows to evaluate the
> sensor events. Cover the list of interrupt based sensor events. Keep
> them in the header file for readability.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

One comment inline

Thanks,

Jonathan

>  #define ADXL345_REG_BW_RATE		0x2C
>  #define ADXL345_REG_POWER_CTL		0x2D
>  #define ADXL345_REG_INT_ENABLE		0x2E
> @@ -34,20 +59,40 @@
>  #define ADXL345_FIFO_CTL_MODE(x)	FIELD_PREP(GENMASK(7, 6), x)
>  
>  #define ADXL345_INT_DATA_READY		BIT(7)
> +#define ADXL345_INT_SINGLE_TAP		BIT(6)
> +#define ADXL345_INT_DOUBLE_TAP		BIT(5)
> +#define ADXL345_INT_ACTIVITY		BIT(4)
> +#define ADXL345_INT_INACTIVITY		BIT(3)
> +#define ADXL345_INT_FREE_FALL		BIT(2)
>  #define ADXL345_INT_WATERMARK		BIT(1)
>  #define ADXL345_INT_OVERRUN		BIT(0)
> +
> +#define ADXL345_S_TAP_MSK	ADXL345_INT_SINGLE_TAP
> +#define ADXL345_D_TAP_MSK	ADXL345_INT_DOUBLE_TAP

Why have these?




