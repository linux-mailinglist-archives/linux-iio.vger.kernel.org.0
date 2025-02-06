Return-Path: <linux-iio+bounces-15072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CEA2A76E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 12:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B518F162C17
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923C2288EE;
	Thu,  6 Feb 2025 11:25:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9E20C473;
	Thu,  6 Feb 2025 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738841135; cv=none; b=UD+ShUcUZeKH4L9hcZp3LoZatR7aNoUn+hFf8wh4mJdTIRzUcNG6q9ailiZvsOmyYawh+gg5D5yIw8TEmMAU/AMW3cH5ieLDVqXqu6IN0Q/zdRCa9LsqYGDFGLL1yqLI2qAHZT29Yo28RiRzAyVbFMEcPveR09g/N5nsri6csVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738841135; c=relaxed/simple;
	bh=u8X0ml4wIaixcmWe/gklqLTQjMm8ZM1CyLHtSksZ8Nw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K3hnv9S6/bEauZGGDrzqI5+8cq/64gf+Co89heubSDiD5GMmKCz+dAP+fXY7eQ+Ph2TlNzZCmr7PWvzxsXpdIvXK2ISy34xy178gMvASffehcPObYACcQbE6DSrRXMOpix1CWOxp+dlU4ygYcduS1kf7g4Sjtiaih0VH5IaMkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpZTs6YKcz6H8VQ;
	Thu,  6 Feb 2025 19:23:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0247F140520;
	Thu,  6 Feb 2025 19:25:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Feb
 2025 12:25:30 +0100
Date: Thu, 6 Feb 2025 11:25:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Message-ID: <20250206112528.00005910@huawei.com>
In-Reply-To: <BE1P281MB2420B7C7A95A913B486A2228EFF42@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
	<20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
	<20241124124205.02453a0c@jic23-huawei>
	<BE1P281MB24209585E1552B80272D5448EFF52@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20250204144309.000043e6@huawei.com>
	<BE1P281MB2420B7C7A95A913B486A2228EFF42@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 15:50:18 +0000
"Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:

> Just one more question, as I've received a mail from the kernel test robot.
> It reported two warnings regarding following unused functions
> ads71x8_runtime_suspend() and ads71x8_runtime_resume().
> I guess this is due PM not being used necessarily. So do I still have to use
> #ifdef CONFIG_PM or what did I miss there?
> 
> static int ads71x8_runtime_suspend(struct device *dev)
> {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct ads71x8_data *data = iio_priv(indio_dev);
> 
>         return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
> }
> 
> static int ads71x8_runtime_resume(struct device *dev)
> {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct ads71x8_data *data = iio_priv(indio_dev);
> 
>         return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
> }
> 
> static const struct dev_pm_ops ads71x8_pm_ops = {
>         SET_RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume, NULL)

Using SET_RUNTIME_PM_OPS() breaks the chain of references. Use
RUNTIME_PM_OPS() instead.


> };
> 
> ....
> 
> static struct i2c_driver ads71x8_driver = {
>         .driver = {
>                 .name = "ads7138",
>                 .of_match_table = ads71x8_of_match,
>                 .pm = pm_ptr(&ads71x8_pm_ops),

>         },
>         .id_table = ads71x8_device_ids,
>         .probe = ads71x8_probe,
> };
> module_i2c_driver(ads71x8_driver);
> 
>


