Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25539294C
	for <lists+linux-iio@lfdr.de>; Thu, 27 May 2021 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhE0IP3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 May 2021 04:15:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:59953 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235054AbhE0IP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 May 2021 04:15:28 -0400
IronPort-SDR: J54V6KvyAcbrIMzj908Zi2lPLZh6ORQOf3hRQAq5x3Ibwh5aW2mwGwO31YMQNHdIFjwXwA0prS
 Y8AUJ113Yf4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="190052093"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="190052093"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 01:13:55 -0700
IronPort-SDR: yEChQTMoe4eeiVLJuS6kYUXVD2niTAAATF2D3e4QhbJ7GOwqSeM02U/8OAkwnBboCimsxIPqwn
 MaX6V8fFSIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="547593177"
Received: from mylly.fi.intel.com (HELO [10.237.72.166]) ([10.237.72.166])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2021 01:13:53 -0700
Subject: Re: [PATCH v2 1/2] counter: Add support for Quadrature x4 with
 swapped inputs
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>,
        Jonathan.Cameron@huawei.com
References: <20210526150601.3605866-1-jarkko.nikula@linux.intel.com>
 <YK7xivdBniZJGENx@shinobu>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <38f6bb60-f828-8a12-2a76-b14b7512d691@linux.intel.com>
Date:   Thu, 27 May 2021 11:13:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YK7xivdBniZJGENx@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 5/27/21 4:10 AM, William Breathitt Gray wrote:
> On Wed, May 26, 2021 at 06:06:00PM +0300, Jarkko Nikula wrote:
>> Some Quadrature Encoders can swap phase inputs A and B internally. This
>> new function will allow drivers to configure input swap mode.
>>
>> This was implemented by Felipe Balbi while he was working at Intel.
>>
>> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> There's no change in this patch from the last revision, right?
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
Yes, no changes. Will add your ack to the next version.

Jarkko
