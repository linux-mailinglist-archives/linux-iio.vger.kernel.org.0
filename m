Return-Path: <linux-iio+bounces-8683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA995B541
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1070B283ADD
	for <lists+linux-iio@lfdr.de>; Thu, 22 Aug 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1431C9EB2;
	Thu, 22 Aug 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K9Dr0N76"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793F1C9DF4
	for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330751; cv=none; b=b90n9hB2Chew9gjYAFLBwEhoqyLqzBIMEckUnU1gzVMSQwAUFxCYcr1wUvqsYWI+dBj1mU40AyBhqqFN+w2yFVEZIoPN768fv9ruzQuKt49PLdcqeQFpH6yHQPhY42JtuhN+nLfa6ecWL65p3ufRAnLES5d3UiGlkffdFT4fUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330751; c=relaxed/simple;
	bh=yoETc8josiIKxYd6PCEzQLh0A57oAlHqLJq3xfUOsqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hK8OtsOk8WxOa8UDw1cQxF6M4OaakABtXPIqFHpT2NfB/875OgDsJxub/99GAn/Vig75/9jY+zSCqR+qph9Z6P6muZMtIXG8ZCcZ4l/YJFh2OREyWiZyc5zvzmUJ3IVPXjPC4EiEsYMPYvlVVAL1jFtikJqW6gfPdqJ5U1mVqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K9Dr0N76; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso5496605e9.1
        for <linux-iio@vger.kernel.org>; Thu, 22 Aug 2024 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724330747; x=1724935547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TziPBUOm9WXx2RorriSSxIgK2odcIsd7J/hDhpc2D5o=;
        b=K9Dr0N76uobB6o5KpDQbECDRii0wiHSWjTTPEQiUrfX2Yo/p1/npzJAbYAaOcosVE1
         2FkIpmiMAehPjMZFXt8D+G7SpeHjI7T0ZlVBIcjB/W/KneNgQSFvPBsIEWb4rqlNSIxc
         lQPvRfLD9csBsD7cWKqAQ15KBL5YZCHHPuA+R45hlFh25F45ad2OiNZ/0oZD7T5DU/6b
         OzScG1NPG8LyxLe+lfz30VZyGwQw6m3ETaU3lWDVMlvEwlyphTCyblmgT+C5qD7vAMvJ
         gnYnCxCyXwi2N1FSWL/YIhTSTOXBoz1aknRiK43rpniOBTENEWwCzssnakVPZ9Zq36x2
         0yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330747; x=1724935547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TziPBUOm9WXx2RorriSSxIgK2odcIsd7J/hDhpc2D5o=;
        b=X1/26+JeqYUoRsrFtxzaG07wi8XxEGo6rQmQUal2acVzySvhbFuGPZ9tR5gQ4oZA01
         dKTHmp6Xeknn7RMp/mXP2FUEx46bvPSh6sQRjh+v+wPeivD/umAnrHufQdkWjVARei11
         az+x9CFO2B3JuuZD2RD0LNdO0tc+d+QjI42Ta0fKJcUTIkz8gfux1Oe6txrPk0FoNEA/
         /MQuj0i5C6/gTiJ61IdvOBDMtcPn20dCqXGVMyiyANonj7p7O7A8NJssJy6J0gWydoV8
         UREutuLjrEsAssjur7mNMuF4yB/Td4+jeifxzNOpmM51iB21AT4muvOlJO4wxEnq5pLq
         uw4g==
X-Forwarded-Encrypted: i=1; AJvYcCWQrC3XOfaJaRDkbvrr3HaLra2hgpe8MRoUOjzFuMntzuQpTw2umbn3WvqJDveRSMVu2HLjOh8kufc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3tCNRfT4HOxc091/1kC/k09SLK72EiD2TiuRL1D1VHdi9Yfd
	HywYTe0UCIUsgBaoEpuMkzgeqQcHeDiSEaI6IsO2gKRO4lnvU4ABypX2vZl5dns=
X-Google-Smtp-Source: AGHT+IH0tUq78bCn9f3nkkiY/CPIRenPfJA7C5++cEDXkitHmsonwTgrf4H0CBGWrdvPatL9StsXdg==
X-Received: by 2002:a05:600c:1992:b0:426:6ee7:c05a with SMTP id 5b1f17b1804b1-42abd23061amr38113545e9.15.1724330746830;
        Thu, 22 Aug 2024 05:45:46 -0700 (PDT)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:8da6:6d6d:c8ed:16c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac514e269sm24032195e9.2.2024.08.22.05.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:45:46 -0700 (PDT)
From: Esteban Blanc <eblanc@baylibre.com>
Subject: [PATCH 0/6] iio: adc: ad4030: new driver for AD4030 and similar
 ADCs
