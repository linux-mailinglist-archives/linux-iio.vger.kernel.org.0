Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3592E7BA1
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 18:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL3Rhb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 12:37:31 -0500
Received: from vern.gendns.com ([98.142.107.122]:59962 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgL3Rhb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 12:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q/atSoRqWe6ArFqQDRSwZ347fqwQAV01GCsR8rdFUSs=; b=ijWFIfKJaFLZHbWGNeqgftbam7
        Ohn+42g7uPEJm5+wNE+Stn0MYNIBECTX7lDS2M1fxZie/DWxND2qEFcryKyN2zqMc5GAQCJGbxp6c
        xFPl5UaQBmfq1fEqJFiGp9zynb1dyUqgO+JGkl6Q4xWi1xwN0JMP9bvaycnsO4rgNewdW0MrftId8
        zo0/WRVUwa7NEu9pQ71yOjjOIRW5sYjWiLr4ElPUACkmfG4We2Fd1cuLffzgZSCZrKLkuZcF9H95v
        5Os/4REvBMexmvAz9CnWBOdtzZ9gBKYlZCp3J/sKNoLnZidXeP6B0hj20yW2YkNqM0t/ptsnD2+24
        f5QpSVLw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:58304 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kufOw-0007hO-9h; Wed, 30 Dec 2020 12:36:46 -0500
Subject: Re: [PATCH v7 5/5] counter: 104-quad-8: Add IRQ support for the ACCES
 104-QUAD-8
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <bb2db54669ef27515da4d5f235c52e0b484b5820.1608935587.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <7a78ad95-9eba-277d-25da-ddf68357b969@lechnology.com>
Date:   Wed, 30 Dec 2020 11:36:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bb2db54669ef27515da4d5f235c52e0b484b5820.1608935587.git.vilhelm.gray@gmail.com>
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

> diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> index eac32180c40d..0ecba24d43aa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> +++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
> @@ -1,3 +1,28 @@
> +What:		/sys/bus/counter/devices/counterX/countY/irq_trigger

Do we really need this sysfs attribute? Shouldn't interrupts be configured
_only_ by the chrdev interface?


