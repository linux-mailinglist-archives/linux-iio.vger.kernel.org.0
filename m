Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E6B432335
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhJRPrb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 11:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231986AbhJRPrb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 11:47:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5019760EFE;
        Mon, 18 Oct 2021 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634571919;
        bh=ZB/UFh/iHseaZnMA2PkAB6x7/1XaoS5sv8QMsz4rqWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCc9v80Z+jDhUdI0FwFCmrPcUqkjt8rxziltMK9rUKaCK8yhUTZCJWTJtXBAE4R3E
         H7VYMI7d5F1v1BqHo5xdDPOotYGiE9EpLxJcZ4EFBaH4V/TU4Jsyopvbsi0R0dl7kX
         Ilf/ngGGo66+IFZax1qhpQ5Rnqaol3oAtKZHcP5M=
Date:   Mon, 18 Oct 2021 17:45:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PULL] 1st set of counter subsystem new features for the 5.16
 cycle.
Message-ID: <YW2WjGuci2d+gK5L@kroah.com>
References: <20211017112717.1c1d8779@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017112717.1c1d8779@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 11:27:17AM +0100, Jonathan Cameron wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/counter-for-5.16a
> 
> for you to fetch changes up to c9638a65d7982b5069a500cc5c504e7a7faa2676:

I get the following error when trying to push this from my scripts:

Commit: 50cda7cc4ab1 ("counter: fix docum. build problems after filename change")
	Fixes tag: Fixes: d70e46af7531 ("counter: Internalize sysfs interface code")
	Has these problem(s):
	        - Target SHA1 does not exist

Was this caused by rebasing?

thanks,

greg k-h
