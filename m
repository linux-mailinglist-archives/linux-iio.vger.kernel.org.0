Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68671089A7
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2019 09:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfKYIEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Nov 2019 03:04:35 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38495 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYIEf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2019 03:04:35 -0500
Received: from localhost ([212.237.170.26]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUpCz-1iQBAa365h-00Ql1O; Mon, 25 Nov 2019 09:03:58 +0100
Date:   Mon, 25 Nov 2019 09:03:49 +0100
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
Subject: [PATCH v4 0/4] iio: add driver for ping))) and laserping sensors
Message-ID: <20191125080344.qgmarbbhodtmn6ok@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:DO/bTDdpbdaLmAG7E73wEBlueTaourtYM/8zW/vN3q4paixmhrb
 WjjJnKVrnVp0tlwQJgv+YCQ2A0aBiAsYWlEhp1ZUyVgPUo6Pv0sj9XZ9cBc0a7kAkooZSRr
 iZgeiZVRB/jbhAmbqJS83NC0NHNP25haTRjXYc/Y2oD1QeMjkoUtMcJAPVT+2Krdlfsbunq
 n3ZNB07iOWR4S6gJ/z5cw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gvyi4oi+sLM=:ZlKpa8QxZD+dJ38hmQVp1r
 asUfM0qleqFwqBS5alciTXVMCujca1KDKFPhOcVbf5J6NSA37MJOHa4f0FYFc33RBEYloxB30
 hh6WjtSPS0kO4EjxtoG5QYM08IzDUBp8pYlWsA2opm4xrUx7J3hHVqEneNiBYBbCB9cFgP18Y
 5DkPBgIuJzdozyJIV/y2DHTYEQ8SuirjQTwr1kslxk4J0X6YdXThAzweNz8k0i5ioAm4o01lB
 Ofq23FxjC2GlNlxTGmGSjHbWLyow//SvipmBnTrvu0DLumBrsr6mkSmjXvwJ2QeG3uc3/Wl2F
 mwOYZwPps+Xwu5eLQEb5UQwH5Wt47eBlPj9W/uPsayOO+d4tZ2dLpWtiJ+A+royPqXKyPdQzY
 Cp7G/9n+xs/e23YMQJRSgOUUDQ3E4a1I4E/Io4o3qwrhW+m6GmW8nh808L42sH9oz5DTeU4pv
 dx9cJBFhVl2Bz5qZKYsGtmqEtvKtb1KEmt9T9yz5ARhgb9vy+bbgI2zWouTVtxlqAOqMeU1N5
 1Qy7c0RvYiZGqDrDdOTT1NRYZXwhDpRVPLfdgrtjpqG+a0cD/PFOfWt7EjPUTZE/HHEGwvJAO
 ifRdAUdkd3ndcPM19a4Aec2Nejk+hLIke+CF7LH4LJac0Gk3wrR4iMgHatutSTUSzfQrJiZId
 YcVSyDvvDPwnKjOlOSsKDuMBtKwX+y/H41Rs4B53S1ff5V9U1Pr8bZE/AjuNgGLOePK4k/y+9
 A+V9TFd9CJwPYIA8CMLRbMU68drxlubSPEVOpk4VfcNpXjcDYR+KPNbESA8RTVn3bjM1naLQm
 BI3RyTep1//n8Es9xphHZ+KZ042wEGwwSfDYdIZz9WEd2pCoWdTKdmALg+ACzKcZps9XNsz+3
 XmK8WVCeT0ojOfhUgrAg==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for parallax PING))) and LaserPING sensors as
iio driver. The driver is derived from srf04 but the device is using only
one GPIO for both triggering and the echo.

Only patch 3/4 is sent out this time because the others remain unchanged.

Changes in v4:
Thanks to Julia for reporting a bug:
- fix mutex handling in ping_read()

Changes in v3:
Thanks to Jonathan who found another bug there are two small changes:
- fix inconsistent use of devm_request_irq() and free_irq()
- hold mutex until free_irq() is called

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
 drivers/iio/proximity/ping.c                       | 335 +++++++++++++++++++++
 6 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
 create mode 100644 drivers/iio/proximity/ping.c

-- 
2.11.0
