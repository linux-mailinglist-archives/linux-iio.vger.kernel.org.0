Return-Path: <linux-iio+bounces-6982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99C91A5F1
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF74DB27C84
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112D14F12F;
	Thu, 27 Jun 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pb43eTgN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6D14EC61
	for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489580; cv=none; b=jlI9abHbXjiFuqnoleLAhVDkzBx8UhR1cmiUUCOCq+dkqwPjUOuqm4dyrkaCAiTBpJqR6c7JD5YeNBgPsDPkHUHPwi4JzbbCkCveEzc0Irt5gfk7MYXyjaGbluVMEIcH0fYZFoPJZ3XNEkKomrJ6bAqFijYxlNmlO23qadOLeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489580; c=relaxed/simple;
	bh=anA5oYFGJ2+2TTOR+4xzpiZiQv1Xq5rAKQT0E0obUDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I51FzHMDD45ibALjtDNYBOaE8Aikr3MNv7odAwy740qzljmqFB9CJVqL+E02G17P1Arsf8xYYYm8JLaJE2E9xIYEvwNTI8H46VvvvoUEMh3rSmRJS1rsZSEEonsdEeTTPiJzJfYC5Q8MODpDyHIf9s7PCrV+VJ7NT9Rsr+1aMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pb43eTgN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-424acf3226fso16435615e9.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Jun 2024 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719489576; x=1720094376; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+OAKif13lnyPw2LmYH2U9f5LMUBn4yIkrRKzqcGvy0c=;
        b=Pb43eTgN/Jrff9QQI7XbB93igKa0iTcDCh7qV15sSIAqXEDUUZb1GOYp+p+2LVupoS
         IJi5lE01fll4YIUC7Gkopb0uBIzOZUs2cLRnC2yX1Qen3KGOK1GmDehoNVyNI+kdNG0H
         Q7oCowsqbmkGLB3gwfXqdKWj2sWmMgnoT9g4kLaU9u8kIUetWHTQ3rtHPIDFHRGqDKCQ
         qF1NCFwRJE3EqotVmVJUwE2EMZ1Lh+Iaj3kDACJC20RBTj02oxop9aOku74GqHcZLRzj
         VaNGt8f0pCUTsL3EV2UUPDi39HWjHsiiKUnEg5jQc2SMU2VhyEMo+MDVonKkr+VjRu5U
         vO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719489576; x=1720094376;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OAKif13lnyPw2LmYH2U9f5LMUBn4yIkrRKzqcGvy0c=;
        b=uR81lFWWtr+WIdvF/2/HSk2r0GmwG8rj/jT7Boeqs1YMSe8QulrICLzRUUjMTKnqIe
         KnAh62/CQA/HaV8bAA35Ex58wy6+nGxWbaGDR7Z2pOXY5hB79TuIaadsLz6cGbwnfiqQ
         X5xlgPy5/N8rYxuIAdHIg9YFrX3yurtOC4ok9KUO3G7uMK4UVpHrHMa4FcdTpY5eYlA0
         pU9nXftVe8E/DMzfqBVRdqBYY/4aZP07kkqEoNyBRsBuXkKe0M1HgrtKC0cahQ4WtorS
         4cp0FTz45Dk6sUCKWl5hY0W0N2GCiFXTStbPdM/ru80PlS5r8dgd4TZ8D3PlIKEn8Zli
         1paQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv23ZQ2559IqL5LJOx2vqcqh3gX6e8oy3JyHvsl/JYu+P3dNIbWE0ZQG07tlo6EPeB7ln78yKB9zANH9LGDPcoIPAzojoOTCwe
X-Gm-Message-State: AOJu0Yz6qAMvS7IGgcUcOLN/0c935YQG0269oWy4FnJqpt4sSWnsSeRC
	Lt0yOYwfIcMTWidpMeAsllWImgOvsIXXNwZFS8mqaYV11LHTKP75gf6DJ0M+M7k=
X-Google-Smtp-Source: AGHT+IGCSfOzVvWKWUPKel38jhHjOSvBykHlWgd/kqEry+wOrXMEP1r8dG8bEHq+9TLVoHrK4Bs+LA==
X-Received: by 2002:a05:600c:3b16:b0:425:52c7:1f14 with SMTP id 5b1f17b1804b1-42552c71f73mr28673795e9.24.1719489576191;
        Thu, 27 Jun 2024 04:59:36 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:4435:7af:3956:8dba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82462a2sm63473585e9.2.2024.06.27.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:59:35 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Subject: [PATCH RFC 0/5] iio: adc: ad4030: new driver for AD4030 and
 similar ADCs
Date: Thu, 27 Jun 2024 13:59:11 +0200
Message-Id: <20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9UfWYC/3WNzQrCMBCEX6Xs2UjSLgn1JAg+gFcpkp/VLrSpJ
 FIspe9u6F2YyzfDzKyQKTFlOFUrJJo58xQLqEMFvrfxRYJDYahljVLXKMgNNnphA+pGPmYllJU
 GZWvItQpK7Z3oyd998g636wW6YvacP1Na9ptZ7dH/xSIpdLDaoFeNQzo7uwzsEh39NEK3bdsPF
 JjFi7gAAAA=
