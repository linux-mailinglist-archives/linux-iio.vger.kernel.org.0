Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604C4273241
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgIUSwI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 14:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgIUSwI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 14:52:08 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EC720888;
        Mon, 21 Sep 2020 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600714327;
        bh=pMHDypg8mdGWzZlKNq79sq3or90BwHEMdVV0rPdC1T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtQx9C2FKqcL/TCp9SA3vKcNks3TUvQI2WZt4FQCSwzekDUu5+eBcM4svcqkSC6i0
         8HnKPz9ih7hEOrg7APJoZT7rQvvAuGqyqdyNFsHex8cOMSfdrDujG4dFgWtS3Nb60E
         QOgOo7mZROF1lfqkmzCzdfl6SK/jhKCXFj9qLNUE=
Date:   Mon, 21 Sep 2020 20:52:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of features and cleanup for IIO in the 5.10
 cycle.
Message-ID: <20200921185230.GA1429057@kroah.com>
References: <20200921190808.2f0af905@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921190808.2f0af905@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 21, 2020 at 07:08:08PM +0100, Jonathan Cameron wrote:
> The following changes since commit 2f0472a1f80e6230f126aa0af76e89f85abc37bd:
> 
>   drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon (2020-09-06 16:05:56 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10b
> 
> for you to fetch changes up to eda7a4890f5825f1a01d635ab25235f4dacb8715:
> 
>   dt-bindings: iio: vishay,vcnl4000: add interrupts property (2020-09-21 18:54:26 +0100)

So close:

Commit: 7bf38af6540e ("iio:accel:bma180: Fix use of true when should be iio_shared_by enum")
	Fixes tag: Fixes: fdadbce0da4 ("iio: add Bosch BMA180 acceleration sensor driver")
	Has these problem(s):
	        - SHA1 should be at least 12 digits long
	          Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
	          or later) just making sure it is not set (or set to "auto").

One more digit!  :)

can you fix that up and resend?

Remember, if I don't catch these, linux-next will...

thanks,

greg k-h
