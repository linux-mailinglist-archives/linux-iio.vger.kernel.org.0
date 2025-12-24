Return-Path: <linux-iio+bounces-27347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E26CDB6B0
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 06:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59E8302AE1A
	for <lists+linux-iio@lfdr.de>; Wed, 24 Dec 2025 05:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2A02EDD63;
	Wed, 24 Dec 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj+0OOiI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0627979A
	for <linux-iio@vger.kernel.org>; Wed, 24 Dec 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554645; cv=none; b=oHi4/589tvC2qyAouCPp0ZGplNv3kC3E/iOqWavHWdHHvTnU6dVejynhijZ49U+VPzJLBAOZvMsAfbjYpvpaHbJ+n0TllsEWpFXaJGnfkjZIi9KfaG6irf3OWQOJ386cau0SJbFhiEjOwy+Cd5kflvt5OsTuHCxVHnS9Y9fNYJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554645; c=relaxed/simple;
	bh=PS+RHY9pcXMjyoqHfN6I1vpgC/vXoQd6ABaBTl5wnH4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KIXwpz7MVrUFjwKC2GvCqlLJKTcKV+ByJolW2fPqIyvmhk8qcKzNS0Gm5t2qlOaQ3fOrf2ULH5KtUCRsvEOBK9NAOzw9u1fVV6MGfvwcurZ3R29QLUBPgK8sfoyejtCzA29ljQRwWfk+T9Hl/sD+E2+T3URNyTlo/Mowf0mp4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj+0OOiI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso6261518a91.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766554643; x=1767159443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQyZjDvsMhgADmmLXef4r9AmX8haHJsx0MdiIhOB3mI=;
        b=Wj+0OOiIn82RrTp5VCHYOgTMSSxFSDLKmeRo7v2JX+SDtoh89CJhX7yebiUZs3hXhk
         cxVpp1lUMfG6IOQCEkNtOPDpd5587A7Z0hkOK2gzkn99DGoPY5wMdDZNezlWjamfz4cb
         lgz2N2JRbgHGO9LbmPPNKBr/ljhkUW6Jk/oi9A0S8rfu0your0h9CeMhNWY91nHfc7DW
         K7eBOkZcgqXVCc6Wr9Bi640hyn84xzNaFNOsWJqF+IIwMi7Eqr0hvz6WtS8w9LztAGz3
         lcDzJocwGILL38dKRbLVxugDMRd8NTjDUEPLu068QS1kXtFYQLwG0X03+J53kucFxrxH
         LguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766554643; x=1767159443;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQyZjDvsMhgADmmLXef4r9AmX8haHJsx0MdiIhOB3mI=;
        b=P/gtYsA2sZl+luoIHLh5EYEkxua/BY+2tkLS+hgo9ZTIIh83bPmsUYMPk1D8C4T67G
         DiO2z0RYs3X2+BivbvcKuB1QLjAgrhAyE8eCNYcaiHOkrlGxIJrvtXIy9Jy06ldODdlO
         1q0k++Qmu8bPAnoPwc76fM4BCttGUOTfLj0bNA0jRsXrhsbqug6/kUZ3o7uXum5436aZ
         Vs26rnXuivSQJQul6cao1Y1SsF9zpyWmezptu22a6obTXNSQwxHs6AeLU+XDToaUt+qA
         TrbpVpfZz72hFCZFrLizHEbdnyY4Nz/SJuTIVxWbpJViPHMddEWt1l5P3lvkDWyG2Dql
         dJow==
X-Forwarded-Encrypted: i=1; AJvYcCXHDZ+iBzNWM7tQP57v0r/qPWPFsMTRajmSU69Ru5JfIz2WiIs2FakeQFsMnlvFrHTUfmX/+g6FhZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1yPxUsq/9bt3i4cCONLTkBLlA2eTimufa7sU0WjxkAJYZ8BFq
	JawGVWzGgZ5JCJtyXrbQairnujTyMIKzgbyxpcXP0eOLyKoGqTyyigAe
