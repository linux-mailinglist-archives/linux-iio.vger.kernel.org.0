Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB963BD3AA
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 13:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhGFL6h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 07:58:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:46211 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240661AbhGFLrD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Jul 2021 07:47:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="207272505"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="207272505"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 04:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="427558916"
Received: from mylly.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2021 04:40:02 -0700
Subject: Re: [PATCH v12 00/17] Introduce the Counter character device
 interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <5bdd9ee6-86af-3bcc-43ff-418fd1a2e3e8@linux.intel.com>
Date:   Tue, 6 Jul 2021 14:40:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1625471640.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 7/5/21 11:18 AM, William Breathitt Gray wrote:
> To summarize the main points of this patchset: there are no changes to
> the existing Counter sysfs userspace interface; a Counter character
> device interface is introduced that allows Counter events and associated
> data to be read() by userspace; the events_configure() and
> watch_validate() driver callbacks are introduced to support Counter
> events; and IRQ support is added to the 104-QUAD-8 driver, serving as an
> example of how to support the new Counter events functionality.
> 
I quickly tested this set on top of linux-next next-20210706 and didn't 
see any issue with intel-qep.c. However I noticed two mutex issues in 
patch 15/17. Perhaps visible due the CONFIG_DEBUG_MUTEXES=y etc. I have on.

I'll be out of office next few weeks so cannot test if you have a new 
version meanwhile but wanted to share no show stopper from intel-qep.c 
and those two mutex warnings.

Jarkko
