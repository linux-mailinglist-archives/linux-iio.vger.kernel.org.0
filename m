Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1293256B576
	for <lists+linux-iio@lfdr.de>; Fri,  8 Jul 2022 11:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiGHJ2m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jul 2022 05:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiGHJ2m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jul 2022 05:28:42 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D4D201BA
        for <linux-iio@vger.kernel.org>; Fri,  8 Jul 2022 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=ITJNc9cwIIwc9Ee0KnhiJSNyGW2vX6KVXUs4JChcYMU=; b=gdeQPo6KFA6ysZ8ej/4dUu803o
        pAT9VfbAZqu5/MpCSjy8eqdo+u8zzap9GdBXFwHhEuLfgYYlzR1g/PwUvZx6NhbfAVD+88eD/YZyP
        6uVbtMS7ujNurnsdaNhR2To76Z2qByXpLHoCea+vAYz00JQsaRtwsrOiPqq/ObHkY6r9+fD7kZLgl
        77eGr/IXGepKe3dEU7z1goHbl0zQvYXe/MBBVIDsLwfMaTJRvx3MmdjlqoNNC9pNgeoxMz3e4p1q6
        8WRHkVpclS9gc1jCiJ6aAE3xlr4Zi/j1dviqiHx4DPt1+hNH1DJvaT6NeQY0jdcL9ux7VpqPxo4Di
        ZP1qvlDA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1o9kHs-0006Tr-4A; Fri, 08 Jul 2022 11:28:36 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1o9kHr-000G3H-TL; Fri, 08 Jul 2022 11:28:35 +0200
Message-ID: <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
Date:   Fri, 8 Jul 2022 11:28:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: ti-ads7950: selecting the adc input range
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Thorsten Scherer <t.scherer@eckelmann.de>
References: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26596/Thu Jul  7 09:53:54 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/8/22 10:02, Uwe Kleine-König wrote:
> Hello,
>
> the ADS7950 has a register bit (called TI_ADS7950_CR_RANGE_5V in the
> driver) that selects the input range. Depending on that bit the input
> range is either [0 .. V_{REF}] or [0 .. 2 * V_{REF}].
>
> The driver currently defaults to setting that bit, so the range is the
> big one.
>
> On a machine here however I know the input is in the smaller range and
> I'd like to benefit from the higher resolution of the small range. I
> wonder how to make this tunable. Should that be done using a firmware
> property? ("single-input-range" vs. "double-input-range"? Or input-range
> = <1> vs. input-range = <2> which better matches the data sheet that
> calls the two modes "Range 1 (0 to V_{REF})" and "Range 2 (0 to
> 2xV_{REF})") Or should this be made tunable via sysfs? (E.g. by writing
> to the scale property? Or a separate property?)

Hi,

Its a bit of a tricky one. You can find arguments for and against 
either. Like "devicetree is for hardware description and not application 
specific configuration data", or "I know which setting I want to use, 
having the kernel apply it makes it a lot easier".

What we've done in the past in the IIO framework is to make the scale 
property writable for such devices. Together with a scale_available 
property to list valid options. This is the most flexible option as it 
allows to change the setting at runtime for applications where it is 
required.

Maybe the right solution is a mix of both, have the property writable by 
default, but allow firmware to restrict the available options based on 
what the system designer though makes sense. E.g. on some boards having 
the ability to switch at runtime makes sense, on others it does not.

- Lars

