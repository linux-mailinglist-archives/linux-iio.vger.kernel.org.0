Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6F81ED5A3
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 20:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgFCSAo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 14:00:44 -0400
Received: from mout.web.de ([212.227.15.3]:55255 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgFCSAn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 14:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591207221;
        bh=GJusi8idCtodTa5iBClasST8g9pym/5nSPUMxZB+0TM=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=K92VQ9R/D+2u8PcOeu6iCngR+wLndUI2YCepWxrOPtd5XgqltIPrVgEBF78Em4AYq
         heCLPZbtNAlIlZeOBJaAIRU+Y10PsnXm+C2mI0rbY6jXwP/MDKEYdTx5V23YqeAj1P
         ymBg2qV5vpgPnBN9ScHttTvcO/Oq3md/1kLghPzc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYNkX-1jSyto0quH-00V8K9; Wed, 03
 Jun 2020 20:00:21 +0200
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: amplifiers: ad8366: Change devm_gpiod_get() to
 optional and add the missed check
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org
Message-ID: <893ced34-306c-b232-06c2-6cf741844b9c@web.de>
Date:   Wed, 3 Jun 2020 20:00:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a1aSg6kpUxeaY26faiXKzo3gS5tivTBNaOTlNuWrU/NRrSMK3vT
 2m55Oquq588o49DSiz4yaHoK8eSthGiiknh81xYz+7rkubfyU0s03+NCHcAi1EsTK0zPFvj
 GDDid6t6Mtb9KrLWNtgGE7AxOYarTcOON4/oxjvSfnzA7rHNBBwvzd+vWRBZz0kYObaDPMd
 D4oB5szzYAfK6kvTzNj5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FqIwFUu2X0g=:Q+CCBTIJQineTh1L8UrfDr
 RshA5FK0OotCkRxBK26yBsGbnZRocJTi7oxDVOQbyOfVWh+MF3l10FQJSfBD7WeuQnybQsKHW
 H851PCOXlqCSIf0XnuDWtUKdRSmIlsaw7ifdsYez9B8bwV79w8AWG5M2yPJzqnlYdH2g47Dh8
 4/W6yL4Mm0F114Qhsc/exvRkAwrD1CDbaHlgoAlFVQ41nxeZ6VvsIxWPYdwBSlkRwZ7MOO8w8
 MnCWvqrbiFK9QTqT+51rX2b910IWoYsykl7BhAr6gwLSrVDplP6PO08RIUnFqUtu+8K2QaOhZ
 jnVBeeUNn15lyI6YentxVc+axoNj7HEDjgCmH1+CsfhbjFCLiCvqZKL9cjyRAlhRtSKWnlu9o
 PMCU7vf0lAP8iqG1lNCT2R6ieFuBe8XmBBuyXdbv/PPJ7RMe/X8yMUiwDhpsLptvSvZimz22M
 NCXh0CN2QPzlKfZjErBlE0jy/ketv59JCVgvJ/c2wPRZ8r77Apje01TiCRz8hstta3/MLg2u0
 a0TOt26XSfk37jgsLXkm1ocnKhSZcfZdov1WG80scTjt95KCoaGKhcshKS/e/ZJuO31JCDEpO
 HAEKNYJ6Qfs39Z9jqYmnYp1pOE/nTngF0YL3aEY29/++65g3BMB65BGvIBe82LGSv+rHEMKXs
 TScXyUB4ZF8+t4c7iD0UD4+6OVpBD0x+J22XGMvwlznsrBJQWZ5X/Ysq/fV+x72+QNTg6iVNk
 Ry4hn52e2eONwdvHRTBJjmnoXchxry8gxGpw43yGGpTmhuTKoiZX4oBqsgfQ2TE6r+5Hy5Zvj
 3wD10z49P12yu+UptFvAW18HuPNDXw1aKraveDfwEVx2lipVhFL5jJGJcYJHS2f2tDCTgZdiK
 Jp5wSR1bjWFdvw9kISSGjkVd1EvEbGdJ0qcCkyy2pm1zh77Zy+WbrUsdw1AnUh2gSmNKDEulp
 Q3l+WoGpcxoIHLMKCNo/B9xGe8Ousn1hRJhJSWt1gSiU4PtRiIvBg+mQ+bj2wv1ZGeFqh4MiM
 0SX8ZKepxwNz3vkKZ3yQpthSo70Uns6ILHg3yTyrcBWpFAszEZTns1f/mD2WbcZ+yVe1GhxUY
 UNkJyUDRmKgCN3BkedxFLuBIOO0ajfPKmPUgKbopr9aDaFfuLNmudh7SQ1vudqnKGiNzPpSYH
 nYIDiOgLZRHjunzCEVXWbPz8BL/2IKDaXJJ6qSJ/GSK4EZXWLqkV8YjWq/3jW6tYZO+9tQk2j
 VE3RCzYoarzy7AGrG
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> Since if there is no GPIO, nothing happens, replace devm_gpiod_get()
> with devm_gpiod_get_optional().

=E2=80=A6
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -262,8 +262,12 @@  static int ad8366_probe(struct spi_device *spi)
=E2=80=A6
>  	case ID_HMC1119:
> -		st->reset_gpio =3D devm_gpiod_get(&spi->dev, "reset",
> +		st->reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
>  			GPIOD_OUT_HIGH);
=E2=80=A6

I suggest to choose an other source code formatting for this statement.

A)
+		st->reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset",
+							 GPIOD_OUT_HIGH);

B)
+		st->reset_gpio =3D devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OU=
T_HIGH);
-			GPIOD_OUT_HIGH);


Regards,
Markus
