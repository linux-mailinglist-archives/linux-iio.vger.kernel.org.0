Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84B739294D
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhE0IPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 04:15:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:36425 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235165AbhE0IPp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 May 2021 04:15:45 -0400
IronPort-SDR: kvKSN4e0SHNIK0Oe3UaN434241x5ptBvA+p1stPwH5gcauv+QZLWbrCzkIPFLg0D3qxUPkBIOK
 2Zua2GPjntRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="200784512"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="200784512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:14:12 -0700
IronPort-SDR: 03I5oyedfnrxGBWKsWJuS/ADq1XodlngPQxjX2NbJqTWedoFO8YLC/F5ZyurPwtphcVTQAWfs0
 DKfgD46AG7ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547593257"
Received: from mylly.fi.intel.com (HELO [10.237.72.166]) ([10.237.72.166])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 01:14:07 -0700
Subject: Re: [PATCH v2 2/2] counter: Add support for Intel Quadrature Encoder
 Peripheral
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
 <20210526150601.3605866-2-jarkko.nikula@linux.intel.com>
 <YK8BALkLzEp0CC4C@shinobu>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <7610aa4d-23f9-9fe8-68c2-4a25d086c7a9@linux.intel.com>
Date:   Thu, 27 May 2021 11:14:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YK8BALkLzEp0CC4C@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 5/27/21 5:16 AM, William Breathitt Gray wrote:
>> +What:		/sys/bus/counter/devices/counterX/signalY/invert
>> +KernelVersion:	5.14
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Whether signal Y inversion is enabled. Valid attribute values
>> +		are boolean.
>> +
>> +		For counter devices that have feature to control inversion of
>> +		signal Y.
> 
> I want to understand this functionality a bit better. So, this device
> has two quadrature encoder signals coming in (Phase A and Phase B) and
> this "invert" option allows the user to configure the device to invert
> these signals in hardware before before they are evaluated by the
> quadrature encoding counter. Users are able to invert each signal
> independent of the other; e.g. Phase A can be inverted, but Phase B can
> be left alone. Is my understanding correct, or is the inversion applied
> across all signals rather than just one independently?
> 
> What is the purpose of this functionality? Is this to allow users to
> adjust the direction of the count without having to physically reorient
> the encoding device (e.g. tracking counter-clockwise versus clockwise
> movement)?
> 
Yes, it's independent for each signal. Here Phase A, B and Index.

According to specification idea is to remove need for board specific 
inversion logic. Which makes me thinking this kind configuration should 
come from firmware. As well as inputs swapped function. Which is for 
correcting possible miswiring of Phase A and B signals on the board.

I'm now puzzled is there even need to have userspace visibility and 
control for these signal inversions and input swapping? Of course yes 
with my hacker hat on but for an ordinary Linux distribution point of 
view those inversions and input swapping should be set by the kernel 
automatically IMHO.

What do you think? Should I keep these sysfs attributes in the next 
version or remove them? Though I don't have plans to add firmware data 
this time. It's nice to save room for future contributions if there is a 
real need for these features :-)

>> +	return sysfs_emit(buf, "%u\n", !(reg & (uintptr_t)signal->priv));
> 
> It's easy to forget what signal->priv represents. I recommend using a
> variable to hold this value so that the logic is a bit easier to
> understand for future reviewers.
> 
Ok.

>> +static struct counter_signal intel_qep_signals[] = {
>> +	INTEL_QEP_SIGNAL(0, "Phase A", INTEL_QEPCON_EDGE_A),
>> +	INTEL_QEP_SIGNAL(1, "Phase B", INTEL_QEPCON_EDGE_A),
>> +	INTEL_QEP_SIGNAL(2, "Index", INTEL_QEPCON_EDGE_A),
> 
> Is INTEL_QEPCON_EDGE_A three times here correct, or did mean to use
> INTEL_QEPCON_EDGE_B and INTEL_QEPCON_EDGE_INDX as well?
> 
What a facepalm... last minute "lets have a nice macro here and blind 
copy-pasting" just before sending this out.

>> +	 * Spike filter length is (MAX_COUNT + 2) clock periods. Disable
>> +	 * filter when user space supplies shorter than 2 clock periods and
>> +	 * otherwise enable and set MAX_COUNT = clock periods - 2.
>> +	 */
>> +	length /= INTEL_QEP_CLK_PERIOD_NS;
>> +	if (length < 2) {
> 
> If userspace supplies a value that the filter cannot support, I think it
> makes more sense to return an -EINVAL here. Otherwise, the user may
> believe they have enabled the filter when it is in fact now disabled.
> 
Fair point. Will change.

Jarkko
