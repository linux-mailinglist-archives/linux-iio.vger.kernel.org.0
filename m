Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6F4A363F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354794AbiA3M2j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354778AbiA3M2j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:28:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900DC061714;
        Sun, 30 Jan 2022 04:28:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D51611A6;
        Sun, 30 Jan 2022 12:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B707C340E4;
        Sun, 30 Jan 2022 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643545717;
        bh=ZH7NMTZhIULnPE3aaXaSqB0Wg5JBWfl8SFMQQQN/fAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DXx6DJrOYx5aO346V4ysQS58oIVZQ6aLjs+62099AnkbcW74t/77kmzpo3/Y9MyrQ
         Jo0nu6FEuZ3GIfjnM3fWAP/zUCVs00pYcbjnID7SxnE/mG7nhM8CHGV1vZAVoimqUN
         Hnslwwrwb8vYN4d6pA0/eoVNXIajG8HvWWnOkN4XbXrnzy5KuhzOUba0jsoH4OYCKI
         h2zl6mPv4+FUPDwHV+89I171rBSOGT2+brOlR5n4pq8nUyyazWvhS27Vrbp+LGj45i
         RRHj3mlJNmGhxD/G1mYPFywaMyTqa8Vs721a4QxWaAmgtWzlrM/7/twGH2IgrGBTcR
         vmlxKFQRJNbLw==
Date:   Sun, 30 Jan 2022 12:34:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     linux-iio@vger.kernel.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, anand.ashok.dumbre@xilinx.com,
        lars@metafoo.de, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH 4/4] iio: adc: xilinx-ams: Fix single channel switching
 sequence
Message-ID: <20220130123459.5d44c1ec@jic23-huawei>
In-Reply-To: <20220120010246.3794962-5-robert.hancock@calian.com>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
        <20220120010246.3794962-5-robert.hancock@calian.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jan 2022 19:02:46 -0600
Robert Hancock <robert.hancock@calian.com> wrote:

> Some of the AMS channels need to be read by switching into single-channel
> mode from the normal polling sequence. There was a logic issue in this
> switching code that could cause the first read of these channels to read
> back as zero.
> 
> It appears that the sequencer should be set back to default mode before
> changing the channel selection, and the channel should be set before
> switching the sequencer back into single-channel mode.
> 
> Also, write 1 to the EOC bit in the status register to clear it before
> waiting for it to become set, so that we actually wait for a new
> conversion to complete, and don't proceed based on a previous conversion
> completing.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>

Looking for an Ack from Anand or someone else familiar with this device.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/xilinx-ams.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 199027c93cdc..7bf097fa10cb 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -530,14 +530,18 @@ static int ams_enable_single_channel(struct ams *ams, unsigned int offset)
>  		return -EINVAL;
>  	}
>  
> -	/* set single channel, sequencer off mode */
> +	/* put sysmon in a soft reset to change the sequence */
>  	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> -			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
> +			  AMS_CONF1_SEQ_DEFAULT);
>  
>  	/* write the channel number */
>  	ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
>  			  channel_num);
>  
> +	/* set single channel, sequencer off mode */
> +	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> +			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
> +
>  	return 0;
>  }
>  
> @@ -551,6 +555,8 @@ static int ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
>  	if (ret)
>  		return ret;
>  
> +	/* clear end-of-conversion flag, wait for next conversion to complete */
> +	writel(expect, ams->base + AMS_ISR_1);
>  	ret = readl_poll_timeout(ams->base + AMS_ISR_1, reg, (reg & expect),
>  				 AMS_INIT_POLL_TIME_US, AMS_INIT_TIMEOUT_US);
>  	if (ret)

