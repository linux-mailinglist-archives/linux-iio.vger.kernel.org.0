Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05093FFF8E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 08:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfKRHgM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 02:36:12 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:33485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRHgM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 02:36:12 -0500
Received: from localhost ([185.35.208.129]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McZfZ-1i176X30JB-00d0Tx; Mon, 18 Nov 2019 08:35:32 +0100
Date:   Mon, 18 Nov 2019 08:35:28 +0100
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
Subject: [PATCH v3 0/4] iio: add driver for ping))) and laserping sensors
Message-ID: <20191118073527.wvkduv6xhzlcs2ej@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:BNIeUh0JWEPz91tcfGuLyxjpapGREoDItWX8THwJQkhyf9xDupm
 LPwQAF9aOJPR+W4w3k+hRNrvKE8f8rWhjK+CIkM2dm+QB9wL8pTNGINXZkaG3GN4iJ2uR4g
 ZoGhiN4KO4uLmp9Y1BWuEUnq/tPG7eog47HJOT6ccdcs4a/V6TUEANibIsVweVLpdajALOz
 ZtPT70TPkWQYBaQClBp8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:usjuWYJLbeI=:pHCBPCvMY5zKwz1CeEtAJ5
 l/kowUEF087P+jfpgCY/uQ0ZOXgR7249Af2EOQlz0bz5WgxV7Q7ovw0BoXUijqFHErUpAqlx+
 l9i5+VZ+Uys5wj1lYbJ1TsALruZsblAJ2BsGIi/en54ThKuM2wLHcziNX7vF+PNl942knSlDp
 Vv4E8/X4buZ1xOaDgshCDCaJo0PRPdTU1z1S28DFZYMSZFuJU4Rjcs/BS5mSnZrvSjJ7YwYMW
 fXGmSJbJS6Zzyz+6VgH301X66Nx4VTA8bE+m8KBOkODD0SscuRppRob/ueLzvZsZy1dldk6ES
 ULVYYPpo55f+0cGIeJMQ45MJYWMqx4cc3gdxTBE0OuyL7nc4X5ZXM3WW5HS0QsGCv8v4L8mCx
 iccjpXL7H0ZffnoLlQxCX1Gcg7h9q2jM+8OAsIdgp2Ze4XUomH477TiC+35lka4Ce49xnOwH6
 TvQ/DsK9++2KIxaUmySb9Z6VZ7AQXtDCTVizJi6wmL2qmDWT7WsJKaRYCVL1+MrM7t/FafJY5
 /TXXxOZ8C4XiKv4yCA97nw6qbKAKPUu8ua7VTs+LAKv6rGc/lqNrxUKrlDeURFDPYAUK83XLm
 wC6I/GFzn3VskxJPB3zKzgbMSpcYTv9WMj4I5hc3RS26jEkOGDhGay4Wulr5UsK5DkavLexac
 G3k9KAyoU+qTT41A48YEMYQ4XlOi63SVR+YO0MSK0zcayFLb1117PAGp9Fbyl7W6zuYqVspOv
 6Zi0xdz8UCBWelxyanteS1xo2hIe5Ssukt+kSGGXSf66CZsG7Yahvq6LOpyYdXtOA0T4nAmf4
 dh8OfCRiGIE3dcAPGs2MiDqQNmFR5p8n8KiYVQXgi2nil3v5UgzoaM8R+hUhbeO02xmwz0UMt
 3sGapSVqiVgtSLyii5NuiknTmhx39QhOfRNDk/YHE=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for parallax PING))) and LaserPING sensors as
iio driver. The driver is derived from srf04 but the device is using only
one GPIO for both triggering and the echo.

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
 drivers/iio/proximity/ping.c                       | 333 +++++++++++++++++++++
 6 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
 create mode 100644 drivers/iio/proximity/ping.c

-- 
2.11.0
