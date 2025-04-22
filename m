Return-Path: <linux-iio+bounces-18510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63457A971B1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 17:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B393B4F94
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A369228FFCC;
	Tue, 22 Apr 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IadmLRcU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3F27BF7F;
	Tue, 22 Apr 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337206; cv=none; b=qOV0RQi59GPVFxgW1xYB6OixqEXF+YOV8E9Ql/2r/EUAPleZj4wIxs6ZJovjnlBf6gOKFgFmTfqA+a/pOl/okMLkwdwsZFFw0hPhBVc0a2vELPMcR+0Gl9OXy/qOsDH4vsfLZGu68A1T4MzJlN48AOWcmmTDaLFNLBgl5bvZopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337206; c=relaxed/simple;
	bh=B18Go172uRiSAhge6Hu8qA/DNclZ/mWZ5WFAWKpvNQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bcsby1k271lEZyteNcvxcMDDsnEFSl0wxucbObJ4huB9lO/K8J3G6PKUQvxjBTwCO4h3wQYbGdkj7cnDge11/KUXZgQMGAid/8j98U6+ag9yVrVoKOXLXdt3sx8EuVFX9IrXqlExlp8nf4iB3sqEEtZJYGAPC7YqWL4/Y4lGG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IadmLRcU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2295d78b433so62441125ad.2;
        Tue, 22 Apr 2025 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337204; x=1745942004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qE/lukhdLOArAxxziVsGfhIsDmorURXr5J5282YinqU=;
        b=IadmLRcUxGW/HppVnzDpCnWe22v46dNjyz08wSE7+Tmshl0Ym0IUa1FMjQWS6m8FPB
         6/+ZzSwH8uegRL1Xx1lencUtTf4oPI52K3+ki6eCKKplFFsOcNRAV0GMOE2vLx5DMhby
         rNASDgMcC8VOmN0C4oaF6g0gA0JUDYeoMnUp2VyUvwMMOOe6wyfm5oPxblgQMPSD3G5Z
         JGfEGdnJFV9uNU9bGABX8YORTmkGuAQ7FiImd99tHsvxytGNpLARSLPMrkdNJwujZQu/
         ESW8lxp7qTNCyKO+ZnR2Hn7EJoVa6ktSEv7P+Klw0LCO83BcZWNYRsZf0NGscU7gaJZh
         5Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337204; x=1745942004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qE/lukhdLOArAxxziVsGfhIsDmorURXr5J5282YinqU=;
        b=P6I+BZkWD+brY/6r1ACNmfWg57Pw3iOwCBwo9ehG2rW4x98Jy4qC8mszA9SBb8vO/E
         YPY7zzrrK/YqxkKsxY6lqLYLOB6dd3K25y3UAaYAf7dYRYK8EtElEVU9/2eSbk+2ajzB
         eisuGUlpsMPmYXrSwkkt0AZiBoiVQ+eDEI9ZW77OWZ5kKhj192wpkJ/pB9HdpJ050hjh
         NZ/S7bm1McQFzp7wwilw/tO9ihn8L2MN64FMccBp0L2M0xR1a/zSt/zac/QMnaFlMiri
         yoBQhj8KyrtWg2p9TNJCuOIEDHfhqmubCgrMU+Lb9yQt8qiXBL9yMZOV9Hbqnx8nJeQp
         5zkg==
X-Forwarded-Encrypted: i=1; AJvYcCUDxG4yMMkuNVVyrX9DTRR1L+fei1RCTzlnbtZ7/BXT+se3fEOEkyqWsLV97RAnWG8JCWObRADDiDMi@vger.kernel.org, AJvYcCUs6MFMh88ZquPxnUEPkR+rqH3Jkqml6NtKXcHlIm716fG0wWGSV3rzbfxvOxbvDynWvMzIleBrzgYP@vger.kernel.org
X-Gm-Message-State: AOJu0YzcDW9pwVqp7VYaiaM4Yt+DTpF22viA5R5C3WV0wghc2aLfZwE7
	+MUwQdB4H82humLAHTL0vYZqTSUOUa7bhXm7GB1HbttUb6HZ4j48
X-Gm-Gg: ASbGncsYh7nIN0xVBAKWLXEEhiCz5sTx0mSy0AsvWGiAgqt2sRNNQZ7RlewdSl0OhHn
	oUU0LnReyYvFMoEa/an+G4cdE63kbD4XL6yA5bBwzbr5JU+09klThhX+gDe4Q7FGlk3AStvUBIp
	tKx81aJMs93QwNE2AUk7ICCuQWN3ih+LxZ3dHb2pNfeuiSLCXV/w211MHmz3dyW17q+QXm3Xrz1
	1TQZnqDM3OxIsd3yvEaUqeV1izF6xJ8WRkW8t20eMF18714WjBVORs2/etTzbzzSqblCkJaASiK
	RT6nbFzASBf8xTA/4gPjZfDP0GREswnSs4MUgDGCHTGK4O0=
X-Google-Smtp-Source: AGHT+IFi0k9jyJM+7w5X2GCk8OAEU+lHhEZ2qZMJgCzq5LQlVRPphwYUIG5jEoB4zRcREpe3aPPhTQ==
X-Received: by 2002:a17:902:da88:b0:229:1717:882a with SMTP id d9443c01a7336-22c5337a225mr250257325ad.4.1745337204202;
        Tue, 22 Apr 2025 08:53:24 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c50bdda46sm87078705ad.3.2025.04.22.08.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:53:23 -0700 (PDT)
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
	conor+dt@kernel.org
Subject: [PATCH v5 0/4] add support for winsen MHZ19B CO2 sensor
Date: Wed, 23 Apr 2025 00:52:58 +0900
Message-Id: <20250422155302.669960-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v5:
 - Include the required headers explicitly.
 - Fix coding style overall.

v4:
 - Ensure buffer is aligned to the cacheline.
 - Fix coding style overall.

v3:
 - Add vin supply regulator.
 - Drop custom ABI.
 - Drop unnecessary mutex.

v2:
 - Add ABI doc.
 - Add complete struct to receive UART transmission successfully.
 - Add undersigned as a maintainer for the WINSEN MHZ19B.
 - Modify to comply with the IIO subsystem ABI as much as possible.
 - Revise the coding style overall.

Gyeyoung Baek (4):
  dt-bindings: add winsen to the vendor prefixes
  dt-bindings: add device tree support for winsen MHZ19B CO2 sensor
  iio: chemical: add support for winsen MHZ19B CO2 sensor
  MAINTAINERS: Add WINSEN MHZ19B

 .../bindings/iio/chemical/winsen,mhz19b.yaml  |  33 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/mhz19b.c                 | 311 ++++++++++++++++++
 6 files changed, 363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/winsen,mhz19b.yaml
 create mode 100644 drivers/iio/chemical/mhz19b.c

-- 
2.34.1


