Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EAC138FC1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 12:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgAMLGm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 06:06:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgAMLGm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 06:06:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D537207E0;
        Mon, 13 Jan 2020 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578913602;
        bh=s3/WMZfvA832Id5SN49sd7V+/4Kc/56VTeoKvEmxn7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDuHJRgXw1lDID8pD7RxzN2GO9DCrTLRKU1T/qZ3iMQvXj+vKuheD355Dk4/4tfvy
         ZHLHCuavUEdzbdj4O6sZuLHrSNrvpnNmAw9AIiJYemRLBEGvmUs//JDleE8vlm2BNp
         K66+6xxiHphBGcSHcR9LN0PTSywcESVuTrV/lNA8=
Date:   Mon, 13 Jan 2020 12:06:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO fixes for the 5.5 cycle.
Message-ID: <20200113110639.GA5809@kroah.com>
References: <20200105110051.445c9a95@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105110051.445c9a95@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 05, 2020 at 11:00:51AM +0000, Jonathan Cameron wrote:
> The following changes since commit c05c403b1d123031f86e65e867be2c2e9ee1e7e3:
> 
>   staging: wfx: fix wrong error message (2019-12-18 15:51:06 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.5b

I get this check warning when trying to push these:

Commit: 80d92ea5f865 ("iio: light: vcnl4000: Fix scale for vcnl4040")
	Fixes tag: Fixes: 5a441aade5b3 ("light: vcnl4000 add support for the VCNL4040 proximity and light sensor")
	Has these problem(s):
	        - Subject does not match target commit subject
	          Just use
		                git log -1 --format='Fixes: %h ("%s")'

I'll fix this up by hand, but note that this changes the git sha1, so if
you pull you will see a merge.

thanks,

greg k-h
