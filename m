Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2753F7A8837
	for <lists+linux-iio@lfdr.de>; Wed, 20 Sep 2023 17:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjITPZn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Sep 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjITPZn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 11:25:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD199;
        Wed, 20 Sep 2023 08:25:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F35AC433C7;
        Wed, 20 Sep 2023 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695223536;
        bh=cKKJtd6+8xU0d4IoVORJvkT8CcrQ4AcOu/ccDResadg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MMe1F5k37hwOCMqtUcAljtYV6q9C8JpgJPoACe+7KzKlnfEmlzfR2XX3fio3W5q7r
         jqdbHgpfbi0tL5YGubvmSko/fG3gPJr7F8J/FUnx6MfeelbEzz3r82TK/KTU1O/M3e
         IFdcYnrSe5RnMu2oCNOx+VCREFLShzafUfDbxoRlpbcFhlmoQS4yL0t+jXk9dccLxU
         RMB8b6F8leeDBJrdsUddu+vd3iFg0tMXDNXaLCxJgp8ZyT93pg7v6Cm6dUC+uKXkCG
         BE80CC6c/SqCS0vszr2ue/xobZyBh5MPqJ/S5csvuy1iQvcD1nEP+4rxY5Vtxp0jAk
         boV3Klok59SJw==
Date:   Wed, 20 Sep 2023 17:25:32 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
cc:     benjamin.tissoires@redhat.com, jic23@kernel.org, lars@metafoo.de,
        srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/9] HID: amd_sfh: Add support for SFH1.1 light color
 temperature
In-Reply-To: <20230919081054.2050714-6-Basavaraj.Natikar@amd.com>
Message-ID: <nycvar.YFH.7.76.2309201725280.14216@cbobk.fhfr.pm>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com> <20230919081054.2050714-6-Basavaraj.Natikar@amd.com>
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
> As a result, add support of light color temperature for SFH1.1.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

> ---
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c      |  6 ++++++
>  drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> index 06bdcf072d10..f100aaafa167 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c
> @@ -188,6 +188,7 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
>  	struct sfh_mag_data mag_data;
>  	struct sfh_als_data als_data;
>  	struct hpd_status hpdstatus;
> +	struct sfh_base_info binfo;
>  	void __iomem *sensoraddr;
>  	u8 report_size = 0;
>  
> @@ -235,6 +236,11 @@ static u8 get_input_rep(u8 current_index, int sensor_idx, int report_id,
>  		memcpy_fromio(&als_data, sensoraddr, sizeof(struct sfh_als_data));
>  		get_common_inputs(&als_input.common_property, report_id);
>  		als_input.illuminance_value = float_to_int(als_data.lux);
> +
> +		memcpy_fromio(&binfo, mp2->vsbase, sizeof(struct sfh_base_info));
> +		if (binfo.sbase.s_prop[ALS_IDX].sf.feat & 0x2)
> +			als_input.light_color_temp = als_data.light_color_temp;
> +
>  		report_size = sizeof(als_input);
>  		memcpy(input_report, &als_input, sizeof(als_input));
>  		break;
> diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
> index 9d31d5b510eb..6f6f5db150c3 100644
> --- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
> +++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
> @@ -88,6 +88,16 @@ struct sfh_sensor_list {
>  	};
>  };
>  
> +struct sfh_sensor_prop {
> +	union {
> +		u32 sprop;
> +		struct {
> +			u32 elist	: 16;
> +			u32 feat	: 16;
> +		} sf;
> +	};
> +};
> +
>  struct sfh_base_info {
>  	union {
>  		u32 sfh_base[24];
> @@ -95,6 +105,8 @@ struct sfh_base_info {
>  			struct sfh_platform_info plat_info;
>  			struct sfh_firmware_info  fw_info;
>  			struct sfh_sensor_list s_list;
> +			u32 rsvd;
> +			struct sfh_sensor_prop s_prop[16];
>  		} sbase;
>  	};
>  };
> @@ -134,6 +146,7 @@ struct sfh_mag_data {
>  struct sfh_als_data {
>  	struct sfh_common_data commondata;
>  	u32 lux;
> +	u32 light_color_temp;
>  };
>  
>  struct hpd_status {
> -- 
> 2.25.1
> 

-- 
Jiri Kosina
SUSE Labs

