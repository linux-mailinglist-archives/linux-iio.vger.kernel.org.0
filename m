Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A143CD71
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhJ0PZp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 11:25:45 -0400
Received: from vern.gendns.com ([98.142.107.122]:57718 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237959AbhJ0PZn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 11:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JPkBCqgYVIGboIjbJlTu2+TTRW22j5I9RNJDnQc/zOw=; b=EFvcRqkoYf0Grkn1S+Avb9oGyy
        2z6XItdZN+CPjSMFEgeyTIvLieAOJc0TuJS06VIOpXwJTd3hlmbdYGAA5OWWyAOHrv05gKFJ0zKjd
        ccZfOjLoyf0EQaHVJm93c1d9BorFBDRKk7U7JzN8FLK4t6Vb392XyeGN4ssGubH235pHdV7JTm+p5
        sWf+5shv8bNe8LVRV9Y5st3vFTzq37ViaCF2cxvq1XeQiCWDr9PZck5JH66ZMWfPvcEy/EcbTnsGV
        mIxp5H22clVwGahareHer1Rihr+Y/UEiMnYAbPnrcpQ5O/e/vsFBCoCnvNkCyb6PMA0yFytWUHKHT
        T1NrQqOA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42722 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mfkle-00005U-As; Wed, 27 Oct 2021 11:23:14 -0400
Subject: Re: [PATCH 1/8] counter/ti-eqep: implement over/underflow events
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-2-david@lechnology.com> <YXZZCn9O4xSTHMx5@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <1d9f37b9-8600-1d8c-09ff-b9d9cc592b26@lechnology.com>
Date:   Wed, 27 Oct 2021 10:23:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXZZCn9O4xSTHMx5@shinobu>
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

On 10/25/21 2:13 AM, William Breathitt Gray wrote:
> On Sat, Oct 16, 2021 at 08:33:36PM -0500, David Lechner wrote:
>> This adds support to the TI eQEP counter driver for subscribing to
>> overflow and underflow events using the counter chrdev interface.
>>
>> Since this is the first event added, this involved adding an irq
>> handler. Also, additional range checks had to be added to the ceiling
>> attribute to avoid infinite interrupts.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Hi David,
> 
> This looks functionally okay, but I have a couple minor comments inline.
> 
>> ---
>>   drivers/counter/ti-eqep.c | 119 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 117 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
>> index 09817c953f9a..b7c79435e127 100644
>> --- a/drivers/counter/ti-eqep.c
>> +++ b/drivers/counter/ti-eqep.c
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/bitops.h>
>>   #include <linux/counter.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>> @@ -67,6 +68,44 @@
>>   #define QEPCTL_UTE		BIT(1)
>>   #define QEPCTL_WDE		BIT(0)
>>   
>> +#define QEINT_UTO		BIT(11)
>> +#define QEINT_IEL		BIT(10)
>> +#define QEINT_SEL		BIT(9)
>> +#define QEINT_PCM		BIT(8)
>> +#define QEINT_PCR		BIT(7)
>> +#define QEINT_PCO		BIT(6)
>> +#define QEINT_PCU		BIT(5)
>> +#define QEINT_WTO		BIT(4)
>> +#define QEINT_QDC		BIT(3)
>> +#define QEINT_PHE		BIT(2)
>> +#define QEINT_PCE		BIT(1)
>> +
>> +#define QFLG_UTO		BIT(11)
>> +#define QFLG_IEL		BIT(10)
>> +#define QFLG_SEL		BIT(9)
>> +#define QFLG_PCM		BIT(8)
>> +#define QFLG_PCR		BIT(7)
>> +#define QFLG_PCO		BIT(6)
>> +#define QFLG_PCU		BIT(5)
>> +#define QFLG_WTO		BIT(4)
>> +#define QFLG_QDC		BIT(3)
>> +#define QFLG_PHE		BIT(2)
>> +#define QFLG_PCE		BIT(1)
>> +#define QFLG_INT		BIT(0)
>> +
>> +#define QCLR_UTO		BIT(11)
>> +#define QCLR_IEL		BIT(10)
>> +#define QCLR_SEL		BIT(9)
>> +#define QCLR_PCM		BIT(8)
>> +#define QCLR_PCR		BIT(7)
>> +#define QCLR_PCO		BIT(6)
>> +#define QCLR_PCU		BIT(5)
>> +#define QCLR_WTO		BIT(4)
>> +#define QCLR_QDC		BIT(3)
>> +#define QCLR_PHE		BIT(2)
>> +#define QCLR_PCE		BIT(1)
>> +#define QCLR_INT		BIT(0)
>> +
>>   /* EQEP Inputs */
>>   enum {
>>   	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
>> @@ -233,12 +272,46 @@ static int ti_eqep_action_read(struct counter_device *counter,
>>   	}
>>   }
>>   
>> +static int ti_eqep_events_configure(struct counter_device *counter)
>> +{
>> +	struct ti_eqep_cnt *priv = counter->priv;
>> +	struct counter_event_node *event_node;
>> +	u32 qeint = 0;
>> +
>> +	list_for_each_entry(event_node, &counter->events_list, l) {
>> +		switch (event_node->event) {
>> +		case COUNTER_EVENT_OVERFLOW:
>> +			qeint |= QEINT_PCO;
>> +			break;
>> +		case COUNTER_EVENT_UNDERFLOW:
>> +			qeint |= QEINT_PCU;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return regmap_write_bits(priv->regmap16, QEINT, ~0, qeint);
>> +}
>> +
>> +static int ti_eqep_watch_validate(struct counter_device *counter,
>> +				  const struct counter_watch *watch)
>> +{
>> +	switch (watch->event) {
>> +	case COUNTER_EVENT_OVERFLOW:
>> +	case COUNTER_EVENT_UNDERFLOW:
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>   static const struct counter_ops ti_eqep_counter_ops = {
>>   	.count_read	= ti_eqep_count_read,
>>   	.count_write	= ti_eqep_count_write,
>>   	.function_read	= ti_eqep_function_read,
>>   	.function_write	= ti_eqep_function_write,
>>   	.action_read	= ti_eqep_action_read,
>> +	.events_configure = ti_eqep_events_configure,
>> +	.watch_validate	= ti_eqep_watch_validate,
>>   };
>>   
>>   static int ti_eqep_position_ceiling_read(struct counter_device *counter,
>> @@ -260,11 +333,17 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
>>   					  u64 ceiling)
>>   {
>>   	struct ti_eqep_cnt *priv = counter->priv;
>> +	u32 qposmax = ceiling;
>>   
>> -	if (ceiling != (u32)ceiling)
>> +	/* ensure that value fits in 32-bit register */
>> +	if (qposmax != ceiling)
>>   		return -ERANGE;
>>   
>> -	regmap_write(priv->regmap32, QPOSMAX, ceiling);
>> +	/* protect against infinite overflow interrupts */
>> +	if (qposmax == 0)
>> +		return -EINVAL;
> 
> Would you be able to explain this scenario a bit further? My expectation
> would be that an overflow event would only occur if the position
> increased past the ceiling (i.e. increased to greater than 0). Of
> course, running the device with a ceiling of 0 effectively guarantees
> overflow eventss with every movement, but I would expect a stationary
> device to sit with a position of 0 and thus no overflow events.
> 

This is just the way the hardware works. I discovered this the first
time I enabled interrupts. Even if you clear the interrupt, it is
triggered again immediately when QPOSMAX == 0.
