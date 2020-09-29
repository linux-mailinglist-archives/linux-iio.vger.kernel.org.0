Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC91A27D432
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgI2RMn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 13:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2RMm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 13:12:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A3E20936;
        Tue, 29 Sep 2020 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601399561;
        bh=rjy8YY8VOtMjsc70u0qMlTp3QIa6Q+2arkg1RoUMNaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSxyO5Uvj+ktClbcj7fLv9o49O27NujwrCcquLS0LRLh7SIVEsEG/okHHNKuWbJRK
         lEYA3IXuSFJiDooZtKmSbdt8sx1wAHjZjW68qONknI2kgB2eUq9Ck9bGhybMd+3Fr6
         vW7VH/0F9su4xlOi0sT/wA4BjNF/+pI6X7AAzHMU=
Date:   Tue, 29 Sep 2020 19:12:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Third set of new device support, cleanups etc for IIO in
 the 5.10 cycle.
Message-ID: <20200929171208.GC1351851@kroah.com>
References: <20200929180239.42ccd9bb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929180239.42ccd9bb@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 29, 2020 at 06:02:39PM +0100, Jonathan Cameron wrote:
> The following changes since commit 69fea2b4e59c52844cf5196c9c81157792d194fb:
> 
>   staging: r8188eu: replace WIFI_REASON_CODE enum with native ieee80211_reasoncode (2020-09-22 09:51:28 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10c

Pulled and pushed out,t hanks,.

greg k-h
