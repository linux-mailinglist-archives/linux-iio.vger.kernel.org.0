Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1B10D30
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2019 21:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfEATa3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 May 2019 15:30:29 -0400
Received: from secvs01.rockwellcollins.com ([205.175.225.240]:15440 "EHLO
        secvs01.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726101AbfEATa3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 May 2019 15:30:29 -0400
X-RC-All-From: , 205.175.225.60, No hostname, adam.michaelis@rockwellcollins.com,
 Adam Michaelis <adam.michaelis@rockwellcollins.com>, , 
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.225.60
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: secip01.rockwellcollins.com
X-RC-IP-MID: 277223677
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-oi1-f199.google.com) ([205.175.225.60])
  by secvs01.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 01 May 2019 14:30:27 -0500
Received: by mail-oi1-f199.google.com with SMTP id u135so82232oia.2
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2019 12:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F4PFKivrCCt8E/bjYsH5ykIrQ9bNtH2T/uQxJDWTUxk=;
        b=iBa5lC4oNWkGHH06vVkgPzyIxegvjFG3w5BebkYQ0Pgz7va9OVc425z38zWn7II6ud
         mRVN73gOj6fycj7FrtqbR7wmNq6HIkI+cRtp0GnRWbH517JYuz989BFdviopFarwW9Uz
         DK8mUU9DJciH6COz0HV9jgFesaukrzeMFU96i7vzjPRAT6xGzcwAn0H5aSBP+3BPyH0V
         Gm+7hs+LvnbJUo/Nq3xggDdYwVTcR16wm1crtUmBoVosm+Wb1PuRMyWFr/SDFof0DUc3
         cTrsAbtHR6U2l05z8G67NtUvURxVkxkyoaJfyDMBnFsbfjBvEyqxpKhF1Q8WWkQ8Q0gU
         6SaQ==
X-Gm-Message-State: APjAAAWe2wkgl+dA8rVJ8OwXjE8xYbjS5f8FFPTp47JR6H6d5MMJkSPT
        mMI3vykiIBCl3UrMlW5luMr/R+dCEuVZh+a2zpwVUKFRv9hoM4u8SITrKBky4Ao4oV1w9gMJn0K
        TosEfOBp1g1IYuiFrLctCNHmK//lXeZ5JbBh6fdCSKBUGaMOsjsh0/rs=
X-Received: by 2002:aca:c246:: with SMTP id s67mr7812470oif.159.1556739027174;
        Wed, 01 May 2019 12:30:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzwl9jaLwlQF3bo/hxPu7ykO2nZUNUL3iGGE/m6q02Ansh3+g/noBeDiTGYKszlPtmb9P02rIBb3GTVamr8Acs=
X-Received: by 2002:aca:c246:: with SMTP id s67mr7812457oif.159.1556739026959;
 Wed, 01 May 2019 12:30:26 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
Date:   Wed, 1 May 2019 14:30:16 -0500
Message-ID: <CALMrGWUsr4+E3bYSj8hGvxDhZRZ1xiwVtd-x4RnOf3En6xMq5Q@mail.gmail.com>
Subject: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select
To:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org
Cc:     Clayton Shotwell <clayton.shotwell@rockwellcollins.com>,
        Brandon Maier <brandon.maier@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From d228a1a119e33aff91f481fb8ab301a027b5a4ac Mon Sep 17 00:00:00 2001
From: Adam Michaelis <adam.michaelis@rockwellcollins.com>
Date: Thu, 25 Apr 2019 15:22:00 -0500
Subject: [PATCH 2/6] dt-bindings: iio: ad7949: Add adi,reference-select

Adding optional parameter to AD7949 to specify the source for the
reference voltage signal. Default value is maintaned with option '6' to
match previous version of driver.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
Sorry about the re-sends - GMail inserted HTML on me and it bounced from vger.
---
 .../devicetree/bindings/iio/adc/ad7949.txt         | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
index c7f5057356b1..14ee9a2cb2a5 100644
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -6,11 +6,29 @@ Required properties:
  * "adi,ad7682"
  * "adi,ad7689"
  - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage

-Example:
+Optional properties:
+ - adi,reference-select: Select the reference voltage source to use
+ when converting the input voltages. Valid values are:
+   0: Internal 2.5V reference; temperature sensor enabled
+   1: Internal 4.096V reference; temperature sensor enabled
+   2: External reference, temperature sensor enabled, no buffer
+   3: External reference, temperature sensor enabled, buffer enabled
+   6: External reference, temperature sensor disabled, no buffer
+   7: External reference, temperature sensor disabled, buffer enabled
+ - vref-supply: The regulator supply for ADC reference voltage. Required
+ if external reference selected by 'adi,reference-select'.
+
+Examples:
 adc@0 {
  compatible = "adi,ad7949";
  reg = <0>;
+ adi,reference-select = <2>;
  vref-supply = <&vdd_supply>;
 };
+
+adc@0 {
+ compatible = "adi,ad7949";
+ reg = <0>;
+ adi,reference-select = <0>;
+};
-- 
1.9.1
