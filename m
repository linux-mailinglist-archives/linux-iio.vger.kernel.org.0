Return-Path: <linux-iio+bounces-2755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDE859EE9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 09:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720D01F210F8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592332209F;
	Mon, 19 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZZXbLcKB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2C721379;
	Mon, 19 Feb 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332976; cv=none; b=lLbA9OAg8dzZjfwtCTss/NG1RCFz8nbBJVGiObaYFkmvVEE08DingAXy5c+dQkKXiHWExuYKXrthUYBBGdhXqOY7Qr8ITIBTyGqbwnmnQDCUlCwv6YQgJhPo+fWku3oRhBFb/C6GV2iw9K3c+9FIS8Gvc3kO17seZs9+hfAK3o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332976; c=relaxed/simple;
	bh=YD+bqENRjvWndB/bUJ3EJXYmwpBACeWizdmGMxxvVR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YniixCgOl3YTIKddIOwXP9J7H7/qjxWCsHMnjnvL+GMs2sIoBP0dI1Ap4h+eyE4wZ8OYAa8af0x1s2Eit7/iU6za2CZdnQeu8dgLKHwxCAeWpmF5uKdB6A5DCm1AQ8qC+JktRxUDC2tOk21sVDA8a2MoYpRMla0CYetay3Vvioo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZZXbLcKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E3EC433C7;
	Mon, 19 Feb 2024 08:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708332975;
	bh=YD+bqENRjvWndB/bUJ3EJXYmwpBACeWizdmGMxxvVR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZXbLcKBA4UoEwNSY6lrdkB5W3I38CUlcMVe2uvDsLKFKTn7ph3tPgUk4i2G5/G7G
	 nQGmxEJAd7uTSYpCz5Tw+fljSnHfz1jCe9QM/pIigR4FgaemtPX/JzOFSXQ9umtv0j
	 +F9BVBBK+tXdfWDYcbMO1Xz4BzdQz3GOqXnysrkQ=
Date: Mon, 19 Feb 2024 09:56:12 +0100
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
Subject: Re: [PATCH v4 04/15] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <2024021904-subgroup-activist-442c@gregkh>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-5-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-5-jic23@kernel.org>

On Sat, Feb 17, 2024 at 04:42:38PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Similar to recently propose for_each_child_of_node_scoped() this
> new version of the loop macro instantiates a new local
> struct fwnode_handle * that uses the __free(fwnode_handle) auto
> cleanup handling so that if a reference to a node is held on early
> exit from the loop the reference will be released. If the loop
> runs to completion, the child pointer will be NULL and no action will
> be taken.
> 
> The reason this is useful is that it removes the need for
> fwnode_handle_put() on early loop exits.  If there is a need
> to retain the reference, then return_ptr(child) or no_free_ptr(child)
> may be used to safely disable the auto cleanup.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4: Include the alignement changes that were in patch 15 of v3 with
>     a tweak as I missed the first line. Thanks Andy!
> 
>  include/linux/property.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 9e67c3c4df6e..eefd662a2f9d 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -182,6 +182,11 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
>  	for (child = device_get_next_child_node(dev, NULL); child;	\
>  	     child = device_get_next_child_node(dev, child))
>  
> +#define device_for_each_child_node_scoped(dev, child)			\
> +	for (struct fwnode_handle *child __free(fwnode_handle) =	\
> +		device_get_next_child_node(dev, NULL);			\
> +	     child; child = device_get_next_child_node(dev, child))
> +
>  struct fwnode_handle *fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  						  const char *childname);
>  struct fwnode_handle *device_get_named_child_node(const struct device *dev,

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

