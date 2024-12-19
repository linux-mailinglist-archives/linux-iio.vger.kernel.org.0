Return-Path: <linux-iio+bounces-13633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 600299F7A82
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA647A319E
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D021661D;
	Thu, 19 Dec 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7zTvU1F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC722333F;
	Thu, 19 Dec 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608362; cv=none; b=a8jbXoyR2RgFoS5XjfG9Fo/HQ71Bk115fk5HW+Uzv6IHRDOpMl0RtdWdeanYrlhBMpjBcm4S+tmD5tsgKek24/5gwGVTwVHHSLWlBwLArFuwnfpFMDi7Jf04ipp9chE9HKpJEbHdqnUBRr6ogTQgmJyoQUwd6HzGjhS7XPdOWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608362; c=relaxed/simple;
	bh=l0IlVLAkN5yXM8TdTpl/M5HQwAIFuHAHi9RPBRHJdAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrbraDsQqa70k3bIgkPCCbSpWM86UllMZ7G4JTjvvxnlQ+5t37394sQj6BuE9tuAD/jmcF+Gb+yIQ/lBkpgAF179ZGzUsS6gx54T44HVSrPBE8MHy8ujwuwYEcmVTW9Hju24kwu/XQPhvRisqmIVvkOSt1EwiZTljbLqz/bqyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7zTvU1F; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e3a227b82so572492e87.0;
        Thu, 19 Dec 2024 03:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734608356; x=1735213156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phIgK69RAEXPcDz3dpO+89wwhoyTuFBuPF479k215DY=;
        b=J7zTvU1FPLsiIRqE7lXVWf+n4MOaT4fKVVzOgUy2iDqNsftThtuJrOs1SI6VZyZ+DW
         AkhERQaLzEFnygd1npCRqn540PxXvuov7yFq0cS7Wyqep+f6eOYAtAt22pSODmQ3ZkBw
         p3YgiJpuS83vakkcXcNSGoDzsOK4GBpTCliVaEeJRrNAQF/l61qCRb+rB27h1WL+uvmB
         HdFLhM/u2SB9iod+Ph80na9FZumDTHVyqt34xQLxLO0nldGNCv2iQdiwwFyA7/4z+M1g
         FVC02OWWAErhm0yD4wdJLWns5JIk8lMVD4Az/D92iIo3PoUgzb1YQs1u+6tm2Po6J0RA
         jjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734608356; x=1735213156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phIgK69RAEXPcDz3dpO+89wwhoyTuFBuPF479k215DY=;
        b=gIZ/PcFJhZ84g7hQFu/fsFn0yHIPRPr3PjWgaUBMtWorNVkH4Wjb9cU9K8gEKy8/4s
         wsOnELMYD5hPbhtx3iJ+vpl7hdE8VE9CefA9sN1kFyX+xwcqm3jd85r4fefqPegfneXh
         URrjGDDkSN1THq+517DHOuzGjak75BofVa9KfAmCtnQH2SN9RdiQCfcOq9bQemFA8aov
         DKKIMm3/A5dmuLG4t0+HeeVkt0s1dxTG9Z3ntbyGuI48+MTXWDCN/JzshEO9ChUVqKIc
         AESrsETZBySJKszMHPy3XzagDPNofzj67oYtXWa66Fu0Y0mVKQwdqIFW6ZY6kOhFbiBM
         eqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBbcu5IGMW13/6lSHg3oBVb1EaTo2tLzEUHz6c89PPD+bF7uGdhAhmZLJ93gIMAu8LqXK+o765gkFTozXR@vger.kernel.org, AJvYcCX7HTUBYlQLeKLdiR1HA20S0n5lA8JrhtqdCOfo/wKhOzmuo/X6fcaNsOV06Rj0YNnS/NaM7iH/bOwJ@vger.kernel.org, AJvYcCXUP0sI5GKZsWK6fc8nJi5YOYy8Dh1NSddGuO+vMH5PB+HiSlEIfVlYa2ee6f2derl7VVZrVF4pLe2i@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0CSdoutCSadRentazcKfE7RJj/zPmb17xxKdHkqFE4HuE+em
	S96jIPy5rSbjq8/w/nMMUsPKgjomNdmW2dVrjohwiGla20HA3XaS
