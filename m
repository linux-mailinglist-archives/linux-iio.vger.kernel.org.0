Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9AA36A869
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 18:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhDYQjr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 12:39:47 -0400
Received: from www381.your-server.de ([78.46.137.84]:37298 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhDYQjr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 12:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Gj39ngogjE+FQvOJAZ/GHerQf+5P+gRgb18qkF+HHm4=; b=EX6CfZfq9LxrWsivCQC/jvnxh6
        rmFBe/yuQjvve1FptPBGbW9QF60IMpHv8a1/zrO/a5bXqKlrx3/5DI3z+buM4FiO+Op4Ir9Vap2tb
        u5lXfKEJIKtQXJqaZSJhZWag1CWyck/YGIswMQDV2pPFIIbWfY4FG79RoSUDyDhWyc1KFPTl0CUR2
        +ELa65106e5VaegDgNeG+aQevwKhqFMzcjG+UlyOCEGqrRIvWpndEZrN8uZI0j9OpSQxpx+CJGiiW
        ZItk6nhhR7ix82pPId5oe1cGjxmWfdP2Z0jBg8+A4I5zJ+ITyh1WAoHwkbKcnmUWP3xPbQgXZMb40
        WYRh6ZYQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lahmh-0002DP-JI; Sun, 25 Apr 2021 18:39:03 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lahmh-000NHA-DA; Sun, 25 Apr 2021 18:39:03 +0200
Subject: Re: [PATCH v4 1/2] iio:adc:ad7476: Handle the different regulators
 used by various parts.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        kernel test robot <lkp@intel.com>
References: <20210425163154.73209-1-jic23@kernel.org>
 <20210425163154.73209-2-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <662ed93c-7567-7acb-15c4-5526af80209e@metafoo.de>
Date:   Sun, 25 Apr 2021 18:39:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210425163154.73209-2-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26151/Sun Apr 25 13:05:06 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/25/21 6:31 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Not all of the parts supported by this driver use single supply.
> Hence we add chip_info fields to say what additional supplies exist
> and in the case of vref, ensure that is used for the reference voltage
> rather than vcc.
>
> One corner case is the ad7091r which has an internal reference that
> can be over-driven by an external reference connected on the vref pin.
> To handle that force_ext_vref is introduced and set if an optional
> vref regulator is present.
>
> Tested using really simple QEMU model and some fixed regulators.
>
> The devm_add_action_or_reset() callback is changed to take the
> regulator as it's parameter so we can use one callback for all the
> different regulators without having to store pointers to them in
> the iio_priv() structure.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

