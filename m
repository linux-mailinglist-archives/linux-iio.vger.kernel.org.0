Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7276397C8
	for <lists+linux-iio@lfdr.de>; Sat, 26 Nov 2022 19:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKZS7W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Nov 2022 13:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiKZS7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2022 13:59:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04EB19C35
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 10:59:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BE92B80139
        for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2022 18:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E940C433C1;
        Sat, 26 Nov 2022 18:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669489153;
        bh=zt/KMIbFNXkACe3jn2wSLLLBME2uRWl8fAUpP6306Vg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ipGZbibPjDUSGkIzhtoRr2YJlG09wsQyJ4ulrnuKiLt6zE82gjWE/fHi+mj1i0aTS
         bnI8lg4e44PaI6eLCCPlRot3EaxhXQWHE1elRNW7tjMoYnf1EX0wGi2fhBlhJ8yS/2
         d5lPc9ACT9GxHKol0QKAYV2aaobJ0k0HlmyA6CETNrLii+hNPxxSaJJ5agbccRAZrp
         oZ63xTV+MihsCsBJ3SxFeker4OWJnR723Z8rGjPO/v/qGdpGksjwJppUrvNV12GVUX
         WN0OJPidV4W6Vd9UZs2B3jVmqiVUzGEboyiJEw5H64KL2ftFksUfsfUfJ8+N9lGteZ
         Kb2bHz+oXsUFg==
Date:   Sat, 26 Nov 2022 19:11:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/4] HID: hid-sensor-custom: Add LISS custom sensors
Message-ID: <20221126191150.7f12c1fd@jic23-huawei>
In-Reply-To: <20221124233841.3103-3-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
        <20221124233841.3103-3-p.jungkamp@gmx.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Nov 2022 00:38:39 +0100
Philipp Jungkamp <p.jungkamp@gmx.net> wrote:

> Add the Lenovo Intelligent Sensing Solution (LISS) custom sensors to the
> known custom sensors.
> 
> Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
Obviously not much to actually review here, beyond 'it looks plausible'.
FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> v2:
> - Create this 'noop' patch that just adds the LISS sensors to the custom
>   sensor match table.
> 
> v3:
> - Add missing 'Signed-Off-By'
> 
> v4:
> - No change.
> 
>  drivers/hid/hid-sensor-custom.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 734c6bde68fe..7c6e2e795753 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -782,6 +782,29 @@ static const struct hid_sensor_custom_match hid_sensor_custom_known_table[] = {
>  		.luid = "020B000000000000",
>  		.manufacturer = "INTEL",
>  	},
> +	/*
> +	 * Lenovo Intelligent Sensing Solution (LISS)
> +	 */
> +	{	/* ambient light */
> +		.tag = "LISS",
> +		.luid = "0041010200000082",
> +		.model = "STK3X3X Sensor",
> +		.manufacturer = "Vendor 258",
> +		.check_dmi = true,
> +		.dmi.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		}
> +	},
> +	{	/* human presence */
> +		.tag = "LISS",
> +		.luid = "0226000171AC0081",
> +		.model = "VL53L1_HOD Sensor",
> +		.manufacturer = "ST_MICRO",
> +		.check_dmi = true,
> +		.dmi.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		}
> +	},
>  	{}
>  };
> 
> --
> 2.38.1
> 

