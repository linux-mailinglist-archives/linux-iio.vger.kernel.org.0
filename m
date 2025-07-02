Return-Path: <linux-iio+bounces-21251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0DAF5D4C
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554A73B53FB
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044B2FF479;
	Wed,  2 Jul 2025 15:31:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECA2DCF54;
	Wed,  2 Jul 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470293; cv=none; b=umzcJMc/nUS8oIlAUqhBqnGeETAg1/07CmP0Zw8Sz2pXB141fKKNHHJ82fjQyCIhpyr2dFeYje7VngZigxfv2llIDqWCw/PkjBJ9C1vr9pZm66WaVkhPE2Gl06qG8MjoJLGy+FNm4WjdrHVrFrwMVju2bwjqXhB15ONSBj4iE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470293; c=relaxed/simple;
	bh=uen+p/SpnS8I1WQoDUDT9JW1oagT5qtNuCnGAgbM+E4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnOwQQ3YxycF3ey9Ga8rz8Nc77XWMQ//Q8h27Z1dSPP8DqaZ9eadfdojIsPLRxfzKgqKONgMoxehglcqk8G3p4jbzcCWhTqpmwSG0sQiu0Zk1cbBYToBSFo9qNXfEX7NbxcpWkegqou71NbDrKK4FY/I/CtgD82+YXeK40x2llY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXP1Z48Fjz6L54f;
	Wed,  2 Jul 2025 23:28:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2070814022E;
	Wed,  2 Jul 2025 23:31:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 17:31:27 +0200
Date: Wed, 2 Jul 2025 16:31:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Robert Budai <robert.budai@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: adis16550: rework clock range test
Message-ID: <20250702163126.000007ac@huawei.com>
In-Reply-To: <aGVNhIwn7CXO_lpP@smile.fi.intel.com>
References: <20250702-iio-imu-adis16550-rework-clock-range-test-v1-1-b45f3a3b0dc1@baylibre.com>
	<aGVIBVsFPcVw3lN6@smile.fi.intel.com>
	<aGVJPRmn1-HUBb40@smile.fi.intel.com>
	<3778ad13-3b62-4f68-946d-b861b0df4272@baylibre.com>
	<aGVNhIwn7CXO_lpP@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 18:17:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jul 02, 2025 at 10:07:17AM -0500, David Lechner wrote:
> > On 7/2/25 9:59 AM, Andy Shevchenko wrote:  
> > > On Wed, Jul 02, 2025 at 05:53:57PM +0300, Andy Shevchenko wrote:  
> > >> On Wed, Jul 02, 2025 at 09:27:45AM -0500, David Lechner wrote:  
> > >>> Rework the clock rate range test to test if sync_mode_data != NULL
> > >>> instead of testing if the for loop index variable. This makes it easier
> > >>> for static analyzers to see that we aren't using an uninitialized
> > >>> sync_mode_data [1].  
> > >>
> > >> But at the same time it makes it not to be the usual pattern.,,  
> > > 
> > > Reading the static analyser output I think the first hunk is only what we need,
> > > but this is still false positive and it's problem of that static
> > > analyser. Have you filed a bug there? (My point is that modifying the code for
> > > the advantage of false positives of some static analyser is wrong road to go
> > > in my opinion.)  
> > 
> > I agree that we shouldn't fix this _only_ to make the static analyzer
> > happy. But I had to think quite a bit harder to see that the existing
> > code was correct compared to what I have proposed here.
> > 
> > But if this is a common pattern that I just haven't learned to identify
> > at a glance yet and everybody else can easily see that the existing code
> > is correct, then perhaps it isn't worth the change.  
> 
> To me checking against index variable (when it's integer, obviously) is correct
> thing to do and regular pattern. OTOH, if the "index" is a pointer and rather
> we call it "iterator", the angle of view is different because in some cases
> it may lead to stale or invalid value which might be mistakenly dereferenced or
> speculated (see more in the discussion about list entry APIs [entry is a
> keyword here] and if list_entry_is_head() is a good approach.)
> 

Original code looks fine to me and is a very common pattern.  So I'd argue
the static analyzer needs some work.

Jonathan

