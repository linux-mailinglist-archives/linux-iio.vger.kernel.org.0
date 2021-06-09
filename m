Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C63A10EB
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhFIKQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 06:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234217AbhFIKQb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Jun 2021 06:16:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA76B6128A;
        Wed,  9 Jun 2021 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623233662;
        bh=Hc5RVB21B6PTjPWPFAXn7IjcR5qTkCIyOiAuhY9meYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WlOKsAN1U+txPeC1lMmoj1Y2i3PS6u7lB+mqaayM0Za4oZkn+XNcf1HbDjnm98tMA
         XPQ3FB62O+z5l1JbwzqkW15bIjasM6OG4UkgfQ9MvNiCvhNwkwq3NHmFdxA+8MHqCh
         K+buAyspFxfP4bWlmPLELvourFvH/DZf0KGsemXs=
Date:   Wed, 9 Jun 2021 12:12:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO new device support, features and cleanups
 for 5.14
Message-ID: <YMCUINJTQGoP8UsF@kroah.com>
References: <20210608173258.5d648bec@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608173258.5d648bec@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 08, 2021 at 05:32:58PM +0100, Jonathan Cameron wrote:
> The following changes since commit d8218b0de51f36f01ed67731ccf174059a33bb1e:
> 
>   Merge 5.13-rc2 into staging-next (2021-05-17 09:47:44 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.14a
> 
> for you to fetch changes up to 41340965b4f8055f975f73e1e3d23eff8038f013:
> 
>   Merge branch 'ib-iio-i2c-5.13rc1' into togreg Adds a stub needed to resolve a build conflict for the fxls8962af driver. (2021-06-07 09:20:02 +0100)

Pulled and pushed out, thanks.

greg k-h
