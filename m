Return-Path: <linux-iio+bounces-14741-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC5A2334E
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F4162ECD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CDA1ACEBE;
	Thu, 30 Jan 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F8bTpC5G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C695145B14
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738259143; cv=none; b=N5XjU4sYUzndfPZ3bM9EBseSbvySZbZEjAzwEd7KIOJg0j1c3UEgDxOYzpI1drDBqo3YaL7d64oDd2MKBUlJWP3DwBswtrQOUSS0taSnAB/O3DBZhGnqmuINIZqbh72PAiKgerXL3TPBv44jnfrPTZTx8s9k40cRMztL6Hd8cnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738259143; c=relaxed/simple;
	bh=vfDZnD6Ua2cIA/ztLux1e4U1IfeXvqAsCFCH/wOVvIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Py+SZhLSjQQxnjprmnvvXSj1DXulrb4WfyxtC0Mee1FLI8igRsRXbDlY+3lYYtbVrIMDRbPXioIueizLGahLBIG/lwv5Qi7tjLeulS0JeCJfypQLlxt5Mh+hTqgtgWbHHi0HHL8VRvxbkIjpim1ADjo3AXfKBQiFuh9rytoLeYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F8bTpC5G; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeef97ff02so198879466b.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 09:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738259139; x=1738863939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1mh9nnX3GcIceAhA1b8AUp6XBg9evpAuAnvXOh3LTM=;
        b=F8bTpC5GD5T+LPaVBhlHPKmxVLM5RE9YIz+tfblLwaAh1+tBfa+c4hRhVbJ8p1HsXS
         h0307+JF37menQBC3s7wuH+bkP2FeESpOe9lYphdOBzLy0Z8R6r6DCWE3L+hkitoVjUm
         rXzraUvBldh5iDlXylNqaPpeie8RKKuRADFrAoiTvSboKfcBFgYwoD09RuIEGfQnc7Le
         AaWASp5+5aB2b7pCBzI6CA6mH61kMWg+/Be1BNPQnNKIAc4n5wvoRWAOXE/pojcsPMOX
         O5INXgQS1gI7dvcQ97W6zq14/arD2IvkfyyMW9a8MUocm98EVp/X6iJcY8/YUKC2Xz3j
         n/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738259139; x=1738863939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1mh9nnX3GcIceAhA1b8AUp6XBg9evpAuAnvXOh3LTM=;
        b=QL6JSsEdpfjYaPegasYQnBLJ5Y8cDnFUufumnEtkJy+LHn/JMefizUaMTawLx6bfXb
         x5MjY8tubkLykMwrwdcMDQZLwwn5yS7FSrx2DS75lldYSUnfbQBAWQhA8U8hA+uNjT68
         loQIBD+KMUWsyTD7n4JEgwQRelQ17+umXWOiIpqsMM3qRicPzkw6SXPMXqowBd6RX9G7
         1M4HGOOwxQalXNjAwcfQKBcjjBb5/aPiFdfugBMP0KbgsTmuhHPuCxPbaYnFQmjfT+WE
         HhekhnFjuNkoiYLv7GKNgFYE2psRFIubKeKWGmWDtpmDDEVYbPriJSFRTAOzYGBdkiVY
         Fe7g==
X-Gm-Message-State: AOJu0Yyl5M0XJXNFU8qySEto+Oh9sWvdEojJrcCEzMWCG31J5jfwHkTN
	hrsYOJFlV79iT3DRC2m+SsbE1CtQj3mmqvow2QYy82//qNpnbgl00SxYHkNivRI=
X-Gm-Gg: ASbGncvo04vnasce/grANF76aLjhLge1E2JE7ofmO8KASkhp+k7EtP3UiOFbGGxZkqk
	N76W2goVuKEzsM2N48W0fluEhgM5SD619uw2fUAaDhM76886xNPX5U2dLwtj+pwLE3NE1sx8yug
	/tkIlJtcxCzifwxQuKbpdoktBNZ4F1TJjNnt4c/VE5C/17jXJB31ghRPEllSLyIYWYvNTxy9Ih7
	qud46QvduRxRc1ricG/n8mO6x6ULBMJXo4/hrZf2X0aO+Np2WPY9wK92tEtEv4IS1uLTnRCvQvA
	LiCNShpxHUTrSbn8Furu
