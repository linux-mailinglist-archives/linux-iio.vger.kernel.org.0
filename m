Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273D2141E5F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jan 2020 15:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgASOCH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jan 2020 09:02:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgASOCH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Jan 2020 09:02:07 -0500
Received: from localhost (unknown [84.241.197.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AA2D206D7;
        Sun, 19 Jan 2020 14:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579442526;
        bh=kLIsjqeQy/pjqylz2DCA6bu9V1trUyO8J/mxrZgumrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZU1wpQbPY1ZpjYkAbOSJ15ufDUnt2v66EM2+ENYvTxZzlAeetObGWmVKbb9YLJlkH
         09oeRdFBSr8t2EILYKPkC/P5tMtgTvVXms2st2EgCJekLzgTbhKy4eRZsOQUFhfktt
         bsBbPqJB4eOAt+S4HF4t0CtfFr9mLL9MosCMOtVc=
Date:   Sun, 19 Jan 2020 15:01:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Second set of IIO new device support, cleanups and minor
 fixes for the 5.6 cycle.
Message-ID: <20200119140140.GA227931@kroah.com>
References: <20200118193627.2a384228@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118193627.2a384228@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 18, 2020 at 07:36:27PM +0000, Jonathan Cameron wrote:
> The following changes since commit e895bc1ebb31750f3baa74e074617d3cc5d0cee2:
> 
>   staging: vc04_services: remove header include path to vc04_services (2020-01-10 17:33:41 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.6b

PUlled and pushed out, thanks.

greg k-h
