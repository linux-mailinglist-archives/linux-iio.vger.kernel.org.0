Return-Path: <linux-iio+bounces-7471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A792BA08
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D841C21798
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3015699E;
	Tue,  9 Jul 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="q0TiX4GI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02915539D
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529769; cv=none; b=o/pyFpB64Ic4lEBCYoO2ef9LUDrtzu8gDAXpYhE/dYf2Rxh5STaqQjj/FSlWQf3ahwP2KiiolLc3xcTvAgN/S5JlpTqif0gHaXuIC2CGKyYIZgKi5T9rsqC0waEXX4YLgf67vGNf+zpguorGVKfrl8mUzNxH+MP65Lj7rRlXjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529769; c=relaxed/simple;
	bh=1mQ27usrQvicYMPygqOYmyZaZ+dqCqB7Hb9uZJQFy0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rUg4SLSPD2q541kHApYBkesOhnJhVw5JEuDmEzW/v+cdV8U2Y9E7mUPRN7Ju7vx1LTlGRPoKlGz2yhbfOlxbIs4n9XmDDgVUMtaWZhn2ORqz8W9MlrrPAukcgMc3s9M/95x4IiXoPIWZT7BsQyK/jcPLEhv5a8NVdPNrVlPoDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=q0TiX4GI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee98947f70so42080581fa.1
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2024 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720529765; x=1721134565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nr1AM+fDk7Hri75Oy0exjRtso/vQOFRBiEuG64RKjDU=;
        b=q0TiX4GIJ7pR4UUm3UFs7b3Z+6glz9+K1ZSd+RQGqxFQu2+H5kf2uAbi73xXxxdgRm
         /P7u6Wp9GR/ynybID00+H5UX/qDNBOBBkdWFaHXsi1CiB35uVZp6vtPMUl8CHVb3/IZG
         2XgKqBggfC1AvpErg44sOKowX1honCN2R/PvGCRApv3zOGm399jauPjJj0KppiF8fpyo
         sgQFZq81lS7DUFtQbfGWmhCDLusNaG8JksNNfkDkvAjwroogFgGBhzJo2zuSKziugzfh
         lq1C4jwXmX4fMsaw9x9hk694vycLLYFt/W1cu6OLOrM4rqefioR9JbmtPAkwKdBQ7+Pt
         NPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529765; x=1721134565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nr1AM+fDk7Hri75Oy0exjRtso/vQOFRBiEuG64RKjDU=;
        b=QR/3qCK1JAZYQeHKuImyBr23JQUBV6JGd7N6ylopt/nAkO/xdP0E17SybPx4itoTWd
         et1HyTAkNYkbH8OLBp5/L+YbTKv4lrHAsGNrNHi4MdTSYdzouRIR2LJ0abSo5EGNnlGS
         44f8pNdDlLWfkRmfDGEMj6Ydbs29RRva28Eqnbaw2rOFMKE8RYMGUo5lWxOPEbbT5Yfm
         vG+uc2jZOxq4xVqSURMmHdMQDheHL+gEaszeslmEVMYJ01S8MemL7Dq8CV2Dr0iyESqi
         spPS5bW34waJvVSjOlaBZkOzDKzj0c/QTVqydz3JV9LXXkpPDPT4SMSVxxu3Ndu2ON/9
         746Q==
X-Gm-Message-State: AOJu0YzMh+oALO5/PKa8VLcpJ72Bl/UOFrGjAuJFcfJYMFld5bX+ElKQ
	lKU+akOkTYe8EPZrKRDKlbqhXIDC55bFkNsiqYJK01n34HDK6Qc8wBoxLxEekbvOzp8XPAKYUta
	t
X-Google-Smtp-Source: AGHT+IG8GHZ17xgCFUdlojYt9fTp4hlfExAQp6WMhX5pGinWdORsY5x+HIh9yisJj1/RYwlO0CeyAg==
X-Received: by 2002:a2e:9259:0:b0:2ec:5843:2fbd with SMTP id 38308e7fff4ca-2eeb3188e5cmr15954351fa.41.1720529765143;
        Tue, 09 Jul 2024 05:56:05 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e095sm2496757f8f.23.2024.07.09.05.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:56:04 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org,
	Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH 1/2] dt-bindings: iio: humidity: add ENS21x sensor family
Date: Tue,  9 Jul 2024 13:55:34 +0100
Message-Id: <20240709125534.988703-1-jfelmeden@thegoodpenguin.co.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree documentation for ENS21x family of temperature and
humidity sensors

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 .../iio/humidity/sciosense,ens21x.yaml        | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml

diff --git a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
new file mode 100644
index 000000000000..3140349a58b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/sciosense,ens21x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ScioSense ENS21x temperature and humidity sensor
+
+maintainers:
+  - Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
+
+description: |
+  Temperature and Humidity sensor.
+
+  Datasheet:
+    https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
+    https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
+
+properties:
+  compatible:
+    enum:
+      - sciosense,ens210
+      - sciosense,ens210a
+      - sciosense,ens211
+      - sciosense,ens212
+      - sciosense,ens213a
+      - sciosense,ens215
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       temperature-sensor@43 {
+           compatible = "sciosense,ens210";
+           reg = <0x43>;
+       };
+    };
+...
+
-- 
2.39.2