X-Gm-Gg: ASbGncuyn8Nh6wi87+BYxAqQ7v8+0ErjH/IvLyFP6vYKe7XfybWl7OsNo18gQPjlGvW
	9Smt/YApmqZ4Pz1mGyxTW8RJElhFfmLNLHM/P0teO4obiETsMwzzlueZwKZqjXBI5gWApL/5Qas
	hT3twAsFi4oj23HYalLA23MD0TL06ADmuYFMz+kFDLT4Gt9k1G8O0ftRPEqbN/WKL9hkpcngvAw
	wCFyD+knw1B4zqwZGCaL39KEwdF5DMRIj2ziaLbsPX4NRuS63MZ4d974Jk=
X-Google-Smtp-Source: AGHT+IGEVK5poKxbB63HZNpxWJ0TOq/vH32vHtcO5cLbMPftU+NGnE6tWAJzgOXbe6RkVzcZoCqROg==
X-Received: by 2002:a05:6512:2807:b0:540:20b8:7341 with SMTP id 2adb3069b0e04-541e674453dmr2145347e87.8.1734608355899;
        Thu, 19 Dec 2024 03:39:15 -0800 (PST)
Received: from mva-rohm ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223600596sm150514e87.92.2024.12.19.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 03:39:15 -0800 (PST)
Date: Thu, 19 Dec 2024 13:39:11 +0200
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
Subject: [PATCH 1/3] dt-bindings: Add ROHM BD79703
Message-ID: <51ed31c494ea7385940b59500e8592d12558e291.1734608215.git.mazziesaccount@gmail.com>
References: <cover.1734608215.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9o14pXUuXWBlH2+R"
Content-Disposition: inline
In-Reply-To: <cover.1734608215.git.mazziesaccount@gmail.com>


--9o14pXUuXWBlH2+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79703 is a 8-bit, 6 channel DAC.

Describe the dt-bindings.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 .../bindings/iio/dac/rohm,bd79703.yaml        | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/rohm,bd79703.=
yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml b/=
Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
new file mode 100644
index 000000000000..c51b4037fd0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/rohm,bd79703.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 ROHM Semiconductor.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/rohm,bd79703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ROHM BD79703 DAC device driver
+
+maintainers:
+  - Matti Vaittinen <mazziesaccount@gmail.com>
+
+description: |
+  The ROHM BD79703 is a 6 channel, 8-bit DAC.
+  Datasheet can be found here:
+  https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/=
dac/bd79702fv-lb_bd79703fv-lb-e.pdf
+
+properties:
+  compatible:
+    const: rohm,bd79703
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 30000000
+
+  vfs-supply:
+    description:
+      The regulator to use as a full scale voltage. The voltage should be =
between 2.7V .. VCC
+
+  vcc-supply:
+    description:
+      The regulator supplying the operating voltage. Should be between 2.7=
V ... 5.5V
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - vfs-supply
+  - vcc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+        dac@0 {
+            compatible =3D "rohm,bd79703";
+            reg =3D <0>;
+            spi-max-frequency =3D <30000000>;
+            vcc-supply =3D <&vcc>;
+            vfs-supply =3D <&vref>;
+        };
+    };
+...
--=20
2.47.0


--9o14pXUuXWBlH2+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdkBd8ACgkQeFA3/03a
ocVvWggAqBr+9Gw7gyUQHiRmcBjAVOPgK5/s05G9MuaJZ+iV7yRrS/7yJlICP/yB
EhRsEp+U7Er6svngBP3lmh4jdQGjzlTWMt3d7y3g0LQhJnboe2BUD9FFWsvbwVCe
eMoKYytTuEgbUQq/agKuA8H6E/yujYS7o5azjS9VoFS+eAJqb7nlauwpcbf/ogHc
VkW3wNDWUjIdzdnFMO3qajiGQJGTe5QNYgjXibnEW6+FfQIyhgkE88X8HyhXSa57
/wbn/YPV+wtD03ZQZJd2dMaSTIFLVUaSK24ffd7T7K+LLiSN9dwOCutlHWvM5Wpu
GenetKrE6tTVzewYyKn3IHNI9eNvNw==
=96mE
-----END PGP SIGNATURE-----

--9o14pXUuXWBlH2+R--

