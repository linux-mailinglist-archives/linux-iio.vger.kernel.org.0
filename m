Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471171E980E
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEaOGy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:06:54 -0400
Received: from mout.web.de ([212.227.15.4]:44701 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgEaOGx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590933980;
        bh=DxdIS954Ga9FjxgbahaPvGvimZTwhA0hHvbIIzkRjVQ=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=AcdDwdvvoWZi4cQPcYNYnbXWspUTc+E0NnQ5NfBj5ukn8RB+Omar9WZtTFHzH962B
         zmZQsGjDMOont4Q9MkHzGFCEOnr6iyLw3xaM5vbvRgkBLf9mxcVViHUszKWiIyJLOg
         eIwY8J3T+OEq1T8VpKepF/xpaPBDtDOiSYjmHTv8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.19.10]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MFL64-1jkqee2qEG-00EQDR; Sun, 31
 May 2020 16:06:20 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: magnetometer: ak8974: Fix runtime PM imbalance on
 error in ak8974_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org
Message-ID: <dd84c12f-277d-27e7-3727-4592e530e4ed@web.de>
Date:   Sun, 31 May 2020 16:06:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mwD1h5bMpJDwWo3VzgZwasVQKzBtC5x3uV3bVMn/+XimOeKhxnm
 TcmkijzkNZP0x66IfSSAJcvw8pygiaNT7ABZjT43yZgn1l6Rplhpgs15BpIY2luIASBDUvI
 9FKzb5lGMQUI2ST9qiYCetIoRt+UiCgYzml1QmyYuAuH/2cOrCtLARl3iH4q5y52RLfYfEF
 4eNHBUCsOjeldreV9x5pQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WvJU4xNNi6k=:7YOBk+wDXUg0trm0YKm+Mi
 7lLUbYPdhBvfny2WzKPt9iT7VhLNGJAHJeRTZazgWDma1Pc01i+QCAnAhncYZXR2g/4Pfud8H
 R1v0DxItmNqNsDRD5tA8EUKUH8huYqEPPiFrSE/ec31MkypIW/yz1jd/0t6nNIfjhOFINY7sm
 tbYkQma9yBa68jAQnyLeLovS9hSWjdK99I1pOUtqnnH8lmr7BjyjwXcgLhrohnUVl01cmbY/R
 pxWsC+aa38KqNrO/AKwIH2+5yl6Jo+RDJlDyeIKL1G6DEI6YPNqKfypT9y4Q7X7Onwcy2GNz4
 o8VuCTHoeetjNawLZpLnKE0jHCJk9ygnq5SPh4oZGMPzfBkjxhn9bxitkN0jW4n1Drzk4kcNQ
 hRQSslfFg5jOK2KgtpZKmpumeck35Rb7KHUdU1gizDSQygthaPv/YohuU5GDr8ppkRCRk1PdF
 PLFsjZmRggx15YkInePqYGlMnXSs2GehuTvsrxmnLZTfUHpYtgTE6IN5+qrRNBUt99BhpDcJZ
 uEMr/Ke0hfL0olNrB22ZM0L/91vKwYHna33La45s2RdWWqZyEQqDXIW+5gR572AjtsfnJAG6T
 jpZSwsnDmBsJbLo1z2Fb/Zkha8G30YOEafBH5JwH8u2AEUduZW/TSa7CVla9rtMPccdjc50Zo
 /q+vXOJSWdXGjIt+SOdDzhq56sbzBVam65U9FLDcWuPnvrA72ikrA5Ui1DJgMz7dcst5VmgMA
 +1Hx2y9yS2ewz2Xfzbpkqv0DjG1TfmmfxZ/eBgdQmzRvgLIZqizMBSFJyak5HRZaZn3XnNQJM
 jxU77qdyULkcJ/DbZsgRC8fvZY8U2uzqJLTnvuX1bh1CmOH2RYYdIZhnq4pFec9pDOoiKxHpu
 a5P5mqCQtRdVTalHcvZ/W3J5wvaYY1hXm5AlABj8zTp/qfaz+OjHGZZYbCShgY2A8ymhUhxbi
 BcAllLblthu57QyL1zpXni+Q+ryIfJo4TM9swvB9jRuv7AbIV4gkJBsQer6g8XNspHpab2HC/
 uhuJhG0KCYY2qOS+Ne4I9cANQHCAwQg/0j7z/EZwQor9iwNTB8LUg7o/5/OvLC794sRRf9ksR
 vtJ1xFs6MOqAs/xpHDiTP4DVVpiRP0tQFSlPE/LGL23nc4Qc+ph5oYJ0F4apogn5sZOQKu68k
 dPOE1kdzo0Infjc1quTqLd1Wwf23V7zjQsbYj7t4DLe/boFLTz12ApuDfweaAkQBYdrHfJ2Ze
 FvE8Ro1pS3G3Wf8Cs
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> When devm_regmap_init_i2c() returns an error code, a pairing
> runtime PM usage counter decrement is needed to keep the
> counter balanced.

How do you think about to replace the word =E2=80=9Cpairing=E2=80=9D by =
=E2=80=9Ccorresponding=E2=80=9D?


> For error paths after ak8974_set_power(),
> ak8974_detect() and ak8974_reset(), things are the same.

Will an other wording become more helpful than this information?


> However, When iio_triggered_buffer_setup() returns an error
> code, there will be two PM usgae counter decrements.

Please avoid two typos in this sentence.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?


=E2=80=A6
+++ b/drivers/iio/magnetometer/ak8974.c
=E2=80=A6
@@ -854,7 +856,6 @@  static int ak8974_probe(struct i2c_client *i2c,
=E2=80=A6

Can a source code variant like the following make sense
for a more complete exception handling?

power_off:
	ak8974_set_power(ak8974, AK8974_PWR_OFF);
put_pm:
	pm_runtime_put_noidle(&i2c->dev);
	pm_runtime_disable(&i2c->dev);
disable_regulator:
	regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
	return ret;


Regards,
Markus
