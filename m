Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C033E04A1
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhHDPqd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 11:46:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhHDPqd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 11:46:33 -0400
Received: from localhost ([31.220.117.74]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFbFW-1mMo4q39oM-00HAZQ; Wed, 04 Aug 2021 17:45:30 +0200
Date:   Wed, 4 Aug 2021 17:45:28 +0200
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
Subject: [PATCH v2 0/2] iio: chemical: Add support for sgp40 gas sensor
Message-ID: <20210804154526.GA3207@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:h1Ad/GJR8B0E6z5jsKRm1/B98CL151ul96gdS5ZJNAowTXJZm/1
 IaA5vjeJsNWMdyxQAWPfHG/m+1Heq+YxmpjJ1GmhfGVHgquBU2zAmrB5jy1VqJ0BYLShpa5
 aqtPfEP8ssjHrA/VRs3dYIpSvhMLoQ1EZvS3TI9s0tXD3qMOA6BTZUrWXQXtYh2j23xXEVd
 E+HWkANUp6+OIryeGJv7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FbfamShZD4I=:1RLz8ycCkdbfviYcUAmZbI
 SFvRmTvZWfKrDtmsR2d3JpfxDX5J/2XPgE2YUB1WcEITQkF3VkqRCfPNFZpHFaGI2Ton0RLw/
 snGi29zEhzs2ymxEUa+93aMK//vorQfUYq4Mhd7QLoF+uKcky1D5o+B6+AvZsgsM7HlrbuAJk
 uS/BWwDV9YCVPgpGh0ud0mgPSXA1ZO+X/dWj5rH8wwxA2qso+1gjXSHP6Ha3r0qqGQuCQ0zyZ
 6e2E3sGLEzGPvQvgq6nTOaLGJtbU5QWtiepZghnPSVmtQWgYdqdFn6pQY/bTdXwMeQut+Up9d
 2/p+axZi8dtrvhYQzNGOODyR2EBSvgLL/UCtZFTpIjW9ts6k+jqSc7x56bcClpmZTeWpy2VN3
 URY56ZwK2PmCw6A9EYMbCzKkeJ1eFgV5CMXLUoaYjksWqtI2Y9DMrtQGf6Gnp7fsALI/Gi5Ha
 zov0pBGMmcPJpOmIIGdEvddHVCPFx/ta5Au4+11jKr1nOCeZopH5ztcTgX15blP40AE41ROp2
 Um9p+41LdE2GPpnZQVTSExmR67rW54D5syfro9Xb6hCuvQi2MwsF8nHV2FhDZ1aZtj3U2fByr
 L9GMuCcVFz3suZHSTHd6MkvR8cNuAgsiAubO1DBn1epKiBHPowosZpQ3gucfH2R9lM5BP+5SQ
 7PoPz4Mf6qrgw4sJkidNmprLQtn5avRMbBGQFLaPJhFzIf6flhW+Xqq/x6V3qGI2yoMS52sxQ
 1OqSrTgQGwarQKSXH25YoMDuli/Jwi4ztn2to+2iOZ98ADwnxfXT1SZWPoJR7j1FC9ouWdpTM
 Pd1LmnlDzil/Y3XFkZQtRwnvEc9Ph3dsQ25nv4oR5C5aXBdS1yj58o9iJZ1P2YuasbEsJoG
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set adds support for sensirion sgp40 gas sensor.

Many thanks for the in-depth reviews, especially of Jonathan who triggered
some important improvements for v2:
- provide more precision for voc value; this in turn triggered the folling
  point:
- rework of e^x calculation with an optimization on the interesting range
  between e^(-6) and e^6
- restructure use of endian types
- use __packed structures for sent telegrams
- optimize usage of mutex
- optimize switch-cases
- replace attributes by read_raw() and write_raw() values
- add documentation in Documentation/ABI/testing/sysfs-bus-iio-sgp40 as
  well as in the source code

Andreas Klinger (2):
  dt-bindings: iio: chemical: Add trivial DT binding for sgp40
  iio: chemical: Add driver support for sgp40

 .../ABI/testing/sysfs-bus-iio-chemical-sgp40  |  31 ++
 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  11 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/sgp40.c                  | 372 ++++++++++++++++++
 6 files changed, 423 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 create mode 100644 drivers/iio/chemical/sgp40.c

-- 
2.20.1
