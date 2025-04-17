Return-Path: <linux-iio+bounces-18230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C945DA92452
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B80D7B0DBC
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88101255E23;
	Thu, 17 Apr 2025 17:47:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4E253F22;
	Thu, 17 Apr 2025 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912042; cv=none; b=nUxRPSK0Tj9DXc9gZSS72PLIP+qPmBB3lzjMbQQ/KCyqI8BQE5+tthicpb931l2CiX64ViQ6hNyNo1KfT4IK20/s7aC9DuKt5vKahsynvxT+MvxWdseiOx7bOsvalo5i40IM+ELTXIPONOw9a5NqNXcbP47ClrcZd2wr45capTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912042; c=relaxed/simple;
	bh=5qo+VPB/EKYB6hrGuVBZ8BV0lAvEX2S3qjmRBMfbL0Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieZeRXWFzTkPygwMrK4ILqiAUURSrFjV7Gx20lVLJLz9su1KJB4raP7n4185qg9hSaH4O+98/5zzb8LOGiGBxkpvbUEunLNeBxlKeC+oEeQCeYaCpJBRLLAhPIKfgxhCxfDW7X4ENwiq1/LUQgZAYeJM93b2QO9TD+DPWMMoFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zdlg51YQyz6L57h;
	Fri, 18 Apr 2025 01:45:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 297C8140146;
	Fri, 18 Apr 2025 01:47:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:47:17 +0200
Date: Thu, 17 Apr 2025 18:47:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Cosmin
 Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
Message-ID: <20250417184716.000044bb@huawei.com>
In-Reply-To: <aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 20:01:13 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Apr 17, 2025 at 11:52:32AM -0500, David Lechner wrote:
> > Wile reviewing [1], I noticed a few more cases where we can use
> > aligned_s64 or need __aligned(8) on data structures used with
> > iio_push_to_buffers_with_timestamp().
> > 
> > [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/  
> 
> 
> Link: URL [1] :-)
In a cover letter? Not sure we care.  In general agree though.
> 
> This will help to maintainer with b4 as it manages tags.
> 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
Also no need to sign off on cover letters as they don't end up in git.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> for non-commented patches.
> 


