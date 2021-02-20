Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39DB320649
	for <lists+linux-iio@lfdr.de>; Sat, 20 Feb 2021 17:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBTQtd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 11:49:33 -0500
Received: from vern.gendns.com ([98.142.107.122]:33400 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBTQtb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 11:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vNEM/tON1M86XHMaCI4bAnuASZzABcq6rX1zJ37Bdqo=; b=IVQz5B8XsyLuXnlRA4Cbg7u2Fx
        6UQnBt0S6+qDgbUG0yL6Yaj6J3LShaR5qB96dF7gO4MVOTm8CzTQ+KP0yjgdFkVkYzW9+OW0MzeLE
        pb7P8heKA+mtCk5DPs/AqurYPWmYMRIck7c8XYDrXrrDduV9zRiCZkf9D4E7EVWjh0xV3Oo83k5E+
        5/5zD8rV7OVG6ReTeNMO7BJnPWvIvEt16djjQ5LHwGJoiP/f2PhXTh+PkA7mYwbOZExpjyZ9RqV+H
        j0BMGl4lXXvNrUz0AsNx8wdASRpwJ+JQLuhIL4WCjdRR+BXjKbukrzk03/lB8UV6LnmHudX01cDYW
        qD7eRZzQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57734 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDVR0-0003Fq-US; Sat, 20 Feb 2021 11:48:47 -0500
Subject: Re: [PATCH v8 10/22] counter: Standardize to ERANGE for limit
 exceeded errors
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
 <7fa80c10fcd10d1d47d1bddced2b2cca3ff59ba9.1613131238.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <f382ce84-8a47-6315-9bdb-9d9957f1800b@lechnology.com>
Date:   Sat, 20 Feb 2021 10:48:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7fa80c10fcd10d1d47d1bddced2b2cca3ff59ba9.1613131238.git.vilhelm.gray@gmail.com>
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
> ERANGE is a semantically better error code to return when an argument
> value falls outside the supported limit range of a device.
> 
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

(I agree with William's assessment that this use of ERANGE
is consistent with other uses in the kernel.)


