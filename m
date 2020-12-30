Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1864C2E7CB4
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 22:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL3VhX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 16:37:23 -0500
Received: from vern.gendns.com ([98.142.107.122]:54190 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgL3VhX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 16:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+X56aQz2Xxt34I0apf6tUs9ZclkxahPRlOH//OiXMdg=; b=dmEgL5yAFDUPmj9oy2SfDLKcT6
        WnQVbaHHFQAb6xe6WV0+gA47Oj156sCu4C+e96Vaz9t/hXv7NinJVprz2DnJ4V96dshzH4M2NG0RN
        CUUu0luQEnB/dtmvzMegwAhb4Wwcu2AJAqypmXB6hPNNVoKRJmV6CqEXWNb5FCM4/OGNLfWWqubYt
        QGdbwZYOJ5hb+yAQKVKS2l/+7bVk3gUinA643TMM1iEIje0mmsmCFPEYyyn6c2KtZaxXvReDxGcNy
        /7LxEMpzaeUDdTzXiZx/iewTVI8eWNkIerlVwDclEVgYkwMtSdbQU8VX8D/s7H52MCw5mknwO1GVt
        C+oVCg8w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:38790 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kuj92-0004DA-Bj; Wed, 30 Dec 2020 16:36:36 -0500
Subject: Re: [PATCH v7 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <57bc509273bf288d74835e6ebdaebf27b4991888.1608935587.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <e9102ed7-d4e1-0c81-96f3-8d3c297d037f@lechnology.com>
Date:   Wed, 30 Dec 2020 15:36:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <57bc509273bf288d74835e6ebdaebf27b4991888.1608935587.git.vilhelm.gray@gmail.com>
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

> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> new file mode 100644
> index 000000000000..7585dc9db19d
> --- /dev/null
> +++ b/include/uapi/linux/counter.h
> @@ -0,0 +1,123 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace ABI for Counter character devices
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#ifndef _UAPI_COUNTER_H_
> +#define _UAPI_COUNTER_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Component type definitions */
> +enum counter_component_type {
> +	COUNTER_COMPONENT_NONE,
> +	COUNTER_COMPONENT_SIGNAL,
> +	COUNTER_COMPONENT_COUNT,
> +	COUNTER_COMPONENT_FUNCTION,
> +	COUNTER_COMPONENT_SYNAPSE_ACTION,
> +	COUNTER_COMPONENT_EXTENSION,
> +};
> +
> +/* Component scope definitions */
> +enum counter_scope {

Do we need COUNTER_SCOPE_NONE to go with COUNTER_COMPONENT_NONE?

> +	COUNTER_SCOPE_DEVICE,
> +	COUNTER_SCOPE_SIGNAL,
> +	COUNTER_SCOPE_COUNT,
> +};
> +
> +/**
> + * struct counter_component - Counter component identification
> + * @type: component type (Count, extension, etc.)

Instead of "Count, extension, etc.", it could be more helpful
to say one of enum counter_component_type.

> + * @scope: component scope (Device, Count, or Signal)

Same here. @scope must be one of enum counter_scope.

> + * @parent: parent component identification number
> + * @id: component identification number

It could be helpful to say that these id numbers match
the X/Y/Z in the sysfs paths as described in the sysfs
ABI.

> + */
> +struct counter_component {
> +	__u8 type;
> +	__u8 scope;
> +	__u8 parent;
> +	__u8 id;
> +};
> +
> +/* Event type definitions */
> +enum counter_event_type {
> +	COUNTER_EVENT_OVERFLOW,
> +	COUNTER_EVENT_UNDERFLOW,
> +	COUNTER_EVENT_OVERFLOW_UNDERFLOW,
> +	COUNTER_EVENT_THRESHOLD,
> +	COUNTER_EVENT_INDEX,
> +};
> +
> +/**
> + * struct counter_watch - Counter component watch configuration
> + * @component: component to watch when event triggers
> + * @event: event that triggers

It would be helpful to say that @event must be one of
enum counter_event_type.

> + * @channel: event channel

It would be useful to say that @channel should be 0 unless
a component has more than one event of the same type.

> + */
> +struct counter_watch {
> +	struct counter_component component;
> +	__u8 event;
> +	__u8 channel;
> +};
> +
> +/* ioctl commands */
> +#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
> +#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
> +#define COUNTER_LOAD_WATCHES_IOCTL _IO(0x3E, 0x02)
> +
> +/**
> + * struct counter_event - Counter event data
> + * @timestamp: best estimate of time of event occurrence, in nanoseconds
> + * @value: component value
> + * @watch: component watch configuration
> + * @errno: system error number
> + */
> +struct counter_event {
> +	__aligned_u64 timestamp;
> +	__aligned_u64 value;
> +	struct counter_watch watch;
> +	__u8 errno;

There are error codes larger than 255. Probably better
make this __u32.

> +};
> +
> +/* Count direction values */
> +enum counter_count_direction {
> +	COUNTER_COUNT_DIRECTION_FORWARD,
> +	COUNTER_COUNT_DIRECTION_BACKWARD,
> +};
> +
> +/* Count mode values */
> +enum counter_count_mode {
> +	COUNTER_COUNT_MODE_NORMAL,
> +	COUNTER_COUNT_MODE_RANGE_LIMIT,
> +	COUNTER_COUNT_MODE_NON_RECYCLE,
> +	COUNTER_COUNT_MODE_MODULO_N,
> +};
> +
> +/* Count function values */
> +enum counter_function {
> +	COUNTER_FUNCTION_INCREASE,
> +	COUNTER_FUNCTION_DECREASE,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X1_A,
> +	COUNTER_FUNCTION_QUADRATURE_X1_B,
> +	COUNTER_FUNCTION_QUADRATURE_X2_A,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +};
> +
> +/* Signal values */
> +enum counter_signal_level {
> +	COUNTER_SIGNAL_LEVEL_LOW,
> +	COUNTER_SIGNAL_LEVEL_HIGH,
> +};
> +
> +/* Action mode values */
> +enum counter_synapse_action {
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +};
> +
> +#endif /* _UAPI_COUNTER_H_ */
> 

