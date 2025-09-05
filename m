Return-Path: <linux-iio+bounces-23797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2137B46036
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952D05C5CB0
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016B931D72E;
	Fri,  5 Sep 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FPGv+b7O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3C30B537
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093628; cv=none; b=Sm4FnI6oNu9OexqwRB9E6uVUU/QxK2qnlaJ4RyhsHw/p8ZuRYZGoZrNurDcHhVbrK+WtUxd0TsfCSecanrYTebApgGCEvhWLwynw4QZHqII+tRijQDXbPOlulE+DITkVF6z9ZMHxZwdy2ma0e7Wi7qVcYXLj1JWBqaLAEaUA6Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093628; c=relaxed/simple;
	bh=GwF3ED0m48GGA77whrTOOJb6X25I71ZtGJNAbQ1LOaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sFhgkb8RaxL2q+qWq5qyOyq8a9qAsUcv8RzTBHb4DN5xVu0hUtl8rbBhYq5XJV7O5HCEC/w3yQjJJKBoK/Ma4UZ1fH1w3My+TQra2vAj7ZkKUtNkwDmuTdkvbsX60SLIv3A11NdzTsaXuqWyQww+5UVZzQJZk1bVu0q5l93XLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FPGv+b7O; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74595f3852cso1615806a34.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757093625; x=1757698425; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6CL54Vt1QIQaD8a/M2rLC31EA2PCSOBA+7vsqt0Vn8=;
        b=FPGv+b7OcPagoo77T2zKKAOpUASZkAwVqZ73MZS9iTKkGFXGhV83J8TGWwF0nM6ldy
         dMQ4aVop9QNsedCAT8rHOVI8tliZxlxmAAoKiNexOEaA525xZ/92FACTap0xvFv7LDBp
         M7CpkFkzaST8XpU66s/8WHOGM/xs8m0CKlFAUXlZ3O5HxwAgBeAgq6rB/b+cy4zbGDJC
         gP9m+wpJFSwSG3k6r1/+4ycawYuAfx24WOpj791K1oFy7270hE5BwGqvrrsBewgjameI
         hljvuV7XGiUonXRFFBRmCzF5kiR88cZWNJ40bYeB8OZ0evDnirtNo4dk/frCCH9hyNkj
         NlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093625; x=1757698425;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6CL54Vt1QIQaD8a/M2rLC31EA2PCSOBA+7vsqt0Vn8=;
        b=W7cKtZZJm+aUisvaxj5C8qEx9hopSgHi8oI7zkdZvmVh3R62Q3b5nUaYAs6jU6G4l7
         CQh9nzNp77UR0d36Qg/PkJxyZuRiNkkrk80lemVd825Qadona/ChqcSDdy1lQ7eOxw0H
         C5KUCyd3cxC2H3X1Xxdg/2aTlOsgCwzMyCVef7Zci3VUjMhdw/R7X2IFghadVZaxx1KJ
         9lQ6447jrtCEOOFxZxcYoTZJXHbyj5uVo0ahlTbURTyXr8RXUpvSM8lGy82aj4DJKcB/
         i554SKOjyhuziAoBVoRVzNMBDFVImOodl8qLBfJzg4BXTw/DVk/uP1esr2k1pvk7YSoc
         gYjQ==
X-Gm-Message-State: AOJu0YyGDhoHR2iistgnb6QhedP4JZOwFc17JODIA4yNAQkfVdkZReX9
	jig/I7tqxHRBwxHHnu8QPVnb5F5S6le721UJ3kDGTaUQ0hvaX8u/JM7GkglLanMTL2Y=
X-Gm-Gg: ASbGncv6HV0biO6eTIj7lq65CZLFRhqWwJm4ESZ1RKvHKuzULO2Dn5ieIsBcNsPoj8/
	P5V78f/SQjWtXcxAdD7zFjgSb2r7dIdL8qkgN6Ix7rng5O914Ns7+gyGmCowzMGAkJJo633hogT
	loQgc3UkOR32/sWSDnhvl40wq2JWUlUT6opJzb8FZNYMWVOP37PUc6oNmjHA0oXmLho6BIFFEPA
	93X3NkZ/kgDdQVOQutwo1vpekj/5uXdvZ15dFWCmWeChG28f6h4HhFerlVEBHwGlPuue+180ppG
	mLAlwP6b/ETw0buihVpX/YPGmjNu7a3TaEQfoEHF2urOmExMb++Nmvswq0CsRNgM/b3/RfmXWgm
	oN/+XXjrWPetREvEDWUMafQfhc+OXa3e8GVtP6w==
