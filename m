Return-Path: <linux-iio+bounces-20349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBEAAD37AB
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A465B189DA3B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A702980DA;
	Tue, 10 Jun 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CNz98/qQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29B295DB2;
	Tue, 10 Jun 2025 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559861; cv=none; b=uFponuQxzbV2OIujUEFuQYHzctPOPlc2KjW110ekVgz/HkTQ9WCbfdgo6aHCOIv+PoQtQ+PUJnp/8xuIx19yRb3wddWlCnC59+0K4/KTdxP65VBQUCVGKQ1mfIlHc+hnq17NyYzde6S/003oY/u3esU8NG7oUPXawaEiFus1l14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559861; c=relaxed/simple;
	bh=4uAmNwzlF6gH9SKi7JLCPMR8x1PShZgHQjyth9xnt3I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcRGkJ6JmtrK6bTfD0EC7Hc92+D7g7lnfRIN9P7w6TP59/lTTxX6/oXzha+SAAAL99eqKYl6B+9nkbKWaBYfApCDI61ovLxOQWIoeZ3O9mGP0VyN8d//MbrlTxCkS1wJktwdCbS7DJfzgze8EnkwpluUZhQWybsX879+HmxbUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CNz98/qQ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ACLDZr012939;
	Tue, 10 Jun 2025 14:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=pJAee28q72qTBjZcGP6IMl
	+e1YIXch0GS+MmyHTBJTg=; b=CNz98/qQnnuBxhV5Kdj2cMdL+uycW/qV2Hms1h
	eorEmBev9WP7jPcbcFDXsPIYPve9s14fQhgGE/jHulo6KeZxnr6fVArNtcNxetxQ
	9AqGhP+WUFAn6ut7ZvoxaHSufPT/Sf9ENU7o8m6yw7YXG++o8QnAzGcGxCTX/jLq
	69n74N/QxcBN0R7YZzEsd7n6duxGw42+4U7pQ5+KdsCYXn+HLVMTN52NJMa+kf+c
	xT6fUGTqb5ZV8VIvZ+3KVDA66d6Iww+iJjyEEVrnrzZUXM4YiWLZ6gy2IRD2C6/O
	PA/EPcnZTOqzJw+iNFpDu5Bo/TDkZzB0TenMNeaT9cNbDkpQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474aumd9u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 14:50:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 64BEB40044;
	Tue, 10 Jun 2025 14:49:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7854AB35DBD;
	Tue, 10 Jun 2025 14:48:59 +0200 (CEST)
Received: from localhost (10.48.86.132) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 14:48:59 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>, Lee
 Jones <lee@kernel.org>,
        <linux-iio@vger.kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
Subject: [PATCH 0/5] STM32: Fix build warnings about export.h
Date: Tue, 10 Jun 2025 14:48:50 +0200
Message-ID: <20250610124855.269158-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_05,2025-06-10_01,2025-03-28_01

This series fixes, for the SoC's STM32, the new warnings that
appear from v6.16-rc1 about mismatch between the include of
linux/export.h and the use of EXPORT_SYMBOL().

Antonio Borneo (5):
  bus: stm32_firewall: Fix build warnings about export.h
  iio: adc: stm32-dfsdm: Fix build warnings about export.h
  iio: trigger: stm32-timer: Fix build warnings about export.h
  iio: trigger: stm32-lptimer: Fix build warnings about export.h
  mfd: stm32-timers: Fix build warnings about export.h

 drivers/bus/stm32_firewall.c                | 1 +
 drivers/iio/adc/stm32-dfsdm-adc.c           | 1 +
 drivers/iio/adc/stm32-dfsdm-core.c          | 1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c | 1 +
 drivers/iio/trigger/stm32-timer-trigger.c   | 1 +
 drivers/mfd/stm32-timers.c                  | 1 +
 6 files changed, 6 insertions(+)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.34.1


