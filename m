Return-Path: <linux-iio+bounces-27804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B6FD2065D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16CCC30D0948
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 16:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA573A7F45;
	Wed, 14 Jan 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="mVZPzkEh"
X-Original-To: linux-iio@vger.kernel.org
Received: from nalicastle.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150633A641E;
	Wed, 14 Jan 2026 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409799; cv=none; b=JRYx9thIHsJDkdxNPyv8GCJNDfp0nva0/9L3vdkfWhBM7xRQNBhSxIZAiVTO8Ut1utCT9YoqVK67s5ro6J5NsjkbGT1O5l+j8BROzcfT4FpRE7Phk+1Gb2RiLM/8itPN20B23FVPLlMp33ZiZhPiXeDZX+PCglF1yCtp2SieArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409799; c=relaxed/simple;
	bh=On3JiUHij+YhRv2q6h8b/NkvqmRAWL+spvnwxXJV+44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+l+oHKooHsLwlqO+H++TtWtUUzv1E1ocQwgKwCs4kJofms6GwW76TPclNKbCJGBpnTcBKDU+sOIr+hLLd6RwQQACnKSOPQry2MJQdPVldRmdkVdygPuzGjM3QnDbutRbJq1hSMy/hce1792VspMQ8ogmpQJK2ycTPpEbyOdmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=mVZPzkEh; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:300:8a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by nalicastle.subdimension.ro (Postfix) with ESMTPSA id E3BFA160216;
	Wed, 14 Jan 2026 18:56:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1768409788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhCc1+YnbiBEle+Ig+zRCnFYNFplIrz8oqBljQnWQ0U=;
	b=mVZPzkEhpPq+iP6NjOMJk9uIQrcKzBQyOnKnMzMhCxNJyDr369QvvOwDXtEZ8iOR70ov8s
	GmPHAA+OUCLPBi+965+KTudlQcbWLRqIpvvxKnbqhd1bjjQURz5Hbw6iZardNAlcPln68z
	jb4KL/bj3/ZDTCZrkDY1Qb24EmKGP1JzZM+vZ1BH3frby/lbEuAx0xWxKhDDMe3ZFSzEbB
	BC8/vjKxk+liqg/e1GQJ2Ko/wOUyZFyqvpewAJD3SJchLrUeb/o1OWETtX8wNhu0WEHdkG
	u73kriqyhroqdnDWl0Aiwrlz+vaNQAEd+BROzHAAfJZuFbi+rUAEpDchwVrlBg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 14 Jan 2026 18:55:41 +0200
Subject: [PATCH v3 12/13] iio: pressure: mprls0025pa: change measurement
 sequence
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mprls_cleanup-v3-12-bc7f1c2957c2@subdimension.ro>
References: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
In-Reply-To: <20260114-mprls_cleanup-v3-0-bc7f1c2957c2@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3312;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=On3JiUHij+YhRv2q6h8b/NkvqmRAWL+spvnwxXJV+44=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFHSkFuYjlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xueXJCdkNsTEZXaG4yclpoUFhkd2Z0ZUwxCi9NckRmd0N2NlBRWUsvK0tv
 aEhoU0lrQ1R3UUFBUW9BT1JZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFo4cXd
 HeFNBQUFBQUFBUUFEbTFoYm5VeUxESXVOU3N4TGpFeExESXNNZ0FLQ1JCMEt5ZW5ZenBKWTVMWg
 pELzkwME1rbWdXY01HY2Z2TVBJSksvbVk5U28rV2FkaE1zNkNERnMvOTVjZFdjU1A3Ukp0Y2lEQ
 i8rYVhNTXlnCjJzaEJzSnQ0ZWtLY1dqVGZ2aHBuTDFVVTVoWU03eENiaHZYeHIrcTdYbWE1VVJl
 TGJIcjAxTEhwcjJGOHdJZkUKMDZPOXVzeVlvdWJNbytlZktBQktobXY4UFU5UWc2MmU4aS9QU0N
 ycVVsUHR2N24vNnNjZTVIN0JtbGxQRGp3Lwp0VjRPMWtwTmU4RjlyQ0wxQWFUNFI1cythTllLSk
 sxTGtGbnN0RFZiRFpLUFNjSGpuSit1UEJtc3F6RXlvY251CjEzMTMybEg4bVluVUVobzFJWEYxO
 ExKa0REMzhCZDh1ZmwyNFNJd0RVbTJJZ1JvNXhBQXlOM3hQeVI0REdTd2sKM2lqNWladDA3OGNs
 aUxpK01ETnVqSzlKSy91RmdDemo1Z01qeFkrOTI0NUUza3E2OWFvT29UMGVod1VHVFJETgord0g
 4ZzRjQWk1TnJRRzZNd1A0WkNjcDkyVm05YnBrR0I4ZXA2bDI3SzR3eVJpMkR1ZXJ6ZEVsY2p5VD
 AvU2VvCmxpcGVhMnVCVGRHMHBzRnVyNTZQdTZEOVZKRjBGR0ZhVGVNSDVpeWdZMk01QTdJazRqQ
 XdPcVBzZVdTSFgzaGYKWnluOGlvSFUxK0huaEVSalFwVmFWc0JIellxUXBvRThmckozM0U3QlYv
 M3dxVW9mOE5JMEl3R0svK21nTVovVApXaTQrUWVYR01ISW4xd3JwSWlWbjl6YlpXcnhnT3U2c0s
 rQm9oTS81bWp0S0g2TktaeHR0WnV0SUtTZ2lpU1F5CkJDWmVSVlQ4YVNaUWdmYjdLaDgrR1JSaV
 dWdEhxOVBHK0dvNEF3dUJMTnZuYTkwSUtpaz0KPThjdEEKLS0tLS1FTkQgUEdQIE1FU1NBR0UtL
 S0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Implement a measurement sequence that does not involve a one byte read of
