Return-Path: <linux-iio+bounces-23705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA9B43BC4
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACD81BC51F5
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E492F83D6;
	Thu,  4 Sep 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A91ffloi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748912ED17B;
	Thu,  4 Sep 2025 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989399; cv=none; b=nNIxaamF1DD/LRf4VyZA/j0KFAfAlC2eDR2xpuMMbXHkU+NogxKq9lmW4NPCoAvvbB7iVk1ABDredgK3RP54XBPxkqbt9D9YQ4zynKdBZvQ5BRxtQq9tSKdJGD8U8wW5Vef1u9PBuOSKAgt7KGlCWaCD0p23Wihran1yoAzL8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989399; c=relaxed/simple;
	bh=cz8f4SON6S7em25PYzBme98L8waFpdmQicxJpNvUg8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op76/WKs7JBVgWBX+OETcS3N8Uf9sgujD91cHq6sOT5ex/bzGDGVSBCRZP6altm7Rd7f9xAYD3858teWrjZBfzkXxgkzBCn5vf3r9iLlM8w0xshAs+wPoD2rm6heo8d/764Y7+yD8D+hso0Sy+10BKZU3zv0LtvU/erm32mkSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A91ffloi; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f716e25d9so961317e87.1;
        Thu, 04 Sep 2025 05:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756989395; x=1757594195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cAw0rYoHkF40GJHUURxiO/Sv7cjTyy9fPPT/elKOAg=;
        b=A91ffloipkS+QyX9MJA4qjLGs6sRb2m4O6Bn0IB0ZV1ER9FrW1JLnY9nOvAvQsC2yM
         mMGmq9OWID6d/VNYDBmBGeyLYItBvTxggXk3QVKdTYkpXdyzNP6SG+QyWBSFU0GT7aVh
         bl/VPpeKHwDRLajJsXgU+sXJVoCFGw8/4A2r4P+HVCdA3uSuvftvTc2E/1TMm7rpQzCF
         +EYqtgo0YRzesiLP5SEJ8hLKWf6iga9UjkgehJ2zqVH6581JCJQGqNefmainrKiQAnVN
         +jvu+o22CbEScnpItPoH4Urqn+Ebqc9Aa6e14uWXIXBG/6oxtwmuxPUoVUO8h2GNwWzD
         LiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756989395; x=1757594195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5cAw0rYoHkF40GJHUURxiO/Sv7cjTyy9fPPT/elKOAg=;
        b=kB3zUIOj/PVGdwIxlpf4e6iJnFM8j6+I5SNjVenyBQBPH9WWWUXTHQo79sr7LMvFTl
         Dwo7eXq9TKUpB2fL/DjN4nP0xMwxtTFhdO8cw7vJk+/uUCSmckNrFMO5rzLkNAZHWuUY
         YFc+BFdkXaG6TkTZvZTkSBG1Fe1IAuDTj+tgU3MpdEaDdN5/lkDdY18riPTw/WxsyEaj
         hzHhvQzigXLk9IczcLXWyH72jftqW1iXc36xojXuC0GDrAdPhFHsggpkK/Q0JDmWcAYl
         g/CoTn0/IHpuMVRY73O4ebMotNJxudUZzEB8iWjARntVocnNxjjt0xAppOxMI4Paxw3i
         S9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCU4n3nlttd2cXxy6qMWoqFp9ZGWtVCmmksLRVPgWbjEvj/2sVqU1WuwwMgHg3WIcqz6ttbkgahqBIFw@vger.kernel.org, AJvYcCUGXc4WDzUSQKpPYyTVF/rlOy0KZWMQXd7L5L5s9vZv1h08QZYW+aZQcfgloVxnOSXV0dJkajyq6nKm@vger.kernel.org, AJvYcCVk7lRVc749Y+6dMzwTt2UXocER8gUtPNWz/dhiDI5QfHXBjh4fpKI595UjoBMd7pMgUdm1DTLDUq1aTZPb@vger.kernel.org, AJvYcCW/Y5Ikn1+oSivvqjWiVRMTrQwEuXDYG8RIfVyjY2ELhopIK8TXAZYFpswrh6mHAkUgck+iUSrLucvq5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXqD2VcC9BjJig9A/BsyNT87BnNqTWXhEXuIoYWxFNGXoNgyIU
	IK5+ebV0+c9/tCeUgxmIBbMgw8BiNh+wJv2vHkg8X+QXa7lQltBmL9g1
