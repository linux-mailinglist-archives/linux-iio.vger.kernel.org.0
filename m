Return-Path: <linux-iio+bounces-2762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD985A260
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76326B26811
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 11:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B342C859;
	Mon, 19 Feb 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QypcSBS3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721EB28DBD;
	Mon, 19 Feb 2024 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343224; cv=none; b=rQwbdpBmjn2H662N67iIqecfc+TqMIF+6pO1+sfaYsYe/rtA8bdAomUo3NGDH9jUyiB9kfAmdRhdtc5mHem2k3q96/pr0dX5ujDXU/qIzZGcdQ7DrhDkvCoUyUA+ebrhj+dttGNocDasNNSA3mAhT3XyFOT80ndtD7w4vlSUrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343224; c=relaxed/simple;
	bh=wyM173WXobkqcMdBuV/vTYBDtXpq/fDb2dNUkfTTQdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzdbTM3Y3wnSzOhxrmiDvL/UmGDAcvUPYtH+/L/0RbDTyRPgdmlQ63wnl2xz0AkE2fiZ8VKLzIuqzbe7btfuO2z2hEqG+Ij4UYtZ1+KU5Um5bmnPjvmLWlAEv7uGUTZjb+738hrbnxwugXcgQCuWDaDl05F/KfyvOcy+beVaUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QypcSBS3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343223; x=1739879223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wyM173WXobkqcMdBuV/vTYBDtXpq/fDb2dNUkfTTQdE=;
  b=QypcSBS3ZppD+3OhbIvXx99WRauTdMW1Yk5aTif4U+YA/HCEXx+d9gus
   zMvwSOw0BXBXt4q91L6gW4aHms2sHfbim8J2trf6xGF98pOpSWooepwUF
   uRkyWO2Bsay/nNtdjBrO3XwrbzHxa1FxtQ9vHga7ulaF0eUpvwIYq4zQx
   +nzX0xpzgKeT+WOItWjcmocPNmLrkPu4vlVboEYxhmcJH2QdnTBvbp0+J
   ELWQ7UACXeTDm+EowX1/3vtRVl15IR5VO7afpdgLbPghwCPhMDeYzENh5
   TjTFHu5N0/eItpvIkUZdq5/hTJjbGZaAkTxwDhy/gCf+rQeK9d0303kZf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19949732"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19949732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912861667"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912861667"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:46:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc26l-00000005oJ5-07Ji;
	Mon, 19 Feb 2024 13:46:51 +0200
Date: Mon, 19 Feb 2024 13:46:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v4 13/15] iio: dac: ad3552r: Use
 device_for_each_child_node_scoped()
Message-ID: <ZdM_qp78GbvzWlN9@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-14-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-14-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 17, 2024 at 04:42:47PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
> 
> Removing the goto err; statements also allows more extensive use of
> dev_err_probe() further simplifying the code.

...

>  			err = fwnode_property_read_u32_array(child,
>  							     "adi,output-range-microvolt",
>  							     vals,
>  							     2);

Side note: ARRAY_SIZE()?

-- 
With Best Regards,
Andy Shevchenko



