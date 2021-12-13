Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25B4730E4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Dec 2021 16:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhLMPuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Dec 2021 10:50:06 -0500
Received: from vern.gendns.com ([98.142.107.122]:48498 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLMPuF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Dec 2021 10:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NpOigk+Z0EZFLGSHFKWMUCKNXNL42NPLNUPOO3Gtbrg=; b=j+YbAF5KD0chYhRYJZGWnPW17P
        zHesqTTYzo4LtiQvXaI7aSkb2CM9E6xAKTC8GFAZ9txcVuvnUvNGkhQdxqnA5pdD2NhNDE6K8RfZY
        FTJXZCUVVpJkSidzhxkkV3J6y8XxRgyk+v0jms0evifYg2QuyHfTsFLNIWnyoMD58cnL00S1UZzUz
        mZYjU4nNEr9g+82d/s0dznE83JVmiUi9xYcN+CiWJUxupJ7EOAvNPi+WTUpgIqAHCPY/+dXBNcwqm
        Ib8FAnomHUEekUc8EaYje42p3pRx0kJFeUlEbo0hRpQd8dCFYkk1a8D3rqGDq/RTOGcR7ggbpwIbw
        niPtvOIg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49672 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mwnaT-00059B-2I; Mon, 13 Dec 2021 10:50:03 -0500
Subject: Re: [PATCH] counter: ti-eqep: Use container_of instead of struct
 counter_device::priv
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
References: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <759aa00b-89b4-e1b9-bfbc-bda2e96d0bd7@lechnology.com>
Date:   Mon, 13 Dec 2021 09:50:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213114312.1406562-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 12/13/21 5:43 AM, Uwe Kleine-König wrote:
> Using counter->priv is a memory read and so more expensive than
> container_of which is only an addition. (In this case even a noop
> because the offset is 0.)
> 
> So container_of is expected to be a tad faster, it's type-safe, and
> produces smaller code (ARCH=arm allmodconfig):
> 
> 	$ source/scripts/bloat-o-meter drivers/counter/ti-eqep.o-pre drivers/counter/ti-eqep.o
> 	add/remove: 0/0 grow/shrink: 0/9 up/down: 0/-108 (-108)
> 	Function                                     old     new   delta
> 	ti_eqep_position_enable_write                132     120     -12
> 	ti_eqep_position_enable_read                 260     248     -12
> 	ti_eqep_position_ceiling_write               132     120     -12
> 	ti_eqep_position_ceiling_read                236     224     -12
> 	ti_eqep_function_write                       220     208     -12
> 	ti_eqep_function_read                        372     360     -12
> 	ti_eqep_count_write                          312     300     -12
> 	ti_eqep_count_read                           236     224     -12
> 	ti_eqep_action_read                          664     652     -12
> 	Total: Before=4598, After=4490, chg -2.35%
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Acked-by: David Lechner <david@lechnology.com>

