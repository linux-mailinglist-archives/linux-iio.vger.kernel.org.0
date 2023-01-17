Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2575566E2D7
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjAQPyV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjAQPyC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 10:54:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E63AA5
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 07:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673970841; x=1705506841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jnMuJ+2MGoXFt6sQj2gUidkkZw7NOtuB3SYXeHaztXQ=;
  b=jE8EbLc1S6UHp5TmDukDO12yX4vqPYy3zm0HuLGm4738+R5ELP/Aiqhm
   APzB9xiLAzVWhFvpOYu/fqq1dALlylRmL7bUY4OJYiSOw7TgSfyNDxZgW
   tVRi9TSQyPPYLc5FzYKCbq96YDYvlrMPBv0lJ4xHOwk0+Vf+Mt2fJkV1f
   fXcMgn/FKU6e9rgl6lP16qz39TsQZ+jiaYAPtZL784K8MxPy+4hwlqnzl
   IvJ8ehv/RPh5Uoj69VrVmH2Wd+x2iCZEK29aLITKGd89rLGEJQGfjEs6O
   WdoLJTet/OF8eIzR9iEQ07JrYmfNOVex2A7gyjHuMQvSpGvX2EwaOwjxW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351974084"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="351974084"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:54:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="722712973"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="722712973"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jan 2023 07:53:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHoHe-00Ae5C-0i;
        Tue, 17 Jan 2023 17:53:58 +0200
Date:   Tue, 17 Jan 2023 17:53:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4 2/3] iio: light: vcnl4000: Make irq handling more
 generic
Message-ID: <Y8bElUjlLNGFPH3p@smile.fi.intel.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-3-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117152435.3510319-3-marten.lindahl@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 17, 2023 at 04:24:34PM +0100, Mårten Lindahl wrote:
> This driver supports 4 chips, by which only one (vcnl4010) handles
> interrupts and has support for triggered buffer. The setup of these
> functions is hardcoded for vcnl4010 inside the generic vcnl4000_probe,
> and thus ignores the chip specific configuration structure where all
> other chip specific functions are specified.
> 
> This complicates adding interrupt handler and triggered buffer support
> to chips which may have support for it.
> 
> Add members for irq threads and iio_buffer_setup_ops to the generic
> vcnl4000_chip_spec struct, so that instead of checking a chip specific
> boolean irq support, we check for a chip specific triggered buffer
> handler, and/or a chip specific irq thread handler.

Thank for an update!

...

> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> -						NULL, vcnl4010_irq_thread,

> +		ret = devm_request_threaded_irq(&client->dev,
> +						client->irq, NULL,

But why first line has been changed now?

-- 
With Best Regards,
Andy Shevchenko


