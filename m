Return-Path: <linux-iio+bounces-14929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCFA25EA5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1F21607F1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9F209677;
	Mon,  3 Feb 2025 15:27:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075C3595E;
	Mon,  3 Feb 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596468; cv=none; b=dXqN95Sud6fx7LGWp0aaH9zOxn9FUytbd4Bj2mNCHeA5/AuSDs2Zu5mYcBTpB60MVqtN1KMfTRlWkTojyONU+dpigaB+M5YKhenuUsQcRby3PgyKNlk0ZSDYdtyNEf4a36ji+DXk+/1vZeKtQFXDb1dfdSEyiyLdnpBdYsQKIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596468; c=relaxed/simple;
	bh=PkjBNBV7LR60VQqTVqvZrqT54nwB5Lgcu6zTZPUfQgw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAjx0bG5tMz2oHtQ0KiREGqthDDN8DNtwEPpO65E5IpjmgckoKxtjBQay3d58GawHDFfTrHAaHpm7AmInl84fUnVsidi2iMoFgWsi05SpShYtJEU0iP2NRF2K2+bvgcNqe6d204C1DsMxy2vfxAThuv5B8BBounFxZ+hrRLhzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymr0n1Y37z6D91w;
	Mon,  3 Feb 2025 23:25:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F8DC140B55;
	Mon,  3 Feb 2025 23:27:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 16:27:41 +0100
Date: Mon, 3 Feb 2025 15:27:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Antoni Pokusinski <apokusinski01@gmail.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: magnetometer: si7210: fix magnetic field
 measurement scale
Message-ID: <20250203152740.0000085e@huawei.com>
In-Reply-To: <Z6CLw5h5EwDGanl-@smile.fi.intel.com>
References: <20250202100709.143411-1-apokusinski01@gmail.com>
	<Z6CLw5h5EwDGanl-@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Feb 2025 11:26:27 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 02, 2025 at 11:07:10AM +0100, Antoni Pokusinski wrote:
> > Applying the current scale value to the raw magnetic field measurements
> > gives the result in mT.
> > 
> > Fix the scale by increasing it 10 times, so that the final result after
> > applying the scale is in Gauss.  
> 
> No objections against this change, just wondering since these are
> the ABI changes (correct?) how should we really handle them in case
> some of the user space stuff already relies on 'bad' values?
> 
If it's broken wrt to the published ABI (and hence what other sensors
are exporting) then not a whole lot we can do other than
backport the fix.  This is one of the few cases where ABI backwards
compatibility comes second :(

Jonathan



