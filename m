Return-Path: <linux-iio+bounces-2753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D31DA859EE4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98010282F7C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5090222098;
	Mon, 19 Feb 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/4MvcTJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF8219E9;
	Mon, 19 Feb 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332931; cv=none; b=E6xX4aySifQYLapMv2qei0YpsapBU2LFpWkgf9tp0Y7HdMhKpxIXAEa8LasAwCptTe5Z7yxq7r0IlL8NJbo7bh3ztpUKL9bfztjKntI2ljwD2K+56bCXiXlyTrnBMQfsvnGcUFkioyd4suhfp/wGoS8HmgQ+o3r5PBvxpjEcCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332931; c=relaxed/simple;
	bh=zqg6XUNA5uCNc2gzaJvySB+FHdV/TldtpiLIVHMjJxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etDlkFF+UsGaYGmpbTnh4zDyCLD3ITIbCMzmWz4V0KM/QHHqhfGi+LaAHO4vUliGQ7Mp2XKMbrUH4mVtixztgOP7larIWG1xORH7YSn8hgbcKUdRewwMNOPU1ughvQDeq4JqpBmieZpzVuJe6DVvPcV9ZnyVlOPxRbiosmIsmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/4MvcTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD72C433C7;
	Mon, 19 Feb 2024 08:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708332930;
	bh=zqg6XUNA5uCNc2gzaJvySB+FHdV/TldtpiLIVHMjJxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x/4MvcTJEAMPhQ9OOHMuRoH3i3RLJberXB8WAwxX8/dpV6WVtL5KUCCFAvdcaARFZ
	 KdHqVxQsBv2AP3DpXDHdHlBWg1uvITDPpwau2268dawj/WzyVRQySB533MTUyYkRji
	 RddxgWIeaa4eCkFKCzlULIZhsfXtKpSfAWIgFgAc=
Date: Mon, 19 Feb 2024 09:55:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 01/15] device property: Move fwnode_handle_put() into
 property.h
Message-ID: <2024021920-spur-imminent-a8d8@gregkh>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-2-jic23@kernel.org>

On Sat, Feb 17, 2024 at 04:42:35PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By having this function as static inline in the header, the compiler
> is able to see if can optmize the call out if (IS_ERR_OR_NULL(fwnode))
> This will allow a simpler DEFINE_FREE() call in the following patch.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/base/property.c  | 14 --------------
>  include/linux/property.h | 14 +++++++++++++-
>  2 files changed, 13 insertions(+), 15 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

