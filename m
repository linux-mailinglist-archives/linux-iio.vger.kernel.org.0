Return-Path: <linux-iio+bounces-13170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73E49E7757
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826442885DA
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E9206F06;
	Fri,  6 Dec 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l1hFeeyw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2552206B0
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506157; cv=none; b=OQrvqXACcAmOVfET+IQ82ifjdgWU8SSkr1z7kRXUUpPNTZ4ULLbDSRtMWxLA8cdvMKfWnBpQIo6MgQSpiPgwByVWJ2Xk5VefIxPGo5aHVgcpVTA5OzKwOdaEvuHvd+/ZnHeYUvuKhw0Q+T0BRvv8Cs0++CkBs/ey4iSHm2g7BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506157; c=relaxed/simple;
	bh=UpCDFbHiLoBrphP0ZQ6Ni+CRtV5VYT4LknAceCYNRfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lra3AklR+uTWqVRdG3OgnjCchOjy7C+QGUBtDEd/YIVwgGkP0Hbc8/XOVExodH5fFgA3yZv+Yq0WO7phoeZKoG19+enKgt3fIkzQ1KaB/1VJnZnx7674Hqt2TB5gg/+djEiWmP9tcE6dhNwnQMPGHnNhmvqUapx+jPUztUJ3bgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l1hFeeyw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so618220f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506154; x=1734110954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RITSuX/h//gaahWszdW0fpwFRnABn01F981JW4yCXNU=;
        b=l1hFeeywNLNPUfWICZ16+Vvnz3jr1QC0bZjwE/eoBUtwlOALa7bcWOCGTJWOAPQk63
         lTABES5zXhQbkvWRfTOexyAEo8k7X6triUDB4si6/A2OZS9dLQwr3JL6Ot9/c+oAB3pZ
         +4u6o8MgqyJ7WtDUAAEf8ax4PcUVX2qQ86Zn51VE0eE0wEfQIDwO9/ikSZ1G+QsJDIkh
         gw/4E3RsECLrRCY3fCEU/miCKK2JAd0871ko94KUglA4W0UseyByl/uaHLuU3099CWsV
         Krd320vQyJG6Vmbhq5y+3o0E6DpAEZ8p5OI7vblqyRft+sQUHR0SJu+NZHzlrT7r9Bat
         ySoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506154; x=1734110954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RITSuX/h//gaahWszdW0fpwFRnABn01F981JW4yCXNU=;
        b=iYeYRa6dvijFrIg8cDBNcm18ZGjZYQwM5siXNFYrDjEyqGWDVHqnuM5d+oGPWhjwGc
         uzfZzMYFsQuX6/TIk5vKU4pmWcuUT/DehGeCu5qjVpIsPGmEB2f+If35apNOe1GLJHeB
         9+BwSIQOIzvrbQe9h3UkGMqgtNmEOMcgyMdUAE2hdvDRwocLm2MR5QVkM8wC6GwtxN96
         dbv/GFp+IoOYVN1KtHoqJZz0mCRoYuuhArc7/31mt7fSrlGMYrx5Xh1DxNntX7o/KQ4Z
         vu3i0hfgi/rfsbFfrTAai7BQ+cqvjX9yoLkrtwr5aW6smAgkV+y9M4R4gbEM4lLhmOn8
         OEag==
X-Forwarded-Encrypted: i=1; AJvYcCXFJUfw4+bj70WoSqBXSZyfAR5YU3wolCQSd7dmGm++aHPm2LpovztdqcyzW39GTnZR/KIg6DsCfLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS/pv7Imls2yrOqsRLRFHHjA0zhfn+LCBHcSruFhEt6W+nOIpP
	RYDL+JY+BOjURIIZRLztSlXDbXcqmyGt0tiQhV6+1gALJbdItd8RI/CdkZMixuU=
