Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5607C1D4FEB
	for <lists+linux-iio@lfdr.de>; Fri, 15 May 2020 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgEOOFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 10:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOOFH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 May 2020 10:05:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B845220657;
        Fri, 15 May 2020 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589551507;
        bh=gXQ2pQpzqWh+O3oem3x7NnlGqBpa5WtSB9qSo8GHMdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEEhqm+v38GSFGhm6dObbh6O/TSZzd21Jl4Or3cV3vaOy8SZazFJHZcSug9JAsZZ7
         utch4en9j2l3s1gG2BIi3976PqkzBAqExp/lHfBWHJmwQTebMG7dh3TlgyXahdLxNL
         RjoHDB/PW2OHPzvvTRDyrQ6qIIeu8d2OsvIxGTW0=
Date:   Fri, 15 May 2020 16:05:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 2nd set of IIO fixes for the 5.7 cycle.
Message-ID: <20200515140504.GB2184507@kroah.com>
References: <20200511201150.13576144@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511201150.13576144@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 11, 2020 at 08:11:50PM +0100, Jonathan Cameron wrote:
> The following changes since commit c532cc617e6edc4398a9ec5c8f470833966f9f9f:
> 
>   Merge tag 'iio-fixes-for-5.7a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2020-04-20 14:07:00 +0200)

Pulled and pushed out, thanks.

greg k-h
