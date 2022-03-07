Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7D34D0092
	for <lists+linux-iio@lfdr.de>; Mon,  7 Mar 2022 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbiCGOAQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Mar 2022 09:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbiCGOAP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Mar 2022 09:00:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A24EF64;
        Mon,  7 Mar 2022 05:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646661561; x=1678197561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=liEYBrpkKuowQv0xH2ch7ZjuprN42NIYtT2U9oMPOSA=;
  b=HTNABzdSoIBOAFRxiHtggiK4sjhTO9x1XOQxVFZa04jLW7LWeduvMsRH
   kvX5NCCU5HlX45dsRUTHPwKimyV7iDqUDx/0HCI7iHMAwiQk+Ml+l2vhy
   0D/VMq3qXVgIVRYJXPYEIO05UrcmHAgVJcOF7q6SijIL129J3zmOaTzms
   ZBnN77jLGcbUDd99J3u/O+DAYYIsg5KrUoHcmWXjWgkWSvTXiKUVAP/Pi
   Js+gPfii3/bRO7npk/f4CCV1LSWUcU3HORMJLmKu5GuQ/DYECDAjWd8B8
   y6Rqp/IrkoFJaCFDj1pHpnQp5JT1pxDbmAAU/5LdtEYPBuGxslLcy8x1Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="317624527"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="317624527"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:59:20 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643252589"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 05:59:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRDsf-00CnfJ-Se;
        Mon, 07 Mar 2022 15:58:33 +0200
Date:   Mon, 7 Mar 2022 15:58:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        maemo-leste@lists.dyne.org
Subject: Re: [PATCH v3 0/3] Support LIS302DL in st_accel
Message-ID: <YiYPiStW3ELlfEUr@smile.fi.intel.com>
References: <20220307132502.73854-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307132502.73854-1-absicsz@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 07, 2022 at 03:24:59PM +0200, Sicelo A. Mhlongo wrote:
> Hi,
> 
> The ST Microelectronics LIS302DL is currently only supported in the
> evdev framework driver in drivers/misc/lis3lv02d. This series enables
> support for it in the iio framework.

The entire series is fine to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Regards,
> Sicelo
> 
> 
> 
> Sicelo A. Mhlongo (3):
>   dt-bindings: iio: st,st-sensors add LIS302DL
>   iio: accel: Remove unused enum in st_accel
>   iio: accel: add support for LIS302DL variant
> 
>  .../bindings/iio/st,st-sensors.yaml           |  1 +
>  drivers/iio/accel/st_accel.h                  | 26 +------------------
>  drivers/iio/accel/st_accel_core.c             |  1 +
>  drivers/iio/accel/st_accel_i2c.c              |  5 ++++
>  drivers/iio/accel/st_accel_spi.c              |  5 ++++
>  5 files changed, 13 insertions(+), 25 deletions(-)
> 
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


