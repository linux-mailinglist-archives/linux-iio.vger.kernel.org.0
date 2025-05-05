Return-Path: <linux-iio+bounces-19146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F0AAA9B86
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 20:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766FE3ADA60
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3418826AAB2;
	Mon,  5 May 2025 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="noM2h7P0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD0734CF5
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746469731; cv=none; b=D3CfQdBbX8Fh/hltdf6UbClrAdYR+lRBylAbYA7x8YCwl3QgrWK+wqd7sBfFWy5JDpSbb2QmujP48+y71X52raAdOmEfosuESYm7dMQq6/xJlIqFao/0AU/E+E1Pa7CMDK8ZzwWZddeqfDcyPgStaoPxedGuec2W8GqvRl2H27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746469731; c=relaxed/simple;
	bh=QDVwmpo9ktX2KMymt0KJritJpgsaBmg5HTydROKeb/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gbfcu/JG3OPYvCL8AB+UqDoROqIt9atQGdyR0z5uBbcRR0ZdaSMf/A0RicwAPotqYGfclFwp0RKgNxL61nclXVMOyELyOMJyHsU34a8SpBxoHyKOrFjGBMSNlxDNcN7TNiLDsCLtW3PIDC5HlyFnAE5SadiOqWocs29ZmR9dWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=noM2h7P0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-400fa6eafa9so3563639b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746469729; x=1747074529; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvnUSg83TE3jOG9sJI46HHnpfCdZ+Y8pGrpMisK7bfM=;
        b=noM2h7P0LQthhhvlDbqWYgJsWiHvksN6I2GDMC0bxCgfEd5EeR88iilVLsYn+/F9pn
         9q0Bq2CwaMS0pb2UiLRyuiCSyjRtqYT8EZW6roPN3UV5kY32cjqf08P7PzC5ZYdGFOvd
         g2Y9FBVtKBZA6gHKq9Llu/1NF9RMHZCqhGI3xXEhrSzl3QsGKDEAkemcwhx/zMkLmKCC
         8/lWOoUwoNVgjRoaTkd+E6H6+QpQSHjj5KB/hRRclk1c0pqoWW3XZ02ogdtFl9z445sU
         VETzSFSzEv5YqRmZHcJvFT9gBv8FMuj4rvrI8x3gqvrlvbME3sHDd/Jp2OpKU9L0ZwEO
         UEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746469729; x=1747074529;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvnUSg83TE3jOG9sJI46HHnpfCdZ+Y8pGrpMisK7bfM=;
        b=QQDfwj2aImFG3k5ne06TYedbpeq7d0tn1HfqX4coxsAEZutp0nneUyFFqBqQR8IyYB
         qombHhPi4lZ1AJu1YZRStkQvwDlOuJttSnKv+lOAEcGOj8ufAZNok82o25sLw2LAh1eR
         Q+bqv25Rb6kQe3RU5A3TLMrpnlmrlHmorTUTywOMp1F1ywLECkQk71JST9laWsCGs4hh
         9/STOHgaeO/ozBsSWq2T8w98LNIL5ELvBJNC5z11LX7O8u1CKFgyRQtzU4VGkfn2dAzh
         MXgjif91n/9mYNdHhJREvpFb3Ly8tPOvyeMW4yNejRHe5Djtfkgm0G5XZ0z+XDThbkUF
         Av0w==
X-Forwarded-Encrypted: i=1; AJvYcCUkGjXqHx8f25pWLXb01ExxgCM9/qg5ULHTkx0B7OalVxlZYdUrqq2ZAyPR7UsWmeBdoq/5Q7OxQzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0wZXNr4ozEeWJhb3e/48mgQOmr71vJ+iDCAyf4lrpfJX6xTd
	UGNLinLh1oiDdoQ9qZyg2oxtogT6u6gR9fOR7Kl2gggX+wuCbFjlj9Vq3eVutOI=
