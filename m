Return-Path: <linux-iio+bounces-15810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696DFA3CAB9
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 22:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C34417731A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968C25291D;
	Wed, 19 Feb 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mWJDHAaF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A18824FBE5;
	Wed, 19 Feb 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998901; cv=none; b=f21uWs+ik1ItQWmqkGLHB1BGhVUP64bhjGIkPKF9qrQZvkEjxNxGHn+Y3YxjG+aNq1wj6fDBQpWEeWrlYWfSbssPTJj6omKulV/FQFIMrYkPlu2dq9ge3IgLXQkdxRx8ZjyijYpBGMXQKSDwpnMpmM28d5ryVv/JQOAg4NZWdOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998901; c=relaxed/simple;
	bh=mU3uChO9zC48MNiFTH0fSQo8UsOqWfp0jQGUgEHP9Jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Si8UNGaK5wW3quyrpRL1ty2eiZjT+KaAYsMjbZYzgRXIWLgIGfC9su5LMfBljIX7clK0xkIk4szrdRMcLRR8jf1zXcEI4MYEQhZbt4yYn1Li4H4xWuA4iZ215CeqlwuE9hCH22OcNHpsrr5TA5Ex6xMk/N4S8g0XmYwt0P+t5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mWJDHAaF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JJdq2S030747;
	Wed, 19 Feb 2025 16:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=9qmY2jSfCyRh6DOe20pJhep431k
	kYS5XQqQrYwmrttk=; b=mWJDHAaF9r8r7SCDQIfHfmgPynIw3oOt+sZwmnZgWtb
	n7DAtpIX9hD2BIThJ4vTX7kh7+OhaTav56+7VKI2OUemBdHAy18tAqNctSUroN0M
	tZw0LqCANwgD9mh4ydiaPm038lwFVe+jkxT7Z/20dt+CRuvsMcmkM9EhdPhsEZBg
	ba1yUB4Z8DU5T8TKGC5jGatvQQbREy9FMibV/XHe3XIzkSC8SsYrTelCKAVXyrfP
	iYnKDYo91duj+CF3992DiqeN5RKJ4sIMicpUnnnMM4kN8bXMOC1HDpMiLq/Aa7mK
	NXaRKAQ0uQ5BWYcAiYybl6y8P5cIoxa0XKN4LKiDcMw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44wg6r9wjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 16:01:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51JL1Dtk034280
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Feb 2025 16:01:13 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Feb 2025 16:01:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Feb 2025 16:01:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Feb 2025 16:01:12 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51JL0wRl001708;
	Wed, 19 Feb 2025 16:01:00 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <corbet@lwn.net>,
        <dlechner@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 1/1] Documentation: iio: Add ADC documentation
Date: Wed, 19 Feb 2025 18:00:56 -0300
Message-ID: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>
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
X-Authority-Analysis: v=2.4 cv=H9shw/Yi c=1 sm=1 tr=0 ts=67b6469a cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=NQjmSNzx33X6iIXZb-8A:9 a=Q3N-nmbbROyM-ys7:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=QSEaPkJ3LGkA:10 a=DMmNjOjugQIA:10 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: vqwGFbCX5jUEH5EHlSEYTt37rLaMm87M
X-Proofpoint-ORIG-GUID: vqwGFbCX5jUEH5EHlSEYTt37rLaMm87M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190158

ADC inputs can be classified into a few different types according to how
they measure the input signal, how restrained the signal is, and number of
input pins. Even though datasheets tend to provide many details about their
inputs and measurement procedures, it may not always be clear how to model
those inputs into IIO channels.

For example, some differential ADCs can have their inputs configured into
pseudo-differential channels. In that configuration, only one input
connects to the signal of interest as opposed to using two inputs of a
differential input configuration. Datasheets sometimes also refer to
pseudo-differential inputs as single-ended inputs even though they have
distinct physical configuration and measurement procedure.

Document consolidated ADC input types and how they are usually described
and supported in device tree and IIO, respectively.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4
- Specified GPL license version.
- Dropped in parenthesis question at introduction paragraph.
- s/Elaborated/Elaborate/
- Added a phrase associating the bipolar term to the resulting value of (IN+ - IN-).
- Minor adjust to pseudo-differential channels description paragraph:
  unlike differential channels -> unlike bipolar differential channels
- Mentioned the differential field meaning and the bipolar / true bipolar
  (in)distinction from IIO perspective.

Change log v2 -> v3
- Adjusted text to match acronym (Voltage input Full-Scale, or VFS for short).
- Mentioned that channel nodes are optional when the ADC has a uniform set of channels.
- Mentioned that single-channel nodes need to provide single-channel property
  if reg doesn't match the physical input pin number.
- Dropped phrase advising to not set ``differential`` in the channel
  ``iio_chan_spec`` struct in pseudo-differential sections since it looked a
  bit odd to mention differential properties in pseudo-differential sections.
- Reworded Pseudo-differential Unipolar section to hopefully make it less confusing.
  Also added a phrase to mention the provided common-mode voltage is typically GND.
- No longer documenting differential unipolar channels as if they were always
  the same as pseudo-differential unipolar.
- Reworded 1.3 Pseudo-differential Channels section to better phrase IN- being
  often taken as constant and to also mention that the input provided to IN- is
  sometimes called common-mode voltage.
- Re-added -VREF to pseudo-diff unipolar diagram.
  Sorry to insist on this but I do think -VREF was missing in the diagram when
  I read the related paragraph.
- Centralized inputs in differential input diagram.
- Rewritten commit body

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
- Improved .rst formatting with ``.

