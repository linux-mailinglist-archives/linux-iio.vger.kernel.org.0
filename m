Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5108712AD25
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2019 16:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLZPD0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Dec 2019 10:03:26 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50061 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfLZPD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Dec 2019 10:03:26 -0500
X-Originating-IP: 90.114.244.64
Received: from zephyr-1.home (unknown [90.114.244.64])
        (Authenticated sender: hadess@hadess.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id ABA1C1BF206;
        Thu, 26 Dec 2019 15:03:22 +0000 (UTC)
Message-ID: <9baeb165eddb4872fb701ff81f11692b7e153bf6.camel@hadess.net>
Subject: Re: Display got wrong rotation after hid_sensor_accel_3d is loaded
From:   Bastien Nocera <hadess@hadess.net>
To:     AceLan Kao <acelan.kao@canonical.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Date:   Thu, 26 Dec 2019 16:03:21 +0100
In-Reply-To: <CAFv23QmiDdhe+xJw2y7CXiWq4-GK1S-1bcKxEpNhNJu3ZtzA_w@mail.gmail.com>
References: <CAFv23QmiDdhe+xJw2y7CXiWq4-GK1S-1bcKxEpNhNJu3ZtzA_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2019-12-26 at 17:22 +0800, AceLan Kao wrote:
> Hi all,
> 
> I'm working on a new platform which comes with an accelerator meter.
> It's a STMicroelectronics LSM6DS3US accelerator meter, it doesn't use
> st_sensors driver, but hid_sensor_accel_3d.
> After hid_sensor_accel_3d is loaded, the display becomes upside down,
> so I tried to add some code to make it become normal.(ACCEL_X should
> have the same modification)
> 
> I don't know how to fix this in a correct way, please give me some
> hints.

This needs to be done as a quirk, either by applying a quirk for the
HID descriptors (which should have a definition of the scale, which
would be negative for this device), or in user-space in systemd's hwdb
database, which your user-space consumers need to take care of:
https://github.com/systemd/systemd/blob/master/hwdb.d/60-sensor.hwdb

Cheers

