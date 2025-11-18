Return-Path: <linux-iio+bounces-26282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4FC68BBA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 321563826BE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C28B336EDA;
	Tue, 18 Nov 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pIOI769u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WzS8TkIh"
X-Original-To: linux-iio@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACB3358D1;
	Tue, 18 Nov 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460543; cv=none; b=ZGZBDZdtvmL9kg//KRVOiyR79Xb18UAm89ehElP6uvIYUL009G1lBU7wZLQX/7x4cBjKnRQXtzg/Kw5b3QgzstlAYM/KErNB7ZiLFjwDIf0QIr9h547cqTBZa7wX7lyLrjsx18JSF5zKu7jxiskXOdu6tFFk2VSemLkKS0iWSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460543; c=relaxed/simple;
	bh=AtW8jtUgddBodlqPiBry2DugFdJtZaQw/+WuspCWlno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6Gil1IZiz5NrWFLhHQJixvpO6ZsqJUjFmuNG19nSxPRtvWKwPqQKjxZb8GLny9Yqy5O9YzIPgPQOA4xRD3nszody6yQvgubqpDRLXIidCLYCGYtls8VjCSx+F25PN5c51TH1PMyVvL6wMx5sGLeFl272pjkC5Cx0nmmGVdYrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pIOI769u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WzS8TkIh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 11:08:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763460524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DE+Ie23ppH/8k5wIDtkO9NeSNXeM6OLFKzi5tTSmK7Y=;
	b=pIOI769u6KVk5LQPG2eVgf7GgB4oEZrmpQvtNvt9bl/h7y3rf0/WCmmIxUynQfFVwee4la
	8/YAtlmyjLPaeVbEPrKSCpHe0Wlz6d61U/sQHSba1JSwMav+GYJP0hq/fFQ7Jhs3AE/fg0
	1aZIXLUlwtuTrGQXpuLpHVhLwEpfry3H+ktOvvVMRJdp7fMdqaT2rS5JXZnSb5oq2e2zye
	EzFTMBA3KTioE6uU5G/qmfs4Mi2YcM37NJw3stxQcU59oiOvm6uqAe6/+DR+PNCSMuDg11
	8w60KFJyWl3O1hb4BV1HT1MRDsw4Hu9yK2EcsNXCgN7OLlJ1CnY4Yk9mBuUJBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763460524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DE+Ie23ppH/8k5wIDtkO9NeSNXeM6OLFKzi5tTSmK7Y=;
	b=WzS8TkIhDQowvRRsDOufluZl6kSnUmKoDOWUYY/kOr4QhhfKepUTRSeRsYt8OaayNFF1S4
	/jESpRSWblF6DyDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-iio@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Message-ID: <20251118100842.jPZMHpnF@linutronix.de>
References: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
 <aRw4mIZpWdsr9exb@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRw4mIZpWdsr9exb@pengutronix.de>

On 2025-11-18 10:12:56 [+0100], Oleksij Rempel wrote:
> Hi Alexander,
Hi,

> > --- a/drivers/counter/interrupt-cnt.c
> > +++ b/drivers/counter/interrupt-cnt.c
> > @@ -229,8 +229,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
> >  
> >  	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
> >  	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> > -			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > -			       dev_name(dev), counter);
> > +			       IRQF_TRIGGER_RISING, dev_name(dev), counter);
> >  	if (ret)
> >  		return ret;
> >  
> 
> Hm, I guess it will break the requirement to handle at least 10kHz
> interrupts. May be we should move only counter_push_event() to the
> thread? or using delayed worker?

IRQF_NO_THREAD only prohibits threading of interrupts on !RT if
threadirqs was specified on the boot command line. This should not
effect you general use case.
As the threaded interrupt runs as SCHED_FIFO-50 it will be preferred
over any SCHED_OTHER so it still should the most prefer task in the
system. 10kHz interrupt sounds like one interrupt every 100us. This
sounds like a lot if the CPU is also doing other things.
Anyway.

> Right now I do not have needed system for testing to come with better
> proposal.
> 
> Best Regards,
> Oleksij

Sebastian

