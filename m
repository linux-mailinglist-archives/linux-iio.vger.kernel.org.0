Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75818E98
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2019 19:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEIRDN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 May 2019 13:03:13 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:17257 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfEIRDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 May 2019 13:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1557421390;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=H3lnJ9dE3RVSGljpof8FDqvjGlBz4jQwVwWyCSSvC34=;
        b=WAECiaM4cB7lJHQ3PB4vKaWRnAtMOSXJz3LFMRLqLog29C9H44JOgQn9HyLRFY3VyV
        hSEJPCCyZoqtEGjj99hJwKPuiymrj3MgAmR7Z+UGmevIpYnX2Bw9VAR16H5VpDovrrID
        uCOqeLDh6yBLHX21z6hAiuCGKyHfTiTno7NWQHtRFEIXHiNCxZQfOyJZ+FVKFr/+y6Y/
        laxPWETgirMjqNFXm0GojR9ijcxXGiKUCWTq/sYgZo95FKOlcggU5v4+vEhTXbjdvkrZ
        3I6iazqB/wb1t+GYlRNxmhzbZOs+VD2kc0wTgxSlqUTX4kHRO0cen5WBz5tgvMuomszh
        RuQA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCym3tRTG2PRBNSU9ZENVnYhackh9D8ptgIbhm9v"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:263c:7500:a9fa:6d0c:a26d:f576]
        by smtp.strato.de (RZmta 44.18 AUTH)
        with ESMTPSA id j04dc1v49H2lNQX
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 9 May 2019 19:02:47 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
Date:   Thu, 9 May 2019 19:02:49 +0200
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4F87479-4FF7-4DBC-81D5-1BA836D2C889@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux> <CA9A9410-C393-49B9-81FA-D9BC55F04468@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Am 09.05.2019 um 11:09 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Jonathan,
>>=20
>>=20
>> And how does that work on the common case of a sensor in the lid of a =
laptop?
>> how do you know what angle the screen is at? =20
>=20
> Well, I am not aware of laptops where the sensor is in the lid because =
I am in the handhelds
> business, but let's assume it is common.
>=20
> I realized that if the sensor orientation is related to the lid =
position, while the reference
> frame reported to user space is to be referenced to the lap or =
keyboard of the laptop, there does
> not exist a static mount-matrix to describe it properly. So no driver =
can report that correctly.
>=20
> Therefore, such a device needs a dynamic mount matrix, i.e. there =
should be a kernel driver that
> reads out the lid angle sensor and modifies the mount-matrix of the =
accelerometer by some sin()/cos()
> table.

One more thought on this topic.

My answer to the question "how do you know what angle the screen is at?" =
by requiring an ADC to
measure some potentiometer in the hinge to make the mount matrix dynamic =
is probably completely
wrong...

If we take the definition for the mount matrix, it defines a specific =
g-vector pointing to
center of earth if the user is holding the device in a specific position =
and looking on the display
or the keyboard.

So far the description assumes that there is a single accelerometer and =
display and keys of a phone
are in a single plane, i.e. there is no angle and everything is fine.

Now if we simply take the two accelerometers separately, one z-axis is =
going through the keyboard
and the other through the display. Which means if the mount matrices are =
well defined, the accelerometers
should report almost the same values if the display is fully opened by =
180 degrees, i.e. the display
is sitting flat on the table. This is what my RFC does by autoscaling. =
The values differ only
by noise.

Now what about measuring the lid angle? Well, it is already measured by =
both accelerometers! If they
do not agree, the angle can be calculated by some arctan() based on y =
and z axis reports...

If you close the lid, the display is turned upside down and y and z axes =
reverse sign.

So there remains only the issue that user-space must know which sensor =
device file is which sensor
and can do the calculation of the lid angle. This is possible because =
the iio accelerometer name
is available through the input event ioctls.

In summary this case also does not need policy or configuration. Just =
user space using the information
that is already presented.

BR,
Nikolaus



