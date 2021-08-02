Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A3C3DD402
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 12:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhHBKkh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 06:40:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3548 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhHBKkh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 06:40:37 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdZJz6ngqz6BBDZ;
        Mon,  2 Aug 2021 18:40:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 12:40:26 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 11:40:25 +0100
Date:   Mon, 2 Aug 2021 11:39:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Morgan Hager <morgan.hager1@gmail.com>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: ACPI Ambient Light Sensor Events
Message-ID: <20210802113958.00003678@Huawei.com>
In-Reply-To: <44033d8f-c387-49d5-30c9-79a45c3b1408@gmail.com>
References: <44033d8f-c387-49d5-30c9-79a45c3b1408@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 1 Aug 2021 20:20:07 -0600
Morgan Hager <morgan.hager1@gmail.com> wrote:

> I was thinking of extending the acpi-als driver to support reading the
> colour temperature, chromaticity, polling interval, and response
> table, but there's a problem with doing the response table through
> IIO; the table is variable-length, but it seems that IIO channels only
> support fixed-length samples (and the ACPI spec also does include a
> provision for an event to be sent if the response table changes, so it

I'd be wary.  ACPI supports a lot of events that never get used by
anyone so also good to point to a known platform that does notify on
_ALR changing.

> would be good to expose that to userspace rather than only allowing
> reading the table from a file).
> 
> As an alternative approach, I have written a driver for personal use
> which is not at all based on IIO and instead conveys events through
> the ACPI netlink socket and readings directly through sysfs nodes, at
> https://github.com/goose121/als_bus; this works fairly well, but it
> seems that the driver was specifically migrated from something similar
> to the IIO framework so that it would be compatible with other light
> sensors, and it seems inelegant to use a completely different
> interface for one property of a device.
> 
> Does anyone know of an elegant way these events could be exposed to
> userspace, preferably one which would fit into the current framework
> of the driver?

For things like this, we can potentially use the rather vague event
type of IIO_EV_TYPE_CHANGE.  It's not ideal, but you would then use
that in conjunction with a sysfs file to get the data.
The event telling you to read the file.  The reason it's not ideal
is that the reponse table doesn't really sound much like a channel
to me and we can only associate events with a channel.

Very nature of events in IIO is to that they are slim, so we don't
carry data in them anyway (beyond that the really basic types).

One other thing to take into account here.  If you define new ABI
for _ALR it will probably not be supported by standard userspace as
there is no generally accepted way of providing conversion curves.
The ACPI spec is clearly trying to solve that problem but I fear most
light sensors won't be on ACPI platforms any time soon. Much of the maths
needed for light sensors involves fusing multiple different sensing element
whereas I don't the ACPI approach supports this.

So, what we normally do (hideous though it is) is to do the maths in
kernel so that we can provide a _PROCESSED value that userspace can
directly use.  It's a pain to do the fixed point maths but the advantage
is no special userspace code is needed.

If you got that way, then the updates of _ALR will be entirely hidden
in the driver and no userspace interface is needed.

Thanks,

Jonathan



> 
> Thank you for your input,
> Morgan Hager

