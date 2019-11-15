Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA16FD732
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 08:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKOHoP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 02:44:15 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:47219 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfKOHoO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 02:44:14 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJW18-1iBf1w0gRM-00JsdN; Fri, 15 Nov 2019 08:43:40 +0100
Date:   Fri, 15 Nov 2019 08:43:35 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: add driver for ping))) and laserping sensors
Message-ID: <20191115074333.ria34nl64ehglalm@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:yi4wfJ1D0RO5zi4BC9BWjFJSWGZ1tCn16r5KjQCvokZQI7gAm/w
 nO+So/Kh0Z+H5nropCBZJert0CMmxL6irxZHH35aw/yiyHH8zSoipM9GRKlC2e+Ktd9Uw2Q
 HxuzEX03Hge+KHsWCq1dnN8dQKcuAFsExRhNT+lZRos2IelKh0T5c+4gJlyzTUtc+766Yy9
 p64wouzM6qfHE0oKLBA9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PR6qVSVfGMw=:M8ZrZ0qb7fwzaniaJOb4U+
 TbvBo0upRwU0QiYrpDknQXnWukozqMXOqKh1CxV9jB5HgU/Zv1JtisZ5M4bFHtyxuBMOLxCZX
 gy45lxo7CwE4OxIQxe9lZHfG9poQh35XATkPBt6PnoBvRlbecNj+NQ+uV5HXGdLz30d6Jlytk
 TSlUapKtsNk3vFBRpInHwLzplxbglqcijxzE+h/25iu89z5ruS3HOzp5zIfHzsh2Kt/jsnSSt
 vlS2ZLTdcToouPum40yj/k0ImbLXAgzc1QyTmXDuQ6yDvjfLwtEhkKPhBCjYaCUk2lfP7PPQm
 RwhN0NhLcK+LfSytcojXd86s/QyXM5/y8qdVNynPKBfrQXjKuhaPa3ebWP/SCcXlb+2BTQCwU
 HUm/OKxSUBZjHqEV/X2l2o7W05zqhucXxFpFKFJQM8Z7MQOPnDiffFiYwnPTYMTO7jWcEZle6
 AREHM4va0xI60TnVP7nAn9ynKSZ0TJtzl8YqYJZ8aImRd7P7WIRXlsXoS0XQGSWM2kLPrZ5w9
 9e9UJ+qWKJFjvC0AmqFs1bST8WRWA7OUr+5BKSWEfhuxEIU3U5DrZFJOZ327eZoU7Qr8nEGNT
 pOVoUuunPsEcfLBbzeBItWl35GD/UcJAzLU9fE7RrKTGm3Rmqug7dq1V/hLC7jmDXP5zK5/R8
 aOUaWMyCNLbjl3MknpJ1Jv/3jSlg9w+4ntTBGTI+lb4IO7qVgQW2+d3J19sfblUajIzFOlaaY
 sjMvvxbY230ySsLkSWpJMBaycGoGiNDjMHxVkm8R+/sKCnpOLpmggmoWj60qz8V0Gwcwfmxt0
 XaQjrlUetT5YPjBsSingPP1QHv6LAHBvdGoIYdYICxsaZ6II7qIbjfaxCaHGG3LT/UZe7gW0y
 JMtk0RJ2aBrqXrUVyGBQ==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for parallax PING))) and LaserPING sensors as
iio driver. The driver is derived from srf04 but the device is using only
one GPIO for both triggering and the echo.

Changes in v2:
Thanks to the reviews of Jonathan, Rob and Michel there are some
improvements:
- optimize use of macros with to_platform_device() and
  of_device_get_match_data()
- change spacing and typos
- simplify ascii art timing diagram
- merge patch for driver and corresponding Kconfig and Makefile

Andreas Klinger (4):
  dt-bindings: add vendor prefix parallax
  dt-bindings: add parallax ping sensors
  iio: ping: add parallax ping sensors
  MAINTAINERS: add maintainer for ping iio sensors

 .../bindings/iio/proximity/parallax-ping.yaml      |  51 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   7 +
 drivers/iio/proximity/Kconfig                      |  15 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/ping.c                       | 333 +++++++++++++++++++++
 6 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
 create mode 100644 drivers/iio/proximity/ping.c

-- 
2.11.0