X-Gm-Gg: AY/fxX5b0Bd+aRyNu2bqZ2TQmPxQfICjd8whROXpUhnkl4v9AwiDL0mNEkiKfGnHJew
	1kC+lqFlKWsrAmxJh1T9UYPET3DsqeYI1Ol03Gd7v53kko8kB3MWEiBozdHldL2bDrmOJ9x27qS
	bFBlx7vwh9k4UHgtSqtpzKOQn9d4K6y1vejSrv3z5m/J6IuS3JieA+eJBh0E8gqRo03/vAh4SGG
	cm/XTp84yhd4U0bvQyaISlySrcNB+j+V2JumRXIaNiuEE+Re1dmr10y9ZIQbB11WRyiV9JEq6wl
	vZVSd3o2wOyB0nDzbl43TOmKMSBTfI8yLIs5TbqlZP1D7X6qcShPW/SraBHkqwWsh5X+0ZIQGES
	lt/wnODbxchWUHm1XREU8donPdKIGVex22YlApNxyEjw5PGFR84gdWsJaAglZ2/4dgo5FEKpMS2
	79Fa7HmGmq8xDy9/dF1NDZ9xDikzbWmg4ef7yWWShsJZ9MdniFVuE=
X-Google-Smtp-Source: AGHT+IFpW2ChD8bRQezzrWY9/FO1tIZocGcwPTvWWLlHMoy8nWDXpxEQLIw2LeaynvqVz81TrhMkTw==
X-Received: by 2002:a17:90b:56d0:b0:340:c4dc:4b70 with SMTP id 98e67ed59e1d1-34e9211e586mr13677732a91.6.1766554643252;
        Tue, 23 Dec 2025 21:37:23 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e588a30sm15540214b3a.55.2025.12.23.21.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 21:37:22 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: ltc2309: add support driver for ltc2305
Date: Wed, 24 Dec 2025 13:37:13 +0800
Message-Id: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAl8S2kC/32NWwqDMBBFtyLz3ZRkRGP71X0UkTQPHVAjiYQWy
 d6buoB+ngP33AOiDWQj3KsDgk0Uya8F8FKBntQ6WkamMCDHRiDWTBkzzLvGmjeDCZRsYBI7p26
 iFS8toQy3YB29z+izLzxR3H34nB9J/OzfXBKMM+MU71A60yJ/jIui+ar9An3O+QuQQ/aktAAAA
 A==
X-Change-ID: 20251223-add_ltc2305_driver-728fa9161bc7
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=PS+RHY9pcXMjyoqHfN6I1vpgC/vXoQd6ABaBTl5wnH4=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpS3wPPbPBxFb2jW9prAtgKQ7wnS7TwhiovvwGh
 4gnjKmvdYWJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaUt8DwAKCRClg0K3CVbE
 gWXbB/0YhN17MxexzwZIhr0cFJ04KY3yG8rLmRXiZRkIhU3BF+gysDR992ALKB8Ypr9CE1WmWBE
 nFFarsWBuOmpe0HbcRJrbXfdWNzyLz3bJF8h4yIYXe6BsEVXK2M4eRuKn5+qtrGwnfK4CUIsYg4
 UTTFK74I3CjEdbq0oNmT2/95LR4GkYxrIExqILOp7YXtcGf5UX217PwNXteiz/PCEjjjfU1qMC0
 vLRYhftQVKnnOTBggeHWSdeddVVqK79c1THoXLisT2SdlOrh2gayAYoEYdHCoyRhf2W+zmFMQNn
 ZFsVQS2QBf0gIXBeJLdqc64ZQNn+Z5xTu5C5RyPuq8n1V+0S
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

The series add support for ltc2305 controller from 
Linear Technology Corporation(lltc).
This is low noise, low power, 2 channels 12-bit successive
approximation ADCs.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v2:
- Reordered chip descriptions and code from low to high order.
- Renamed chip info structure to use ltc2309 driver prefix.
- Switched to i2c_get_match_data().
- Removed unused variables.
- Added chip info to i2c_device_id table.
- Link to v1: https://lore.kernel.org/r/20251223-add_ltc2305_driver-v1-0-dfa0827fd620@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: adc: ltc2497: add support for ltc2305
      iio: adc: ltc2309: add support for ltc2305

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  7 +++
 drivers/iio/adc/ltc2309.c                          | 51 +++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-add_ltc2305_driver-728fa9161bc7

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