Date: Thu, 22 Aug 2024 14:45:16 +0200
Message-Id: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwyx2YC/32NzQrCMBAGX6XkbGQ3DQn15HtIkfxsbaC2kkiwl
 L67afHiQWEv88HMLixRDJTYqVpYpBxSmMYCeKiY6814Ix58YSZASFBCcrKDGR03Xqoarhk5GtA
 SGk22QVa0R6QuvPbkpS3ch/Sc4rx/yLitf2LlgCtvlJYOayvpbM08BBvp6Kb7lv+4+ofbeQcKw
 Ynawrfbruv6BvomNZnvAAAA
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 linux-doc@vger.kernel.org, Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1724330718; l=2951;
 i=eblanc@baylibre.com; s=yubikey; h=from:subject:message-id;
 bh=yoETc8josiIKxYd6PCEzQLh0A57oAlHqLJq3xfUOsqk=;
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
 AAAAAAAGc2hhNTEyAAACFAAAAAxyc2Etc2hhMi01MTIAAAIAOcwMZFiJqxgsZdycbbpIOFEaiRS
 iTgFrNXG6NQKEOjEjm0Nt5hnzf93DqlhFL9FKnRwptCQMORJaxvUBNwEn5gYJ+f1VIHqdG++kbU
 hZMzHFU+49QD2RxUgakRshe+wECARgW3B/7t/XH5Vnvh6I1+GhcmoHCi2NnXjRCX+8x9p5joJvO
 c2QXAJk6FQordb0snje9m9xElhbQMuBY2yF5LIaKSf1nI4fPreEpcbwt8s/5r/WGX+cf0RDOoqc
 jwbOkX9l4IJNCfL35tUjbH0eHWpTmCRj3nBUheLw3ayDaxm5kCLMxaOqi/+4T6hqQ3WuFdV0OYT
 aRk8P/vOYKqwaY6+SV8mf/HDbct+zHbP5IG5fwqHm8BS1Y/+WCRssHgMu1vcwbAIyDReOmJ5Mjs
 s2zaLi0Jt0ZA963WoW1OLZ7RhZKj6nGd8JYwcaZDUgG3bIskj08Y27GE47aYHOHzdkv/hNR9PKK
 6ztj/y/310XHqLg8GTOIS6cwfS5+HaPexDW0K7Z9JgE23bpMoHRb+iZRhZ+zYcbIAnV5s3Egr9b
 2+p2aOw2MwYM/dNa3WfINFqH+0+oQk7b2EojqgWkl3Ht+uINcv6Yf2Wnh7vr/HFBGPYDyE3ZLVk
 t78fDKB9asOz5lTOoUaCXXfgyqUyFoLgJ8WGw0mErwQvZeRN0xEDBL2A=
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

To: Lars-Peter Clausen <lars@metafoo.de>
To: Michael Hennerich <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>

Changes since RFC:
- Reorder IIO channels to have the common byte channel next to its differential
  channel.
- Extended names for IIO channels.
- Diffrential data channels are marked as differential channels on IIO
  side.
- Use get/put_unaligned_be24 for offset and sign extend it.
- Common byte channel now has 32 realbits. This will be the same as what the
  FPGA will return, avoiding different channel layouts.
- Fix missing newline in some error messages.
- Add comment for the use of spi_sync_transfer instead of
  spi_write_then_read in ad4030_spi_read.
- Use DMA safe buffers for regmap operations.
- Clarify calculation for number of bytes to read from the device during
  conversion.
- Formating fixes.
- Add documentation page.
- Link to RFC: https://lore.kernel.org/r/20240627-eblanc-ad4630_v1-v1-0-fdc0610c23b0@baylibre.com

---
Esteban Blanc (6):
      dt-bindings: iio: adc: add ADI ad4030, ad4630 and ad4632
      iio: adc: ad4030: add driver for ad4030-24
      iio: adc: ad4030: add averaging support
      iio: adc: ad4030: add support for ad4630-24 and ad4630-16
      iio: adc: ad4030: add support for ad4632-16 and ad4632-24
      docs: iio: ad4030: add documentation

 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  113 ++
 Documentation/iio/ad4030.rst                       |  129 +++
 Documentation/iio/index.rst                        |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/adc/Kconfig                            |   13 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad4030.c                           | 1141 ++++++++++++++++++++
 7 files changed, 1408 insertions(+)
---
base-commit: 3545ef5c627c761c76bbdf71e4b4d423fe30e51b
change-id: 20240624-eblanc-ad4630_v1-1a074097eb91

Best regards,
-- 
Esteban Blanc <eblanc@baylibre.com>


