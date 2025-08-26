Return-Path: <linux-iio+bounces-23274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF0B34FF9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786B95E2FF3
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD919FA8D;
	Tue, 26 Aug 2025 00:10:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57E14883F
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167016; cv=none; b=RehgD+MKomTgzsL3sm4Aeyp77lQs8XYV9JBapfscyYw5/wkH8Vs2n5hJV4tARue9zEKE9+mAAw3xoRLY5bhUOFfdlK0xDjHfYAdPsmkOCTiYSN9M/V4cFHq1jRYMbKNU1vzyzQepseuwOErSBiwIf1rQzc0KYFTJua66cJUbpAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167016; c=relaxed/simple;
	bh=RBP2bAVNx5seH1yUO0VlfPQUrADaOVCOGVTtcjc/7aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhZ3S7ENJA5XBfb0Bgff2hW/pRTReq2Jxx+XAbTX3R6fytRsbBfWd5igUcciJ7+YvsnkDp85BjrJbd5w7SjCsOdQaDrbx/IxJtRton21DVZIAWfi26bWSQCAAUouD1mBkC5+CeArZBV7OT1qRH/5D1/lEQrNwB2b7V7sPKoGhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Date: Mon, 25 Aug 2025 20:10:05 -0400
Subject: [PATCH v7 3/5] ABI: sysfs-bus-iio: Document "ema" filter_type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-mcp9600-iir-v7-3-2ba676a52589@kernel.org>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

Exponential Moving Average (EMA) is a first-order IIR filter.

This is a common IIR algorithm used in mcp9600 and others.

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index df42a4040530ee96096b998bebc8a08b4fb2d78f..4e30f1db0a930f021cf07e5553d35a3feffddcc2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2281,6 +2281,8 @@ Description:
 		  when reading sampling and frequency related attributes of
 		  this filter, and return -EINVAL when trying to write these
 		  attributes.
+		* "ema" - Exponential Moving Average (EMA) is a first-order
+		  Infinite Impulse Response (IIR) filter.
 		* "sinc1" - The digital sinc1 filter. Fast 1st
 		  conversion time. Poor noise performance.
 		* "sinc3" - The digital sinc3 filter. Moderate 1st

-- 
2.39.5


