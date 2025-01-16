Return-Path: <linux-iio+bounces-14401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E0DA13FB2
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 17:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACAC3A9D4D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B022D4C2;
	Thu, 16 Jan 2025 16:42:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1722B8A0;
	Thu, 16 Jan 2025 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045741; cv=none; b=YiQyQ3fE+H8sindvgzQmm92waqjwGpJ0ME6g01k03BeBaNOCXyINss8EfR7vZqkOuRWf34DNhayQHUP96KOT6Iz0KquuhAPJWuODDxYa0GuT9FzN+snYhGTMJy+fTkMH3SdaC5dIFuUT3hElphDpVD9Vz5fC9BxqDFAwjGZbwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045741; c=relaxed/simple;
	bh=Gabzw77sqMoTj2enTfVlZILY8B3tf3buDe95F1mn3IQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJzRtnNYRYxYGQq9Y5nJQuCtNLdHRs/W6Vw40O+zWhI84T/l3CxQml30d5LGneW+6GT9O2DrkACn3o7AjO05EblXgXe4K8xFjd0DpL/1CuNIOYtu40qi0nkIPHvDkMwO8Xh0iO3D01rm38jgg6NQMFbn+BFDETKG1qdecCU8vRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YYpWs2lkPz6L5Ct;
	Fri, 17 Jan 2025 00:40:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C403140390;
	Fri, 17 Jan 2025 00:42:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 16 Jan
 2025 17:42:13 +0100
Date: Thu, 16 Jan 2025 16:42:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
CC: <nekodevelopper@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, "Krzysztof Kozlowski"
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND v4 0/5] iio: accel: mc3230: add mount matrix, of
 match and mc3510c support
Message-ID: <20250116164211.000079d0@huawei.com>
In-Reply-To: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
References: <20250116-mainlining-mc3510c-v4-0-a41308b85ec2@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 16:52:41 +0300
Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org> wrote:

Always say why you are resending.

Jonathan

> Changes includes:
> - Add mount matrix handling
> - Add match table to work with DT
> - Add MC3510C support
> 
> MC3510C use same registors as MC3230, but different value scale.
> 
> Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> ---
> Changes in v4:
> - Fixed commit messages
> - Added const modificator to chip_infos
> - Return name->chip_id->product_code->scale order
> - `{}` replaced by `{ }` (with space)
> - Link to v3: https://lore.kernel.org/r/20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com
> 
> Changes in v2:
> - Ordered commits
> - Fixed comment style
> - Ordered struct members
> - Fixed device table
> - MC5310C commit splitted
> - Link to v1: https://lore.kernel.org/r/20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com
> 
> Changes in v3:
> - Fixed patch (poped stash)
> - Link to v2: https://lore.kernel.org/all/20250112-mainlining-mc3510c-v2-0-322804a545cf@gmail.com
> 
> ---
> Vasiliy Doylov (5):
>       dt-bindings: iio: accel: mc3230: document mc3510c
>       iio: accel: mc3230: add mount matrix support
>       iio: accel: mc3230: add OF match table
>       iio: accel: mc3230: add multiple devices support
>       iio: accel: mc3230: add mc3510c support
> 
>  .../devicetree/bindings/trivial-devices.yaml       |  2 +
>  drivers/iio/accel/mc3230.c                         | 95 ++++++++++++++++++----
>  2 files changed, 80 insertions(+), 17 deletions(-)
> ---
> base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
> change-id: 20250111-mainlining-mc3510c-564702fba487
> 
> Best regards,


