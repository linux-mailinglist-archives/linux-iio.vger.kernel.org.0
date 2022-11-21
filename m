Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2999632D76
	for <lists+linux-iio@lfdr.de>; Mon, 21 Nov 2022 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiKUTzq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Nov 2022 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiKUTzh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2022 14:55:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A3627C8
        for <linux-iio@vger.kernel.org>; Mon, 21 Nov 2022 11:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669060537; x=1700596537;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qzc8IeErEOyQD7m6+QzjHvzoH3uqPE+LKVXdLyYNaHk=;
  b=eytbGRUp3iArELto8ElyUkT1me3KiTkWBLxY+MvODb+eYZ4DkUIO9B1j
   6v01ibRClbzOjNCDM3HRqjfehPUHo15LWEoqC+x5eo/nIc/21hWPzdG9n
   92nTY845tCzYdEL2EwolFvigdYsrfBAfUsLCz1/Am/nfxOIUL6GJeXf+0
   YYf7syhT/rSXFZT4WBSQldinOnu++26i53fAslSPLajG9DaP9LVaLH7op
   D1mN3HgsJgrVvEZjK4OLae3Rv8xzZuhhVZDzq1ox5Bhfdw210eGZcCgP7
   7ie/wxkJ8JinaUTEA6w67TIAWjxvrDGARgTdZZ0nnS/GFs4fsRzXQfY/3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="301196845"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="301196845"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 11:55:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672215540"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="672215540"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 11:55:36 -0800
Message-ID: <b3d6e375a8c36b7dc7e7ebb5c05e4f4376b4b6f8.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/4] IIO: hid-sensor-als: Use generic usage
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date:   Mon, 21 Nov 2022 11:55:36 -0800
In-Reply-To: <nycvar.YFH.7.76.2211211858160.6045@cbobk.fhfr.pm>
References: <20221117150508.00002704@Huawei.com>
         <20221117234824.6227-1-p.jungkamp@gmx.net>
         <20221117234824.6227-3-p.jungkamp@gmx.net>
         <499ca4a6bbebb458a1132e36462f97121ccb96d3.camel@linux.intel.com>
         <nycvar.YFH.7.76.2211211858160.6045@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2022-11-21 at 18:59 +0100, Jiri Kosina wrote:
> On Fri, 18 Nov 2022, srinivas pandruvada wrote:
> 
> > > Use a generic 'hsdev->usage' instead of the HID_USAGE_SENSOR_ALS
> > > to
> > > allow this driver to drive the Lenovo custom ambient light
> > > sensor,
> > > which is registered under a 'custom' usage and not
> > > HID_USAGE_SENSOR_ALS.
> > > 
> > > Add the Lenovo Intelligent Sensing Solution (LISS) ambient light
> > > sensor
> > > to the platform device ids.
> > > 
> > > Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Is my understanding correct that this Ack is valid for patches 1,2
> and 3 
> (and not for 4) from the series?

Not for the series, I have some comments on others except 2.
So waiting for response.

Thanks,
Srinivas

> 
> Thanks,
> 


