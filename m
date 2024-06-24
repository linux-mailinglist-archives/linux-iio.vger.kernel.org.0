Return-Path: <linux-iio+bounces-6809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41C914B17
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A465B24A63
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42713D53B;
	Mon, 24 Jun 2024 12:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgHm6VM8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29213DDDC;
	Mon, 24 Jun 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233436; cv=none; b=Ps5q2AuRqHSf1D513OSNwDXkFDqaGgWnrVPBo2+X37mkZtcXoJKtHYBncYVWDCls/6CGDgOfg5l+mhZdDXr/eDV4WxjPCYLRdZbBwCuJzWWC6NKFyiwCUImIsp40KfVjRNjDyirNpxZvRWnFllg9jKFadLJ8TsnCJ6BT328sPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233436; c=relaxed/simple;
	bh=dkfThZ3Lat7Zlzx7ILWb7giKix7eyHU8+9Uctg/rPjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ag2QwcSfvLt6gLFf2rskOkxDTRmzpCZzBx9jQbSAPafcLqM5P8F+fBFyNG6qemM2XAb+Ln5aULplV96hC02onFFx40A7pZnzw8jXG4SqDNWtX6WjP6fekdXNYfLKzrkCY1QcYV+XzU4zF2IDywa98m7aH/WLzuP4aHJDMS6DLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgHm6VM8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4249196a361so6467655e9.0;
        Mon, 24 Jun 2024 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719233429; x=1719838229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=080FC0tj2AACaK1A9ue1dZ0QKYAZKNF8MOr4W+vc9WU=;
        b=dgHm6VM8zddUAbQ8o8CVUetBi2jsMVe6zNSA5hxHfHMkMJ5dM7d7AkLccvZgxz4UEG
         vKbvsDcsbl6mNtMZ3t7ZxTHxUBhnHeXSSFWyxZIhIlXLxUBIUfLAAupfQ7dBq8pN0dLy
         5Kcl3CSPXmIVTlfaGcOyskTG0YiR+McMJSsKGolqe5+BI29jRCrpsfCNr/h2SN1z7ZRm
         2XUJ4H8Rmq/WeYBx/qf8Al5ROYgvBqUtYtITz8MzBaw9Z3F4grJ52ntq2DAZdqW3Ncvn
         RzFdfOwGUwoH74pHzOLgOnzrpxZWV5Jgu8xnswdgQrw+XdvkUO7DHJc9oDjTLIKL9w7S
         RlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719233429; x=1719838229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=080FC0tj2AACaK1A9ue1dZ0QKYAZKNF8MOr4W+vc9WU=;
        b=DzuQJMQK2i8d9K/lRg9EX5gSFKEZGzIGjs/9EDwvMCzENvJoaeIYBNuNY4JNwnlBF5
         YGFXgF+3ycpvuNs4D5s9DOnFgflnliSByt9DG8Vyqlno/8mf20m/h9G1OcSkguasUx6G
         Lt4QGGJY04oyxaLX0R5yw2V9jHNozHYKPsjiGOgyIA3gvyRJVcMexcMvavkzBaWNfHqk
         gaVrRO0u5cX9Udh94MVrjiIJytL05LkUabMOaw7fxCohkJyYXKEdmfw5fLtn9fa5Rona
         TmV0yX04ajQL0r+TKJiU6aOq1pTIciT9mwBc1SEB/TxZRKiNM0RlX6csl8bk6JwYMz7K
         Yt1w==
X-Forwarded-Encrypted: i=1; AJvYcCW9UPqETU0Eb6t5aMsVEvm8sY3zn91ZuAiBUjMNePTj3IzuUUw0c7c02svchqd8P9r7RhfCfnngknj9YEl7kxuAhFpIQezy7qyEtEN7tHPTm79hYHowfS9eOlz1O93GgpmQFvhtlUq7mlHpPd5A2InY0EdNTCRgh4dfUhTOD70dCo3sXA==
X-Gm-Message-State: AOJu0Yw14Ga+ZyPBOblIt42dlStEozfAyjzWUFl3vKztREMVcTWxe+fi
	+iYV8S0eDIMWpX1+WuXCuCjNizhYu2i8DTN8cDufGvUvi8gf0EyS
X-Google-Smtp-Source: AGHT+IFNayaymQlQmZojnTCCDLXGrg5/l14jjrzAY1zBEWVOpqJg9XbCe0K1JgrpBblOOJ5yODoC6g==
X-Received: by 2002:adf:e850:0:b0:362:afd2:a4c0 with SMTP id ffacd0b85a97d-366e96c338fmr2609697f8f.70.1719233429424;
        Mon, 24 Jun 2024 05:50:29 -0700 (PDT)
Received: from spiri.. ([5.14.146.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm174127905e9.37.2024.06.24.05.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:50:29 -0700 (PDT)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v6 6/6] MAINTAINERS: Update AD7192 driver maintainer
Date: Mon, 24 Jun 2024 15:49:41 +0300
Message-Id: <20240624124941.113010-7-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624124941.113010-1-alisa.roman@analog.com>
References: <20240624124941.113010-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexandru Tachici has not been active. Also the email address included
is not reachable anymore. I was assigned to work on the driver instead.

Remove Alexandru Tachici and add myself as maintainer of AD7192 driver.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9517093d889d..ab1e82fd3b76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1217,7 +1217,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
 F:	drivers/iio/adc/ad7091r*
 
 ANALOG DEVICES INC AD7192 DRIVER
-M:	Alexandru Tachici <alexandru.tachici@analog.com>
+M:	Alisa-Dariana Roman <alisa.roman@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1


