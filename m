Return-Path: <linux-iio+bounces-9562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC4D97915F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF3E1F226DA
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3C31CFEBF;
	Sat, 14 Sep 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YINNz5RQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1FA1DFFB;
	Sat, 14 Sep 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323949; cv=none; b=b4/T6nVYJvgZi1ODO3Tw9O3czV7bEI7Y6Z1DUQAmz1lqLsWthkAykFlAbCcBzc73/Ks8HM/J3IQx7ACqtokNSJ6jIZhCBdfTKWCqMarV8RS1yynWWHQDCiG7+5cZbbkWx7awljlzzxGLo9wdXLdmCK4hCiTdAJiuzTpRJEMwVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323949; c=relaxed/simple;
	bh=qroqSTTwEDCD0rZ0eV81Yf1u6tPK2FLzTrXAxoEaSyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STUfmnpxITn+hSHyB7VUly4c4ApGZvlm40pzGLq4lzjzBA2L7zh2ZblrAY8LBwnf3r56oeHNOrww/OFvM6qJ/t7yI4hnwAkcFCuHohXXDB9dRVlrrap7scbwT4P1ppOSymTqpe6hqOL0sLrky1hgXRkUOfMNtFgegVn7bz7dtVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YINNz5RQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260FEC4CEC0;
	Sat, 14 Sep 2024 14:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323948;
	bh=qroqSTTwEDCD0rZ0eV81Yf1u6tPK2FLzTrXAxoEaSyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YINNz5RQI7Mb8ZWkwsFfL2maatyH3oK9VH5fiYzCFQwPj8bX4rrNSFTT8Jc9RVwfU
	 LnWdKaxY+2LRNS5eCsYQs7DRnl09lpP6CXgClrOEaGaX8Xh+B+4XWX90EXCzOjx3e1
	 nFBlXLHuqRe1/VbQyN5wm6jk/VRBK6YTkCxYp6SSXgUDanqQLteDBThqkWRnv4qhip
	 OXUGLvLmpBW9vQIO3nvW4E356h9+/2TeXtQiHQ91lIA/63NWsEv/7Po3uYD1t62PCc
	 T16ei0CTW2dZH+6AZZacIyuicBF7hMMQLfSY5c0ltQJc1wfW/hfvE1ecXaqqRyOs4F
	 j7uKFBHjz+k0A==
Date: Sat, 14 Sep 2024 15:25:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: light: ltr501: Drop most likely fake ACPI
 ID
Message-ID: <20240914152541.1c2228f4@jic23-huawei>
In-Reply-To: <ZuQGcyrTFek1yExt@smile.fi.intel.com>
References: <20240911212202.2892451-1-andriy.shevchenko@linux.intel.com>
	<c45dd21c-493a-4e56-809e-85d6d7201254@redhat.com>
	<ZuQGcyrTFek1yExt@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 12:31:31 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Sep 12, 2024 at 03:51:09PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 9/11/24 11:22 PM, Andy Shevchenko wrote:  
> > > The commit in question does not proove that ACPI ID exists.
> > > Quite likely it was a cargo cult addition while doint that
> > > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > > 
> > > Googling for LTERxxxx gives no useful results in regard to DSDT.
> > > Moreover, there is no "LTER" official vendor ID in the registry.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Thanks, patch looks good to me:  
> 
> Have you grepped over your collection of real DSDTs?
> 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>  
> 
> Thank you!
> 
I'll pick these up in the meantime. Applied to the testing
branch of iio.git.



