Return-Path: <linux-iio+bounces-1442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507DF82601B
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jan 2024 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DEB22CFB
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jan 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBAD79F9;
	Sat,  6 Jan 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcqwQi6q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3F8C1D;
	Sat,  6 Jan 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704554708; x=1736090708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uchMTwyNWsn3FIvlNecAOL81jzA+hn5613XxiosJYxA=;
  b=FcqwQi6qJCfs5GHPfPhXC+WJ+sKjqI+q5qAQ7Mib3nySa+1LbaFWUK0J
   2E3wFEO3FtkSWyBLEjtd9uTZRg9y7XR01+IRWD2NOfCvnPVTL5h/bezXF
   yGxFZXsoxnakequCBcrUNnTiokUNHF+iyD0n+jb57aft9Mx4mNYkzftkz
   yeFTQYj3aLhyIvZWlcGxw4xB7HpH048D7lqhRSzzv1q/pKYe6CAQVwZ6Z
   AzYV+gaQGJAiB06UnQlZklDV0oRkilrK3tIA+Mi0NvdCzuhTsE4a+RWkt
   ilUsw+ZiDLgWjBA86QZRPNykmBNsj4S6UQsNZyySbYWFGWU1Ky2/Hj7uh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="461961914"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="461961914"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="871478208"
X-IronPort-AV: E=Sophos;i="6.04,337,1695711600"; 
   d="scan'208";a="871478208"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 07:25:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rM8Rz-0000000BwHY-1tMh;
	Sat, 06 Jan 2024 17:19:03 +0200
Date: Sat, 6 Jan 2024 17:19:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 00/13] device property / IIO: Use cleanup.h magic for
 fwnode_handle_put() handling.
Message-ID: <ZZlvZ_9_72nyKEU1@smile.fi.intel.com>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jan 01, 2024 at 05:25:58PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> RFC mainly because it's untested. I have none of the relevant hardware and
> haven't yet emulated the firmware descriptions to test this.
> I have tested the device tree only version:
> https://lore.kernel.org/linux-iio/20231217184648.185236-1-jic23@kernel.org/
> which is very similar.
> 
> Failing to release the references on early exit from loops over child nodes
> and similar are a fairly common source of bugs. The need to explicitly
> release the references via fwnode_handle_put() also complicate the code.
> 
> The first patch enables
> 
> 	struct fwnode_handle *child __free(fwnode_handle) = NULL;
> 
> 	device_for_each_child_node(dev, child) {
> 		if (err)
> 			/*
> 			 * Previously needed a fwnode_handle_put() here,
> 			 * will now be called automatically as well leave
> 			 * the scope within which the cleanup is registered
> 			 */
> 			return err;
> 	}
> 
> /*
>  * fwnode_handle_put() no automatically called here - but child == NULL so
>  * that call is a noop
>  */
> }
> 
> As can be seen by the examples from IIO that follow this can save
> a reasonable amount of complexity and boiler plate code, often enabling
> additional cleanups in related code such as use of
> return dev_err_probe().

Important comment on the first patch, otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko



