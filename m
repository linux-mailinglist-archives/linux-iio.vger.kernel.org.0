Return-Path: <linux-iio+bounces-16260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7AA4BE99
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F1D1885672
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601851F8726;
	Mon,  3 Mar 2025 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4xnXHXM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5E1EEA4A;
	Mon,  3 Mar 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001500; cv=none; b=paDOWnH9pu5BB3h4lxCMldtQJcd52jCgzpW7gCth5JwYyVc/7h0U/3Kpl7p09EbRQSgfPBwbByeOzIYYoUjVvWO8VzHcfIRIY0zIic2JFPJt09RTQFrlRm+rwhfyQCRobcb0oh2ObNlPYp3Z6KGNl4GnEATVXTb9iE0x3oKF6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001500; c=relaxed/simple;
	bh=NlwgN07FrFSu84o+5T1gUSI8JW7OjvVqVFxpziiSosE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1QiZ8NrnyPn0ispCWcu64ayAXoghtlFJMwW5yBB0YRr5w85PJ5D88J45+pEgJiY5wgLu8wCF0BwznjTVSR4aigmbRV2bUV4PSp+TjhHCzxCi/uhC063PUkbuVih3cZ6DWPeRAADPMMouzq9dh8x0P21mejBYF7xXmPLkjXZt80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4xnXHXM; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-307bc125e2eso47108081fa.3;
        Mon, 03 Mar 2025 03:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741001496; x=1741606296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRbeVD92omOXPkqtwMRC9gBsAE4nzJULOdvDKGHzwoM=;
        b=H4xnXHXMcaQ7Aehxj1dXfBt1RemeKGaG64p2ISkA/I0PoM63Ist2rxN7oiUB5gTp1Q
         YdaUOB1xrUGlG2pB5cvc7QoWn/cMkuF5xLa9cMyDunQOsDUXn532GChEkmmuoTrWWbMl
         KD4jMIzMH1mfU5b7TfOkAJByci+ltRSbMq2Ub6+joxa5/AX965HHastfVgBkY8j7EH07
         7VQHcUeHFEA7//44bYgZIGyW0h+z2PSuDsEEVFLU5+a9gT0hr0VseCvOXg9gaBdKhtIV
         sff+724+CEM29G47djJA8MThE1VnSbfXbDGqbz1H2xignpUV/bftVbTJRNaqYqkyaAl/
         /UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741001496; x=1741606296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRbeVD92omOXPkqtwMRC9gBsAE4nzJULOdvDKGHzwoM=;
        b=mpvgioWBYCZxNCdc7nZPYaghX26Hbhv6SncdoJD7fncWzVjyrnxn5iew33bkGsBvQN
         cmqRPMVkP7nt4B87zBxBe3ObgA1BfNm9QSJ1GrYLd5gNH52xxrDan0bh3XsoAoRGD2Ah
         cjJi6BUN7ZTGhlHfsbxSOPXLUQgGWbs4V4KgaS03wL6Mxzihi3xkSXbUnPX/iF2Jw0Cg
         mTkq8CVyYjSOPPzTMO1zXr/huxsiAlK9k37XYNGHbubZw841SCbMSl130rDJ5I2fkQQI
         /9AnUrVUv8iy/hulntyo9JQKNKO7nn/u7aygbcyY7ilGyjt4EL7bh4/aqvi0X/OLEd6P
         Dscw==
X-Forwarded-Encrypted: i=1; AJvYcCWBLLVezD/afQ/afweFpw6CVenTVDPKcn40wa2C51XyD4ADke0FRrb9fD2yjKTf0XUoGofUN8Tv/HDDDYTJ@vger.kernel.org, AJvYcCWot5WOzPEWoFFz3RcQF/cWminMoT3KYxMjGZM98d3Bb/IYz7d6UMDG9+GAapSOgrMATj3NiBRjVzj7@vger.kernel.org, AJvYcCXscHTVpf+pJ66LMlnGtYJp3XJ4dqlNtWu9VWqH1KyQwVNS5ooXP2P8ib+8CshSYkrJKVwDjzSz2dhF@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2xAvPAWHUrW2Ze4O9dTGnjVDbjJrj4/fKJ67HjDZoq8QtUM2
	dW7AZAl4Jula/s9r++0ZRjzNe6riWW6sye4fWbOApG73Q3P4m1C7
