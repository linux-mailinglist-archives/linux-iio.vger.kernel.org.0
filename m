Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A152E7D31
	for <lists+linux-iio@lfdr.de>; Thu, 31 Dec 2020 00:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL3Xew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 18:34:52 -0500
Received: from vern.gendns.com ([98.142.107.122]:36428 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgL3Xew (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 18:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LsHXR2e4SeHb6nWLvgDlYAkW2jrz4NZvHBU+beGGqjk=; b=nxOVY/Upf6L9yB0fDOUuLdENEu
        BOdqHHrdHdVimcpoi0AQghaNPDV8Hof/YwQUsMycf1Do8Z67fA/B0Op8weZbHDvlTbxuDiLHH6vTT
        05DDFAb0CIT8mBUxzrRxqSD64RG/7guGbGOlpB46z/iTK4FC2y9qxjreD6xIOTljiBPSxpaZ6DYsK
        k/p6zNPA+0xk1PFN6Ohur9iVsPjeN1ixfow1LPIzElqdsm9QtJiSkuJbndXKLgtXkf6nCSIHvg1a9
        2uPXEFhM3qRbse7xFeW6fpvoUSnfj5z0G33dVVJ57q3JjfowJZvG8wriPL6htGLaRRp4COvxNu1Hn
        E7vxSzGQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:43040 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kukyn-0006qC-7b; Wed, 30 Dec 2020 18:34:09 -0500
Subject: Re: [PATCH v7 0/5] Introduce the Counter character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <28cfe031-8883-3160-8658-084c2d4260c0@lechnology.com>
Date:   Wed, 30 Dec 2020 17:34:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1608935587.git.vilhelm.gray@gmail.com>
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

On 12/25/20 6:15 PM, William Breathitt Gray wrote:
> Changes in v7:
>   - Implemented u32 enums; enum types can now be used directly for
>     callbacks and values
>   - Fixed refcount underflow bug
>   - Refactored all err check to check for err < 0; this should help
>     prevent future oversights on valid positive return valids
>   - Use mutex instead of raw_spin_lock in counter_chrdev_read();
>     kifo_to_user() can now safely sleep
>   - Renamed COUNTER_COMPONENT_DUMMY to COUNTER_COMPONENT_NONE to make
>     purpose more obvious
>   - Introduced a watch_validate() callback
>   - Consolidated the functionality to clear the watches to the
>     counter_clear_watches() function
>   - Reimplemented counter_push_event() as a void function; on error,
>     errno is returned via struct counter_event so that it can be handled
>     by userspace (because interrupt handlers can't do much for this)
>   - Renamed the events_config() callback to events_configure();
>     "events_config" could be confused as a read callback when this is
>     actually intended to configure the device for the requested events
>   - Reimplemented 104-QUAD-8 driver to use events_configure() and
>     watch_validate() callbacks; irq_trigger_enable sysfs attribute
>     removed because events_configure() now serves this purpose
> 
> The changes for this revision were much simpler compared to the previous
> revisions. I don't have any further questions for this patchset, so it's
> really just a search for possible bugs or regressions now. Please test
> and verify this patchset on your systems, and ACK appropriately.
> 

I'll wait for the next round to give my Reviewed-By, Tested-By but I've
rebased my WIP TI eQEP changes[1] on this and I haven't ran into any
problems yet.

[1]: https://github.com/dlech/linux/commits/bone-counter