X-Gm-Gg: ASbGncss2BC/LQRonr3hTcySe5pPOlC0bn3GjD6Gde1Xo5G3ll7REu1qMJMEXRwr6mA
	oMHuxrdtrxbGFf98AYNRiDnNgR6kf4RV3lyhPiz0xs5hAj43/E7J+Ei9yFi3KnLPznSEfQAKuF9
	/SJ5Kt5GG8gYbnDrZg6Jqo3bFBsK4gR6hTtyhw7893YJPQxN+HnFACoBOkagGMzRMu2w9IFUMx2
	bfJFsEnQ5ACEPv+zbgvACqwB8c/KMg2RxvVl1huAguF0ZMk/uuggf5fUrUeN0obZBBS4Fn3+T9F
	ahm4
X-Google-Smtp-Source: AGHT+IE5DzkcHudQm+cl+IiQWqgFwmJoL60RcAa4mplsaFBiZxmIhJcps/AJJZBgIOBJOCSAxgwugQ==
X-Received: by 2002:a05:6000:1565:b0:385:f280:d55 with SMTP id ffacd0b85a97d-3862b3e5618mr2862859f8f.37.1733506154354;
        Fri, 06 Dec 2024 09:29:14 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4395sm4987182f8f.10.2024.12.06.09.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:13 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 02/10] iio: adc: ad7124: Refuse invalid input specifiers
Date: Fri,  6 Dec 2024 18:28:34 +0100
Message-ID:  <80e3bd629d2b755ab5e061c8731dafa57d08698a.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=UpCDFbHiLoBrphP0ZQ6Ni+CRtV5VYT4LknAceCYNRfw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvRgE3chvaKtqvc/MRqK+S3iTO962BsVE8fzvOvX25f9S tmnxG50MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRviL2/yllDHsTeKOfS6za Up6+e9umxBX5ctmsLnxd80yXM0W0Trsj5bJL/fHS9pSqiEP/zkp3KEl9i+GKyG2InFl3+p8Xg5C Dhmhi8/oDrbUpS5fbBc6YtefDYp2ukL1PkiqOb3zQmMkZkR42U+67XmOT+mrvWxsOaFWlpSh2cM h0XLa1cY9Q4rCQzrf6l8jWInlzcyJn6Z5vJtu5wqRZDl1UCX8h5PjDj3VN1VTmdE2eRe9uS9Xs/ PjldOpcvtIXTvVTMk3VZyUohNS6e8yqiNKv3hv4oi5t5r9N71yjU/4rPLqzJe+P0ISNcvr393+a IOEX+HqXToD2OuVf/FXFBUyuiy8m3ypWsnfSbNR61AwA
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The ad7124-4 has 8 analog inputs; the input select values 8 to 15 are
reserved and not to be used. These are fine for ad7124-8. For both
ad7124-4 and ad7124-8 values bigger than 15 are internal channels that
might appear as inputs in the channels specified in the device
description according to the description of commit f1794fd7bdf7 ("iio:
adc: ad7124: Remove input number limitation"), values bigger than 31
don't fit into the respective register bit field and the driver masked
them to smaller values.

Check for these invalid input specifiers and fail to probe if one is
found.

Fixes: f1794fd7bdf7 ("iio: adc: ad7124: Remove input number limitation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 5352b26bb391..1f3342373f1c 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -807,6 +807,19 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+/*
+ * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
+ * while they are fine for ad7124-8. Values above 31 don't fit
+ * into the register field and so are invalid for sure.
+ */
+static bool ad7124_valid_input_select(unsigned int ain, const struct ad7124_chip_info *info)
+{
+	if (ain >= info->num_inputs && ain < 16)
+		return false;
+
+	return ain <= FIELD_MAX(AD7124_CHANNEL_AINM_MSK);
+}
+
 static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 				       struct device *dev)
 {
@@ -859,6 +872,11 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
+		if (!ad7124_valid_input_select(ain[0], st->chip_info) ||
+		    !ad7124_valid_input_select(ain[1], st->chip_info))
+			return dev_err_probe(dev, -EINVAL,
+					     "diff-channels property of %pfwP contains invalid data\n", child);
+
 		st->channels[channel].nr = channel;
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
-- 
2.45.2


