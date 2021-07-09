Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9443C288F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 19:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGIRnm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 13:43:42 -0400
Received: from vern.gendns.com ([98.142.107.122]:39698 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhGIRnm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 13:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MDLeLO35yOu9e+ubHJxjLeSOA9/E59U+abO9awfMjes=; b=uEKvpYtIJXAef+wcJU2rz3jJ1R
        +SpErNwb42GrUY8jmhoBonO+rLsr7WddcXUYxtWaQ362z0dd4aNql8LmZCM3Hg2TQ17a9hduZ9VfP
        NNWyY9sJaec7olTzWUO6LbXxHDxYztGLoxQypbiFTlvrKrwNvZ7D8e4p2kPiXT3A+hymGMTJTW1SZ
        ztE/Kk1Qq0ciBFqB3aqVQamyiPJI0C+/zAOCjxO4wAgoX8mtwzQwluvo6ir0PGp6HeGCZtVFuiqbS
        4EapOkdO+PccQu5XAJV3UjvULolMMDKfRh7L7Kui8g/bn8V+U8CIFWSMMgRAfUzvJp1dxUOZyqE7R
        6dDGxWow==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51894 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m1uUU-00BGSf-Ep; Fri, 09 Jul 2021 13:40:54 -0400
Subject: Re: [PATCH v12 02/17] counter: Return error code on invalid modes
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <6d4bfe6d7acfbeaf09a6c7d6324b0cbf8e23f35a.1625471640.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <f432f63a-69c3-5016-ea36-e5df309e8c5b@lechnology.com>
Date:   Fri, 9 Jul 2021 12:40:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6d4bfe6d7acfbeaf09a6c7d6324b0cbf8e23f35a.1625471640.git.vilhelm.gray@gmail.com>
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

On 7/5/21 3:18 AM, William Breathitt Gray wrote:
> Only a select set of modes (function, action, etc.) are valid for a
> given device configuration. This patch ensures that invalid modes result
> in a return -EINVAL. Such a situation should never occur in reality, but
> it's good to define a default switch cases for the sake of making the
> intent of the code clear.
> 
> Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: David Lechner <david@lechnology.com>
> Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---


Acked-by: David Lechner <david@lechnology.com>
