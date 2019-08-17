Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D20912BE
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2019 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfHQTot (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Aug 2019 15:44:49 -0400
Received: from mx1.supremebox.com ([198.23.53.39]:54829 "EHLO
        mx1.supremebox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfHQTos (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Aug 2019 15:44:48 -0400
X-Greylist: delayed 2157 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Aug 2019 15:44:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=y039daUDNPWxHnUUSg/vQcnuL/NxoZWrxyq5xKw1RZc=; b=d6eIDsgvtqOIHIodTaNHfpPVJv
        UpI+nyuv+NQWe5+IZULhLxLr5fmH9GN+8vYfKzGfbodwPAEOy/jqQgiHsWDYIf6sKIkS3pRZJUcbu
        68kO8b2+5zIBqgghxg9ucHqhJ+X9EgAsSjta3FTOuhd8eL5k95mnoekJqamqQi0pwsyc=;
Received: from 184-96-235-43.hlrn.qwest.net ([184.96.235.43] helo=[192.168.0.28])
        by mx1.supremebox.com with esmtpa (Exim 4.89)
        (envelope-from <opensource@jilayne.com>)
        id 1hz44E-00085I-KA; Sat, 17 Aug 2019 19:08:46 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 13/14] iio: trig-loop: SPDX headers GPL-v2
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <20190717211246.GA13989@kroah.com>
Date:   Sat, 17 Aug 2019 13:08:44 -0600
Cc:     Himanshu Jha <himanshujha199640@gmail.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-spdx@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB9A92CE-36F5-4A27-8984-655538DEF40B@jilayne.com>
References: <20190622145516.3231-1-jic23@kernel.org>
 <20190622145516.3231-14-jic23@kernel.org>
 <20190717175837.GA31268@himanshu-Vostro-3559>
 <20190717211246.GA13989@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> On Jul 17, 2019, at 3:12 PM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>=20
> On Wed, Jul 17, 2019 at 11:28:37PM +0530, Himanshu Jha wrote:
>> On Sat, Jun 22, 2019 at 03:55:15PM +0100, jic23@kernel.org wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>=20
>>> Not exactly standard license text, but clear in intent and it's
>>> my copyright anyway.
>>>=20
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>> drivers/iio/trigger/iio-trig-loop.c | 3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/iio/trigger/iio-trig-loop.c =
b/drivers/iio/trigger/iio-trig-loop.c
>>> index 9258d3cf149b..f0205a9e47d0 100644
>>> --- a/drivers/iio/trigger/iio-trig-loop.c
>>> +++ b/drivers/iio/trigger/iio-trig-loop.c
>>> @@ -1,8 +1,7 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>=20
>> I think it should be:
>>=20
>> 	// SPDX-License-Identifier: GPL-2.0-only
>>=20
>> https://spdx.org/licenses/
>> https://spdx.org/licenses/GPL-2.0-only.html
>>=20
>> I don't know if `spdxcheck.py` points out about
>> such a mismatch.
>>=20
>> Yes, documentation and sanity checkers needs to be updated.
>> =
https://lore.kernel.org/lkml/CAHk-=3DwipjStEwJj2_iWxBdVC4oV8rY5NjrRb1tmWLU=
a0VrS_Eg@mail.gmail.com/
>=20
> Please read the in-kernel documentation about this.  We support both
> types of tags now and have done so since the beginning.
>=20
>=20
While I understand that the previous SPDX License List and current =
version identifiers are supported here, it would be really helpful more =
generally if we could use the current ones now and going forward.

Thanks,
Jilayne
SPDX legal team co-lead

