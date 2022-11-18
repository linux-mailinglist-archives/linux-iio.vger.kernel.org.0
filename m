Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8280C62FE9E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Nov 2022 21:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKRUQV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Nov 2022 15:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKRUQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 15:16:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818362E6B2
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 12:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668802580; x=1700338580;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0DQ0u3RCTYdda346AA5OG6m0CtuL0Jk5KQwqWomVBUw=;
  b=XkXgBjK5xNvAzXjGlq/qHmv5h9f7V0da9kINmirLKijvalMsa2t4T8gH
   UD+WkzZXGvIHwlwRc7HpvOff40RHmYWp1UWClvzTcylqLOHR/JsqiBMac
   CqObxknwW7d8ByGtUCmu3Io3Pvtlhe/vzQRv2IQuEeMw6TcF66ArMCBkF
   wEqv9IB9CIAUH94+Dxgs/2gudb74qJuvW7vA48l+P8v+IfPtPfYo8Gh4G
   cBYKFovhE8eF6zOA48C1k4uKHztayZBE3P41Iqm5hZBIRQIXbcrjBw6sU
   yw1DFad3E1jFvRtnnV2MV2JhxnbjKHmhxC7JS3IIxZLsKhr+qbV79CVmr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="314376573"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="314376573"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:16:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="729351083"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="729351083"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 12:16:19 -0800
Message-ID: <566e22568be0a8f231d6acedeece1bc4972ecd82.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/4] HID: hid-sensor-custom: Add LISS custom sensors
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, "Xu, Even" <even.xu@intel.com>
Date:   Fri, 18 Nov 2022 12:16:19 -0800
In-Reply-To: <20221117234302.3875-2-p.jungkamp@gmx.net>
References: <20221117150508.00002704@Huawei.com>
         <20221117234302.3875-1-p.jungkamp@gmx.net>
         <20221117234302.3875-2-p.jungkamp@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-11-18 at 00:43 +0100, Philipp Jungkamp wrote:
> Add the Lenovo Intelligent Sensing Solution (LISS) custom sensors to
> the
> known custom sensors.
> ---
Generally you need write a version history:

v2
..

if no change just write
- No change.


> Here is the requested noop commit that changes the device ids for the
> known
> LISS sensors.
> 
>  drivers/hid/hid-sensor-custom.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 89e56913c92e..85db14406b23 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -782,6 +782,29 @@ static const struct hid_sensor_custom_match
> hid_sensor_custom_known_table[] = {
>                 .luid = "020B000000000000",
>                 .manufacturer = "INTEL",
>         },
> +       /*
> +        * Lenovo Intelligent Sensing Solution (LISS)
> +        */
> +       {       /* ambient light */
> +               .tag = "LISS",
> +               .luid = "0041010200000082",
> +               .model = "STK3X3X Sensor",
> +               .manufacturer = "Vendor 258",
> +               .check_dmi = true,
> +               .dmi.matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               }
> +       },
> +       {       /* human presence */
> +               .tag = "LISS",
> +               .luid = "0226000171AC0081",
> +               .model = "VL53L1_HOD Sensor",
> +               .manufacturer = "ST_MICRO",
> +               .check_dmi = true,
> +               .dmi.matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               }
> +       },
>         {}
>  };
> 
> --
> 2.38.1
> 


