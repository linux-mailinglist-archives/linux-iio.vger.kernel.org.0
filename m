Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D022CED4D
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 12:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgLDLl6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 06:41:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:27217 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgLDLl6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Dec 2020 06:41:58 -0500
IronPort-SDR: Gil9a8zw0EodT2TjaKTXtR4XsfQx9G9/KD4HZnMoYt0YcjHg+BViQ/85DWghwlgG13xP/eIM3I
 u5RNd8M2Ub2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="191607328"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="191607328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 03:40:17 -0800
IronPort-SDR: hvFpjHzre32ZyHJQrj1nMCwJiqqvOsRhSxgm9AXawjDt08lvzwXNy7ZqjQGthIchTlPh2DnDF2
 9xCYmTVaoekQ==
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="550920796"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.181.204])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 03:40:16 -0800
Message-ID: <697be63c1500a4ad80651a8182e56ce4271693c1.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] iio:Documentation: Add documentation for hinge
 sensor channels
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ye Xiang <xiang.ye@intel.com>, jikos@kernel.org, jic23@kernel.org
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Dec 2020 03:40:15 -0800
In-Reply-To: <20201203035352.13918-4-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
         <20201203035352.13918-4-xiang.ye@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2020-12-03 at 11:53 +0800, Ye Xiang wrote:
> Add channel description for hinge sensor, including channel label
> attribute and raw data description.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index df42bed09f25..82303b1bdff0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1802,3 +1802,20 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Unscaled light intensity according to CIE 1931/DIN 5033
> color space.
>  		Units after application of scale are nano nanowatts per
> square meter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
Channel "Y" doesn't sound to be a variable. Why not just say "*"

Thanks,
Srinivas

> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Angle of rotation for channel Y. Units after
> application of scale
> +		and offset are radians.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Optional symbolic label for channel Y.
> +		For Intel hid hinge sensor, the label values are:
> +		hinge, keyboard, screen. It means the three channels
> +		each correspond respectively to hinge angle, keyboard
> angle,
> +		and screen angle.

