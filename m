Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D67C1A0A02
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgDGJ0Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 05:26:25 -0400
Received: from mout.web.de ([217.72.192.78]:36717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgDGJ0Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Apr 2020 05:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586251565;
        bh=PVP/PwT3okYgBTOE2hskX3+DfyvmwWuNY9KgVJPQSF0=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=eHPnfIbQ+x2RtKyKsB3R1/H7WgmYmGtTHEvhbBkjj5AFZioUCUhgX6DMKCOy14Krj
         Rm68TbEX17GdF0Pic37zW5pHnlKY7G5Egx2GBO2hj5PbfH6x3yy18t/I6/MeWFOhXh
         QWhYc+OPQ3gnPUC8HwtDTuDj0whTf5+lqv1Me7lE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.5.104]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LvSPv-1jDsJL3gUF-010e8x; Tue, 07
 Apr 2020 11:26:05 +0200
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/3] iio: make use of iio_device_attach_kfifo_buffer()
 where straightforward
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <36669e0f-c41c-5cc8-7218-be5cad5cf8a5@web.de>
Date:   Tue, 7 Apr 2020 11:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OyrW4qWnk2pU3f5huI2LSlzLsOAAJJbK6kHVm+iMocBiEWY0g/g
 dT6JRmYXDBaBDJWhP3cuiFC9WDn9Gbrne9uukXs2yOcKtjVcW6tMGWnxtTSROo1Em822WZ/
 O9jLc7PlSrv3n/ydZNs19DIpnIbFpZJZ5DmBi/Y8AmApyc8LPUK7bov532zpwM36SlqlMN2
 gdnxd0qcHN/2Q+bneKn7w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AXf/A644imo=:Tb39wfjNQTwM2/QyBctB4V
 jXlbgzzlIeKjeh2aWJ++UjTC7r2+RPl2F1bhuPKdxJdNY/LvmN0TDIdxIo4CUo0MlHgfmNL9b
 cB1pEnbzQ/YmBrrewq+qGthWzwX/tegxh3/DrTwvg4Va1Zwm8XALV1blpaoIpfX74RdecxRy/
 3L5zxx3bEIGG4SzFjBc6wloQ+PQZZ1ksPooXfip/Y6hemSNMb/ZJBgYBd6OGsHokD+3skTisR
 1B6dDaPASVPKrr9+MFThX6PXkdaZ5qkApEH1g2Ufq50pnHgw7ZLB/3AJ1i+C5oKWqbwZqlv3X
 iUjZ114r99xrTohUUCnYr3GtPdIo6icLSpU9xGMVMZkaclv104EnZsO6YjfPtgt3p8TEm47bj
 LaLZCjq/mZLxAkmVDvnjrGMG/NoVKuHyLOqzZemgsPtMutSe4Zl0ddbQTml32YGFVdNuf+3bM
 LTQ/0Tti8gKmdHnGj8JusIHxf+G8jFWRY+dqzbdLlwkUFs1A2QrzHbwTIA+ht3u7bnCS/5gH/
 5DzsCAkfjTQLA5cqLCJ5S9hX1DNsVX3wYqhPccpvmlbOdTkENyUsj4UL2kq+u/jQDglt8FAVT
 OA+/pV1EwIatevIDLTcZZ2I6HZTI5ZobAtrdT2EeVAUvwVFlYujg9ZqR4gekgjLaUlPYUioQ0
 e6ZeTMELzkXLIVvnHutyBbKBNesvgoHxcAhU2qJMQof2wMT/iP3plFfFZ4lInSP6W6Mepvr7e
 RFYQ7nr+QJLL62aXuj7hS36PwFN3b/a9IUC/lKdzJo1s41OgYFXwOhRBcOh1RAizQs2wMXR+f
 4YAPKmzWnXGn+YAfnTsJ+GiEXiBe5gpsrA9KVHL97v5iFxxRj+fY6p2v++Ei3gqFDhbUJjl8i
 eCvXuQxEtBVfPFh05g64mNwozy7laK5P/TRfGJHN6R0L0wD4jYZw2cJNMz8NuR1qEGNWRLRbk
 Eteq2wUB1++k0E6YzAPIeIihuogoGwNLr6b+BCqqnasx4LHkcPujDCZ+VZ5HCOfjyJubjzAI4
 99GwdqrXIDLv/NNNQhhtyWyPA7JY66PjO+932r3txku8fGNWt1GijiPm5IdmxcYtXNOBUTril
 FkCo5Cj5UaeGKk61iFUtSgWaGVs0WgeA6k1abjsECAmFjv+d8CNVdqX5WgtJWBCjxGYCz86lE
 P1mb+kKwE4bOtYtkqFkHRLLdeF0ud2srT6mhB9vAUoPN4icLopaO/NIdN0wV+JCD4aIIQMnA8
 eGrrBhGfL6SAZIG7Y
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

How do you think about a patch subject like =E2=80=9Ciio: Increase use of =
iio_device_attach_kfifo_buffer()=E2=80=9D?


> This change does that.

I suggest to improve also this commit message.

* Would you like to consider a wording like =E2=80=9CConvert a specific fu=
nction call
  combination to a better programming interface.=E2=80=9D?

* Do you imagine any more software fine-tuning because of related
  collateral evolution?

Regards,
Markus
