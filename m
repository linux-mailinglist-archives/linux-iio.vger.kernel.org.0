Return-Path: <linux-iio+bounces-25391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65CC02BDC
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329D81A67C57
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894A34A3AA;
	Thu, 23 Oct 2025 17:34:25 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E51DE4CA;
	Thu, 23 Oct 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240865; cv=none; b=mZa3VBPRl9hHZqcX8UyWzy21KdcRCnRIgaR7B6J+4N8t7FvvBjq00gI9ZbetUgj+qWyrbs6ArYFq0dv7PUJVAqc6p9ZTUnOSuzLHgDJP9B3EJh8hfgad9vpmQ5LwSktc4HcqsWTIlAQqYJLyZII2zZUlIP3h4NFXpM56QYm5uV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240865; c=relaxed/simple;
	bh=M7MeJ/1kpjGvunS8dD0pgtr+cDcpOCcRe0kpByFiGi4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYdJLmGu8Y3jPeOjzbEIQAJ/ItrWf0nIvLTG9WnVdGsASLeHCk6DPLla0lGpZKOHoUrIequnfdh2t9FpnMDmZxpvjAMmL4k0eP0s6vFSNcp9rNfkjGjJwLd02EOZyoSoF46T7SDeNfeJnNpUcveqhjQagHgufdMkG6CdJCpxwlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cstNG24vHz6M4Qg;
	Fri, 24 Oct 2025 01:30:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 24358140279;
	Fri, 24 Oct 2025 01:34:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 18:34:19 +0100
Date: Thu, 23 Oct 2025 18:34:17 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
CC: <jic23@kernel.org>, <dlechner@baylibre.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <marcelo.schmitt1@gmail.com>, <vassilisamir@gmail.com>,
	<salah.triki@gmail.com>, <skhan@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <akhileshpatilvnit@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <20251023183417.00007d22@huawei.com>
In-Reply-To: <5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
	<5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 21 Oct 2025 11:20:30 +0530
Akhilesh Patil <akhilesh@ee.iitb.ac.in> wrote:

> Add driver for Aosong adp810 differential pressure and temperature sensor.
> This sensor provides an I2C interface for reading data.
> Calculate CRC of the data received using standard crc8 library to verify
> data integrity.
> 
> Tested on TI am62x sk board with sensor connected at i2c-2.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

A couple of trivial bits of follow up from me given you are going to be
doing a v4 for the stuff Andy picked up on.  Otherwise I'd just have
tweaked it whilst applying for these two.

> diff --git a/drivers/iio/pressure/adp810.c b/drivers/iio/pressure/adp810.c
> new file mode 100644
> index 000000000000..5fcb0447c628
> --- /dev/null
> +++ b/drivers/iio/pressure/adp810.c

> +/*
> + * Time taken in ms by sensor to do measurements after triggering.
> + * As per datasheet 10ms is sufficient but we define 30ms for better margin.
> + */
> +#define ADP810_MEASURE_LATENCY_MS	30
I'd just put this value in the one place that it is used and combine the two
comments on why it has this particular value.

30ms seems like a bit over the top for handling silicon variation etc.
Any background for the large margin?  If you've seen this as necessary
in practice then just state that - it's useful info to have available
to a future reader of the driver.


> +static const struct iio_info adp810_info = {
> +	.read_raw	= adp810_read_raw,
Trivial but there is no benefit in using a tab before the =

In general aligning this stuff isn't a good plan. It causes
a mass of churn in the long run as some of the callbacks have longer
names and suddenly whole thing needs reindenting.

> +};


