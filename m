Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2635E9B7
	for <lists+linux-iio@lfdr.de>; Wed, 14 Apr 2021 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhDMXei (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Apr 2021 19:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMXei (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Apr 2021 19:34:38 -0400
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163CFC061574
        for <linux-iio@vger.kernel.org>; Tue, 13 Apr 2021 16:34:18 -0700 (PDT)
To:     linux-iio@vger.kernel.org
From:   Thomas Deutschmann <whissi@gentoo.org>
Subject: CONFIG_HID_SENSOR_IIO_TRIGGER depends on CONFIG_IIO_TRIGGERED_BUFFER
Organization: Gentoo Linux
Message-ID: <0ba66635-920a-2541-7b92-447cdb37764b@gentoo.org>
Date:   Wed, 14 Apr 2021 01:34:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LamQn7TxeaejNiKQiIgNmsaFG2lCugZwo"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LamQn7TxeaejNiKQiIgNmsaFG2lCugZwo
Content-Type: multipart/mixed; boundary="nbKOBoZZpn3VGff3h96RQtPHMI1nyNXMs";
 protected-headers="v1"
From: Thomas Deutschmann <whissi@gentoo.org>
To: linux-iio@vger.kernel.org
Message-ID: <0ba66635-920a-2541-7b92-447cdb37764b@gentoo.org>
Subject: CONFIG_HID_SENSOR_IIO_TRIGGER depends on CONFIG_IIO_TRIGGERED_BUFFER

--nbKOBoZZpn3VGff3h96RQtPHMI1nyNXMs
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

when you try to build kernel with

   CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
   # CONFIG_IIO_TRIGGERED_BUFFER is not set

build will fail with

> ERROR: modpost: "iio_triggered_buffer_cleanup" [drivers/iio/common/hid-=
sensors/hid-sensor-trigger.ko] undefined!
> ERROR: modpost: "iio_triggered_buffer_setup" [drivers/iio/common/hid-se=
nsors/hid-sensor-trigger.ko] undefined!

So CONFIG_HID_SENSOR_IIO_TRIGGER should depend on=20
CONFIG_IIO_TRIGGERED_BUFFER.

This was reported via https://bugs.gentoo.org/782496.


--=20
Regards,
Thomas Deutschmann / Gentoo Linux Developer
fpr: C4DD 695F A713 8F24 2AA1 5638 5849 7EE5 1D5D 74A5


--nbKOBoZZpn3VGff3h96RQtPHMI1nyNXMs--

--LamQn7TxeaejNiKQiIgNmsaFG2lCugZwo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEExKRzo+LDXJgXHuURObr3Jv2BVkFAmB2KnEFAwAAAAAACgkQRObr3Jv2BVnF
Swf/dVKY01vrgJge6nu+N/uhBmaVGq2ApVxD5p/cqkOO+gx4wTA1RZWr56J0Tx2Scj8TBMq0v5p9
e9LM8H2KG2JbfrCPuteid6RoBV4NWp1WlZ21QE/APpahzeB82CaNdt2vWr6hLwRqjBOwrKZmEcX8
0jXY4ud+tZIXHHv/J4mn6OO/mBqz3Zqd1TY7N0Rp/zyeRRiB2IaPlweXsyL3kmTBWU8m1prPOJKn
erPJ/x/lUk7pqZKbOKbupZyqX7yVLqYC7gPhFpKqzLVbVn/BTnZZfFiRn/pMDbArtlNwe/L3YnjT
E6xfrHBIw0keAV5q31SiPWQJBoT3QY6Zlc5TWDJ4jA==
=CfYo
-----END PGP SIGNATURE-----

--LamQn7TxeaejNiKQiIgNmsaFG2lCugZwo--
