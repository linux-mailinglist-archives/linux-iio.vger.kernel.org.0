Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A43A2C7D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFJNJn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 10 Jun 2021 09:09:43 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55329 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFJNJm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:09:42 -0400
Received: (Authenticated sender: paul@opendingux.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 81C7060009;
        Thu, 10 Jun 2021 13:07:42 +0000 (UTC)
Date:   Thu, 10 Jun 2021 14:07:35 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] iio: core: Support removing extended name in
 attribute filename
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <NSLHUQ.V23ZTO77JGST3@crapouillou.net>
In-Reply-To: <20210610140412.000054ac@Huawei.com>
References: <20210610124556.34507-1-paul@crapouillou.net>
        <20210610124556.34507-2-paul@crapouillou.net>
        <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
        <20210610140412.000054ac@Huawei.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le jeu., juin 10 2021 at 14:04:12 +0100, Jonathan Cameron 
<Jonathan.Cameron@Huawei.com> a écrit :
> On Thu, 10 Jun 2021 15:58:51 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
>>  On Thu, Jun 10, 2021 at 3:47 PM Paul Cercueil 
>> <paul@crapouillou.net> wrote:
>>  >
>>  > By default, when a channel has an extended name, it will appear 
>> in the
>>  > filename of channel attributes. E.g. if the extended name is 
>> "aux", the
>>  > filename of a "sample_rate" attribute will be something like:
>>  > in_voltage0_aux_sample_rate
>>  >
>>  > Add a mechanism to disable this feature. This will be used to add 
>> a
>>  > "extended_name" channel attribute.
>> 
>>  I'm afraid, NAK. Otherwise, please put an explanation that clearly
>>  shows that it will be no ABI breakage.
>>  I.o.w. users for the existing drivers and devices will always get
>>  those attributes at the same platform configuration(s).
>> 
> 
> What Andy said.  This was a bad design decision a long time back, but
> we are stuck with it.
> 
> We have the _label attribute today that is the preferred route 
> forwards
> for new drivers but we can't touch the old ones however annoying it 
> might
> be.

You're missing the point here. This patchset only adds a new channel 
attribute and doesn't change anything else.

The "label" is good to have, but that doesn't help me in any way. The 
problem here is parseability.

Cheers,
-Paul


