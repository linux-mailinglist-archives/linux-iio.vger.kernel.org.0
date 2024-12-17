Return-Path: <linux-iio+bounces-13593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4189F5920
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 22:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C5C16A859
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 21:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B31FA8D8;
	Tue, 17 Dec 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T6HN/vE+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A31FA260
	for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472056; cv=none; b=p8yROfpxbe8FjKvsEM5WG3G/hpHgC/x2ZfzwPOqSVJKmMDN6RrAGfR5EdQo6XN7nJ/r4q9sLzJNd5o6s47QjpZEDXJ9z63tUAlU+VB14HnO/yvREN9wec46qoTtYuInk+Z4YyOfiCdJ1jHB4xZNs6hmGgBn/Lc5YqHNP5KqH2tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472056; c=relaxed/simple;
	bh=Ma8HaBPEK9LBfvT3QeN1X7ugzAmaSGzcmCUpk/9AAyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLm1fR6MclTTUDsElsGOHdcxxJPpp2wtgq9HTWW8un5BdBCzFOy/79800V4q/vrYsClJb5HEg59rJRD2h4ZKiDnzPqAGaAS91xD4RpV9rzbskv83EcE7BvIKp67pJYUQt/BxxLR26vSEdb36L/i0b1wGkWBkJn6p4091MpnnWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T6HN/vE+; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d896be3992so39875456d6.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 13:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734472053; x=1735076853; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2jerrcD1nGClFF+pwwbUr/tdkat4xQ5wJ8skGDMH+c=;
        b=T6HN/vE+AG1yAlw02+JsgBOjLd6ioFgjFxxMSDre/og/BQY5+DAFhBDM6+h8Lnc0xB
         pEuEgRZs/HFkLS6k1bBwP4X+NaAEEJB1a/cg2pkHYn1MiYH502QbhoSbIhzFNEHiPyRj
         4n2/mq+s2v6/l0v5o5GVEG7BBd8pU8lIVp0QkZgQyBq829Z+dziFRQSBDc1BVjywGTZT
         Ue157lr32GqmhEbOFW+zoN3yL0D4DWApacpUfLvCmWGCWhyymQLOWfzIF8EwTf/Vtasc
         chdsxy5yIuVaQlcs0wG6Y6cllTpAD9NWrGcP8idoY+HIrnRACKx5k2uA6SbJUs4g27Zm
         h3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734472053; x=1735076853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2jerrcD1nGClFF+pwwbUr/tdkat4xQ5wJ8skGDMH+c=;
        b=mNGiKqv46QOea0NxcCayoqkVApCgwziRi9+BcRNWJ6XXtf4GvjxgT40sx9Xv2AIENk
         MU4di8Jiw6rgxeQ9VOJMFZx9RH8B9fi2X91foj+nbxUrDAE+dWCdqjInDrCQtsPGOrs+
         XNxil7wQviBx2u+59xXKAVlkTf4RdjWqaEuTQ7jx2vLFtk4N2qN9HP6v6MByAQYHPQRt
         Jo9uq92S7uESFUEXNlJGK7S+1d2bKXdMYSnalLolJJkgMpP7Izj6GJ13k7pgIPjK5vZH
         jjRgpadY7WW5CstlnyEk8QM9S2x0bw/K/jRMDc+iCRV+EDNdjz/LPm/+VGiJbbhOhoVY
         baDg==
X-Gm-Message-State: AOJu0YxnAtMuwq52CV6RQzuZqf9Ji9gCooYw+dn83gaKEDnVeA5p4tcw
	oN07n0mMSJpk3hXoV1TbHBNzQqTELIgh6xlluK/ZRrUsqLfTPDByhEkoZxVxsJs=
X-Gm-Gg: ASbGnct0KlXWXQNi7AO0gk2nqvXpxvlnr5u3FrFMrgeB/fWDLmj5usAteEKswnAaAhC
	EK0EFbk3bU207J7O1QCfVwLRjwIePDlcUB0L+TkFolQdOu3J8yzMQHpdXcY09hJiRUlPxO41zAB
	/s6xEVEGY0c7T8019MRC+vowiXF84/GJ2V2AuW8fpvC9Dmtc8rEXr7AZRDBJR+Hupfe9vmluPhG
	KGLA6GknZYN2OYdzXzTvoPqJc9vxdFpHo8VM4YMXDxDrbU8cKemi/v7K4IyXf+TsrLgb6Wwv9dV
	w94Bj7oAFpQhp/W2