X-Google-Smtp-Source: AGHT+IHYs3eZeXwcebr9dCJF77gZnhTDDQcoQESrfxGhuXXUNS8yPDc5g4gMztI1b/ZM5qlqU9zA9g==
X-Received: by 2002:a17:907:2d8f:b0:aaf:117f:1918 with SMTP id a640c23a62f3a-ab6cfcb35a6mr902370366b.5.1738259139511;
        Thu, 30 Jan 2025 09:45:39 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a5ada4sm152012766b.184.2025.01.30.09.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:45:39 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: adc: ad4130: Fix comparison of channel setups
Date: Thu, 30 Jan 2025 18:45:01 +0100
Message-ID:  <584b8bae1ad158fc86bd1cd9bd3dcae54b58093e.1738258777.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
References: <cover.1738258777.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2791; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=vfDZnD6Ua2cIA/ztLux1e4U1IfeXvqAsCFCH/wOVvIo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnm7qfGIydDjX4VExoVoHQfEzg14xyrLD1tBYd5 DLnbt9eth6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ5u6nwAKCRCPgPtYfRL+ TrU6B/98llaKA6w/CCVAmRZgqsDFRe6bdFr8L0ejegpghN/JdlP5Ly8/RL/yaEPiD7a1xtvkmcK /9kt3OrpQrpreJNXHLMb/+dA56b65PVOIk1hoIIHCdmwgabZ0AR+7SZ5XmESp1Lod9U0hN8su9O HK0MuD2NJYB6wT8paWN6Bn31fZbrFXs+maqgRMQZkPNcIurZga23Mo+5GPioChOZPoGWL2C5kMC +9g9m43SUR3JfHdc6objEQa3lvSWoum9QXM5AOFKK2SWxqo45FnYwG5wIaWVaU12d+WL5K7Sjq1 JZ0Hie5mO5yV1aZGxU31MY8foLaZpC9Qb1jCo8uG5rK7Raue
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Checking the binary representation of two structs (of the same type)
for equality doesn't have the same semantic as comparing all members for
equality. The former might find a difference where the latter doesn't in
the presence of padding or when ambiguous types like float or bool are
involved. (Floats typically have different representations for single
values, like -0.0 vs +0.0, or 0.5 * 2² vs 0.25 * 2³. The type bool has
at least 8 bits and the raw values 1 and 2 (probably) both evaluate to
true, but memcmp finds a difference.)

When searching for a channel that already has the configuration we need,
the comparison by member is the one that is needed.

Convert the comparison accordingly to compare the members one after
another. Also add a BUILD_BUG guard to (somewhat) ensure that when
struct ad4130_setup_info is expanded, the comparison is adapted, too.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad4130.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index de32cc9d18c5..ae321df426b5 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -591,6 +591,36 @@ static irqreturn_t ad4130_irq_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
+				 struct ad4130_setup_info *b)
+{
+	BUILD_BUG_ON(sizeof(*a) !=
+		     sizeof(struct {
+				    unsigned int iout0_val;
+				    unsigned int iout1_val;
+				    unsigned int burnout;
+				    unsigned int pga;
+				    unsigned int fs;
+				    u32 ref_sel;
+				    enum ad4130_filter_mode filter_mode;
+				    bool ref_bufp;
+				    bool ref_bufm;
+			    }));
+
+	if (a->iout0_val != b->iout0_val ||
+	    a->iout1_val != b->iout1_val ||
+	    a->burnout != b->burnout ||
+	    a->pga != b->pga ||
+	    a->fs != b->fs ||
+	    a->ref_sel != b->ref_sel ||
+	    a->filter_mode != b->filter_mode ||
+	    a->ref_bufp != b->ref_bufp ||
+	    a->ref_bufm != b->ref_bufm)
+		return false;
+
+	return true;
+}
+
 static int ad4130_find_slot(struct ad4130_state *st,
 			    struct ad4130_setup_info *target_setup_info,
 			    unsigned int *slot, bool *overwrite)
@@ -604,8 +634,7 @@ static int ad4130_find_slot(struct ad4130_state *st,
 		struct ad4130_slot_info *slot_info = &st->slots_info[i];
 
 		/* Immediately accept a matching setup info. */
-		if (!memcmp(target_setup_info, &slot_info->setup,
-			    sizeof(*target_setup_info))) {
+		if (ad4130_setup_info_eq(target_setup_info, &slot_info->setup)) {
 			*slot = i;
 			return 0;
 		}
-- 
2.47.1


