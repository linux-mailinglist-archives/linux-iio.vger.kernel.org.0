Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC132062B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Feb 2021 17:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhBTQaz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 11:30:55 -0500
Received: from vern.gendns.com ([98.142.107.122]:59590 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBTQat (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 11:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ihzSQU1VPZbn2yYTLCpMZ8Md74uPTutyPKGtlry1dT0=; b=ky9BSwkWUReOIoFkYNxbbgO7DJ
        3hvp2upv75H/ZJRaXJfC4p9uwtgTp8z2FeAr7FizSQDN7gMk0MyFpwVqUdgMjScoJV19A+XApqTVt
        9Qiu0LPSJvZt5RjT1OHvw5kW295q+R/rltjdw8ag06P8RCdvf9NTg93nQfxBhaQYAXWVCWnDlA2+H
        cOcAq8O818XQ11i/NdqgpgDj53Czyd3Z+q7t1YFsOeRM1V+/+LqjzaEG0bWSecffXYXHjCnEpydkp
        mr/X0ToEJ5XfMxvNzcQHeC6BITZT7mB8zgJmhjCx/cFdSeCm0zTSAfddtrSeqjmdEE8y+zphEM190
        YaFUrMuA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57396 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDV8u-00072X-Go; Sat, 20 Feb 2021 11:30:04 -0500
Subject: Re: [PATCH v8 03/22] counter: 104-quad-8: Return error when invalid
 mode during ceiling_write
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
 <2be0c071e7730ea16b8faa1efcd3d0d908e7f9db.1613131238.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <8e7daaad-e824-a823-1465-327cbc90ab23@lechnology.com>
Date:   Sat, 20 Feb 2021 10:30:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2be0c071e7730ea16b8faa1efcd3d0d908e7f9db.1613131238.git.vilhelm.gray@gmail.com>
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
> The 104-QUAD-8 only has two count modes where a ceiling value makes
> sense: Range Limit and Modulo-N. Outside of these two modes, setting a
> ceiling value is an invalid operation -- so let's report it as such by
> returning -EINVAL.
> 
> Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>   drivers/counter/104-quad-8.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 9691f8612be8..f0608b21196a 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -714,13 +714,14 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
>   	switch (priv->count_mode[count->id]) {
>   	case 1:
>   	case 3:
> +		mutex_unlock(&priv->lock);
>   		quad8_preset_register_set(priv, count->id, ceiling);
> -		break;
> +		return len;
>   	}
>   
>   	mutex_unlock(&priv->lock);
>   
> -	return len;
> +	return -EINVAL;
>   }
>   
>   static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
> 

What happens if the register is written to when in the wrong mode?

If it doesn't hurt anything, I would suggest always writing the register
instead so that users don't have to know worry about the fact that the mode
has to be set first.
