Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC257A8842
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 17:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbjITP0Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 11:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236617AbjITP0P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 11:26:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A046DD9;
        Wed, 20 Sep 2023 08:26:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA075C433C7;
        Wed, 20 Sep 2023 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695223568;
        bh=3mJZRpck2nfPDRNMhjucawo9RrC/rE2rPsidgMyEFgQ=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kpbCS1JyscU02boVDdqYsm+ZS+NGXx8/r0OcZ5+/c0M8+YuFtRlUjbW1FSc7C+bKq
         0svN7H1x824mts+7z6j0ZuZNfPvI26qUz3hlv3sLwHCvG9sEoUab9LCpNPKcUFMEi1
         KZVbynAd9dlEKwzaZP0yS3GWBBrZwhJjHZG0N711uaG7oExmEo72dDrWqmSUaHymIR
         kYcVvm9s01OCCX2z6/adGilnsuOTDybPwMPE3lImqwzMhw961W83Sb4i5E7WFgdQlr
         lDCBI1uE3HfmYKlp3rBivcbg+Q+dyTHl3Pxy4yJsxvCyn2oeOTCzjvt8f2Gkn2FLnD
         mAskRs26bTqDg==
Date:   Wed, 20 Sep 2023 17:26:04 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc:     benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 9/9] HID: amd_sfh: Add light chromaticity for SFH1.1
In-Reply-To: <20230919081054.2050714-10-Basavaraj.Natikar@amd.com>
Message-ID: <nycvar.YFH.7.76.2309201725530.14216@cbobk.fhfr.pm>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com> <20230919081054.2050714-10-Basavaraj.Natikar@amd.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 Sep 2023, Basavaraj Natikar wrote:

> In most cases, ambient color sensors also support the x and y light
> colors, which represent the coordinates on the CIE 1931 chromaticity
> diagram. Thus, add light chromaticity x and y for SFH1.1.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

> ---
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      | 5 ++++-
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> index f100aaafa167..8a037de08e92 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> @@ -238,8 +238,11 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
>  		als_input.illuminance_value = float_to_int(als_data.lux);
>  
>  		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
> -		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2)
> +		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2) {
>  			als_input.light_color_temp = als_data.light_color_temp;
> +			als_input.chromaticity_x_value = float_to_int(als_data.chromaticity_x);
> +			als_input.chromaticity_y_value = float_to_int(als_data.chromaticity_y);
> +		}
>  
>  		report_size = sizeof(als_input);
>  		memcpy(input_report, &als_input, sizeof(als_input));
> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
> index 6f6f5db150c3..656c3e95ef8c 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
> @@ -147,6 +147,8 @@ struct sfh_als_data {
>  	struct sfh_common_data commondata;
>  	u32 lux;
>  	u32 light_color_temp;
> +	u32 chromaticity_x;
> +	u32 chromaticity_y;
>  };
>  
>  struct hpd_status {
> -- 
> 2.25.1
> 

-- 
Jiri Kosina
SUSE Labs

