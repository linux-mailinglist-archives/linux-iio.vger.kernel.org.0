Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E084E2DB5
	for <lists+linux-iio@lfdr.de>; Mon, 21 Mar 2022 17:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbiCUQTf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Mar 2022 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiCUQTf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2022 12:19:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC913D60
        for <linux-iio@vger.kernel.org>; Mon, 21 Mar 2022 09:18:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237532347"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="237532347"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:18:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="615687139"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 09:18:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nWKim-0040pj-M6;
        Mon, 21 Mar 2022 18:17:28 +0200
Date:   Mon, 21 Mar 2022 18:17:28 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 09/10] iio: adc: ti-ads1015: Replace data_rate with
 chip data struct ads1015_data
Message-ID: <YjilGMLt/Z0Kiz89@smile.fi.intel.com>
References: <20220320181428.168109-1-marex@denx.de>
 <20220320181428.168109-9-marex@denx.de>
 <CAHp75VczHX=0yZLjDyLdVjLW6ZRz4-ipJN0VERVj0qhp8CEWFQ@mail.gmail.com>
 <cd805097-b670-95dd-4298-72880a0e0a6d@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd805097-b670-95dd-4298-72880a0e0a6d@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 21, 2022 at 03:41:20PM +0100, Marek Vasut wrote:
> On 3/21/22 10:26, Andy Shevchenko wrote:
> > On Sun, Mar 20, 2022 at 8:14 PM Marek Vasut <marex@denx.de> wrote:

...

> > >                          if (period <= ads1015_comp_queue[i] *
> > > -                                       USEC_PER_SEC / data->data_rate[dr])
> > > +                                       USEC_PER_SEC / data_rate[dr])

			if (period <= ads1015_comp_queue[i] * USEC_PER_SEC / data_rate[dr])

> > I would put these two to one line.
> 
> That'd make the line over 80 chars long, is that OK in iio now ?

If not (Jonathan, what's your opinion?), you can do a better splitting

			if (period <=
			    ads1015_comp_queue[i] * USEC_PER_SEC / data_rate[dr])

although I think it's worse than putting on one line.

-- 
With Best Regards,
Andy Shevchenko


