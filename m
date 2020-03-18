Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9C8D189998
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 11:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCRKju (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 06:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRKju (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Mar 2020 06:39:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C508220770;
        Wed, 18 Mar 2020 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584527990;
        bh=yiIVdO/AABTDEXDki6dYdowr7jmmdmr03jlK1vAfrKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5uIs8+myk1pQokVL8foHEqzCInvheYOVN0ZjodnEqNkLKLRKMZNmyf/VoBjm4ez/
         C+5TlOQIT+42hcKVLmw4+P/nAuYFNTGr3r5Png0D478a/K/DYf/I6YkYyy4llxCah7
         hRRfCDW/IAaPuOTW7UbEMlwFqrUa5U3fsS32/sWE=
Date:   Wed, 18 Mar 2020 11:35:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of new IIO device support, features and
 cleanups in the 5.7 cycle.
Message-ID: <20200318103531.GA2216217@kroah.com>
References: <20200308190642.1ceced2c@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308190642.1ceced2c@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Mar 08, 2020 at 07:06:42PM +0000, Jonathan Cameron wrote:
> The following changes since commit 8ef0c4f06432b5b2f4e32f37b81708eae1e20c8c:
> 
>   Revert "staging/octeon: Mark Ethernet driver as BROKEN" (2020-02-12 13:50:33 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-5.7a

Pulled and pushed out, thanks.

greg k-h
