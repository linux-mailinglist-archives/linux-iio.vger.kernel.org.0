Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AD2579564
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 10:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiGSIlZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 04:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiGSIlV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 04:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51D22B25
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 01:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88FB61768
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 08:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EE3C341C6;
        Tue, 19 Jul 2022 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658220079;
        bh=qGBay7yiPb7w2dZ0+nHuadnKaMsmFQWr/SQ7QzcADjc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N4QOnYEjPshS+6HWb8ptngyH3x/AQEoWCTHvJQfka/F9nxnnuSzZIvRgdBifcVBA4
         kWUtfdNRztEXdtoVu2/NY4df1vohROI0Oiw5x5qxNKVnB3UMUXo2g8vAXYhD272bRE
         0fPIVfxepNk3Beql2sOKYouJVuOxXHd/cZ/MIEeDjA2qP/L2qeKiIQ/EBOu4rLTMAS
         By7M6dXEDjwMuAVK3iLlnIap00e4PI3GhN44f76V6vJ7bcM07qDFf0aUsHtAS0SNIk
         fXUxgOitZhw75c5aJRqTxC3evHl60Ok1pfkVJSqt1hN8PHUwbH4a7tG41kuexxHovi
         hDpfsJz8W8rIw==
Date:   Tue, 19 Jul 2022 09:51:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-iio@vger.kernel.org, lars@metafoo.de, peda@axentia.se,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Message-ID: <20220719095116.3dc46f3a@jic23-huawei>
In-Reply-To: <20220718184312.11840-1-macroalpha82@gmail.com>
References: <20220718184312.11840-1-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Jul 2022 13:43:12 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Copy the scan_type details from the parent iio channel to the child.
> The scan_type is otherwise empty and things like the storagebits are
> zero (which causes a problem for the adc-joystick driver which
> validates the storagebits when used through a mux). I'm submitting this
> as an RFC because I'm not sure if this is the correct way to handle
> this scenario (a driver that checks the storagebits used with the iio
> multiplexer).
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Seems sensible to me. Though Peter is expert on this one.

One comment on the comment inline...
> ---
>  drivers/iio/multiplexer/iio-mux.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 93558fddfa9b..1de01ec878c4 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -322,6 +322,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>  	if (page)
>  		devm_kfree(dev, page);
>  
> +	/* Copy scan type from parent to mux child. */
Comment is in the obvious category, so drop that.

> +	chan->scan_type = pchan->scan_type;
> +
>  	return 0;
>  }
>  

