Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6821D608
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 14:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgGMMgI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 08:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMgI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jul 2020 08:36:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 748362072D;
        Mon, 13 Jul 2020 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594643768;
        bh=PvIDxkwnwIEyGIDQ9rwQpdjf5A0vGFq9L+78blMCcj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKhdmTKeZMQJp3o1n6fwj/wWSBUpWSCrHr64/51DMPx+9mWZnFnlOLZ/oFJTssqoL
         kfPNQKaxqXIDyKIJwlnmX3/WbDjGeoIfgNKKuqqB03Xc+/W7YUoMx7XvDLNaJo4kXo
         m7i3U0OzMvyh/zgu41vMI7Tt138RoWtNC77Pdo+8=
Date:   Mon, 13 Jul 2020 14:36:06 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL] First set of new device support, cleanups and features
 for IIO in the 5.9 cycle.
Message-ID: <20200713123606.GA3093579@kroah.com>
References: <20200712145703.526c8b46@archlinux>
 <6040d8fa83eff1d401abb7545521f4ae723d3640.camel@analog.com>
 <20200713114850.00002f64@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713114850.00002f64@Huawei.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 13, 2020 at 11:48:50AM +0100, Jonathan Cameron wrote:
> @Greg, please ignore this pull request.  Will do a v2 shortly.
> If this crosses with you taking it, then please add the patch Alex
> has linked below with my Ack.

I'll wait for a second pull request, thanks.

greg k-h
