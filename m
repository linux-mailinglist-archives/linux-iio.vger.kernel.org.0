Return-Path: <linux-iio+bounces-1797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998FB8356B0
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA48BB21887
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B93716C;
	Sun, 21 Jan 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpBc+JVJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2C34550;
	Sun, 21 Jan 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855140; cv=none; b=Z203qOX4aY3YTCpvFpmJXiKg/7m+bXi6W7Hhz5dCb8pCZSJycaF9Jk86gZXzLVHUJ8oXiBF1QWeMT88wEHfOu/BQQS+HWfWy6bDm4YncbISOxLl+CZi1qc/+Ikug4VkxQGYx9hRUi5xvWhG+IZyD9lGgfuYCRX7WNCIWi6kvaC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855140; c=relaxed/simple;
	bh=IveSG9w2cySCDzTVB6sh7mkjc06OisQW+mSDCMXOLTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkiYzMSJVVm1raekvPiJILgnsPPT504uY5bO8C83uM/Xs3LApvaLUP4N9ld7nz+gUvGuikrRLKr74buYPETMxYz0/FmTqK8PKDPFba7BmwPlrLMvDTRNT7goD/NQxG7R/j6IEiUFFDaGwIhPJPuCYZgLRc+mSIYEnQ8DB61mOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpBc+JVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70280C43390;
	Sun, 21 Jan 2024 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705855140;
	bh=IveSG9w2cySCDzTVB6sh7mkjc06OisQW+mSDCMXOLTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CpBc+JVJSlhBQ++UpKAxuK3aWFzgongPgBPheyLZpm0Gr/lmsMP8smI/rWHnFWln9
	 gXP5B35l3xiIIG3sv7Ac+ANutHxTX92wBLzYBT0OoTwg7PgACeylFVF4ibGglWWSpT
	 teOS5olEAfx/CAtYQ6+NAh2YLpzYz0EN63TorxqPHoNxPbil06SylFvChS1dSAIkWy
	 lM9NGtBv17BQbIuf6sIOzXHspzC8iHQ0Quu+Idi5puUAonoboi+CGLBWd0z85MUSKH
	 6Rt1+8M7aMzfqsfUmu7bWxbc5AQvtGkrtcre2zUY/gsLW0SBkiNEDx+7uOA5dCzdvO
	 Rph/YbH0FRnqQ==
Date: Sun, 21 Jan 2024 16:38:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rob Herring
 <robh@kernel.org>
Subject: Re: [PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <20240121163714.3670498f@jic23-huawei>
In-Reply-To: <Za0N_5Hp2s-uwOoM@smile.fi.intel.com>
References: <20240114172009.179893-1-jic23@kernel.org>
	<20240114172009.179893-2-jic23@kernel.org>
	<Za0N_5Hp2s-uwOoM@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 14:28:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Jan 14, 2024 at 05:19:57PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This allows the following
> > 
> > struct fwnode_handle *child __free(kfree) = NULL;

That's garbage.  Should be __free(fwnode_handle)!

> > 
> > device_for_each_child_node(dev, child) {
> > 	if (false)
> > 		return -EINVAL;
> > }
> > 
> > without the fwnode_handle_put() call which tends to complicate early
> > exits from such loops and lead to resource leak bugs.
> > 
> > Can also be used where the fwnode_handle was obtained from a call
> > such as fwnode_find_reference() as it will safely do nothing if
> > IS_ERR() is true.  
> 
> ...
> 
> >  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
> >  void fwnode_handle_put(struct fwnode_handle *fwnode);  
> 
> I would add a blank line here
> 
> > +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> > +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
> >  
> >  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
> >  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);  
> 
> With the above,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
Thanks Andy - however..

The discussion with Rob about the DT equivalent took an interesting turn.

He raised the concern that the __free was not always tightly coupled with the
equivalent of  device_for_each_child_node() which as per similar
discussions elsewhere results in:
a) Potentially wrong ordering if there is other cleanup.h based stuff going on
   in the same function.
b) A lack of association between the setup of the free and what it is undoing.
  (this was the one Rob pointed at).

I proposed two options that here map to
1) Always drag the declaration next to the device_for_each_child_node()
   and intentionally don't set it to NULL.

{
	.... stuff....

	struct fwnode_handle *child __free(fwnode);
	device_for_each_child_node(dev, child) {
	}

2) Scoped version of the loops themselves.

#define device_for_each_child_node_scoped(dev, child)				\
	for (struct fw_node_handle *child __free(fwnode_handle)                 \
		 = device_get_next_child_node(dev, NULL);                       \
	    child; child = device_get_next_child_node(dev, child))

So that the child only exists at all in the scope of the loop.

What do you think of the options?

DT thread is here:
https://lore.kernel.org/linux-iio/20240114165358.119916-1-jic23@kernel.org/T/#t

Jonathan

