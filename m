Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8EE4AAA27
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiBEQ0p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 11:26:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:33637 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbiBEQ0p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Feb 2022 11:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644078405; x=1675614405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aIWDnW5/xzFVkdpCWOCZYXAUphgpi3nt59tjEtGeeA4=;
  b=fB8tmvzmvlrn22K/aZM7BOhs/RM4qxe9Bry0HUKM8YJ5yu5zK6jimaLC
   k2T/zmpo41cKrHaSFJwmZZYETqRQZGmn8rC//GQSBOAo3uLpaRf/DstRl
   XcGo0cwB+UuAsNDqIXcwGk+5kFJf9F7rlXH/+/J3TDmffa9HMFIKZLZ66
   SPreqpfrn/pMMWibleFq00NFVUzuBZGoQLm33tmHn65ls5wGvK9+5Hscf
   6XAcco+gwkczw8RI41gx70OzaLqXy/WLXO2aAZbnGtuQs0/rjRsgPPltY
   XVawq3ezjTPPD5FtaBkViofHR0x3G4p5wsIcnuwZxz5Mh+JdHaR4dVWrc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248736110"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="248736110"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 08:26:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="632005384"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 08:26:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nGNsc-001JcW-7c;
        Sat, 05 Feb 2022 18:25:42 +0200
Date:   Sat, 5 Feb 2022 18:25:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 2/3] iio: ABI: add ABI file for the LTC2688 DAC
Message-ID: <Yf6lBVpN3dFjC4Fg@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220121142501.151-3-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121142501.151-3-nuno.sa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 21, 2022 at 03:25:00PM +0100, Nuno Sá wrote:
> Define the sysfs interface for toggle or dither capable channels. Dither
> capable channels will have the extended interface:
> 
>  * out_voltageY_dither_en
>  * out_voltageY_dither_raw
>  * out_voltageY_dither_offset
>  * out_voltageY_dither_raw_available
>  * out_voltageY_dither_frequency
>  * out_voltageY_dither_frequency_available
>  * out_voltageY_dither_phase
>  * out_voltageY_dither_phase_available
> 
> Toggle enabled channels will have:
> 
>  * out_voltageY_toggle_en
>  * out_voltageY_raw0
>  * out_voltageY_raw1
>  * out_voltageY_symbol
> 
> The common interface present in all channels is:
> 
>  * out_voltageY_raw (not present in toggle enabled channels)
>  * out_voltageY_raw_available
>  * out_voltageY_powerdown
>  * out_voltageY_scale
>  * out_voltageY_offset
>  * out_voltageY_calibbias
>  * out_voltageY_calibscale

...

> +KernelVersion:	5.17

v5.17 alredy gone for new features.

-- 
With Best Regards,
Andy Shevchenko


