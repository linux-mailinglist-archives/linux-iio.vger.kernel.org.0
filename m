Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3F257755
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 12:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHaKcY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 06:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHaKcY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 06:32:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748F22098B;
        Mon, 31 Aug 2020 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598869943;
        bh=ng5OGCZYuMhonRNOPxwEXD/iGEoUgj6MyCllMK6Yxuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i4/djMbC6VvjSTUv8yUKDSo9eCYcqLNnj3vksGCoQOWl8V6POVoR48VE3g6pGdGem
         ArZmGFujPw9qI1N2yFTlCItYfn7I5XGL4LUaeeU/8lk3VZ4kLX/YOfpDSfTVyCjUTK
         hUp4Ha65y9ch1N6WmMVgrzUmPguG+Iwfe9bx9918=
Date:   Mon, 31 Aug 2020 12:32:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 5.9 set 1
Message-ID: <20200831103212.GA520793@kroah.com>
References: <20200831104333.6ceffa04@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831104333.6ceffa04@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 31, 2020 at 10:52:07AM +0100, Jonathan Cameron wrote:
> The following changes since commit 1dffeb8b8b4c261c45416d53c75ea51e6ece1770:
> 
>   staging: greybus: audio: fix uninitialized value issue (2020-08-18 16:12:54 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9a

Pulled and pushed out, thanks.

greg k-h
