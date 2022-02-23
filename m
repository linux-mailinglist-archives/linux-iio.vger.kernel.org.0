Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17F64C13C4
	for <lists+linux-iio@lfdr.de>; Wed, 23 Feb 2022 14:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbiBWNPJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 23 Feb 2022 08:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiBWNPI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Feb 2022 08:15:08 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1EA996E
        for <linux-iio@vger.kernel.org>; Wed, 23 Feb 2022 05:14:40 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:14:29 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 0/8] IIO: Where dev_pm_ops rework and namespaces meet.
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Message-Id: <54ER7R.R3NHXV9BWTRL3@crapouillou.net>
In-Reply-To: <20220223121341.0000089b@Huawei.com>
References: <20220220181522.541718-1-jic23@kernel.org>
        <O8AR7R.HDQ5MQXD3QZI3@crapouillou.net> <20220223121341.0000089b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Le mer., févr. 23 2022 at 12:13:41 +0000, Jonathan Cameron 
<Jonathan.Cameron@Huawei.com> a écrit :
> On Wed, 23 Feb 2022 11:50:48 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  Hi Jonathan,
>> 
>>  Le dim., févr. 20 2022 at 18:15:14 +0000, Jonathan Cameron
>>  <jic23@kernel.org> a écrit :
>>  > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>  >
>>  > Hi All,
>>  >
>>  > As these two activities have been ongoing across IIO at the same 
>> time
>>  > it was inevitable that there would be drivers were they both 
>> interact.
>>  > In particularly when we have EXPORT* of struct dev_pm_ops.
>>  >
>>  > This series covers those cases by introducing (in patch 2)
>>  > EXPORT_NS[_GPL]_SIMPLE_DEV_PM_OPS() and
>>  > EXPORT_NS[_GPL]_RUNTIME_DEV_PM_OPS()
>>  > that add a namespace as the final parameter.
>> 
>>  If we now have namespace versions of the macros, I'm starting to 
>> wonder
>>  if the original macros are still useful.
>> 
>>  In which case would we need to export a dev_pm_ops outside the 
>> scope of
>>  a namespace?
> 
> Excellent point. Long term my assumption is that any place where
> a dev_pm_ops is being exported probably should be in a namespace
> because the scope is tightly defined.
> 
> My only thought is it adds a burden to moving over to your new 
> infrastructure
> as it would be odd to move only the dev_pm_ops into a NS without 
> looking
> at the rest of the exports in a driver.
> 
> It was useful to be able to do things in two steps as it allowed 
> separation
> of using the new dev_pm_ops handling from a namespace move, but
> clearly could do that the other way around and not need the non
> namespaced version of this macro.
> So do namespace move first then use the new macros and hence only
> ever need the namespaced one.

I'd be slightly in favor of enforcing namespaces in the PM macros, if 
only to simplify the macro names (as you could just extend the existing 
ones to require a namespace, I don't think anything use them yet).

But I'm fine with keeping the non-namespaced macros as well if it's 
easier. We can always drop them later.

Cheers,
-Paul

> Jonathan
> 
> 
>> 
>>  Cheers,
>>  -Paul
>> 
>>  > In each driver (with the exception of the kxsd9 which was already
>>  > using a IIO_KXSD9 namespace) I first move to the new *_PM_OPS()
>>  > and pm_[sleep_]_ptr() then in a second patch move to the new
>>  > namespaces.  Initially I had these two steps done as one patch
>>  > per driver but that was harder to follow and broke the rule of
>>  > one thing per patch.
>>  >
>>  > All comments welcome.
>>  >
>>  > Thanks,
>>  >
>>  > Jonathan
>>  >
>>  > Jonathan Cameron (8):
>>  >   iio: chemical: scd30: Export dev_pm_ops instead of suspend() and
>>  >     resume()
>>  >   PM: core: Add NS varients of EXPORT[_GPL]_SIMPLE_DEV_PM_OPS and
>>  >     runtime pm equiv
>>  >   iio: chemical: scd30: Move symbol exports into IIO_SCD30 
>> namespace
>>  >   iio:accel:kxsd9: Switch from CONFIG_PM guards to pm_ptr() etc
>>  >   iio: humidity: hts221: Use EXPORT_SIMPLE_DEV_PM_OPS() to allow
>>  >     compiler to remove dead code.
>>  >   iio: humidity: hts221: Move symbol exports into IIO_HTS221 
>> namespace
>>  >   iio: imu: lsm6dsx: Use new pm_sleep_ptr() and
>>  >     EXPORT_SIMPLE_DEV_PM_OPS()
>>  >   iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX
>>  > namespace
>>  >
>>  >  drivers/iio/accel/kxsd9-i2c.c                |  2 +-
>>  >  drivers/iio/accel/kxsd9-spi.c                |  2 +-
>>  >  drivers/iio/accel/kxsd9.c                    | 11 ++---------
>>  >  drivers/iio/chemical/scd30.h                 |  5 +----
>>  >  drivers/iio/chemical/scd30_core.c            | 10 +++++-----
>>  >  drivers/iio/chemical/scd30_i2c.c             |  3 ++-
>>  >  drivers/iio/chemical/scd30_serial.c          |  3 ++-
>>  >  drivers/iio/humidity/hts221_core.c           | 12 +++++-------
>>  >  drivers/iio/humidity/hts221_i2c.c            |  3 ++-
>>  >  drivers/iio/humidity/hts221_spi.c            |  3 ++-
>>  >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++-------
>>  >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 ++-
>>  >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  |  3 ++-
>>  >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 ++-
>>  >  include/linux/pm.h                           | 14 +++++++++-----
>>  >  include/linux/pm_runtime.h                   | 10 ++++++++--
>>  >  16 files changed, 51 insertions(+), 48 deletions(-)
>>  >
>>  > --
>>  > 2.35.1
>>  >
>> 
>> 
> 


