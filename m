Return-Path: <linux-iio+bounces-4634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC98B59C1
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 15:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F05281788
	for <lists+linux-iio@lfdr.de>; Mon, 29 Apr 2024 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49C56B69;
	Mon, 29 Apr 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Dph9vtg4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406F548F3
	for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396972; cv=none; b=Jv5GT64/GjhgaTEWGSQ6DxNby13NmT1lfm40HG6KQEmpmZ3/sNHnKUQlfyErXeKTDoDhFAspgxw9pCNAK7ZFUu5YQauL82yh9lrfpjdgv9cUgKt3XgSA+NYf1uxHYGrcYhZEkjSRJcAPWPdVmra9UJtCWiZCenfX6k4naX5dZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396972; c=relaxed/simple;
	bh=E+j90xkVJM65F/ObgohHWw7CB5zsqsm4d5EuRjZMpbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IXLz5NNjLJfU/cGpa/N4pdQXA9a2h/uEIkevoks2QezRyDMG9xF37bPSvchr+zW11K6kLniCRY7Gqt+kydor3L/8Oh4cOLrASUH+GxtY7btNz1WJS5YifNodWpxtSePEULGL4ZAuj7uBHBcJi7eXToSeR96f3AUTGt3gLIZWuXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Dph9vtg4; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-60275a82611so3261698a12.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2024 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1714396969; x=1715001769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3TqO4JEj1rpOS70kekDOvbDasGN17a2yADNxZIQVi8g=;
        b=Dph9vtg4jihBNj5FupzKr7mMWT6OZBnjOxOBwPYX9/tb/0X/4u6aiWAu7rYYQ/4mBy
         rQd1R0BY6qvlPc/nEM6C5sSyL9qYG2T4IXDZMH9fw1Z8vnFPonH5yt4CGf9EsgKN+TNv
         68Ja7tctFlR9JH6084bbMhnsE+tlNO6hGhX34wbaSwg8Qq7rJLX+bHoYErjmSpNLgKjy
         oxgoNZgzb1MqtKMySJ1PZzVqL+iuePXitgIctCz/ueZqKYjRVoWrgH7bsrc//RvPbOKk
         JmKLIsOXGjYo8rGRV12PAWjv0aRE/Pv/lSowmBu1Ihc76h0ibcdNLpeL0kItHErB4kuF
         8P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714396969; x=1715001769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TqO4JEj1rpOS70kekDOvbDasGN17a2yADNxZIQVi8g=;
        b=K41sUMzY0Y0q4DKgLAqQ3tjjCOTm//0vk9n26uiKRAfMk3FWVLk77B599ALq+WRsfk
         HoWdW2jpn+gxrBMF9Q53U8Vh7VxSFHcWFRvPe3wbC1IymcKE5Sy6OBg6ydg3cRivZr86
         obhLLQKWnJ1HLPo3qKOWRXsrR0eM/tNwK8tfm5ECjsREO77WZoDER5dMy8LqiqSo9eOH
         Vb32sxnmZM0F8btkMbJEk1YNdj9vISbI3QXiXYsBt0Ghfs8luSeXcyjCZ+uxwTTa2UEW
         FxyTzPmPu/ueBjLfe3koqdfE0oIhClnkqstLzI8cPfFTxuSm+SVZIMbzTmRdwCUMb8fG
         3gdA==
X-Forwarded-Encrypted: i=1; AJvYcCWR+/x3uQcZ41UllPS0O8HZPkOhWvZIgv3BDWQGmMRLyd+PUeNMX3fav9lqxG7PHv8cQNLAOdZhRHWDrObsMISLBM5jDZqZfOQn
X-Gm-Message-State: AOJu0Yw7krS+QpZkmkJEtc3h5waRVjZl6JypFDdCyb4kFl8kSOneIfit
	0e4+pMkdh/r08YtCvdCyUoShnOFFQkIJcz2NjN3aeIQjWXB7UwVVfw9QV0BwoJc=
X-Google-Smtp-Source: AGHT+IHD7mGu2ZBgkq4j6Z7/Kfcc9ies+vJ7uw94QeIllwhorh/JTBGp3mN3G1lkYD5vTfmIOTxXPA==
X-Received: by 2002:a17:90b:2303:b0:2ac:8366:8ab4 with SMTP id mt3-20020a17090b230300b002ac83668ab4mr9694801pjb.38.1714396968992;
        Mon, 29 Apr 2024 06:22:48 -0700 (PDT)
Received: from lincolnyuji-vaio.. ([201.83.91.252])
        by smtp.gmail.com with ESMTPSA id r92-20020a17090a43e500b002aa783c7749sm20852664pjg.41.2024.04.29.06.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:22:48 -0700 (PDT)
From: Lincoln Yuji <lincolnyuji@usp.br>
To: jic23@kernel.org
Cc: Lincoln Yuji <lincolnyuji@usp.br>,
	Luiza Soezima <lbrsoezima@usp.br>,
	Sabrina Araujo <sabrinaaraujo@usp.br>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: adc: ti-ads1015: use device_for_each_child_node_scoped()
Date: Mon, 29 Apr 2024 10:22:33 -0300
Message-Id: <20240429132233.6266-1-lincolnyuji@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This loop definition removes the need for manual releasing of the
fwnode_handle in early exit paths (here an error path) allow
simplification of the code and reducing the chance of future
modifications not releasing fwnode_handle correctly.

Co-developed-by: Luiza Soezima <lbrsoezima@usp.br>
Signed-off-by: Luiza Soezima <lbrsoezima@usp.br>
Co-developed-by: Sabrina Araujo <sabrinaaraujo@usp.br>
Signed-off-by: Sabrina Araujo <sabrinaaraujo@usp.br>
Signed-off-by: Lincoln Yuji <lincolnyuji@usp.br>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6ae967e4d..d3363d02f 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
-	struct fwnode_handle *node;
 	int i = -1;
 
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		u32 pval;
 		unsigned int channel;
 		unsigned int pga = ADS1015_DEFAULT_PGA;
@@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			pga = pval;
 			if (pga > 5) {
 				dev_err(dev, "invalid gain on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
@@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			data_rate = pval;
 			if (data_rate > 7) {
 				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
-- 
2.34.1


