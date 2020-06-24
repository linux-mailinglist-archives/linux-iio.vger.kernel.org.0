Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7E207010
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jun 2020 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbgFXJbK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Jun 2020 05:31:10 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40985 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbgFXJbK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jun 2020 05:31:10 -0400
X-Originating-IP: 82.255.60.242
Received: from classic (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 46C8860013;
        Wed, 24 Jun 2020 09:31:06 +0000 (UTC)
Message-ID: <f9184404114243a77f67bc4bdc4170abef8d7a16.camel@hadess.net>
Subject: Re: linux-iio and Windows default orientations
From:   Bastien Nocera <hadess@hadess.net>
To:     Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org
Date:   Wed, 24 Jun 2020 11:31:06 +0200
In-Reply-To: <fad058f5-ba5c-0cf2-317f-c0bb8457846e@redhat.com>
References: <16f4bfe1c254798291507aca00afeb2c8b0978a7.camel@hadess.net>
         <fad058f5-ba5c-0cf2-317f-c0bb8457846e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2020-05-12 at 18:12 +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/12/20 3:55 PM, Bastien Nocera wrote:
> > Hey,
> > 
> > I'm just dotting the is, and crossing the ts on a bunch of iio-sensor-
> > proxy documentation and wanted to revisit the IIO documentation,
> > compared to what Windows, and my implementation did.
> > 
> > Does this:
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/Documentation/ABI/testing/sysfs-bus-iio#n1638
> > in particular the "Z" axis:
> > "Z is perpendicular to the screen plane and positive out of the screen"
> > 
> > match this:
> > https://docs.microsoft.com/en-us/windows/uwp/devices-sensors/sensor-orientation
> > "with the positive z-axis extending out from the device."
> 
> Yes I believe that the 2 are stating the same, this is also how the
> Z axis works on Android I believe. If you put a phone or tablet
> flat on a table with the display up, then you will get a -1.0G or
> -9.8 m/s²
> reading since the gravity is pulling downwards (away from the front
> of
> the screen) with 1G.

"extending out from the device" could mean away from the user, so away
from the display, which would invert the Z axis compared to the IIO
docs. I think that's the opposite of what was actually meant, but just
to make doubly sure, I filed a bug against the Windows docs:
https://github.com/MicrosoftDocs/windows-uwp/issues/2542

> > This Microsoft page didn't exist when I changed the code to "match
> > Windows 10" in 2016:
> > https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/commit/35b6328cbdaa5efa30917c445962d64fd733fb02
> > 
> > (And just to double check, it seems that the other 2 axis do match in
> > their definitions, right?)
> 
> Yes I believe they do, and also again Android's definition.

This seems to match indeed:
https://developer.android.com/reference/android/hardware/SensorEvent

