Return-Path: <linux-iio+bounces-7111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0991EB81
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 01:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EF1F224DE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629A1172BAA;
	Mon,  1 Jul 2024 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="MJm72Q0i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C43502A9;
	Mon,  1 Jul 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877536; cv=none; b=d6Xc7vIme9JAqrjLduhJe9l8jgn00YEExpQ/YqWAE+LGSzQfHe2Yp12IRPp34qIUsqOdkdRDIihEjrR9LCIGbJGSM86eNwuCewnFRFHnYAbyJAjyRyWE8pW2FQr4rGagXsZw3j1C8ujgK/VPhp6tlrDWGL0uWJDUXTv5W5HnNWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877536; c=relaxed/simple;
	bh=sLHYDUClzFe8ceyCDc93RSvaPE+NuHXwSlwFTQtAxbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VcwBpYkcCLgB6Em5UcC4L1AHx3iFvmoLo3aAvyppokEx4jpmOtllLLCPHhhzT9NU6KJQcO8BBPchqA+i29K5tgskmq26pcvIowXUpNU98y2j3jOkglB+TqQEGVz3LUp4Xpz5YKQ4iLzHKHgwbvHqmV8s8cRmbCQsB1LY73mlhR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=MJm72Q0i; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 7F115100003;
	Tue,  2 Jul 2024 02:45:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719877508; bh=sLHYDUClzFe8ceyCDc93RSvaPE+NuHXwSlwFTQtAxbw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MJm72Q0i1k4V3EwqWz8WA2WDSxJdVAoQACFMT1km3bw7lW40Ig8LuGZYpLcooJO2U
	 6ydGIcCYN2VPqOSpb/K1AQsg4qRQZMd+2FsE5AQkqOoS6qlIpKFJb1FZStUZiD8UP9
	 t+oGf2wKESrxqVCvHC8pFAAyZgsJ1/+ZVs6qePP8UqlE3ikWHGjYlE7bXjXFW4Z8ij
	 afFjER1HLcH0mcIoC6ZvNLjRm+g5aXQNCcSX/mFaHZuD6c2dxPCT2F8wIF8JJGrXSp
	 qX7WCK5N0W49zG4Dq9rAJfWLN+UNpV+9ZsycNVNDzmnhtJVzYJcWK/Ip/HcCEPdApT
	 lWTtFXQiSUrhw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 02:44:02 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 02:43:41 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Graf Yang <graf.yang@analog.com>, Mike Frysinger
	<vapier@gentoo.org>, <linux-iio@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15/6.1 0/1] staging: iio: resolver: ad2s1210: remove call to spi_setup()
Date: Tue, 2 Jul 2024 02:43:23 +0300
Message-ID: <20240701234324.20811-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186263 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/01 22:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/01 17:38:00 #25803542
X-KSMG-AntiVirus-Status: Clean, skipped

This removes the call to spi_setup() in the ad2s1210 driver.
Setting MODE_3 was incorrect. It should be MODE_1 but we can let the
device tree select this and avoid the need to call spi_setup().
This issue has been fixed by the following patch which can be
cleanly applied to the 5.10/5.15/6.1.y branches.