X-Gm-Gg: ASbGncuOfTfJuINHjaVOrT4GBAwg8vanW9vE2yDXdR5aIs3K7GLihOoAhCU6b+ygGZY
	Wv2+tYO1t24mcGbz2WNs5/nBTU89aR8OmtcRYzUIYcH9urfL+iua/vYeroEGVi6P7t/J2RsLyVZ
	2V0ubhnMgLgePou4KPPiV+bTaYe1oombbzqYRuDiNdoZrKN+2AfPiDD0wtxCGaW2uQnTrDB+yeM
	oz891j/1Aw8hMMPKvoX/a1IcFpyqmPV7KZMa+O5OeDGvfasl4h0seefX9VxlvSeUEFzW+Jm0jRJ
	nIC4aIfqjuOXvGaG2etXtDx+T2OESXPw8M3rJNYlASv3Vw==
X-Google-Smtp-Source: AGHT+IEX21eYhQjrrdyKu2y/FFUXmYeQXwqbJB/KdSUZRflFNpvmVDNc6veX6nZcdvi0YJLdfLxgPg==
X-Received: by 2002:a05:6808:2007:b0:403:5277:9424 with SMTP id 5614622812f47-403527794b8mr6511893b6e.32.1746469728780;
        Mon, 05 May 2025 11:28:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dc828a3sm2050781b6e.41.2025.05.05.11.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:28:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 13:28:40 -0500
Subject: [PATCH] iio: adc: ad7944: max high bits on direct read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFcDGWgC/x2NQQqDMBBFryKz7kCaKGqvUrqImamZRZMyERHEu
 3coj794m/9OaKzCDR7dCcq7NKnF5H7rIOVYVkYhc/DOD85AkYqRkm2c+x4/8cAsa8ZFtoa1IIl
 y2lA5Ei5hmPw0kwthBHv8Kr/l+Neer+v6AeJlOe19AAAA
X-Change-ID: 20250505-iio-adc-ad7944-max-high-bits-on-direct-read-b358289d0337
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QDVwmpo9ktX2KMymt0KJritJpgsaBmg5HTydROKeb/E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQNZzpqaeOKzms9+hlqWPEByob1PPVfP1g5Z/
 38U5o3mCtCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkDWQAKCRDCzCAB/wGP
 wLuAB/9ES6esxBezGlbH1E1DLvl2QMYuAeLjVWGuA4g74MV6UXoxgjk3mO56r/I0xXQj6ohC0EW
 rCFEsMKkBNR16ocPAUQgK+PuMxG7tpTOjiHag3TT+X6fKdob5tQiTmOrYcr06LOeaZgqYZOJmAV
 0UvxIGv7iiteMIw9Rps6ve5/O4/qbV8siUVd1Sxx+789BVqVUZoZWUY+ijTRYkzCc5VwI6ytBCK
 G8VRK+W+R4o+RfaEFdCAYKphVvHV7d1if2ZEzQGbF+zsUIY+Ybzxbb8vIb5lBkNOo2ZhnBrsJNp
 pxgNmbxGb5CohCGXQOr1yLwgBun9EtaAeurniWiAV0IvXBwD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Apply a mask to the raw value received over the SPI bus for unsigned
direct reads. As we found recently, SPI controllers may not set unused
bits to 0 when reading with bits_per_word != {8,16,32}. The ad7944 uses
bits_per_word of 14 and 18, so we need to mask the value to be sure we
returning the correct value to userspace during a direct read.

Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD7986")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
The sign_extend32() already takes care of signed reads in case that
isn't obvious - it overwrites the unknown bits with the sign bit.
---
 drivers/iio/adc/ad7944.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 2f949fe5587318957f2e423029294ced0a6f803d..37a137bd83571b055e970a8cd483d8726972d637 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -377,6 +377,8 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
+	else
+		*val &= GENMASK(chan->scan_type.realbits - 1, 0);
 
 	return IIO_VAL_INT;
 }

---
base-commit: b72f1157bfb9b92b0439e11469f7f94e47363460
change-id: 20250505-iio-adc-ad7944-max-high-bits-on-direct-read-b358289d0337

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


