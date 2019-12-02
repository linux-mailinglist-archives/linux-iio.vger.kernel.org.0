Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0309810EA44
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2019 13:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLBM57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Dec 2019 07:57:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:9269 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbfLBM57 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Dec 2019 07:57:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 04:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="411757273"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2019 04:57:56 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iblH2-00022E-4R; Mon, 02 Dec 2019 14:57:56 +0200
Date:   Mon, 2 Dec 2019 14:57:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] iio: ak8975: Convert to use GPIO descriptor
Message-ID: <20191202125756.GF32742@smile.fi.intel.com>
References: <20191202081730.61707-1-linus.walleij@linaro.org>
 <20191202125148.GE32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202125148.GE32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 02, 2019 at 02:51:48PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 02, 2019 at 09:17:30AM +0100, Linus Walleij wrote:
> > The end-of-conversion (EOC) GPIO line is better to grab using
> > a GPIO descriptor. We drop the pdata for this: clients using board
> > files can use machine descriptor tables to pass this GPIO from
> > static data.

> >  		dev_err(&client->dev,
> > -			"irq %d request failed, (gpio %d): %d\n",
> > -			irq, data->eoc_gpio, rc);
> > +			"irq %d request failed: %d\n",
> > +			irq, rc);
> 
> Now it fits one line.

I meant including dev_err().

-- 
With Best Regards,
Andy Shevchenko


