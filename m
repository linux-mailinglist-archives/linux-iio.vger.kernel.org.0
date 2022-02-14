Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D242F4B5228
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 14:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiBNNvY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 08:51:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBNNvX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 08:51:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FD49FB2;
        Mon, 14 Feb 2022 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644846675; x=1676382675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hDs9gRO/GUR9OEq0XvETsLm6kPmyTsfZT1pnOepiDE8=;
  b=nM9Ssa+1N5wM6xfg+/iUUuPiQq5MNIzCUto2QMza4c3xs72eU88ms1cc
   LeoYkCWBCx99cGHSjWUWbU0/zgN4901SvsEqyfxP3VrE3hUTzSgn2nBTH
   MsG84nDHmT0Gz897mXduPtru5fbOoaUOpiFQIemcwkyxTHHU6/ptQw0th
   4vl63jK0Xc540c/cxHEX+YKc+Ea0yteiCkY9fzQ/ClBW9QkIbWZEjZFNM
   WyddtGpo3CLv/Hy7gkSKq6mvqQXoIeUoMymcGk130W+EIxp5we4mL/dME
   H4b6dUVNToK8b4vF0fByV8hwiXJ0s7CL/hfhb4dBAH8pOk5heVVQfJfPg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336517448"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="336517448"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:51:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="624228521"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 05:51:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nJbkA-004YZT-3u;
        Mon, 14 Feb 2022 15:50:18 +0200
Date:   Mon, 14 Feb 2022 15:50:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 1/3] iio: dac: add support for ltc2688
Message-ID: <YgpeGZYTHWlmVZEU@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-2-nuno.sa@analog.com>
 <Yf60A1UkbBtQ68qv@smile.fi.intel.com>
 <PH0PR03MB678628C341A1972BC31F5BBA992B9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <YgD91zg4L1S5KH5k@smile.fi.intel.com>
 <e1bd9f14e63e55f48f804568705a9ab8c1a09f62.camel@gmail.com>
 <0fc9da519df96aaeb3cdcd155fb8aabbdc17fbeb.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fc9da519df96aaeb3cdcd155fb8aabbdc17fbeb.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Feb 14, 2022 at 02:23:01PM +0100, Nuno Sá wrote:
> On Mon, 2022-02-07 at 21:19 +0100, Nuno Sá wrote:

> I would definetly like to have some settlement on the above (before
> sending a v4). It kind of was discussed a bit already in [1] where I
> felt we had to live with OF for this driver (that is why I kept OF in
> v3. With the above, I cannot
> really see how we can have device API with also including OF... If I
> missing something please let me know :)

Sorry for the delay, answered to your previous message.

> [1]: https://lore.kernel.org/all/CAHp75VczFs8QpsY7tuB-h4X=H54nyjABA4qDSmpQ+FRYAHZdrA@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


