Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44B7A8835
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 17:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjITPZa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjITPZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 11:25:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5078A94;
        Wed, 20 Sep 2023 08:25:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D46C433C8;
        Wed, 20 Sep 2023 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695223523;
        bh=ZiBsCTCrBVfl68Lk8+0/R5+btk+GfgbSawllXUfhdFU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JusXf98XeE0iiXwq7avJgGY9UQpXctvZa4s2pa8lX010SDynWAAlCrIVW6IMInaK+
         8Tz9PVVsp9c9Mvp8V267FdsoEvATDsIqj5D2X2wt6FaNrjdn9034v6u3Z7RekigLBI
         A0WcNmkRm1r9T2cLZ2nhDjnkKSQeM4X4di7FJF79KuM5acWRZmutOL7zIlfNn0GhIF
         5GKi1pqdSsqTGrv70bKmMTK4EeEsWyUtn9uOFhu2y56Tlkk0+XVpPkNJna+ddN9029
         hd6A1tbjOvFJJcLGIcXjtsacIZcbAXWE2D8fvwQ3lxyxWaj6LliLOjgH/IhMdTDdZ8
         8erOB5GYTl0EQ==
Date:   Wed, 20 Sep 2023 17:25:19 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc:     benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/9] HID: amd_sfh: Add support for light color
 temperature
In-Reply-To: <20230919081054.2050714-5-Basavaraj.Natikar@amd.com>
Message-ID: <nycvar.YFH.7.76.2309201725060.14216@cbobk.fhfr.pm>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com> <20230919081054.2050714-5-Basavaraj.Natikar@amd.com>
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

> In most cases, ambient color sensors also support light color temperature.
> As a result, add support of light color temperature.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

> ---
>  drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  | 4 ++++
>  drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  | 1 +
>  .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h   | 7 +++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> index 8716a05950c8..b7e732ec4806 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> @@ -257,6 +257,10 @@ static u8 get_input_report(u8 current_index, int sensor_idx, int report_id,
>  		else
>  			als_input.illuminance_value =
>  				(int)sensor_virt_addr[0] / AMD_SFH_FW_MULTIPLIER;
> +
> +		if (sensor_idx == ACS_IDX)
> +			als_input.light_color_temp = sensor_virt_addr[1];
> +
>  		report_size = sizeof(als_input);
>  		memcpy(input_report, &als_input, sizeof(als_input));
>  		break;
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> index ebd55675eb62..a7fc50deca4d 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> @@ -99,6 +99,7 @@ struct als_input_report {
>  	struct common_input_property common_property;
>  	/* values specific to this sensor */
>  	int illuminance_value;
> +	int light_color_temp;
>  } __packed;
>  
>  struct hpd_feature_report {
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> index 697f2791ea9c..26e994e54ded 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> @@ -641,6 +641,13 @@ static const u8 als_report_descriptor[] = {
>  0x75, 32,		/* HID report size(32) */
>  0x95, 1,		/* HID report count (1) */
>  0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
> +0x0A, 0xD2, 0x04,	/* HID usage sensor data light temperature */
> +0x17, 0x00, 0x00, 0x01, 0x80,	 /* HID logical Min_32 */
> +0x27, 0xFF, 0xFF, 0xFF, 0x7F,	 /* HID logical Max_32 */
> +0x55, 0x0,		/* HID unit exponent(0x0) */
> +0x75, 32,		/* HID report size(32) */
> +0x95, 1,		/* HID report count (1) */
> +0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
>  0xC0			/* HID end collection */
>  };
>  
> -- 
> 2.25.1
> 

-- 
Jiri Kosina
SUSE Labs

