Return-Path: <linux-iio+bounces-11560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E49B45E9
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 10:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196031F23666
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789E204928;
	Tue, 29 Oct 2024 09:43:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C815203708;
	Tue, 29 Oct 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195038; cv=none; b=jolZ0PHsrYzf0XEbJOPIwWlChQAdelWfFli2g2nPJfvvs1RQrP1C3zitrJI/sFothEuBeNeZ4Wqtwvk9JplyHwMg50sN3PzkaJyEczBt0F2Ur5ABPiF+2/BBqGJnGTmlGqrjLmo/faK17b+LHRmWId+pRMdckfz2cf47ZEKe9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195038; c=relaxed/simple;
	bh=DsAJW7VXDhepK48DnllqrO0eBSbIW23+oTWO3Yaj/Pw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOyQMIxmnkNOqjqnTm6727iQznUQ15eWJwMey5XDBtdopiKdrYjFp+INJWWv2kkSiHlCvVWf6L/AdoWKga1d/jLpz8QPyr1axkomRTOnpRdAppL9gqyNMcV/N0+s0nVuWpV0odzu3HvHA36VgEWKzsQJgGcqmJ4KYLSZufpg70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xd4vp1T8kz6LDCd;
	Tue, 29 Oct 2024 17:39:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A31FC1404F5;
	Tue, 29 Oct 2024 17:43:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Oct
 2024 10:43:51 +0100
Date: Tue, 29 Oct 2024 09:43:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Matteo Martelli <matteomartelli3@gmail.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>, <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the iio tree
Message-ID: <20241029094349.00001186@Huawei.com>
In-Reply-To: <20241029155022.5f777572@canb.auug.org.au>
References: <20241029155022.5f777572@canb.auug.org.au>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Oct 2024 15:50:22 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the iio tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> include/linux/iio/iio.h:555: warning: Function parameter or struct member 'read_avail_release_resource' not described in 'iio_info'
> 
> Introduced by commit
> 
>   8a63e3033e72 ("iio: core: add read_avail_release_resource callback to fix race")
> 

Thanks.  Sorry for number of times I've missed things this cycle!

Will fix this up when on right machine.  Matteo, feel free to send a
patch if you have time, if not I'll make something suitable up.

Jonathan

