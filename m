Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D02257B4D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHaOad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 10:30:33 -0400
Received: from vern.gendns.com ([98.142.107.122]:35994 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgHaOad (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 10:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5TL6L87Gzfsxb0AUsJo+hT5Ayv6C3WC26qszeZyu2eU=; b=o78UIN6TbbtduZdZn4L5JdaDdO
        pWhPp6f3peOTypia2uTzOwAo8+ZZaIf/uwWJaAS4TDqRVdRASaiHQJGTvkIN26mG3SyURtrOY+b8r
        i1BR+Z6LBKBztkbcETSH/VsTzB7vRTU6h0s7ga7Sm6U7i3tYS/xjHPCR3RHVLJhjpm9jgGseUIQI7
        gRmD+kO4T1nYa/WJUv7jW42krbhx9xoAkOc7J7vxzBVOBJTpXNI5oGNflWPTY7afUK545ABzIHVWe
        GjVByQ3Vekwyz8VGxin5ZtkpizU8hAm+RPd8LFxSFPPZ8t4WCDzi2qmWoUO7P9Kag4K/pBaR0fqf9
        Eqv8nkLQ==;
Received: from [2600:1700:4830:165f::19e] (port=53058)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kCkpJ-0002q9-2b; Mon, 31 Aug 2020 10:30:29 -0400
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: ti,ads7950 binding
 conversion
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20200830161154.3201-1-jic23@kernel.org>
 <20200830161154.3201-3-jic23@kernel.org>
From:   David Lechner <david@lechnology.com>
Message-ID: <f8da562f-0111-6c86-9331-aebebd562bc1@lechnology.com>
Date:   Mon, 31 Aug 2020 09:30:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200830161154.3201-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/30/20 11:11 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Conversion from txt to yaml.  The binding documents that
> as not all boards will make use of the ADC channels via a consumer
> driver.  It does no harm however, so we will leave it as required.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Lechner <david@lechnology.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

