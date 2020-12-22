Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A23D2E095F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgLVLLv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 06:11:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgLVLLv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Dec 2020 06:11:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7393722516;
        Tue, 22 Dec 2020 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608635470;
        bh=Q1euM+YOvuQwr69t7zFVYW1zAzkMWO7kDxvDMc9dnsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Od9CKyEvTeGsf0XvRzL/O85XlE9fnPXq/6T2OJSSuTZcWBkf0YqDNfsjtFyMkEn5r
         vMa+RPKkCGIbeXH3KA3oWCG0tVzQ5jOEQDOIkhwdER8GSiFm3em6Fx7ntKhZZ+OebE
         f4713+QEDVSyToHkKAuwvH+Ce0y/29ZvAqfgKDDM=
Date:   Tue, 22 Dec 2020 12:12:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de, akpm@linux-foundation.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 1/2] lib/string.c: add
 __sysfs_match_string_with_gaps() helper
Message-ID: <X+HUmERYPLyM+oz5@kroah.com>
References: <20201222095210.61897-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222095210.61897-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 22, 2020 at 11:52:09AM +0200, Alexandru Ardelean wrote:
> The original docstring of the __sysfs_match_string() and match_string()
> helper, implied that -1 could be used to search through NULL terminated
> arrays, and positive 'n' can be used to go through arrays that may have
> NULL elements in the middle of the array.
> 
> This isn't true. Regardless of the value of 'n', the first NULL element in
> the array.

I can not parse this last sentence, is it missing something?

thanks,

greg k-h
