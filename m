Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4C639C08
	for <lists+linux-iio@lfdr.de>; Sun, 27 Nov 2022 18:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK0RdM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Nov 2022 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiK0RdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2022 12:33:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5BB7ED
        for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2022 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669570386; x=1701106386;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5JEfA3+1ln7mVa4ihT+X6W6imSzvKjUcBCBMu3iGTkg=;
  b=Z8hyEN7+PDs3bZZJtRnoCM5ekzWWu5JNXA3raS06sYt5KnYAB660eHMV
   CasO/I+rojQX+MVC89TqV6fYK6MTWK/MKB2d/kPZs5J9TC0yFhRrhNUdt
   BAf34MHzWtud2OA1uudwh/XcFmV0UI4Lubf+qkiR/+YnIgm7XQ5RDUVN9
   CUuh7aw7fVIwMd0bYuMaK0eIkTf/8IlRxpZcT85KSxBuOiqZIEAxkSCS+
   W9c1waxTI8dLshcH7lp0ob/CKOH/cWvEZ4b+hs9PPe7HhwRbe89bNAQKo
   vn1Vxua0uIaSha2CgSeHO6m4bQJB12BMiXfd+8sc2TMkG7KN8YZ8bq3hU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="378943980"
X-IronPort-AV: E=Sophos;i="5.96,198,1665471600"; 
   d="scan'208";a="378943980"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 09:33:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749107894"
X-IronPort-AV: E=Sophos;i="5.96,198,1665471600"; 
   d="scan'208";a="749107894"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 09:33:05 -0800
Message-ID: <623f2206647e69199c64064c48eb8bf03afb99da.camel@linux.intel.com>
Subject: Re: [PATCH v4 0/4] IIO: More HID custom sensors
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Philipp Jungkamp <p.jungkamp@gmx.net>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Sun, 27 Nov 2022 09:33:04 -0800
In-Reply-To: <20221124233841.3103-1-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2022-11-25 at 00:38 +0100, Philipp Jungkamp wrote:
> Hello,
> 
> I'm sorry for the confusion caused by me sending revisions as replies.
> I've now addresses the points raised. As I'm unfamiliar with mailing
> lists
> any recommendation on making the process more seamless is welcome.
> 
> Thank you for your time!
> 

For the series

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> v2:
> - Patch 1/4:
>   - Remove unnecessary comments.
>   - Change return type of functions to bool. (introduced an error,
> fixed in v4)
>   - Swallows return value of a function. (fixed in v4)
> - Patch 2/4:
>   - Create this 'noop' patch that just adds the LISS sensors to the
> custom
>     sensor match table.
> - Patch 3/4:
>   - Remove some unnecessary newlines in function calls.
> - Patch 4/4:
>   - Allow for 1 byte human presence reports.
> 
> v3:
> - Patch 2/4
>   - Add missing 'Signed-Off-By'
> 
> v4:
> - Patch 1/4:
>   - Fix return value and error codes on property query.
>   - Document and ignore return values for queries of optionally matched
>     properties.
>   - Don't modify *known in _get_known, return error when not matched.
>   - Remove comment on newly added sensors from commit message.
> - Patch 4/4:
>   - Clean up switch statement.
> 
> Regards,
> Philipp Jungkamp
> 
> Philipp Jungkamp (4):
>   HID: hid-sensor-custom: Allow more custom iio sensors
>   HID: hid-sensor-custom: Add LISS custom sensors
>   IIO: hid-sensor-als: Use generic usage
>   IIO: hid-sensor-prox: Use generic usage
> 
>  drivers/hid/hid-sensor-custom.c     | 233 +++++++++++++++++++---------
>  drivers/iio/light/hid-sensor-als.c  |  27 ++--
>  drivers/iio/light/hid-sensor-prox.c |  37 +++--
>  include/linux/hid-sensor-ids.h      |   1 +
>  4 files changed, 199 insertions(+), 99 deletions(-)
> 
> --
> 2.38.1
> 


