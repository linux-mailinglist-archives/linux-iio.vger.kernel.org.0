Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772D249AF8B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jan 2022 10:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455689AbiAYJLc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jan 2022 04:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454329AbiAYI64 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jan 2022 03:58:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B97C06C584
        for <linux-iio@vger.kernel.org>; Tue, 25 Jan 2022 00:21:20 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCH4f-0000Fb-LA; Tue, 25 Jan 2022 09:21:09 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCH4e-0001We-GG; Tue, 25 Jan 2022 09:21:08 +0100
Date:   Tue, 25 Jan 2022 09:21:08 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     linux-iio@vger.kernel.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, anand.ashok.dumbre@xilinx.com,
        jic23@kernel.org, lars@metafoo.de, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer register
 settings
Message-ID: <20220125082108.GE25856@pengutronix.de>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
 <20220120010246.3794962-4-robert.hancock@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220120010246.3794962-4-robert.hancock@calian.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:17:51 up 45 days, 17:03, 75 users,  load average: 0.09, 0.13,
 0.22
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jan 2022 19:02:45 -0600, Robert Hancock wrote:
> Register settings used for the sequencer configuration register
> were incorrect, causing some inputs to not be read properly.
> 
> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> ---
>  drivers/iio/adc/xilinx-ams.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index b93864362dac..199027c93cdc 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -91,8 +91,8 @@
>  
>  #define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
>  #define AMS_CONF1_SEQ_DEFAULT		FIELD_PREP(AMS_CONF1_SEQ_MASK, 0)
> -#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 1)
> -#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
> +#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
> +#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK, 3)

The TRM states that Continuous Loop Mode is 2, but Single Pass Sequence Mode
is 1, not 3. Is there a reason, why you need to set both bits?

Michael

>  
>  #define AMS_REG_SEQ0_MASK		GENMASK(15, 0)
>  #define AMS_REG_SEQ2_MASK		GENMASK(21, 16)
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
