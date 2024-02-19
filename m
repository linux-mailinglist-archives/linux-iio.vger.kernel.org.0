Return-Path: <linux-iio+bounces-2754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF18859EE7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919C41C2235C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31321A1C;
	Mon, 19 Feb 2024 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJR+CuBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D8224D0;
	Mon, 19 Feb 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332946; cv=none; b=aeWpPCaUZDypEke9l5azV4LO2QqmtaAakM6rV5cgBaEp3Gtz9T/fDn2UN6dlSXb40CRN1YfT3GLWdRGLxeyzqzyXmVeBonEfQKXZVZsUsBXmrvjHL8txXn9Ov0H3A5dN0bnpMd7yEkp0cxOEn61MpYATqEB3+7ybJWqQIuZ5Uhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332946; c=relaxed/simple;
	bh=iZyE6mDMItXp/g8OWbo2PWWIAJxgZ1dQzrAfvd+Kpz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6dwMm3OljEMdj/Z5VMHI0aEgwTp08DWW8aH4MYLd+5rma8zA8esZZ/ZvNvNXWMGiJDNsNPcGWuSs6uTM1YkYOFB7cFpYUYz7+iflMOxbphgC/G44nQFhn2B/igYk6BdY09xUR/LCj3rDVegzHqas58JyBH9N7AdUBO2B5pOlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJR+CuBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E131DC433C7;
	Mon, 19 Feb 2024 08:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708332945;
	bh=iZyE6mDMItXp/g8OWbo2PWWIAJxgZ1dQzrAfvd+Kpz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJR+CuBpVOIu3oKv44D3dgnBsBIt607IYAGAAp2B1DK/W5Mylo4XR3czgc52kYjf0
	 43rCQ1omJw82ESr9t3GgYQGEn9nFSW3ZAsfRSXxTfLnTFQxV5aecBgHDDZHPbNx3tJ
	 FTxtIz0KymuOHEG4IBWfFJG9exlkvbgAa7nye5mM=
Date: Mon, 19 Feb 2024 09:55:42 +0100
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
Subject: Re: [PATCH v4 02/15] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <2024021935-stylized-pushpin-367a@gregkh>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-3-jic23@kernel.org>

On Sat, Feb 17, 2024 at 04:42:36PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Useful where the fwnode_handle was obtained from a call such as
> fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
> and will automatically release the reference on the variable leaving
> scope.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/property.h | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

