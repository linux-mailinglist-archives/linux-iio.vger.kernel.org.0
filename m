Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F2C4515B3
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhKOUtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 15:49:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345094AbhKOT0X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 14:26:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EABF563717;
        Mon, 15 Nov 2021 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637003415;
        bh=WUs8pbSJ4KTHev9vx8TYvymwy1+1LnfpNVarwYGx37E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msLABvr0NvZFd4WIpbCxcon7xn/4MtxfBxQH3/1Kz05y99bz3vNUo+hQgZ6+XzLJN
         DzzQOT07dcitAvIMFQlWLaHCeVjirt71h57eRypTsbpiO1olbZUI/j5fC0zNSfytZa
         PIhwV68NjJKQNoTeJOZ5uQada9C1sDAY1MmSV2OA=
Date:   Mon, 15 Nov 2021 19:08:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH] device property: Add fwnode_iomap()
Message-ID: <YZKiAgvnRdgAzkmA@kroah.com>
References: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115173819.22778-1-anand.ashok.dumbre@xilinx.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 05:38:19PM +0000, Anand Ashok Dumbre wrote:
> This patch introduces a new helper routine - fwnode_iomap(),
> which allows to map the memory mapped IO for a given device node.
> 
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>  drivers/base/property.c  | 15 +++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 17 insertions(+)

We can not add new api calls with no users, as there is no way to
determine how the calls are being used.

So please submit this as part of a patch series that shows it being
used.

thanks,

greg k-h

