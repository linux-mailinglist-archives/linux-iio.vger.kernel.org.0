Return-Path: <linux-iio+bounces-19244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6CAAE196
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084B11C252F1
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F040B289E35;
	Wed,  7 May 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lFAhvrr/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7552289E34
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625925; cv=none; b=iCkKzvopZWUXkGIMUCL8yjrC7ekNlmIXTHGsZLEQ0CHbW4YX4ct65JaNyzt0GrEGvJDJ+La3GRQhLGK1tipIqmC8j5PuSWpP5tD7QUFbZPi49a4Pcof8dZOCV3o8tUf3LieZDCknUhIUnl0zSyBkRn6dQTtBRnQZYO6Jaq8w0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625925; c=relaxed/simple;
	bh=5LLKe8a++xD2c3tJVJ8drGjnk/736Tl6kXc3j0/ObLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ncExgUTNhZ6QEE+Xosyss9xYNhxRgBvdj2U4gkUWy4yNf0kRi2eXLyjE4waczbo4nP0wThibOR8KiNslhADBfDoqoTp77e4qoy7x7eYTQJkoIeTuF7DXEDHfL3eWX7QRA4mJZFRGJjW8Sax/63RDxgJ8si64TRB+3KDJH3SFpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lFAhvrr/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so10969607a12.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1746625922; x=1747230722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GeKwUyzeFoIF4XHNI7B0gCteSiC3k5ZfaiHzje0KNY=;
        b=lFAhvrr/x2lCs9AaM/SYfyToFSb5i2OyrG4DEJm4NkxKfoRAsd3erSklk/W8AJ1JMM
         mUJqPvjfLN0DXTjKTDqhuenAUbGp6bEPixhKMk/TCst8b0MCfBrTVhElgkJAVv4WEkQ3
         ACgZmU6p5+YtfDKuJpo0xQg/imF8f8l7hezmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625922; x=1747230722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GeKwUyzeFoIF4XHNI7B0gCteSiC3k5ZfaiHzje0KNY=;
        b=w8WZlhtght0WOanTAHWuCzf+/a3cfeI806f1sZQlUj2HUszdVvbRdCHXaiRPn0OBbB
         l8HjaNNyxRxX17wPht/KzBzfa+R3qp9pTVmkSsTHdQuRp1C0awe3L1h4OVxH+UJjQx+f
         XmzuSFfA9Y6fFepIXl36I7upaEJ4/TroU7pDcKeo2/qDw9vf+hzrCEta2IFRCJ61++xW
         IXQ9EdQgwrMRJmOi3mOxh8ywoYp+OQHWGF7T5sDpwgDm52Irpb5mXHJgJ9NPPQ6Q69ap
         m5No5ESq8bcCTFVbEudiHgbadcWJN79A8oeo5qnczAxhbyWPE+gIMbLFXN8ddiyyy/QM
         XoSg==
X-Forwarded-Encrypted: i=1; AJvYcCVHuQ9uCS9lTiwA1Wbq5xQJSYOW5i9lfpO2/4c99t6SLVhKfANVZvEJZFe6lbRG30J67XHCvkem8jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzeze3Yb6vPsgXNvKbUdeEIQD1n1414xvx/S8QWzLujuurxieR
	lV5rK5Oy0SVc1TPMRIPyQqMtDSfmQ+zj0gz5KpG2oUySWsMr9jA/Eu7vD8+WBBQ=
X-Gm-Gg: ASbGncsjcAXfCyaShrPuv8g/gbVD0nNc1zxtycEGVCbEsTExTh6Uag2AFcUh8T7M1hc
	NlitXN6GaLfhLgooIJs7vip24J1tF0wmCk/1P0/lGjHVCxKFkibhNsGvSBtcDvQ8ZCkWV8eZB8u
	CrXphma0iQfnFYgry96Fmh9xipBAUsZ7S4MQC0PhGawVDF/7TVwLqSrqyxcZ75r5sWI8ygyHId5
	7hqyCCvMiv6rZ+0s3wK1sk6EMYGgF3EUoWYbV+FTF18kWA6AtVWm4Y+Di6oToZ3qnJ1BoCgDzs1
	xQbmFkfD80D507a+A87bNoIV9SG+ZUwYB8/ZblU7BWNG3haEhIEqJF3Yfty7JLeI4FY7xWT773n
	D/rXpwDbF6XHtCjBDE+GSW3hmH+qUJw==
X-Google-Smtp-Source: AGHT+IF8nFh7Jj3E3ztZAdeC2ct0kjtnQ1x6LvMRae+EEiYHTrZbN6TQQ4YbOvTXqTUEGvOdOJzFVA==
X-Received: by 2002:a17:906:bf47:b0:ace:6a18:595c with SMTP id a640c23a62f3a-ad1e8ce4c1emr334611466b.16.1746625922122;
        Wed, 07 May 2025 06:52:02 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.43.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a6873sm920845266b.61.2025.05.07.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:52:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: light: apds9160: add missing type definition
Date: Wed,  7 May 2025 15:51:38 +0200
Message-ID: <20250507135147.1328639-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warning:

 Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition

raised by command:

 make dt_binding_check  DT_SCHEMA_FILES=fsl.yaml

Fixes: be464661e7532 ("dt-bindings: iio: light: Add APDS9160 binding")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
index bb1cc4404a55..f9c35c29fe04 100644
--- a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
@@ -37,6 +37,7 @@ properties:
     maximum: 63
 
   ps-cancellation-current-picoamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Proximity sensor crosstalk cancellation current in picoampere.
       This parameter adjusts the current in steps of 2400 pA up to 276000 pA.
-- 
2.43.0

base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
branch: fix-brcm,apds9160.yaml

