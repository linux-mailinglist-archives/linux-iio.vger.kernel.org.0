Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2165352778
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBIfY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 04:35:24 -0400
Received: from www381.your-server.de ([78.46.137.84]:37004 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBIfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 04:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Re+sXb7djl7QYzbmUBwJVJ0t9uCBlVWSNpoooZ4Dx3I=; b=VhpGgbiNMOz5eSChcui03S1z+j
        ptScSno7JS04xTHZ753d04pH7eZvw1Dgpgq0GTVw7hKO5jbA/RGWlN2fvJdk/6anYusbn1z3qE2XI
        7VtiEBdyO7biVdg6b7k2BthtDPx1+R17gCyntWqxerwcfmA3X3rjBPtaPShhoBsvo3d3w9Ud9OPR3
        FDpKtjlZt4NaT6ZiJFd9no5V2XAnXvT+QQYkOleZVTAQHQEDFsPz1tLBdijiUifc7pSkW0xsthuZh
        iiqStTbsEl70ZvQN9m6S85J1FQCkzEED8yomWA/sQOCn/N9P9C8gRL6WXOTUN0H0jVi57wbP07OeE
        GN+Qb+bw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lSFGw-0006wl-4v; Fri, 02 Apr 2021 10:35:18 +0200
Received: from [2001:a61:2aa1:1e01:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lSFGv-000UZn-Uc; Fri, 02 Apr 2021 10:35:18 +0200
Subject: Re: [PATCH 2/3] iio:adc:ad7476: Handle the different regulators used
 by various parts.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210401171759.318140-1-jic23@kernel.org>
 <20210401171759.318140-3-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <45bfed22-1864-eb3a-f370-c6a38a9de414@metafoo.de>
Date:   Fri, 2 Apr 2021 10:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210401171759.318140-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26127/Thu Apr  1 13:11:26 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/1/21 7:17 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Not all of the parts supported by this driver use single supply.
> Hence we add chip_info fields to say what additional supplies exist
> and in the case of vref, ensure that is used for the reference voltage
> rather than vcc.
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

Looks good.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

There is one special case that is currently not handled. The AD7091R can 
either use its internal reference, or an external reference.

At the moment the driver sets neither has_vref nor int_vref_uv.
