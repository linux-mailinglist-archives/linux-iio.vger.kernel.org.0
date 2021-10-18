Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AE243121C
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhJRI2s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 04:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhJRI2s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 04:28:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E33B6108E;
        Mon, 18 Oct 2021 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634545597;
        bh=xOmAQitMBVIxD0P5lk/jGhQrjBA6gAaoj/EuLHLLD5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIOFSCSL4nxT+TH63zGzjyvUoiQ3l7ZYBNDji+DqcQlmmawK+g8tNdDviPd//eq7/
         ErUKdTZ2j561FgLszxENs8A6jzXzCNresZfiNONGS3WgUP4ElxzPpU8TNLa+A1hrAa
         bRAvEEw2tD9ldMLTlw7Lz+06yEcUiolJhNYQDxBQ=
Date:   Mon, 18 Oct 2021 10:26:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter/counter-sysfs: use sysfs_emit everywhere
Message-ID: <YW0vujDgJ12HtulV@kroah.com>
References: <20211017190106.3472645-1-david@lechnology.com>
 <YWyyzmNGxWKyKiAD@shinobu>
 <YW0PAq8nB6FcLwZd@kroah.com>
 <YW0t9mVy6ACZYsXB@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW0t9mVy6ACZYsXB@shinobu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 05:19:02PM +0900, William Breathitt Gray wrote:
> On Mon, Oct 18, 2021 at 08:06:58AM +0200, Greg KH wrote:
> > On Mon, Oct 18, 2021 at 08:33:34AM +0900, William Breathitt Gray wrote:
> > > On Sun, Oct 17, 2021 at 02:01:06PM -0500, David Lechner wrote:
> > > > In the counter subsystem, we are already using sysfs_emit(), but there
> > > > were a few places where we were still using sprintf() in *_show()
> > > > functions. For consistency and added protections, use sysfs_emit()
> > > > everywhere.
> > > > 
> > > > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > > > Signed-off-by: David Lechner <david@lechnology.com>
> > > 
> > > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > 
> > Thanks, want me to take this directly on top of the previous pull
> > request?
> > 
> > greg k-h
> 
> Yes, that should be a fine path forward for this patch.

Great!  Can you also ack the other patch from David as well?

thanks,

greg k-h
