Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5F572AF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFZUkF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 16:40:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39216 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 16:40:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5D4512603FD
Subject: Re: [PATCH v3 0/2] Support accelerometers for veyron_minnie
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        dianders@chromium.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190624225312.131745-1-gwendal@chromium.org>
 <5326bfb8-611f-765b-1c9c-c95032102c71@collabora.com>
 <20190626202103.07e27e5e@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <882cf47c-c126-3e10-ba3a-23c926a68ce1@collabora.com>
Date:   Wed, 26 Jun 2019 22:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626202103.07e27e5e@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 26/6/19 21:21, Jonathan Cameron wrote:
> On Tue, 25 Jun 2019 19:09:50 +0200
> Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
>> Hi,
>>
>> On 25/6/19 0:53, Gwendal Grignou wrote:
>>> veyron_minnie - ASUS Chromebook Flip C100PA - embedded controller
>>> controls two accelerometers, one in the lid, one in the base.
>>> However, the EC firmware does not follow the new interface that
>>> cros_ec_accel driver use.
>>> Extend the legacy driver used on glimmer - Lenovo ThinkPad 11e
>>> Chromebook - to veyron_minnie.
>>> veyron_minnie being ARM based, issue command over the I2C bus to the EC
>>> instead of relying on the shared registers over LPC.
>>>
>>> Gwendal Grignou (2):
>>>   iio: cros_ec: Add sign vector in core for backward compatibility
>>>   iio: cros_ec: Extend legacy support to ARM device
>>>
>>> Changes in v3:
>>> - Fix commit message, add reviewed-by for first patch.
>>>
>>> Changes in v2:
>>> - Readd empty line to reduce amount of change in patch.
>>> - Remove Keywords used by ChromeOS commit queue.
>>>
>>>  drivers/iio/accel/Kconfig                     |   4 +-
>>>  drivers/iio/accel/cros_ec_accel_legacy.c      | 350 ++++--------------
>>>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   4 +
>>>  .../linux/iio/common/cros_ec_sensors_core.h   |   1 +
>>>  4 files changed, 84 insertions(+), 275 deletions(-)
>>>   
>>
>> Just a side note that I think that this patch depends on [1] to have the legacy
>> sensors working on veyron minnie.
>>
>> For the full series:
>>
>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Ah. I was assuming you mean a runtime dependency.  Whereas applying this
> on it's own is giving me a build problem:
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c: In function ‘cros_ec_accel_legacy_read_cmd’:
> drivers/iio/accel/cros_ec_accel_legacy.c:50:16: error: ‘struct <anonymous>’ has no member named ‘max_sensor_count’

Right, this also build depends on the immutable branch (ib-mfd-cros-v5.3).


>    50 |  st->param.dump.max_sensor_count = CROS_EC_SENSOR_LEGACY_NUM;
>       |                ^
> make[3]: *** [scripts/Makefile.build:285: drivers/iio/accel/cros_ec_accel_legacy.o] Error 1
> make[2]: *** [scripts/Makefile.build:489: drivers/iio/accel] Error 2
> make[1]: *** [scripts/Makefile.build:489: drivers/iio] Error 2
> 
> Which I'll assume is related to that other set.
> 
> I'm happy for these to go another route to sit on top of that series.
> If not I'll pick them up for the next cycle via IIO.
> 
> Should they go another route,
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for both of them.

I'd be happy to pick this patch and add to the chrome-platform tree, ideally
once we manage to get [1] ready for land.

Thanks,
~ Enric

> 
>>
>>
>> [1] https://lkml.org/lkml/2019/6/18/268
> 
