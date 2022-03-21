Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C104E2DBA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 17:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348974AbiCUQVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbiCUQVU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 12:21:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADFA8EDE
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 09:19:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="238195877"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="238195877"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:19:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="500224533"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:19:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nWKkH-0040rE-Go;
        Mon, 21 Mar 2022 18:19:01 +0200
Date:   Mon, 21 Mar 2022 18:19:01 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ti-ads1015: Switch to read_avail
Message-ID: <YjildQUsDyehNHqs@smile.fi.intel.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-10-marex@denx.de>
 <CAHp75Vekt0aOcKMfXDhZJaC80DoqTZH30pMj6qFDhgG-guSdcg@mail.gmail.com>
 <8c5772a7-6939-ac33-7b10-acded2b7b9ac@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5772a7-6939-ac33-7b10-acded2b7b9ac@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 21, 2022 at 03:44:24PM +0100, Marek Vasut wrote:
> On 3/21/22 10:27, Andy Shevchenko wrote:
> > On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:

...

> > > +static const int ads1015_fullscale_range[] = {
> > >          6144, 4096, 2048, 1024, 512, 256, 256, 256
> > 
> > Keep a comma at the end.
> > Also applies to the rest of the modified data structures below.
> 
> Why ? We don't expect these arrays to grow new values, if there is ever some
> new ADC, it will likely have its own array.

Just for the sake of a common style. But it's not critical,
so I leave it to the maintainers.

-- 
With Best Regards,
Andy Shevchenko


