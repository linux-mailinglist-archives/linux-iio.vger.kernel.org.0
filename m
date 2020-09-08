Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4953260DB9
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgIHIiw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 04:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgIHIiv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Sep 2020 04:38:51 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A582215A4;
        Tue,  8 Sep 2020 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599554331;
        bh=9MbsarOq+P/4I79z3A+fJ+J72iGu7faVW8HMRIAC4yg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ABlmjheudFWqMnnqN7fkj7Y8fpGWpqp+Q+5bztrxFGYwdt/wYgY/MV7PHBbVNqkon
         YKpo8TUVTX6CKqR+9LMrE0vMFmrIIsUlMMIhexMaoFG+3MN9Tu7yuOd+G3uin4Mt/h
         ku2dg3SQDqNkWUHQcVwN7jdxOTn9U8cssWk6hieU=
Subject: Re: [RFT 09/25] ARM: dts: s5pv210: fix number of I2S DAI cells
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-10-krzk@kernel.org>
 <BN6PR04MB0660D9B0D0B5FB4F40CF2769CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200908065321.GB24227@pi3>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <48aa966f-d3b8-7e4a-36aa-aed4630d331a@kernel.org>
Date:   Tue, 8 Sep 2020 10:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908065321.GB24227@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 9/8/20 08:53, Krzysztof Kozlowski wrote:
> On Mon, Sep 07, 2020 at 04:55:26PM -0700, Jonathan Bakker wrote:
>> Sadly, this is causing issues for me.  The machine driver is no longer probing correctly
>> on the Galaxy S.
>>
>> The failing call in sound/soc/samsung/aries_wm8994.c is
>>
>> 	/* Set CPU of_node for BT DAI */
>> 	aries_dai[2].cpus->of_node = of_parse_phandle(cpu,
>> 			"sound-dai", 1);
>>
>> where cpus->of_node is not set properly.  Which is definitely weird because it doesn't
>> look like this should affect that.
>>
>> Let me know if there's any specific test that you want me to do.
> Thanks for the tests. I wonder now if this was working before because
> really my change should not break it... I'll think more about it.

I think of_parse_phandle_with_args() needs to be used instead of just
of_parse_phandle() for that to work, as AFAICS the latter assumes the
cells count == 0. We would need first to update the driver and then dts.
