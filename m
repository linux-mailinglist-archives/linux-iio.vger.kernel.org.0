Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07F73748DA
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 10:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbfGYIOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 04:14:17 -0400
Received: from comms.puri.sm ([159.203.221.185]:35968 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389116AbfGYIOQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jul 2019 04:14:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 016E4E02E4;
        Thu, 25 Jul 2019 01:14:14 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xs46vcVnlcIR; Thu, 25 Jul 2019 01:14:13 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20190725053132.9589-1-martin.kepplinger@puri.sm>
 <20190725053132.9589-5-martin.kepplinger@puri.sm>
 <CAA2SeNK-pjkSWVsrv5dehEJbakZqR0oPF3DQ5mzhiiOD3Npxkg@mail.gmail.com>
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
Openpgp: preference=signencrypt
Autocrypt: addr=martin.kepplinger@puri.sm; keydata=
 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
 WG//KA68tPVBR2xhy7Fp+qAa
Message-ID: <9af363c9-2676-05bf-0cb4-de4dc8ba991c@puri.sm>
Date:   Thu, 25 Jul 2019 10:14:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <CAA2SeNK-pjkSWVsrv5dehEJbakZqR0oPF3DQ5mzhiiOD3Npxkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 25.07.19 09:04, Lorenzo Bianconi wrote:
> 
>     The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer
>     (separately
>     supported in iio/magnetometer/st_magn*) are located on a separate
>     i2c addresses
>     on the bus.
> 
>     For the datasheet, see
>     https://www.st.com/resource/en/datasheet/lsm9ds1.pdf
>     <https://www.st.com/resource/en/datasheet/lsm9ds1.pdf>
> 
>     Treat it just like the LSM6* devices and, despite it's name, hook it up
>     to the st_lsm6dsx driver, using it's basic functionality.
> 
>     Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm
>     <mailto:martin.kepplinger@puri.sm>>
> 
> 
> 
>  Hi Martin,
> 
> could you please check if LSM9DS1 and LSM6DS0 have a common register map
> for the supported features (I think so)? If so I think it is better to
> rename LSM9DS1 in LSM6DS0 since st_lsm6dsx supports just acc and gyro
> (we will support LSM9DS1 with a proper dts configuration)
> 
> Regards,
> Lorenzo

Hi Lorenzo,

The register mappings of LSM6DSO and LSM9DS1 don't match (gyro out for
example). The LSM9DS1 magnetometer is a *different* device on the bus
than accel/gyro (despite being on the same chip). That one is already
supported in drivers/iio/magnetometer/st_magn_*

So LSM9DS1 in the imu driver (lsm6dsx) can also just support accel and
gyro in order to complete the support for the device.

Besides, that's the device I have and test here. I can't really name it
differently.

What are you working on (dts description)?

thanks,
                             martin
