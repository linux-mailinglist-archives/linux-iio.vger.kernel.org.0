Return-Path: <linux-iio+bounces-16958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0984A64D61
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913E0189630F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414523816F;
	Mon, 17 Mar 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0VUAXpf3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91259238144
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212391; cv=none; b=ZL2GOaxjNAV2of/at1RqM9Eka2NsT2b9x+jQKBBsNoEwySqPoGuijyZN4yeeg2G+8Og9yrEhPqxXzHQUcu/WB+eH9vqJssRuEMXwSTAZ9FRG8tss7oaLCUb2lcCCoPbS4lgKQAUoxWtkvQy9wX3G24bqcwuf9QEkZIifTEnrC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212391; c=relaxed/simple;
	bh=YzoYMhNzQ7/XUgJMMbNViK5f9ibBz5Uq0l3tYQMrpeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1f7lmIZQn5JytyHbBoL2HGeYLyAuK4EqW1l3JQiO8Ip49CiP/G5Hf/XeUT8iR4+27fDzu334N6rOkf7W0Ra2NWB2W0V6JaDJJ6GPttYbfSZKGr4kYRApZ8Y8s61/0OOqd88dE3nhMtyifhSgNrjs+DvsTy0Hc9eC+OZtlmhz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0VUAXpf3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abbd96bef64so778523766b.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742212388; x=1742817188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evCZTos7wVc8Yqasd9Efh3Pol0F2dWkHOf7yVSYWknc=;
        b=0VUAXpf3xTVLKRCaFOAIbgGk39HLteBSeTpOVtztxBewSylS0THA3JcpbbUj2t/fWd
         88LH1H+Si1Zo2UjV6WOabHKclXEXVl4zYQIhlpdsx0D/W7XJq2Zj20Z6EWh6Mr/NGTf8
         ULGwjTZ8JBSqId+O522roPhs8VB+HshF5lwWk87fRRKf0CYXz8PMCk7MpSEgnr7I7HGE
         n3qQ1q+GIqW1TeOSBsJhVL/qysj0qhVwHWOSCmxSC00i2XRgcPZIEvo0CjbOm3jn3y9m
         V0tWThmkzOfyc9wF4gsPsGbULYr6lZQpf6TjV+wNbIW5WUcnKIn7trM0++xJA+BeO85S
         lgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742212388; x=1742817188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evCZTos7wVc8Yqasd9Efh3Pol0F2dWkHOf7yVSYWknc=;
        b=dbLsDJLLtmy+/xSIpI35n2c7RNMLt9oFIugdXTiOkBCvnfs6ifqenyr4WrSxz6seng
         KJD3PS4XxN8XaCqoDtjzJx801xLHLCkfvOFuZkOmG2ZqkcL2b8Xhwe6KLW7WmkahYbpm
         JWNmJT89F7DFI6EQdvoeOIm5Ln4UBG60IjI4PcaeuOMZbhvKdtOxFnEyvZokpYK5cgB2
         v46QWY7fhX1nCdvwjdjIXiA9g/GCVGZrI/maXWQjDukXYNXuQsaswPHI0VFbEjFocSMs
         CfzSW2Q2tcy6Jcuc1okwzrA5zdeuqMlu1ApGsE7CvpyxZu0NkvrVYGRjvKzo/hF+fVae
         kZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXF2HYwkIt4Ko6NSwMtEQEgplprB8J8joPUkUULHoKqq3NY3FHtHC77BZavZbSi3t2R0+uTvyz/2/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxktVDVMqPZfroFAWZremOFDJpWCcCU2xwNgqcYec+jYlj172
	GJKwwXfVnzqsGYQ3plr9XAbusYPZSXCYYckXPtzauPcIY6zVm7IxyNWGUY20m9qOReEqlt5SlgB
	+
X-Gm-Gg: ASbGncukPHl8kr0hpjcjdKUkj+5q9gYTlLpU4XJIYnj2tI2li0piQ1tFpWxtn2Mdsi+
	AK75SltaxZzkZBo2VXhowKI/ewkVyBr3nA09GiZTx++SL8Dgaf2oZxbj3iynh5Q4bDjTpdBwzmM
	UBD8i6qJki6sFGgx4EwHXdn5o+RNIXCD8FqoluhVXYkDo21IgMTlM124nClzDUoJHu8q3hsV5gC
	xr0JzSYjoOU1/VvDm88fQDVBPkSgEOmkKErCXRJuzoY/uk097h/OY3UlXdzqJcVFr9U/oHIjBQK
	Hz6lWVGHGAfZMlL30lWcS5EzmviBMlxiJYkERbEyc/nWwKINXgEOMRbnZvscef/hOoATa90d0ri
	4+WMHClDgQk0=
