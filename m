Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D2A77ECA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfG1J2i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 05:28:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfG1J2i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 05:28:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9216020659;
        Sun, 28 Jul 2019 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564306117;
        bh=B8tVROVN6MvZJjVH1G+RWBJCDGfAm3qJUt5XT0HqupM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKAtVKzWwlNDAyem2z+HHI1+/yuSf6SOd50wllIxuER6GBYvj7ipTzR+yiomRYFDq
         ghLdNGAuwnKx4D34QD3ol7bENNg/4WVdtPIaIv0f265I/wB36P2H2/smeLYhRyHF5h
         AJ5+CkL6dqWRRxBs5LRXVD0AvwSjkEPyH+HYpxZw=
Date:   Sun, 28 Jul 2019 11:28:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for 5.3
Message-ID: <20190728092826.GA31933@kroah.com>
References: <20190728095828.01c5cbe2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728095828.01c5cbe2@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 28, 2019 at 09:58:28AM +0100, Jonathan Cameron wrote:
> The following changes since commit d7d170a8e357bd9926cc6bfea5c2385c2eac65b2:
> 
>   Merge tag 'tag-chrome-platform-for-v5.3' of git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux (2019-07-11 18:45:29 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.3a

Pulled and pushed out, thanks.

greg k-h
