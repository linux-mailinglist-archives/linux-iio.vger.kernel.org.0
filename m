Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622041A0C31
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDGKnG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 06:43:06 -0400
Received: from mout.web.de ([212.227.17.12]:58991 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGKnG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Apr 2020 06:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586256178;
        bh=Lwz20K2PQlUJwElQcUXwaqdqLmhJXaOB3spSCK9WlY8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=idmHcqYJLUGANk7KTjw8jUDsxeXLq0UE6JwiZ/qUdhN3JkU6ThlMSb8TbBuyQ/oa8
         /0KkPgYU2b2UOTCoRyYeSchEulSbMNuH4HTiz/VHjMNcDexpX6drr4a25i9wdyf6sl
         ZddLqiD0ECRUrHVvNzSwQbZs7aHcJn+a2Gyv99Gg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.5.104]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXYWA-1jpyHU1eFy-00WRmi; Tue, 07
 Apr 2020 12:42:58 +0200
Subject: Re: [v2] iio: core: move 'indio_dev->info' null check first
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
 <3725f882accda683815f04c0eff0bb36c285fe62.camel@analog.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <39d24c67-e83a-e414-e27e-041c7d5cea1a@web.de>
Date:   Tue, 7 Apr 2020 12:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3725f882accda683815f04c0eff0bb36c285fe62.camel@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:KuQ20lbOyIyixZ6Yyd+YFCymWtwQFOa6f9fRK78PDO3lNwCOPEw
 qmbuiKI/k/XXv9Dasju2eqXgsPxvCrA8MdWvfNcarSj2+NJCUOIvp7s1PdKkRgWGxZUvWZd
 eJLAZNCyVD8I7POB7R3H81vTqIo/B89ipzJpOsg8v/lVfhcisesDAxrdlgQeOQIrAYwek85
 u46RppbMfwhrxJXva9n4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FVaPRB/rBwo=:AkTnbXoa/CZyZfzOPjvLhN
 FgIIkhSatLBc9ehJAjNsb0pis2LKueUX+i65Wx/ZUKiHapj8z4C9hg4BT73uB+YdQ90sI5MDw
 +c+YvSa2qyBYACP93CIsjZqufC3wOl+n6FG3+yqCfGP2GArQrh09i3b5BZcGQ6PBUwEteUsby
 78hc078wmhYo157Zw1wDJJBbHDh93iwBjOCE3rNlAgiuNvbpWPcXlTB7yXS8iGUZH0V9jnMgC
 PfLueA5N/1d54TgZWwCdg9H7Hsx8IE7wsFMefufvIXLHOHKgOJAkUgBSwhy02xiuijCsJLZyN
 PG+JbjUpuF7GTPnogSY9Ss+MOHMikneIKFEfmqdTk1ur1fl8eiC/XyD1j6RzUi/6dqhf48ven
 3XvManYRa+9h9piKP+1b46636VfmGAPTGy3pUD/xpvYqWFt31DI0kY5UbTv+ZsoHLQJPEwpHX
 Gc4XjSUpZzMfxpuzH/xvDd09MAadGc+BRJ2gzDi4lOB8F0CAa/MgD30UX6QpjGwaJuungKQFA
 IbXcqEGegbX9bhKFWZTYhqBJKffcx97tpvCox4JwzZXWZ9Vp8yzv8/TT/X7IwPprceHKJEa/C
 2oKA6HQ+30ey3fP1+ij5PwHqFppwLqx+TpN+LrogkF4rkXpQtVS3zepRLLPDNhy0rAWzrSC/b
 Ro3t2Qf8e4R1er6CySWVEtPCyuGTmSRnxo410T985WhlXVLd+7lcDsbEQHfG3FZjjTsA4aSks
 AuzV9m4L7PZuIv7f2pB/ppFRUJJoafu0Et2q9oIHmkR29akanykftCM3YHPIj+dbpgjIVnOaF
 ceehIDSZb21dhDBiaF3ouN15c/3RmkI0VWmTVh5QTvqzkwZbdNgN/tDYecsYgOb+ePwMK8Nsz
 Sl2/mzF79t95uCJSPEq0UdGxCTGwSpQ0zVqhwKOLuSsLVBUFCD6plTLafcH/Kv2K2ZBBAWy9g
 CRVGMD0gAeYl8zsLnabRiDgSCsn9OBUo6I9fQ7LxuATCcsttMFPBiEUCDFfTKoKtbiC1rbl1+
 RPmFx2TgQReqpFb34EDOar48uXmm8oCaf7yXtviDDfUsg4hLEkVcZJ0k9O7MdlviqV93uJYPr
 5N7ZiplEO6xH/N7OgKKWAjcUSR/1wbLAdySeBgb872PznB89wN/MOhopmSxcyUVt/6IYmNAsQ
 imq/7pXIGcFB8XL9LHkVE7kt9iiVXMXnmuC86CDZUPKgYcTQ6BhJaLygzcQEJU84ENE7WlrIl
 s0w/9xcxqaHb9ImHS
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> So, over time I got the habit of mentioning 'Doesn't fix anything.'

I suggest to reconsider such information once more.
We come along different interpretations for remarkable software adjustments.


> if the patch doesn't fix anything.

Do you improve the input parameter validation a bit in principle here?

Regards,
Markus
