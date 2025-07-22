Return-Path: <linux-iio+bounces-21880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 210C7B0E404
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FF01AA7946
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C792836A4;
	Tue, 22 Jul 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UGzAW7iV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62D27A121
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 19:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212019; cv=none; b=IjJWN0hxOtaZ4EkxTmmM+5LQ47qdI7QJzTxtEKoSCGt11HUbtx+NbOOAy+yL6PfAFt8c6xArnsMKSh2SWNFEGMR5oGq6HBxqXd2avpS7ilNxzJrID+UqFAK2cHnMmo8PyuLAVxXS/FFYkPAzWyfcWVTaln+dwQKyea8nDHrWNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212019; c=relaxed/simple;
	bh=uC+cJzF1sL7UGXFBRf+LsG4ZqTCJIrhWBTRWb6aCCks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fm+OP3sDJ5xY1vr/Jb5xiOzf0Gv1Dc6AYUPqyPk1IjC/GFcTkNA2zmJ6rI1xw8wgH7BP2y9UYedeVV4ss4xkOIoaBBgX+kxQ0O3Ca61XWuntncJFWoXQZLXp3S7xBXJ9Yi+01AnxrJtmInERutd2shvD/2Z+x/R0yO5A0onoGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UGzAW7iV; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c14138668so2461123a34.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 12:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753212016; x=1753816816; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDtejlZx5yEfYYq9UmbQwFH5oHPr/mFoQRNc2bfGPRA=;
        b=UGzAW7iVKUYuPNK5lACiO6wS/iY0AA18X/umIlesrk0FPCIS0Y0g6spW27mpHWwd92
         xtSyfK8sKrfxoDiUekkrbzhH8JdoLjsc6yAjJRX3BrecQ+siYyDJveF6ajQkFAJIW84/
         22WPcfJBEuQTsNVzYXzh3JwdbIwoC4FX0fF8PRXAGsFD3ReBqoKix4+F5Wio62UcloOK
         xxcMWrNvQkRykNRtldpeq7ZSMGmm8Wk/Gt8buh2TX5VN0TJZy1OSasFfreh0OySP2B/t
         mqoJC1jWyfcUWHyox3aYKm25gl6kuXfEW6BmoX9LjNCD5a4VNctgB+QMd5tg4OHlQF9N
         FEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212016; x=1753816816;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDtejlZx5yEfYYq9UmbQwFH5oHPr/mFoQRNc2bfGPRA=;
        b=GCjAlagRwdcwb0C6WmmDJSru9CNJmlFxyrK8inKHgDNUd4QkJZ1pBUdYf2RKec97Wi
         O83BgqXYsHnIg94HB2bcoUNinzP9yKcjXrHm7ChHlk8nLCenFOYeiCFJp7uVnsTLiW7S
         q0dDwKss5gFt5zSvOdgS0ZbuY+dM1mbjBiEJItUGsZIQU/ZQXao5gsksdyAtdoP9mWMH
         4Xg/KNqDtwrG3UgPjggY21EWrRtNJ8QXkAW2GavcjqRldcVnUFODoiRZGxw28JjBQ+k3
         hU/H7uxXLoALOLayzuyVl1AxwkxGhpIP9uZILMZdmP5N6fw7iTUzk4n1LXgnauk2ruTU
         LgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWNevW/9vb5oqubRoCtvppzwN88cAWwBz5Tya/B8uZhtIhXI2rP6M6t39quFUh/uh/S3Lm3un+6OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCA/OMe5WDUGdTWHDnzXfl6QXENWpv76TAyiCFiYWlqvbWf0Ne
	z7EU71Verp0OMmwPEDpLHIb14PAyDIvahKu2dNGDdFopm1D+OJ6I8eHflExSBmChENs=
X-Gm-Gg: ASbGncvNNN9Jt6uW60JoIJmJlDdLWZE8kDqiQAQ9OBbCnxI228OdB8Gpc19zVr0hhLq
	dxMDGIA5NJ/gYzzpmCr5D2NM/TKIfNg0Mqkee21Sffj/lSI0ArCvcg45kaErmwIR0R8vCst0Elt
	0i0cqqhmOc7t64fEWmghB4phOSwl3wvS0H93lOphVY4mRZ11KemdsdntSFu0U60Ht8DZIPf9DEK
	Ag/EzzFyKyAgtu8awf1sPLZ+WCrf2vYnGoKe1Ey5OM4APw6T2wR4surdgACXOfM471V1a9ER7Si
	2dxEzrvy52AW9HjwseIcJ6pfgm1Cc2ywCfO/BrDOoyzq66/RiNN1NBA3YBPZBKt+G6Ya6ImvqFw
	uvqh5GLfpWpeVQVUzL8Q8tJ7LNo8n6rVGtfiptBU=
