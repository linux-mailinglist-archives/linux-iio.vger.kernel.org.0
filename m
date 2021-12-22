Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8647D118
	for <lists+linux-iio@lfdr.de>; Wed, 22 Dec 2021 12:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbhLVLgU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Dec 2021 06:36:20 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35854 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbhLVLgU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Dec 2021 06:36:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 130F7619C9
        for <linux-iio@vger.kernel.org>; Wed, 22 Dec 2021 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CD0C36AE8;
        Wed, 22 Dec 2021 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640172979;
        bh=BM9PdxVPwz61kGj6fZIKsPnMBmJsTtA83pUV0IUWD2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHAUcLY4JVc0G7w+EeoIFxQlah5/sQcNTm20QUcy/ADecWIj8ut2LKKXz1nImjpC4
         fiU7gtttQUvU+n+sMvW41YcofM+cN5M0+YVcROw/gLBxTabTR1O8AbNO7RSghlPZae
         2+ThZZci2cXP/xkmYljNx1fQvdkCbNSrf4jEXsSI=
Date:   Wed, 22 Dec 2021 12:34:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of new device support, features and cleanup for
 IIO in the 5.17 cycle.
Message-ID: <YcMNVQDVsCMpKzd3@kroah.com>
References: <20211221153333.0bfe8257@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221153333.0bfe8257@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 21, 2021 at 03:33:33PM +0000, Jonathan Cameron wrote:
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.17a

Pulled and pushed out, thanks.

greg k-h
