Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220566E2CE
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 16:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjAQPwv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 10:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbjAQPwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 10:52:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C13AA5
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 07:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673970721; x=1705506721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=s2b5KJNqjVR5lBfP2qC6f4akeimG6vMIMgWNwsFxsK8=;
  b=n05frkD42SuTCxMd7gqeO9IQiqtYK6f11Y6PZwXMHE2VG0QS7bzClIGK
   uI2PX/vqj3/tCelWqSbRNPbVdPjoEytO4dQKdcpsHpgGJStr7LQYVAIsd
   3J87rEoLoZfQ5n8ZFMXT2HlOVcrTad5UmZoAX7niULAm0UZTIr0agZO1u
   Q93/e24PkcM47KsdJ2wFA1pDI/WB8aE2JYrhqTjSI28xZ+RjXjtWGIbqt
   gAxFSqw0zNgXRrWZMQZzuEOoh15RBjFZKwU8INxhwtTgIKSwfiUyHt6e6
   rvObI2LyORFy+XpAQQ0wkS5ygpKZO6fUbY6CWXzlHlzFqk1uGhJyHET/g
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="322415954"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="322415954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:51:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="652587820"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="652587820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2023 07:51:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHoFd-00Ae1Q-08;
        Tue, 17 Jan 2023 17:51:53 +0200
Date:   Tue, 17 Jan 2023 17:51:52 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4 1/3] iio: light: vcnl4000: Prepare for more generic
 setup
Message-ID: <Y8bEGIj1JAjyaEg6@smile.fi.intel.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-2-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117152435.3510319-2-marten.lindahl@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 17, 2023 at 04:24:33PM +0100, Mårten Lindahl wrote:
> In order to allow the chip_spec array reference the function pointers
> for interrupts, the code for these functions need to be moved above the
> chip_spec array.
> 
> This is a prestep to support a more generic setup of interrupts.

...

> +	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */

I understand that this just a code move without a single change, but
I have to ask. Don't we use the specific struct layout for this?

Also, 0 is redundant.

P.S. Maybe considered as a followup change(s).

-- 
With Best Regards,
Andy Shevchenko


