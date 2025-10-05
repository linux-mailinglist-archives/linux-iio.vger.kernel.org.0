Return-Path: <linux-iio+bounces-24745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5CDBB96B2
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C563B9AEB
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94B289805;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="TNS7YHpS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C128750A;
	Sun,  5 Oct 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669993; cv=none; b=d3+YoBAjjP/jqhpw3wz+/+2NI4kKhMS0ppunvSBnW7XCRDWdN38UghevTZuh4HhTkdLdGSpjTP0VXwwtjO5asBPtGuD74Y4vNfR5kflkDVJXIllzsXp+XWECsZ5sMyABhR/2A+CtQHkgvkcUUrljv1dTd0/EbOaKKkuiTAKmlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669993; c=relaxed/simple;
	bh=cyIwHzJpXiF0lnO56Fe7DP00gI3Dt9lMyBGQjSBtKf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpeEJxrWuOkcvuJ+DoHcyMykCjRFc/8/RWqHKhXgclJ2ygvtE6I2lDGbPqBFrSxuFvWS4AwBaIo7kQtpaXlEPxccF/OFlnFWwrcDBWdyW9OlR/WNYw35POKgar19TjT1vK2Kx2WTXLq84k/0iX+rFgfwLQ1Ok+f1hFt4/fN4ik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=TNS7YHpS; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id DB05F173BF5;
	Sun, 05 Oct 2025 16:13:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ig6cfnWRkgfelBCCLV7Q+x6GfztCv5+stowMKlE0kY=;
	b=TNS7YHpSXvGg6Pp+jgewKDXVYfTAKSJtOKg5ltORKbF74Q8JZaMBT8dnDTDB+JLC5K1P07
	v7NVEkXSumCgw7NyEEHl29hFEWIucw8/CkT2DHGIzj5b2dZI62af7CrY3LdEgoBrI5Nrko
	H1+AMRqM8klssEj/cWpQSONaEKWQ+rdchLTXZxorf2vhj7GPPlVAkcRlMRLxS4nEFCdUYn
	ht6scOBeuT4GNuX6x+1u3HMu0bHysPdmr4SuLUEGq7rDyIJ1EQcu6hOH4JVzVS4gqrbAan
	WrU/GYKQg6QZBnAwWI7ot0Ocb0BhpuA/VJYdZ3WT6UU1OAFqmFCuXSCk8xV27w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:22 +0300
Subject: [PATCH v4 13/19] iio: accel: bma220: use find_match_table fct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-13-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=cyIwHzJpXiF0lnO56Fe7DP00gI3Dt9lMyBGQjSBtKf0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnNxd1J6SldiYWJTNnkzdmkremVwY1VHCnVoRmhNM0VoQXJrY2gvTHUx
 dnB4bzRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN0t
 BQW9KRUhRcko2ZGpPa2xqRkdvUUFKcWNzb2pDTjE0emV3UDRTa084bVNOR0RndFQxdm5XaGdvUg
 pCNWpPUjZIb3FmT2hOM1pVcHJvMFZpS2lnWERmUEhSTnRGajRXMWlhT0hLd0swVUJZVERZNHkxd
 lFzQjdCa3lMCk1HaHl2RnRKVk1wMk5rNkVqRFoyeXJ2VCtkclM3TUlpMkMxMHN0TjdSaUJ1OWtj
 WUUzcllLYm42bTlXWFNYd1YKOXJMdFN5UnZqTTdEYnZBbDNLV2tRQUN4ZjhxWUtxRnBYZXB6dG9
 uekUrckFCNFhLeFhwb2RkajAyZWpyT2JaRgpNcGNzZEhTbDU0dkF2MEpHZWtHbHpPWVJmNk96N2
 hncjRCNWpScHRBTTkwOEcrWTNQR1RlL081Q012ei9kNnJqCmRkbWtoOXBUZUs1M2diYVpMZEpLS
 3FQcGxQYW56bXdabi9xWFB0OWgrNUtTQmtxVTVxRGtxbGtVVXE2ekdYT2IKUWZaS2I5MVo4NVNz
 SVp0N0ZLbWRxdFY1eXc5ZlhSVm54eDFIU1BvZVB2ZjBCZnVMSW5QVDlyaWN3dFd2aGhteQprQTV
 RSEhnRVFqRTZYWjE2TTJDNi9WL2VSOWorb3ZtbSt4MXVOSnhBMTJlWHh6R0ZLR3Jsd2RzL2tqND
 UwNUQwCklaTmNNRnhxS1ZtOFlvYUU3TnByUE5wZnVKRFdVYUl0ZlQrckdRWmovdjRza0pKNVBsa
 GpMNjU3ckkzSk9IcUMKYStqTmowMG5KdDY5ZjZsQTJqUjBnODdNUCtrMUtLVWx0R09kemd3ZUta
 bUFjY1VjNlBPY096NWVrWEJwZGkyZQpGRm1VM3BlQ3NVSVgxWDFuTXp4Y2gwcmRrazI3eXhwWFd
 5V1VDZGlLUUdheTVOOTh5SWdzbmZoSEhUWVRRaXNnCnMyYnRTSVVJMFpNcEJRPT0KPXp6TysKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Clean up the code a bit by using a find_match_table function.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2->v3 split out from bigger patch (Jonathan)
v4 no change
---
 drivers/iio/accel/bma220_core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index ec7409db83f81882043653cd70e3205500348994..42d5acce0a8387734d932c77fec9777a7a01f774 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -221,11 +221,23 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int bma220_find_match_2dt(const int (*tbl)[2], const int n,
+				 const int val, const int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (tbl[i][0] == val && tbl[i][1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int bma220_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
-	int i;
 	int ret;
 	int index = -1;
 	struct bma220_data *data = iio_priv(indio_dev);
@@ -234,12 +246,9 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
-			if (val == bma220_scale_table[i][0] &&
-			    val2 == bma220_scale_table[i][1]) {
-				index = i;
-				break;
-			}
+		index = bma220_find_match_2dt(bma220_scale_table,
+					      ARRAY_SIZE(bma220_scale_table),
+					      val, val2);
 		if (index < 0)
 			return -EINVAL;
 

-- 
2.49.1


