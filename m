Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C18F773F66
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjHHQqd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Aug 2023 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjHHQpf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 12:45:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9070644465;
        Tue,  8 Aug 2023 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510185; x=1723046185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y5raYLm0PmXZTwJDzcH6o7Z+kiKuWa+7IhU6RpcxBBY=;
  b=H9C7br+dG04blG4pqwTlYJoOd0LvO3Jr5zDaKP3EGGyzhAMs1cdBIYX9
   lvBjxLJANPwZIBszitjXsFT4ZR8WdZq3wa9S+We8cJBWDuOzMVLos64rb
   kCUxB0doSYOZvRldz/bijJiTUF09txgLhIdtvBz3dub6CejdFuNLl/JIv
   ZGRhiI3pmU0drvpN9OYlNkJAJAqzSOMNcQQhQ0AT4ADhzD93odgXbO2Ep
   WpLKYGIGnO/8yHSLL5G+kwRVMhuvQLlTBl4NNY2qyoWnkqRQszYgDba6W
   sEJ31KdW/m7VzkIH5RmCa28IhWCPFOmdaJnA9gqn5N9U9TWNHqa0wgoco
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437147341"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437147341"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766377234"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="766377234"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2023 06:05:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMPE-008zcz-2o;
        Tue, 08 Aug 2023 16:05:48 +0300
Date:   Tue, 8 Aug 2023 16:05:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Crt Mori <cmo@melexis.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: magnetometer: ak8975: Simplify probe()
Message-ID: <ZNI9rIWa7bxNW9+P@smile.fi.intel.com>
References: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
 <20230807172548.258247-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807172548.258247-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 07, 2023 at 06:25:48PM +0100, Biju Das wrote:
> Simplify the probe() by replacing device_get_match_data() and
> i2c_client_get_device_id by i2c_get_match_data() as we have similar I2C,
> ACPI and DT matching table.

...

> -		name = dev_name(&client->dev);

> -		name = id->name;

> -	indio_dev->name = name;
> +	indio_dev->name = dev_name(&client->dev);

I believe this is an ABI breakage.

NAK.

-- 
With Best Regards,
Andy Shevchenko


