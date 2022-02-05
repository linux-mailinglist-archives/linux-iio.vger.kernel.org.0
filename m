Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC84AAA22
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 17:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbiBEQZo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 11:25:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:37222 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbiBEQZo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Feb 2022 11:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644078344; x=1675614344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=h5nz9ArM1VZwP8WCg9mCDPwMPRQikKTTzylA1Aqmfyk=;
  b=nuDHI2GjyU5s5nb13GwVSajVd+KW32fSc0N8sUw7gmY+aguEBO24aOdr
   ZqwG0W4mveAXkiNmUZvJMFME7DeKQCByx/b5KwbW6SXW9DuZbH3t/l2s5
   bdaB6TIalJv+D1CF06A/FvJDi9YgeUNUT7PsAPkJYHfgHWtLk1HhSs6Wb
   PoecwsvBQZ0DiFdaOVthGrvIuaLIFR+nCmIxKQFkQPow+cCiM/nlJtj/r
   oYrsnwttZ2S6jgIa8CKGD192p8LyCJHUr8JwOOI9Lgk6+A8IsG1oM/1su
   jBAT+UQj3dhEyVu2ly/gTOqv93mB9UgF9Rpo1qM3RZ816Ocx2W8VSQC9X
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248284783"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="248284783"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 08:25:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="524642132"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 08:25:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nGNre-001Jbd-7m;
        Sat, 05 Feb 2022 18:24:42 +0200
Date:   Sat, 5 Feb 2022 18:24:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v3 0/3] Add support for LTC2688
Message-ID: <Yf6kyTTo3FzxL0f2@smile.fi.intel.com>
References: <20220121142501.151-1-nuno.sa@analog.com>
 <20220122172706.16aec32e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220122172706.16aec32e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 22, 2022 at 05:27:06PM +0000, Jonathan Cameron wrote:
> On Fri, 21 Jan 2022 15:24:58 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:

...

> Series looks good to me, but will have to wait a little longer for DT and
> any other review before I apply it.

Thanks! I have comments.

-- 
With Best Regards,
Andy Shevchenko


