Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E703356E7F
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348395AbhDGO0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 10:26:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:36985 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235723AbhDGO0E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Apr 2021 10:26:04 -0400
IronPort-SDR: 8lXbXtcxqVrkAK9LwtC7RS2OyDRoq8z4SQ5S/A8tQSiTWkpw1Byma1VPKM7N0jlA+3BRRAa5B4
 dRXCTKd4LLSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="192858490"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="192858490"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 07:25:53 -0700
IronPort-SDR: bOoxT90q/f9Xj0q4180tmx+UPjL+1J3xYkdWsH625LirHTuSfwTHxLF+vCVYjsaE/ixz5eQfgp
 30jCcMXJkg2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="421723118"
Received: from mylly.fi.intel.com (HELO [10.237.72.57]) ([10.237.72.57])
  by orsmga008.jf.intel.com with ESMTP; 07 Apr 2021 07:25:48 -0700
Subject: Re: [PATCH 2/2] counter: Add support for Intel Quadrature Encoder
 Peripheral
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
 <20210401153228.2773560-2-jarkko.nikula@linux.intel.com>
 <YGbyVHNY/55akU9I@shinobu>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <778390eb-d27b-c486-0f3d-610e019e69f0@linux.intel.com>
Date:   Wed, 7 Apr 2021 17:25:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGbyVHNY/55akU9I@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 4/2/21 1:30 PM, William Breathitt Gray wrote:
> On Thu, Apr 01, 2021 at 06:32:28PM +0300, Jarkko Nikula wrote:
>> Add support for Intel Quadrature Encoder Peripheral found on Intel
>> Elkhart Lake platform.
>>
>> Initial implementation was done by Felipe Balbi while he was working at
>> Intel with later changes from Raymond Tan and me.
>>
>> Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
>> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
>> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
>> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Hello Jarkko,
> 
> Please see the questions and suggestions inline below.
> 
Thanks for review! I'll address them for the next version. Some comments 
and discussion below.

>> +static enum counter_synapse_action intel_qep_synapse_actions[] = {
> 
> This enum can be const too.
> 
>> +	[INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE] =
>> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
>> +
>> +	[INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE] =
>> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
>> +};
> 
> Quadrature x4 mode is expected to evaluate on both edges on both phase
> signals. Shouldn't this array have COUNTER_SYNAPSE_ACTION_BOTH_EDGES?
> 
...
>> +static int intel_qep_action_get(struct counter_device *counter,
>> +				struct counter_count *count,
>> +				struct counter_synapse *synapse,
>> +				size_t *action)
>> +{
>> +	struct intel_qep *qep = counter_to_qep(counter);
>> +	u32 reg;
>> +
>> +	pm_runtime_get_sync(qep->dev);
>> +	reg = intel_qep_readl(qep, INTEL_QEPCON);
>> +	pm_runtime_put(qep->dev);
>> +
>> +	*action = (reg & synapse->signal->id) ?
>> +		INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE :
>> +		INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE;
> 
> I'm a bit confused about this quadrature encoding. Is this counting only
> one edge on each phase signal?
> 
...
> 
> Are you actually able to set the action mode for the phase signals? My
> expectation is that the action mode for the phase signals will always be
> "both edges" because the encoding is quadrature x4. What exactly is
> happening for the device when you write INTEL_QEPCON?
> 
You are right. I've overlooked this. Action is always both edges but 
what HW actually does here is an inversion control for each input signal 
so these should be then extensions I think.

 From the specification "An individually configurable Edge Select block 
allows control over rising or falling edge detection on each input pins, 
removing the need for platform logic inversion.".

>> +static ssize_t enable_write(struct counter_device *counter,
>> +			    struct counter_count *count,
>> +			    void *priv, const char *buf, size_t len)
>> +{
>> +	struct intel_qep *qep = counter_to_qep(counter);
>> +	u32 reg;
>> +	u32 val;
>> +	int ret;
>> +
>> +	ret = kstrtou32(buf, 0, &val);
> 
> "enable" is expected to handle boolean values so use kstrtobool here.
> 
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	mutex_lock(&qep->lock);
>> +	if (val && !qep->enabled) {
>> +		pm_runtime_get_sync(qep->dev);
>> +		reg = intel_qep_readl(qep, INTEL_QEPCON);
>> +		reg |= INTEL_QEPCON_EN;
>> +		intel_qep_writel(qep, INTEL_QEPCON, reg);
>> +		qep->enabled = true;
> 
> Are you missing pm_runtime_put() here?
> 
>> +	} else if (!val && qep->enabled) {
> 
> Are you missing pm_runtime_get_sync() here?
> 
Both are intented. Here pm_runtime_ calls are not only for accessing the 
registers like in other functions but keep the HW block on and be able 
to count when enabled. So after enabling the runtime PM usage count 
stays at least 1 and goes to zero only after disabling.

> If you have both val and qep->enabled as bool, you can make this logic
> clearer by evaluating their xor to determine if there's a change. So
> something like this:
> 
> 	bool changed = val ^ qep->enabled;
> 	if (!changed)
> 		return len;

Good point. Will check how does it look.

>> +static const struct counter_device_ext intel_qep_ext[] = {
>> +	INTEL_QEP_COUNTER_EXT_RW(noise),
>> +	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
>> +};
> 
> "noise" is a new attribute so you'll need to provide an entry in
> Documentation/ABI/testing/sysfs-bus-counter explaining it.
> 
Should this noise actually be visible as seconds (ns, µs, ms) instead of 
plain register value? From the spec "It selects the maximum glitch width 
to remove in terms of peripheral clock cycles: PCLK_CYCLES = MAX_COUNT + 2".

I think it should since for a person configuring the system plain 
register value is more or less guesswork.

Jarkko
