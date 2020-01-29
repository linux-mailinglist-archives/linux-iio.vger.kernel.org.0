Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7614C61F
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2020 06:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgA2Fv5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jan 2020 00:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgA2Fv5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jan 2020 00:51:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4DC2063A;
        Wed, 29 Jan 2020 05:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580277116;
        bh=7MUE7be9gyPbZpp49Iah+G5vwuLh1QqLhtBeulocnB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xh2GN6r5JhJzxLx/f4uZLnp9JtO/VAqEM0cyuu6Q56e+VSQxSntERxyACTJRSqIMM
         KnQlt4O4diBzaQKUlBHFW8IY2zeTYNCb+UMjFpx6UMouG4Ll67Uo7cdL9Hc27BKbpD
         +caV42mbdYqucBqZJXAFHInXwLOPcAB/D/lXYVWE=
Date:   Wed, 29 Jan 2020 06:51:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com,
        alexandru.ardelean@analog.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RESEND PATCH] iio: adc: ad7124: Add direct reg access
Message-ID: <20200129055153.GA3766596@kroah.com>
References: <20200129051435.15366-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129051435.15366-1-mircea.caprioru@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 29, 2020 at 07:14:35AM +0200, Mircea Caprioru wrote:
> From: Mircea <mircea.caprioru@analog.com>
> 
> This patch adds the posibility do read and write registers from userspace
> using the kernel debug direct register access option.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

Now this line doesn't match the name you use above on the "From:" line
:(
