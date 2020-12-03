Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424752CE07E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 22:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgLCVUg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 16:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727460AbgLCVUg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Dec 2020 16:20:36 -0500
Date:   Thu, 3 Dec 2020 22:19:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607030395;
        bh=ZjYPNmI8JitOeclukkRqE6uRj1MwZ2L1etbIvxUXMeE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6IwYt4sea2zYCYEyHZFPZwMt8k/fms9YXXzVmPiHe4oW+uZJ3NHkf+Ux8Fd67EX4
         rYJJAm7GRwt0GI0pTN24TCATc4jcPn6k1wxE5vu9DBs874OhmA6AjXWJICyWs1CVlm
         mzUrQCck+mZOoGWOEaHqxwzYgQT8iP3KOccImXLU=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V2] 2nd set of IIO new device support, cleanups and yaml
 conversions for the 5.11 cycle
Message-ID: <X8lWSHRD36WqPdGc@kroah.com>
References: <20201203194612.3f35eda5@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203194612.3f35eda5@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 03, 2020 at 07:46:12PM +0000, Jonathan Cameron wrote:
> The following changes since commit 749c1e1481e1d242ded9dd1bf210ddb7c0d22a4f:
> 
>   Merge tag 'iio-for-5.11a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2020-11-24 08:30:08 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.11b-take2

Much better, thanks.  Pulled and pushed out, thanks.

greg k-h
