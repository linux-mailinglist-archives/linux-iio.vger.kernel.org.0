Return-Path: <linux-iio+bounces-13952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEF9A03A28
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 09:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A68165311
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121851E3DFC;
	Tue,  7 Jan 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Q7ZgbDjD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5E1E1A32
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239715; cv=none; b=BlM264gdmDvnpambb3YGSnOOfJCaSQZDhGTZsXasFa0Btsb/JmNNlfd95uTxJ6BW6XhjFeZuaYN9Bc0HblLMNIO9MuduMwp6CPVeAyy6J4LN9Jb6fWSZL8qU7BbGlQMTgM79s580qpzpHzRGrq6Qajj/1D365ubr1y9sbCFdQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239715; c=relaxed/simple;
	bh=CNZG+NpwX2frkPA3ToSHHXj+sGlFW4npeq8SUppj8a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WB5yt9h9xQafeTFmPVz+HwquPy7JAY45ch0LXG92zocbe2xtEJBbW2VgZpasbkIoNVy5XqLx5wsMhB/sJFnHrGdNNY3+QjzgyxR4nephsebzHcp4pxK+u1eTgJZxlCm0+u0WGoMB1xfAlM6i4XLE3ibt+e/kxzOb3a6eBu+U+S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Q7ZgbDjD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso154697635e9.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 00:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736239710; x=1736844510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nsIh5AS47gq57Ve27pvxJs0Imc3yuLJQeDrDKSKEFQ=;
        b=Q7ZgbDjDB2HzNipJgthYkkJqL4P50dv0j0p5j92MLlWNIS3c334fSikhtNSlOK4zAQ
         V78XouBoCaQvrPDRa/hbwJMMtmCiI06siKh8Uygg2Y7RTU5ZHYJJcqbb3gck+a65Iu8z
         8R1blitnbN8oU2kyw+0iroBI6WhfNaBGGq/P1JYBR4ixGcHQeksnHiQ27p/l7vaHllKa
         HA3JFqlmbDkc5u7N1BQ5jgi1xrWyqHqR+J4Mi46k/020QkN/tJVjqoCr3EzKg2EIRjYT
         rScTHYbNTULrntNUR418uiMfaP/u0Pg/l5oQeMiQN19hg3GfrnemjqcId/wfEFl7MsCR
         rdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239710; x=1736844510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nsIh5AS47gq57Ve27pvxJs0Imc3yuLJQeDrDKSKEFQ=;
        b=wbs3OyY2ZxLsB5ZNhXKqia0CnFkSTwKO0FqSEK1G3C2phFow/KttgN7h/1CkgdTQAg
         gyyY0V+g5JGm7QXzNS1JAOnNFxc5EK6GJk+wXqBrieJmkZtwSZW32JVFbBuOKAGxg3jm
         kJVWI/gtEdz1lCEN1uCvS1dLrafAAGOOdcaArx5goQkBjuwZKNc/j0ZlEfz9phEpE7df
         VHTlo8TQSB34zglhyvmzMTqymCmD3Hq/uYLG2fSfyg3KXyzzeCrSz1zbsZniN4qL/3BJ
         iSPH/nVsdI9p1e8m8QkhZ9e8cCUqaEhgIRU9OoVNhwhMH3rS0hbQkF97HF+gxb9Ob453
         wo4Q==
X-Gm-Message-State: AOJu0Yyyz73MweU/67/dZoP9azB7TYYNS4fA5C+Gm1KqK511vMutzTvZ
	MJ9YuR3HKc5M81uBlYq4LDl/KALr+EDP9VW9anPaV7G43W3xdagTiScyCP1Tr0k=
X-Gm-Gg: ASbGncuq6IAcFhc3xosQwkc9/atHj6ThYVYcTYF3iH59jWjqIngirLetPN4f7f/6P+f
	NCWI9Q1ESGdQyVYHh9K4wySppGM8llLkmgGrOGcq6F3OCO44aURxFWdXwCdHIk/LITUIu0IUbDa
	dSmxgJcEELuhhSw6uXkoJ2lE1x/2u54mkBhGCkSeYCfvT9mnMmmgDeOjAW4WdFMdJ6FzwKo0xUF
	vXS/gHCLLRs5OgETQlPNPVQdZGYic4ks/WD8y8tLwgn79ndeXJst+4OimGBrGddZ91KjRFLF3h1
	x8Rp7ADEbIjbitxRxoAlHXdsXY3cmviEHe+qtOxDgJyXcgWgdA==
X-Google-Smtp-Source: AGHT+IF40Th3DsJCZiUhDUmWc51b5/TVV6bpKP86SWOgVFtEzXYAHHHbf/f8wOcTTBZOGRN84y6J6w==
X-Received: by 2002:a5d:5e09:0:b0:37c:d23f:e464 with SMTP id ffacd0b85a97d-38a223f75bdmr54025349f8f.38.1736239710269;
        Tue, 07 Jan 2025 00:48:30 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm50722280f8f.1.2025.01.07.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 00:48:29 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 07 Jan 2025 09:48:29 +0100
Subject: [PATCH v3 5/5] docs: iio: ad7380: add alert support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-ad7380-add-alert-support-v3-5-bce10afd656b@baylibre.com>
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
In-Reply-To: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
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

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index c46127700e14ca9ec3cac0bd5776b6702f2659e2..9b4407eeaf1d4309c06c64071ed08b4ac80944d2 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -92,6 +92,37 @@ must restart iiod using the following command:
 
 	root:~# systemctl restart iiod
 
+Alert
+-----
+
+When configured in 1 SDO line mode (see `SPI wiring modes`_), the SDOB or the
+SDOD line (respectively for the 2 or 4 channels variants) can act as an alert
+pin.
+
+At the end of a conversion the low-active alert pin gets asserted if the
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
+If debugfs is enabled anc configured, user can read the ALERT register to
+determine the faulty channel and direction.
+
+In most use cases, user will hardwire the alert pin to trigger a shutdown.
+
 Channel selection and sequencer (single-end chips only)
 -------------------------------------------------------
 
@@ -144,7 +175,6 @@ Unimplemented features
 - Rolling average oversampling
 - Power down mode
 - CRC indication
-- Alert
 
 
 Device buffers

-- 
2.47.1


