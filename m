Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E0F28B4B8
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgJLMhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 08:37:12 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJLMhM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Oct 2020 08:37:12 -0400
Received: from [192.168.1.155] ([77.2.5.48]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MQeDw-1knLXr1BDC-00Nkxk; Mon, 12 Oct 2020 14:36:57 +0200
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Hans de Goede <hdegoede@redhat.com>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <b400b6956270a2433373dd6cbdae3332aa683f4f.camel@hadess.net>
 <cadabe4d-7cce-281e-75fe-fcc2099848da@redhat.com>
 <5273a1de9db682cd41e58553fe57707c492a53b7.camel@hadess.net>
 <272074b5-b28e-1b74-8574-3dc2d614269a@redhat.com>
 <20201008001424.GA3713@labundy.com>
 <9893a32c-02c8-f00c-7f00-6287d55043ab@redhat.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <f4f00263-3beb-d941-eb3a-2be95684db66@metux.net>
Date:   Mon, 12 Oct 2020 14:36:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <9893a32c-02c8-f00c-7f00-6287d55043ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KKEN+bpXP3GjqbgoxOI5iqP+fmHqm71tJmcYNRCQwbw4f/08NMW
 UtyszG01BZOfsd/9PGpiPLqN1q2HV5uX//nuDqdW2trUw53m5sC6R6RniUaqHUpvlVarl9j
 i3FaOcCgSlMc2599iNvjlHhBZGAA8PxUpVQNMDQhLBZ9Qniv+luemOTeoxYWx/7Vbt0TEuZ
 R04JXXd0GZ6NeRUBl2QPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1NsqBuDAYmc=:eRXIdSKXL/WiFL5JPyRwqD
 /LYUa/bZ1S/KrYnvTA6EVpgtW1gvIkTbKTtgXXcNNfQu/Z7fOTlZFHEW4X7VSE6f6QDeIPReB
 Y+cvPhCzvqhMNiuxZV+HHxTTQKZotS/Jl52yMRGRRJZN3ChT+8jJWu3iyQTQ0B+9ZjfwDwDPU
 2YsFuX0R/X5ovB70lZM/PLrRT9Cc1qHSsQQyXcQVi7zHlbDWcutyX0rovM98LkLQpzl6BKLw/
 DztNNp8s0D/8PSqd6QachvQI5JY57MIGXKmV8qLnQ4Q4OKwgQolkQaMCJV9fVwB4uBm3YbApx
 G253QD8Fw365zDHC5MPSF8wY2gLJv0rlEEvu1Wh3ePQh9/cEVgX/HF3/gthuLAAIOoksGJGPw
 g0PqJyw4NniH2tqMkgtz4mskiVHY+WL5vT1u/dnW3GW4eva6CljjV2Fhrp+VlYkLJFOgU+l0j
 PvxcaWwsMXMZ95ZQSAV60mebxnGUL3Ht2P8EXUGXsovNVqKULmIHu9fJBz5wzFkwEP4Tn81Mb
 BCnEaauHJ7kU8iEI125xke5mGf3QyvMYgYqInRFToltOPongmUXiQFu9OvKUqmdcZFecoY3Kq
 YhIb+DSck41r8R0bqSKLqCJXvIPQNMtVssd3DeYokmmipRfhF7Z1Z6qcpklcDZ7L9EHv5Ofh4
 11/QlnR1JKNkxqehHI5xZ9ItkyCIy9fWLTiYRRfUX0ppOwybL3lBK2jdzTm+uRr5yRQZLhQtt
 oXDWJj7at3mekmOSuA0frFTdEw2K82IX0LhIcGDrqN2iDGlbxyaMtJFo4oQ6ucisFc3WUqmW1
 910OfdPAkjrFci584Qh2KV0nCJjJ5tIUOZs7p0l8+EkJSaVVaJrOKQTI5GN1zIDKdxX1Etd
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 08.10.20 09:10, Hans de Goede wrote:

Hi folks,

> Yes and no. At least the lap-mode detection (laptop on someones
> lap rather then sitting on a table) is currently used by the
> embedded-controller for thermal management decisions, basically
> when on someones lap the configurable TPD of the CPU is set lower
> to keep the laptop's bottom skin temperate < 45 degrees Celsius
> (I think it is 45 but the exact number does not matter).

Am I the only one who thinks the whole concept is a pretty weird
idea ?

IIRC the machine becomes slower when it *thinks* its on my lap,
but runs faster - and becomes hotter - when it's laying around
somewhere, eg. ontop of some papers ?

Where can I get the drugs that these guys took ? :o

> With upcoming WLAN cards with configurable transmit power,
> this will also be used as what you call a SAR device.

Same fun. Once a person comes near, the signal gets weaker and
potentially connection breaks. Great fun for debugging.

Back to the technical side: IMHO we should first work out what the
actual purpose of these sensors could be - are they useful for
anything else than just these specific cases ? If not, I'm not
sure whether it makes sense to put them into IIO at all, but using
a specific board driver instead.

Okay, maybe we find these sensors somewhere else (maybe some embedded
stuff), for completely different purpose - in that case having one
standard driver (for the sensor itself) could make sense.

But that leads me to bigger topic: we've got several cases of some
sensors/chips used in different subsystems, eg. simple one-shot
ADCs, eeprom's, etc. ... maybe we should move them to separate
subsystems, which then can be wired to other (more specific) ones
in a very generic way ? ... just some quick+dirty thoughs,


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
