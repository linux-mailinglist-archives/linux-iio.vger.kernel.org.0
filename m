Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 437D918E58B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 01:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgCVAZn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 20:25:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:30447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCVAZn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 20:25:43 -0400
IronPort-SDR: LU5tnGu79NI8ftd9DyBlDFfWc9lECniFP14v4zMKMHwf7tUaqe4yThJJpwniz3gXhdh+Z8by09
 j620MPSDGT7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2020 17:25:43 -0700
IronPort-SDR: xxcblHMX2RBUykp4thoYSybBcZ9e/GoEScu8af4cI/GdBdJGgLUMtPkHogh2/F3OPZGlhfYb+L
 wKTOFtak/WxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,290,1580803200"; 
   d="scan'208";a="325223523"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2020 17:25:40 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jFoQw-00BrDM-F8; Sun, 22 Mar 2020 02:25:42 +0200
Date:   Sun, 22 Mar 2020 02:25:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, dragos.bogdan@analog.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>, knaack.h@gmx.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH] iio: gyro: adis16136: use scnprintf instead of snprintf
Message-ID: <20200322002542.GA2826015@smile.fi.intel.com>
References: <5e723666.1c69fb81.3545b.79c3@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e723666.1c69fb81.3545b.79c3@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 18, 2020 at 08:25:22PM +0530, Rohit Sarkar wrote:
> scnprintf returns the actual number of bytes written into the buffer as
> opposed to snprintf which returns the number of bytes that would have
> been written if the buffer was big enough. Using the output of snprintf
> may lead to difficult to detect bugs.

Nice. Have you investigate the code?

> @@ -96,7 +96,7 @@ static ssize_t adis16136_show_serial(struct file *file,
>  	if (ret)
>  		return ret;
>  
> -	len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> +	len = scnprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
>  		lot3, serial);
>  
>  	return simple_read_from_buffer(userbuf, count, ppos, buf, len);

The buffer size is 20, the pattern size I count to 19. Do you think snprintf()
can fail?

-- 
With Best Regards,
Andy Shevchenko