Link to v3: https://lore.kernel.org/linux-iio/c21b89367510c3d56d8d17adc24b46c7c63a14b2.1738759798.git.marcelo.schmitt@analog.com/
Link to v2: https://lore.kernel.org/linux-iio/efa1dba23c38b207716883d6226ce9e9df5a51b8.1736862045.git.marcelo.schmitt@analog.com/
Link to v1: https://lore.kernel.org/linux-iio/48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com/

 Documentation/iio/iio_adc.rst | 305 ++++++++++++++++++++++++++++++++++
 Documentation/iio/index.rst   |   1 +
 2 files changed, 306 insertions(+)
 create mode 100644 Documentation/iio/iio_adc.rst

diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.rst
new file mode 100644
index 000000000000..ffbd9cbf247b
--- /dev/null
+++ b/Documentation/iio/iio_adc.rst
@@ -0,0 +1,305 @@
+.. SPDX-License-Identifier: GPL-2.0-only
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
+how they are supported by the IIO subsystem.
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
+Elaborate designs may have nonlinear characteristics or integrated components
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
+(Voltage input Full-Scale), with VFS being determined by VREF. The voltage
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
+One is always allowed to include ADC channel nodes in the device tree. Though,
+if the device has a uniform set of inputs (e.g. all inputs are single-ended),
+then declaring the channel nodes is optional.
+
+One caveat for devices that support mixed single-ended and differential channels
+is that single-ended channel nodes also need to provide a ``single-channel``
+property when ``reg`` is an arbitrary number that doesn't match the input pin
+number.
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
+input. Often, +VREF and -VREF are symmetric but they don't need to be so. When
+-VREF is lower than system ground, these inputs are also called single-ended
+true bipolar. Also, while there is a relevant difference between bipolar and
+true bipolar from the electrical perspective, IIO makes no explicit distinction
+between them.
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
+  -------- +VREF ------         +-------------------+
+    ´ `       ´ `              /                    |
+  /     \   /     \   /   --- <  IN+                |
+         `-´       `-´         |                    |
+  -------- -VREF ------        |                    |
+                               |            ADC     |
+  -------- +VREF ------        |                    |
+        ´ `       ´ `          |                    |
+  \   /     \   /     \   --- <  IN-                |
+   `-´       `-´               \       +VREF  -VREF |
+  -------- -VREF ------         +-------------------+
+                                         ^       ^
+                                         |       +---- External -VREF
+                                  External +VREF
+
+The analog signals to **differential bipolar** inputs are also allowed to swing
+from -VREF to +VREF. The bipolar part of the name means that the resulting value
+of the difference (IN+ - IN-) can be positive or negative. If -VREF is below
+system GND, these are also called differential true bipolar inputs.
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
+the channel. Even though, there are three general input types, ``differential``
+is only used to distinguish between differential and not differential (either
+single-ended or pseudo-differential) input types. See
+``include/linux/iio/iio.h`` for more information.
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
+not fall within the voltage range expected for the measured signal. That leads
+to a setup that is equivalent to a pseudo-differential channel. Thus,
+differential unipolar setups can often be supported as pseudo-differential
+unipolar channels.
+
+1.3 Pseudo-differential Channels
+--------------------------------
+
+There is a third ADC input type which is called pseudo-differential or
+single-ended to differential configuration. A pseudo-differential channel is
+similar to a differential channel in that it also measures IN+ relative to IN-.
+However, unlike bipolar differential channels, the negative input is limited to
+a narrow voltage range (taken as a constant voltage) while only IN+ is allowed
+to swing. A pseudo-differential channel can be made out from a differential pair
+of inputs by restricting the negative input to a known voltage while allowing
+only the positive input to swing. Sometimes, the input provided to IN- is called
+common-mode voltage. Besides, some parts have a COM pin that allows single-ended
+inputs to be referenced to a common-mode voltage, making them
+pseudo-differential channels. Often, the common mode input voltage can be
+described in the device tree as a voltage regulator (e.g. ``com-supply``) since
+it is basically a constant voltage source.
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
+                                \       +VREF  -VREF |
+                                 +-------------------+
+                                         ^       ^
+                                         |       +---- External -VREF
+                                  External +VREF
+
+A **pseudo-differential unipolar** input has the limitations a differential
+unipolar channel would have, meaning the analog voltage to the positive input
+IN+ must stay within IN- to +VREF. The fixed voltage to IN- is often called
+common-mode voltage and it must be within -VREF to +VREF as would be expected
+from the signal to any differential channel negative input.
+
+The voltage measured from IN+ is relative to IN- but, unlike differential
+channels, pseudo-differential setups are intended to gauge single-ended input
+signals. To enable applications to calculate IN+ voltage with respect to system
+ground, the IIO channel may provide an ``_offset`` sysfs attribute to be added
+to ADC output when converting raw data to voltage units. In many setups, the
+common-mode voltage input is at GND level and the ``_offset`` attribute is
+omitted due to being always zero.
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
+pseudo-differential bipolar channels ought to declare an ``_offset`` attribute
+to enable the conversion of raw ADC data to voltage units. For the setup with
+IN- connected to GND, ``_offset`` is often omitted.
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
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 2d334be2b7f2..9b0dbc78607b 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -7,6 +7,7 @@ Industrial I/O
 .. toctree::
    :maxdepth: 1
 
+   iio_adc
    iio_configfs
    iio_devbuf
    iio_dmabuf_api

base-commit: c0f115a8d97599623294c8e9ec28530e19c1e85b
-- 
2.47.2


