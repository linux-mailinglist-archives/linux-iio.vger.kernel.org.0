Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94B34CA6D7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Mar 2022 15:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbiCBOAv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Mar 2022 09:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiCBOAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Mar 2022 09:00:50 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731275C0F;
        Wed,  2 Mar 2022 06:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646229607; x=1677765607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0zRvgEVVCkwhpwxawMEmLKanlSkibn/flJ6Tvgo1Eg=;
  b=nnFn78y2yJFNeoRHzk+Uy4luQlanXaLsJPryv2peLvWr9KSzygGyG3sZ
   JhRT5hfjmHo2SUnJVULXeeeA/3rfdZ95+26PkxsQbCS9aU62WQBu/CMRH
   6re0zbkQHZ0BNpt9XXeGInOOEUBAKewgZXwhqWYM4rNpqrgVkU8SUkgOZ
   pRPCFOsnlmB/zt856f62o8d7VtOQcoKh8MH7JeCNgb39U5SWTqoX963MC
   nPe9QWqFopUKOqFcVZCGleYMQP2WsmbPcZzA6qLcjFr6w2TJ28rXpshhH
   598I4xPnyX51VRBPWiFh/YqKkbXZbdc5lH8UigfLNhY1W8wH0nvRwz2s8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="314122716"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="314122716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:00:06 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="576111735"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:00:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPPVd-00AJiV-3S;
        Wed, 02 Mar 2022 15:59:17 +0200
Date:   Wed, 2 Mar 2022 15:59:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sicelo A. Mhlongo" <absicsz@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/3] iio: accel: add support for LIS302DL variant
Message-ID: <Yh94NEO7jJrChx8z@smile.fi.intel.com>
References: <20220301225432.60844-1-absicsz@gmail.com>
 <20220301225432.60844-4-absicsz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301225432.60844-4-absicsz@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 02, 2022 at 12:54:32AM +0200, Sicelo A. Mhlongo wrote:
> Add support for STMicroelectronics LIS302DL accelerometer to the st_accel
> framework.

> https://www.st.com/resource/en/datasheet/lis302dl.pdf

Can this be converted to Datasheet: tag, please?

> Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>

...

>  drivers/iio/accel/st_accel_i2c.c  | 5 +++++

Doesn't SPI also need to be updated? I believe those sensors are capable
of both interfaces, but correct me, if I'm wrong.

-- 
With Best Regards,
Andy Shevchenko


