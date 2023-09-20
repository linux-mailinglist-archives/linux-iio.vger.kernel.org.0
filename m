Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA67A883C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjITPZ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjITPZz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 11:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2913DAF;
        Wed, 20 Sep 2023 08:25:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCD5C433C9;
        Wed, 20 Sep 2023 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695223548;
        bh=NT+/Z4OZKm8sTKjfy6UsboiyZqkvVAjVlz5TcrzbO0I=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jafAfjXb77GBbQvXqxzZ/Kl1dDH8fdb7NG8SfirRKPoJ2aNMf0J2pmwVT9gMbkkzp
         Qhf1NVtKxHnumZyHmXPTVht0nVLimlW18G1gCTKthMf1VidGFUomTWDksZtSWOHoUi
         NvpTCjajLsamGyugB6DGofVXkdFuRewIaWu1iWwDHYb0jBgHRcQlN88WaqAzOJ8FRG
         zYmlaLsbzUXAe5gmMJpJa/nhZf5NnHp0ZcPAl/KiKhdyde9+s2AEBBHC2I+h13Bdyh
         SmIGJwY0gQ8ogr0WfzV90o1lwqlq8z8luNaf4mebzMjUn8/KKxZ33dlQvscT/kHGiw
         3aj4Km4b/i1Mw==
Date:   Wed, 20 Sep 2023 17:25:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc:     benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 8/9] HID: amd_sfh: Add light chromaticity support
In-Reply-To: <20230919081054.2050714-9-Basavaraj.Natikar@amd.com>
Message-ID: <nycvar.YFH.7.76.2309201725390.14216@cbobk.fhfr.pm>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com> <20230919081054.2050714-9-Basavaraj.Natikar@amd.com>
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
> diagram. Thus, add light chromaticity x and y.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

> ---
>  .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  |  5 ++++-
>  .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  |  2 ++
>  .../hid_descriptor/amd_sfh_hid_report_desc.h       | 14 ++++++++++++++
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> index b7e732ec4806..ef1f9be8b893 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> @@ -258,8 +258,11 @@ static u8 get_input_report(u8 current_index, int sensor_idx, int report_id,
>  			als_input.illuminance_value =
>  				(int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
>  
> -		if (sensor_idx == ACS_IDX)
> +		if (sensor_idx == ACS_IDX) {
>  			als_input.light_color_temp = sensor_virt_addr[1];
> +			als_input.chromaticity_x_value = sensor_virt_addr[2];
> +			als_input.chromaticity_y_value = sensor_virt_addr[3];
> +		}
>  
>  		report_size = sizeof(als_input);
>  		memcpy(input_report, &als_input, sizeof(als_input));
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> index a7fc50deca4d..882434b1501f 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> @@ -100,6 +100,8 @@ struct als_input_report {
>  	/* values specific to this sensor */
>  	int illuminance_value;
>  	int light_color_temp;
> +	int chromaticity_x_value;
> +	int chromaticity_y_value;
>  } __packed;
>  
>  struct hpd_feature_report {
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> index 26e994e54ded..67ec2d6a417d 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> @@ -648,6 +648,20 @@ static const u8 als_report_descriptor[] = {
>  0x75, 32,		/* HID report size(32) */
>  0x95, 1,		/* HID report count (1) */
>  0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
> +0x0A, 0xD4, 0x04,       /* HID usage sensor data light chromaticity_x */
> +0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
> +0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
> +0x55, 0x0,		/* HID unit exponent(0x0) */
> +0x75, 32,		/* HID report size(32) */
> +0x95, 1,		/* HID report count(1) */
> +0X81, 0x02,		/* HID Input (Data_Var_Abs) */
> +0x0A, 0xD5, 0x04,       /* HID usage sensor data light chromaticity_y */
> +0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
> +0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
> +0x55, 0x0,		/* HID unit exponent(0x0) */
> +0x75, 32,		/* HID report size(32) */
> +0x95, 1,		/* HID report count (1) */
> +0X81, 0x02,		/* HID Input (Data_Var_Abs) */
>  0xC0			/* HID end collection */
>  };
>  
> -- 
> 2.25.1
> 

-- 
Jiri Kosina
SUSE Labs