X-Google-Smtp-Source: AGHT+IHdTAwakxYbl/tQkk84omytF+ZWmZXptDfN6ewyRtV6WT8zT92E79UtxFwipK0+X4mNs4CluA==
X-Received: by 2002:a05:6808:170b:b0:40a:bcbf:2d83 with SMTP id 5614622812f47-426c6919360mr415042b6e.28.1753212016058;
        Tue, 22 Jul 2025 12:20:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd10c25d1sm3294381b6e.9.2025.07.22.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:20:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 14:20:07 -0500
Subject: [PATCH v2] iio: adc: ad7173: prevent scan if too many setups
 requested
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGbkf2gC/5WNOw6DMBBEr4K2zka2+Tikyj0iChtvwkqAkQ0oC
 HH3ONwgxRRvNHqzQ6TAFOGe7RBo5ch+TKAuGbSdGd+E7BKDEqoUWtTI7NG4NkVLneOLPxhpXiZ
 cImHPA88RhSmdspWp9E1AMk2B0u58eTaJO46zD9t5uspf+59/lSiRCqnyXKjaFcXDmq1nG+ja+
 gGa4zi+RZ1bJtkAAAA=
X-Change-ID: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6769; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=uC+cJzF1sL7UGXFBRf+LsG4ZqTCJIrhWBTRWb6aCCks=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBof+RoWv/qA6bCB8XGnnXfSG3My+OYmKEqpdJQe
 +AajWj2iKCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH/kaAAKCRDCzCAB/wGP
 wFmiCACetjpVLz21pQLERkdVwFqPdvTArL/PHW/41Atnh19fh9Eow4HBO5eSsOi5Chf8G7ncu3G
 RJG+h6GetKYadh2EphtShI6HLnIBrL9ZiphmMrOErdIUkd/QdjdaudfNwgMJvRzq+AwWkd8hmu9
 M2viDwGZuYRiHMaq5kqMKCj94d4ugGoCw0aATeFzIRNXnhSYXiBo1Dt+ko+VtAOiPZoOpJEWCpu
 F651va4E/McDQcLe+B5RFX2sxgD+UnzQ4KJitsV8TQ2ItHTdxIfmD+ITmcq2M2o0Ck1NE0hUUeW
 33ECjfjimPxA2WVtKxS8fru/IQI69fxo1Jo74ikYvs8477tq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
the maximum number of unique channel configurations.

