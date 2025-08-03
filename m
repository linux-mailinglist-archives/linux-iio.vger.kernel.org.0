Return-Path: <linux-iio+bounces-22221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E7B19435
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 16:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E297AA3B6
	for <lists+linux-iio@lfdr.de>; Sun,  3 Aug 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BDC241139;
	Sun,  3 Aug 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b="chautQex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp3.goneo.de (smtp3.goneo.de [85.220.129.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C330217734
	for <linux-iio@vger.kernel.org>; Sun,  3 Aug 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230720; cv=none; b=sw1NPquhS/a8rTBFi00b7OdZf4VVptk5ubinH9cIt5YeUsRjmKZnzSWalsYr+KI1FXfN7NpB4QT8ceax0/dsj2uhAeLn0aixZ7QlAPcSOR7BUO4UYEAtywb2qip/5hCjBMnjyhNgUL8AAcljY4N4O20at26Eqy5F0aA8L7Jkgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230720; c=relaxed/simple;
	bh=PqsH5nOqkzGnmVmzxQdRSl+IGfaaOvUATEcx0MSeL9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0TlTmzLSGWkUKSAKArR1CWjD22nyXErzkazGzXs65fGoGegrtNvnyvFbxXI0BFQfh/xyM23Nl0wu+tQJtntLgTbLeWfVigEBNlJnLxgeT/OdBZDXN2hhy4ySoWitRp5qUEirctWyiqOR3D4VCCne8Mz/B4DT/S1Y0/rmQrThU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE; spf=pass smtp.mailfrom=Stromeko.DE; dkim=pass (2048-bit key) header.d=stromeko.de header.i=@stromeko.de header.b=chautQex; arc=none smtp.client-ip=85.220.129.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Stromeko.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Stromeko.DE
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp3.goneo.de (Postfix) with ESMTPS id 1A6A62401AF;
	Sun,  3 Aug 2025 16:08:50 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id E7CF42402ED;
	Sun,  3 Aug 2025 16:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stromeko.de; s=DKIM001;
	t=1754230130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKPhefsKsYTU6dMo+RRSV29v/QZL09eSjRTclBcEg08=;
	b=chautQexrbzafjbUfFpcZkRCVfPFpxI5OoizSRN79T8kVgiPFsPXEu7qYq8n6NbQ+SDHZ8
	uoRJ8pC9hYF8ndwGTNDA0BBkSL2uR1VsgSRaWjt93+zjulKh7OfZEUNiiiJOUuZJFuUXbs
	UarzaTRkqz2MReJVLESqKwM6CklhTzxo+SyBTdrAvw72MsVuWPcIllidFky4bbQrniBHtp
	gLLVihXeePJ15BbnU6X7Lcs2Rn2jwftk4lJFaXhhChh206bYUXGj3ipI3isW8WUKiXMEqC
	UNV0mYolWsFu0O/HGbk2jFu/XvCiR/OOa1Zt0vOMmdAh0xKVxHWmlocai7G4ug==
Received: from Gerda.fritz.box (p54a0c634.dip0.t-ipconnect.de [84.160.198.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 84DA2240206;
	Sun,  3 Aug 2025 16:08:49 +0200 (CEST)
From: Achim Gratz <Achim.Gratz@Stromeko.DE>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Achim Gratz <Achim.Gratz@Stromeko.DE>
Subject: [bmp280 v1 0/6] Fixes and enhancements for the bmp280 driver
Date: Sun,  3 Aug 2025 16:07:56 +0200
Message-ID: <20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20241017233022.238250-1-vassilisamir@gmail.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 502dd2
X-Rspamd-UID: 8a22b5

With 6.13 a change was made to the bmp280 drivers to use MODE_FORCED
instead of MODE_NORMAL.  This broke userspace functionality: reading
from sysfs interfaces no longer worked and an error was thrown
"Measurement cycle didn't complete".  This series fixes the udnerlying
bugs affecting the measurement time calculation and implements
additional functionality not available for the BMx280 devices
previously to allow the use of the sysfs interface in MODE_NORMAL
again and control the corresponding parameters.  The implementation
follows the already existing facilities for the BMx[35]80 devices even
though the actual functionality of the BMx280 devices is slightly
different.

Achim Gratz (6):
  iio: pressure: bmp280: correct meas_time_us calculation
  iio: pressure: bmp280: reduce overhead on read with MODE_FORCED
  iio: pressure: bmp280: implement sampling_frequency for BMx280
  iio: pressure: bmp280: enable filter settings for BMx280
  iio: pressure: bmp280: remove code duplication
  iio: pressure: bmp280: implement sampling_frequency calculation for
    BMx280

 drivers/iio/pressure/bmp280-core.c | 335 +++++++++++++++++++++++------
 drivers/iio/pressure/bmp280.h      |  28 ++-
 2 files changed, 297 insertions(+), 66 deletions(-)

-- 
2.50.1


