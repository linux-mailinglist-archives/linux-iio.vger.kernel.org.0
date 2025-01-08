Return-Path: <linux-iio+bounces-14020-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAC9A05C0E
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 13:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0E53A68E8
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8C1FCF66;
	Wed,  8 Jan 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gAz2UKPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814EF1FC0FF
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340592; cv=none; b=qYgyEYIMDdQj+9U858t0yd1LZTA0mQHBwc5gtwhhexgf0EwIC/6SCZGKp41wSArnHeGI55L/u58UC/TYPccqlzdW0o8Lp4Sa/gqETqii8AP+LA31DuFRWOfUBJHRSFyA26qFyVXsgMXn+24z7wRWMI5eIlIiexj7g2PlSulNI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340592; c=relaxed/simple;
	bh=q+2FfWgXL3it8kWQJY1v1IawdOYfJSEhFMz5RY7Ava8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwRd0haCiBP/gQwmq/7eMapgLZLH5hYsQcMilIT5P1bn9R2ORTDkKjSO0CdykqxETYzF6vbAFRrxzhijWASAfrYUdMY1qUQebJfOZSZTfAwcvrMTMrf7lqovc8J1M4CTe2OEk49tgG9GbtitxhwcLr04fo6uwbqbgvHngozqouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gAz2UKPW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso115286935e9.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736340588; x=1736945388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOhT2Lsro+qOOV89/XsqYrLbTVo9ZQM0Bb0vXMREq/0=;
        b=gAz2UKPWVK1D3YRfbhMliHNZ5x9UTT6Nd7u5kzIeL3oR8o9yEVN1glofgVQp11OkEH
         L8RvB+gOk8besqIKSIsqYdbShTD4Lwrgaz97YDXt5rW9vU/kco9WClkuLh9eth3j88Et
         A9xq9fO6rBhZ+sgiPkeji/+oTuQHYmRMTgb45yxHjKgzzhDtTrLS9zmt2lks6b3BuVrL
         PCg0F0g5JfWdyqDFQEqBKEBlF6Y+XpU7oH4GuSPPr4e98b7f5P5OQdH8+iOAYrWLYIbJ
         SGHfqJi51iP28VLY2/Koc/jirFHTG/FNbfGFkzginsd7neQr3rU18KIHCA7K29ufBxvL
         pjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340588; x=1736945388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOhT2Lsro+qOOV89/XsqYrLbTVo9ZQM0Bb0vXMREq/0=;
        b=jPoEuhiWjwz/3T4rCWBCjRnDk+Pw4qY/F6zaYeK1IidqbGY+BtCL2bxblZyemI/n1j
         Zn0GeLlsoPKc2eje6csGAd7NbkRt8uvAtN3b7icFCJOFtF9Hp/WeLIzaTcLsa4Zp51QW
         QN2EhjUEoPD8Fl1jGIULV1Fc4v8wGZFzuKbdvAXoHr/zt5vTzFHAOlantX8Q7pI5AuEJ
         OxeCt5qC+787XBt+BUrTfFXfVeAiIWpKhqlJswIYBdPL1KGAvwJpYL/r4KTL/rvM5umr
         +biIn25VRRHMumJIz7iYrUXTzarpfsqNdAak5SPVIZ9/cOqyrg8WjVQx6vOC5diqxSuq
         ySvQ==
X-Gm-Message-State: AOJu0YztTkjT+KcQmvcwIFE6rYtu7IKIoQgDjN1Ack3eZCboxSpmK50P
	gQHuzwQk9zFqucIXnUTZDNefJtT3489O+bLHWh0/zaNfax+cHToYo6Ym5OKEP74=
X-Gm-Gg: ASbGnctcmFlO1r4S22a/zWj0s+GRaY3IltCFpOBrStOrNTEsKWbHujP3ZK0ymWQy/7o
	bM59c7hNbdq9MgWuA5akZGuOrn9fWV5MtTUTMj7Qvc2885MJnINHcIUNyTqYvr6laemN8e5pDiN
	1AYXNMDeIl/uY+myY3wpCPTn0hzmZnvmj9JxvO1bbqHryyBk0zbI0CgRhr7etf1RJuZCPKDybRo
	LW8SpjunrsL0pPrhyqG5rJgA4U48gIAHkmRXlzEeC11Jy++DmYkzibya8w1y8k/cpHd7GefusJB
	kPp1eWR9T4PQubkCuz1I7GsP7SEMjs9WNr5/1wLZvhdaqGei7/fSZA==
X-Google-Smtp-Source: AGHT+IE+QhuDpA8YR57JeyH4IaaPw2brfo9vS5Y7y3nd1ge9+lmd1OqCzvYZWaMA8uj10HLFCeuIHQ==
X-Received: by 2002:a05:600c:1c98:b0:436:1b7a:c0b4 with SMTP id 5b1f17b1804b1-436e2677c65mr20409605e9.1.1736340587726;
        Wed, 08 Jan 2025 04:49:47 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da63eesm19846805e9.3.2025.01.08.04.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:49:46 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 08 Jan 2025 13:49:37 +0100
Subject: [PATCH v4 5/5] docs: iio: ad7380: add alert support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-ad7380-add-alert-support-v4-5-1751802471ba@baylibre.com>
References: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
In-Reply-To: <20250108-ad7380-add-alert-support-v4-0-1751802471ba@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Add a section for alert support, explaining how user can use iio events
attributes to enable alert and set thresholds.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index c46127700e14ca9ec3cac0bd5776b6702f2659e2..cff688bcc2d9601a9faf42d5e9c217486639ca66 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -92,6 +92,38 @@ must restart iiod using the following command:
 
 	root:~# systemctl restart iiod
 
+Alert
+-----
+
+2 channels variants of the ad738x family, can use the SDOB line as an alert pin
+when configured in 1 SDO line mode. 4 channels variants, can use SDOD as an
+alert pin when configured in 1 or 2 SDO line(s) mode, although only 1 SDO line
+mode is currently supported by the driver (see `SPI wiring modes`_).
+
+At the end of a conversion the active-low alert pin gets asserted if the
+conversion result exceeds the alert high limit or falls below the alert low
+limit. It is cleared, on a falling edge of CS. The alert pin is common to all
+channels.
+
+User can enable alert using the regular iio events attribute:
+
+.. code-block:: bash
+
+	events/thresh_either_en
+
+The high and low thresholds are common to all channels and can also be set using
+regular iio events attributes:
+
+.. code-block:: bash
+
+	events/in_thresh_falling_value
+	events/in_thresh_rising_value
+
+If debugfs is available, user can read the ALERT register to determine the
+faulty channel and direction.
+
+In most use cases, user will hardwire the alert pin to trigger a shutdown.
+
 Channel selection and sequencer (single-end chips only)
 -------------------------------------------------------
 
@@ -144,7 +176,6 @@ Unimplemented features
 - Rolling average oversampling
 - Power down mode
 - CRC indication
-- Alert
 
 
 Device buffers

-- 
2.47.1


