Return-Path: <linux-iio+bounces-1052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FA816AB0
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 11:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E0A1F233C9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FE213AE0;
	Mon, 18 Dec 2023 10:13:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD41156D2;
	Mon, 18 Dec 2023 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4StwbF6tvVz6JB3x;
	Mon, 18 Dec 2023 18:11:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D913140C9C;
	Mon, 18 Dec 2023 18:12:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Dec
 2023 10:12:50 +0000
Date: Mon, 18 Dec 2023 10:12:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: <jikos@kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
	<Basavaraj.Natikar@amd.com>, <linux-input@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<gregkh@linxuxfoundation.org>
Subject: Re: [PATCH 0/2] Fix regression in ALS
Message-ID: <20231218101249.00007aab@Huawei.com>
In-Reply-To: <20231217200703.719876-1-srinivas.pandruvada@linux.intel.com>
References: <20231217200703.719876-1-srinivas.pandruvada@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 17 Dec 2023 12:07:01 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Addition of color temperature and chromaticity support breaks ALS sensor
> on several platforms. Till we have a good solution, revert these commits
> for 6.7 cycle.
> 
> Srinivas Pandruvada (2):
>   Revert "iio: hid-sensor-als: Add light chromaticity support"
>   Revert "iio: hid-sensor-als: Add light color temperature support"
> 
>  drivers/iio/light/hid-sensor-als.c | 100 +----------------------------
>  include/linux/hid-sensor-ids.h     |   4 --
>  2 files changed, 2 insertions(+), 102 deletions(-)

+CC Greg KH.

Hi Greg,

This is a regression fix that I'd like to get in asap. Currently light sensors
on a wide range of laptops are broken.  I was hoping we'd fix the the problem
rather than need to revert, but time is running out so revert it is.

I don't have anything else that needs to be rushed in before the merge cycle,
so if you are happy to pick these two reverts directly that would be great.

Message ID of the cover letter is

20231217200703.719876-1-srinivas.pandruvada@linux.intel.com

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If not I should be able to do a pull request in next couple of days
with these in.

Thanks,

Jonathan


> 


