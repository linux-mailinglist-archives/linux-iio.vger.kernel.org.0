Return-Path: <linux-iio+bounces-14739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78953A23217
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5591886083
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8C1EE7C6;
	Thu, 30 Jan 2025 16:39:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F441EE7A9;
	Thu, 30 Jan 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738255169; cv=none; b=gKSa/6Lb8N72n4S6+pHauSl+xnuK/8lhQswstAbMwXHEQqG/5111SW+qFj6I9JKE1BTRV4gI4Jk/Tstf2eij2TEzs111HCvJLisJ8KdF2E3LhktKLz/kbYmBqQ8ziUuU5A//AQv3ZCfolYSDsrIchXqqHuMh9JKMkqw193mtfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738255169; c=relaxed/simple;
	bh=lZtC4Lc23dSRCtsEwOTdpA3Hd5pDYnUIvll+PCOUi8o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G12PgOfGQjmVPPBVId3RHynW0ULjK5xnG1LQuVSijYtVTZXuuEJNqV6huhnZSE5VtBctho5htHvS3KzCiCV7pJ/9SjGU2gfNYEBo3EDxOAlQMIg5jNsGf+rFvvcuHoLsMVcMq2Z3TNGN/o0HrTeSng5XCutZyRxIoU1VmP5QPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkPnF6Z1hz67fvj;
	Fri, 31 Jan 2025 00:37:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 520C81403A8;
	Fri, 31 Jan 2025 00:39:25 +0800 (CST)
Received: from localhost (10.195.245.124) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 17:39:24 +0100
Date: Thu, 30 Jan 2025 16:39:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
	<jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
	PopPaul2021 <paul.pop@analog.com>
Subject: Re: [PATCH v2 15/16] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250130163923.00005191@huawei.com>
In-Reply-To: <3a5684280e86df1e2cc2c9be291fa2807aa6cb02.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<3a5684280e86df1e2cc2c9be291fa2807aa6cb02.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 27 Jan 2025 12:14:19 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables SINC3 and WIDEBAND
> filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features.
> 
> Co-developed-by: PopPaul2021 <paul.pop@analog.com>
> Signed-off-by: PopPaul2021 <paul.pop@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
On trivial thing I noticed.

> @@ -745,6 +1000,12 @@ static int ad7768_setup(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> +	/*
> +	 * Set Default Digital Filter configuration:
> +	 * SINC5 filter with x32 Decimation rate
> +	 */
> +	ret = ad7768_configure_dig_fil(indio_dev, SINC5, 32);
Check ret?
> +
>  	/* Set the default sampling frequency to 32000 kSPS */
>  	return ad7768_set_freq(st, 32000);
>  }


