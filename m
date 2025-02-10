Return-Path: <linux-iio+bounces-15244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BAA2E82D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686EB164341
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710422E628;
	Mon, 10 Feb 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="nMZz+fZC"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644B1C4604;
	Mon, 10 Feb 2025 09:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180962; cv=none; b=H0EluJsEk8Si6nUCXkXjwiK/gd98M9V4sh5cppjFCSNIjePuFyvMs7RMoTKMvyfIgT9IvtPat5jyItjcIpi7K/gmgy07zVdS3cqia9nyX2B6gZkfWlXC6EnaW4yfjdMyXbtVuhkL+pTgJQz0+EsMLAQDG0fm29QkdAjt2pWZVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180962; c=relaxed/simple;
	bh=nCVuBi8ZTrEmUADFZ2jR0DL8kYCKbpfdu66LMnXIQdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QMw4lSu2YTMSqm+5yfUAbbd90dR3JFeDRfAc51i++B06keOOZooyvpgxYQR0SViRbmGG/7pbMcpng4qy2JCTSLHCwCnGvQEZIhF+rVH6DZ5QgEakCal+T22nvTVueF9icD0Do+1xINtz13lggADuvfWdyuoBhyLkf2ASMGT9Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=nMZz+fZC; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 42831A008F;
	Mon, 10 Feb 2025 10:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=E+04FxogYzi4sdZRzCbF
	nxRd7zajIX6CS62l/K1+2oo=; b=nMZz+fZC8yZfoZ2XFlFzGQKyde72ueUik4Rk
	xfYEy3jujdD0kFCCmjJ7SLfd4ILmlLfoMgF+Y7JEYkEFQ2vMUmuJ1VipMR1t6u44
	OsnxF7W0G2j6fRjxET5pJ4kikMknR3x3pAYntsMSZSmFt5tiqj6k6K8N9FDbiy0r
	C5LTg3rXfXkRNtDDOQwETcQIMzI28QIQBIHZdVJHpZL8ZiYa63wf/w19O6EBtM/o
	Z0SwSlkDv36igAJQ2cCR9kzyguX9AbnXtB/Tev5f4KwMPSV36XqgBVUnEss+NGYe
	YDI/rgNM8SxVYf7dRL63vPVX9MNJ40TsVtycvFK/vlSqpyWgqiBZxANgzShIW4dF
	hCwd/U3uwUhVuy7DxVhY+DikCkhjseptCu4osvGV03GgBtvfREoeAGljzCMSEymr
	QYm3IVpP6BQRtdBXlwedNQVaYhy6a6tJFX0RBaT5K3WHd72Oxwf1pDHCIJoNQrAD
	III6dfpK9zcqKOqhKxAhRhmZyIJHJtu+MNJLn70JJXdzL3TZW4U2LskcNGRNu7uu
	hn50p/lKX7LkOled0WXfvEBLGmuxwVQGBQSxuOKCaw2AxloBUl3kG16c5cfpqdgG
	KGVNqqAXIm2pqVi2IAfsG+35/9MgEefL+fCcgwsjK5230ahdIoojtkZOe1H1+VMQ
	Jmqw3SQ=
Message-ID: <3f424600-33d3-403b-9df6-85f7cb97c9a6@prolan.hu>
Date: Mon, 10 Feb 2025 10:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] counter: microchip-tcb-capture: Add IRQ handling
To: <Dharma.B@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kamel.bouhara@bootlin.com>, <wbg@kernel.org>
References: <20250205104957.95236-1-csokas.bence@prolan.hu>
 <20250205104957.95236-2-csokas.bence@prolan.hu>
 <ed8b9d03-0f03-4872-b9e0-ab670e307450@microchip.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <ed8b9d03-0f03-4872-b9e0-ab670e307450@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D9485261776A

Hi,

On 2025. 02. 07. 9:12, Dharma.B@microchip.com wrote:
> can we have macros for the channel (3rd argument) for better clarity?

I myself have also thought about that, even about adding an uapi header. 
Thoughts?

>> +static int mchp_tc_irq_enable(struct counter_device *const counter)
> 
> Can we have it as mchp_tc_irq_init ?

Why, what's wrong with the current name? It requests IRQ servicing from 
Linux, then writes the peripheral's Interrupt Enable Register.

>> +{
>> +	struct mchp_tc_data *const priv = counter_priv(counter);
>> +	int ret = devm_request_irq(counter->parent, priv->irq, mchp_tc_isr, 0,
>> +				   dev_name(counter->parent), counter);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], IER), ATMEL_TC_DEF_IRQS);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_add_action_or_reset(counter->parent, mchp_tc_irq_remove, priv);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>>    static void mchp_tc_clk_remove(void *ptr)
>>    {
>>    	clk_disable_unprepare((struct clk *)ptr);
>> @@ -378,6 +438,13 @@ static int mchp_tc_probe(struct platform_device *pdev)
>>    	counter->num_signals = ARRAY_SIZE(mchp_tc_count_signals);
>>    	counter->signals = mchp_tc_count_signals;
>>    
>> +	priv->irq = of_irq_get(np->parent, 0);
>> +	if (priv->irq > 0) {
>> +		ret = mchp_tc_irq_enable(counter);
> 
> missing error handling in irq retrieval (check for -EPROBE_DEFER).

Hmm, what should happen on `priv->irq == -EPROBE_DEFER`? `return 
-EPROBE_DEFER`?

Bence