X-Gm-Gg: ASbGncumNEaKhnywl80vNygES1fWW18p0+p2P9n8zVO6SrEwll+vCpLZNY9RgomQceB
	LAbj+lLg9tgywg80kECzPkFLEvD7dWb7OVOKQ3ZCmlMtII0hlJ7CXZlRgA5cfSfhgGmf+wUoEr1
	RoQ1eB7CaiGIm7AtyMi1GtwFmVXWSKZ4II4bBZgxlTfHfUtEVD3ctVk7K09aISxNjIPfeA+BPaL
	NlMQrTxe23aEkDujMEXNyN6ymNSK6Yt5XKMAI9LRithc+YvO6lxy7Lbnr+7pyznmq3LaWEqWjcR
	4eKquhfGOyqvq2VTyXaE341JQBOtptK9ulBh+AflTcUyddAYazSIVELmJPHpD6S7v+C4KlhYq2A
	eHCxSGy+7JuPKfYy8tHrp6gqKMg==
X-Google-Smtp-Source: AGHT+IGAB3f8eB06Yl5hNbqi9CBNyzhTfL6cdtqqCslIH/CR0ukPTP/6MHqJ25wOz5l73F7UAcpSxw==
X-Received: by 2002:a05:6512:158a:b0:55f:5d1f:245a with SMTP id 2adb3069b0e04-55f70a3492cmr5381601e87.52.1756989395152;
        Thu, 04 Sep 2025 05:36:35 -0700 (PDT)
Received: from mva-rohm ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfbfa8sm1209717e87.96.2025.09.04.05.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:36:34 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:36:30 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
Message-ID: <af7292dea5cebe97553af67a8897e092bef3ec56.1756988028.git.mazziesaccount@gmail.com>
References: <cover.1756988028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FZkLJYUOdbpGadK3"
Content-Disposition: inline
In-Reply-To: <cover.1756988028.git.mazziesaccount@gmail.com>


--FZkLJYUOdbpGadK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.

The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
daisy-chain configuration) and maximum sampling rate is 1MSPS.

Add a device tree binding document for the ROHM BD79112.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - BD79112 can act as a GPIO controller.
---
 .../bindings/iio/adc/rohm,bd79112.yaml        | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/rohm,bd79112.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml b/=
Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
new file mode 100644
index 000000000000..8aeac5b60880
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/rohm,bd79112.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/rohm,bd79112.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD79112 ADC/GPO
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. ADC input pins can be
+  also configured as general purpose inputs/outputs. SPI should use MODE 3.
+
+properties:
+  compatible:
+    const: rohm,bd79112
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+  spi-cpol: true
+
+  gpio-controller: true
+  "#gpio-cells":
+    const: 2
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
+  "^channel@([0-9]|[12][0-9]|3[01])$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Represents ADC channel. Omitted channels' inputs are GPIO=
s.
+
+    properties:
+      reg:
+        description: AIN pin number
+        minimum: 0
+        maximum: 31
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
+  - spi-cpha
+  - spi-cpol
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        adc: adc@0 {
+            compatible =3D "rohm,bd79112";
+            reg =3D <0x0>;
+
+            spi-cpha;
+            spi-cpol;
+
+            vdd-supply =3D <&dummyreg>;
+            iovdd-supply =3D <&dummyreg>;
+
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            gpio-controller;
+            #gpio-cells =3D <2>;
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
+            channel@16 {
+                reg =3D <16>;
+            };
+            channel@20 {
+                reg =3D <20>;
+            };
+        };
+    };
--=20
2.51.0


--FZkLJYUOdbpGadK3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmi5h84ACgkQeFA3/03a
ocWjOwgAjeTaAu/NdOdH1/KUPjRA+uzUoDaVY7G53Mvj0djsWXOdHiOuLRVH8a/Q
1cpenDtDIZUnagsiy5otP8PXBGmy6k6WMnHxjCC4fsx4nZgrlw4ASeyWI/y0VGsy
2PYxFaLdly8wnpDFQfU2lbQYsCf0AR31XdexUGwTt9tSOWNsaAUfY43YmCRIc7s1
f+dN3L7TFrVaE2wWoKh3uN1f7wkVSEWT7sdPhFfxrs70F5WvYvoFsdqaa6zlj/2h
RdTaebxwaMnZI+HQKtRyUI/paHaN3T/NpCcJ835eIXr8/vGjbuVp2drJ9mZhKYiy
+MP8sZpmwfjyreH/jo6JZgckChs02w==
=UFBs
-----END PGP SIGNATURE-----

--FZkLJYUOdbpGadK3--

