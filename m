Return-Path: <linux-iio+bounces-2469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C7F8513A4
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 13:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480811C219BD
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A725740;
	Mon, 12 Feb 2024 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwh7pJ+X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDE179B8;
	Mon, 12 Feb 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741417; cv=none; b=D7usG+Yl64AlyknVgwCD96Ffqdi/pNKjsXCNnkQ0+FumIcxI5s9BPxvH9vfeTg9w1hzPUq6VTbSF+BvrpJWQ4kulFlCQz5pzTsE1NQaIRO+KaQk+XYUf4afPmBC66nIIRZ8n8FFCddvAcd3iW/dtCqtzTr8aURhU7tqkAIpa0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741417; c=relaxed/simple;
	bh=SzgQzJ4w8NXyvJfwBKVu7SwOE3XBJB0VeBqVOoeNTq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y49TnUwP+/0cPuOm/Knb7k4n06WuTFfD0u1SSH6xSTgBDUEyU2laHEI173TtEaopiYstpThiuO5adRI/kzV8nmqWWbjmDOkDWn5Lf7i386dT62l1Y7TM2OhrRTA9YU8aeA2Tjml3NaEzBvyH2uIAzvCUWfVmHe0AoIh84aXBgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cwh7pJ+X; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707741416; x=1739277416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzgQzJ4w8NXyvJfwBKVu7SwOE3XBJB0VeBqVOoeNTq0=;
  b=Cwh7pJ+X3+7iYDKwifZF15jIzgxceySI6foHQJliOVA+/Bc7U4h4RKwo
   pfNrjKxmLj1mrh99ypF83hkb3anKEcr50mRWJOA0FjJGuGv2cLiBUza2V
   NhuLpFHwtmm5GbYlHL6ja1xA889qePyocsl6M9+phXc37HcQbUCXhpYT4
   2iNBo0MZoPQEaJvOWpRc9xKaxIadN/TLud11+M3hIi8PwejLqHXKCnhUC
   gFbDbn+DF0XjHdvDJQj9rbp1doyZBy5wfspAKv+J44wgcSETns7WUMBnC
   +oMrmxgqkplUBlffGBkY/JNfqBd6EZ1Dz7rfwDwWhDMjYYVgWXBUTjVS5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1592912"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1592912"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:36:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911471024"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911471024"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:36:49 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C75BD11F86A;
	Mon, 12 Feb 2024 14:36:46 +0200 (EET)
Date: Mon, 12 Feb 2024 12:36:46 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 01/14] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <ZcoQ3sOcVYbwoHO7@kekkonen.localdomain>
References: <20240211192540.340682-1-jic23@kernel.org>
 <20240211192540.340682-2-jic23@kernel.org>
 <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
 <20240212114206.00005b9f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212114206.00005b9f@Huawei.com>

Hi Jonathan,

On Mon, Feb 12, 2024 at 11:42:06AM +0000, Jonathan Cameron wrote:
> On Mon, 12 Feb 2024 08:49:23 +0000
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On Sun, Feb 11, 2024 at 07:25:27PM +0000, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Useful where the fwnode_handle was obtained from a call such as
> > > fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
> > > and will automatically release the reference on the variable leaving
> > > scope.
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  include/linux/property.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/include/linux/property.h b/include/linux/property.h
> > > index e6516d0b7d52..bcda028f1a33 100644
> > > --- a/include/linux/property.h
> > > +++ b/include/linux/property.h
> > > @@ -12,6 +12,7 @@
> > >  
> > >  #include <linux/args.h>
> > >  #include <linux/bits.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/fwnode.h>
> > >  #include <linux/stddef.h>
> > >  #include <linux/types.h>
> > > @@ -188,6 +189,8 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
> > >  
> > >  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
> > >  void fwnode_handle_put(struct fwnode_handle *fwnode);
> > > +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> > > +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))  
> > 
> > fwnode_handle_put() can be safely called on NULL or error pointer fwnode so
> > you can remove the check.
> 
> Was discussed in the RFC thread (where i didn't have this protection)
> 
> https://lore.kernel.org/linux-iio/20240108125117.000010fb@Huawei.com/
> includes a reference to Linus Torvald's view on this.
> 
> All comes down to compiler visibility and optimization opportunities, which are improved
> if the check is in the macro definition.

Hmm. In that case I'd rather make fwnode_handle_put() and similar trivial
functions macros.

There's no need to add cruft here and about a 100-fold number of callers
will get the same benefit.

-- 
Sakari Ailus

