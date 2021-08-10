Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE63E5416
	for <lists+linux-iio@lfdr.de>; Tue, 10 Aug 2021 09:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhHJHHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Aug 2021 03:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233662AbhHJHHw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Aug 2021 03:07:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9280760EFF;
        Tue, 10 Aug 2021 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628579251;
        bh=9t1Tkypbs0K3hHMBnvXqm84ZvVYxt0/wOp4dJQnqc9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVdtByubl6gmWWHzSn/DeBU15n1Febw5QH+YhzC43aGnZNCqBFeE4t9Ree2fFKUNG
         9SISn9b2s7xs7BaWDbl0rs1S3iNxUh5AqI0oFADQ3BAHEqrE6FqjenE7+GQDkvXAL+
         iVcag3DAh2EZtGajJsSwYqKao6s7febx4CN7dmgk=
Date:   Tue, 10 Aug 2021 09:07:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 5.14
Message-ID: <YRIlsIGd/2tjz8r+@kroah.com>
References: <20210809201626.36d04053@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809201626.36d04053@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 09, 2021 at 08:16:26PM +0100, Jonathan Cameron wrote:
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.14a

Pulled and pushed out, thanks.

greg k-h
