Return-Path: <linux-iio+bounces-7837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DF93B10C
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 14:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD49A1C220DD
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 12:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3000156F2C;
	Wed, 24 Jul 2024 12:48:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C41E488
	for <linux-iio@vger.kernel.org>; Wed, 24 Jul 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825329; cv=none; b=aolJ5t9VjCSoFy9FWrbLnMZzkdrBFiZc/AnRxGsAfJgjPgtA98+/BAN8Iim4f3aQUSKDqmXfbyOto/GHWoM1fWhwgAAAEj2zJNAh0ruX/EDZBAjBrI6KIMxZ0UlwPbhBKUtc/4wH4w/r2p8ZW5WcY78CvCU8KOxFCWKWKS50AFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825329; c=relaxed/simple;
	bh=vJAFGE4IZ1t4tIlZrOlykUAe+fdrWrIEnA/DjD3a8Cw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnMkotzlyLLxwkM9MOaXbXDWh9Gssx2iGK8PwMgQ9wgVL5xBUlF5IIptu174RxGrewVjxo/HrH5RBXRkmjP/nh8XthSvbwu0GqpkCAM6q+tJXwQO3fOGRppkT7bw57DqCQPRjEeQPc15+tGk2J5WGhaYOQaRZ0SljiyK3gkhIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WTYfg1XnTz6K9RZ;
	Wed, 24 Jul 2024 20:46:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C4C0F140B67;
	Wed, 24 Jul 2024 20:48:43 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 24 Jul
 2024 13:48:43 +0100
Date: Wed, 24 Jul 2024 13:48:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Akash Borde <Akash.Borde@heilatech.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Emily Guthrie
	<Emily.Guthrie@heilatech.com>, Erika Silva <Erika.Silva@heilatech.com>, Bart
 Oegema <bart.oegema@heilatech.com>
Subject: Re: [ti-dac5571] Checking compatibility of TI DAC with kernel
 driver
Message-ID: <20240724134842.00001c29@Huawei.com>
In-Reply-To: <1261F7BA-D202-4BED-ADB4-87EB75E2C068@heilatech.com>
References: <1261F7BA-D202-4BED-ADB4-87EB75E2C068@heilatech.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 23 Jul 2024 23:07:19 +0000
Akash Borde <Akash.Borde@heilatech.com> wrote:

> Hi,
> 
> I'd like to see if the TI DAC8563 is potentially compatible with this existing device driver in the main branch of the kernel.
> 
> This is the part I'm evaluating for my board: https://www.ti.com/lit/ds/symlink/dac8563.pdf 
> Here is the most similar kernel driver I could find: https://github.com/torvalds/linux/blob/master/drivers/iio/dac/ti-dac5571.c
> 
> I see very similar DACs in the compatible list of this driver, but not the exact part number family that I'm looking for.
> Is there a way to verify a DAC or family of DACs' compatibility with existing drivers?
Sadly best bet is to open the datasheets side by side and verify if the
devices are compatible in all software visible ways.

It's a pain to do but only way to know if it will continue to be compatible
in the future if new driver features are added.

Jonathan

> 
> Thanks!
> 
> Akash Borde | Embedded Systems | Heila Technologies
> https://heilatech.com/
> 


