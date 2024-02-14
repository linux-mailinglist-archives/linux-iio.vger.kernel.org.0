Return-Path: <linux-iio+bounces-2556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBC854DF5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 17:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA348B267D4
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7A60254;
	Wed, 14 Feb 2024 16:19:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6525A604B6
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927571; cv=none; b=BZk99YZnUL7/90qAKSQTKqX1pMId2DNoBkf0UaqUGq2XSvL+FTa84AZeBT/QAqAJvKgTPtVU/PgzZe/QA6g4094QmkLPhctsNRnyk2Q88hFP/QvkLNixfXR5untqIPw72HVmekw6vp6PyvT9yAgunvtnpCXsXzFij4Kd2P95ma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927571; c=relaxed/simple;
	bh=GiAlKhuq8XPI2BSRQaWIq5YYyvZjWtln7PjSywDkHZ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAhNVKmfCM0LG8c77/0/4s4eGtY/0skbPJZdQeCh3dzXpap0BhpjTTLHw/BcaTIqUaJthS8/nyD9X9+qmbx+nmQbl0FuXztg58v6rTDYL/+J3mPR54trQlLRg2aXDEwmu+aJZycSDylZmMo2aUOsG+l1RMissGH7Q81NM1T4Gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZjww4Qd1z6K8qR;
	Thu, 15 Feb 2024 00:16:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B7E1140B55;
	Thu, 15 Feb 2024 00:19:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:19:26 +0000
Date: Wed, 14 Feb 2024 16:19:25 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jonathan LoBue <jlobue10@gmail.com>
CC: <andy.shevchenko@gmail.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <jic23@kernel.org>,
	<jagathjog1996@gmail.com>, <luke@ljones.dev>, <benato.denis96@gmail.com>,
	<linux-iio@vger.kernel.org>, <lkml@antheas.dev>, <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match
 Table
Message-ID: <20240214161925.00001986@Huawei.com>
In-Reply-To: <20240213223910.27127-1-jlobue10@gmail.com>
References: <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
	<20240213223910.27127-1-jlobue10@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Feb 2024 14:39:10 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

> This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
> driver with an ACPI match of "BOSC0200".
> 
> Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>

Take another look at how to use Co-developed in submitting-patches.rst
there are examples - key is that the author (From: in the email)
does not have a Co-developed-by line.

> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
> 
> Formatting fixes, removed duplicate header, and removed ACPI_PTR
> from previous submission.
> 
> Added an explanation of the duplicate ACPI identifier issue between
> devices using bmc150 and bmi323.
> 
>  drivers/iio/imu/bmi323/bmi323_i2c.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 20a8001b9956..22826a2efc6f 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -93,6 +93,25 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
>  	return bmi323_core_probe(dev);
>  }
>  
> +/*
> + * The "BOSC0200" ACPI identifier used here in the bmi323 driver is not
> + * unique to bmi323 devices. The same "BOSC0200" identifier is found in
> + * devices using the bmc150 chip. This creates a conflict with duplicate
> + * ACPI identifiers which multiple drivers want to use. If a non-bmi323
> + * device starts to load with this "BOSC0200" ACPI match here, then the
> + * chip id check portion should fail and the driver should relinquish the
> + * device. If and when a different driver (such as bmc150) starts to load
> + * with the "BOSC0200" ACPI match, a short reset should ensure that the
> + * device is not in a bad state during that driver initialization. This
> + * device reset does occur in both the bmi323 and bmc150 init sequences.
> + */
> +
> +static const struct acpi_device_id bmi323_acpi_match[] = {
> +	{ "BOSC0200" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
> +
>  static const struct i2c_device_id bmi323_i2c_ids[] = {
>  	{ "bmi323" },
>  	{ }
> @@ -109,6 +128,7 @@ static struct i2c_driver bmi323_i2c_driver = {
>  	.driver = {
>  		.name = "bmi323",
>  		.of_match_table = bmi323_of_i2c_match,
> +		.acpi_match_table = bmi323_acpi_match,
>  	},
>  	.probe = bmi323_i2c_probe,
>  	.id_table = bmi323_i2c_ids,


