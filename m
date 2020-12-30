Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8502E7895
	for <lists+linux-iio@lfdr.de>; Wed, 30 Dec 2020 13:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgL3Mif (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Dec 2020 07:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgL3Mif (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 30 Dec 2020 07:38:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1498A20715;
        Wed, 30 Dec 2020 12:37:51 +0000 (UTC)
Date:   Wed, 30 Dec 2020 12:37:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jyoti Bhayana <jbhayana@google.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        egranata@google.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com, Peter.hilber@opensynergy.com,
        ankitarora@google.com
Subject: Re: [RFC PATCH v2 0/1] Adding support for IIO SCMI based sensors
Message-ID: <20201230123748.4e969f82@archlinux>
In-Reply-To: <20201224031921.1547519-1-jbhayana@google.com>
References: <20201224031921.1547519-1-jbhayana@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Dec 2020 03:19:20 +0000
Jyoti Bhayana <jbhayana@google.com> wrote:

> Hi,
> 
> This series adds support for ARM SCMI Protocol based IIO Device.
> This driver provides support for Accelerometer and Gyroscope sensor
> using new SCMI Sensor Protocol defined by the upcoming SCMIv3.0 ARM
> specification, which is available at 
> 
> https://developer.arm.com/documentation/den0056/c/
> 
> The series is currently based on top of:
> 
> commit f83eb664cdb4 ("Merge tag 'scmi-voltage-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into for-next/scmi")
> 
> in Sudeep for-next/scmi branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/\
> linux.git/log/?h=for-next/scmi
> 
> This version of the patch series has been tested using 
> version 5.4.21 branch of Android common kernel.
> 
> Any feedback welcome,
> 
> Thanks,
> 
> Jyoti Bhayana
> 
> v1 --> v2
> - Incorporated the feedback comments from v1 review of the patch
> - Regarding the new ABI for sensor_power,sensor_max_range,
> and sensor_resolution, these are some of the sensor attributes
> which Android passes to the apps. If there is any other way of getting
> those values, please let us know

So, sensor_max_range can effectively be exposed as a combination of
scale and the *_raw_avail for a raw read (via the read_avail callback in IIO).
We'll ignore the fact the interface assumes a single value (so I assume symmetric?)

I think resolution in android is equivalent to _scale in IIO terms?
Docs seem to say it's "resolution of the sensor in sensor's units".
There are a few corners where that might not be true (sensors that do some
odd padding for example) but we can probably rely on it normally being fine.

Power.  Hmm. Currently we have no provision for this as users
of the sensor don't care.  The OS might of course, but individual applications
tend not to.

The question is much more general than IIO if we go down the route of
exposing this from the kernel as we should define some sort of power query
interface for any device in the system in a generic way. I'm not sure if
any such thing already exists.

Jonathan

> 
> Jyoti Bhayana (1):
>   iio/scmi: Adding support for IIO SCMI Based Sensors
> 
>  MAINTAINERS                                |   6 +
>  drivers/iio/common/Kconfig                 |   1 +
>  drivers/iio/common/Makefile                |   1 +
>  drivers/iio/common/scmi_sensors/Kconfig    |  18 +
>  drivers/iio/common/scmi_sensors/Makefile   |   5 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c | 693 +++++++++++++++++++++
>  6 files changed, 724 insertions(+)
>  create mode 100644 drivers/iio/common/scmi_sensors/Kconfig
>  create mode 100644 drivers/iio/common/scmi_sensors/Makefile
>  create mode 100644 drivers/iio/common/scmi_sensors/scmi_iio.c
> 