X-Google-Smtp-Source: AGHT+IGfUKqTzhb+KyEvQJ+1fmr9Oi39Z91ue5ioU5B1N5OQfbf8bpjZTFXWHo4XK9ki9DBrVjqWDg==
X-Received: by 2002:a05:6214:1301:b0:6d8:8667:c6ca with SMTP id 6a1803df08f44-6dd09241f5emr12256036d6.32.1734472053451;
        Tue, 17 Dec 2024 13:47:33 -0800 (PST)
Received: from localhost (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dccd22f0b7sm43260876d6.23.2024.12.17.13.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:47:33 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Tue, 17 Dec 2024 16:47:29 -0500
Subject: [PATCH 2/2] doc: iio: ad4695: describe oversampling support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-ad4695-oversampling-v1-2-0b045d835dac@baylibre.com>
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
In-Reply-To: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add a section to the ad4695 documentation describing how to use the
oversampling feature. Also add some clarification on how the
oversampling ratio influences effective sample rate in the offload
section.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 Documentation/iio/ad4695.rst | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index ead0faadff4b..f40593bcc37d 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -179,12 +179,38 @@ Gain/offset calibration
 System calibration is supported using the channel gain and offset registers via
 the ``calibscale`` and ``calibbias`` attributes respectively.
 
+Oversampling
+------------
+
+The chip supports per-channel oversampling when SPI offload is being used, with
+available oversampling ratios (OSR) of 1 (default), 4, 16, and 64.  Enabling
+oversampling on a channel raises the effective number of bits of sampled data to
+17 (OSR == 4), 18 (16), or 19 (64), respectively. This can be set via the
+``oversampling_ratio`` attribute.
+
+Setting the oversampling ratio for a channel also changes the sample rate for
+that channel, since it requires multiple conversions per 1 sample. Specifically,
+the new sampling frequency is the PWM sampling frequency divided by the
+particular OSR. This is set automatically by the driver when setting the
+``oversampling_ratio`` attribute. For example, if the device's current
+``sampling_frequency`` is 10000 and an OSR of 4 is set on channel ``voltage0``,
+the new reported sampling rate for that channel will be 2500 (ignoring PWM API
+rounding), while all others will remain at 10000.  Subsequently setting the
+sampling frequency to a higher value on that channel will adjust the CNV trigger
+period for all channels, e.g. if ``voltage0``'s sampling frequency is adjusted
+from 2500 (with an OSR of 4) to 10000, the value reported by
+``in_voltage0_sampling_frequency`` will be 10000, but all other channels will
+now report 40000.
+
+For simplicity, the sampling frequency of the device should be set (considering
+the highest desired OSR value to be used) first, before configuring oversampling
+for specific channels.
+
 Unimplemented features
 ----------------------
 
 - Additional wiring modes
 - Threshold events
-- Oversampling
 - GPIO support
 - CRC support
 
@@ -233,3 +259,11 @@ words, it is the value of the ``in_voltageY_sampling_frequency`` attribute
 divided by the number of enabled channels. So if 4 channels are enabled, with
 the ``in_voltageY_sampling_frequency`` attributes set to 1 MHz, the effective
 sample rate is 250 kHz.
+
+With oversampling enabled, the effective sample rate also depends on the OSR
+assigned to each channel. For example, if one of the 4 channels mentioned in the
+previous case is configured with an OSR of 4, the effective sample rate for that
+channel becomes (1 MHz / 4 ) = 250 kHz. The effective sample rate for all
+four channels is then 1 / ( (3 / 1 MHz) + ( 1 / 250 kHz) ) ~= 142.9 kHz. Note
+that in this case "sample" refers to one read of all enabled channels (i.e. one
+full cycle through the auto-sequencer).

-- 
2.39.5


