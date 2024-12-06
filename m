Return-Path: <linux-iio+bounces-13185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972079E7B90
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D4828543F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273071CBEAA;
	Fri,  6 Dec 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="alqf1+xY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F522C6C1;
	Fri,  6 Dec 2024 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523388; cv=none; b=iTxZZPpLTJGHa/00EVjBYve4/V3/90UOZRdFrWscvu8OC1AS+RwNnaC4/e0GLRBa84nhcECKghfq6Bh/td1/lZiq+S+3Zxl1t6wnRA76GrcFt/8rZJJjjJ6/h2zY7lL7L0Lxv8URc745RwsX3vbaA4aE3W3B2FZn1O5tzRmb3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523388; c=relaxed/simple;
	bh=yaltWmquaSi30mBn4sjlsxifK7x30YWy3ceQJGAodlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hhAI3gHXyCGXnOlsN/+M9Maa+1x+LSceVVH+GY2fyH5uUanTo+sXlPc/+Ti4k/66/7vQvEkP8IViBG8RACSfiamZIV9jPTjH23fXhS4WYL0w+hmUhr5iidmfUXw+2P0+2matvglXpjk+Ou8KnEr44ntsXxPrvAdVpmsvDtEwUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=alqf1+xY; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id JgU0tEPwCKnkaJgU0trrgL; Fri, 06 Dec 2024 23:07:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733522852;
	bh=xAsiSx9HEEFNrmVGS9TnL3m5XLPaHlHYBdh8+FPGk6k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=alqf1+xYvTA2uMU2rryIMOLxjZzPKi+WDEXhMfp37BDsYL9Tu96n+NOLbxMM181rI
	 Ewuh7QYfQegLdQTEyxi522lvOyZx/8+qae2LWfuMVwsTm+iiyVBnfwSo6iDUr7+yJN
	 UI1IliO2K9aHG2P4y0Hhbcr/i3MF8RLhs+F8GrymrmrKVwltQlWQ6XzpFn4o8tB6uc
	 8IxBU2FolF5QHgRyDFwBopTh/comXDBSbus5AqH5iGV5u0mhfcE9vB0oG3rnphG2ZK
	 3gGf5V7FGDEhWa7zfd4rakdQUKFTlr7nmW0oeQOI8ax+tkCyXwkGo49JG+mXhFnFZ3
	 BQKVn+fh5S3Mw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Dec 2024 23:07:32 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-iio@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?iio:=20proximity:=20aw96103:=20Constify=20struc?= =?UTF-8?q?t=20iio=5Finfo=E2=80=8B?=
Date: Fri,  6 Dec 2024 23:07:23 +0100
Message-ID: <da4918af46fef03903ab0e9fdcb4f23e014f3821.1733522812.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'struct iio_info' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  17366	   1454	     16	  18836	   4994	drivers/iio/proximity/aw96103.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  17526	   1294	     16	  18836	   4994	drivers/iio/proximity/aw96103.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/iio/proximity/aw96103.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
index cdd254da9e50..3472a2c36e44 100644
--- a/drivers/iio/proximity/aw96103.c
+++ b/drivers/iio/proximity/aw96103.c
@@ -433,7 +433,7 @@ static int aw96103_write_event_config(struct iio_dev *indio_dev,
 				  state ? BIT(chan->channel) : 0);
 }
 
-static struct iio_info iio_info = {
+static const struct iio_info iio_info = {
 	.read_raw = aw96103_read_raw,
 	.read_event_value = aw96103_read_event_val,
 	.write_event_value = aw96103_write_event_val,
-- 
2.47.1