the status byte before reading the conversion.

The sensor's conversions should be read either once the EoC interrupt
has triggered or 5ms after the 0xaa command. See Options 1 and 2
respectively in Tables 16 (page 15) and 18 (page 18) of the datasheet.
Note that Honeywell's example code also covered in the datasheet follows
Option 2 for both i2c and SPI.

The datasheet does not specify any of the retry parameters that are
currently implemented in the driver. A simple 5+ms sleep as specified in
Option 2 is enough for a valid measurement sequence.

The change also gets rid of the code duplication tied to the verification
of the status byte.

This change only affects users that do not define the EoC interrupt in
the device tree.

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2 rewrote commit message
v2 -> v3 rewrote commit message
---
 drivers/iio/pressure/mprls0025pa.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 31ec2bae84b1..b1122ace6bac 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/string.h>
+#include <linux/time.h>
 #include <linux/units.h>
 
 #include <linux/gpio/consumer.h>
@@ -41,10 +42,6 @@
 /* bits in status byte */
 #define MPR_ST_POWER  BIT(6) /* device is powered */
 #define MPR_ST_BUSY   BIT(5) /* device is busy */
-#define MPR_ST_MEMORY BIT(2) /* integrity test passed */
-#define MPR_ST_MATH   BIT(0) /* internal math saturation */
-
-#define MPR_ST_ERR_FLAG  (MPR_ST_BUSY | MPR_ST_MEMORY | MPR_ST_MATH)
 
 /*
  * support _RAW sysfs interface:
@@ -206,8 +203,7 @@ static void mpr_reset(struct mpr_data *data)
 static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 {
 	struct device *dev = data->dev;
-	int ret, i;
-	int nloops = 10;
+	int ret;
 
 	reinit_completion(&data->completion);
 
@@ -224,29 +220,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
 			return -ETIMEDOUT;
 		}
 	} else {
-		/* wait until status indicates data is ready */
-		for (i = 0; i < nloops; i++) {
-			/*
-			 * datasheet only says to wait at least 5 ms for the
-			 * data but leave the maximum response time open
-			 * --> let's try it nloops (10) times which seems to be
-			 *     quite long
-			 */
-			usleep_range(5000, 10000);
-			ret = data->ops->read(data, MPR_CMD_NOP, 1);
-			if (ret < 0) {
-				dev_err(dev,
-					"error while reading, status: %d\n",
-					ret);
-				return ret;
-			}
-			if (!(data->rx_buf[0] & MPR_ST_ERR_FLAG))
-				break;
-		}
-		if (i == nloops) {
-			dev_err(dev, "timeout while reading\n");
-			return -ETIMEDOUT;
-		}
+		fsleep(5 * USEC_PER_MSEC);
 	}
 
 	memset(data->rx_buf, 0, sizeof(data->rx_buf));

-- 
2.52.0