X-Google-Smtp-Source: AGHT+IFBsJ3+NraCpnPdQ6qC3rJ2anWg/x97RhlTKeQVnrYSYhPvlXRjsScNWOOafKT98rvFJwHR7w==
X-Received: by 2002:a05:6830:82e4:b0:746:d4cf:b47d with SMTP id 46e09a7af769-746d4cfb612mr3433054a34.3.1757093625470;
        Fri, 05 Sep 2025 10:33:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-62174cc4059sm152913eaf.6.2025.09.05.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:33:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 12:33:34 -0500
Subject: [PATCH v3] iio: adc: ad7124: fix sample rate for multi-channel use
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAO0eu2gC/52OQW7DIBBFr2Kx7tR46jaQVe9RdQF4SEayTQLEa
 hT57p04i0rdtQs0+gyP92+qUGYqat/cVKaFC6dZwstTo8LRzQcCHiQr1PiqDRpgTuCGIGfXYQ+
 Rv6C46QQx0xliyjBdxspwh2cawXjE0BtvYtBKPj1lEmQTfnw+soAX8dbHpfKuEIQ0TVz3jbwub
 aYpybYVdSuz8nxQd/bIpaZ83bov3Qb/t+bSQQfRDH2wqN2bte/eXUf2mZ6lymZb8Mdgdf9nA4r
 B+4hRD9buyP0yrOv6DbxozmqNAQAA
X-Change-ID: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6560; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=GwF3ED0m48GGA77whrTOOJb6X25I71ZtGJNAbQ1LOaQ=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGi7HvGiNXwdMBCek6MWoegXwQJZSuOL1JFtjx2wQDLUluL6H
 YkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJoux7xAAoJEMLMIAH/AY/AYigH/RwH
 g+362OKR5SER4C9R1tHq8xlmd2F2lXifXTJkjJcZ6GMUoj4oSld+LQlkvhaLq93Bu/aDm3/aKsf
 swhDeV2xvAzgET4V3tQE2sBgOFMyvP2p1ihCfoFWoOk2KeTJh8LpfRHAEeKRjSw0EYWG+4JNuNr
 pILN+RSX1GBE41yfw0tIJd4THwHKbJtvqpB+4/SkHZFpw4/+XqUR7kMjD49HjRgvThr5Xqrcjke
 7HEhr4ct6PGM9zMB5Byc+ioR7ZSr1X+5g8RSfK6O4i5TuvySByK6ThbfhSH3Oskfia6DF1xTnNb
 PAJ5FUzcJkdCEw+KANCf5KWL1jIuYfV4XZXcq1I=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change how the FS[10:0] field of the FILTER register is calculated to
get consistent sample rates when only one channel is enabled vs when
multiple channels are enabled in a buffered read.

By default, the AD7124 allows larger sampling frequencies when only one
channel is enabled. It assumes that you will discard the first sample or
so to allow for settling time and then no additional settling time is
needed between samples because there is no multiplexing due to only one
channel being enabled. The conversion formula to convert between the
sampling frequency and the FS[10:0] field is:

    fADC = fCLK / (FS[10:0] x 32)

which is what the driver has been using.

On the other hand, when multiple channels are enabled, there is
additional settling time needed when switching between channels so the
calculation to convert between becomes:

    fADC = fCLK / (FS[10:0] x 32 x N)

where N depends on if SINGLE_CYCLE is set, the selected filter type and,
in some cases, the power mode.

The FILTER register has a SINGLE_CYCLE bit that can be set to force the
single channel case to use the same timing as the multi-channel case.

Before this change, the first formula was always used, so if all of the
in_voltageY_sampling_frequency attributes were set to 10 Hz, then doing
a buffered read with 1 channel enabled would result in the requested
sampling frequency of 10 Hz. But when more than one channel was
enabled, the actual sampling frequency would be 2.5 Hz per channel,
which is 1/4 of the requested frequency.

After this change, the SINGLE_CYCLE flag is now always enabled and the
multi-channel formula is now always used. This causes the sampling
frequency to be consistent regardless of the number of channels enabled.

For now, we are hard-coding N = 4 since the driver doesn't yet support
other filter types other than the default sinc4 filter.

