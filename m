Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3996E39BA65
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhFDN7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 09:59:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:12261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230250AbhFDN7N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Jun 2021 09:59:13 -0400
IronPort-SDR: VjlvX5sr4Z2HxTawxJIjYKj/VFYI7RfhzrgfFvSY0oNjgwnD4YMsql/M/vDSoscAzmKLOaGpyW
 icE40lcizHaA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191401697"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="191401697"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 06:57:26 -0700
IronPort-SDR: +C4ktXnRETJT3UzFVxAffJwW2bv1KmYTglUDAYiuZtdLSUlRPAMAsqRKSUYgcRuPa3w7d3uEJY
 pCKKQ1w18xGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="483919346"
Received: from mylly.fi.intel.com (HELO [10.237.72.153]) ([10.237.72.153])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jun 2021 06:57:25 -0700
Subject: Re: [PATCH v4] counter: Add support for Intel Quadrature Encoder
 Peripheral
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20210602113259.158674-1-jarkko.nikula@linux.intel.com>
 <20210603171233.37009042@jic23-huawei>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <fbca9d99-07b9-0150-ef9e-15eaa867ac8b@linux.intel.com>
Date:   Fri, 4 Jun 2021 16:57:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210603171233.37009042@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 6/3/21 7:12 PM, Jonathan Cameron wrote:
> Given all my comments are either minor or not specifically about code here,
> feel free to send a follow up if you want to tidy them up.
> 
Thanks, point taken. Commenting two of those below.

>> +
>> +	pm_runtime_forbid(dev);
>> +	if (!qep->enabled)
>> +		pm_runtime_get(dev);
> 
> Ouch, I'd not encountered this pci related weirdness before
> (All about overriding the fact PCI opts out of runtime)
> 
Yeah this conditional pm_runtime_get() doesn't look optimal in remove(). 
PCI devices must be in D0 when not bound but don't remember now does PCI 
core it anyway after remove or not but pm_runtime_get() must be here for 
balancing the runtime PM usage count due pm_runtime_put() in probe(), 
i.e. device is suspended after probe(),

Exception here is if peripheral is enabled and already powered when 
coming here. Which makes me thinking counting is perhaps good to 
disable. Kind of pointless to let it count if there is no driver.

>> +
>> +	intel_qep_writel(qep, INTEL_QEPCON, 0);
>> +}
>> +
>> +#ifdef CONFIG_PM
> 
> Up to William and yourself, but I would prefer not to see these ifdefs
> but instead mark the functions __maybe_unused and let the linker
> drop them.  It tends to be less error prone if the pm handling gets
> more complex in future.
> 
I obviously will follow the style here. I remember some maintainers 
prefer explicit #ifdef over __maybe_unused.

Jarkko
