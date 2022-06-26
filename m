Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E40D55B1E4
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiFZMVI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiFZMVI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:21:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28060E029
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA013B80D64
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23894C341CA;
        Sun, 26 Jun 2022 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246063;
        bh=AplSmDtcKRzrJ9fC1hOJ49ScgEXhmy6Pf9AXSuT1tlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uc/RGINgiG7+4utlNIW0FCM5m/vOXzV9GFay5hyBXFJtY7s2M8riyiVTOJlnKrE8y
         qXMaHf+X6icsQPU6qVfR0Nh8R1VbvKqISHtPkkvKb9g3CJebkGYxtklNr31WAF/BQg
         7GkcODdIYppcuH/HYKsUl9RCQDKEZ7JJSCSj9OWYq52uoreZ0iASW8tGD/KWB/vV7e
         rtxjia82Ll26fM1bvLKY6r0Q6jchwLimvv+4oHxjG3dTmxUZTXblpUkNfqVS0lUfQD
         HhO6HYbpqMpla/EqgQcs+drT6dyTZfiMOSP5J9nxSgw6dkOi2+JjUG1LYZp8WcdTy5
         lxqF+2hz8nsTg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 17/17] RFC: iio: cdc: ad7746: Add roadtest
Date:   Sun, 26 Jun 2022 13:29:38 +0100
Message-Id: <20220626122938.582107-18-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The recent work to cleanup and migrate this driver out of staging
relied on using roadtest to verify that the various refactoring
and fixes did not cause any regressions.

Note I am far from an experienced python coder so a large part of
this exercise was to establish if roadtest was useful / usable
without that particular skill set.  Conclusion yes it is :)

Apologies for the code!

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../roadtest/tests/iio/cdc/__init__.py        |   0
 .../roadtest/roadtest/tests/iio/cdc/config    |   1 +
 .../roadtest/tests/iio/cdc/test_ad7746.py     | 323 ++++++++++++++++++
 3 files changed, 324 insertions(+)

