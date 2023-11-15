Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16087DCB03
	for <lists+linux-iio@lfdr.de>; Tue, 31 Oct 2023 11:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343692AbjJaKif (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Oct 2023 06:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbjJaKie (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Oct 2023 06:38:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35D83;
        Tue, 31 Oct 2023 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698748712; x=1730284712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3YWDf1NX0vV0KjfCqqHzU9+x4C2KVyU+FzOd4nHXStM=;
  b=CLSwr6EtM5la8O5+sd1oBF5Rx6g8C77mT0KrasNGgW4ZWIvHHLm99VKW
   J4DQuqjOxDj5cXqYLvwUv5r7p2Sy1gkwW4HybUrfWjbZBsIuB/Ajw3cys
   Pvut640gxM1GtPcGshcJLgThCIsUNyLyc5Ia/XHvzbbcf5DW6d5hIto7c
   N4hv4JTiFX5kjn5Us4b9v4HoHF6HhA1jUX4H1NdBSAaafF2dWbHrvs/Dr
   XpWxggKo4poquzKg3625BtPBsE2mdXLTwU7kJUI9enfDXKnigiptXD7U7
   1TeoQ1aEtvD88GcDodMHpSc4N1SISa5YonEojvwHW9ta6fQtAOz7mpQgK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452535567"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="452535567"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="904306946"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="904306946"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:38:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxm8f-0000000A7Cp-0bVz;
        Tue, 31 Oct 2023 12:38:25 +0200
Date:   Tue, 31 Oct 2023 12:38:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZUDZIEY_uTVMHh3C@smile.fi.intel.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
 <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
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

On Tue, Oct 31, 2023 at 09:11:37AM +0200, Matti Vaittinen wrote:
> On 10/30/23 12:21, Matti Vaittinen wrote:
> > On 10/29/23 17:51, Matti Vaittinen wrote:
> > > On 10/28/23 18:20, Jonathan Cameron wrote:

...

> 	tmp = gts->max_scale;
> 
> 	rem = do_div(tmp, total_gain);
> 	if (total_gain > 1 && rem >= total_gain / 2)
> 		tmp += 1ULL;

...which is NIH DIV_ROUND_CLOSEST_ULL()

-- 
With Best Regards,
Andy Shevchenko


