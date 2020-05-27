Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2351E4EA9
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 21:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgE0Tzo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 15:55:44 -0400
Received: from mout.web.de ([217.72.192.78]:54575 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgE0Tzn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 27 May 2020 15:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590609326;
        bh=T27Y2yQteWvALB9TWBmEGDpncjmBJToM5enDPLY97M4=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=oWBo2AeKQ0T4tf8R0ShJtASTriYjHT/iGZDV0UZGMaqs8C7f5a/vTVD17FdkxZwQr
         nETia10MflJBv7QB5P00hZyifitxCZZfPFLbr3QGhedZ0qTcYKKKcJ6ZUaCV17lfUz
         yh263VK4ok6WfbF+xr0gbCxk32JmOyoUEiDEFmeA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.185.253]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MNfU1-1jOJmP37Dn-00PHcm; Wed, 27
 May 2020 21:55:26 +0200
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: mma8452: Add missed iio_device_unregister() call in
 mma8452_probe()
To:     Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <818d7c1b-ab4f-f254-3ada-99fed5108f3f@web.de>
Date:   Wed, 27 May 2020 21:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dWosoVVMgHrU1/OcGJVy3BR/wd8A20C6qrQ/RgJSMltLjpE92aF
 qmklttNpu4MHsF4+FQ8LtcXWsOjieiTDELQ85oohY0+8RCrc/eZ5IDsAtL4+++steEindqW
 0Eqqnxvn0I00EhWIbwnZf1Au953Lql5xOGeutZMYNHE9d9xvL3kkdcwIpnv5IHyckf31BFd
 8Pce4o77wz4jTmHL2Z+lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2nDIr+8TVEQ=:gN8PC1+3hrrbr5e/esmdIX
 54Qw5nGK5CNGG9TK81D9m5NGc2bQBb1oLEgdbgfs6s1IKA/LULy2hvUSkwOGJhA0vQtHi4xj+
 BC5FJ1YyR2lFaEEGif/5pTqnCtZvXtkidNH4ttrKjDFLXLcFicBLYwiR5XYipxDkLbXJcHt0V
 JygQQYbUaucyndgkao0Mk+b1IGDzGQcPmf0hBGxMX9XGazuI1PtqGHiEAaPYivCG56fFyFk8m
 SaKFrNBKtOv4IYqhdRYXm9OjAc6GRUOgqhNooim9/sg1E9dvpoLuemoI6KKS0ygJlAkuqhPZG
 tJneLHCHT0bkvGYNpcSM+FY7/nWe5cE/baFHHeih9+5+V5AZGp89lI27nv3KEFoDYLzNGGQaN
 /ajU+JLow1Bn5zLkRJ56r3nsJR5snC7GJaw1wvx0c2NLopurQAlCZBDrj5VdeGHYWTsf4HBky
 kCoc0myq6elxcylFWr6H9x7yWWbhcajT5Qykdub09ojmNlxEMzvMLBXprXmQI5oeDnlo8XpuC
 6m5SGf0BMwTyvUdJuoFh3mtbcMIlxc8F9EdmfNNbVztN2uSEMrTSSC4KXxmKqY6CZltFyvp/g
 K2/W1NuInlkmksN1V47Hir45OLsqEGQBiafdyjT+p8kAtnCg44xSqTvBnbUSkAsdz+AlMGEPD
 lSs/eMItHIayyreGuej6GA2qev/Ov3yrEPKu6+RJqbtW1kGIux4w8dUj2yVitOa8Li2UPBTZ9
 UGNnenird1zmqiBzNY4EX4QiFm4XDFI8aexf4onucfOBLtdAqMMDpL4gho1pVdqB3Bns5fIb9
 CGN6lkHEITaaYPDY9u5xpr55DWPVtVZylUhpHru2kwtMhGo8CQ529lKKOTfAE3iVhklPn5Wwb
 F9tW0zdNYGmnIgWJlraTh6tNKq+PpQgwHPPdvWwIJB1Z7j6xo8WRlSAWnenrBbsIKlS3312xb
 31qh+qFdhtujWdm7YuYVqV16KQ0GmVg6VEXnC4k2vhfbJHhjvy5CnY8sJCi73x59S/PcHNVM6
 Maq2qaXVfMP0UI5BTo8OcwLE+dFXjznJoKnuBIzQK2ftellgo9WfYFG+nrSqCcd2lht/wImnP
 zS/2x1L4g/0cuWZZsMII6Rm0YeEIqjIObbR1atCJzV4Eemta2J7RiUi7Kqx4mxYHN/Z52GoTu
 HIPSX8Sz49/uOSnTINTNP9pyIPFK8cG/ToTW8P+4KXWy8GR+vPyOYMj7hdNnGaqbuTWxs1FcP
 y2CZf5Yh8pQusJviJ
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> mma8452_probe() calls iio_device_register() but misses to call
> iio_device_unregister() when probe fails.
> Add the missed call in error handler to fix it.

How do you think about a wording variant like the following?

   Change description:
   The function =E2=80=9Ciio_device_register=E2=80=9D was called here.
   But the function =E2=80=9Ciio_device_unregister=E2=80=9D was not called=
 after
   a call of the function =E2=80=9Cmma8452_set_freefall_mode=E2=80=9D fail=
ed.
   Thus add the missed function call for one error case.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