To: baylibre-upstreaming@groups.io, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1719489554; l=1754;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=anA5oYFGJ2+2TTOR+4xzpiZiQv1Xq5rAKQT0E0obUDY=;
 b=U1NIU0lHAAAAAQAAAhcAAAAHc3NoLXJzYQAAAAMBAAEAAAIBALJZcW6pLD4ksSdWnXd5r65Ze
 5Qc5pH7+DmmbKJasOXeVYRPFEmnORS7pwhURG11AMVFmnCVYWj+wPYrbCEeM7XKfO4oQzc66kYB
 7y0RrFwjoWKofytjI026zV5b2pn1JAItgu0Ijth+TSa6KVOTSXqqiVzOTDM1WL0hAIIzpkhE3Vt
 AVJrFDsh/nWed9OpeSS+S6e3ZxyJtlnhqbVIemcDmjwMihtFgTKeJWlxP7KGY/RQKPF/Ef7pS+O
 AckOrxuqGKvpOiNVCmuQEUQM0+r4uvwtja4zRSl+huqW+g1nLyReoZPzFwfJWREd+89dtTJTXN7
 xmmFNdX6KzRKBLVw1RY/R3mhAd+MkrdiNaRNKj+LO1QIxPoW90cPG9WpdVDUZf1VxhdciB6Hlxn
 lfEDFuCxU0n5H+kC4eiZvw+c9D4xX7iVdjPTMEaE6GBQNnMncdljBwA5NVN8WcaUhnAQnq7qhcz
 85L2Br7MPqe3q3J/PHIe0nHO56j7tTY6cFFs/ckqcQSTJigh2rA7InN1d7GqZFLzlewRTGaCY+M
 93d7DCIuxTxJWRpVm7NW1FBeX6d00+dAcQ/dS+jmA3kcdRoWtH160jmmYYvOgrsQTcMIQrPtK+B
 rULRmmIvEIJMF5UfNmxruWmWn6MM/xeejTNszoKqrORpbr7q3BnkKt2y/KdAAAABnBhdGF0dAAA
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAIHga1lplWJQgF9MHgXvlNtQg/xk
 rlzN1fxEY0ZBZOpyIV4qE8C4I4KWtk2qFo3GMxxIKhLA9h7J1tTENd4+ez6qfZUn2UJgmxnE2EZ
 rsrKgy9dSDl29fSB63JYuqV8+w0CfXZqW8uCZ9NXjHuOgbYO3gvMtSy6O9HRYDDVR6IeQVAWj89
 2Uex0zgZThdmjL8ZWmvuYCQNNSstH2zCIdrBKdM2hMROY895jc1IQxtYSweCR567rp5S9wKYMkP
 yvZi26amjqZ5Vt+fJmOXKnFLjPE5Re39eGTxtQHiopFrbXe6wQZN4AWMsALUWMj5tnT08pUwqTx
 UUuJvscg/jvMs5ICSk0e67czelDZPg+ehDiRz5oEOgkFuIiI4KO+h2h+Apus9iEqcxi1SjYB8cQ
 n9TNBbXrYEofEppE/wxrs3N42kNt6dBIo9qbY2R+e4XdMDEBbEJqWU4PkRaYTG0OSWQrhm27Klr
 +S3QAHrZEfyT+k+a6KdawW311P2U/R5iu1NBdWj44IqrMOyGTWhz2lBu7DbgIvaQYBfPOOBa3bS
 f2DQriTgOZoqD18TaM52xwokhPVzC9WjWdMtUaXoFJRMNRUovhAMzYlhOaF2/ExXh6EywZOr+mV
 nBW/vl4hWVaLsrElHneYzAt9LwQGpxplKTWnywC/0SUNvuA5N9i+9wJw=
X-Developer-Key: i=eblanc@baylibre.com; a=openssh;
 fpr=SHA256:LOxhPHcL6HLuSaOVHuI2Yq7hvD2blbngN1ohWi2rJOw

This is adding DT bindings and a new driver for AD4030, AD4630 and
AD4632 ADCs.

This work is being done in collaboration with Analog Devices Inc.,
hence they are listed as maintainers rather than me.

The code has been tested on a Zedboard with an EVAL-AD4030-24FMCZ,
an EVAL-AD4630-24FMCZ and an EVAL-AD4630-16FMCZ. As there is no eval
board for AD4632 the support can't be tested at the moment. The main
difference is the reduced throughput.

This series is taged as RFC because I think I'm misusing
IIO_CHAN_INFO_CALIB*. For CALIBBIAS the doc in sysfs-bus-iio says
"Hardware applied calibration offset (assumed to fix production
inaccuracies)" but AD4030 offset in on 24bits and I would argue that at
this point it's not just here to fix production inaccuracies. Same this
for CALIBSCALE. What IIO attributes should I use instead?

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
Esteban Blanc (5):
      dt-bindings: iio: adc: add ADI ad4030 and ad4630
      iio: adc: ad4030: add driver for ad4030-24
      iio: adc: ad4030: add averaging support
      iio: adc: ad4030: add support for ad4630-24 and ad4630-16
      iio: adc: ad4030: add support for ad4632-16 and ad4632-24

 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  113 ++
 MAINTAINERS                                        |    9 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4030.c                           | 1081 ++++++++++++++++++++
 5 files changed, 1217 insertions(+)
---
base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
change-id: 20240624-eblanc-ad4630_v1-1a074097eb91

Best regards,
-- 
Esteban Blanc <eblanc@baylibre.com>