The AD7124_FILTER_FS define is moved while we are touching this to
keep the bit fields in descending order to be consistent with the rest
of the file.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is one of those unfortunate cases where we are fixing a bug but we
risk breaking userspace that may be depending on the buggy behavior.

I intentionally didn't include a Fixes: tag for this reason.

Given some of the other shortcomings of this driver, like using an
integer IIO_CHAN_INFO_SAMP_FREQ value when it really needs to allow a
fractional values, it makes me hopeful that no one is caring too much
about the exact value of the sampling frequency. So I'm more willing
than I would normally be to take a risk on making this change.

[1] https://lore.kernel.org/linux-iio/20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com/
---
Changes in v3:
- Removed the ad7124_get_avg() and harded-coded N = 4 for now.
- Link to v2: https://lore.kernel.org/r/20250904-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v2-1-bbf2f0d997ea@baylibre.com

Changes in v2:
- Improved comment explaining why the new factor always applies.
- Fixed merge conflict with iio/testing branch.
- Replaced avg parameter with ad7124_get_avg() function.
- Link to v1: https://lore.kernel.org/r/20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v1-1-f8d4c920a699@baylibre.com
---
 drivers/iio/adc/ad7124.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c6435327d431e5f4ba28aa3332ec6eb90da7c83d..70f458e3ccc12db884dda9003abcffdf48989e5e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -93,10 +93,13 @@
 #define AD7124_CONFIG_PGA		GENMASK(2, 0)
 
 /* AD7124_FILTER_X */
-#define AD7124_FILTER_FS		GENMASK(10, 0)
 #define AD7124_FILTER_FILTER		GENMASK(23, 21)
 #define AD7124_FILTER_FILTER_SINC4		0
 #define AD7124_FILTER_FILTER_SINC3		2
+#define AD7124_FILTER_FILTER_SINC4_SINC1	4
+#define AD7124_FILTER_FILTER_SINC3_SINC1	5
+#define AD7124_FILTER_SINGLE_CYCLE	BIT(16)
+#define AD7124_FILTER_FS		GENMASK(10, 0)
 
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
@@ -285,18 +288,20 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
 
 static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
 {
-	unsigned int fclk, odr_sel_bits;
+	unsigned int fclk, factor, odr_sel_bits;
 
 	fclk = ad7124_get_fclk_hz(st);
 
 	/*
-	 * FS[10:0] = fCLK / (fADC x 32) where:
+	 * FS[10:0] = fCLK / (fADC x 32 * N) where:
 	 * fADC is the output data rate
 	 * fCLK is the master clock frequency
+	 * N is number of conversions per sample (depends of filter type)
 	 * FS[10:0] are the bits in the filter register
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
-	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * 32);
+	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor);
 	if (odr_sel_bits < 1)
 		odr_sel_bits = 1;
 	else if (odr_sel_bits > 2047)
@@ -306,7 +311,8 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 		st->channels[channel].cfg.live = false;
 
 	/* fADC = fCLK / (FS[10:0] x 32) */
-	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
+								factor);
 	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
 }
 
@@ -439,10 +445,20 @@ static int ad7124_write_config(struct ad7124_state *st, struct ad7124_channel_co
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * NB: AD7124_FILTER_SINGLE_CYCLE is always set so that we get the same
+	 * sampling frequency even when only one channel is enabled in a
+	 * buffered read. If it was not set, the N in ad7124_set_channel_odr()
+	 * would be 1 and we would get a faster sampling frequency than what
+	 * was requested.
+	 */
 	tmp = FIELD_PREP(AD7124_FILTER_FILTER, cfg->filter_type) |
+		AD7124_FILTER_SINGLE_CYCLE |
 		FIELD_PREP(AD7124_FILTER_FS, cfg->odr_sel_bits);
 	return ad7124_spi_write_mask(st, AD7124_FILTER(cfg->cfg_slot),
-				     AD7124_FILTER_FILTER | AD7124_FILTER_FS,
+				     AD7124_FILTER_FILTER |
+				     AD7124_FILTER_SINGLE_CYCLE |
+				     AD7124_FILTER_FS,
 				     tmp, 3);
 }
 

---
base-commit: d1487b0b78720b86ec2a2ac7acc683ec90627e5b
change-id: 20250828-iio-adc-ad7124-fix-samp-freq-for-multi-channel-8b22c48b8fc0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