diff --git a/tools/testing/roadtest/roadtest/tests/iio/cdc/__init__.py b/tools/testing/roadtest/roadtest/tests/iio/cdc/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/roadtest/roadtest/tests/iio/cdc/config b/tools/testing/roadtest/roadtest/tests/iio/cdc/config
new file mode 100644
index 000000000000..6e9397325918
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/cdc/config
@@ -0,0 +1 @@
+CONFIG_AD7746=m
diff --git a/tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py b/tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py
new file mode 100644
index 000000000000..60d75c0f4fe8
--- /dev/null
+++ b/tools/testing/roadtest/roadtest/tests/iio/cdc/test_ad7746.py
@@ -0,0 +1,323 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Based on test_vncl4010 Copyright Axis Communications AB
+# TODO
+# - Test read temperatures
+# - Test read capacitance
+#
+
+from typing import Any, Final
+
+from roadtest.backend.i2c import SMBusModel
+from roadtest.core.devicetree import DtFragment, DtVar
+from roadtest.core.hardware import Hardware
+from roadtest.core.suite import UMLTestCase
+from roadtest.core.modules import insmod, rmmod
+from roadtest.core.sysfs import (
+    I2CDriver,
+    read_float,
+    read_int,
+    read_str,
+    write_int,
+    write_str,
+)
+
+REG_STATUS: Final = 0x00
+REG_CAP_DATA_H: Final = 0x01
+REG_CAP_DATA_M: Final = 0x02
+REG_CAP_DATA_L: Final = 0x03
+REG_VT_DATA_H: Final = 0x04
+REG_VT_DATA_M: Final = 0x05
+REG_VT_DATA_L: Final = 0x06
+REG_CAP_SETUP: Final = 0x07
+REG_VT_SETUP: Final = 0x08
+REG_EXC_SETUP: Final = 0x09
+REG_CONFIG: Final = 0x0a
+REG_CAP_DAC_A: Final = 0x0b
+REG_CAP_DAC_B: Final = 0x0c
+REG_CAP_OFFSET_H: Final = 0x0d
+REG_CAP_OFFSET_L: Final = 0x0e
+REG_CAP_GAIN_H: Final = 0x0f
+REG_CAP_GAIN_L: Final = 0x10
+REG_VOLT_GAIN_H: Final = 0x11
+REG_VOLT_GAIN_L: Final = 0x12
+
+class AD7746(SMBusModel):
+    def __init__(self, **kwargs: Any) -> None:
+        super().__init__(regbytes=1, **kwargs)
+        self.regs = {
+            REG_STATUS: 0x07,
+            REG_CAP_DATA_H: 0x00,
+            REG_CAP_DATA_M: 0x00,
+            REG_CAP_DATA_L: 0x00,
+            REG_VT_DATA_H: 0x00,
+            REG_VT_DATA_M: 0x00,
+            REG_VT_DATA_L: 0x00,
+            REG_CAP_SETUP: 0x00,
+            REG_VT_SETUP: 0x00,
+            REG_EXC_SETUP: 0x03,
+            REG_CONFIG: 0xa0,
+            REG_CAP_DAC_A: 0x00,
+            REG_CAP_DAC_B: 0x00,
+            REG_CAP_OFFSET_H: 0x80,
+            REG_CAP_OFFSET_L: 0x00,
+            REG_CAP_GAIN_H: 0x00,
+            REG_CAP_GAIN_L: 0x00,
+            REG_VOLT_GAIN_H: 0x00,
+            REG_VOLT_GAIN_L: 0x00,
+        }
+
+    def reg_read(self, addr: int) -> int:
+        val = self.regs[addr]
+        return val;
+
+    def reg_write(self, addr: int, val: int) -> None:
+        assert addr in self.regs
+        assert addr not in ( REG_STATUS,
+                             REG_CAP_DATA_H, REG_CAP_DATA_M, REG_CAP_DATA_L,
+                             REG_VT_DATA_H, REG_VT_DATA_M, REG_VT_DATA_L )
+
+        self.regs[addr] = val
+
+    def inject(self, addr: int, val: int, mask : int = ~0) -> None:
+        old = self.regs[addr] & ~mask
+        new = old | (val & mask)
+        self.regs[addr] = new
+
+class TestAD7746(UMLTestCase):
+    dts = DtFragment(
+        src="""
+&i2c {
+    cdc@$addr$ {
+        compatible = "adi,ad7746";
+        reg = <0x$addr$>;
+    };
+};
+        """,
+        variables={
+            "addr": DtVar.I2C_ADDR,
+        },
+    )
+
+    @classmethod
+    def setUpClass(cls) -> None:
+        insmod("ad7746")
+
+    @classmethod
+    def tearDownClass(cls) -> None:
+        rmmod("ad7746")
+
+    def setUp(self) -> None:
+        self.driver = I2CDriver("ad7746")
+        self.hw = Hardware("i2c")
+        self.hw.load_model(AD7746)
+
+    def tearDown(self) -> None:
+        self.hw.close()
+
+    def read_attr(self, dev, type, attr, index, extend_name=None, default_val=0) -> float:
+        name_start = "iio:device0/in_" + type;
+        if extend_name is None:
+            try:
+                scale = read_float(dev.path / (name_start + str(index) + "_" + attr))
+            except:
+                try:
+                    scale = read_float(dev.path / (name_start + "_" + attr))
+                except:
+                    scale = default_val
+        if extend_name is not None:
+            try:
+                scale = read_float(dev.path / (name_start + str(index) + "_" + extend_name + "_" + attr))
+            except:
+                try:
+                    scale = read_float(dev.path / (name_start + str(index) +  "_" + attr))
+                except:
+                    try:
+                        scale = read_float(dev.path / (name_start + "_" + attr))
+                    except:
+                        scale = default_val
+
+        return scale
+
+    def test_scales(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            scale = self.read_attr(dev, "voltage", "scale", 0, default_val=1.0)
+            self.assertAlmostEqual(scale, 1170 / (1 << 23))
+            scale = self.read_attr(dev, "voltage", "scale", 1, "supply", default_val=1.0)
+            self.assertAlmostEqual(scale, 1170 * 6 / ( 1 << 23))
+            scale = self.read_attr(dev, "capacitance", "scale", 0, default_val=1.0)
+            self.assertEqual(scale, 0.000000488)
+
+    def test_read_avail(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            test = read_str(dev.path / "iio:device0/in_capacitance_sampling_frequency_available")
+            assert test == "91 84 50 26 16 13 11 9"
+            test = read_str(dev.path / "iio:device0/in_voltage_sampling_frequency_available")
+            assert test == "50 31 16 8", test
+
+    def test_read_channels(self) -> None:
+        with self.driver.bind(self.dts["addr"]) as dev:
+            testscale = 1170.0 / (1 << 23)
+            # Test endpoints and each of the bytes
+            testvals = (( 0x0, 0x0, 0x0, (-0x800000) * testscale),
+                        ( 0x0, 0x40, 0x0, (-0x800000 + 0x004000) * testscale),
+                        ( 0x80, 0x0, 0x0, (0x0) * testscale),
+                        ( 0x80, 0x0, 0x1, (0x1) * testscale),
+                        ( 0xff, 0xff, 0xff, (0x0 + 0x7fffff) * testscale),
+                        )
+            scale = self.read_attr(dev, "voltage", "scale", 0, default_val=1.0)
+            offset = self.read_attr(dev, "voltage", "offset", 0, default_val=0.0)
+
+            # Should really be testing that the voltage after application of
+            # scale and offset is correct, not raw values.
+            for h, m, l, testval in testvals:
+                # Sequence matters as we will only write registers if the change.
+                # Hence always proceed a vt read with a cap read and visa versa
+                read_int(dev.path / "iio:device0/in_capacitance0_raw")
+                # value is 24 bit and driver offsets it by -0x800000.
+                self.hw.inject(REG_VT_DATA_H, h)
+                self.hw.inject(REG_VT_DATA_M, m)
+                self.hw.inject(REG_VT_DATA_L, l)
+                value = read_int(dev.path / "iio:device0/in_voltage0_raw")
+                self.assertAlmostEqual((value + offset) * scale, testval, 4)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_VT_SETUP, 0x80 | 0x60)
+                #verify capacitance read disabled
+                cap_setup = mock.get_last_reg_write(REG_CAP_SETUP)
+                assert(not (cap_setup & 0x80))
+                mock.reset_mock()
+            testscale = 1170 * 6 / (1 << 23)
+            # Test endpoints and each of the bytes
+            testvals = (( 0x0, 0x0, 0x0, (-0x800000) * testscale),
+                        ( 0x0, 0x40, 0x0, (-0x800000 + 0x004000) * testscale),
+                        ( 0x80, 0x0, 0x0, (0x0) * testscale),
+                        ( 0x80, 0x0, 0x1, (0x1) * testscale),
+                        ( 0xff, 0xff, 0xff, (0x0 + 0x7fffff) * testscale),
+                        )
+            scale = self.read_attr(dev, "voltage", "scale", 1, "supply", default_val = 1.0)
+            for h, m, l, testval in testvals:
+                read_int(dev.path / "iio:device0/in_capacitance0_raw")
+                self.hw.inject(REG_VT_DATA_H, h)
+                self.hw.inject(REG_VT_DATA_M, m)
+                self.hw.inject(REG_VT_DATA_L, l)
+                value = read_int(dev.path/ "iio:device0/in_voltage1_supply_raw")
+                # Supply voltage channel is attenuated by x6
+                self.assertAlmostEqual((value + offset) * scale, testval, 4)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_VT_SETUP, 0x80 | 0x40)
+                #verify capacitance read disabled
+                cap_setup = mock.get_last_reg_write(REG_CAP_SETUP)
+                assert(not (cap_setup & 0x80))
+                mock.reset_mock()
+
+            # Only bother testing one of the temperature channels. They are very similar.
+            testvals = (( 0x0, 0x0, 0x0, (0/2048.0 - 4096) * 1000),
+                        ( 0x0, 0x40, 0x0, (0x004000/2048.0 - 4096) * 1000),
+                        ( 0x80, 0x0, 0x0, (0x800000/2048.0 - 4096) * 1000),
+                        ( 0x80, 0x0, 0x1, (0x800001/2048.0 - 4096) * 1000),
+                        ( 0xff, 0xff, 0xff, (0xffffff/2048.0 - 4096) * 1000),
+                        )
+            scale = self.read_attr(dev, "temp", "scale", 0, default_val = 1.0)
+            for h, m, l, testval in testvals:
+                read_int(dev.path / "iio:device0/in_capacitance0_raw")
+                self.hw.inject(REG_VT_DATA_H, h)
+                self.hw.inject(REG_VT_DATA_M, m)
+                self.hw.inject(REG_VT_DATA_L, l)
+                value = read_int(dev.path/ "iio:device0/in_temp0_raw")
+                self.assertAlmostEqual(value * scale, testval, 4)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_VT_SETUP, 0x80 | 0x00)
+                #verify capacitance read disabled
+                cap_setup = mock.get_last_reg_write(REG_CAP_SETUP)
+                assert(not (cap_setup & 0x80))
+                mock.reset_mock()
+
+            testscale = 0.000000488
+            # Test endpoints and each of the bytes
+            testvals = (( 0x0, 0x0, 0x0, (-0x800000) * testscale),
+                        ( 0x0, 0x40, 0x0, (-0x800000 + 0x004000) * testscale),
+                        ( 0x80, 0x0, 0x0, (0x0) * testscale),
+                        ( 0x80, 0x0, 0x1, (0x1) * testscale),
+                        ( 0xff, 0xff, 0xff, (0x0 + 0x7fffff) * testscale),
+                        )
+
+            scale = self.read_attr(dev, "capacitance", "scale", 0, default_val=1.0)
+            offset = 0.0 #self.read_attr(dev, "capacitance", "offset", 0, default_val=0.0)
+
+            # Should really be testing that the voltage after application of
+            # scale and offset is correct, not raw values.
+            for h, m, l, testval in testvals:
+                # Sequence matters as we will only write registers if the change.
+                # Hence always proceed a vt read with a cap read and visa versa
+                read_int(dev.path / "iio:device0/in_voltage0_raw")
+                # value is 24 bit and driver offsets it by -0x800000.
+                self.hw.inject(REG_CAP_DATA_H, h)
+                self.hw.inject(REG_CAP_DATA_M, m)
+                self.hw.inject(REG_CAP_DATA_L, l)
+                value = read_int(dev.path / "iio:device0/in_capacitance0_raw")
+                self.assertAlmostEqual((value + offset) * scale, testval, 9)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_CAP_SETUP, 0x80)
+                #verify capacitance read disabled
+                vt_setup = mock.get_last_reg_write(REG_VT_SETUP)
+                assert(not (vt_setup & 0x80))
+                mock.reset_mock()
+
+            scale = self.read_attr(dev, "capacitance", "scale", 1, default_val=1.0)
+            offset = 0.0 #self.read_attr(dev, "capacitance", "offset", 0, default_val=0.0)
+
+            # Should really be testing that the voltage after application of
+            # scale and offset is correct, not raw values.
+            for h, m, l, testval in testvals:
+                # Sequence matters as we will only write registers if the change.
+                # Hence always proceed a vt read with a cap read and visa versa
+                read_int(dev.path / "iio:device0/in_voltage0_raw")
+                # value is 24 bit and driver offsets it by -0x800000.
+                self.hw.inject(REG_CAP_DATA_H, h)
+                self.hw.inject(REG_CAP_DATA_M, m)
+                self.hw.inject(REG_CAP_DATA_L, l)
+                value = read_int(dev.path / "iio:device0/in_capacitance1_raw")
+                self.assertAlmostEqual((value + offset) * scale, testval, 9)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_CAP_SETUP, 0x80 | 0x40)
+                #verify capacitance read disabled
+                vt_setup = mock.get_last_reg_write(REG_VT_SETUP)
+                assert(not (vt_setup & 0x80))
+                mock.reset_mock()
+
+            # Should really be testing that the voltage after application of
+            # scale and offset is correct, not raw values.
+            for h, m, l, testval in testvals:
+                # Sequence matters as we will only write registers if the change.
+                # Hence always proceed a vt read with a cap read and visa versa
+                read_int(dev.path / "iio:device0/in_voltage0_raw")
+                # value is 24 bit and driver offsets it by -0x800000.
+                self.hw.inject(REG_CAP_DATA_H, h)
+                self.hw.inject(REG_CAP_DATA_M, m)
+                self.hw.inject(REG_CAP_DATA_L, l)
+                value = read_int(dev.path / "iio:device0/in_capacitance0-capacitance2_raw")
+                self.assertAlmostEqual((value + offset) * scale, testval, 9)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_CAP_SETUP, 0x80 | 0x20)
+                #verify capacitance read disabled
+                vt_setup = mock.get_last_reg_write(REG_VT_SETUP)
+                assert(not (vt_setup & 0x80))
+                mock.reset_mock()
+
+            # Should really be testing that the voltage after application of
+            # scale and offset is correct, not raw values.
+            for h, m, l, testval in testvals:
+                # Sequence matters as we will only write registers if the change.
+                # Hence always proceed a vt read with a cap read and visa versa
+                read_int(dev.path / "iio:device0/in_voltage0_raw")
+                # value is 24 bit and driver offsets it by -0x800000.
+                self.hw.inject(REG_CAP_DATA_H, h)
+                self.hw.inject(REG_CAP_DATA_M, m)
+                self.hw.inject(REG_CAP_DATA_L, l)
+                value = read_int(dev.path / "iio:device0/in_capacitance1-capacitance3_raw")
+                self.assertAlmostEqual((value + offset) * scale, testval, 9)
+                mock = self.hw.update_mock()
+                mock.assert_last_reg_write(self, REG_CAP_SETUP, 0x80 | 0x60)
+                #verify capacitance read disabled
+                vt_setup = mock.get_last_reg_write(REG_VT_SETUP)
+                assert(not (vt_setup & 0x80))
+                mock.reset_mock()
-- 
2.36.1

