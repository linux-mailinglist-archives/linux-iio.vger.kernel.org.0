Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E311B43CD7E
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbhJ0Pbb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 11:31:31 -0400
Received: from vern.gendns.com ([98.142.107.122]:60362 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242749AbhJ0Pb2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 Oct 2021 11:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rimMaM7OY3CFXN1BQiiQL/G8JJJKlfVWuF+xgvDHvDo=; b=rGXXoUJigYvVnaKgQqx0MosKgM
        JFVont4hCWE64tGZ7YCG2espgZsemTL8oYBJlZ7JGoJQQx/iTeLJChpkECPxut3Sp4ZD3KqZsrY8u
        hZDk7SSFNeSmsCrPiDF1lLyjYA0n/9HXIK+8yLOmd5lqAusNuMXlQT0TpGe1Zf7l4EuAibdi/kwKe
        r4Ss1WNnA2J0Z7hWihJxWajFYrjNPS+8S6ooHpZB9cJc9s3qO1GnGY5iOVxteZ39NTJ2WRO5ysWyS
        yvkf89z/C2Xabr3Jb63y7VaAjgA1d4dvxz0KKnsPwGWVBokFdsWXmJqB9fEQKocAVVZ4Pjpeoxf6s
        5M4h6B3w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42838 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mfkrE-0001BT-Ii; Wed, 27 Oct 2021 11:29:00 -0400
Subject: Re: [PATCH 3/8] counter/ti-eqep: add support for unit timer
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-4-david@lechnology.com> <YXZvQSU6bRRaWD89@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <253916e2-a808-8786-ac72-60a1a62b1531@lechnology.com>
Date:   Wed, 27 Oct 2021 10:28:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXZvQSU6bRRaWD89@shinobu>
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

On 10/25/21 3:48 AM, William Breathitt Gray wrote:
> On Sat, Oct 16, 2021 at 08:33:38PM -0500, David Lechner wrote:
>> This adds support to the TI eQEP counter driver for the Unit Timer.
>> The Unit Timer is a device-level extension that provides a timer to be
>> used for speed calculations. The sysfs interface for the Unit Timer is
>> new and will be documented in a later commit. It contains a R/W time
>> attribute for the current time, a R/W period attribute for the timeout
>> period and a R/W enable attribute to start/stop the timer. It also
>> implements a timeout event on the chrdev interface that is triggered
>> each time the period timeout is reached.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> I'll comment on the sysfs interface in the respective docs patch. Some
> comments regarding this patch below.
> 

...

>> +static int ti_eqep_unit_timer_period_write(struct counter_device *counter,
>> +					   u64 value)
>> +{
>> +	struct ti_eqep_cnt *priv = counter->priv;
>> +	u32 quprd;
>> +
>> +	/* convert nanoseconds to timer ticks */
>> +	quprd = value = mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_PER_SEC);
>> +	if (quprd != value)
>> +		return -ERANGE;
>> +
>> +	/* protect against infinite unit timeout interrupts */
>> +	if (quprd == 0)
>> +		return -EINVAL;
> 
> I doubt there's any practical reason for a user to set the timer period
> to 0, but perhaps we should not try to protect users from themselves
> here. It's very obvious and expected that setting the timer period to 0
> results in timeouts as quickly as possible, so really the user should be
> left to reap the fruits of their decision regardless of how asinine that
> decision is.

Even if the operating system ceases operation because the interrupt
handler keeps running because clearing the interrupt has no effect
in this condition?

...

>> @@ -500,6 +608,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct ti_eqep_cnt *priv;
>> +	struct clk *clk;
>>   	void __iomem *base;
>>   	int err;
>>   	int irq;
>> @@ -508,6 +617,24 @@ static int ti_eqep_probe(struct platform_device *pdev)
>>   	if (!priv)
>>   		return -ENOMEM;
>>   
>> +	clk = devm_clk_get(dev, "sysclkout");
>> +	if (IS_ERR(clk)) {
>> +		if (PTR_ERR(clk) != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get sysclkout");
>> +		return PTR_ERR(clk);
>> +	}
>> +
>> +	priv->sysclkout_rate = clk_get_rate(clk);
>> +	if (priv->sysclkout_rate == 0) {
>> +		dev_err(dev, "failed to get sysclkout rate");
>> +		/* prevent divide by zero */
>> +		priv->sysclkout_rate = 1;
>> +		/*
>> +		 * This error is not expected and the driver is mostly usable
>> +		 * without clock rate anyway, so don't exit here.
>> +		 */
> 
> If the values for these new attributes are expected to be denominated in
> nanoseconds then we must guarantee that. You should certainly error out
> here if you can't guarantee such.
> 
> Alternatively, you could provide an additional set of attributes that
> are denominated in units of raw timer ticks rather than nanoseconds.
> That way if you can't determine the clock rate you can simply have the
> nanosecond-denominated timer attributes return an EOPNOTSUPP error code
> or similar while still providing users with the raw timer ticks
> attributes.

I think we should just fail here.
