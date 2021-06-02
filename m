Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E4D39887B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhFBLnT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 07:43:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:63970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhFBLnP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Jun 2021 07:43:15 -0400
IronPort-SDR: j5yaDyR0GkTVlA5VDidkjsv6ITbtv1PiycEMtkycH8Dm/xMDnsUSzh+28X+YjFKyQi84Y2hVuq
 xZYbwg7nB0dw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="191117841"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="191117841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 04:41:31 -0700
IronPort-SDR: YVSQNeuJiweuR66owrfmALsn361OpHwEI304MotqGnyzTdW9sImLp9E13IBgO4CWse4DwX8hop
 XCx+GC1YJfWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="399695896"
Received: from unknown (HELO [10.237.72.51]) ([10.237.72.51])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2021 04:41:30 -0700
Subject: Re: [PATCH v3] counter: Add support for Intel Quadrature Encoder
 Peripheral
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
References: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
 <YLcDJ+ZI1fXRpFRe@shinobu>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <d9dc416f-100f-3fb8-d250-3aed8ca8f10b@linux.intel.com>
Date:   Wed, 2 Jun 2021 14:41:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YLcDJ+ZI1fXRpFRe@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 6/2/21 7:03 AM, William Breathitt Gray wrote:
> On Thu, May 27, 2021 at 04:58:38PM +0300, Jarkko Nikula wrote:
>>   Documentation/ABI/testing/sysfs-bus-counter |   9 +
>>   drivers/counter/Kconfig                     |  10 +
>>   drivers/counter/Makefile                    |   1 +
>>   drivers/counter/intel-qep.c                 | 546 ++++++++++++++++++++
>>   4 files changed, 566 insertions(+)
>>   create mode 100644 drivers/counter/intel-qep.c
> 
> Hi Jarkko,
> 
> I noticed the intel-qep.c file is missing an entry in the MAINTAINERS
> file. Would you be able to resubmit this patch with a proper entry added
> to MAINTAINERS so that users have the relevant contact info to reach the
> maintainers of this driver? You can keep my Signed-off tag on as well so
> that we know the code has already been reviewed.
> 
Ah, added now. I sent the update and didn't dare to add your signature 
due the sidenote below :-)

Sidenote, to my understanding Signed-off-by requires patch went through 
that person and Acked-by is used when maintainer accepts the patch but 
another person commits it with his/her Signed-off-by.

Jarkko
