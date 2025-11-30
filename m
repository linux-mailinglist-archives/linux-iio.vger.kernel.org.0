Return-Path: <linux-iio+bounces-26570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB213C951B2
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E073A2810
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B9283FC3;
	Sun, 30 Nov 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaaDrKoB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6FB27FB0E
	for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764517079; cv=none; b=tZvpKxI7uhYHXQyQuBkNSiGXns4SakM7TPNxAUGm1lAgYtJpOFVN1rhoo3M9jy5XfcDkJS8OI5V8IqO+Ktit5vj1hiTvrSiW0afee5FMyep6dRFZSN9cwCGBQ0MwzbQceg6cSXNReh928Ro4+391MXwckdI60TkzlpORgX/qH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764517079; c=relaxed/simple;
	bh=oDwSQ2DgZN5UPeFyVpapzafOE9JeM+6gEZ340+HFjeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a85yEOU1qpR0Fq6B3NMEBzS2fUkr6Y8ss8/zIljp53F8wzMbx6I3M/jANm2gRtcsjitTQW1ArWPNMmX+m7pnhMv4sjeDZ1gdSHGt4ZiN95EIjNu14wsMV2p3p2pYhKxRBS5XsEsQVK+Pmw1LrP2WIH492LKIIxbevRBsj1OMhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaaDrKoB; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-298456bb53aso43581075ad.0
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764517077; x=1765121877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUC4dObEfZpG4uC9TDLTiGB/YUFdpvHOo5IRraOFoc0=;
        b=AaaDrKoBBWXbYR+XJ45UhslK0Au/2xTcSPZHNVSVzmtE88ICKipBg783/xdXC0rZfK
         Rm7ATPEAr/UqhvRHA5HSQRz8Lld5L02iZ/VWUFnV6/g3wjextCMpAMz1Q/utszBlzuPC
         q6RP0dWOTsvztnGthzLOlZPR5xXieRAnep2SxWTe1lrSARYws+EIK6NqXb5jl3K6+GtT
         JKCzfIn+BuoZgdm9RZuWWstmL1gSgCaWaDMUEDo0cJiBwc3DBfjhp2Ohw+dt0HU7iKNd
         JzJHGKSKqkCB2LM1hq2cmvi2zBw1RRjykJASJm6sDip/tFdNMVHHuM0u2r0ZOVvjb7V6
         54Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764517077; x=1765121877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUC4dObEfZpG4uC9TDLTiGB/YUFdpvHOo5IRraOFoc0=;
        b=Yi6QisyNkYVcptP1fFAeSf/hwHXfyez8bQtfC2eUbtPbypmk6K7OUnreT+OsiZLpCJ
         rMTdYhiJLCyrHu8QY+XcZ1QTHv+v+c+iAhc76aQsO/2kTLnekuEKuwzM+yXtNzABpqAW
         k02OYqIt7phGXSmpSQFniiyKz46eZ6RFPEROoVx6jepIc4CRsvy+6lQg7LjVvKL8rHCT
         O63Do0WWTJmvOg6QPVDvQhISte1H/XruCdeTwbe+jgjuUCtoYZ52VGLu5R/zFOEIw7sX
         Ct65Akq97KzK2o2xdnqaY7nsIqhEEhXu3Xymqlix0OCxHt+6WuyT8ZsNHHtY1h64cZwQ
         7zVg==
X-Forwarded-Encrypted: i=1; AJvYcCX2m9sdJJ9pg48HRkIra/URQn3KxX++nqZYcVCGn8O49n1wmZPSQVEczwsBU3PsyTR1qJ/VsWLybSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJOpcc7ynFs+4PEMwSObIibLk5BU8YfDcHcBDHtoIRiyPmOFP+
	UDAbbZUgtP9+dC/j5r9FLyMKCNexcUzFUXoVrc3q2fMdqFJDPPAem1iW
X-Gm-Gg: ASbGncuYCtA9UpYoHnUxNpKyZGqwp5s2D/ZKIsaatUGK3gMwExQLKxH7EwNag1tkyfN
	as4RBD1BhhHB+49T2xnBh4JnTR47H9I9kz1XkzwNnGf1kD9LhosH9QdmgHMwVNEbwpjo7ddIYdJ
	44s9rRFfuo5/tGgK0Hjz3o4rdTnlDFBTbsd2l8Oo9ccMkuJPrnUoFjw22bhDcY49StWY6hQ5C+n
	fleqRlasLdDgjZTMxhiubQnd9vA7xn7I1nT8UTpK6NX0Fb7HwrhK3aRbcWPN6ZgBXOJO06yh55n
	wCJnDMBPbUzWUoImWmT/L2IuosVKiMGGRpszSG7xvnAVdNz3S4iGkIraGZ6st5fdWH98TI/EY/v
	RqRFEtkmt/meEuUg6hMSUCmSrStcgnfpdgmNMljPH9B5K4edwMLRGzN+c8UNtBYr+suXJ0x+T4l
	XfSX52n0l2dutQ3g==
X-Google-Smtp-Source: AGHT+IGiDaRlSOUQ+fshNFNRIIqAzsM+JdRz2ezhxxJtsrcIPVcLKpE8DvHsW+OMEaI3itBEF++7dw==
X-Received: by 2002:a17:90b:5588:b0:341:8b42:309e with SMTP id 98e67ed59e1d1-34733f3de19mr35626599a91.31.1764517077432;
        Sun, 30 Nov 2025 07:37:57 -0800 (PST)
Received: from Ubuntu24.. ([103.187.64.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm6903483a91.1.2025.11.30.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 07:37:56 -0800 (PST)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v2 3/4] iio: proximity: rfd77402: Move polling logic into helper
Date: Sun, 30 Nov 2025 21:07:11 +0530
Message-ID: <20251130153712.6792-4-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130153712.6792-1-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change extracts the polling logic into a dedicated helper,
rfd77402_result_polling(), which improves readability and keeps
rfd77402_measure() focused on the high-level measurement flow.

This refactoring is also a necessary preparation step for adding
interrupt-based result handling in a follow-up patch.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 35 +++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 3262af6f6882..2152509816ca 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -110,11 +110,28 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 	return 0;
 }
 
-static int rfd77402_measure(struct i2c_client *client)
+static int rfd77402_result_polling(struct i2c_client *client)
 {
 	int ret;
 	int tries = 10;
 
+	while (tries-- > 0) {
+		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
+		if (ret < 0)
+			return ret;
+
+		if (ret & RFD77402_ICSR_RESULT)
+			return 0;
+
+		msleep(20);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int rfd77402_measure(struct i2c_client *client)
+{
+	int ret;
 	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
 	if (ret < 0)
@@ -125,20 +142,10 @@ static int rfd77402_measure(struct i2c_client *client)
 					RFD77402_CMD_VALID);
 	if (ret < 0)
 		goto err;
-
-	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
-		if (ret < 0)
-			goto err;
-		if (ret & RFD77402_ICSR_RESULT)
-			break;
-		msleep(20);
-	}
-
-	if (tries < 0) {
-		ret = -ETIMEDOUT;
+
+	ret = rfd77402_result_polling(client);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = i2c_smbus_read_word_data(client, RFD77402_RESULT_R);
 	if (ret < 0)
-- 
2.43.0


