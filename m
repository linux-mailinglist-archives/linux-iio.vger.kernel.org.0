Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519F518DAA
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 22:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiECUEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECUEJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 16:04:09 -0400
X-Greylist: delayed 1090 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 13:00:35 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAFC13CF9
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I6M6V5n+Vdd8idAnHqAl/6PWIhDNoa40OfqBseGDhiw=; b=QhsXzU8FJGn5uIzwzlR2t2yDD7
        U2brwf6EGB2ivMIgcCmMRsON5p7Ptji9oD3BOtkSdK6vwb18Iu32aQELkJt2YYpLWX/yW4mKbHGFR
        EPJ6A5knHK/Q5UYRMKfpikSOjvU5tWvyJsZU+J8TfSQw01IuDWposP7TIO+kfyyWI6koDH9nJwW17
        9HQBg0lMIjxVR3yR9FiK50CZo540DorkaDQ3V0boZwkpU6f8JNsA5c8+7zL8XcCl3BjuRfTkA4ofm
        P8VmFwSU9HubjNzZP//Anpg7BMYOGcC2XGYR9YlduI0/if7jX+fXarBRRZaSKpNbw0FF6H3/3rGM1
        Oa7XbXDA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44990 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <david@lechnology.com>)
        id 1nlyPV-0000Gg-7e;
        Tue, 03 May 2022 15:42:18 -0400
Message-ID: <a84d9625-75b2-083b-32f2-59457d487dde@lechnology.com>
Date:   Tue, 3 May 2022 14:42:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 36/92] iio: adc: ti-ads7950: Fix alignment for DMA safety
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-37-jic23@kernel.org>
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20220503085935.1533814-37-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/3/22 3:58 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is an insufficient guarantee for non-coherent DMA
> on platforms with 128 byte cachelines above L1.  Switch to the updated
> IIO_ALIGN definition.
> 
> Update the comment to include 'may'.
> 
> Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: David Lechner <david@lechnology.com>
> ---

Acked-by: David Lechner <david@lechnology.com>

