Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63E73A2C77
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFJNIB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 10 Jun 2021 09:08:01 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37495 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJNIA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:08:00 -0400
Received: (Authenticated sender: paul@opendingux.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1F445240008;
        Thu, 10 Jun 2021 13:06:00 +0000 (UTC)
Date:   Thu, 10 Jun 2021 14:05:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] iio: core: Support removing extended name in
 attribute filename
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <TPLHUQ.MUVY4TY05YFY2@crapouillou.net>
In-Reply-To: <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
References: <20210610124556.34507-1-paul@crapouillou.net>
        <20210610124556.34507-2-paul@crapouillou.net>
        <CAHp75VfR5jjMjDhFRvtT01EbuSTwDBi3HERDKi306mRK22+Fnw@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Le jeu., juin 10 2021 at 15:58:51 +0300, Andy Shevchenko 
<andy.shevchenko@gmail.com> a écrit :
> On Thu, Jun 10, 2021 at 3:47 PM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
>>  By default, when a channel has an extended name, it will appear in 
>> the
>>  filename of channel attributes. E.g. if the extended name is "aux", 
>> the
>>  filename of a "sample_rate" attribute will be something like:
>>  in_voltage0_aux_sample_rate
>> 
>>  Add a mechanism to disable this feature. This will be used to add a
>>  "extended_name" channel attribute.
> 
> I'm afraid, NAK. Otherwise, please put an explanation that clearly
> shows that it will be no ABI breakage.
> I.o.w. users for the existing drivers and devices will always get
> those attributes at the same platform configuration(s).

Well, the commit message says that I'm adding a mechanism to disable 
the feature. If it was actually doing anything else (like actually 
disabling it for any attribute) then I'd mention it in the commit 
message.

I don't see how that possibly can be a ABI breakage.

-Paul


