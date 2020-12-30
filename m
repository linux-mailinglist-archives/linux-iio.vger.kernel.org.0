Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0D2E7BE7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL3STg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 13:19:36 -0500
Received: from vern.gendns.com ([98.142.107.122]:35294 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgL3STg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 13:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O9mAikuge8pWDxbxgmMYsQbwjgUOHpJq51Q8DnCsMXQ=; b=SzEj0GC0ZBhffp0IlIIHKLzDUC
        II8ujY8T84xu/SPS6I3m3I6DqFajTGL/rAd4WelaIQ8CLxR0lQzjWSnHTRKAukt7DLK8p0lMlPQAn
        l5RkqPnSkZlDn3tIEeGpaO4Z9QKFKXRqwUuEJFoQIEg62Zku51eW8AYz6+iyBBP5ptJYpCxp9Th6H
        xMGAxGJeug8IKKe/+x6/WANr9j4QpEgSqqWjNn5yF3jweHtmKdhfFALGLO14aTXOIufwvY1wWZjAY
        jEQTXzWk0OL5OKZAsdy6usEdIPu7Pgd91RTUy6X2ibjdd5ELX5rmHEIGQPAHulBqycCTf8dcEPRvc
        2KkuIzeQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:59368 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kug3e-00030h-5O; Wed, 30 Dec 2020 13:18:50 -0500
Subject: Re: [PATCH v7 4/5] docs: counter: Document character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <1e69b7beae4cf352bddb379220d0d52b20db0634.1608935587.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <416fe56e-bfb3-3f46-7f03-17009fa27dee@lechnology.com>
Date:   Wed, 30 Dec 2020 12:18:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1e69b7beae4cf352bddb379220d0d52b20db0634.1608935587.git.vilhelm.gray@gmail.com>
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

> +Userspace
> +---------
> +Userspace applications can configure Counter events via ioctl operations
> +on the Counter character device node. There following ioctl codes are
> +supported and provided by the `linux/counter.h` userspace header file:
> +
> +* COUNTER_CLEAR_WATCHES_IOCTL:
> +  Clear all Counter watches from all events
> +
> +* COUNTER_ADD_WATCH_IOCTL:
> +  Add a Counter watch for the specified event
> +
> +* COUNTER_LOAD_WATCHES_IOCTL:
> +  Activates the Counter watches added earlier

Would it make more sense to call the last and first ones
COUNTER_ENABLE_EVENTS_IOCTL and COUNTER_DISABLE_EVENTS_IOCTL?
In any case, more explanation would be helpful.

* COUNTER_ADD_WATCH_IOCTL:
   Queues a Counter watch for the specified event. The queued watches
   will not be applied until COUNTER_ENABLE_EVENTS_IOCTL is called.

* COUNTER_ENABLE_EVENTS_IOCTL:
   Enables monitoring the events specified by the Counter watches that were
   queued by COUNTER_ADD_WATCH_IOCTL. If events are already enabled, the new
   set of watches replaces the old one. Calling this ioctl also has the
   effect of clearing the queue of watches added by COUNTER_ADD_WATCH_IOCTL.

* COUNTER_DISABLE_EVENTS_IOCTL:
   Stops monitoring the previously enabled events.

> +
> +To configure events to gather Counter data, users first populate a
> +`struct counter_watch` with the relevant event id, event channel id, and
> +the information for the desired Counter component from which to read,
> +and then pass it via the `COUNTER_ADD_WATCH_IOCTL` ioctl command.

for restructured text, two backticks are needed for ``code`` formatting