X-Google-Smtp-Source: AGHT+IFv6PDPeoBNLMP3vuU+N5Ws6VlNB63en9xwYmI82RlPWAjEXT3x6ntuab5yJc4bMi6Ogtm9jA==
X-Received: by 2002:a17:906:6a11:b0:ac3:446f:20cb with SMTP id a640c23a62f3a-ac3446f24a6mr1043474266b.43.1742212387877;
        Mon, 17 Mar 2025 04:53:07 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0b4csm650806466b.122.2025.03.17.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:53:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 2/3] iio: adc: ad7124: Remove ability to write filter_low_pass_3db_frequency
Date: Mon, 17 Mar 2025 12:52:48 +0100
Message-ID: <20250317115247.3735016-7-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
References: <20250317115247.3735016-5-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=YzoYMhNzQ7/XUgJMMbNViK5f9ibBz5Uq0l3tYQMrpeA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn2A0UIU6V62pstGpiKh3Ni1L7+2X/b39kzJ8DI UV+edOOguuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ9gNFAAKCRCPgPtYfRL+ TiLnCAC51hu+UaRRLsM8Nq1oe0miawg7GPlC9sL0dQCxqBX1ZKYQ0+BtNs3vXZDqzn1sQNUijAM Lx3sLB/zeDfWYQKvtX4C696RRAZUndYazEhLOvD3wpE1w53x0TRhEUqP5MG8TTNfp8spbSlYltm ojiNAKggV+OswnrfdYUvrNX4d9MBBX4tzqz5i5Dp9TDLF9ITXJxzbdgiRvXqS+d3Deae8cZV9KU ix5LJEo5LEx69PPgo6HbHIFWaQKA5a8Z89M9LZgsKW9RaJ2wSabUZA814wWL7VstFt3ybRnDRaS AzSsMwbKmcbFQVBSFsBjQp6rqx4mzs1e0bp0SFmHI42SRkWq
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

There are several issues with the function that implements writing to
the filter_low_pass_3db_frequency property:

 - The sinc3 factor should be 0.272 not 0.262 (this is fixed for the
   reading side in the previous patch).
 - For freq > 1 the if condition is always true so the sinc4 filter is
   hardly ever chosen.
 - In the nearly always taken if branch the filter is set to sinc3, but
   the frequency is set for sinc4. (And vice versa in the else branch.)

This is broken enough to justify the claim that there isn't any serious
user. Also it it counter-intuitive that setting the 3db frequency
modifies the sample frequency and the filter type.

So drop the ability to write that property.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 7d5d84a07cae..662a3eb2f90e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -309,32 +309,6 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 	}
 }
 
-static void ad7124_set_3db_filter_freq(struct ad7124_state *st, unsigned int channel,
-				       unsigned int freq)
-{
-	unsigned int sinc4_3db_odr;
-	unsigned int sinc3_3db_odr;
-	unsigned int new_filter;
-	unsigned int new_odr;
-
-	sinc4_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 230);
-	sinc3_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 262);
-
-	if (sinc4_3db_odr > sinc3_3db_odr) {
-		new_filter = AD7124_SINC3_FILTER;
-		new_odr = sinc4_3db_odr;
-	} else {
-		new_filter = AD7124_SINC4_FILTER;
-		new_odr = sinc3_3db_odr;
-	}
-
-	if (new_odr != st->channels[channel].cfg.odr)
-		st->channels[channel].cfg.live = false;
-
-	st->channels[channel].cfg.filter_type = new_filter;
-	st->channels[channel].cfg.odr = new_odr;
-}
-
 static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_state *st,
 								  struct ad7124_channel_config *cfg)
 {
@@ -739,16 +713,8 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 		st->channels[chan->address].cfg.pga_bits = res;
 		break;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		if (val2 != 0) {
-			ret = -EINVAL;
-			break;
-		}
-
-		ad7124_set_3db_filter_freq(st, chan->address, val);
-		break;
 	default:
-		ret =  -EINVAL;
+		ret = -EINVAL;
 	}
 
 	mutex_unlock(&st->cfgs_lock);
-- 
2.47.1


