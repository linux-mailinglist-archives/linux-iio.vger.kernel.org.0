Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D15D484441
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jan 2022 16:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiADPJA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 4 Jan 2022 10:09:00 -0500
Received: from aposti.net ([89.234.176.197]:42946 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbiADPJA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jan 2022 10:09:00 -0500
Date:   Tue, 04 Jan 2022 15:08:48 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 01/51] iio:accel:da311: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr() etc
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Message-Id: <O2Y65R.THAX75MFFTRJ1@crapouillou.net>
In-Reply-To: <20220104141601.00005ed8@Huawei.com>
References: <20220102125617.1259804-1-jic23@kernel.org>
        <20220102125617.1259804-2-jic23@kernel.org>
        <CAK8P3a20AatvTxHEXfTpMWD8RJtLbJiTLbhiKJgQrn+KXYG8zw@mail.gmail.com>
        <20220103152444.0e22e971@jic23-huawei>
        <CAK8P3a0OSU8Pz2=92ZQ2+uOXSoumRMPLEZM1zthsaYuZb162Kw@mail.gmail.com>
        <20220104141601.00005ed8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Le mar., janv. 4 2022 at 14:16:01 +0000, Jonathan Cameron 
<Jonathan.Cameron@Huawei.com> a écrit :
> On Mon, 3 Jan 2022 12:58:46 -0500
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>>  On Mon, Jan 3, 2022 at 10:24 AM Jonathan Cameron <jic23@kernel.org> 
>> wrote:
>>  > On Sun, 2 Jan 2022 09:15:06 -0500 Arnd Bergmann <arnd@arndb.de> 
>> wrote:
>>  >
>>  > That came up in discussion of the patch series introducing this 
>> macro
>>  > 
>> https://lore.kernel.org/linux-pm/20211216110936.6ccd07d3@jic23-huawei/
>>  >
>>  > Most of the cases that don't define it as static
>>  > also export the symbol for use by other modules so the approach 
>> of letting
>>  > the compiler detect it as dead code won't always work.
>>  >
>>  > Exceptions from a bit of grepping are
>>  > net/ethernet/broadcom/bnx2x/
>>  > scsi/esas2r/esas2r_init.c
>>  >   not sure on reasoning behind the file splits in these drivers
>>  >   but definitely looks like it we could just merge a few files
>>  >   and let this be static + the compiler remove it neatly.
>>  >
>>  > vs 17 cases where the symbol is exported and more cleverness will
>>  > be needed.
>> 
>>  I don't see why exporting the symbol makes a difference at all, 
>> either
>>  it is needed in another file or it is not.
> 
> Ah. My reasoning was that the purpose behind that patch set (letting
> compiler remove the functions etc when unused) was not applicable in 
> EXPORT*
> cases.  However, I'd neglected that the DEFINE_SIMPLE_DEV_PM_OPS()
> macro is probably useful anyway as those cases would need CONFIG_PM*
> guards if they want to remove the code when PM stuff isn't enabled.
> 
>> 
>>  I think it would be more natural to not include 'static' in the 
>> macro,
>>  that is certainly what all other macros like this do, and it's still
>>  trivial to add 'static' manually, but impossible to remove it.
> 
> IIRC there are other cases like this, but it was exactly this somewhat
> unusual element that made me raise the question in the original 
> discussion.
> 
> Paul, over to you for reasoning.  If we are going to change this
> now is the time before they get significant use and we end up having
> to add static to lots of places.

I have an idea on how to tackle automatic dead code removal on exported 
dev_pm_ops symbols. It means introducing a separate 
EXPORTED_SIMPLE_DEV_PM_OPS(), so the current DEFINE_SIMPLE_DEV_PM_OPS() 
macro could keep the "static". Unless you still think it's a bad idea, 
then in this case we can remove it.

Cheers,
-Paul


