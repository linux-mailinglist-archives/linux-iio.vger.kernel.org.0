Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C76FF30B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfKPQXD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 11:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfKPQXD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 11:23:03 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BABE21479;
        Sat, 16 Nov 2019 16:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573921382;
        bh=uGuhx40PSVACD1w2xbCF83UlRktCW3KrF5PatnpxlxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fxaPmIIPIPk2Nm0smKAbyYykUNypy9xrYa+I/tr604z7UBEBPjvxuSqbO0hrT1Eca
         ewm/cVlaVwg1YCwUWpANv9X4UwcizgD3TeEiuTW9FVig15TYdFNIM4bGH6S93H2zzO
         xB9HtSCDIiCyu0T5tswPQeYVixdJt+vsz6apnQEY=
Date:   Sat, 16 Nov 2019 16:22:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, knaack.h@gmx.de,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly
 for channel request
Message-ID: <20191116162257.550f62d6@archlinux>
In-Reply-To: <20191114043318.GE952516@vkoul-mobl>
References: <20191113092453.30838-1-peter.ujfalusi@ti.com>
        <20191114043318.GE952516@vkoul-mobl>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 Nov 2019 10:03:18 +0530
Vinod Koul <vkoul@kernel.org> wrote:

> On 13-11-19, 11:24, Peter Ujfalusi wrote:
> > dma_request_slave_channel_reason() is:
> > #define dma_request_slave_channel_reason(dev, name) \
> > 	dma_request_chan(dev, name)  
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
