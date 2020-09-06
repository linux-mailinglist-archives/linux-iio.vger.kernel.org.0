Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA8625EE60
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIFO52 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 10:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgIFO5Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Sep 2020 10:57:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BB920714;
        Sun,  6 Sep 2020 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599404245;
        bh=mYC4+661NDhhqnFqeph4351v3s9BxRaRyHs+14bLpoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPggoQA+5HUOSWshe3dpigbTn++wpu0LsQsR2TB2Z0uLrgM1TDjA5QVnr3R43swhj
         fD9YX/clEcTC1HRRBdD8UisQA/4ZF3NcTCqUbCvd4OpZygRlHTdi9k6llB5pytvlRR
         dBM4tvMrawOwYruFrb4YzrcOf3+OFA0YBOoyU7e8=
Date:   Sun, 6 Sep 2020 16:57:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support etc for the 5.10
 cycle
Message-ID: <20200906145741.GA314751@kroah.com>
References: <20200906133958.6fec0a17@archlinux>
 <20200906145628.GA290336@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906145628.GA290336@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 06, 2020 at 04:56:28PM +0200, Greg KH wrote:
> On Sun, Sep 06, 2020 at 01:39:58PM +0100, Jonathan Cameron wrote:
> > The following changes since commit bc752d2f345bf55d71b3422a6a24890ea03168dc:
> > 
> >   staging: hikey9xx: Kconfig: add regulator dependency (2020-08-18 19:15:47 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.10a
> 
> Pulled and pushed out, thanks.

Oops, spoke too soon, I get the following error when trying to push:
Verifying "Fixes:"...		                

Commit: 1bebdcb928eb ("drivers/iio/humidity/hdc2010.c:305:2-3: Unneeded semicolon")
	Fixes tag: Fixes: 016b57638b47 ("iio: humidity: Add TI HDC20x0 support")
	Has these problem(s):
	        - Target SHA1 does not exist

Can you fix this up and send a new pull request?

thanks,

greg k-h
