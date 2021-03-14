Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A233A71F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCNRct (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 13:32:49 -0400
Received: from www381.your-server.de ([78.46.137.84]:40898 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhCNRcW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Mar 2021 13:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=2GZFl3Ruwx7HQDGyHKlXBDb26/Xe5zEEXlJBksjFRug=; b=S+nWg7HU5ds1O2SoYDz1NOybJ4
        CK0UWltm4IbMPERbQnpW8ZpVHWkob95SXqTKBFNTrj5WYegOZ9CDgcSFmihIqlPcYQCRaibQqqOb8
        jTGWhZRnPXjRE8pTtOXbIjjMIR+LCBTWcrK7TRFLkXmSHVkToFzRJ0D6is9ut67v1cI7TJQhRhW06
        u/EIugBbDJpY78/MSe4wjss6UtOzlG/Ghq1QSYJ4sDPUoIUboSRg9jBbmLShMMB6B327dTd5fNpuf
        eqHSxVmGksuuUldxPvHfwyL6CLo89xfd/lQUOfrXuHL10rDfz5Jh6+2XsQVXx6hiX/R8yfzl6kK+Y
        +Jdg3RBA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lLUbC-0002ni-57; Sun, 14 Mar 2021 18:32:18 +0100
Received: from [2001:a61:2aea:a901:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lLUbC-000WIR-0v; Sun, 14 Mar 2021 18:32:18 +0100
Subject: Re: [PATCH 0/8] iio: kernel-doc fixups
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210314164655.408461-1-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c3872df0-fbc5-903f-8ab8-761c58c61808@metafoo.de>
Date:   Sun, 14 Mar 2021 18:32:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26108/Sun Mar 14 13:05:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/14/21 5:46 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> A bunch of totally trivial kernel-doc fixes from W=1 builds.
>
> Note I've not touched staging drivers as those are a good activity for
> anyone who wants to get started working with IIO drivers. I'll post
> a specific email about that in a few minutes.

All obviously correct.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

