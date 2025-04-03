Return-Path: <linux-iio+bounces-17570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC62A79B54
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25347A61C6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 05:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E76E19D897;
	Thu,  3 Apr 2025 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3ucKUdO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485D19CCEC;
	Thu,  3 Apr 2025 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658467; cv=none; b=P5WyOaps40fQu2OXlOPodLeKFBS1W6k0xUZ27LVvAt9tm68IgzfIYV38+KhqLP+IsfKjhY75nmGCTXDeBAHljFmMQYk9nboXHteVydBTIKD4JTp27XcNAmSi89RTsp4XriVJmw6e6K5QA5JDYsVtevIoKSZD21cxn9JSTxvvhmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658467; c=relaxed/simple;
	bh=hSrl4Yd4qs6gKIOXwcZN4iwmnSX8vsZ4UzlLhnJFye8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5Rye4I8SCS0fgIlOGGk55ReC3+UQuqXIP7SXY0HBgrBNZ2SIop0aQYSDUGyQPKaInAO9z7WPE5cNBGxVi8OAfm+GVgvFeAaZOWd9jfaHT9dYRZ8h8IXU/TlQvLlENXPtC8lXwNxbQmI9bOQl4lR/aLO5JrqhOoTcWIlc0p7Jkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3ucKUdO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225df540edcso22115545ad.0;
        Wed, 02 Apr 2025 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743658465; x=1744263265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p68hZDkCnGzhFlhvnUMt2CtWrkoGWDvwJns2pSEUGu0=;
        b=U3ucKUdOMIMbuFLqYtqMaQdr10Za/oA57PMab6NfG6HUP+SOs+WDZMSwPFEbnzE2kI
         Wuhx3FA8nzZMuFmGMONohBb+7AZ2QexoykFPF5VEENL1d8x8Za7a1gqd4RMO3YWdAWKI
         gfMJkelCCxCD1Wu9tumWaIqZ1Sa43MOiSKK4fukvl7PXlTBQdANfVJMp0KHQUgvrmSwk
         vufc3xH3yPB/YnaPTDJ5nVq0TVF5Q4EhrqXsNPID/Yb6V1Db6pnpGkAtw3KvknI5Vhl1
         AGQsEeR8bAdhl262uBzXnVfBDKZP2uvcQFG6xJ6XEhqiLGJm2PC41iYlwxOdjD31/J3i
         wlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743658465; x=1744263265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p68hZDkCnGzhFlhvnUMt2CtWrkoGWDvwJns2pSEUGu0=;
        b=CPkbmSGGOkt4iukjmHfpE8hqA/8AmypOyOvqB0BXVN5TSnOPBsblqOCOW9HZhvvyfb
         /JQlcIYB/F9VtLprckwvOQnUH/DMPA5rogTA0os8ExQagZSCTlrZaUgRDKuY656MJAVd
         2eZO1/TS3faYtt0gFZZgYas0mkl+2Iz1owbCoiroHfv4teu/2StUyyA+iQjLnR5wy/j7
         ctw1MG1Tv2bwh5MzTuHER2ogOBrnnFKUXwbZ8FJ5zp79i/u7yJP099XFYEQa4wODNzJC
         x6SiKxaJSYiRg/le9NOrVbjSCfJRi5BUhdVdxm5h4lpn5TejU81gGvUdkNji7rGTUVAO
         jfdw==
X-Forwarded-Encrypted: i=1; AJvYcCUjsBI6r0vudHStpV45NBhN3vUN7vlaJShCNxhg90+GbVQq2ESq93pspj/9FSgTU2bGduMvU57VcIjX@vger.kernel.org, AJvYcCUsc+EII/yRg6ocGmyWseaipFQVP3WsAwo/Q1sVk3MqwDTgdB6M93JA0Wm6j2+gu03bMIBh6iZg4AqS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rSFOO7F+1lNBHl2OMDXuG0e97f57mVt9bW0LLdAXA2LouTgJ
	KrA3iY9VrborflF0FlSW/eQP02UXBzmSHKIDVqzySzTFZGrfrkhH
X-Gm-Gg: ASbGnctxHK2PgrQdmLLPOdc1Js6Q3J4YJWyvIwxo15stzxcS71GgeOTSXFGFwzWtaOb
	Ba7BXaXFZW4Y3CwvR328Z8QjkD/nC73qmWbmwkSKoRk28C+eYp6TOBWeFhFFtuQ/EmHL/+akBnP
	a8yyZ9xafb40bWd0Ks74Bqm38O+oaQeumUaoOKxiZ4Bi7xblOWHXpzecwn9hhOTScs5y+slBb3z
	DPbEpRrB2YUvMk3dijxe1iSMmlF8pgfk1ozoG57z6+RSxV2n6kRfddhUPu8LRH2nxfYrI8deKsn
	MYhw/9DvcmEFU36rotFu6Sa3Z++L0pkRv/ujZ0hLtgjAFLbFJTzpmVVj79AD
X-Google-Smtp-Source: AGHT+IFHdPbA5g+HSszh5t6L6AoO/OLBeT3e1aqjC3bbbCWU+/xNb8agMYD8z0+07HiY0tAM4+qbQA==
X-Received: by 2002:a17:902:d510:b0:223:517a:d4ed with SMTP id d9443c01a7336-229765ed0b9mr25325835ad.15.1743658465397;
        Wed, 02 Apr 2025 22:34:25 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([61.108.38.194])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22978776601sm5537575ad.237.2025.04.02.22.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 22:34:25 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
Date: Thu,  3 Apr 2025 14:32:23 +0900
Message-Id: <20250403053225.298308-4-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403053225.298308-1-gye976@gmail.com>
References: <20250403053225.298308-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for winsen MHZ19B CO2 sensor.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
new file mode 100644
index 000000000000..6cdfd34be016
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-mhz19b
@@ -0,0 +1,7 @@
+What:		/sys/bus/iio/devices/co2_range
+Date:		April 2025
+KernelVersion:	6.14
+Contact:	Gyeyoung Baek <gye976@gmail.com>
+Description:
+		Writing a value adjust maximum measurable PPM.
+		should be 2000 or 5000.
--
2.34.1


