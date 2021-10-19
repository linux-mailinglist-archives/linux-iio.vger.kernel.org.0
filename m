Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12DC432F12
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhJSHO4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234374AbhJSHOz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 03:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C418061260;
        Tue, 19 Oct 2021 07:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634627563;
        bh=LKOHmW8af3I/sadI332L7flg2PuRGZzRm2bu8UPkZqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsfyX9rkiwfoy3e3u2+nEdETq7g3Od+VbJrQyqAsrBysbDjXzGF3yow0PKBMN+IKg
         9CwsEM+fZu3ZIPkfA8BZ+2G+GufpJPPex2iiwqrRNC/swZFpSMbMgYHuzgGQgwVHfu
         8AcKQt50BZn3e20AHodg5T4/gMsfq4Wi/6h2OJqA=
Date:   Tue, 19 Oct 2021 09:12:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V3] 1st set of IIO new device support, features and
 cleanup for  the 5.16 cycle
Message-ID: <YW5v6OPgC84X73Qg@kroah.com>
References: <20211018192351.39245b42@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018192351.39245b42@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 07:23:51PM +0100, Jonathan Cameron wrote:
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.16a-split-take3

Almost :(

I get the following error from my scripts:

Commit: 4862202a0171 ("dt-bindings: iio: magnetometer: asahi-kasei,ak8975 add vid reg")
	Fixes tag: Fixes: 7e000fbff7a0 ("dt-bindings: iio: magnetometer: ak8975: convert format to yaml, add maintainer")
	Has these problem(s):
	        - empty lines surround the Fixes tag

Also, there was a merge conflict in drivers/iio/adc/aspeed_adc.c, but
that was easy for me to resolve.

thanks,

greg k-h
