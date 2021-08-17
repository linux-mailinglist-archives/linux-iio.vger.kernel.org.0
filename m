Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED33EF075
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 18:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhHQQva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 12:51:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:53542 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhHQQv3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 12:51:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="301726064"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="301726064"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:50:54 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="449346851"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 09:50:53 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mG2IY-00AoMK-RA; Tue, 17 Aug 2021 19:50:46 +0300
Date:   Tue, 17 Aug 2021 19:50:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Document
 senseair,sunrise CO2 sensor
Message-ID: <YRvo5qCWrBT1x7V+@smile.fi.intel.com>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-2-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817154951.50208-2-jacopo@jmondi.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 17, 2021 at 05:49:50PM +0200, Jacopo Mondi wrote:
> Add documentation for the Senseair Sunrise 006-0-0007 CO2 NDIR sensor.

> +  ndry-gpios:
> +    description: Phandle to the GPIO line connected to the nDRY pin. Active low.
> +
> +  en-gpios:
> +    description: Phandle to the GPIO line connected to the EN pin. Active high.

Not sure you have to mention polarity. It can be changed on PCB level easily
and this bindings won't satisfy those (valid) changes.

-- 
With Best Regards,
Andy Shevchenko


