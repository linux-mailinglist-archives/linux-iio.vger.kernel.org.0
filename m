Return-Path: <linux-iio+bounces-27162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C1CCB89E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A74C3005B8E
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63E315783;
	Thu, 18 Dec 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="IMVM/qJU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF022311C24;
	Thu, 18 Dec 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055988; cv=none; b=HpPCtmeDy2witSdUw+WTsqDh23Dt8grJa1okMLo4T4Atug9u3WHfr7Fy5CEpKAS9jXX+EkAQ4G8TmH1mYL1rs3BIVpzr6O7Rpz/iA4CtUsjYeW+goqzPc7teyklD6Y0u3g/M0+iCQFoaP4ePrd9n75W/dp8w8E/pvNbhoG7Y39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055988; c=relaxed/simple;
	bh=EIPabEjnnEvLCl+rNYWJZdEuQTNo2AMQVhL4dwETO4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNVo5langKBL41Kb2fuZSSWpRUGnWhb172Sm5WQhwez2J9H45LW9Um0URZf8MaxALGMrPCHUluvy3URCXyJFrpchzv0BjHTR+udH70zHnyBaAMqsowVicK2jrDSAATyVtfc2/m29LNXJKgTL0zjcWGAdV1Gg4u4je8ea4w6KE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=IMVM/qJU; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id A251E160214;
	Thu, 18 Dec 2025 13:06:20 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766055980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNemMTIWx9oMXHKIFOpbiRFXirUXP3o6jLiPZq6x8vo=;
	b=IMVM/qJU3pltZauMJ7kA1SUhZyNHY6S0pRUcwVIHXOGi/2Y1yugLOmkbAxiTvMZ5jUjZ0k
	fsfOUfJFndB+LCdbKezaibcm3KnwVV1mtPfoESoj5k9SeiOPesyxMko+Zac2Pd0nz8KhXj
	ZBLDDqoz1q+B8fWieoWQWj3OeTTAzod10B+nBFPYFypNOiTRws/2ys49YKhTiCvgHZK87s
	/k2FVr6wa7AmrwU+GOTvjQ+5Vk/xGftwRu4OTA0l8cOYJR90GkufRitMQ3KLPEwt6QyALO
	W+4teJw7w5za/4yPYNPo+l5wo7r8wNvj9pCQE2tfXEvxl0rZnh2oSDKjn8dZSw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Thu, 18 Dec 2025 13:05:53 +0200
Subject: [PATCH 11/14] iio: pressure: mprls0025pa: fix scan_type struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-mprls_cleanup-v1-11-b36a170f1a5c@subdimension.ro>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
In-Reply-To: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=EIPabEjnnEvLCl+rNYWJZdEuQTNo2AMQVhL4dwETO4A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xENEIzWVFqME41Z0xyVkJVRjc3R1ZqV3hQCk9yWXFUckpsWXo5YWlzOE1v
 d0lKRklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFErQWR
 BQW9KRUhRcko2ZGpPa2xqUFhRUC9pQ1JGY29jaVVMYnpqa3ZmV1F2VTFIZVFubFVQV2RLTytuWQ
 pNa1FBSy9ETi9hUkJrRExSS2JueDRZREp5dkVoK0x6c2ZiRGNnbXROQ1dIQkFDYzY3cnlaVTMxc
 i9FejVUaW00CjBFSkJjSDZjUUZwdXVERyt6eTFDRXJKN2ZWUkp3bTcwbVZPdndzL3VkMFNSMFEv
 SFFtZXBrQ1NyS3MxTDVoc0oKeW5aMHNhM2ZRVnZqTGwrOVdPVGg2b0NtZDRyak5DUnRDWGlOM2R
 wTEhFakhmVjF2Z3hGSHpWOUo2MFdNZVUybgpTTkRYNHlWZFRUT2VkU3g0SVZTVmFKd1B0cWltdU
 l5djREZ3ZTKzRNTE9yN0RacWVKdDVZZUUvcnI0OEtlWVhwCjg2ZDVXZlp2Y2svUWtLRHpvY1lld
 y9kSmoyV1duSGRnWW80ZThIU1VKbG9obmNNdzB2U2RKTngwTHhYVWFrVmUKVU16K2gvang5dE1S
 Z3Y2eVAwcWxRSVJjLzNIWEtFL3lwcS9EQ0JYVkgzTGZkRWI3OGRrT3l1bmFzMVNlTWsvcgo0Y3B
 EYzl1NXdTUTdZdUc5WWtxdzF6VllTUGhIenh0enppS256TzIzSFJBOFpNbkc2cWNZNVQyanEwYy
 9iOEwyCnRWZ2FZRHI1WSs5dXlkSTJYNzZSZGRSMzBPVHgrK3F5MEVKSlRtV0kraCswWHVQajVwT
 TJRQ2pjSit5MDBoUXoKaXZSWEh0d0toUFl1aVQ4ekk5aTFXOXFLeXM3NURxb092Skc5OUd1T2hr
 c2E1cEN0VXFMWENlR1UwNkJFQXVZNwp1d2VtbVFaOXUrMllPbVZpbTVTWWxoeENLSVJDWjE2M3Z
 pMSttK3g1eXk0MS95aGNSMkdYaGhKQUY0L2ZiRG5pCnlzdHpaczhPMW1vcjRRPT0KPUR5eW8KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Fix the scan_type sign and realbits assignment.

The pressure is a 24bit unsigned int between output_min and output_max.

 transfer function A: 10%   to 90%   of 2^24
 transfer function B:  2.5% to 22.5% of 2^24
 transfer function C: 20%   to 80%   of 2^24
[MPR_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 }
[MPR_FUNCTION_B] = { .output_min =  419430, .output_max =  3774874 }
[MPR_FUNCTION_C] = { .output_min = 3355443, .output_max = 13421773 }

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/pressure/mprls0025pa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 9b18d5fb7e42..243a5717b88f 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -165,8 +165,8 @@ static const struct iio_chan_spec mpr_channels[] = {
 					BIT(IIO_CHAN_INFO_OFFSET),
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 's',
-			.realbits = 32,
+			.sign = 'u',
+			.realbits = 24,
 			.storagebits = 32,
 			.endianness = IIO_CPU,
 		},

-- 
2.51.2