X-Gm-Gg: ASbGncsCwglWfKSPqg6oJmyqvUtpgIRKFWptftjh+a4HkOIrEEPaDZ2G2+A8y93g9mo
	NL/nIEMtahP+/YgGCWFyVJZXQE41OU+7Ct5tnAm2zjcu1zcgAWLUeXwlnmOyYIYJU+kqxOU4rGr
	pcqToJpXroRiFcKjCp0Y1fx0pmiOxI2iLl8iKHwdPsYVmFFCQUdyPefH5/qq15j2IJ/uFe33fm/
	9Gy6CwiemNjKCTnWxOBJubSY0VOHfsWObpGT+uZvJkkI18sUuqQl1f00xNdBbVVGvsVhz7qbH+v
	Nre50tlidjEWhSzwlNaUdWGsGEtnUapVxG+5pCDOQBmZVR0Cl4HwYVxFGi0X9TwPl6Asw77YNih
	hDmEoIx5sEFA=
X-Google-Smtp-Source: AGHT+IGZilv5CZXn8TdEAfhT2IfOr3b0lcki4DbrDq45M/Fra3PCQLRg2e7d4pV7RiK//821RneoVg==
X-Received: by 2002:a2e:a543:0:b0:30b:b0e5:7174 with SMTP id 38308e7fff4ca-30bb0e57614mr23002541fa.2.1741001496041;
        Mon, 03 Mar 2025 03:31:36 -0800 (PST)
Received: from mva-rohm (mobile-access-2e8451-125.dhcp.inet.fi. [46.132.81.125])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bc661888bsm736491fa.107.2025.03.03.03.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:31:33 -0800 (PST)
Date: Mon, 3 Mar 2025 13:31:28 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/10] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <12f09edd6c036c78f803e530f3f8f0011527efdb.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H0RgC7Hhku1h6P9v"
Content-Disposition: inline
In-Reply-To: <cover.1740993491.git.mazziesaccount@gmail.com>


--H0RgC7Hhku1h6P9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add binding document for the ROHM BD79124 ADC / GPO.

ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be used
as general purpose outputs.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Revision history:
v3 =3D>
 - No changes
v2 =3D> v3:
 - Restrict channel numbers to 0-7 as suggested by Conor
RFC v1 =3D> v2:
 - drop MFD and represent directly as ADC
 - drop pinmux and treat all non ADC channel pins as GPOs
---
 .../bindings/iio/adc/rohm,bd79124.yaml        | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79124.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
new file mode 100644
index 000000000000..503285823376
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79124.yaml
@@ -0,0 +1,114 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/rohm,bd79124.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD79124 ADC/GPO
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
+  an automatic measurement mode, with an alarm interrupt for out-of-window
+  measurements. ADC input pins can be also configured as general purpose
+  outputs.
+
+properties:
+  compatible:
+    const: rohm,bd79124
+
+  reg:
+    description:
+      I2C slave address.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 1
+    description:
+      The pin number.
+
+  vdd-supply: true
+
+  iovdd-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@[0-7]+$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Represents ADC channel.
+
+    properties:
+      reg:
+        description: AIN pin number
+        minimum: 0
+        maximum: 7
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - iovdd-supply
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        adc: adc@10 {
+            compatible =3D "rohm,bd79124";
+            reg =3D <0x10>;
+
+            interrupt-parent =3D <&gpio1>;
+            interrupts =3D <29 8>;
+
+            vdd-supply =3D <&dummyreg>;
+            iovdd-supply =3D <&dummyreg>;
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            channel@0 {
+                reg =3D <0>;
+            };
+            channel@1 {
+                reg =3D <1>;
+            };
+            channel@2 {
+                reg =3D <2>;
+            };
+            channel@3 {
+                reg =3D <3>;
+            };
+            channel@4 {
+                reg =3D <4>;
+            };
+            channel@5 {
+                reg =3D <5>;
+            };
+            channel@6 {
+                reg =3D <6>;
+            };
+        };
+    };
--=20
2.48.1


--H0RgC7Hhku1h6P9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfFkxAACgkQeFA3/03a
ocWVMwf+LSjeAan6vYRVHystYipz9Ec9BGJks+ld7jCTbboLHQveWSt4gYac4TEJ
nbzsmGSbxqUDmd2Ja0bmSufXz7SkYS7Cu2L2hMvE1tLrLDWTZXVMaDlTEpjOcaBf
38XLV8LdtLu9nz4VAMcdJ/zJyTRXDwsZhfwmDtulChV4/cio2yTYQaLyBgWSMrfJ
zM/Mgvbcq1G2MjC5pZY16abvs6/8JStRm8vunTSfUk1jnl5RJvlXTt798ZhOjO3d
CBziLLN9FtyZd1v/zCtZfcwZFVJFX5KcucN/EJ+/sLYgfpFCbHAJ9ddVZHGBdtvU
4bOsS1cTWscHYHmt/hFCPnMVFuEQ3A==
=JqV2
-----END PGP SIGNATURE-----

--H0RgC7Hhku1h6P9v--

