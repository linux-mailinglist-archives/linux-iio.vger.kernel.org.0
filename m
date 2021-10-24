Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079F3438874
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 13:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJXLME (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 07:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230520AbhJXLME (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 07:12:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCF260F6F;
        Sun, 24 Oct 2021 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635073783;
        bh=apjTvyGXrld2PKBb+yZU84U5yfucI5Zb8F8i0NTBIxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X/n1OEq5PaL+R1UI8s3aAca5bSoK6gJKGH+ayUXMn8N+yJQOZQW5DdLFWusUqiW5n
         JL915MdKmPcm9JxFV3WQcAfGekchmHCynFYGHCHUhfKohvDJ3tBPdpj3h9zSbx2psi
         aGf36LZoqTmc7gn9pvNRQpPhRuc6Y/o7XD3t5h2A=
Date:   Sun, 24 Oct 2021 13:09:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for the 5.16 cycle (suggest queuing
 for merge window as nothing urgent)
Message-ID: <YXU+6P/WTvIU4EAW@kroah.com>
References: <20211022162345.0000350c@Huawei.com>
 <20211022170752.0000686c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022170752.0000686c@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 22, 2021 at 05:07:52PM +0100, Jonathan Cameron wrote:
> On Fri, 22 Oct 2021 16:23:45 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > The following changes since commit 37f12202c5d28291ba5f83ce229771447ce9148f:
> > 
> >   staging: r8188eu: prevent array underflow in rtw_hal_update_ra_mask() (2021-10-05 12:35:30 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.16a
> > 
> > for you to fetch changes up to 486a25084155bf633768c26f022201c051d6fd95:
> > 
> >   iio: buffer: Fix memory leak in iio_buffers_alloc_sysfs_and_mask() (2021-10-21 10:26:38 +0100)
> > 
> > ----------------------------------------------------------------
> 
> Hi Greg,
> 
> Doesn't make much sense to rush this set in, so I'd suggest just merging
> it alongside the other pull request to char-misc-next.
> 
> I thought about just merging this into the iio-togreg branch and
> sending you one pull request, but decided this was simpler.  Let me know
> if you'd prefer it done a different way.
> 
> *fingers crossed* I haven't messed these up this time!

Looks good!
