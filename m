Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35D219AFD
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2019 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfEJKGf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 May 2019 06:06:35 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:18252 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfEJKGf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 May 2019 06:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1557482791;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=cUv6K6+1VZqIenkIGi0V+AylOlIcVZ0ARfNK2HErCeo=;
        b=Dr2o4EY06UK0GESdEKzGSTyN88t3/vpW6Sp92ZT8wft2spI1PjNLhuLewFAjWFNe8m
        chUPvXAGYtkhQ8jL83Fx3czNJ4Kpv9lXk2XlHS5JSle+3/CVKVPJY/od51pW6HrvXVN7
        IUbzfIsZz48UFd4VKVNgKQT6+/XUvu/HPX5RtKIeCszptIPQEj0SAPOq0fWRVkgSF7fD
        k3GQ8og8cJu3a9Yn11EKcmKboBDHHwv4XgUPlSIu7Nqjrwz0PS/OAD0Wq2WkZEMqc+6Q
        hRIY6x8CHvViFlS+IabggFTl12Fw1EyUshCe0blxXbmT6gBQetiv1Wa3oMWnlqVdU5yp
        557A==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMgw4Tt7w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id j04dc1v4AA63Qra
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 10 May 2019 12:06:03 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <4a77d53966d117bc5c7ff2836634d8591633f4f5.camel@hadess.net>
Date:   Fri, 10 May 2019 12:06:03 +0200
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C600F37-33E3-4C3D-B7D1-BBB85D5A2195@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux> <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net> <7440F555-5A92-442C-B217-BE17EEF9EF68@goldelico.com> <4a77d53966d117bc5c7ff2836634d8591633f4f5.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3124)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Am 10.05.2019 um 11:35 schrieb Bastien Nocera <hadess@hadess.net>:
>=20
> On Fri, 2019-05-10 at 11:33 +0200, H. Nikolaus Schaller wrote:
>>>=20
> <snip>
>> It does through "Input device name:" starting with "iio-bridge:" as
>> you can see in the commit message of [RFC v3]:
>=20
> This makes it ABI, right?

The "Input device name:" is already ABI of the input system (although I =
guess the string is
built into the evtest tool). I think there are also /sys nodes which =
carry the same information.

But yes, if someone changes the "iio-bridge:" prefix in kernel code it =
breaks a user space lib
making use of it:

+	poll_dev->input->name =3D kasprintf(GFP_KERNEL, "iio-bridge: =
%s",
+						    indio_dev->name);
+	poll_dev->input->phys =3D kasprintf(GFP_KERNEL, "iio:device%d",
+						    indio_dev->id);

This type of exporting names seems to be quite common. E.g. "mmcblk0p1" =
which may end up
in some /etc/fstab.

>=20
> Big fat warnings around the code that declares it would be =
appreciated.

Ok.



