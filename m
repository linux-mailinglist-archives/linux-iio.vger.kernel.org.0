Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C544F313382
	for <lists+linux-iio@lfdr.de>; Mon,  8 Feb 2021 14:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhBHNls (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Feb 2021 08:41:48 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:43551 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBHNlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2021 08:41:42 -0500
Received: from [192.168.1.150] (unknown [78.199.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5901F24000F;
        Mon,  8 Feb 2021 13:40:50 +0000 (UTC)
Message-ID: <2b7a0374f4af5e2113c1d209246b506d7f42ae29.camel@hadess.net>
Subject: Re: [PATCH 1/2] iio: documentation: Document proximity sensor label
 use
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-input@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>
Date:   Mon, 08 Feb 2021 14:40:49 +0100
In-Reply-To: <20210207123720.8357-1-hdegoede@redhat.com>
References: <20210207123720.8357-1-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-02-07 at 13:37 +0100, Hans de Goede wrote:
> Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
> the new device and channel label sysfs-attribute support.
> 
> And document the standardized labels which may be used with proximity
> sensors to hint userspace about the intended use of the sensor.
> 
> Using labels to differentiate between the multiple proximity sensors
> which a modern laptop/tablet may have was discussed in this thread:
> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/
> 
> As mentioned the "proximity-wifi*" labels are already being used in
> this manner on some chromebooks, see e.g.:
> arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi
> 
> And the "proximity-palmrest" and "proximity-lap" labels are intended
> to be used with the lap and palmrest sensors found in recent Lenovo
> ThinkPad models.

Both patches in the series look fine to me.

Is IIO the interface you plan on using to implement the lap detection
for the thinkpad_acpi driver?

If so, don't forget to set the "nearlevel" property as well. I'll
probably have to write a new iio-sensor-proxy driver for those as well,
without the hardware. That'll be interesting ;)

Cheers

