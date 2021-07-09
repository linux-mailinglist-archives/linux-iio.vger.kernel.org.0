Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB53C28C7
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGIR7Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 13:59:25 -0400
Received: from vern.gendns.com ([98.142.107.122]:41026 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGIR7Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 13:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nr+ybean0GYJB/FyhUT9xAqfrMJWszlIeTXTMgqs5Dc=; b=a75vxDYeO3We3ly4cfZS1ufdEm
        BlS3Ccue4Ng+uimuFb4XfgEXdH1bnw22GU1M313Mf3Q2MmlmxSw5wV4qX9VExHHbzwJ5arzVBpXvp
        fY/2v5sJdZ0BDGdC+dlR3yL1wsIpYr9OeUTQNTdZCBrP9/ry5v5dwdxzJ+jry/z6vYbEP3nbJwCT2
        fkHo3FRr+Y2fOc4tUSYzDqinER8++H4eKMzjBJi/eQgEguDCFhuONx13FyrRA/I8is4Y7Asov94Y7
        O7DdXXdqdd53E4JumqAJ2J2fxeA9mO4xu/WmogooVxa7kMCD5g1d1VNyQeMRlu5+M6adNTnOEeNVo
        wshnMKKw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52256 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m1ujh-00BKQG-CM; Fri, 09 Jul 2021 13:56:38 -0400
Subject: Re: [PATCH v12 08/17] docs: counter: Update to reflect sysfs
 internalization
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <3e0a3f7a32bba0f56f5830ff1548ef417e63880e.1625471640.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <dee9b119-1e45-2c82-2a1d-0979244fb01f@lechnology.com>
Date:   Fri, 9 Jul 2021 12:56:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3e0a3f7a32bba0f56f5830ff1548ef417e63880e.1625471640.git.vilhelm.gray@gmail.com>
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
> The Counter subsystem architecture and driver implementations have
> changed in order to handle Counter sysfs interactions in a more
> consistent way. This patch updates the Generic Counter interface
> documentation to reflect the changes.
> 
> Signed-off-by: William Breathitt Gray<vilhelm.gray@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

