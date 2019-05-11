Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 854A61A7A2
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfEKLFn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEKLFn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:05:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9CEA217F9;
        Sat, 11 May 2019 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557572741;
        bh=OP5PzMKNdv7eZTclz6nMXr+GPXx4HBbNzjUZYRYUa/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xKbDZt6GAyBICk/pLUZM4FgM6vLQ8lH5jT1N5OdVcsZXE84mIFZVF+4Y/jkngLSQX
         6NQeV8XCW6snF6a6WMTDHT+qjSBW/3PNaUz+yp8Fhhs9wt12SmRlx6kNLL2C5C51ix
         a9MkDcGf+JfuUrBOIgkq3n2wgIt1fHkRLc1v7rNY=
Date:   Sat, 11 May 2019 12:05:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-iio <linux-iio@vger.kernel.org>, kernel@pyra-handheld.com,
        lkml <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [RFC v2] iio: input-bridge: optionally bridge
 iio acceleometers to create a /dev/input interface
Message-ID: <20190511120536.647c8676@archlinux>
In-Reply-To: <D4F87479-4FF7-4DBC-81D5-1BA836D2C889@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com>
        <20190407133037.0ad98897@archlinux>
        <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com>
        <20190414124029.1f1f6084@archlinux>
        <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com>
        <20190422152014.7c6637ab@archlinux>
        <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
        <D4F87479-4FF7-4DBC-81D5-1BA836D2C889@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 May 2019 19:02:49 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 09.05.2019 um 11:09 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> > 
> > Hi Jonathan,  
> >> 
> >> 
> >> And how does that work on the common case of a sensor in the lid of a laptop?
> >> how do you know what angle the screen is at?    
> > 
> > Well, I am not aware of laptops where the sensor is in the lid because I am in the handhelds
> > business, but let's assume it is common.
> > 
> > I realized that if the sensor orientation is related to the lid position, while the reference
> > frame reported to user space is to be referenced to the lap or keyboard of the laptop, there does
> > not exist a static mount-matrix to describe it properly. So no driver can report that correctly.
> > 
> > Therefore, such a device needs a dynamic mount matrix, i.e. there should be a kernel driver that
> > reads out the lid angle sensor and modifies the mount-matrix of the accelerometer by some sin()/cos()
> > table.  
> 
> One more thought on this topic.
> 
> My answer to the question "how do you know what angle the screen is at?" by requiring an ADC to
> measure some potentiometer in the hinge to make the mount matrix dynamic is probably completely
> wrong...

There are lid angle sensors out independent of this discussion that might work
as you describe but so far they are rare.  There is one under review for
cros_ec for example - how it is implemented, no idea!

> 
> If we take the definition for the mount matrix, it defines a specific g-vector pointing to
> center of earth if the user is holding the device in a specific position and looking on the display
> or the keyboard.
> 
> So far the description assumes that there is a single accelerometer and display and keys of a phone
> are in a single plane, i.e. there is no angle and everything is fine.
> 
> Now if we simply take the two accelerometers separately, one z-axis is going through the keyboard
> and the other through the display. Which means if the mount matrices are well defined, the accelerometers
> should report almost the same values if the display is fully opened by 180 degrees, i.e. the display
> is sitting flat on the table. This is what my RFC does by autoscaling. The values differ only
> by noise.
> 
> Now what about measuring the lid angle? Well, it is already measured by both accelerometers! If they
> do not agree, the angle can be calculated by some arctan() based on y and z axis reports...
Agreed. This is how it is done.
> 
> If you close the lid, the display is turned upside down and y and z axes reverse sign.
> 
> So there remains only the issue that user-space must know which sensor device file is which sensor
> and can do the calculation of the lid angle. This is possible because the iio accelerometer name
> is available through the input event ioctls.
> 
> In summary this case also does not need policy or configuration. Just user space using the information
> that is already presented.

I disagree with that last statement.  If there is a lid angle sensor, policy is
needed to know which of your associated orientation is the base one and which
device indicates the lid angle.

Actually most of the time what you will do is pick one 'correct' sensor under
some configuration of the device and use that.  That is policy.  Yes, you could
bake the policy in to device tree, but then you can also bake in the association
between the underlying IIO sensor and any virtual input sensor.

Anyhow, we still disagree on whether any such virtual input interface
should be a userspace policy decision.  So far I haven't seen any compelling
argument why it shouldn't be and the flexibility such a policy based interface
provides is its major advantage.

Thanks,

Jonathan
