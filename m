Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294DC2E7D2B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Dec 2020 00:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgL3XZV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 18:25:21 -0500
Received: from vern.gendns.com ([98.142.107.122]:35810 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgL3XZV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 18:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gR78gPmwmA3kImx4p1tfZOTvAzaVPgOtdhEAk6uVEuo=; b=Ql8i79ZJySZkkEqx92KLopxutF
        nMiYp+T9LFAnRRiGu3UH5RLtJSLxptityXbUPrJLaqD7v4p6vmWO0gZovCI57dgUp5qcyPWAIm05z
        wWtBLCbngYwA8Mih1D4Q6N30Q+rv8Ohuff6VlBhSy87Co7n98XE3eRlsZZ/YGs9SaEC8swQ76CHQf
        6t/HUlwy7vsQ0m/bsxi2vbS0QGDdTht0WJGXhL8XZa3sOBrwuqPS4Nec4sYGvtkfBDriO+Au3aHOm
        4gveVMjkC9C77U3ktO0y+zpNcKKVLB4Cnxjqs5DgNOBEXGL6e24jK2vZyh8YhXPoAXDPRDUr9mJTG
        gjsoXeFg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:42538 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kukpX-0004fK-Hz; Wed, 30 Dec 2020 18:24:35 -0500
Subject: Re: [PATCH v7 1/5] counter: Internalize sysfs interface code
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1608935587.git.vilhelm.gray@gmail.com>
 <fc40ab7f4a38e80d86715daa5eaf744dd645a75b.1608935587.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <2f950b79-fb83-9800-2690-ec81c6be6348@lechnology.com>
Date:   Wed, 30 Dec 2020 17:24:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fc40ab7f4a38e80d86715daa5eaf744dd645a75b.1608935587.git.vilhelm.gray@gmail.com>
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

> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index a60aee1a1a29..6c058b93dc98 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c


> -static ssize_t ti_eqep_position_floor_write(struct counter_device *counter,
> -					    struct counter_count *count,
> -					    void *ext_priv, const char *buf,
> -					    size_t len)
> +static int ti_eqep_position_floor_write(struct counter_device *counter,
> +					struct counter_count *count, u64 floor)
>   {
>   	struct ti_eqep_cnt *priv = counter->priv;
> -	int err;
> -	u32 res;
>   
> -	err = kstrtouint(buf, 0, &res);
> -	if (err < 0)
> -		return err;
> +	if (floor != (u32)floor)
> +		return -ERANGE;
>   
> -	regmap_write(priv->regmap32, QPOSINIT, res);
> +	regmap_write(priv->regmap32, QPOSINIT, floor);
>   
> -	return len;
> +	return 0;
>   }

This will conflict with 2ba7b50893de "counter:ti-eqep: remove floor"
(in Jonathan's fixes-togreg branch) which removes these functions.


