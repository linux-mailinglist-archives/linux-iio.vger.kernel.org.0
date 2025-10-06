Return-Path: <linux-iio+bounces-24773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82EBBDD18
	for <lists+linux-iio@lfdr.de>; Mon, 06 Oct 2025 12:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 901F44EC832
	for <lists+linux-iio@lfdr.de>; Mon,  6 Oct 2025 10:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD10262FC0;
	Mon,  6 Oct 2025 10:58:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106325F994
	for <linux-iio@vger.kernel.org>; Mon,  6 Oct 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748281; cv=none; b=WYJ+U1s54nfncKW/5G9jdecmIdvtWZZdCBygi8aaMZL+WzWo//PQ19MtbG7LSWfz3Ct1mhi9ycEo+gXTqZ6lehX98EHasGseiP4Durlqdxikk3b5fu+eqm8K2BMPuOVSkcbURGskxZ1QDtoXydnBJioAGMKVmyIcgG1En8gPqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748281; c=relaxed/simple;
	bh=g5O5csoWNz19IFgWxCFkEFL5Dfc3iD8CKF4fBZ/i4ZU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myhikOrGeij+xb9qE+Asaw2/FOBolsj3UITACKT8CvDJKKWObNGeH46QGp08j3X5pDhDxZ1NtZQCl8f+FEBMW+eamyxo+3/bDzxSCmKbxmq4f38LsfwDcEgN4pSgo6UF/FfCBHQlfNW0xmQtxkGikF3PMQahVRfp5ownLYUFaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgGSN2vMrz67Cx4;
	Mon,  6 Oct 2025 18:57:24 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C61014038F;
	Mon,  6 Oct 2025 18:57:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 6 Oct
 2025 11:57:56 +0100
Date: Mon, 6 Oct 2025 11:57:54 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Taimoor Zaeem <taimoorzaeem@gmail.com>, <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-staging@lists.linux.dev>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH] staging: iio: ad9832: move ad9832_platform_data into
 include/linux/lib
Message-ID: <20251006115754.00006876@huawei.com>
In-Reply-To: <2025100548-stereo-patronage-408a@gregkh>
References: <20251005121829.175943-1-taimoorzaeem@gmail.com>
	<2025100548-stereo-patronage-408a@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sun, 5 Oct 2025 16:00:33 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Oct 05, 2025 at 05:18:29PM +0500, Taimoor Zaeem wrote:
> > Move struct ad9832_platform_data from
> > drivers/staging/iio/frequency/ad9832.h to
> > include/linux/iio/frequency/ad9832.h.
> > 
> > This clears a TODO item in the drivers.  
> 
> No, this should only happen when the whole driver moves out of
> drivers/staging/, staging drivers shoul dbe self-contained.
> 
> Also, why is a .h file needed for just one file anyway?  Shouldn't this
> be part of the .c file instead?

It's an old school board file / platform data definition.

So it would be fine to get rid of that entirely and move the
driver to appropriate modern firmware interfaces but if we keep the
struct definition it doesn't make sense to move it into the C file.

I'm edging closer to just posting a series to get rid of these
remaining IIO drivers in staging, but normally I've only done that
when the parts have gone out of production as until that point it
seems reasonable that they might eventually get cleaned up, ABI
fixed etc and the costs of keeping them around are low.

Nuno, can you see if you can get a view from ADI on whether there
will ever be any effort to sort these ancient drivers out?
I appreciate that may be challenging to answer though.

Jonathan

> 
> thanks,
> 
> greg k-h
> 


