Return-Path: <linux-iio+bounces-1176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E0C81B478
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B807F28410E
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6F6A02F;
	Thu, 21 Dec 2023 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYsx0Zcs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82F69799;
	Thu, 21 Dec 2023 10:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440B8C433C7;
	Thu, 21 Dec 2023 10:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703156088;
	bh=7wbXaePSW/44tnWXqKYDczbwgLzPWA8vIbnztprKJVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYsx0Zcsdi/1Zy7bVVMDd7jKnpuL1iuXiAJ+Zx4z78WwYKtzB+LmUHXo/w2AOWmhe
	 G6B4HfCLkoWYnzZBT6NzEh8fi18qMuewYIB3MdqKwrZmS0rhMfvHbCYjbHIKRPZmMS
	 ZVm+0f3EKa8SiSEz9A3MGXEdCNwDWDttHikMqLY2ztaDlVTTsp/3+2qJcDPBmIKNPK
	 VPF6NYn/Akw10Q8xQ1O4yGIHAS3BOlf6AkGWtWh1pOfwG4Shxu8ng/BzaMCNKyn8rQ
	 /Ymd2HhpnLreiYdyNHyyL748eGqlO+hxaJNotg9gHRzCaXSC+JOqHAMogj08Fl7zu1
	 uGGl/fP3axycA==
Date: Thu, 21 Dec 2023 10:54:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/4] of: Add cleanup.h based autorelease via
 __free(device_node) markings.
Message-ID: <20231221105434.5842ff3a@jic23-huawei>
In-Reply-To: <20231220221144.GA1188444-robh@kernel.org>
References: <20231217184648.185236-1-jic23@kernel.org>
	<20231217184648.185236-2-jic23@kernel.org>
	<20231220221144.GA1188444-robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 16:11:44 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sun, Dec 17, 2023 at 06:46:45PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The recent addition of scope based cleanup support to the kernel
> > provides a convenient tool to reduce the chances of leaking reference
> > counts where of_node_put() should have been called in an error path.
> > 
> > This enables
> > 	struct device_node *child __free(device_node) = NULL;
> > 
> > 	for_each_child_of_node(np, child) {
> > 		if (test)
> > 			return test;
> > 	}
> > 
> > with no need for a manual call of of_node_put()
> > 
> > In this simile example the gains are small but there are some very  
> 
> typo
> 
> > complex error handling cases burried in these loops that wil be
> > greatly simplified by enabling early returns with out the need
> > for this manual of_node_put() call.  
> 
> Neat!
> 
> I guess that now that the coccinelle check has fixed many, we can update 
> it to the new way and start fixing them all again. We should update the 
> coccinelle script with the new way. See 
> scripts/coccinelle/iterators/for_each_child.cocci.

If the holiday season gets dull enough I'll take a look at updating that
as well. Been a long time since I last messed with coccinelle.

Given this is just a simplification rather than a fix, there would be no rush
to convert things over but we definitely don't want the coccinelle script
to generate lots of false positives.  + we should perhaps add a
script to try and catch the opposite (double free) as a result of
using this automated cleanup.

> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/of.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 6a9ddf20e79a..50e882ee91da 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -13,6 +13,7 @@
> >   */
> >  #include <linux/types.h>
> >  #include <linux/bitops.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/errno.h>
> >  #include <linux/kobject.h>
> >  #include <linux/mod_devicetable.h>
> > @@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
> >  }
> >  static inline void of_node_put(struct device_node *node) { }
> >  #endif /* !CONFIG_OF_DYNAMIC */
> > +DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))  
> 
> of_node_put() can be called with NULL, so do we need the "if (_T)"?

Nope - should be fine to call it without. I was being lazy and didn't check :)

> 
> Rob


