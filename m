Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D966AC9FC
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCFRZC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCFRYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:24:45 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837083A82;
        Mon,  6 Mar 2023 09:24:15 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3KY0-1qYSBu0EqI-010Jxc; Mon, 06 Mar 2023 18:23:12 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/8] ARM: dts: imx6ull: Add chargebyte Tarragon support
Date:   Mon,  6 Mar 2023 18:22:41 +0100
Message-Id: <20230306172249.74003-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7X3G3jIfDeolQi6iDz99jJ77T1hJ6MIzBoLP/VTGvpwuL7H+am6
 i4jpzJZ+tJ1+9IJ0NWg9+L9a/eL+NIdTe6xSEUVZqrHjGaIqrCndO/l7+gMKBo5pXdqjbfI
 SvadKtkiC6z51w9fjaukEJYchDbTKMR4lQtsvJ1OsLxJkD9T/MXw3JTywK89H8qeDRw5J7l
 WrZDBj+iqz/RhEAfMPo2g==
UI-OutboundReport: notjunk:1;M01:P0:biCDQeY6+Jo=;1X6prIbhiEw2GYPBvslN2bHlYBP
 GkhTcJQIw+3yCzCEaDo6uwutJkOSOpar09JxGwC8XVzd4r3yAEPOYT2u/EUtJ3jzv5fpBWFa8
 qohA47qvUI9g/sb572uWSP8wHkuNJZmL3GS0VkLtQniXLC0cQ4IglHJiGExdD45qzy0Ydhsmv
 iU71YHrv/R8jCMvpOZ9hDP8n9UfqW8FSI23XCsJaB0AWSXImmSy1SwW3mAimIEW4D7cU8OZwA
 GsfmYH4vfpr9vDS4jUDYUifzSNp/r3jwCXcGgGHSMhNW9huSAX6Rf9La4aosYKuAGWpXPXl0P
 HdpDYMOgFOk+Qvte9kGxtO2FrOxTV84fQeAE6ye89s4jz4P8JScBtXvjrkw7n6/cZFq/dzUoY
 W6WDtZVtbpMfJdLGKiKntnuqu3hzX76h00YpEojAEwLU9Woxi31+Z+xyfNR+mRhVjlf0gO++W
 jOiugNjVpBE6W+7p7kk2QMwuNB2DMc1NeLm4Q+0+DW0KucZ/oK+EhNi1xPNVFd+8PehIpVqmp
 RGpabjmpit1hA9jSlzfrn+zmm+XCd7mwyjUAjTLhWE+EG63BzDyAFp3ihOb72vXMa99HRyeR+
 2lxPhFTqnvfWcvlRNuIsMyTSE2sbH3IVP4dxlj90Lu3T+CpETlyEkb7X6vPuLK+SUZgIPCI7o
 zFdRifosFGflTS276kmmbH2e3oSdrmBscYbv1DgGtw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds the support for chargebyte Tarragon, which is an Electrical
Vehicle Supply Equipment (EVSE) for AC charging stations
(according to IEC 61851, ISO 15118).

The Tarragon board is based on an i.MX6ULL SoC and is available in
4 variants (Master, Slave, SlaveXT, Micro), which provide more or
less peripherals.

Supported features:
  * 512 MB DDR RAM
  * eMMC
  * Debug UART
  * 100 Mbit Ethernet
  * USB 2.0 Host interface
  * Powerline communication (QCA700x)
  * 2x RS485
  * Digital in- and outputs (12 V)
  * One-Wire master for external temp sensors
  * 2x relay outputs
  * 2x motor interfaces
  
The Tarragon hardware is bundled with a charging stack under the name Charge Control C: 
https://chargebyte.com/products/charging-station-communication/charge-control-c

This series is rebased on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git?h=for-next

Stefan Wahren (8):
  dt-bindings: vendor-prefixes: add chargebyte
  dt-bindings: Add DS2482/DS2484 as trivial device
  w1: ds2482: add i2c id for ds2484
  dt-bindings: iio: st-sensors: Add IIS328DQ accelerometer
  iio: accel: add support for IIS328DQ variant
  dt-bindings: ARM: fsl: Add chargebyte Tarragon
  ARM: dts: imx6ull: Add chargebyte Tarragon support
  ARM: imx_v6_v7_defconfig: Enable Tarragon peripheral drivers

 .../devicetree/bindings/arm/fsl.yaml          |   9 +
 .../bindings/iio/st,st-sensors.yaml           |   1 +
 .../devicetree/bindings/trivial-devices.yaml  |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   4 +
 .../arm/boot/dts/imx6ull-tarragon-common.dtsi | 858 ++++++++++++++++++
 arch/arm/boot/dts/imx6ull-tarragon-master.dts |  82 ++
 arch/arm/boot/dts/imx6ull-tarragon-micro.dts  |  10 +
 arch/arm/boot/dts/imx6ull-tarragon-slave.dts  |  32 +
 .../arm/boot/dts/imx6ull-tarragon-slavext.dts |  64 ++
 arch/arm/configs/imx_v6_v7_defconfig          |   6 +
 drivers/iio/accel/st_accel.h                  |   1 +
 drivers/iio/accel/st_accel_core.c             |   1 +
 drivers/iio/accel/st_accel_i2c.c              |   5 +
 drivers/iio/accel/st_accel_spi.c              |   5 +
 drivers/w1/masters/ds2482.c                   |   1 +
 16 files changed, 1085 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-master.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-micro.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slave.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slavext.dts

-- 
2.34.1

