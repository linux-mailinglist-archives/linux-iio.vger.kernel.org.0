Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23B320625
	for <lists+linux-iio@lfdr.de>; Sat, 20 Feb 2021 17:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBTQ1W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 11:27:22 -0500
Received: from vern.gendns.com ([98.142.107.122]:59280 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhBTQ1V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 11:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u1H/Rj3si247tGQxAWnRSEo+DLs314H7VoFt9pxULPc=; b=UG67jwaBdIy8LOV0hftKFBONpD
        qyql+Iup4SBCgssOyHh27rtigd0USOnBX8QEx4AfpXgnukmqMsQ/kFGVx4sIK09Yv4DKk3bEgIEWR
        zn20PAA223VnoLx4BI+xNmQ4cMgGK2gy/uPz5p3oBG5UUQ3Ha5jboA1oeRBftyyBk5IXlZi1FoDny
        r1Z5jeypB8jf4L6Qv+sTFz0HoXpaSUvtLq8a/lumlOvjQTd/iFHHgxGlSmuNzPWVBnQduA4O/+C2s
        AzSd4AyV8uworRiWAlm0fd9iPTWbKnajFzlC7+6hLf05xN6ZzfEPMhaTSQlX8iTWw4jk1Nndz1aqK
        gyzQn8lw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57348 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDV5Y-0006HP-Jc; Sat, 20 Feb 2021 11:26:36 -0500
Subject: Re: [PATCH v8 02/22] docs: counter: Fix spelling
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
 <0f90d3ae0305224abd6350059bcb00ac44bd858b.1613131238.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <4f06b5db-9f4f-4a00-eba6-40b3e53245c6@lechnology.com>
Date:   Sat, 20 Feb 2021 10:26:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0f90d3ae0305224abd6350059bcb00ac44bd858b.1613131238.git.vilhelm.gray@gmail.com>
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
> "Miscellaneous" is the correct spelling.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

