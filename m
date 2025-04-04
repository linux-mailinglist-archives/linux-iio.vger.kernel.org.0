Return-Path: <linux-iio+bounces-17609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7CA7BB9C
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 13:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04920189EAC5
	for <lists+linux-iio@lfdr.de>; Fri,  4 Apr 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204F1DDC12;
	Fri,  4 Apr 2025 11:33:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1561DB34C;
	Fri,  4 Apr 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766395; cv=none; b=CnxsDhqSz6tdO3fRvpM0cK1YcM0YwhF8p4rfkoErnopFxagZHw37qWLlYpzHRT6/ppTMHfU+Vbu0rZPJmPfiAkndvjBurbs7lWH2ZuKxt9sguVqLzwDEN/h6CuAMu1ZhTk8vx9jRIQZttstkCWHM+Tb1LlODKLtZfllec5QfM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766395; c=relaxed/simple;
	bh=Vr/dgQUKtxPOzkS4b3b681oYLIy6EF0mAL1Hy8UKmKY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6XxYKGHbpYsRuHbX60xzyHeoeU9opOXRd3zgG3KFWjYGvv1MVocuahdbcZYAD7sujNyF6MsQRcAe01OOrEiJdyOVOofLCOkfAL1aAS1wL6ri5J3LACp2Bv6d6Dq6PgYG1xNDR2iEnUDPCPIbVkn40zuzas/6NAD+SPBBitHVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTc0D23XVz6L4wP;
	Fri,  4 Apr 2025 19:32:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C25B1400D3;
	Fri,  4 Apr 2025 19:33:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 13:33:09 +0200
Date: Fri, 4 Apr 2025 12:33:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gyeyoung Baek <gye976@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <lars@metafoo.de>, <gustavograzs@gmail.com>,
	<javier.carrasco.cruz@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
Message-ID: <20250404123308.00003d72@huawei.com>
In-Reply-To: <20250403053225.298308-4-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
	<20250403053225.298308-4-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Apr 2025 14:32:23 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Add support for winsen MHZ19B CO2 sensor.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> new file mode 100644
> index 000000000000..6cdfd34be016
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
> @@ -0,0 +1,7 @@
> +What:		/sys/bus/iio/devices/co2_range
> +Date:		April 2025
> +KernelVersion:	6.14
> +Contact:	Gyeyoung Baek <gye976@gmail.com>
> +Description:
> +		Writing a value adjust maximum measurable PPM.
> +		should be 2000 or 5000.

I haven't checked but assume this also results in a scaling of the
measure _raw values?  If so the control should be via the standard
ABI scale.  If you need to be able to establish the range, provide
the _available for the _raw via the read_avail() callback and setting
appropriate bit in info_mask_separate_available

General rule is don't introduce new ABI unless it is impossible to
provide the same information via existing interfaces.  The decision
to use scale rather than range info to control channel scaling was
made a very long time ago and having a mixture of the two would
make for very complex userspace code.

Jonathan

> --
> 2.34.1
> 
> 


