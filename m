Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E92F6197689
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgC3Idy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 04:33:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:53923 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgC3Idx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 04:33:53 -0400
Received: from envy ([87.123.107.212]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MHoAg-1jXf2D0Va2-00ErkA; Mon, 30
 Mar 2020 10:33:39 +0200
Message-ID: <048ceb3ded2c8a4b7063b6ac1ad1605f569e9057.camel@richard-neumann.de>
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
From:   Richard Neumann <mail@richard-neumann.de>
To:     Sandeep Singh <Sandeep.Singh@amd.com>
Cc:     Shyam-sundar.S-k@amd.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com
Date:   Mon, 30 Mar 2020 10:33:36 +0200
In-Reply-To: <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
         <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-xu5K+B2HpkD7ANo/1hwE"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:52KXuA9Wvi9SCX4EGMAd8VUk0U6to71d4Rv1xC3zOrH/eUBgM6d
 rubt419lNrvV64sQ8ADhqX8lLgUhLG5+reVBNdwqpXoiBmBhJy+VLlLzI3s7SA00A7a1G4g
 XRJP00bc1JFP1IzLvr9j2/AIaeRhJyAtx1QbPfbVDWKpg6iRSHOe2zhEl4LsiQo9pVKP3WJ
 Jl0E86KjVkfWtdgR08Rnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UdRSUDvqg+E=:a4udqGZ7gYdKz1amxMLmrI
 In8dWEa5RVpMKM0Xqd/5SQqLUKZBVKjc4A5Zl9JxCUd26s0OMG65qUBhvKqjnB8ka8B9clKEt
 yJO/+RKkKEZL5emq2Qxu0XWJQIsXjrr6FM010e2nj/1oqi6HQgkD7EvywBecUf4h9oY6Pj1BG
 34QNdbNTS263V220Lc/zBEKPw/Q3USrOSxyW335ONgID61xIc/W0GNHcHkwarpqzIpWH3F+jW
 dTSFBHYwu/w2eT3XzgcCUvm9D0Sp6c14h3N/BM9aP0BLSuATKMRSeRh6A9VUBlVto3uTtfEa2
 8ITsLLSomYNO5z1vMYNf+16Ehg2U6K29cF3yXKIRbY0FqDMnIMt+fpIoG89sOHW5YCvSvjFvd
 yXInm4/6Xh49j6GmiKnLJXpKl1OcpmzK+JsSBFGhm1cAzocnVpSW8mTQihi04fZ5YNa8JM2tm
 GHRm93DwSQ5HQjS+Gb6j783luRs7oUbDEk1jrz8CP/hM/Zo+heNfb3kDAsHjrPV/8p/Pdu1nO
 cKXxT69KKhfnuxEcBhNcg8w3OjToHaJdFv5OWsjNUSv4/rgpQSMCtN4lR8Fjq3/IhACpb5kUU
 cyCQL2cJPjgqRZ7AKLupFy8whojN0dmq3hLigS6IuDJOQyc5csd8pw3z+ITAYO8Ras9kEdWKa
 TWhG33aue4juxx2HrjQ9bUX2gLMpbhyl1/Rp+KK9wQUikySwI6ICh84p8ll/dxoZYyyedg5wW
 THO29loPZZga3fm0/i8W2bwy5oCT193lvXX2hcnLyj5QFAJb55Y2i8rvIjGHbeiRi5Ft1nnVz
 o3EcBcjmnTjIt+A+uEhCn6nAmvV4rbpL4JIF04U4lE0cztzpltiCyrEx31MW0vsWRRw8Mds
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--=-xu5K+B2HpkD7ANo/1hwE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I took some time testing the patch series on my HP ENVY x360 13-
ag0005ng with a Ryzen 5 2500U.
On my machine the readout of register AMD_P2C_MSG3 (0x1068C) always
comes back as zero (0x0) and thusly activestatus will be zero as well.
Consequently the bistmask (0x0) will not match any sensor types.
I came up with a patch [1] on top of this patch series to add module
parameters to be able to statically enable the different sensors.
If I load the module with "force_accel=3D1" I get a working accelerometer
HID device and working screen rotation through iio-sensor-proxy. This
only works so far, if I boot the kernel with "amd_iommu=3Doff", which
seems to be a general issue with this driver [2],[3].

[1] https://gist.githubusercontent.com/conqp/e8a0793406fbe7c9714f01f3078ea3=
3a/raw/ac2de743e68d1dd90430e57cb28df8c1dc5d1098/amd-sfh.patch
[2] https://bbs.archlinux.org/viewtopic.php?id=3D253058
[3] https://bbs.archlinux.org/viewtopic.php?id=3D252815



--=-xu5K+B2HpkD7ANo/1hwE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT62wKwhMqSt8WaustMqNUjvThq9wUCXoGu4AAKCRBMqNUjvThq
90CcAP42tzB5p8epHWyLk2ibq8kfLGKbQECKP4upjJ7Y0q0llAEAvBpxLho8wZLp
c57ghnyWscdAxbchldW7RQ4GVjX+DAs=
=l8Eg
-----END PGP SIGNATURE-----

--=-xu5K+B2HpkD7ANo/1hwE--

