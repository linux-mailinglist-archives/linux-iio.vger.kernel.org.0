Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765806F98A5
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGNaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjEGNaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 09:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050E1635F
        for <linux-iio@vger.kernel.org>; Sun,  7 May 2023 06:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C6A60ED3
        for <linux-iio@vger.kernel.org>; Sun,  7 May 2023 13:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA77C433EF;
        Sun,  7 May 2023 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683466214;
        bh=uDoPVD3PzzZ8sakQbA34T9qSuMTGXrKiRoI7rRPXkI4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jBUuQ5JvSuQOYx09APrgRR+lCZkwRrlUAloRVQ4tYz+gu8IfQWjfjyh4MjQKscEeS
         k4sxm3gUHBvjyFXBLl7ij7PLZY7eP5Fd88uej8PHJa+AIroybWXvdMj1tYOjrgimNO
         09QND3yFq4zS/UBd0F5Bo4sAznOTeC2skAEdAb0vMXitpthaRcCHPhMiP1gi4aiDnF
         6JnhYzlrvEsuRZpFjh8zy1aOT7Mbmo+SD1FtGmj0KcT6Md9mMLCr0tc60YvZ+rQqdM
         9/lbD52V+3ZDZ3Xe1K9keaWptp67V/++eL3hRItZVDGzSfvcTOTmYqJSMUQSAsbkbX
         kUYV8erHKQ0MQ==
Date:   Sun, 7 May 2023 14:46:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe De Muyter <Philippe.DeMuyter@macq.eu>
Cc:     linux-iio@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: dac: ad5446: Add ID of compatible Texas
 Instruments i2c dac121c*
Message-ID: <20230507144608.15e7aa8e@jic23-huawei>
In-Reply-To: <1683450625-28789-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1683450625-28789-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Sun,  7 May 2023 11:10:25 +0200
Philippe De Muyter <Philippe.DeMuyter@macq.eu> wrote:

> From: Philippe De Muyter <phdm@macqel.be>
> 
> The Texas Instruments DAC121C* chips are the I2C counterparts of
> the DAC121S* SPI chips which are already supported by this ad5446 driver.
> 
> Add them to the compatible list.

Hi Philippe,

DT binding should be updated and include the fallback to adi,ad5622.
Does this driver actually have a bindings doc?  If not please add one
as a precursor patch then add binding for this new part on top.

> 
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/dac/ad5446.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index aa3130b33456..b95c0ccbb796 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -587,6 +587,7 @@ static const struct i2c_device_id ad5446_i2c_ids[] = {
>  	{"ad5602", ID_AD5602},
>  	{"ad5612", ID_AD5612},
>  	{"ad5622", ID_AD5622},
> +	{"dac121", ID_AD5622}, /* 'ti,' is dropped by 'of_modalias_node' */

True, but why is the comment needed?
Also, for consistency with the spi equivalent it should be dac121c101 or similar
I think.

I think this use of the driver with multiple vendor prefixes,
also indicates we should really add the of_device_id table for this
driver. To do that nicely will require more changes as we'd want to do
the same for the SPI side which has a single entry table (which is odd)
then deal with the data fields which should probably all be pointers
rather than enum values.

Still I'm fine with proper explicit DT support being left for a follow up patch.

I do want the missing binding doc fixed though (which is independent of the
question of how the driver binds based on the compatible values).

Thanks,

Jonathan


>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);

