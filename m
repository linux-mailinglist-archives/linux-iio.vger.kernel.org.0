Return-Path: <linux-iio+bounces-17846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DDA81B42
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 04:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEA4207A6
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 02:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B57A1A8F84;
	Wed,  9 Apr 2025 02:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cULb74Wv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBA18F2FC;
	Wed,  9 Apr 2025 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744166697; cv=none; b=LKzNE2cCvcdTu09USdRBsCct7oFROUS/9JJ8qFX0qF/Yfb3Ew1Gc+J4D7HqaESDVyOHAht/CWTq3WiaLwvojKqr65OrQ6QpJGCZKd9C9MGntOjCuQtBFcMZzF0LI9Lu/fQ+cKxhL0LwvGlyENYe63YNKPx9R3QhagcRh2C8TnLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744166697; c=relaxed/simple;
	bh=Diy0NH5+Yai/SCCh2ZYWGW/X4ZXJ/v31Ul1qeDVuAOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HywIb6BIR+l8CEz6wyn07LpxfdWya7ybzEPbO5mXmOlMA6TKh1NlvkjiPLGMiKbeTfEYxKjfDCmNBr25+3SE9DaLmLiuxYHRVUiMRgKMnqLp5K8Ii3MozfdKNKBYMSZfhnWHwDmb6+Bo8RIXSFVOCNpipAn7ChCVyWNHBW1LOTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cULb74Wv; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso6117981a12.2;
        Tue, 08 Apr 2025 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744166695; x=1744771495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj8kpmYrdiK9mCxsMqgrjwEIay8Sc6Z78TIqN3FAEJ0=;
        b=cULb74WvpdD5zbpzTsN3LdGj9f7TufkE2/2sU8ofEWNoKK8Idoazqf+Gym9kjja6Mb
         Z9v/2Zo1/Y1UnrpcQ24RMSBGsm0mm5xDFbFaJCv9KoQjUTYqGqY799w1XQFmMCHsF/LY
         H++GuMq2VDJ5aZuukF07LPAMrfgf8pOIcKtl2u5L8umR1ualquE2a/LwGm7Om46kXUw1
         uQ0s366SDhIZcQ4bbeU1ulg4j6PcxYl7ORGJVNZXSvhvx8XoGVMij1whv0nvZpNJUyY0
         TVsdtOQsJXGd7f6Px6R0TMFvbwJhduPNMxcOfipXhvniqz6kdpV3j0Xq1bp491bDU8KD
         rFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744166695; x=1744771495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj8kpmYrdiK9mCxsMqgrjwEIay8Sc6Z78TIqN3FAEJ0=;
        b=NHssR+KvBTDjkADJsgCTH4q6ftBEeymreUde/xvJlch3G6S6HNYZ3pkM0PqcBQ1ZVG
         Ay4PPmYN8GtT+//Qg46mrijnj1a2h0XhYfOx2Xuqp1EmvZYPf+RqqCPvmkS1UWuO9Lwc
         MHoy9lIxBrkhy6iSHRQ6uTFFRRDrfUTk1xXIaEuNTjRqoXBfG2ftil5jkdZ0+vpimVuu
         aEiKWtehjR+eOySALG0RvKxKDiQRtXJtkeSXVA1LLOhBChULhfX9B2vFheenRzmbff1K
         B2lyvzPDVitVK3hmqzZ2+iAEdHqFRZNHqlcNbwi6iOl4+6aUj+jnBglZHjH4Ts+QD+a6
         86JA==
X-Forwarded-Encrypted: i=1; AJvYcCUf6Dqx0jhYn5AOocMpdBUuOq0FSW+sAS+9A1ZMYFUINRuRURB3IINtZWJaAw/1N4tXvdNt5GLxVuAz@vger.kernel.org, AJvYcCVUXuxqJ3ujshq5G+rozE+r4SzX5Cna2HXNt/2q73XPs4hxUGGFsJ/rOfxqf0x4D5QNzdZZ4gv8idak@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjiHtZpK4EmVqeLFexG1EDSpBXHg2IcrJbAf0Xo8HxQtO7chk
	23lWklEQHothgKmDV75nCiyqUuc3+Raz2Np6dysL7RtD+RU6josv/VZXgWvU
X-Gm-Gg: ASbGncuhWo5HvLm3UWOLrPXNA1ET+5yA89bp00gsN2F8GpFkBm9+t7tlyGVh9owbr50
	gAD+CcSK3Q5/GcJB9qF9QEcO+Mk8cENDWa3Xuw+bPdx32k5Rg2Nyg6pjL0ZBYxKTKOdkngnRGdI
	gRQmRv/CK6bl9/NEfNmzttnMlKlqjGEMOgWDzM8YH4NUK8HasAL2b81RGxcJMNJvWbvvhZpZUJB
	zdDg0nMH0esznh5+k+DE+BRFv+2fCzLFIynRXOAAsHx2PeXct6RFAqD9nRB1GFdRle5tHo6y2h0
	f9DXUQvGEv+wAx+ZRvLlaCLtOIbuKjvZSlSpfeFLw5ZWObvPEA==
X-Google-Smtp-Source: AGHT+IHgswI4nSouIozliEHiUSj7Kh1z8sF3fMELty8OdWwGdtz1fyUYkEt0BF0bkTHOd7QzNqiXLQ==
X-Received: by 2002:a05:6a20:d504:b0:1fd:f46c:fb42 with SMTP id adf61e73a8af0-2015afe4a85mr1373570637.31.1744166694980;
        Tue, 08 Apr 2025 19:44:54 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b02a2d3abffsm114028a12.48.2025.04.08.19.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 19:44:54 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/4] dt-bindings: add winsen to the vendor prefixes
Date: Wed,  9 Apr 2025 11:43:08 +0900
Message-Id: <20250409024311.19466-3-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409024311.19466-1-gye976@gmail.com>
References: <20250409024311.19466-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add winsen to the vendor prefixes.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae..6d35549d2e4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1689,6 +1689,8 @@ patternProperties:
     description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
+  "^winsen,.*":
+    description: Winsen Corp.
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wirelesstag,.*":
--
2.34.1


