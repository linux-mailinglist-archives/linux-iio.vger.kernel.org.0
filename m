Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2F31EB83
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhBRPZu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:25:50 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:29943 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhBRMjq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Feb 2021 07:39:46 -0500
X-Originating-IP: 10.200.201.23
Received: from webmail.gandi.net (webmail23.sd4.0x35.net [10.200.201.23])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPA id D2F33240002;
        Thu, 18 Feb 2021 12:38:15 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 18 Feb 2021 15:38:15 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        =?UTF-8?Q?Ekin_B=C3=B6ke?= <ekin_boke@arcelik.com>,
        linux-iio@vger.kernel.org
Subject: Re: Control Register device tree binding request for Opt3001
In-Reply-To: <20210218121502.00002014@Huawei.com>
References: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
 <CA+U=DspfyuxyhPfPrGDaU5nDQVaO5p3ha-5hwpzVX69p1P60WA@mail.gmail.com>
 <20210218121502.00002014@Huawei.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4e0b8e47a2644d304b2d1e6b2e087136@kernel.wtf>
X-Sender: cengiz@kernel.wtf
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan, Alexandru and Ekin

On 2021-02-18 15:15, Jonathan Cameron wrote:
> 
> As described, what you want to control here is policy, not a 
> characteristic
> of the hardware.   Normally we don't use DT to make such decisions, as 
> it should
> be controlled at runtime.

I'm by no means an expert on sensors and I don't fully understand the 
distinction
of policy vs characteristic in this context.

Can you clarify a bit?

For example, many TFT drivers allow maximum-minimum brightness values in 
devicetree
and even set a default brightness value. Totally within the specs of 
vendor of course.

Since this is just a hardware register that can be changed, and possibly 
never to be
modified (depending on the use case of course) during runtime, I would 
like to be able
to set it once during initialization and forget about it.

Currently I have a oneshot systemd unit that echo's my desired 
integration value and
I think that's a bit late for my application. (even with all the 
priority and orderings set).

> 
> So basically what Alex said :)
> 
> Jonathan
> 

Thank you

-- 
Cengiz Can
@cengiz_io
