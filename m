Return-Path: <linux-iio+bounces-17181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA7A6C22A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 19:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD507A9A51
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19722F38C;
	Fri, 21 Mar 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GSRdmfC8"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2322D4F1;
	Fri, 21 Mar 2025 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580627; cv=none; b=DzaTv96fp3tFYY15fNZOIzaoz4f0gm7rzBA9wJQStpjmyTcWBvVlC8PTJW3nhMgIAXd1wW6pzsOQPnDEm1a08l12vQLksUXfnfiOCV4u+EDVaQzoK1KtV6Rjt4GJvOMu/QDrMwBg4L9Jt0pMh9Uwkaj5gP/cI111xEHTp2lm4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580627; c=relaxed/simple;
	bh=0GMyBgFgIU8OMphBQEuitGH4xaRXJZUVqbrCrD4NoDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UuHLQ5JV0n//r4fNDeqXadxG0q2nP8G326t4NtIz8ktJHvtDqCsPIEpvZTp6CIzNwy6a+iTma2phQierp7NjxPKz7n0OFhCPWH3kr4UdKK8h5dhzBY59FM6PzmXME7uxF91ol/HcG24VGFha2w+odX+snG3O9DvIFtG126JU4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GSRdmfC8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EAA420481;
	Fri, 21 Mar 2025 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742580616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qO8SVWZzm28x0uUOfozdcQEEmEUOpSa6EXOznWkuxJE=;
	b=GSRdmfC8EmLK74LNH9kn9+LksUdvV16M5bNPsCnJE89ewvaAtsaErv5zmSIbVzJKtCM6h/
	BJHHtOtvOCFzY2uNEcXkBvtoloEyzTJLbtnDH0Y86GBqUVV3oL70P3Rl2wQbca3SBXXtCi
	Tnm/5MOxeNQ7DxBhL/U/zyBw1EHuLrs+XjSpYsB8J504/JgPmmfbYJj4jUqQYznmA15Whs
	sQTuGAEQUDkQNk53V+peyH4+6gv+0jTPffcpq5ICf/xltMIzOKj8IxNp60PaXe0Ir/BbR1
	icEXbGH2kiBLqIrXitS1GylCuTOKOB/Y0mlFJGh4m5USWDYj4Kn6X8lrlOpjlg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 21 Mar 2025 19:10:00 +0100
Subject: [PATCH] iio: light: opt3001: fix deadlock due to concurrent flag
 access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHer3WcC/x2MOwqAMBAFryJbu5CPInoVsZDkqdskmogI4t0Nl
 jMw81BGEmQaqocSLskSQwFdV+S2Oaxg8YXJKNMqazTH/bRKaZZ08CI3Lx3gfAOD3lGp9oSi/+M
 4ve8HpxSJM2EAAAA=
X-Change-ID: 20250321-opt3001-irq-fix-f7eecd4e2e9c
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Felipe Balbi <balbi@ti.com>
Cc: Andreas Dannenberg <dannenberg@ti.com>, David Frey <dpfrey@gmail.com>, 
 Emil Gedenryd <emil.gedenryd@axis.com>, 
 Alexander Koch <mail@alexanderkoch.net>, Jiri Valek - 2N <valek@2n.cz>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedujeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefghfffgeekhfdtveffheeuudeltefhfeduteekleffvefgfffgkeevfeejtdekkeenucfkphepvddttddumegstdejmeeigeeileemtgeiugeimeegtgduleemfeefkegvmeejvgejvgemtgdtjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumegstdejmeeigeeileemtgeiugeimeegtgduleemfeefkegvmeejvgejvgemtgdtjedupdhhvghloheplgduledvrdduieekrddurdeigegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegvmhhilhdrghgvuggvnhhrhigusegrgihishdrtghomhdprhgtphhtthhopehlihhnuhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgp
 dhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhitgdvfeeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlsegrlhgvgigrnhguvghrkhhotghhrdhnvghtpdhrtghpthhtohepuggrnhhnvghnsggvrhhgsehtihdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

The threaded IRQ function in this driver is reading the flag twice: once to
lock a mutex and once to unlock it. Even though the code setting the flag
is designed to prevent it, there are subtle cases where the flag could be
true at the mutex_lock stage and false at the mutex_unlock stage. This
results in the mutex not being unlocked, resulting in a deadlock.

Fix it by making the opt3001_irq() code generally more robust, reading the
flag into a variable and using the variable value at both stages.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/iio/light/opt3001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 65b295877b41588d40234ca7681bfee291e937c2..393a3d2fbe1d7320a243d3b6720e98b90f17baca 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -788,8 +788,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	int ret;
 	bool wake_result_ready_queue = false;
 	enum iio_chan_type chan_type = opt->chip_info->chan_type;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -826,7 +827,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)

---
base-commit: 250a4b882cf37d9719874253f055aad211f2c317
change-id: 20250321-opt3001-irq-fix-f7eecd4e2e9c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


