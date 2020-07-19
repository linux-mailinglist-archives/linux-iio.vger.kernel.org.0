Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DFE225470
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgGSWQ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jul 2020 18:16:27 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:53269 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSWQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2020 18:16:27 -0400
Received: from webmail.gandi.net (webmail15.sd4.0x35.net [10.200.201.15])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPA id DE1C0FF803;
        Sun, 19 Jul 2020 22:16:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jul 2020 00:16:23 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] iio/adc: ingenic: Cleanups & add touchscreen mode.
In-Reply-To: <12263784.1eIgeU1MTH@phil>
References: <20200709152200.10039-1-contact@artur-rojek.eu>
 <12263784.1eIgeU1MTH@phil>
Message-ID: <60b5e2ea0ae9884a0506688a1c8670a5@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
User-Agent: Roundcube Webmail/1.3.14
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-07-14 20:33, Heiko Stuebner wrote:
> Hi Artur,
> 
> Am Donnerstag, 9. Juli 2020, 17:21:54 CEST schrieb Artur Rojek:
>> Hi all,
>> 
>> v8 of this patchset introduces some structural changes, which I deemed
>> worthy highlighting here:
>> 
>>  - adc-joystick related changes have been dropped from this patchset 
>> and
>>    will be upstreamed separately. Their only connection to this 
>> patchset
>>    was that they used INGENIC_ADC_TOUCH_* defines in the DTS example,
>>    causing trouble to Rob's scripts.
> 
> as I'm mainly eyeing your adc-joystick patch ... did you post that 
> already
> somewhere - separately as you wrote?
> 
> Thanks
> Heiko

Hi Heiko,

sorry for a late reply. As you have surely noticed in your mailbox, I 
have sent the adc-joystick changes in the following series:
https://lore.kernel.org/linux-input/20200719221103.91644-1-contact@artur-rojek.eu/

Regards,
Artur
