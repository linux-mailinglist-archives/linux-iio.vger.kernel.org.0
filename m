Return-Path: <linux-iio+bounces-18229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA8EA92448
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D3A3B2596
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E2255E34;
	Thu, 17 Apr 2025 17:46:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146D724111D;
	Thu, 17 Apr 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911987; cv=none; b=eZc7vAbKa7nL0B1QMwmWjZ4f0coycVaRkhnIcCdpqnXxFHLdKcqF4FjPr1yGz3pBxTqKbG2/qDJlDgI5ta9ZTR8FVLkCz1+ZNYW4sCxaDWKqu1N4Z3OfgDPZwjA5oum0Nl9cd6jeyJkTCCewh5NAdBwiEqYzMerhccaPUnPLulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911987; c=relaxed/simple;
	bh=46ukvaYcdhyKDeXS4wk7tC3dQ01qf4FGv/IJfYCeBMs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPjxPy6OWzzcIK8KrvVe759WrwGLvFSTEjfL0xHrP6dghfJA8nQAWBAvnyWqyz+388SkIurcfUxUhkeVCS7ATDVQTcyAp8K/CXA1zFN6yxn6T7aDpnKStfuZlnMSWHpay44N5thy6QUZT9YLFUC+pgjZtTsV4eU9KNZN/RR+vW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zdlf138pWz6L53m;
	Fri, 18 Apr 2025 01:44:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6369D140121;
	Fri, 18 Apr 2025 01:46:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:46:21 +0200
Date: Thu, 17 Apr 2025 18:46:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Cosmin
 Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Message-ID: <20250417184620.00006ae6@huawei.com>
In-Reply-To: <aAEzlZoZTsQuWgZa@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
	<aAEzlZoZTsQuWgZa@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 20:00:05 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Apr 17, 2025 at 11:52:39AM -0500, David Lechner wrote:
> > Align the buffer used with iio_push_to_buffers_with_timestamp() to
> > ensure the s64 timestamp is aligned to 8 bytes.  
> 
> Same question as per previous patch.
> 
In this case I don't think we know the position of the timestamp
so a structure would be misleading.

The comment above the define certainly suggests it is variable..

/*
 * Maximum of 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8.
 * May be less if fewer channels are enabled, as long as the timestamp
 * remains 8 byte aligned
 */
#define INV_MPU6050_OUTPUT_DATA_SIZE         32

