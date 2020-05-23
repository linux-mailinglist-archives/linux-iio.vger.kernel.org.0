Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A911DF60A
	for <lists+linux-iio@lfdr.de>; Sat, 23 May 2020 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387500AbgEWIl4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 May 2020 04:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387471AbgEWIl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 May 2020 04:41:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93706206C3;
        Sat, 23 May 2020 08:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590223315;
        bh=dxlY0IEO/cs0s9sH92Pnng2mx/muyjDU0TbxQU6ypJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWTHnakJtkifXfrYqe6yzf/0uU2kyK0Sj87mwt20HyF5Qk3H7lJ5MI/U/n2hgwIe7
         h0qDx2YJ4wOuHvkN9vcBips5/Y9u5BV+TRivFOUkn30DfxK+GtTbxbFq1BzMz/LEkm
         gSTlbbMJzFpF3SOHZgqdqkkL47fAFtRqR+45Ub8A=
Date:   Sat, 23 May 2020 10:41:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 3rd set of new devices, cleanups and late breaking minor
 fixes for IIO in the 5.8 cycle.
Message-ID: <20200523084124.GA3450090@kroah.com>
References: <20200522175931.1d91d3e4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522175931.1d91d3e4@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 22, 2020 at 05:59:31PM +0100, Jonathan Cameron wrote:
> 
> he following changes since commit cef077e6aa4c7dbe2f23e1201cf705f9540ec467:
> 
>   Merge tag 'iio-for-5.8b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2020-05-15 16:03:28 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.8c

Pulled and pushed out, thanks.

greg k-h
