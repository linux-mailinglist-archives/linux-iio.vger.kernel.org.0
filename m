Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F06E214BA8D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2020 15:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgA1Ojo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jan 2020 09:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgA1Ojo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 09:39:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFA924688;
        Tue, 28 Jan 2020 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580222383;
        bh=/EZ3fH8QcPNFqcjhEo4ZSfYy5je9d2qtTPI/ZMlLLC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+PwbUdQjuY+gFimVStbq1Y275PFsUiRMMQ9XZUgZkTeCOZsJxLpyZTw1oUQStfMK
         OJNnzdoxGeEf16mOI1QgRMPNSGDEdl4EgO2zXnuR0/Wb0i+c/8gN6DPxkq9t/UKG/g
         bR98NZQezTWSz4Ii7yHHf2ZUNKXXLgBHh+i9V8oc=
Date:   Tue, 28 Jan 2020 15:39:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     jic23@kernel.org, Michael.Hennerich@analog.com,
        alexandru.ardelean@analog.com, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: Add direct reg access
Message-ID: <20200128143940.GA3340676@kroah.com>
References: <20200128142549.1370-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128142549.1370-1-mircea.caprioru@analog.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 28, 2020 at 04:25:49PM +0200, Mircea Caprioru wrote:
> From: Mircea <mircea.caprioru@analog.com>
> 
> This patch adds the posibility do read and write registers from userspace
> using the kernel debug direct register access option.
> 
> Signed-off-by: Mircea <mircea.caprioru@analog.com>

We need a "full" name here, like your "from:" line in your email says.

Please fix up and resend.

thanks,

greg k-h
