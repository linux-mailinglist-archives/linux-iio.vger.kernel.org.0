Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4B4FAEFD
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 18:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiDJQkA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiDJQkA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 12:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A257448318
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 09:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 528A2B80B00
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 16:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEE9C385A4;
        Sun, 10 Apr 2022 16:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649608666;
        bh=r1qq+xThA1fwXMqWlPxqZgytiBue7yQjaPp3egl3PuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Shk018oIDDcMqgOPZSvUB9oz4lIlteSIo7P/ZtRoVQKNrLo0HwL0OiqQaNkonHJ2J
         XCZv9KOxr/0sNpVwcJCv9qV28fha3hbL1jbft24cT7gdA91oRh3KHsKZFZyCu+LBEX
         U9vhjfUdsL9LzJMUQVSZWMGrW27Q22y/CsQwpUntUNwqORzIlRaQUWC4T+rSxX2Eku
         8wJlCgWhAeAgkaByaLWi7q787XVaVmQcAXoFWXuoTT5hArLbz1oqD4+R+35bk33DmF
         5IE3NZ+/oQVY34vvSvNFc1AAn2R8hZBUTRZq/L00RXuoeVvFLL0dzCryoZ0jbPdUTV
         NkYKdIxTzGXTQ==
Date:   Sun, 10 Apr 2022 17:45:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <michael.hennerich@analog.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5446: Fix read_raw not returning set value
Message-ID: <20220410174539.0fb10e34@jic23-huawei>
In-Reply-To: <20220406105620.1171340-1-michael.hennerich@analog.com>
References: <20220406105620.1171340-1-michael.hennerich@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 6 Apr 2022 12:56:20 +0200
<michael.hennerich@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> read_raw should return the un-scaled value.
> 
> Fixes: 5e06bdfb46e8b ("staging:iio:dac:ad5446: Return cached value for 'raw' attribute")
Fixes tags are part of the main tag block, so no blank line here.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/dac/ad5446.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 14cfabacbea5..fdf824041497 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -178,7 +178,7 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		*val = st->cached_val;
> +		*val = st->cached_val >> chan->scan_type.shift;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->vref_mv;

