Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A846474AA
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFPNYh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 09:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfFPNYh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 09:24:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DE020870;
        Sun, 16 Jun 2019 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560691476;
        bh=Ug0DvbLkFLLhPZAOlZ933hhZC1qFeTz23ULIbSaz7TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XmsPR30BBipjvt9yJht9OonpRSdmNGN6l9SDqIgV3y7ZeWTncbxVXiEC0lvvK99iI
         pXnGiYX4Nq9dwQA/EowQ/LO11ica5mUZVgl2IS8WC/J+G5/9z83AAkvzETmjDtj1Zp
         wttcwziWR96+uR0JvTRxE3MdqvHJ6U9Nn6HRP5YM=
Date:   Sun, 16 Jun 2019 14:24:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: Re: [RFC PATCH 0/3] io: imu: st_lsm6dsx: wake on acc event
Message-ID: <20190616142431.111e6280@archlinux>
In-Reply-To: <20190614122604.52935-1-sean@geanix.com>
References: <20190614122604.52935-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 14:26:01 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Hi,
> 
> The first patch enables the wake event creation in the suspend function,
> it hardcodes the accelerometer to low power mode and the gyro is powered down.
> 
> The second and third patch is where I have some questions.
> Is it okay to create an sysfs entry that can enable and disable the wake
> events from the accelerometer?

On that I'm not sure - is there a standard way of configuring wake up events
outside of IIO?

> 
> The third patch is enabling us to set the threshold value.
> Obviously this will need to be changed to represent a real value instead
> of the raw register value.
> Maybe I need to add a threshold avaliable sysfs entry?
> Do I set it to a raw value calculated from the scale value or is some have
> a better idea?
Yes, if a device is providing a _raw channel reading then threshold
values should also be raw.

Available sysfs attribute makes sense if it helps a user, or userspace
program to set the value.

> 
> Finally is this the right approach to enable wake on accelerometer
> events?
> Please provide some idea's to how we could do it in the best and most
> generic way.

It's not something I've come across before, so hopefully someone else
can provide guidance on this!

My only immediate thought is that perhaps this should be a device tree
thing rather than userspace controlled?
There also seems to be some existing infrastructure to control this
in the power directory for a device.

Documentation/ABI/testing/sysfs-devices-power

Thanks,

Jonathan

> 
> /Sean
> 
> Sean Nyekjaer (3):
>   iio: imu: st_lsm6dsx: add wake on accelerometer threshold
>   iio: imu: st_lsm6dsx: add wake on accelerometer enable hook in sysfs
>   iio: imu: st_lsm6dsx: add wake on accelerometer threshold hook in
>     sysfs
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 135 +++++++++++++++++++
>  2 files changed, 137 insertions(+)
> 

