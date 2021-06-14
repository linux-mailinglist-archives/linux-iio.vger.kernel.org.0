Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8703A5E57
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 10:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFNI0v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 04:26:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:32894 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbhFNI0v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 04:26:51 -0400
IronPort-SDR: KdoLd2vfhDbyi25QDTzzOD0jm8jmGaN5Qz+gDPukvHh0WLAAltb8Ijf4rCMmKW7KwPvq8Cfoyg
 jrf2WaCpkHPw==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="227228127"
X-IronPort-AV: E=Sophos;i="5.83,272,1616482800"; 
   d="scan'208";a="227228127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 01:24:48 -0700
IronPort-SDR: 5Yl4wOrmc+TdxB1HE05suVUwufJn4r3EUW+HEYNp1+AZRbz9AF/gJKZSrEITRSzxODG3Uz2uM3
 g4mBHfBz06uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,272,1616482800"; 
   d="scan'208";a="451520722"
Received: from mylly.fi.intel.com (HELO [10.237.72.166]) ([10.237.72.166])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2021 01:24:47 -0700
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
 <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
 <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <839944ff-e4e3-86c1-8d53-abaf96fa9271@linux.intel.com>
Date:   Mon, 14 Jun 2021 11:24:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/13/21 1:36 PM, Andy Shevchenko wrote:
> On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
>>
>> Use to_pci_dev() helper instead of container_of(d, struct pci_dev, dev);
> 
> ...
> 
>> -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +       struct pci_dev *pdev = to_pci_dev(dev);
>>          struct intel_qep *qep = pci_get_drvdata(pdev);
> 
> Why not change both lines to dev_get_drvdata()?
> 
I thought it before and Uwe had a good point why it isn't necessarily a 
good idea:

https://www.spinics.net/lists/linux-pwm/msg15325.html

Jarkko
