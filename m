Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF53C36C0
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhGJUSB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 16:18:01 -0400
Received: from vern.gendns.com ([98.142.107.122]:51978 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhGJUSA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 16:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mmrCsDKGg86DQETWy6BobZbDY2kT6MR0c3riTEr4thk=; b=KacMMKoG+0WtEDhcw+lgOF/35x
        3lK13tF+e++/gUqQx7Q6SMx3zusqNmWUOwNOT033Ur1X54nERUkodGS7ogUCjB1RnOu7rR2419zMN
        JVKABhzqd0x+UsS6HMnhbozTk7gugRtfLTFzXwi+lk9Me/W1BRmAT8RSExKcQuycpF2wb9bJzx0TN
        HdXi7iZEwpd+Gb9sDiuXyiJfscxyikXYujg9BbaE9fnOmC2AE8oQH2qRc2jpEyH4AGEtKNlqC6dVL
        0Ca60yb75prcvc+XAUra/+FmUExSZN4Yi07UWDaH2qTOmJqesmx86AcP+bhVXi5M4VN56z6ZYa/JM
        wxV7exqw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:50632 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2JNI-00HTJW-0w; Sat, 10 Jul 2021 16:15:11 -0400
Subject: Re: [PATCH v12 11/17] docs: counter: Document character device
 interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <186e7a1cd7dc822cc9290683b463c3e675959e1a.1625471640.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <10ae3615-1fe4-0dce-5aa6-e865de2655a7@lechnology.com>
Date:   Sat, 10 Jul 2021 15:15:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <186e7a1cd7dc822cc9290683b463c3e675959e1a.1625471640.git.vilhelm.gray@gmail.com>
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

On 7/5/21 3:18 AM, William Breathitt Gray wrote:
> This patch adds high-level documentation about the Counter subsystem
> character device interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   Documentation/driver-api/generic-counter.rst  | 185 ++++++++++++++----
>   .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>   2 files changed, 145 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
> index f6397218aa4c..62a702e7f994 100644
> --- a/Documentation/driver-api/generic-counter.rst
> +++ b/Documentation/driver-api/generic-counter.rst


> +
> +Counter Character Device
> +========================
> +
> +Counter character device nodes are created under the ``/dev`` directory
> +as ``counterX``, where ``X`` is the respective counter device id.
> +Defines for the standard Counter data types are exposed via the
> +userspace ``include/uapi/linux/counter.h`` file.
> +
> +Counter events
> +--------------
> +Counter device drivers can support Counter events by utilizing the
> +``counter_push_event`` function::
> +
> +        void counter_push_event(struct counter_device *const counter, const u8 event,
> +                                const u8 channel);
> +
> +The event id is specified by the ``event`` parameter; the event channel
> +id is specified by the ``channel`` parameter. When this function is
> +called, the Counter data associated with the respective event is
> +gathered, and a ``struct counter_event`` is generated for each datum and
> +pushed to userspace.
> +
> +Counter events can be configured by users to report various Counter
> +data of interest. This can be conceptualized as a list of Counter
> +component read calls to perform. For example::

Won't the :: here make this appear as text instead of an HTML table?

(might need to change ~~~ to --- [top line] and === [middle line])

> +
> +        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
> +        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
> +        +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
> +        | Channel 0              | Channel 0              |
> +        +------------------------+------------------------+
> +        | * Count 0              | * Signal 0             |
> +        | * Count 1              | * Signal 0 Extension 0 |
> +        | * Signal 3             | * Extension 4          |
> +        | * Count 4 Extension 2  +------------------------+
> +        | * Signal 5 Extension 0 | Channel 1              |
> +        |                        +------------------------+
> +        |                        | * Signal 4             |
> +        |                        | * Signal 4 Extension 0 |
> +        |                        | * Count 7              |
> +        +------------------------+------------------------+
> +
> +When ``counter_push_event(counter, COUNTER_EVENT_INDEX, 1)`` is called
> +for example, it will go down the list for the ``COUNTER_EVENT_INDEX``
> +event channel 1 and execute the read callbacks for Signal 4, Signal 4
> +Extension 0, and Count 4 -- the data returned for each is pushed to a
> +kfifo as a ``struct counter_event``, which userspace can retrieve via a
> +standard read operation on the respective character device node.
> +
> +Userspace
> +---------
> +Userspace applications can configure Counter events via ioctl operations
> +on the Counter character device node. There following ioctl codes are
> +supported and provided by the ``linux/counter.h`` userspace header file:
> +
> +* COUNTER_ADD_WATCH_IOCTL:
> +  Queues a Counter watch for the specified event. The queued watches
> +  will not be applied until ``COUNTER_ENABLE_EVENTS_IOCTL`` is called.
> +
> +* COUNTER_ENABLE_EVENTS_IOCTL:
> +  Enables monitoring the events specified by the Counter watches that
> +  were queued by ``COUNTER_ADD_WATCH_IOCTL``. If events are already
> +  enabled, the new set of watches replaces the old one. Calling this
> +  ioctl also has the effect of clearing the queue of watches added by
> +  ``COUNTER_ADD_WATCH_IOCTL``.
> +
> +* COUNTER_DISABLE_EVENTS_IOCTL:
> +  Stops monitoring the previously enabled events.

I wouldn't mind seeing more of this documentation in the actual header
file and just referenced here with :c:macro:`COUNTER_ADD_WATCH_IOCTL`

> +
> +To configure events to gather Counter data, users first populate a
> +``struct counter_watch`` with the relevant event id, event channel id,
> +and the information for the desired Counter component from which to
> +read, and then pass it via the ``COUNTER_ADD_WATCH_IOCTL`` ioctl
> +command.
> +
> +Note that an event can be watched without gathering Counter data by
> +setting the ``component.type`` member equal to
> +``COUNTER_COMPONENT_NONE``. With this configuration the Counter
> +character device will simply populate the event timestamps for those
> +respective ``struct counter_event`` elements and ignore the component
> +value.

To make sure I am understanding this correctly, scope + parent
determines this part of the path:

	/sys/.../counterX/<scope><parent>/<component>

Or in the case that scope == COUNTER_SCOPE_DEVICE then parent
is not applicable:

	/sys/.../counterX/<component>

I suggested parent_id instead of parent earlier, but maybe
scope_id would be a better name? (Or rename scope to parent_type?)

> +
> +The ``COUNTER_ADD_WATCH_IOCTL`` command will buffer these Counter
> +watches. When ready, the ``COUNTER_ENABLE_EVENTS_IOCTL`` ioctl command
> +may be used to activate these Counter watches.
> +
> +Userspace applications can then execute a ``read`` operation (optionally
> +calling ``poll`` first) on the Counter character device node to retrieve
> +``struct counter_event`` elements with the desired data.
