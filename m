Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24050320642
	for <lists+linux-iio@lfdr.de>; Sat, 20 Feb 2021 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBTQnw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 11:43:52 -0500
Received: from vern.gendns.com ([98.142.107.122]:60918 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBTQnw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 11:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o3fnr0AasHCE7sOwqG9i6QL4f96T64yKsXZXUPNym00=; b=iCNOfWxwVMacI+svobG9eYt1IX
        LB7VgPct+zMzjh2R8iWeOvTjVargOr/IpoVln1/HAj6XSOYIcalDvL8hq5+ewE1QaLXBwvp/l2Jzg
        GAC3oCPV0XDjBONGV3QBDpdzHk7VzNvejKRFNSeCs1xYPKEe7rWcYsuVMrffR5LIK7O/DDYRM8w4G
        Im3CAhBBPurg4McI20rjFeO4mC7Y8T4++kJ8vt07xZhKihDsdBUkx0hLZiOA8snA3fR3CgHo6Y1cb
        tRQRpF/yCa+wzLms/Hn2mH3+RY2/NzaR3HtxkLCmJerxk3F+Lm0Dmu835190r4Dr3oFmqc9snBawE
        c0G/JZFA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57598 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDVLY-0001ki-9S; Sat, 20 Feb 2021 11:43:08 -0500
Subject: Re: [PATCH v8 09/22] counter: Return error code on invalid modes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <58e7c59bb7c7bb94c8655903308842d9d9e9907a.1613131238.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <d5b53db8-395a-b77e-77fb-49f7fd0da231@lechnology.com>
Date:   Sat, 20 Feb 2021 10:43:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <58e7c59bb7c7bb94c8655903308842d9d9e9907a.1613131238.git.vilhelm.gray@gmail.com>
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

On 2/12/21 6:13 AM, William Breathitt Gray wrote:
> Only a select set of modes (function, action, etc.) are valid for a
> given device configuration. This patch ensures that invalid modes result
> in a return -EINVAL. Such a situation should never occur in reality, but
> it's good to define a default switch cases for the sake of making the
> intent of the code clear.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

(In response to Jonathan's comment, I think this is fine rather than
adding more churn to change all of the breaks to returns - but will
keep that in mind for future changes.)

