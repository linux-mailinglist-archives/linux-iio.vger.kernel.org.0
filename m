Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E452746C3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIVQhe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 12:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIVQhe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Sep 2020 12:37:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431492399A;
        Tue, 22 Sep 2020 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600792653;
        bh=W+NHW2c8NBZlcXv96rN0OWo8rbAgSDO4UK58jiPlgJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yAnSa75uLPli1oADFcY3/ng3l8iuV+g0LjVMLRBRc6B5kKreRwXmAa1R+j4MnraPj
         rj481iP465oPtlb/FxUuva/VyH8QZv0ipix8amm0ySpgU7sXKnu4kLPZP34enm0CbJ
         XqFjn/X5irMrLrNX04tcsTOL2VAIwdiJCbldEy20=
Date:   Tue, 22 Sep 2020 18:37:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V2] 2nd set of IIO fixes for 5.9
Message-ID: <20200922163747.GA2322802@kroah.com>
References: <20200922134018.064157eb@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922134018.064157eb@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 22, 2020 at 01:40:18PM +0100, Jonathan Cameron wrote:
> The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:
> 
>   Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.9b-take2

Pulled and pushed out, thanks.

greg k-h
