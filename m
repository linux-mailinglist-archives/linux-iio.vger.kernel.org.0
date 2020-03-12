Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC018383E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 19:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgCLSIm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 14:08:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:17942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCLSIm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 14:08:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243117885"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 11:08:34 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCSG3-0094KY-W6; Thu, 12 Mar 2020 20:08:35 +0200
Date:   Thu, 12 Mar 2020 20:08:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, fabrice.gasnier@st.com,
        beniamin.bia@analog.com, linus.walleij@linaro.org,
        u.kleine-koenig@pengutronix.de, fabrizio.castro@bp.renesas.com,
        info@metux.net, hancock@sedsystems.ca, gregory.clement@bootlin.com,
        renatogeh@gmail.com, plr.vincent@gmail.com,
        miquel.raynal@bootlin.com, marcelo.schmitt1@gmail.com,
        paul@crapouillou.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/5] Add battery charger driver support for MP2629
Message-ID: <20200312180835.GM1922688@smile.fi.intel.com>
References: <20200312172649.13702-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312172649.13702-1-sravanhome@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 12, 2020 at 06:26:44PM +0100, Saravanan Sekar wrote:
> This patch series add support for Battery charger control driver for Monolithic
> Power System's MP2629 chipset, includes MFD driver for ADC battery & input
> power supply measurement and battery charger control driver.

For the future, hint:
	scripts/get_maintainer.pl --git --git-min-percent=67 ...

but since I reviewed this, don't forget to include reviewers in your next version.

> 
> Thanks,
> Saravanan
> 
> Saravanan Sekar (5):
>   dt-bindings: mfd: add document bindings for mp2629
>   mfd: mp2629: Add support for mps battery charger
>   iio: adc: mp2629: Add support for mp2629 ADC driver
>   power: supply: Add support for mps mp2629 battery charger
>   MAINTAINERS: Add entry for mp2629 Battery Charger driver
> 
>  .../devicetree/bindings/mfd/mps,mp2629.yaml   |  62 ++
>  MAINTAINERS                                   |   5 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/mp2629_adc.c                  | 211 ++++++
>  drivers/mfd/Kconfig                           |  43 +-
>  drivers/mfd/Makefile                          |   4 +-
>  drivers/mfd/mp2629.c                          | 109 +++
>  drivers/power/supply/Kconfig                  |  14 +-
>  drivers/power/supply/Makefile                 |   1 +
>  drivers/power/supply/mp2629_charger.c         | 709 ++++++++++++++++++
>  include/linux/mfd/mp2629.h                    |  34 +
>  12 files changed, 1169 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
>  create mode 100644 drivers/iio/adc/mp2629_adc.c
>  create mode 100644 drivers/mfd/mp2629.c
>  create mode 100644 drivers/power/supply/mp2629_charger.c
>  create mode 100644 include/linux/mfd/mp2629.h
> 
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


