Return-Path: <linux-iio+bounces-1170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B781081A8C9
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 23:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A4F1C225B3
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 22:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905BE495FF;
	Wed, 20 Dec 2023 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byCJAc1G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582894A997;
	Wed, 20 Dec 2023 22:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0425C433C7;
	Wed, 20 Dec 2023 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703110306;
	bh=/KFTV7+1magMZJ3bZ7dz1PxueAaInhV1KdHG6TbhODg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=byCJAc1G1uEVxwEhdVRitMd/SXNI1ewKNWxwKsvnhiqJEMr0wvcLUHef4x+pv0jnB
	 F4uP1XNFzEpUSBAtO7EE2/NxoXGq8Y4E6b4TQGuNOp3ZhZJHYwPyqUkC101Gkj1dEr
	 7F92li660Yer8wzLMei+JNVzy2gvM++vtIxdJk9O31fFVhrtLiuLwwCEMCCFmXXKM4
	 O+WRM6egIQZFK5hlxVMNtjsEEwjeqJ3zSIDUC3Vrh0iilPdN+pSdGhSyFuTMvHKax7
	 fKCwJ1PPB+bEMTxa30HgYnmIqz9LSZ129r5MbEBI3hJeTkzOwQm9wvTa2XyLyOCSw0
	 HsbWAbCcYykJw==
Received: (nullmailer pid 1219931 invoked by uid 1000);
	Wed, 20 Dec 2023 22:11:44 -0000
Date: Wed, 20 Dec 2023 16:11:44 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/4] of: Add cleanup.h based autorelease via
 __free(device_node) markings.
Message-ID: <20231220221144.GA1188444-robh@kernel.org>
References: <20231217184648.185236-1-jic23@kernel.org>
 <20231217184648.185236-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217184648.185236-2-jic23@kernel.org>

On Sun, Dec 17, 2023 at 06:46:45PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The recent addition of scope based cleanup support to the kernel
> provides a convenient tool to reduce the chances of leaking reference
> counts where of_node_put() should have been called in an error path.
> 
> This enables
> 	struct device_node *child __free(device_node) = NULL;
> 
> 	for_each_child_of_node(np, child) {
> 		if (test)
> 			return test;
> 	}
> 
> with no need for a manual call of of_node_put()
> 
> In this simile example the gains are small but there are some very

typo

> complex error handling cases burried in these loops that wil be
> greatly simplified by enabling early returns with out the need
> for this manual of_node_put() call.

Neat!

I guess that now that the coccinelle check has fixed many, we can update 
it to the new way and start fixing them all again. We should update the 
coccinelle script with the new way. See 
scripts/coccinelle/iterators/for_each_child.cocci.

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/of.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 6a9ddf20e79a..50e882ee91da 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -13,6 +13,7 @@
>   */
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
>  #include <linux/kobject.h>
>  #include <linux/mod_devicetable.h>
> @@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
>  }
>  static inline void of_node_put(struct device_node *node) { }
>  #endif /* !CONFIG_OF_DYNAMIC */
> +DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))

of_node_put() can be called with NULL, so do we need the "if (_T)"?

Rob

