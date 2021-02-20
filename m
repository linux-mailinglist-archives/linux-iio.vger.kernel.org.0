Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A66320651
	for <lists+linux-iio@lfdr.de>; Sat, 20 Feb 2021 17:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBTQ46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 11:56:58 -0500
Received: from vern.gendns.com ([98.142.107.122]:34166 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhBTQ46 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 11:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rtReqm6BD8NSkzJ0Wi5T2+JHymMgDP+iJZyHo3wdEQ8=; b=N/oMDpnItwRnMQX8p1llCL4Lb5
        06fFrczrCxCE0UVxM67Cpgzfm9bDaxCs/PeleokcZqpp/AJbQd9UcecaK+k4FSk1ueB/Kv2/pZ+M5
        YjP3TiteYL8vMp0T0ACnOcQZwVlRX532BRWG4AGis9yIJj6n2QCuYKSzF5f9cZwP3TvVVIF7kz57S
        5qwMOfBCnZj1ZcQVTl11zWp7H7lUKXojAKJ0YdzrBaC4nkogK5ofzR3A4o7/39CqPuNagNnPweLYQ
        3mSmIcP80Psuxe7AuKTzSL7JwtQx2AneZr+s0sj98qFvTJw2MwqisFZ40Ee+3HwIrK9mhzwNGyazD
        ODr55F3A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57830 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDVYE-0005DO-Qy; Sat, 20 Feb 2021 11:56:14 -0500
Subject: Re: [PATCH v8 12/22] counter: Rename counter_count_function to
 counter_function
To:     Jonathan Cameron <jic23@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <355aaaaf44b36c5de1704e4074a4671abcb9699d.1613131238.git.vilhelm.gray@gmail.com>
 <20210214171340.3cc7b686@archlinux>
From:   David Lechner <david@lechnology.com>
Message-ID: <2b6913ac-0802-f83e-06ba-e89d5318dbd7@lechnology.com>
Date:   Sat, 20 Feb 2021 10:56:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210214171340.3cc7b686@archlinux>
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

On 2/14/21 11:13 AM, Jonathan Cameron wrote:
> On Fri, 12 Feb 2021 21:13:36 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> 
>> The phrase "Counter Count function" is verbose and unintentionally
>> implies that function is a Count extension. This patch adjusts the
>> Counter subsystem code to use the more direct "Counter function" phrase
>> to make the intent of this code clearer. The phrase "Count action" is
>> adjusted herein as well for the same reason.
>>
>> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
>> Cc: Patrick Havelange <patrick.havelange@essensium.com>
>> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
>> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Alexandre Torgue <alexandre.torgue@st.com>
>> Cc: David Lechner <david@lechnology.com>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> 
> I agree this makes sense in the counter core code, but in the drivers
> it may not be quite so obvious we are talking about a counter function
> given some of the bits of hardware do a number of other things.
> 
> I guess up to the various driver maintainers on whether they
> think the new meaning is clear enough!
> 
> Jonathan
> 

TBH, I think "counter count function" makes more sense to me.

