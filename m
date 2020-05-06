Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F201C74E7
	for <lists+linux-iio@lfdr.de>; Wed,  6 May 2020 17:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgEFPal (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 May 2020 11:30:41 -0400
Received: from mout.web.de ([217.72.192.78]:59323 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgEFPak (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 May 2020 11:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588779007;
        bh=g+f6vfgQjmv7bJu4M4nmtheEmi9EEiHRE5sTU3DVh4I=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=WfjfTtHyboxlV1ARE/Lbc933JbGwhTgN7YQEqgUJRyDoQUcgrz7NCSUpAYlKX+XHQ
         kIgAfIR1Uxirbf2uTEEY1q1nhth2C+MMhMFyaZZ352v0gjRnRgAzsfwLWBCuPtPt4a
         h3xDOLPWt7ezNnuGsID0Zz1JCRKwowkAD/77pfcc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.162.166]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKFD-1jn2pO1uV3-00Pcgn; Wed, 06
 May 2020 17:30:07 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] iio: sca3000: Remove an erroneous get_device() call in
 sca3000_read_data()
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org
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
Message-ID: <6e972e9b-c799-f0ad-91ac-144640b463f6@web.de>
Date:   Wed, 6 May 2020 17:30:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:h3zmFkgIB3nbx8qAW1Uo09U00WHf1PaFnapI95hJHMaBEy4ccGu
 VRNyLnXUOjhtzhmufHFTHZHL46NrvFP7d4gSVzCsbAaBPyAwitJ8g08nDDnzhHt4Mq9B6Z8
 JyYlpVcwn/v/x1UoVOnmQraKWER+vIXg35nb2nQP4P87yc0d8/PxB3tdaUnVQptVjBa2OjO
 3bx4Pt9Rv3gZFcULwxUrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OLQHm4Pv5vQ=:MNYLaEG0t4ubmGm5Phhxcm
 +a4Z89JnCPjqgZsl3isBC7OcA+j9ldHGv52nxiwdlDF+QMy0EwK+eJUbJZAJchXBDoXV9YZZG
 1yzH6/lK0q8DVMgJNSnCumzJxqIo8BebqTzgdpyiRa5hNntx13gldE4M/OCJR5KXgBbuy0csI
 DsCU9qy5vqA6gPoHciPjVjrKlgxG61qyN9hwLv/VnIRda0xtYoXVTKtRwqO5zokPpJOncUXdW
 OL+HFQRytEWr+KPbEM0PxpKfEbCddP2F85Tikt7u+ZqecEHTgBeDGlIKMLv2osnqeV7rXy7hx
 eKqaKNWlrYOqt0JO+0yxeqr6HXciCEXnCKPoghqw9YwBFhXxUscShbku3cjp0iTJtrCD3fPy+
 KCv6ql/K/Fg3Wl5tdopQIL0n9SMers8677fsduKvR6gM0usWlYwRha1pc8NGXcdF5PINRZ8tA
 w/MYWHdrRZ24ZjiVNzCudkCJlp9DBCxFQ3Uy5O6xps8EiTYFhbOsDhNa+ZGwJ+GZ2zIHYG/Oy
 y/i63mgWA8J9Kmqoz2MX66CzSJKQlnGsXnCL1qgyZG/G76aoTCnEzonE5vfEkLUye5rM9pJ1s
 K3OQtij4Dn00eT+aDCs34UTVTsQplFipJiQTZdk0fCTvrzGd29uREt4qZIeQZX7knc9dpTf2Y
 bUs+oGrMW/SbsSkJir1mcVw1pznfXP60GcHK9a0gwKKN5WOx/kDo85UYVv3PYKwDUkkFKyCgf
 7qGb4I5Bri0EXc/1xGNla5JAvNVhD0APM6uj/KQyhVBb1yof8gWFOY0mEGz0sz2asc/jlEsWX
 tXjgpcgICHIlqyYqeWYb0+/Nti7+RH98TMO7+WF7Nf7USxP2xuzuo2za1HhqhE2RZWyJ+e/Ag
 ci5qQmuiAQnsbRspp4u/OOaNzvQjQj5YgMw/GXRz/gnmZb+1o2My5n8EnmZHQ+wXeFBuRPaFC
 Xb4bNjnBfP9zqXMXvVaMcY3aqAOM9cujHNjiLchhWA7bpkmDF4RY9rdKclxotI1JPhE/2Z67W
 8X8KMwbKqSJ7Qv8meyP1MJxUmbxyhiD/+k6fi7Dt8Ij4P2yMRDMk9sN1sSWrHh6W8jS42IZTH
 vAnXRlSptAR0fzmKaRB57V/S8RGuB2W5CPGqItsXtW1xyk5M7KWlX3x+ISsjy6U8bndU0D1po
 D72pE5G1fdJQNkFxGDNzncsX7hphR63mg9pz16rRJ/p/h4pQo8i0LYxkmRrXEiddQsZ6wyWIQ
 oclfZBlKB16qXkZ5Y
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> This looks really unusual to have a 'get_device()' hidden in a 'dev_err()' call.

Is there a need to prevent similar function calls by the means of
advanced source code analysis?

Regards,
Markus
