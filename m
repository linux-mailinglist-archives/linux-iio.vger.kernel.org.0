Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA73550F9
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhDFKgS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Apr 2021 06:36:18 -0400
Received: from gateway32.websitewelcome.com ([192.185.144.98]:31618 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhDFKgS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Apr 2021 06:36:18 -0400
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 06:36:18 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 3A1F16747
        for <linux-iio@vger.kernel.org>; Tue,  6 Apr 2021 05:13:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id TiiDlOWhimJLsTiiDlxcB3; Tue, 06 Apr 2021 05:13:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UtxOuI/vruadawRYNAKIr7Rkp/OGW7D58iU4DVSud4Y=; b=b4/m2LrXsUwUOsh7cVz7MEsh+I
        uNboiyHMNPUFnZ3JjKyJKGGaEDGlOxWs6i9SzhxDlurV4LBNe7d6ioCLzgSJE47KyuoIFM6r9/4pB
        RMhDQmGJAdklqtE3U5Kx0P+kPxFQRpcOsj7fcsK8bXAvCk7aWvE8wMEKIDaSCps33zqS4K+E4DfyL
        h7JJ7ntadE/zs8P5PPZycmRAsquCY9ZzuC813FsfC5+mTUIn6D8+9e037L+Ws4EoMms156s3TnTmH
        WWJNgHIP6DZre3sR1ueXv7aAODbfhAz9CiJMwL1yv4R++2iXCFKhwiGH3F48qvIXj/7g8aHLfr0KK
        CtCcsbiA==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:44008 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1lTiiC-001Ijj-V3; Tue, 06 Apr 2021 05:13:32 -0500
Subject: Re: [PATCH][next] iio: hrtimer-trigger: Fix potential integer
 overflow in iio_hrtimer_store_sampling_frequency
To:     Jonathan Cameron <jic23@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210329205817.GA188755@embeddedor>
 <20210405172646.6a9f1b7d@jic23-huawei>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <ec7abed3-1685-8ae0-1a89-d9fc4ee76275@embeddedor.com>
Date:   Tue, 6 Apr 2021 05:13:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210405172646.6a9f1b7d@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lTiiC-001Ijj-V3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:44008
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 4/5/21 11:26, Jonathan Cameron wrote:
> On Mon, 29 Mar 2021 15:58:17 -0500
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>> Add suffix ULL to constant 1000 in order to avoid a potential integer
>> overflow and give the compiler complete information about the proper
>> arithmetic to use. Notice that this constant is being used in a context
>> that expects an expression of type unsigned long long, but it's
>> currently evaluated using 32-bit arithmetic.
>>
>> Addresses-Coverity-ID: 1503062 ("Unintentional integer overflow")
>> Fixes: dafcf4ed8392 ("iio: hrtimer: Allow sub Hz granularity")
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks, Applied to the togreg branch of iio.git and pushed out as testing
> for 0-day to poke at it.

Awesome. :)

Thanks, Jonathan.

--
Gustavo