In the AD7173 family of chips, there are some chips that have 16
CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
GAINx and OFFSETx registers). Since commit 92c247216918 ("iio: adc:
ad7173: fix num_slots"), it is possible to have more than 8 channels
enabled in a scan at the same time, so it is possible to get a bad
configuration when more than 8 channels are using unique configurations.
This happens because the algorithm to allocate the setup slots only
takes into account which slot has been least recently used and doesn't
know about the maximum number of slots available.

Since the algorithm to allocate the setup slots is quite complex, it is
simpler to check after the fact if the current state is valid or not.
So this patch adds a check in ad7173_update_scan_mode() after setting up
all of the configurations to make sure that the actual setup still
matches the requested setup for each enabled channel. If not, we prevent
the scan from being enabled and return an error.

The setup comparison in ad7173_setup_equal() is refactored to a separate
function since we need to call it in two places now.

Fixes: 92c247216918 ("iio: adc: ad7173: fix num_slots")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
My musings in v1 might have confused things a bit, but my intention is
to have this patch fix things well enough for backporting stable kernels
and then perhaps look at a better way of handling the setup slots in the
future.
---
Changes in v2:
- Updated the commit hash of the commit being fixed since it was rebased
  before being sent to Greg.
- Fixed a few typos in the commit message.
- Link to v1: https://lore.kernel.org/r/20250709-iio-adc-ad7173-fix-setup-use-limits-v1-1-e41233029d44@baylibre.com
---
 drivers/iio/adc/ad7173.c | 87 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4413207be28f60a4d9529e3522f5d2fd6276bcc2..131cd1cf8a23c57dfeb156a96864e6cf2a2b6bf9 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -200,7 +200,7 @@ struct ad7173_channel_config {
 	/*
 	 * Following fields are used to compare equality. If you
 	 * make adaptations in it, you most likely also have to adapt
-	 * ad7173_find_live_config(), too.
+	 * ad7173_setup_equal(), too.
 	 */
 	struct_group(config_props,
 		bool bipolar;
@@ -561,12 +561,19 @@ static void ad7173_reset_usage_cnts(struct ad7173_state *st)
 	st->config_usage_counter = 0;
 }
 
-static struct ad7173_channel_config *
-ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+/**
+ * ad7173_setup_equal - Compare two channel setups
+ * @cfg1: First channel configuration
+ * @cfg2: Second channel configuration
+ *
+ * Compares all configuration options that affect the registers connected to
+ * SETUP_SEL, namely CONFIGx, FILTERx, GAINx and OFFSETx.
+ *
+ * Returns: true if the setups are identical, false otherwise
+ */
+static bool ad7173_setup_equal(const struct ad7173_channel_config *cfg1,
+			       const struct ad7173_channel_config *cfg2)
 {
-	struct ad7173_channel_config *cfg_aux;
-	int i;
-
 	/*
 	 * This is just to make sure that the comparison is adapted after
 	 * struct ad7173_channel_config was changed.
@@ -579,14 +586,22 @@ ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *c
 				     u8 ref_sel;
 			     }));
 
+	return cfg1->bipolar == cfg2->bipolar &&
+	       cfg1->input_buf == cfg2->input_buf &&
+	       cfg1->odr == cfg2->odr &&
+	       cfg1->ref_sel == cfg2->ref_sel;
+}
+
+static struct ad7173_channel_config *
+ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+{
+	struct ad7173_channel_config *cfg_aux;
+	int i;
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live &&
-		    cfg->bipolar == cfg_aux->bipolar &&
-		    cfg->input_buf == cfg_aux->input_buf &&
-		    cfg->odr == cfg_aux->odr &&
-		    cfg->ref_sel == cfg_aux->ref_sel)
+		if (cfg_aux->live && ad7173_setup_equal(cfg, cfg_aux))
 			return cfg_aux;
 	}
 	return NULL;
@@ -1228,7 +1243,7 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, k, ret;
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		if (test_bit(i, scan_mask))
@@ -1239,6 +1254,54 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 			return ret;
 	}
 
+	/*
+	 * On some chips, there are more channels that setups, so if there were
+	 * more unique setups requested than the number of available slots,
+	 * ad7173_set_channel() will have written over some of the slots. We
+	 * can detect this by making sure each assigned cfg_slot matches the
+	 * requested configuration. If it doesn't, we know that the slot was
+	 * overwritten by a different channel.
+	 */
+	for_each_set_bit(i, scan_mask, indio_dev->num_channels) {
+		const struct ad7173_channel_config *cfg1, *cfg2;
+
+		cfg1 = &st->channels[i].cfg;
+
+		for_each_set_bit(j, scan_mask, indio_dev->num_channels) {
+			cfg2 = &st->channels[j].cfg;
+
+			/*
+			 * Only compare configs that are assigned to the same
+			 * SETUP_SEL slot and don't compare channel to itself.
+			 */
+			if (i == j || cfg1->cfg_slot != cfg2->cfg_slot)
+				continue;
+
+			/*
+			 * If we find two different configs trying to use the
+			 * same SETUP_SEL slot, then we know that the that we
+			 * have too many unique configurations requested for
+			 * the available slots and at least one was overwritten.
+			 */
+			if (!ad7173_setup_equal(cfg1, cfg2)) {
+				/*
+				 * At this point, there isn't a way to tell
+				 * which setups are actually programmed in the
+				 * ADC anymore, so we could read them back to
+				 * see, but it is simpler to just turn off all
+				 * of the live flags so that everything gets
+				 * reprogramed on the next attempt read a sample.
+				 */
+				for (k = 0; k < st->num_channels; k++)
+					st->channels[k].cfg.live = false;
+
+				dev_err(&st->sd.spi->dev,
+					"Too many unique channel configurations requested for scan\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	return 0;
 }
 

---
base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
change-id: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


