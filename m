Return-Path: <linux-iio+bounces-5089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0538C8734
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD4B227A7
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 13:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F956548F2;
	Fri, 17 May 2024 13:28:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4941213;
	Fri, 17 May 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715952496; cv=none; b=nqig3ee6Gh1SVyoRv8RoORix6ym5A0KSWpt6/Bncq7x9zSqReJap3yYhYQRh7DjGALgL94SHsoChiXnKKbEunpnwepNZ2w+S0LBIYS9z4aAR0ddY9vJ7Z3Xd0EjYmXwDpXsLw9dtXFc/v7QmGXMU73DwEq7Hd4GD2mmGG6UW0aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715952496; c=relaxed/simple;
	bh=uwBwO3Fqyp5mCPqAOfpmhA3/Ak9Db7EdwQG7JCiMf4U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMXqXTvZtX3BKLlP3fXNCUaY4jrwpt276BOBtD4wiZfiBmK5gV9ITlNTLTVim2Hrng67gIH6Tx+9t1JPjMiLCIrhTIb0ebOOVxOK09lJBVi4hqY+7g3EUouGceCnJNBZxd1upFqMEYkZRpDJty8zvhZ0EZx0Uk8bOY+PG28MO0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VgnkL5RLlz6JB8B;
	Fri, 17 May 2024 21:24:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 73AE51400D9;
	Fri, 17 May 2024 21:28:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 May
 2024 14:28:07 +0100
Date: Fri, 17 May 2024 14:28:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add threshold events support
Message-ID: <20240517142807.00005b90@Huawei.com>
In-Reply-To: <20240517081050.168698-1-dima.fedrau@gmail.com>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 17 May 2024 10:10:48 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Add patch for providing index for both channels and add patch for threshold
> events support for the MCP9600 device.

Always mention subsystem and device in the cover letter title!

iio: temperature mcp9600: Add threshold events support.

Makes it easier for people to judge if they want to read a thread or not.

No need to resend for this though.
> 
> Changes in V2:
>   - Remove pretty printing patches from series
>   - Add patch for providing index for both channels(ABI change)!
>     Suggested by Jonathan, hope this okay.
>   - Remove formatting in a precursor patch
>   - Add lock documentation
>   - Add define MCP9600_TEMP_SCALE_NUM and use it instead of MICRO. MICRO is
>     type unsigned long which we have to cast to int when using
>     multiplication or division, because we are handling negative values.
>   - Use switch statement in mcp9600_write_thresh
>   - Replaced generic interrupt handler with four separate interrupt handler
>   - Use one lock instead of four
>   - Added error check for mcp9600_probe_alerts
>      
> 
> Dimitri Fedrau (2):
>   iio: temperature: mcp9600: Provide index for both channels
>   iio: temperature: mcp9600: add threshold events support
> 
>  drivers/iio/temperature/mcp9600.c | 398 +++++++++++++++++++++++++++++-
>  1 file changed, 396 insertions(+), 2 deletions(-)
> 


