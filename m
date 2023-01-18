Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3367173C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jan 2023 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjARJRE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Jan 2023 04:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjARJPn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2023 04:15:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023D4B4A3
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2023 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674030789; x=1705566789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T549ODVG8zfBRXIpfIjukAoRzq44j8uQoLc0rJEvFJc=;
  b=mbJIR1kn6eoncAzKNNpqGslAyiKLnPNmDwEEnovfFHxjDHWtblngPXJr
   HDw4HtzbZDbGb4aJlg/nQU3R4HHg4d7CZ3/ck8oNy6midcshwmaYoH7cl
   fK6bE1DBjYyC2gyJwqjPz95KF91QHxVPkQWSF5hny2FIBRWb1h383y9Xb
   K5Lj21MxEKg4AhGJH0tqvMLIqI1/Yw7pJGA3d+4UakbELI5kvMP9oN9KO
   xZorZ5KNqrPVisoXnyVK6SS7pMq1PGatEuHetRm45RSlaKRqSYHLKGj35
   GnEeECYUOYvX5MgdhA1QyLAEg6fPKDTK6IcRNICjn6aM8DmHFj+j3Z+ja
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411171491"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411171491"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 00:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="783587032"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="783587032"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 18 Jan 2023 00:33:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pI3sX-00B0xr-0j;
        Wed, 18 Jan 2023 10:33:05 +0200
Date:   Wed, 18 Jan 2023 10:33:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v5 0/3] iio: light: vcnl4000: Add vcnl4040 interrupt
 support
Message-ID: <Y8euwCLiKww7+AFe@smile.fi.intel.com>
References: <20230117190017.3789181-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117190017.3789181-1-marten.lindahl@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 17, 2023 at 08:00:14PM +0100, Mårten Lindahl wrote:
> Hi!
> 
> I have made three patches to add support for proximity sensor
> interrupts with the vcnl4040 sensor.
> 
> The first two patches are minor restructuring of the current setup for
> interrupts since the probe function hardcodes it for vcnl4010 only.
> 
> The third patch adds support to configure proximity sensor interrupts
> and threshold limits for vcnl4040.

The series looks good enough to me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Kind regards
> Mårten Lindahl
> 
> Changes in v5:
>  - Restore one more unnecessary line change
>  - Fix indentation
>  - Build reg value in a clearer way
> 
> Changes in v4:
>  - Restore unnecessary line changes
>  - Remove unnecessary typecast
> 
> Changes in v3:
>  - Only register iio_trigger when there is an irq_thread function
> 
> Changes in v2:
>  - Make restructure of functions for interrupts and triggered buffer
>    in separate patch
>  - Add check for buffer_setup_ops
>  - Remove irq dependency for devm_iio_triggered_buffer_setup
>  - Change size of register variable and document it
>  - Use field definitions for read/write event_config
> 
> Mårten Lindahl (3):
>   iio: light: vcnl4000: Prepare for more generic setup
>   iio: light: vcnl4000: Make irq handling more generic
>   iio: light: vcnl4000: Add interrupt support for vcnl4040
> 
>  drivers/iio/light/vcnl4000.c | 449 ++++++++++++++++++++++++-----------
>  1 file changed, 311 insertions(+), 138 deletions(-)
> 
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


