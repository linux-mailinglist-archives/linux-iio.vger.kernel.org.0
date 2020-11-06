Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACBD2A9227
	for <lists+linux-iio@lfdr.de>; Fri,  6 Nov 2020 10:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKFJLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Nov 2020 04:11:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbgKFJLS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2020 04:11:18 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A698C8Y027456;
        Fri, 6 Nov 2020 10:11:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=OIxqUeyyKEzLBcLjzM/IbizYsmrpr5gy6hnhfU5LGzc=;
 b=okDqn205z9JQwRUVb7RMqH4Kz1u+/JNAVb3GH1seYZdIhNK+eqBezBSZnhrC0C8Qg/1L
 JP+2xh/539YI26WyXzCV77W6pZttlpHVDkaxziP2IZ4cPyiIokXeFra4yPisjtmc4lkD
 MC3VMc8K4ly0xYXjNzdC90EZCejO6pLa4V8XckHj5BNKWSVA5GTnM1wewWVx1EOAiK1L
 ducmvck5T/x4JVlITq3apjDXfpaBs0Pk19zs60c+9Vh4ktCC55tQWo3NEdnjLHSTSjeQ
 8dQqsOV/jSDNvHqI6ZTPpwgTY2ek6Jkn2ENbLf4kAhk8uFAN9ol52hYUreWIW2GLmBWz vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywrd6n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:11:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BABC10002A;
        Fri,  6 Nov 2020 10:11:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E583233854;
        Fri,  6 Nov 2020 10:11:09 +0100 (CET)
Received: from [10.211.1.197] (10.75.127.44) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 10:11:08 +0100
Subject: Re: Counter device Interface for reading out input capture
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Holger Assmann <h.assmann@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
References: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <f9f26c15-f214-0fa5-3d12-10a5ec3b6202@st.com>
Date:   Fri, 6 Nov 2020 10:11:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e8c99989-f018-dd90-2144-e09c05a3731b@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Ahmad,

On 11/5/20 7:46 PM, Ahmad Fatoum wrote:
> Hello Benjamin,
> Hello Fabrice,
> 
> In the stm32-timer-cnt driver I find unused #defines for TIM_CCMR_MASK and
> TIM_CCER_MASK, which to me hint that support for the "input capture mode"[1]
> was implemented but removed prior to upstreaming.

Indeed, I'm not sure why such defines have been added in
stm32-timer-cnt. They could probably be removed (and are possibly
redundant with other definitions in STM32 PWM/capture driver...)

> 
> It doesn't look like the counter device API is yet made to support such
> an input capture mode (latching a counter value on an external event, e.g.
> to timestamp incoming rising edges to measure jitter between pulses).

Regarding recent updates for the counter device API, maybe William could
bring some hints (I haven't checked or had time to follow this up :-().

> 
> I am still very new to this, so I figured I ask whether you already have
> thoughts (or maybe code to share) on how to best integrate this with the
> counter device API.

FYI, The only use of the STM32 timer input capture mode currently
implemented (in STM32 timer Linux drivers) is through the PWM capture
interface (drivers/pwm/pwm-stm32.c).
It's using 40.3.8 PWM input mode which is a particular case of input
capture mode you point in [1].
Not sure if this can help for time-stamping (at best as code example?).

One though I have is: a particular timer will be able to do either
quadrature encoder or input capture... So likely timestamping would
require an additional timer. But I haven't really checked how this could
be implemented in the hardware or driver.

May I ask a bit more information regarding your needs here?

Regards,
Fabrice
> 
> I've added linux-iio/linux-stm32 to the CC as well, so if someone else
> has an idea how to best do this, please share.
> 
> [1]: 40.3.7 in RM0436 rev 3
> 
> Cheers,
> Ahmad
> 
