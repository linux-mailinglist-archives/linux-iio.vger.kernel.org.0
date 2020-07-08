Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D217218105
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jul 2020 09:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgGHHWG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Jul 2020 03:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgGHHWG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Jul 2020 03:22:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622C620760;
        Wed,  8 Jul 2020 07:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594192925;
        bh=pO50zWkmQ6blQ+TkvzpeaoV9jqXFMHns53PYD9TU/NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Au5icPVBVB+Rq4IKxY7eE3nf1yFgJUK7lTSmBaa9mTrgJmX9EOSEnCWwC98bk2pZP
         G9Dw8WnEd5H99kAVgVhWzCryzeMhp2l91E9UM7BqqTXBZdaq1UimbmA/SbEshUPV69
         3QHmWiKf5m5Lp6CF3lJKwxwnwWu79trqpeqpZM6I=
Date:   Wed, 8 Jul 2020 09:21:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO fixes for the 5.8 cycle.
Message-ID: <20200708072135.GB353684@kroah.com>
References: <20200707192611.6a5d3e99@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707192611.6a5d3e99@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 07, 2020 at 07:26:11PM +0100, Jonathan Cameron wrote:
> The following changes since commit b791d1bdf9212d944d749a5c7ff6febdba241771:
> 
>   Merge tag 'locking-kcsan-2020-06-11' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2020-06-11 18:55:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.8a

Pulled and pushed out, thanks.

greg k-h
