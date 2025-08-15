Return-Path: <linux-iio+bounces-22748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6BDB2798A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 09:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1707D1C25DE6
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 07:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDCA23A984;
	Fri, 15 Aug 2025 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=erick.setubal@gmx.de header.b="Gsv79gcJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AD13FEE;
	Fri, 15 Aug 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241250; cv=none; b=oxfxpc1+fQMjzZREtORiTZ5kthU7LJruyCjvBf5EGNbHR2tFV6ku23WuGbdAiqr6iJ/61WpUtvydEYBIxGtdbdh5ShxicJPf7MtAYvoV1cWndCIcZ1NkDyZqQB0RpaDlPlkmQo4UQmVMkuTxf3Br7b6Ur07weO45sW/shuu9sLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241250; c=relaxed/simple;
	bh=pX1DCr78qzR8wEynG+gs7zQW1xFyCpbzB7os8xu8bC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=febp+gb4KJl3xViufxecmvBKMg92nqqOWdlbQiKYNwlqaykxqahEIp87bCPUS01UFHjOmtsHSHBTPZ+HkFOqjn7FZi7+fPWcGacYSWW2ilwGPsed+1LEAZCCiwW/dizJNwTApp8vm+6cifeoNaAkud85G6BAUPwwqyQ1ivDNbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=erick.setubal@gmx.de header.b=Gsv79gcJ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755241239; x=1755846039; i=erick.setubal@gmx.de;
	bh=pX1DCr78qzR8wEynG+gs7zQW1xFyCpbzB7os8xu8bC0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gsv79gcJ6ekdWQbesqfGlS4A368sTH+ve7rSBdaQwXFciz8S8vji1ejC/H4kSPeC
	 vGM5reF1wKzm4Wlfgopibvc9hZLZEu5MyNxcdD+3ydxNN3WsS2ostDKWH8MMFAJ8c
	 DgQ8B2a2jrmvjSHK1M1y8llPoYtATcJG9jkvsd5PetH+9IsvqETnSjL5M73jZYsEZ
	 HGN5oigcCY5j3/0KxkG/gQ0H9ShwGbJPoAvkbVUTa8zw2gQfvKWtsOa6cRi350E2k
	 CwuJjlT8wBB7TluDq0x6mdWRa0jSD+fCFLBHyBSBKhipmC6xIJVQ+v5MWzeYthbFL
	 Kz9WzA19dy6lJEI1+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from linux-eks.speedport.ip ([62.224.193.197]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N1Obb-1ubM5t2axX-00rJUZ; Fri, 15 Aug 2025 09:00:39 +0200
From: Erick Setubal Bacurau <erick.setubal@gmx.de>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	Erick Setubal Bacurau <erick.setubal@gmx.de>
Subject: [PATCH] docs: iio: bno055: Correct wording in driver documentation
Date: Fri, 15 Aug 2025 09:00:01 +0200
Message-ID: <20250815070001.55185-1-erick.setubal@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UOIJcsUbevIxp6KeBl89+THnVZBVUhJ++XXGnJOQBA6mUP62zm5
 Y92gLiv0RQKPIW/o1lxXgyCHAiEK67akxFKXx5vIMaT9CP3tR+ntF9DUkuwPWSU6blo58YL
 SJ/ScbGzdAwYE4lv19ItZt55842bDRUqVDmtLPovq6pHN6ZFp2FfqaJlRc4Iy9VqRsLhRG3
 /jukuWgltXJLVn8fEcFYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XXTisUSTuvQ=;gl+TbNnyZaEH210Yu6tPVKb22no
 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
 g77ddlBj7KnlrPS+geyQvzIpSnknB36GXcXvd

Fix typos and improve wording in the bno055 driver documentation.

Signed-off-by: Erick Setubal Bacurau <erick.setubal@gmx.de>
=2D--
 Documentation/iio/bno055.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/iio/bno055.rst b/Documentation/iio/bno055.rst
index f1111ff3fe2e..c6042586b2ae 100644
=2D-- a/Documentation/iio/bno055.rst
+++ b/Documentation/iio/bno055.rst
@@ -9,11 +9,11 @@ BNO055 driver
=20
 This driver supports Bosch BNO055 IMUs (on both serial and I2C busses).
=20
-Accelerometer, magnetometer and gyroscope measures are always provided.
+Accelerometer, magnetometer and gyroscope measurements are always availab=
le.
 When "fusion_enable" sysfs attribute is set to 1, orientation (both Euler
 angles and quaternion), linear velocity and gravity vector are also
 provided, but some sensor settings (e.g. low pass filtering and range)
-became locked (the IMU firmware controls them).
+become locked (the IMU firmware controls them).
=20
 This driver supports also IIO buffers.
=20
@@ -24,14 +24,14 @@ The IMU continuously performs an autocalibration proce=
dure if (and only if)
 operating in fusion mode. The magnetometer autocalibration can however be
 disabled by writing 0 in the sysfs in_magn_calibration_fast_enable attrib=
ute.
=20
-The driver provides access to autocalibration flags (i.e. you can known i=
f
-the IMU has successfully autocalibrated) and to the calibration data blob=
.
+The driver provides access to autocalibration flags (i.e. you can determi=
ne
+if the IMU has successfully autocalibrated) and to the calibration data b=
lob.
=20
 The user can save this blob in a firmware file (i.e. in /lib/firmware) th=
at
 the driver looks for at probe time. If found, then the IMU is initialized
 with this calibration data. This saves the user from performing the
-calibration procedure every time (which consist of moving the IMU in
-various way).
+calibration procedure every time (which consists of moving the IMU in
+various ways).
=20
 The driver looks for calibration data file using two different names: fir=
st
 a file whose name is suffixed with the IMU unique ID (exposed in sysfs as
=2D-=20
2.43.0


