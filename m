Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3E2B2E5F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 17:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKNQQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 11:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNQQb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 11:16:31 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7472B206D9;
        Sat, 14 Nov 2020 16:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605370590;
        bh=wA5JJM2Bglgv3WNaexhFOxOw949Mt4FgBWDr20dnDG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcePe2Z3jSFIayjYrptBzcTyAxS7H7XkDm+fV+qUyDAqEnNKAy383n4RPbrvBUHe/
         1h1oHjj6Ue+iDdGi7mc8gvAwct9MVWdpYVGWZg2SZJ0FosB+TAY8w2/rE6VdPfDgOb
         2sYpcTxJPyQpOr5y6o3deR8ztoV+2f0DV1np9XXY=
Date:   Sat, 14 Nov 2020 17:17:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/4] device: provide devm_krealloc_array()
Message-ID: <X7ADFLwEpUHkTiT+@kroah.com>
References: <20201102142228.14949-1-brgl@bgdev.pl>
 <20201102142228.14949-2-brgl@bgdev.pl>
 <20201114154641.0258f4ee@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201114154641.0258f4ee@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 14, 2020 at 03:46:41PM +0000, Jonathan Cameron wrote:
> On Mon,  2 Nov 2020 15:22:25 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > When allocating an array of elements, users should check for
> > multiplication overflow or preferably use one of the provided helpers
> > like: devm_kmalloc_array().
> > 
> > This provides devm_krealloc_array() for users who want to reallocate
> > managed arrays.
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> +CC Greg KH. 
> 
> As this is going into a very generic place I'd like a relevant ack.
> That file is a bit of a wild west for acks, but Greg seems most
> appropriate person.
> 
> So Greg, any comments on this one?

As there is only 1 user of this function in the patch series, you don't
save any extra code space here, I don't think this is worth it.

We are seeing less and less gains from these new devm_* additions, and
only more confusion and problems with them.  So perhaps don't add this?
I don't think it is needed.

thanks,

greg k-h
