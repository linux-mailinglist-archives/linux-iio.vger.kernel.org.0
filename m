Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D381328D752
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 02:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgJNANj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 20:13:39 -0400
Received: from vern.gendns.com ([98.142.107.122]:52492 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbgJNANj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Oct 2020 20:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YEZVzb5NwZBUhd0JiFn2u7ZSr9noWt1yX5Lw4ZpfGEU=; b=uXxsxtf44QitHmcVBPGb354fjD
        eSqybcEPKEu43jiVtgDkP/M62nWXj4214aztAstryyFlWiwSPWmqK2g2lUn3WfMf6ih9zd1c3TF14
        PFn6zEFWijL6/1xYHAOVrLP606XD5kYxkapRJnn1ff6q+fxZwKR43pkbsi3oeJ6A510UrZNWkeXoy
        pFjPQC4sPNv/Dln4jrMYQ+QOhQixPE2+zHtnhp35wAxpUoy97ngydg3x+bs7cykIZ8p66OkZZQi2V
        5oXHL7WE5jSm0hxsyV34aGg4wK4gE3Zmv6fzVd53/Y/d90PanD0X6XpUjkWJgJ5ZUo2/JP+Ijxh2f
        z+1jBtxw==;
Received: from [2600:1700:4830:165f::19e] (port=53810)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kSUQB-0000Zk-6m; Tue, 13 Oct 2020 20:13:35 -0400
Subject: Re: [PATCH v5 5/5] counter: 104-quad-8: Add IRQ support for the ACCES
 104-QUAD-8
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <7a829fe8cba3ae222796328f832bd2546769e6ac.1601170670.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <a0e54a35-eed6-a938-dd4e-4f602d3b50c0@lechnology.com>
Date:   Tue, 13 Oct 2020 19:13:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7a829fe8cba3ae222796328f832bd2546769e6ac.1601170670.git.vilhelm.gray@gmail.com>
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
> +static irqreturn_t quad8_irq_handler(int irq, void *quad8iio)
> +{
> +	struct quad8_iio *const priv = quad8iio;
> +	const unsigned long base = priv->base;
> +	unsigned long irq_status;
> +	unsigned long channel;
> +	u8 event;
> +	int err;
> +
> +	irq_status = inb(base + QUAD8_REG_INTERRUPT_STATUS);
> +	if (!irq_status)
> +		return IRQ_NONE;
> +
> +	for_each_set_bit(channel, &irq_status, QUAD8_NUM_COUNTERS) {
> +		switch (priv->irq_trigger[channel]) {
> +		case 0:
> +			event = COUNTER_EVENT_OVERFLOW;
> +				break;
> +		case 1:
> +			event = COUNTER_EVENT_THRESHOLD;
> +				break;
> +		case 2:
> +			event = COUNTER_EVENT_OVERFLOW_UNDERFLOW;
> +				break;
> +		case 3:
> +			event = COUNTER_EVENT_INDEX;
> +				break;
> +		default:
> +			/* We should never reach here */
> +			return -EINVAL;

This is not a valid return value for an IRQ handler. Maybe WARN_ONCE instead?

> +		}
> +		err = counter_push_event(&priv->counter, event, channel);
> +		if (err)
> +			return err;

Same here. Otherwise, I think we could end up with interrupts in an endless
loop since the interrupt would never be cleared.

> +	}
> +
> +	/* Clear pending interrupts on device */
> +	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base + QUAD8_REG_CHAN_OP);
> +
> +	return IRQ_HANDLED;
> +}
> +

