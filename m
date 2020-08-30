Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F37256D15
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgH3JZt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 05:25:49 -0400
Received: from foss.arm.com ([217.140.110.172]:49362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgH3JZt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 05:25:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A31DD31B;
        Sun, 30 Aug 2020 02:25:48 -0700 (PDT)
Received: from [10.37.8.19] (unknown [10.37.8.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82AE33F68F;
        Sun, 30 Aug 2020 02:25:47 -0700 (PDT)
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Select IIO_TRIGGERED_BUFFER
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        xxm@rock-chips.com
References: <20200828174242.338068-1-alexandru.elisei@arm.com>
 <20200829155703.19bf1c9f@archlinux>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <73cb7fcd-df73-e287-7733-4ce657e5a758@arm.com>
Date:   Sun, 30 Aug 2020 10:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200829155703.19bf1c9f@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 8/29/20 3:57 PM, Jonathan Cameron wrote:
> On Fri, 28 Aug 2020 18:42:42 +0100
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:
>
>> Building the Rockchip saradc driver can trigger the following error if the
>> driver is compiled into the kernel, but the IIO triggered buffer is not:
>>
>> aarch64-linux-gnu-ld: drivers/iio/adc/rockchip_saradc.o: in function `rockchip_saradc_probe':
>> /path/to/linux/drivers/iio/adc/rockchip_saradc.c:427: undefined reference to `devm_iio_triggered_buffer_setup'
>>
>> This is because commit 4e130dc7b413 ("iio: adc: rockchip_saradc: Add
>> support iio buffers") added support for industrial I/O triggered buffers,
>> but didn't update Kconfig to build the required file. Fix that.
>>
>> Fixes: 4e130dc7b413 ("iio: adc: rockchip_saradc: Add support iio buffers")
>> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Sorry, I've had a patch queued to fix this for a while, but had a
> vacation just after merge window occurred that delayed me sending it out.
>
> Will send a pull sometime this weekend.
>
> Jonathan

That's great, thank you!

Thanks,
Alex
