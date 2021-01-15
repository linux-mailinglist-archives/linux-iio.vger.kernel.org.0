Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3C2F739A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 08:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbhAOHSe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 02:18:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbhAOHSb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Jan 2021 02:18:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CCCB23117;
        Fri, 15 Jan 2021 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610695045;
        bh=vttksYpG0Z4wUVkuCoquP88skGm45WjWGxmPUJrp92U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPNzLwbsbbkuNUQ75wnfwP2fu4BSSgM2QBZCQYJjofKFw/4fUkI/FeeQwnGrhwv/2
         dLfgRu3mJcdswE+b5+VkOf/IG4Oep2wkM5f6wGcvChepQtUGzxBA8myDwIXt/oCxAK
         lVBFA/hNL9Opbdt2OAusoJn1tv0uc0HZawa2Czh0=
Date:   Fri, 15 Jan 2021 08:17:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO and counter fixes for the 5.11 cycle.
Message-ID: <YAFBfguqr5vaPMmE@kroah.com>
References: <20210114221424.72c7e5f5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114221424.72c7e5f5@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 14, 2021 at 10:14:24PM +0000, Jonathan Cameron wrote:
> The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:
> 
>   Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.11a

Pulled and pushed out, thanks

greg k-h
