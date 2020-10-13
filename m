Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1C28C66A
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 02:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgJMAf7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 20:35:59 -0400
Received: from vern.gendns.com ([98.142.107.122]:36066 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbgJMAfS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 20:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i3DN6BtJb3Jcv8rh81sTBY6UT+tAKn+rVAVT3o7iIs0=; b=LCWAFnRQ9KOZLwI3SDaZMqncKF
        f/DMPsIh8viZE5VxEU395L0jKfZ8dHRv62q3AUsfR32nPKPduHKBTAcODM2InG2K5L9el+tpax9lu
        RvXe2CekmCNzDQHRTFFJMNKSPaf4ROoDVJWaiGbGvnPxPnmCMpRLLGogchn7I6YAMjMssrq+eRPnh
        pUetcBTuhuR+6qCd1PI3sePSJ2uQYE8990YSxuSwWmq6uhcJriMzwMTZVCj3ybIcvJGvsjwZ3nE+j
        ENd2JhPRPtymm+u+khNB97+5AQe1/KRpoi59MZmIZJ9ksLZz80kd8T/J1WfaRNPWz3zqoX6/eTzow
        ebDqpVoQ==;
Received: from [2600:1700:4830:165f::19e] (port=56668)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kS8HZ-0000vN-Pn; Mon, 12 Oct 2020 20:35:13 -0400
Subject: Re: [PATCH v5 0/5] Introduce the Counter character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <caeeb0b2-6b66-b623-98e3-acdc261ec20e@lechnology.com>
Date:   Mon, 12 Oct 2020 19:35:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1601170670.git.vilhelm.gray@gmail.com>
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
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> The following are some questions I have about this patchset:
> 
> 1. Should standard Counter component data types be defined as u8 or u32?
> 
>     Many standard Counter component types such COUNTER_COMP_SIGNAL_LEVEL
>     have standard values defined (e.g. COUNTER_SIGNAL_LEVEL_LOW and
>     COUNTER_SIGNAL_LEVEL_HIGH). These values are currently handled by the
>     Counter subsystem code as u8 data types.
> 
>     If u32 is used for these values instead, C enum structures could be
>     used by driver authors to implicit cast these values via the driver
>     callback parameters; userspace would still use u32 with no issue.
> 
>     In theory this can work because GCC will treat enums are having a
>     32-bit size; but I worry about the possibility of build targets that
>     have -fshort-enums enabled, resulting in enums having a size less
>     than 32 bits. Would this be a problem?

We shouldn't have to worry about userspace programs using -fshort-enums
since that would break all kernel interfaces that use enums, not just
these - so no one should be using that compiler flag.

So I am in favor of using strongly typed enums with u32 as the
"generic" enum member type.

> 
> 2. Should I have reserved members in the userspace structures?
> 
>     The structures in include/uapi/linux/counter.h are available to
>     userspace applications. Should I reserve space in these structures
>     for future additions and usage? Will endianess and packing be a
>     concern here?
> 
Since there doesn't seem to be a large number of counter devices
this probably isn't critical. Are there any aspects of counter
devices in general that couldn't be described with the proposed
structures? For example, could there be components more than two
levels deep (i.e. it would need id, parent id and grandparent id
to describe fully)?
