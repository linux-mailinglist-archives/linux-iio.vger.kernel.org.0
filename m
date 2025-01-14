Return-Path: <linux-iio+bounces-14351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F57BA10836
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 14:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF4D3A78A6
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535049625;
	Tue, 14 Jan 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ql1hvvsE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB917557;
	Tue, 14 Jan 2025 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862843; cv=none; b=bfkv4vEpJKO1PpYruf+1OFD58ARWFECPGIlLkMtgEDXDm3gEISsUTuGDht8KjlFFid+jsUqwOB5Cnm82D4byvW5gnDGapyn0vHpiAN90rCeg+YTWRKKnlqMhGeTlW/7kpPqeOEMz1g6jbgYUedEVdNX38rBjJNdUp96BXHfgQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862843; c=relaxed/simple;
	bh=IFt9bFY0Iqaoka1rqazzLtGpe5MwjYnf19jia1VjH5Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKhnfIFiwUEZJ1YFQs5XK+BpusV5tZf/aYlaDW9R0UtMo9AoDrGN3A6aLVpA7E01lx2LlYWmwy5OCz7CGBkyNNrnt4SZepvtqu527vqf50xX5Q3KoQI8TLOZFulC+gpLlmeDMmkW9q3ZqTSnj4QepV21MnSE0cEcLfGLCrmXRJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ql1hvvsE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E9OeKJ024418;
	Tue, 14 Jan 2025 08:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=K55O69zNlRAb8oawP8s8FEg5FT5
	Kqvut7JiLNyK9NzY=; b=Ql1hvvsE9vnkvLBFf06SzjSUCUHhMM/pX5OuCengWPR
	1Jpm05krSUwDwsmx1VpnwPwNVY93AHcbzvb17Sbw644NyEHBlz2ndzHTEHNvOgWC
	xIx5yt4bLIPEdt85/gPYg/LDqqruoU3lXQAWQTaoU8YHGM7aZja6Adnx4dPzdIck
	PsreUGVxKtk0xg5kHVtFK+ZhLhmtbGnQklHDRsCSHRemxuGtQGN9t/D5AuGfGKwR
	yIRorqvqqrz0Qs09RLgjkuIyWL3NfJ0Xh+maJ2NBzY/3G847zAOV5K48aPIn/dm3
	KsKCLaZkErkOBxXBKRqTb2lVOiw1PTXKHTVjCm2nTnw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 445n95gymt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 08:53:42 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50EDrfIc056979
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Jan 2025 08:53:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 14 Jan 2025 08:53:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 14 Jan 2025 08:53:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 14 Jan 2025 08:53:41 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50EDrS5d002499;
	Tue, 14 Jan 2025 08:53:31 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <corbet@lwn.net>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/1] Documentation: iio: Add ADC documentation
Date: Tue, 14 Jan 2025 10:53:27 -0300
Message-ID: <efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RN447Qwcx4z-WZFiRYBkGoOFkL0aAVU9
X-Proofpoint-ORIG-GUID: RN447Qwcx4z-WZFiRYBkGoOFkL0aAVU9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140112

ADCs can have different input configurations such that developers can get
confused when trying to model some of them into IIO channels.

For example, some differential ADCs can have their channels configured as
pseudo-differential channels. In that configuration, only one input
connects to the signal of interest as opposed to using two inputs of a
differential input configuration. Datasheets sometimes also refer to
pseudo-differential inputs as single-ended inputs even though they have
distinct physical configuration and measurement procedure. There has been
some previous discussion in the mailing list about pseudo-differential and
single-ended channels [1].

Documenting the many possible ADC channel configurations should provide two
benefits:
A) Consolidate the knowledge from [2] and from [1], and hopefully reduce
the reviewing time of forthcoming ADC drivers.
B) Help Linux developers figure out quicker how to better support
differential ADCs, specially those that can have channels configured as
pseudo-differential inputs.

Add documentation about common ADC characteristics and IIO support for them.

[1]: https://lore.kernel.org/linux-iio/0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.com/
[2]: https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2
- Split apart from AD4170 patch set.
- Added disclaimer paragraph about complex ADCs.
- Made the input type general description a bit more general, by adding
  `general` to the text.
- Changed `::` placement to be consistet in all sections.
- Improved Differential channels section with more precise explanation.
- Improved Differential Unipolar Channels section with comment about common
  mode voltage being described in dt as a voltage regulator.
- Removed -VREF from Pseudo-differential Unipolar diagram.
- Added comment about omitting `_offset` when IN- is at GND.
- Improved .rst formating with ``.

Link to v1: https://lore.kernel.org/linux-iio/48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com/


 Documentation/iio/iio_adc.rst | 290 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 291 insertions(+)
 create mode 100644 Documentation/iio/iio_adc.rst

diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.rst
new file mode 100644
index 000000000000..b9d30e732a61
--- /dev/null
+++ b/Documentation/iio/iio_adc.rst
@@ -0,0 +1,290 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+IIO Abstractions for ADCs
+=========================
+
+1. Overview
+===========
+
+The IIO subsystem supports many Analog to Digital Converters (ADCs). Some ADCs
+have features and characteristics that are supported in specific ways by IIO
+device drivers. This documentation describes common ADC features and explains
+how they are (should be?) supported by the IIO subsystem.
+
+1. ADC Channel Types
+====================
+
+ADCs can have distinct types of inputs, each of them measuring analog voltages
+in a slightly different way. An ADC digitizes the analog input voltage over a
+span that is often given by the provided voltage reference, the input type, and
+the input polarity. The input range allowed to an ADC channel is needed to
+determine the scale factor and offset needed to obtain the measured value in
+real-world units (millivolts for voltage measurement, milliamps for current
+measurement, etc.).
+
+Elaborated designs may have nonlinear characteristics or integrated components
+(such as amplifiers and reference buffers) that might also have to be considered
+to derive the allowed input range for an ADC. For clarity, the sections below
+assume the input range only depends on the provided voltage references, input
+type, and input polarity.
+
+There are three general types of ADC inputs (single-ended, differential,
+pseudo-differential) and two possible polarities (unipolar, bipolar). The input
+type (single-ended, differential, pseudo-differential) is one channel
+characteristic, and is completely independent of the polarity (unipolar,
+bipolar) aspect. A comprehensive article about ADC input types (on which this
+doc is heavily based on) can be found at
+https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html.
+
+1.1 Single-ended channels
+-------------------------
+
+Single-ended channels digitize the analog input voltage relative to ground and
+can be either unipolar or bipolar.
+
+1.1.1 Single-ended Unipolar Channels
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+  ---------- VREF -------------
+      ´ `           ´ `                  _____________
+    /     \       /     \               /             |
+   /       \     /       \         --- <  IN    ADC   |
+            \   /         \   /         \             |
+             `-´           `-´           \       VREF |
+  -------- GND (0V) -----------           +-----------+
+                                                  ^
+                                                  |
+                                             External VREF
+
+The input voltage to a **single-ended unipolar** channel is allowed to swing
+from GND to VREF (where VREF is a voltage reference with electrical potential
+higher than system ground). The maximum input voltage is also called VFS
+(full-scale input voltage), with VFS being determined by VREF. The voltage
+reference may be provided from an external supply or derived from the chip power
+source.
+
+A single-ended unipolar channel could be described in device tree like the
+following example::
+
+    adc@0 {
+        ...
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+        };
+    };
+
+See ``Documentation/devicetree/bindings/iio/adc/adc.yaml`` for the complete
+documentation of ADC specific device tree properties.
+
+
+1.1.2 Single-ended Bipolar Channels
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+  ---------- +VREF ------------
+      ´ `           ´ `                  _____________________
+    /     \       /     \               /                     |
+   /       \     /       \         --- <  IN          ADC     |
+            \   /         \   /         \                     |
+             `-´           `-´           \       +VREF  -VREF |
+  ---------- -VREF ------------           +-------------------+
+                                                  ^       ^
+                                                  |       |
+                             External +VREF ------+  External -VREF
+
+For a **single-ended bipolar** channel, the analog voltage input can go from
+-VREF to +VREF (where -VREF is the voltage reference that has the lower
+electrical potential while +VREF is the reference with the higher one). Some ADC
+chips derive the lower reference from +VREF, others get it from a separate
+input.  Often, +VREF and -VREF are symmetric but they don't need to be so. When
+-VREF is lower than system ground, these inputs are also called single-ended
+true bipolar.
+
+Here's an example device tree description of a single-ended bipolar channel::
+
+    adc@0 {
+        ...
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            bipolar;
+        };
+    };
+
+1.2 Differential channels
+-------------------------
+
+A differential voltage measurement digitizes the voltage level at the positive
+input (IN+) relative to the negative input (IN-) over the -VREF to +VREF span.
+In other words, a differential channel measures the potential difference between
+IN+ and IN-, which is often denoted by the IN+ - IN- formula.
+
+1.2.1 Differential Bipolar Channels
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+  -------- +VREF ------
+    ´ `       ´ `               +-------------------+
+  /     \   /     \   /        /                    |
+         `-´       `-´    --- <  IN+                |
+  -------- -VREF ------        |                    |
+                               |            ADC     |
+  -------- +VREF ------        |                    |
+        ´ `       ´ `     --- <  IN-                |
+  \   /     \   /     \        \       +VREF  -VREF |
+   `-´       `-´                +-------------------+
+  -------- -VREF ------                  ^       ^
+                                         |       +---- External -VREF
+                                  External +VREF
+
+The analog signals to **differential bipolar** inputs are also allowed to swing
+from -VREF to +VREF. If -VREF is below system GND, these are also called
+differential true bipolar inputs.
+
+Device tree example of a differential bipolar channel::
+
+    adc@0 {
+        ...
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            bipolar;
+            diff-channels = <0 1>;
+        };
+    };
+
+In the ADC driver, ``differential = 1`` is set into ``struct iio_chan_spec`` for
+the channel. See ``include/linux/iio/iio.h`` for more information.
+
+1.2.2 Differential Unipolar Channels
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+For **differential unipolar** channels, the analog voltage at the positive input
+must also be higher than the voltage at the negative input. Thus, the actual
+input range allowed to a differential unipolar channel is IN- to +VREF. Because
+IN+ is allowed to swing with the measured analog signal and the input setup must
+guarantee IN+ will not go below IN- (nor IN- will raise above IN+), most
+differential unipolar channel setups have IN- fixed to a known voltage that does
+not fall within the voltage range expected for the measured signal. This leads
+to a setup that is equivalent to a pseudo-differential channel. Thus,
+differential unipolar channels are actually pseudo-differential unipolar
+channels.
+
+1.3 Pseudo-differential Channels
+--------------------------------
+
+There is a third ADC input type which is called pseudo-differential or
+single-ended to differential configuration. A pseudo-differential channel is
+similar to a differential channel in that it also measures IN+ relative to IN-.
+However, unlike differential channels, the negative input is limited to a narrow
+(taken as constant) voltage range while only IN+ is allowed to swing. A
+pseudo-differential channel can be made out from a differential pair of inputs
+by restricting the negative input to a known voltage while allowing only the
+positive input to swing. Aside from that, some parts have a COM pin that allows
+single-ended inputs to be referenced to a common-mode voltage, making them
+pseudo-differential channels. Often, the common mode input voltage
+can be nicely described in the device tree as a voltage regulator (e.g.
+``com-supply``) since it is basically a constant voltage source.
+
+1.3.1 Pseudo-differential Unipolar Channels
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+  -------- +VREF ------          +-------------------+
+    ´ `       ´ `               /                    |
+  /     \   /     \   /    --- <  IN+                |
+         `-´       `-´          |                    |
+  --------- IN- -------         |            ADC     |
+                                |                    |
+  Common-mode voltage -->  --- <  IN-                |
+                                \       +VREF        |
+                                 +-------------------+
+                                          ^
+                                          |
+                                   External +VREF
+
+A **pseudo-differential unipolar** input has the limitations a differential
+unipolar channel would have, meaning the analog voltage to the positive input
+IN+ must stay within IN- to +VREF. The fixed voltage to IN- is sometimes called
+common-mode voltage and it must be within -VREF to +VREF as would be expected
+from the signal to any differential channel negative input.
+
+In pseudo-differential configuration, the voltage measured from IN+ is not
+relative to GND (as it would be for a single-ended channel) but to IN-, which
+causes the measurement to always be offset by IN- volts. To allow applications
+to calculate IN+ voltage with respect to system ground, the IIO channel should
+provide an ``_offset`` sysfs attribute to report the channel offset to user
+space. In cases where IN- (or the common mode voltage applied to IN-) is GND,
+the ``_offset`` attribute may be omitted.
+
+Device tree example for pseudo-differential unipolar channel::
+
+    adc@0 {
+        ...
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            single-channel = <0>;
+            common-mode-channel = <1>;
+        };
+    };
+
+Do not set ``differential`` in the channel ``iio_chan_spec`` struct of
+pseudo-differential channels.
+
+1.3.2 Pseudo-differential Bipolar Channels
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+::
+
+  -------- +VREF ------          +-------------------+
+    ´ `       ´ `               /                    |
+  /     \   /     \   /    --- <  IN+                |
+         `-´       `-´          |                    |
+  -------- -VREF ------         |            ADC     |
+                                |                    |
+  Common-mode voltage -->  --- <  IN-                |
+                                \       +VREF  -VREF |
+                                 +-------------------+
+                                          ^       ^
+                                          |       +---- External -VREF
+                                   External +VREF
+
+A **pseudo-differential bipolar** input is not limited by the level at IN- but
+it will be limited to -VREF or to GND on the lower end of the input range
+depending on the particular ADC. Similar to their unipolar counter parts,
+pseudo-differential bipolar channels may define an ``_offset`` attribute to
+provide the read offset relative to GND.
+
+Device tree example for pseudo-differential bipolar channel::
+
+    adc@0 {
+        ...
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+            reg = <0>;
+            bipolar;
+            single-channel = <0>;
+            common-mode-channel = <1>;
+        };
+    };
+
+Again, the ``differential`` field of ``struct iio_chan_spec`` is not set for
+pseudo-differential channels.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 5710f5b9e958..48b88044d7cb 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -7,6 +7,7 @@ Industrial I/O
 .. toctree::
    :maxdepth: 1
 
+   iio_adc
    iio_configfs
    iio_devbuf
    iio_dmabuf_api

base-commit: 9b75dd1b7d6b98699a104c6b1eec0c8817e5fd4b
-- 
2.45.2


