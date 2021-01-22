Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB4E300223
	for <lists+linux-iio@lfdr.de>; Fri, 22 Jan 2021 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhAVL4d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Jan 2021 06:56:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbhAVK7F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 Jan 2021 05:59:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FF0720739;
        Fri, 22 Jan 2021 10:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611313091;
        bh=OE3wbEwuooYJTVEUo63UoWWZzM1gxqzc2fJJwvxMr0U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=mz3dBZfaEbCWHEn08a8O4I4BBjbKCcYVopUgSNY/Q2xkDlmQQBS7UvLfe4Evskrms
         J1HqjKOj7fazx+btXa68hslHm3JF3NPORbCAG3fWMNbZffWCmKoXboCnnRr1dG3lYW
         GKfnQvbr+f44n54Uz16vz40W2uZ9oCNZHEhodCXUq7M0acMy8vw9gSEOagE3lJl9ox
         RMwlUarkY1i0wYzq/gTbRFhByQWZSG+43swFJG95VOFqmh26jhzIJ3enx5K4ce9FvC
         s5o7ivKCknwbrASPM9CyneTiZqsjRKfdJib35HU4VmrS9Oi9sKlOl98sxNY1iPdJtA
         eNOCaVpfb9Z4Q==
Date:   Fri, 22 Jan 2021 11:58:08 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] hid/hid-sensor-custom: convert comma to
 semicolon
In-Reply-To: <20210120204824.0d52a2d2@archlinux>
Message-ID: <nycvar.YFH.7.76.2101221157470.5622@cbobk.fhfr.pm>
References: <20201214133212.3569-1-zhengyongjun3@huawei.com> <df1481e15c591106ba75ed85289b12507cbc8c49.camel@linux.intel.com> <20201229181841.6d63213a@archlinux> <20210120204824.0d52a2d2@archlinux>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Jan 2021, Jonathan Cameron wrote:

> > > > Replace a comma between expression statements by a semicolon.
> > > > 
> > > > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>    
> > > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>  
> > Applied to the togreg branch of iio.git and pushed out as testing for
> > the autobuilders to see if they can break it.
> Hi Jiri,
> 
> Just realised this is in HID rather than IIO. I hope you don't mind as
> it's now deep in a tree I'd rather not rebase.
> 
> Sorry about that.

No worries, feel free to keep it in your tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs

