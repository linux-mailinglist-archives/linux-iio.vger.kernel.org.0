Return-Path: <linux-iio+bounces-8978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6121696855A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C581C22CF9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD59140E3C;
	Mon,  2 Sep 2024 10:55:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242DD7347B
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274532; cv=none; b=OEDgOk0m1uiP52L+dH44rQGcgZpQTdN+ws2lvPow3IEiQ2+pbyqdrDYjslLMiG/p9+cYVekMUGZQOj4bYjeo4QtesNIURqN0ymR0FRe7dqZ+MD2O+SkNnfaugaTehAxin4n3eMx+krkPH9dH7rdaT9XePaJKJYJLTAPOLtUy8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274532; c=relaxed/simple;
	bh=KXXwkpG0+kTyK3vW+C3r2gCr6DNaLerGX3HPcFtTtPU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPvs8Wj0j9T6s+MPjE5xJQ8ok7nbY/l8ED2GzhuqmzNiiQnGCvMez1mh7iTqr50TRPx3Yr/wJtWLxUBxyLCKCudClnohH6+THUVg0NQ6cPFLSOkrZtAB9m29cX4oaqU2Qh10uXCbnLcSpUtSTrV1BqHOTdq/T1FVCvD0J96iZe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wy4nG6cHTz6K6Q2;
	Mon,  2 Sep 2024 18:32:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DADD1406AE;
	Mon,  2 Sep 2024 18:36:20 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 11:36:20 +0100
Date: Mon, 2 Sep 2024 11:36:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Revert patch 1908f13c4682 ("iio: imu: inv_mpu6060: Remove
 duplicata code between labels")
Message-ID: <20240902113619.00005b83@Huawei.com>
In-Reply-To: <FR3P281MB1757E9B87D66EAB2512027E0CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <FR3P281MB1757E9B87D66EAB2512027E0CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 2 Sep 2024 10:19:52 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
> 
> accepted patch 1908f13c4682 ("iio: imu: inv_mpu6050: Remove duplicata code between labels") is breaking inv_mpu6050 interrupt handling, forcing call of inv_reset_fifo() for each interrupt processing.
> 
> Can you revert it inside testing branch? Is there a specific standardize way of asking to revert patch or is it OK like this?
> 
> Thanks.
> 
> Best regards,
> JB
> 

This is fine. I'll do it when on right machine later today.

Jonathan

