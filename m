Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0869E320623
	for <lists+linux-iio@lfdr.de>; Sat, 20 Feb 2021 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBTQ0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 11:26:33 -0500
Received: from vern.gendns.com ([98.142.107.122]:59204 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBTQ03 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 11:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d+oiySUdTw6kjAIxeQUPAaWlTWZ7c9j+H2jNv6v/cDc=; b=eUB3/yQ7F/4qZ5vniJWQ6ToNH7
        5/hd333+ZRnlYykM476FGC75X6/xI9UtIj7kt+Zs74lF/OIkVu7WfNg4Cl7XXG8s7ctPSq60ntD4K
        l+cWa2DyyXsOUG1o25Yq6U4sOpv6CRVm9lSVNwkk8CecyGzy5cKuP/Y2qXufMSCQsxZXabtW/N10c
        gA0n2NCHNUL+HRICcSVSqj9Qy8Ot6FZfLYqQvlYnZtlo43ohHCPmKguNfjpdc+sZtyf9Khge7VUFO
        VtrXBA/hpChfXPq4PXPy80vaifg9LrvxmR25s9tt/zbQWg56WjETLjHe3HvnTlYC6os69bjNTMsZK
        /7ovMFfQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57342 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDV4i-00063f-Gl; Sat, 20 Feb 2021 11:25:44 -0500
Subject: Re: [PATCH v8 01/22] docs: counter: Consolidate Counter sysfs
 attributes documentation
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
 <362a71a1eba98108d009db8c929170a6ed8cf110.1613131238.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <2d35b608-b13b-3dbf-e895-a65da1f4bf68@lechnology.com>
Date:   Sat, 20 Feb 2021 10:25:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <362a71a1eba98108d009db8c929170a6ed8cf110.1613131238.git.vilhelm.gray@gmail.com>
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
> Duplicate ABIs are not valid, so let's consolidate these sysfs
> attributes into the main sysfs-bus-counter documentation file.
> 
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

