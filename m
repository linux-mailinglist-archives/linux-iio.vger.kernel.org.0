Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7011A3207BD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 00:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBTX4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Feb 2021 18:56:47 -0500
Received: from vern.gendns.com ([98.142.107.122]:47060 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhBTX4r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Feb 2021 18:56:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NJQ3qK7kZJOYMEo7d0WhHsoE9tRggHBugk1o8Rn0Puk=; b=UHZYZ8Fb5qcAmWUz4aohA2ymLS
        bpK78s9h9IJza4cpjY15MBJraMUTuoijR2VraCwQ2RB+tqZAzdMS2vZCv5QI+AvRJYtRzeIiyjHAn
        2xe3E0HnsuB7yO03MxNIJggG8+02vSM+NKI493+47b3QRlHIMUtRq5wT3pl3xhs2eNUfzeZ1pJC7u
        YWtU6qsDra19HpAyrdNqo4eVek2wKSgwGHIRW+nttxGQGyJhh17ncLYgXx7/bkCwH52PA+jZqQHVs
        G1N1tpyLLwB35XeWNb9CbtmyE2H95IM/eui3EK7duSouZFnkkKmDM+4ZpULroPdcVIZT+lbKCYgwf
        v162vb8Q==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:37044 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lDc6S-0005os-Os; Sat, 20 Feb 2021 18:56:00 -0500
Subject: Re: [PATCH v8 16/22] counter: Move counter enums to uapi header
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
 <eeb79725eca9c299dee166d38347b6722804d8b5.1613131238.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <fb1a996b-02e7-2328-4e56-6d724c41e433@lechnology.com>
Date:   Sat, 20 Feb 2021 17:55:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eeb79725eca9c299dee166d38347b6722804d8b5.1613131238.git.vilhelm.gray@gmail.com>
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
> This is in preparation for a subsequent patch implementing a character
> device interface for the Counter subsystem.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>


