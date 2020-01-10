Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC6136A20
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2020 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgAJJpq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jan 2020 04:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgAJJpq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 10 Jan 2020 04:45:46 -0500
Received: from localhost (83-84-126-242.cable.dynamic.v4.ziggo.nl [83.84.126.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39FAC2072A;
        Fri, 10 Jan 2020 09:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578649545;
        bh=1T5gec1MtZJL10SXYW1mVfUNIeqWfwWKAZyNIYgft44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyTBzFGizklZbrhcksQYTCE+fAD5xFiIoYIA56LspydzjGnE/EvXpMWdN2GagoSrb
         o7cOMbJuQgf6crxaU6NuC5XR01+m1ep7tMH20IGa5vPjBg0cO3bl2f/qGD0p1EH9Gs
         0cLaRHVYZn9BiJ4yi3v+IvPUfXozTMQoTC/8wpdE=
Date:   Fri, 10 Jan 2020 10:45:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of IIO new device support, features and
 cleanups for the 5.6 cycle
Message-ID: <20200110094543.GA399864@kroah.com>
References: <20200105124957.7acd54b5@archlinux>
 <20200105125333.60db3e63@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105125333.60db3e63@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 05, 2020 at 12:53:33PM +0000, Jonathan Cameron wrote:
> Hi Greg,
> 
> I did see a merge conflict when merging this your staging/staging-next
> around deletion of include/Kbuild
> 
> I've not been following what has been going on around that, but simply
> removing the file seems to be the obvious solution.

Looks sane, now pulled and pushed out, thanks.

greg k-h
