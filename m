Return-Path: <linux-iio+bounces-18821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191CEAA0781
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DE71896D3F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D3729DB79;
	Tue, 29 Apr 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="SP+bttNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E942949F7
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919596; cv=none; b=gyST1UMVPWeDUBS25zpLVxu2OBJ79ghW57S+NH2npl3LqLePurw0Pv8NW2lbdRmdxdQQ4uyNAiRBWNES/1JykfhId8rcg9KRoov69LtE6bN/dcAFlXBn7JMfQ0fUliUfdqskIWwPGwijF6dKWopBOtxOjLhXmlIYto1MUvsEWxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919596; c=relaxed/simple;
	bh=jBYslqysXsVefh/hV56h1nmtfpo2OkxjK7E2KAUrHQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PJUdwWTBwlr2FQ1apXatRoO3+jTLry8zxqVuiRNaiNg0LsqKkBTjz3m/SoaqGEzr0g9L78ApstBNMsgt1owPNf0IfJA7LDkU38vZ7gfMVusGIxA3ZR8io1QZMuzUMHkz4dVl/+cs+YtNF8HcNREUSqwH8dQQntgIvLTLgqePL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=SP+bttNR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73b71a9a991so829095b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1745919592; x=1746524392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2QIxx6gSmtslAsAgje9b2zdVWhv0bIANxz1tCqWbr3U=;
        b=SP+bttNR4X02XicP72+32/cpj1YZV/gCLy+ukHe7apsCNSdF00g9u+IGWaKBqhrYrm
         G2K5TWZG9yXDhp36YXUr86SlxSxePQa6QBxS4e64kQOXB9LXYzBRKOsMoEIDnDZ1cZsJ
         X04ZTKZwg62jXISsZWStTQk2dTrtrb/+42fgbvCuqJd9ZQIriumenIzyiRVa/keUGzSP
         2foY+0MzKVVUnOHYZCHox+eIMNan4FCNS6v7cXh35MQ+I2ItBmKyqZU5Z7aHK7LKleG6
         H4sfJf2H2jHz4a/1wJBqFzxlHTzIaOQppJ6XWpXv6zDg50yVUOme4G1bN3309RlQYeSA
         x0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745919592; x=1746524392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2QIxx6gSmtslAsAgje9b2zdVWhv0bIANxz1tCqWbr3U=;
        b=R8YOwHI6RC/5O8/SmYY+2stLL7VJ+zFzjuK7fcB1eDVXCnWisll6jtEn3h5uYgwFB7
         7NklgfwpIV2/f67/LjJXpc7D6d7CTTw8H5AyHZHFRuq7SMOvsU1KGC1ma42PSz9po/uQ
         b1I8CfaRVW/SfJyTA2BG+GWmh6c1ynjqcKOKCmNGAK0j2WDD2HFWEArHaD6bPXBxMk5L
         o7YrfIVSDfaljUOPoWrCotkkfovU838GW9gfb+DTw5QscvI8vTwhMz6kVIMShHODDqIq
         DaX+y2LC5Wz9S0RCuSr6Kp7eZKc7lK32GDj3QRzAslP5B74nFWZWeWD5W25bsCykd0af
         6DMA==
X-Forwarded-Encrypted: i=1; AJvYcCWA8fyN49pT0f1HdNM6c/9lyeoqKs8bdxH2dxO3+ruzSuC5jwJ7Kz1dPb/uBKayEoorsqqORX7kE1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHq83akeUcqvl1OXTU4deIwn5GcxnRUz0EeJddqS/lONauCEZU
	yAvE1RUARbCY8MIXQngD27J0wzW6ZoQ1oi6Rtq6xEtI9ILydXc4J1e0y9q7IDDH9V4K9AYo5z8V
	ceXI=
