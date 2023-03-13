Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF57E6B81BF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Mar 2023 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCMTek (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Mar 2023 15:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCMTej (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2023 15:34:39 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Mar 2023 12:34:38 PDT
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859D07DF9F
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2023 12:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ksT1njU8NavU8rU2BmJJtfMjNbZ+bC0i2FRLlF4K7qw=; b=qZBjEV+mVt7ixK33eabLrORJJm
        HlJqfU7fJt0q/GuEmoqcc7Zc+wcvP3WpX3P+5KXTG/M1NuSEKuELFBccMbGyQS7Be+BZNV9RQzE03
        xF118bIRUTcvoRPcoP7RiDbpSwrd1Y8AB5ASu6uJ1+o0F9mm/oXx/rqI//7AU5oZzFtbI7sqysevf
        Xtab8wqWvmb//ielk8Q3SLqJk1IIapdv7+Sj6IiOBZhR6c+7TfFbsPRFhR0pygw+jiY8QsRDTOrqP
        nDk80Hq7P4eoG6rVTj9Wo1SbKs5+tMDCr5qFagUcV/L929Y3p4zrI6WMG06DtRvyP0kPKxLMjL3MR
        JWhu3LgQ==;
Received: from ip98-183-112-29.ok.ok.cox.net ([98.183.112.29]:38470 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <david@lechnology.com>)
        id 1pbn9q-002eLu-0P;
        Mon, 13 Mar 2023 14:44:34 -0400
Message-ID: <603a73ae-5c67-0837-ed26-9a98ad3fec74@lechnology.com>
Date:   Mon, 13 Mar 2023 13:44:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iio: adc: ti-ads7950: Set `can_sleep` flag for GPIO chip
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Justin Chen <justinpopo6@gmail.com>, linux-iio@vger.kernel.org
References: <20230312210933.2275376-1-lars@metafoo.de>
Content-Language: en-US
From:   David Lechner <david@lechnology.com>
In-Reply-To: <20230312210933.2275376-1-lars@metafoo.de>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/12/23 4:09 PM, Lars-Peter Clausen wrote:
> The ads7950 uses a mutex as well as SPI transfers in its GPIO callbacks.
> This means these callbacks can sleep and the `can_sleep` flag should be
> set.
> 
> Having the flag set will make sure that warnings are generated when calling
> any of the callbacks from a potentially non-sleeping context.
> 
> Fixes: c97dce792dc8 ("iio: adc: ti-ads7950: add GPIO support")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: David Lechner <david@lechnology.com>


