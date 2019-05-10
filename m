Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAABD19AAD
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2019 11:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfEJJeA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 May 2019 05:34:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:27146 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfEJJeA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 May 2019 05:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1557480836;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=C8WiZW1jjTfeo6DJEapxqioDf/xOovEO+bb4GmMWIpM=;
        b=NAFJZAAnyxaBSg7NB3eS9fb6vja9PlGNJNfWaD9DKrgFIzZrWSrhk7hEpbYNJg249o
        dSFT6QdW5ZYSdc+JLkAIcbTDH464X5ksycmz/PA5Afd4w11XrOKj1SBVb8A0Oenkmmwu
        yD+1fLhaH0Ja02wC45PmvpYSAikGmXaJRQzg7SsLfykx9HdYnc51MwRjMWKTj8yNilCO
        E3aBdMNbOZtxbW0sWwN1nGxjlODC5s6VCh0OXcGcu76uiJQmt+lalpbIXRSSM60RCKVi
        Wr7F3A+8adkmcV778jXN98xWHBOkg84+JpJP3Rt1dWZ2TqdxB4feYtHOEWiSwRKdztjm
        Nnpg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMgw4Tt7w=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id j04dc1v4A9XQQRb
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 10 May 2019 11:33:26 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC v2] iio: input-bridge: optionally bridge iio acceleometers to create a /dev/input interface
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
Date:   Fri, 10 May 2019 11:33:26 +0200
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        linux-input@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7440F555-5A92-442C-B217-BE17EEF9EF68@goldelico.com>
References: <195994ebff28de22eae872df134d086c761b83b8.1554026986.git.hns@goldelico.com> <20190407133037.0ad98897@archlinux> <CD44AFA0-6676-4842-9C80-61BB363DD556@goldelico.com> <20190414124029.1f1f6084@archlinux> <CD6219BE-61FF-4C38-9532-054C60A77F89@goldelico.com> <20190422152014.7c6637ab@archlinux> <b5e40ab0d5aad247b7cb9539c198e04096c516c1.camel@hadess.net>
To:     Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3124)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Am 10.05.2019 um 10:57 schrieb Bastien Nocera <hadess@hadess.net>:
>=20
> On Mon, 2019-04-22 at 15:20 +0100, Jonathan Cameron wrote:
>>> Different goals usually lead to different solution architectures.
>>=20
>> Indeed, but in this case we have your proposal which is a subset of
>> what
>> I am suggesting.  One architecture can fulfil both requirements.
>>=20
>> I'll leave it for the other thread, but Bastien has raised the case
>> (that I'd forgotten) that there already userspace stacks that are
>> capable of happily taking in both IIO and Input devices.  The
>> confusion
>> here is they will now discover 'both' without the existing userspace
>> knowing that they are the same device.  We need to be very careful
>> not
>> to break those userspace programs.
>>=20
>> So this is an illustration of why the simplistic case doesn't work
>> 'now'.
>=20
> I don't know what state the whole patch is, but, at the very least, =
I'd
> expect that patch to export the fact that it's exporting synthesised
> data from another driver, so that it can be easily ignored in user-
> space that already supports IIO devices.
>=20

It does through "Input device name:" starting with "iio-bridge:" as you =
can see in the commit message of [RFC v3]:

root@letux:~# evtest /dev/input/event5 | head -19
Input driver version is 1.0.1
Input device ID: bus 0x0 vendor 0x0 product 0x0 version 0x0
Input device name: "iio-bridge: bmc150_accel"
Supported events:
  Event type 0 (EV_SYN)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      8
      Min     -511
      Max      511
    Event code 1 (ABS_Y)
      Value    -44
      Min     -511
      Max      511
    Event code 2 (ABS_Z)
      Value   -265
      Min     -511
      Max      511



