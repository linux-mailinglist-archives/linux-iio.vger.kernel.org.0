Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9ED1A093A
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDGIUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 04:20:46 -0400
Received: from mout.web.de ([217.72.192.78]:40545 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgDGIUq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Apr 2020 04:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586247638;
        bh=axDv8zIhXE7bsjbz/f1ODbZWUdk+z3gkTTq0sfunDd8=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Rv6t0CkD1heypLf+VI3RG0rXc2+oyCcwngbxRGCyrhMeofwrV0ICtrsC06a/yrMxl
         evtKTbK4/K6PDwCGxerJbAJ8NIgCuAdTu6WT387F2uIfUgU08tiHhCZ/khybHoCkhm
         ecxinLYOWoit0aN91aQ2xW9D8bPBmB+nFIMqlp4I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.5.104]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lo0V2-1iorYk1mem-00fyoa; Tue, 07
 Apr 2020 10:20:38 +0200
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: move 'indio_dev->info' null check first
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
Message-ID: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
Date:   Tue, 7 Apr 2020 10:20:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aHOrZ7W7oehiuXC+BmesoutQg3MIGnbgyZ4wMISjdGAa2gj0zQM
 Gfh8Rt5ebQ4+E1TcW8C5kTZjKfyiEwzqdQeonY3GJKvrsLotwk6gS673PYLTTt5G7XLtXDN
 OUdFLMCJDvUoS7xkgelLHZ2+gaiAA69PoGyHpDiAxVUe86sqnFP0Yb0FZwDxKpZycslZYI3
 rvjPr9hOkPKBwcG3fig4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IjsO9saZrLc=:HgBVfaxwtJVLHi/x3sjz/P
 DAjgT52cEVu7cVBXYd9thuhnxYieM01UXMrtK44opiKNoFI5TMB5joN3ucxX5REDqZh0RyjBC
 YCU6PvON4wDgAM1uyZLYR6q2x6GJvhDxjiZDqqOpnrdxY0JhNnyyNnf2jXXmRAldFtTa5JRDm
 pqOxekv+j3zj+OPgXkY91bSWjaF5XXgqvRDBOi7pjscHvJW8T9VwS1FKVhbuQG/s3eb36fLCU
 2RDSgDXw9BeTBSwKSlQzc8voYf+gVRqv/p8+RcR1AZnwEBHlGb4ytNYpGE3DMSrzpnNsBn8sA
 1Br3FwMd5s8NU59az97m8G3pzf1BnZ6Q+mg/SuaYx0XrDDAldKU11QoxCvnG1kWBoRhO50IcR
 BTD6B4nUc9Uxo+SG/CgMQbKWO4U14MDdbNWEEo/j94O0zsSwoZkygEnoewI+sDjg0bRJp77zl
 ZSB/VocwARZtPxqPzUqASfbjd8bv3ruAbjihej71VGV1dJXA2+sDfcOfeZhHepCJkIarPuIBv
 Htvr2/ZSl+CH5WBlAhrbAXEzCoZ5jtpfz+w5ThTMwwSs4oTwBy8FtpnRwQidzMj4EQs8ejtTs
 t7/cDnt8W9DlnMQ4zJ/96zFVVMyQkM1HENIw1SCuBOSPIMPkAuN+6P+UsrVqefk4PHmt2048f
 zlGh3FEXsUlx7vowCXiG1nAV3kj+h/5PJ9PwIBvXmnQWWQOsnTPLVb0ZlHX2hwmo+09ZEa3eM
 wgnI+rqrockR5c9zLYKqjwo8Ehx2B7qft3W0UOeiDwAsFf8gsApqqgAP3ANotl5cuCxIQVNpu
 +CtIycP66FKGwwgHOorVenSgS5+oRswBzhiGs5TAGFhg48WSiac9O7+6O+0+xqqR6LsddXUXV
 2zORQrIHXkoS52GcEUtsp1HS69J8K8aQXNY7N7MddKyOkPnQNsipckAT9ZPSAYKpdHJe1y/uq
 ykt0POpn+c5Wu0I0xKOcmKaJVsygka+UNLJKKvkZFjZp8Qyj7gAXOvHCq++TOOJ4xInRolM3e
 vVJNO0FL8iM0y2devuqZzSSmvyRW/rTYaqpJWD6cHn94YP1HBl/tcfWNAPqPAad6kv1kSLt+u
 DTaoSucDDi4VpmLSWpoaA9skPYHCwfQNjoY65ZQk/z419wZBLpC1Ie6thKbaYPMPTD/1oX/X3
 I/5kCBpDc0ICOuDsOC4hGlDFoDuLuOvG1raXqqgyiMx7P2FxAUS5N7DHLQoKah76f6Q1fn0hs
 oPzbTVM2rc8j8EKG0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Doesn't fix anything.

Would the change description be nicer without this sentence?


> Just moves this =E2=80=A6

I suggest to choose an imperative wording.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D7e63420847ae5f1036e4f7c42f=
0b3282e73efbc2#n151

Regards,
Markus
