Return-Path: <linux-iio+bounces-23136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24EB313F6
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F2C640E13
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5332FB624;
	Fri, 22 Aug 2025 09:37:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD272F363F;
	Fri, 22 Aug 2025 09:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855452; cv=none; b=LmgeD79Tyt5bD+XpzkBwWqPVXDMgZUywF6Cr6gcqoIMSkuUNJpvuM2tJ86+IqJJOVeA/F/QFjAEj4He54XHvr/8oJeH3jPZE4DrvOO3ZqxNPxR145ptpCypJ9xnQK1owBVGhPHDyIGIDHWOyBrYHUB4+w4O1S+Xszw8Go8keRbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855452; c=relaxed/simple;
	bh=3kcuEqpYRVjS3cb7eMChzGnsx02O1gIRPccfxeniL38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Enq4r8lbIzvuQsYcAN18lAoIXbfnRAaswMeg1XJNfHlXRqDcQI14uiBd8knE3Nfhewa7Klsq+czgKxjzIfLwILzMqgqaZc4BgrX7WljUIKLUfynsqu6CZFWDJgm3lEWqcSr5VKfKmi0hBsIdS4zmngfpJJWZpWnjOZ2x9sbyWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c7ZpP111Jz6L5hS;
	Fri, 22 Aug 2025 17:37:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AD1F71402A4;
	Fri, 22 Aug 2025 17:37:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 22 Aug
 2025 11:37:19 +0200
Date: Fri, 22 Aug 2025 10:37:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Xing Guo <higuoxing@gmail.com>
CC: <sfr@canb.auug.org.au>, <l.rubusch@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>,
	<shuah@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] docs: iio: Fix unexpected indentation for adxl345.
Message-ID: <20250822103718.000062e1@huawei.com>
In-Reply-To: <20250819065634.1154322-1-higuoxing@gmail.com>
References: <20250818124124.5b978e64@canb.auug.org.au>
	<20250819065634.1154322-1-higuoxing@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 19 Aug 2025 14:56:34 +0800
Xing Guo <higuoxing@gmail.com> wrote:

> Resolved the following building error:
> 
>  Documentation/iio/adxl345.rst:161: ERROR: Unexpected indentation. [docutils]
> 
> Fixes: fdcb9cb9178a ("docs: iio: add documentation for adxl345 driver")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250818124124.5b978e64@canb.auug.org.au
> Signed-off-by: Xing Guo <higuoxing@gmail.com>

+CC linux-iio.

> ---
>  Documentation/iio/adxl345.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
> index 4bd038cb4a37..afdb35f8b72e 100644
> --- a/Documentation/iio/adxl345.rst
> +++ b/Documentation/iio/adxl345.rst
> @@ -157,6 +157,7 @@ sensor terms, free-fall is defined using an inactivity period ranging from 0.000
>  to 1.000 seconds.
>  
>  The driver behaves as follows:
> +
>  * If the configured inactivity period is 1 second or more, the driver uses the
>    sensor's inactivity register. This allows the event to be linked with
>    activity detection, use auto-sleep, and be either AC- or DC-coupled.


