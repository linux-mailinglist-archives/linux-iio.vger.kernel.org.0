Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E84A38D8
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356034AbiA3T7I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiA3T7H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:59:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651ECC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F35D2612FA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8298AC340E4;
        Sun, 30 Jan 2022 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643572746;
        bh=pG3kX/taBw8Wy7V3+UB/ae7JdBgEyblXPavXPDTxuGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QMkxuZQgFZbCmPI/L+uHpDj/EuDxaqK7k4HhOaZs5vHd9s239ldL4DvFYf1p6+5uz
         EWQHBwC82mrRyGp9Tvnm6awLrYvNLfXb1AYG4ZMC6Qz17+IGk0nKw930/jaWbmOZhV
         o1UtyE3xqCk5cem1D3i+/XaG7gGSKNRyiPhstTMqE3wnGpo/eglmm5UJSBWytpSx33
         HOnlLc6IL8wi8SQnuBPJIjaaQibfO2RfWE3EJ7igpG1pq2IxhRWkzNJ0ImAJXlkwvn
         yaM9GpUg4em3ah+rVgi7+39IcUGYRD13k7XoIQpmLw2hYLEJ/N/gsltoSXGV14EHfm
         L7qYVtrwXqCrg==
Date:   Sun, 30 Jan 2022 20:05:31 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 12/17] staging:iio:ad7280a: Reflect optionality of
 irq in ABI
Message-ID: <20220130200531.294330c8@jic23-huawei>
In-Reply-To: <Yb5Ezoa2mHoONp7J@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-13-jic23@kernel.org>
        <Yb5Ezoa2mHoONp7J@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Dec 2021 17:30:06 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Not much confident about the attributes of ad7280_info_no_irq.
> With that seen:
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Given the irq is optional, let us remove the interfaces related to
> > events when it is not present.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
>> > +static const struct iio_info ad7280_info_no_irq = {
> > +	.read_event_value = &ad7280a_read_thresh,
> > +	.write_event_value = &ad7280a_write_thresh,  
> Think this should be
> 	.read_raw = ad7280_read_raw,
> 	.write_raw = ad7280_write_raw,
Good spot!  You are of course correct. Not sure how I managed that
particular piece of idiocy.

Thanks,

Jonathan
