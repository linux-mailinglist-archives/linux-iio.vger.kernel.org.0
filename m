Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BEF3A4186
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhFKL6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 07:58:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:42829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhFKL6c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 07:58:32 -0400
IronPort-SDR: FYvBz6ckFAYK+sECU54mWvfZ5a7LYGSfoe5kj3jTrZlvM+Au7GOD7irpg6kivpVP2EfND1nvr9
 jqPMSmzWwFvA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="203678411"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="203678411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 04:56:33 -0700
IronPort-SDR: VytPuLx7S5jT9Gd6FUOK49layMI54pZNwQvbX1kBvCfwsDxWZDkknOLBSOCn64yZ4CIzq6yVKV
 gHPxdcIEWVFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="553387383"
Received: from unknown (HELO [10.237.72.51]) ([10.237.72.51])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2021 04:56:31 -0700
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
Message-ID: <6d554842-8c28-c38b-58cd-9312cf71a419@linux.intel.com>
Date:   Fri, 11 Jun 2021 14:56:30 +0300
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

On 6/3/21 7:12 PM, Jonathan Cameron wrote:
> On Wed,  2 Jun 2021 14:32:59 +0300
> Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
>> +static int intel_qep_suspend(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> 
> to_pci_dev()
> Though if all you are doing is using it to then get the drvdata
> avoid the round trip.  There have been a few patch sets tidying this up
> in recent years and good not to add the noise of having that happen here.
> 
> struct intel_qep *qep = dev_get_drvdata(dev);
> 
Now I remember, I got this dev_get_drvdata() idea here earlier but 
implemented it first to another driver and Uwe had a good point about 
kind of layer violation of relying dev_get_drvdata() to return what 
pci_set_drvdata() set:

https://www.spinics.net/lists/linux-pwm/msg15325.html

Jarkko
