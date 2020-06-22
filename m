Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CE82038CB
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFVOIx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 10:08:53 -0400
Received: from vern.gendns.com ([98.142.107.122]:40634 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgFVOIw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Jun 2020 10:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9vEISF7TWp4PVYxt3CdWfsfRlefupfkWdhA6vLj/Xbo=; b=yMzjpl2rKmL+O6LAgB9GEvUyb0
        9X4fIz/rdeMe4YQB9qLCOellIZRE2SZ+yulpXWO8iAPS4u9TKGgnTYSPvYGfHhgVKxk6zi/g2DKgj
        vTdH582CvU7oQAwe05NDp1Snf7XWJh0D3r6kHWJZQzkiEFACKmRR2qM0iID9VXkqxw7O97/qSI8Cr
        +Vjwc2UUh8/6kypFLgjmgAdXE6Zet9YOaiq3UvSO+Tcl2wzGS7/Z5xe8bENWRkzVGZ/ME3iVqflF2
        7IEb75+K+lwFHjhPkacBQ1hbu4x1jTLlNrqTI359p3wCiAmfdRvEPP5b7879KixLKaf7VspBLr+x5
        p+iUp5jg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51552 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1jnN7x-0004eb-11; Mon, 22 Jun 2020 10:08:49 -0400
Subject: Re: [PATCH v3 3/4] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1592341702.git.vilhelm.gray@gmail.com>
 <afe40ef2e24ecaca44fc229f7983cf4cde3374a8.1592341702.git.vilhelm.gray@gmail.com>
 <8fae0659-56df-c0b5-7c0d-220feefed2b4@lechnology.com>
 <20200621195347.GA59797@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <47ad15e7-05ce-d463-b6af-406365b3c3b4@lechnology.com>
Date:   Mon, 22 Jun 2020 09:08:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200621195347.GA59797@shinobu>
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
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/21/20 2:53 PM, William Breathitt Gray wrote:
> Synapses simply indicate a change in a Count value

Ah, ok. I understand now that synapse is the wrong term for things like
the change in direction event or error events.

> For example, in the dual-axes positioning table scenario, a user
> application would likely want to know the exact X and Y position at the
> time of a given event -- that means an event should provide two Count
> values (and possibly associated device flags) when it occurs. I'm not
> sure yet how the struct counter_event should be defined in order to
> support this; we will need to indicate the format of data as well as
> provide the data itself. Perhaps, we can handle this by providing an
> unique id field so that only a single datum (e.g. a single count value)
> is provided via the value field, but subsequent struct counter_event
> items share the same id so that the user knows that a particular datum
> is part of a larger group of data for a specific event.

The timestamp could act as the "id" to correlate multiple values of a
single event.
