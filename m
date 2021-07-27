Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B06F3D7B0C
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 18:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhG0QfK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 12:35:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhG0QfJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 12:35:09 -0400
Received: from localhost ([31.220.117.216]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkEdF-1mt08846i9-00kgys; Tue, 27 Jul 2021 18:34:18 +0200
Date:   Tue, 27 Jul 2021 18:34:15 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 0/2] iio: chemical: Add support for sgp40 gas sensor
Message-ID: <20210727163413.GA3443@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:C/YSvBQdaGPU9bz+jgjQYfZDMoQxo76X+/YJg/ueSAQBaYngbMU
 3qw5KN/te8CHm1AMI/ASvQbyvvQ+ZouwufQSS8Im5WyuKcI4wF/3n/ECG2ISbd3FX271sSL
 WM1bMNCcEH3w+zCULWm3zpeSj77m3orBQQlyLVpn1IZFjHBtXjTiVXv620ImI/XiGX57oaw
 +m/u5rY45taoB1ZdX31Fg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iY8RcQ6azWk=:kCC96cbNQ0TX5avKC36r87
 ouqGVGyzQoReS5E2aMNhcpP507sRHBudoEsrexXhqOhqEHBdxQph/z/beLFCh2gTgrwUcpxu2
 xd0+ujporPzUUUpvTt2Hkl+DN7+/nLyQxsMfQWePy9W81gJQqnm9osMTRt1QWnkhlbmNkXkJ4
 MipHLgkx7YRX4yoG5u0ROFbKadLPjZwmwPIF4LWsk+JCpyaQXCuiAR+FtmWsmiiZ7BfXpDAxZ
 jzRhk/zhaMpcur74o72ZzejsYVm5DIpJLmjEU3FZOdR3zE0c/ejtqZXHr54BwqjxCzI51R1wq
 aF9M3IMwN8MzZuc35Kz5dZ38EebYAEXl4NrmViXqbljh3mbtBKfN25r1HvI/RCqpCYlOi5AQE
 n3+gWDaVCewr7+ExZlcmF6Jre0EcDkwss6ZwS1J+Ku1iMWWOeE52ehXHZe1BQCSU7SHJyZEL3
 /xeoQP/8eJgJBEKExgeKFneIx6eywhhAmW2rODq/iR1QmmI6g1Rf1z+2bZmuJCOztjGkZ3Yzv
 PwrS06DPYdm57EbYxntwRvHsPwSC/Q5J87hBQ09A/fls64brpnjFk0+Ws71RTBrb79zS0gC99
 dMMukA2oyvmgOx5HnWxc/jA2JGyuuDwRxIzypvTFHLrj/r7PTzw2IXlapu6MDD1p9zrnPX4gU
 qKERiNA+ol563g7xz5rervXsR4xA1mKOiSv+JYTk29IZzef2iG9ISPyZ15Q4PSUMY1nFlkxFc
 9Stt62ST0bkwVheXIw1JbZ0VqQ39VXUx23LLw9/sJM+2u2FgVK9NqzSDgeslz6ak9zC69m1Xl
 ufEwLdVqMrlaTPMxOR0dWoyXaJJUVyRC3/jMejVW2sBsyh/wTRV2kQEc5gO7rlXQ5LNfPg8
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set adds support for sensirion sgp40 gas sensor.

Andreas Klinger (2):
  dt-bindings: iio: chemical: Add trivial DT binding for sgp40
  iio: chemical: Add driver support for sgp40

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   5 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sgp40.c                  | 413 ++++++++++++++++++
 5 files changed, 432 insertions(+)
 create mode 100644 drivers/iio/chemical/sgp40.c

-- 
2.20.1
