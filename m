Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596C143887B
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJXLRC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 07:17:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhJXLRC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 07:17:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0760B6101C;
        Sun, 24 Oct 2021 11:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635074081;
        bh=k1ID24hA5TsSGtxjJr+MvWvoxO0sKvhMPTnTJG+fj8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tEu711ZwnB72lg4X6nrST7Y4WAbJFHhMTo98xRf/Q5F10vGSj6iU4z9TlS52RmNTQ
         W1OCzXd6WUV/aUJ8r9qe+w8AQgR7GJMLIQZ032cfev6j4xRN3vy3QOLiD/KbnMDO7Z
         1YLWyTftsZ6cywGWtX2GXJB5QtF7hsVFEpXJcuUA=
Date:   Sun, 24 Oct 2021 13:13:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO new device support, features, cleanup for
 5.16
Message-ID: <YXU/8jN6Qfn7iHSI@kroah.com>
References: <20211022161612.000026f6@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022161612.000026f6@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 22, 2021 at 04:16:12PM +0100, Jonathan Cameron wrote:
> The following changes since commit 8135cc5b270b3f224615bdee8bd7d66afee87991:
> 
>   MAINTAINERS: Update the entry for MHI bus (2021-10-19 15:49:14 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16b

Pulled and pushed out, thanks.

greg k-h
