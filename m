Return-Path: <linux-iio+bounces-8640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A41958E6A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 21:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE817283CAF
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053DC15A865;
	Tue, 20 Aug 2024 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRwNOtg0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BACB14F9E2;
	Tue, 20 Aug 2024 19:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724180557; cv=none; b=ZacPU41VKNkoGgBhVAo7q4senm6EHKfDrPFrN0cPxFn2p2jPNsvgmHq3JKttlHCv9tY7cXWtviOe0oaJefil+lBswzYQYJWfd8Qp+KZswNhFV8PLQgmEwDq+PCnx2OSRt7d+r5R3cSlBrkPlIpQy9G7e3sk4k7epXUZGPc8ryQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724180557; c=relaxed/simple;
	bh=cl0OgwWFGj09y5TwwEPvN3u/Sy1PyJsfo8HSpKT7rW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jH3SPrMlYxZ/DRu2nxY0X7TtEQyL5dk/+tMqbYKjnbWs3m36wEsaczgSVtUaCNrvbaKSD95rnDBPSo811OPIMPjJoza+Uju35J8BQoG4Aft6s+r21WannehzOxl2PwYctQKwYRN7I1D54G/fOb7F27+oDjgTLrZMYxXYMW8tuaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRwNOtg0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280bca3960so51477225e9.3;
        Tue, 20 Aug 2024 12:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724180554; x=1724785354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlwKey+PJeZN0A9rh/S0vL1F8rX1MwKvwXZ2q25uwGA=;
        b=TRwNOtg0Z4MaXNyAUWa1+XwQm9K+mrS9pw7UOLRpSpokV70E5Mg1ODMEHSTZEqN2uJ
         z3y0fZD5kO1NJmmCNqIPcRGQYkXyi6dgSdTTMjS9l1hQo5/5m4KcGL4RYPIwIGsYCEi5
         rEabdRsodLO6M3cMQ19jzJTe0fNWV3PHyLu+44XLdF0qFkNsh/3crjabfwC9mfXu8I2M
         mjlJXG2v6SWA9aUgACtc7yavg7YSXEsCHXoyw/+lacxtiZHy4R5UNIq377mAfIlycSwU
         UObPavOuPVl+dGnmx9VgJv7gBqt7fHU1iwdGOZ5jhsbvQfkJd5WFDbG/CQmDhmtvCicm
         oUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724180554; x=1724785354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlwKey+PJeZN0A9rh/S0vL1F8rX1MwKvwXZ2q25uwGA=;
        b=PdNP0R6XDnNe1CbfeXONLUkaPlDSCjKOXeMMmUe/w8uRiEgiWiPWrf9pGi3M1zf+lo
         +xuIBk4DLCx19/iVOueGwB13fySo0IJTRcjrATf4Yalq+7INSNdMu7yfxur06/RSQ46b
         he/6kad2nFSMtP35MZHSM5y9NlS/tcM2Mad8hw3kT1LA6uIDBk5wkgwTK5T3qQGDy0Y+
         A8bpgv++/bELXs7yXcRC7qyB8++lU42IhUCWYauuQjJSOZaZ0hOZfaBG7UbNhLSCkIYY
         qixVv/FFMglnJhknkqLLwNFw4w6o5gpM5NRa1oV4eiADPrN6zlCMReB3y2bZBoPrE5gS
         F62Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXSYy6XKDDjXRTdArwyDSkgcmuCbIvJoVGKrsGeU+mdNZkajYrKXRFpfOzyhkJxmKHyBXznLVbZx6qBZiD@vger.kernel.org, AJvYcCVzzNEJJuX/e+ptSKrMijKNlGhvgnHHH4TK/X4xasfBgGwgOrCGML/zLul3x795141r6gALcWLwe/M=@vger.kernel.org, AJvYcCW7zJ4uDj/kWLfHqocdFMcq0FkdD+8F4YcsPGenjw1X6+jC9pqtKeUH5Z449oe3spzHo1a+LBWs+TCZHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ms01mn+rwXmx+kNqAnPoZvDdqFPMYLGzUXbF03vLgAps9ahK
	7T8QL77OLySb5/HwEx/H1YOGzEZAacxgTn+7dQZiZdS42b42eDRR
X-Google-Smtp-Source: AGHT+IFd/9eXjIimfq6IVjdiKHAYzFfXr+fnsj7PnsuNsfpHif9KAV2JjMtdFT05yi0N5r7XiYy0fQ==
X-Received: by 2002:adf:ec4b:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-371946a48camr9184041f8f.46.1724180554278;
        Tue, 20 Aug 2024 12:02:34 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898497ffsm13685375f8f.27.2024.08.20.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:02:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 20 Aug 2024 21:02:26 +0200
Subject: [PATCH v3 1/2] iio: adc: xilinx-ams: use device_* to iterate over
 device child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-device_child_node_access-v3-1-1ee09bdedb9e@gmail.com>
References: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
In-Reply-To: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724180551; l=1584;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=cl0OgwWFGj09y5TwwEPvN3u/Sy1PyJsfo8HSpKT7rW0=;
 b=PMTWQVUhRErOEF/Tm2rq2wYK9XrGuYNQoynvd7qUkDe28eBhRUo+E8ZtAitFprlj5LYADlvj5
 ZbAAIdu/x2vBs3otupjyQRtgQQM9fPgFm18yXZ3cS/DLvYau8sueJLS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
to explicitly state device child node access, and simplify the child
node handling as it is not required outside the loop.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f051358d6b50..ebc583b07e0c 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1275,7 +1275,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	struct ams *ams = iio_priv(indio_dev);
 	struct iio_chan_spec *ams_channels, *dev_channels;
 	struct device *dev = indio_dev->dev.parent;
-	struct fwnode_handle *child = NULL;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	size_t ams_size;
 	int ret, ch_cnt = 0, i, rising_off, falling_off;
@@ -1297,16 +1296,12 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		num_channels += ret;
 	}
 
-	fwnode_for_each_child_node(fwnode, child) {
-		if (fwnode_device_is_available(child)) {
-			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
-			if (ret < 0) {
-				fwnode_handle_put(child);
-				return ret;
-			}
+	device_for_each_child_node_scoped(dev, child) {
+		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		if (ret < 0)
+			return ret;
 
-			num_channels += ret;
-		}
+		num_channels += ret;
 	}
 
 	for (i = 0; i < num_channels; i++) {

-- 
2.43.0