X-Gm-Gg: ASbGncus+8GeDTDOqrz2pCYucnM+mqwe5fugiA2MPCkn8ZLabayiCqRkh618PMhPCPJ
	02D8ciHtMYtWwDVaPFpdypjomFD8tRqKtNECf6fDr+4K0HLkxqY/qFrO44UdTj0FPs2sgg9qNSZ
	kir18W1BRFBLTXmGO8zzi17I0F42H9iBHE7xxcvtdUaRZ1ROz4kFff/Gi8KqMrBlynTv58IKJTu
	OETsd+GJveD7Ap5cl8R355oVEEMJnTtzh8+sU4jEWlzCmSYH7ksZMuUrYxS5RljQHVDlQL9EMft
	4h2zFy98cJwWNo+PwezICBVcUVYDvPTv/gay4eIMDOkq41oXbFJ4jTJFNVq/7CwZAuChM4br
X-Google-Smtp-Source: AGHT+IF58CxvWJqRYrja+ogisaT8YD+M4dyQfoW9hZyFs5u3pj7OUeS9flayd4FATbVklO5w7y1xtw==
X-Received: by 2002:a05:6a00:1da6:b0:740:275:d533 with SMTP id d2e1a72fcca58-74029150fd8mr993078b3a.6.1745919592051;
        Tue, 29 Apr 2025 02:39:52 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a882:a84d:54bb:586e:a977:8db7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a8c2sm9754852b3a.98.2025.04.29.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:39:51 -0700 (PDT)
From: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br>
To: jic23@kernel.org
Cc: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br>,
	Augusto Bernarde <augustomb@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: proximity: sx9500: Deduplicate buffer managing functions
Date: Tue, 29 Apr 2025 06:39:23 -0300
Message-Id: <20250429093923.347370-1-mikhael_abdallah@usp.br>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor to share logic between buffer enable/disable handlers.

Signed-off-by: Mikhael Abdallah de Oliveira Pinto <mikhael_abdallah@usp.br>
Co-developed-by: Augusto Bernarde <augustomb@usp.br>
Signed-off-by: Augusto Bernarde <augustomb@usp.br>
---
 drivers/iio/proximity/sx9500.c | 50 ++++++++++++++++------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index c4e94d0fb163..75459c85116b 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -674,52 +674,48 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
+static int sx9500_buffer_manage_chan_users(struct iio_dev *indio_dev, bool enable_channels)
 {
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int ret = 0, i;
 
 	mutex_lock(&data->mutex);
 
-	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
+	for (i = 0; i < SX9500_NUM_CHANNELS; i++) {
 		if (test_bit(i, indio_dev->active_scan_mask)) {
-			ret = sx9500_inc_chan_users(data, i);
+			if (enable_channels)
+				ret = sx9500_inc_chan_users(data, i);
+			else
+				ret = sx9500_dec_chan_users(data, i);
 			if (ret)
 				break;
 		}
+	}
 
-	if (ret)
-		for (i = i - 1; i >= 0; i--)
-			if (test_bit(i, indio_dev->active_scan_mask))
-				sx9500_dec_chan_users(data, i);
+	if (ret) {
+		for (i = i - 1; i >= 0; i--) {
+			if (test_bit(i, indio_dev->active_scan_mask)) {
+				if (enable_channels)
+					sx9500_dec_chan_users(data, i);
+				else
+					sx9500_inc_chan_users(data, i);
+			}
+		}
+	}
 
 	mutex_unlock(&data->mutex);
 
 	return ret;
 }
 
-static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
+static int sx9500_buffer_postenable(struct iio_dev *indio_dev)
 {
-	struct sx9500_data *data = iio_priv(indio_dev);
-	int ret = 0, i;
-
-	mutex_lock(&data->mutex);
-
-	for (i = 0; i < SX9500_NUM_CHANNELS; i++)
-		if (test_bit(i, indio_dev->active_scan_mask)) {
-			ret = sx9500_dec_chan_users(data, i);
-			if (ret)
-				break;
-		}
-
-	if (ret)
-		for (i = i - 1; i >= 0; i--)
-			if (test_bit(i, indio_dev->active_scan_mask))
-				sx9500_inc_chan_users(data, i);
-
-	mutex_unlock(&data->mutex);
+	return sx9500_buffer_manage_chan_users(indio_dev, true);
+}
 
-	return ret;
+static int sx9500_buffer_predisable(struct iio_dev *indio_dev)
+{
+	return sx9500_buffer_manage_chan_users(indio_dev, false);
 }
 
 static const struct iio_buffer_setup_ops sx9500_buffer_setup_ops = {
-- 
2.25.1


