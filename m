Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB0966E2EB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 16:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjAQP7C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 10:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAQP7A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 10:59:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9732BF05
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673971138; x=1705507138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/w+dJrVtCKUqjMAxdXAlcJK25bOJH9/p97S8eFefprg=;
  b=TYnjZmMwllA26nPTs6o68igdEWcLdNwK5f4TvdBaTRa28RzyKY71TJvk
   bH89aZn5n6QJIolCOqgCt3xXiO8+eiQSQbH+lnTgP0Rjtm6fELjH0RxE4
   ZF8dpuKvCg+A2YgcKLU8C5QS/gBdDaDc6xT0MgWgIkButmrlp2Bw7F370
   QG+ba3eouy0IOax8Nzh+Pcp7qfLDDxZ2qdEX1PTJA7k1eR274lG+4QSMI
   M5d0zwzMkvhUhMxveOanZaZXi79eUmwN15hwKGJJ//oio0rTb9DBPoqaz
   p7cjIIEApScK5hRX6GOzh4WJH453eynOFfbh4E6HV4pAaLj080hDKGYds
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="351975352"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="351975352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 07:58:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="691635047"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="691635047"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2023 07:58:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pHoMQ-00AeBO-2p;
        Tue, 17 Jan 2023 17:58:54 +0200
Date:   Tue, 17 Jan 2023 17:58:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v4 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Message-ID: <Y8bFvovmqKCO6fVC@smile.fi.intel.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-4-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117152435.3510319-4-marten.lindahl@axis.com>
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

On Tue, Jan 17, 2023 at 04:24:35PM +0100, Mårten Lindahl wrote:
> Add support to configure proximity sensor interrupts and threshold
> limits for vcnl4040. If an interrupt is detected an event will be
> pushed to the event interface.

...

> +	return (dir == IIO_EV_DIR_RISING) ?

> +	    FIELD_GET(VCNL4040_PS_IF_AWAY, ret) :
> +	    FIELD_GET(VCNL4040_PS_IF_CLOSE, ret);

Indentation issues?

...

> +	val = ret;
> +
> +	if (dir == IIO_EV_DIR_RISING)
> +		val = state ? (val | VCNL4040_PS_IF_AWAY) :
> +		    (val & ~VCNL4040_PS_IF_AWAY);
> +	else
> +		val = state ? (val | VCNL4040_PS_IF_CLOSE) :
> +		    (val & ~VCNL4040_PS_IF_CLOSE);


Wouldn't be better

	uXX val, mask;


	if (dir == IIO_EV_DIR_RISING)
		mask = VCNL4040_PS_IF_AWAY;
	else
		mask = VCNL4040_PS_IF_CLOSE;

	val = state ? (val | mask) : (val & ~mask);

?

-- 
With Best Regards,
Andy Shevchenko


