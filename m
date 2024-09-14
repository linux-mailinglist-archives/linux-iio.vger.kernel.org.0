Return-Path: <linux-iio+bounces-9563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25EF979161
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612652859C6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09BE1CFEB7;
	Sat, 14 Sep 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee+xSPDg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAFF1DFFB;
	Sat, 14 Sep 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726324004; cv=none; b=JoGLr8KV8I0MBFy16GLfZvdSmymI4jZ40PPESQYlFasOaidMZBcWNLZmC3qSdp+Aj/MWG2hEMOWgMYGX0diNwt1lANszo4+mb9h9JDUn4k1BNyR7kpSnYow5XrvUxU3zVuCzJW7JrXvEO3I5PMnvqSHrevk1RDFnDM17oGzQv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726324004; c=relaxed/simple;
	bh=IByxkRxXq0J/Gztv7I0dv6bOV6UDkslm/FPPaEUTDf8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaxwzMGc1nXmNqlQAsIuEkFyRgRuvXm24OAc9KWLWQDgzIx/EM/ETMaI95QN6cTO3SJdQ/ZUI0i0sLhE0U3YZhFoV7Ng4bvjfGhFkpTAxLYI+qB0CrMhlnwJfpM+nkyl7dN4sm4ZviyhAQonh5C+xxoJOIXYpZRoliHot6sQlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee+xSPDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E82C4CEC0;
	Sat, 14 Sep 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726324004;
	bh=IByxkRxXq0J/Gztv7I0dv6bOV6UDkslm/FPPaEUTDf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ee+xSPDgwQnbB7erCqan5o3T6iWvKwAzel5bm/nJrA2a/Jdrbh7FJLWcnRUVc2bSM
	 2VrofYC2Ovy+pTfx17yEZIwWKupQHXaixBlF3H9yVX1DVeRp9XFOYF3HGq7hNWw6bZ
	 Ws2GD61jr1eq1Gs1vUD3qoZT23xwe8EFO+1oD7zRzfcE94uQhV13HSYirPbrXLdYFN
	 oyC9N229AIbMz2kfAqNgn22QL9HhqYMFDpPTZVHv0dhwZFSTCUU1rC3WxXR9J/agly
	 y+61M2XiaWB6cRwz0kwluuXN6g9Eshzue+9UMFjeqKEYERIm+VFlqmYwHcbXe08Mgb
	 lHjUzC1WxrRSw==
Date: Sat, 14 Sep 2024 15:26:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iio: imu: kmx61: Drop most likely fake ACPI ID
Message-ID: <20240914152637.6972642f@jic23-huawei>
In-Reply-To: <ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
References: <20240911213110.2893562-1-andriy.shevchenko@linux.intel.com>
	<2b847413-f8ee-436c-a635-f5a36253e953@redhat.com>
	<ZuQGnqgdkJhyIiLK@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 12:32:14 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Sep 12, 2024 at 03:52:34PM +0200, Hans de Goede wrote:
> > Hi,
> > 
> > On 9/11/24 11:31 PM, Andy Shevchenko wrote:  
> > > The commit in question does not proove that ACPI ID exists.
> > > Quite likely it was a cargo cult addition while doint that
> > > for DT-based enumeration.  Drop most likely fake ACPI ID.
> > > 
> > > Googling for KMX61021L gives no useful results in regard to DSDT.
> > > Moreover, the official vendor ID in the registry for Kionix is KIOX.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Thanks, patch looks good to me:  
> 
> Same Q here.
In meantime I've queued it up.  Can always drop it again
if it turns out we do have users.

Jonathan

> 
> >  Reviewed-by: Hans de Goede <hdegoede@redhat.com>  
> 
> And thank you for the reviews!
> 


