Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A923273C69
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 09:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgIVHsA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 03:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgIVHsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 03:48:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B67239D2;
        Tue, 22 Sep 2020 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600760879;
        bh=EaMIasDUAbRBcUmAAYr8Tjf3zc/2DmTo36+3xFNVLH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQushAjZDUELx1Dhtlx8GqSWhu5hXErjV4pN4JbOlS5b/z+QKx6/lpQ20OJjkE/Wl
         9IZnM3b2Y8kOS0wbi09Mosvj3v5fA8HP+Ws41/IEePtBh5yHNOqWmULmmTKq2G7Rsv
         07oE4QKOMbBHwOKwZXPHSuzq6MgMkEqCllQXRNEI=
Date:   Tue, 22 Sep 2020 09:46:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL v2] Second set of features and cleanup for IIO in the 5.10
 cycle.
Message-ID: <20200922074655.GC1581265@kroah.com>
References: <20200921200655.583b16cd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921200655.583b16cd@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 21, 2020 at 08:06:55PM +0100, Jonathan Cameron wrote:
> The following changes since commit 2f0472a1f80e6230f126aa0af76e89f85abc37bd:
> 
>   drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon (2020-09-06 16:05:56 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10b-take2
> 

Much better, now pulled and pushed out, thanks.

greg k-h
