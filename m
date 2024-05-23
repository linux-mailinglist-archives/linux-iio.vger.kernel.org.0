Return-Path: <linux-iio+bounces-5226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6FE8CD85B
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EEC281792
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093D117BA6;
	Thu, 23 May 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ANBctlwB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74441D304
	for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481498; cv=none; b=rAfez8u5v3FRR7Ck8Ry/ijE+I8aL3/EgxQT/Y5Og/u4ao6HIQU9YnmAKZLAJ5WYrVXKl03gtMYG7bu30hY29BRa6yDySwA63PS9Id1uCcu12iyJtxxUPrpu2fktw2dBpPoa5+hHIWU0tuA4sD83qGyPC/XdckMFEmEdAh0gMArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481498; c=relaxed/simple;
	bh=pXbJRTfQ1CzIKPsL7RUD4jB0yNxcSbmOt1M/Bvwnk5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKhHKt99FIvRXELDlYAtPdYArkUaYh6wFSnZJMAU03EhB1aMfK/REYS3FdWxcAU5BNnr4W/CkTSlwR9zSi8MFIJzc+I3/p2e1CmRiZ2jSftKFrhfQ4WluwsAwXVh+TMyiwQeIke9exb63Zb0/aj0EpGDnt71FPHWnB0lGdjEc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ANBctlwB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ed96772f92so22759105ad.0
        for <linux-iio@vger.kernel.org>; Thu, 23 May 2024 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1716481496; x=1717086296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCBvRx3fnLn1ZrsRPe6m4JFWe8xstyH3nTGxy6I9Sq8=;
        b=ANBctlwBV4lMljlzyvFVGzhK6jNsGp6fiam1U8LcnbUf9IESqSmBy3KMNgR151qEmj
         3DXafXMETLo/t/gDrx/YzD+m0UU7ey26rCUzqQapBYmi7iPoeUWt+kD0y8bMP6wzdWRF
         Z+s0ApQ9fQo74BLYkzx9ongTAFsqka67F2RcpLTy1q0PQ6CJoT7o0pt7ImYueFXdOxXZ
         F3WiQmsL06iv9etItcAs9D2epRFjYTiEhHNhTsVQCbd51Zd6nnsi67LcZfU+/DcW2FtN
         dOuGtNvZkdnxyPKGuoiXD/1ZIJTNzoXXX303fFhTLriY0DBw5mUJTEBSRILmpSYTAS62
         T68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481496; x=1717086296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCBvRx3fnLn1ZrsRPe6m4JFWe8xstyH3nTGxy6I9Sq8=;
        b=oiP4ahhcMTZMHt7CEHykiOiJj0L9vJpxNdFegOxDhrMKDu4C0/LMHDon+8azzED3be
         P3FsuaHtcf+IwkEmGs0Pj95DPof/7LOUDMw67DjuGGDjEs6cE8tnFqlSdyYB0xv7IYtW
         7mBH04K/dGS/Lj4dkd8MAVCuF35D5zUTgFPGRgAHQOTeR/KfOzykq4WpTjVsq/bcnZL+
         /HGAiYwzoFnN1Jl+lcnEAqKaZRzvNw0otfr7R7ksLiD5h3kl40lM2QuSko/+bVMC3dHb
         sBH825vEXOVRtUq9jojeyy8OVljpJl9+nM2iUM2XwlrqmMD2pBu1GVtPhhO+ZWx4Uhrp
         7pRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmdk64qqgw9Blnnoo+vofcnfClEgKkf+fRdIyGfQJwxjTDX0ymNhV40qvBjJ6ANRvUYlE4ypy/QL10DkUmdizFxfRP03tshzHj
X-Gm-Message-State: AOJu0YxJhGjwZbDoz3kFXQ1LKw53BfGwDqMqQHRj/q6shD1bWlV5o9zc
	vo/qS8PeRRQrf4oIDfWXZxGADngLYqp9ndCzTRYnuQKeQqG1gN26zyHBbfifEEtJZrzUAzDVtrR
	qyg==
X-Google-Smtp-Source: AGHT+IGxMfJsLFioCIbVVhceNMxmdE2oNsYOEFi4xsI7d9vZwfkQO4CLd+RTgecbKwv7uUzdANr9/A==
X-Received: by 2002:a17:902:e54f:b0:1f3:83d:ee82 with SMTP id d9443c01a7336-1f31c96913cmr73566185ad.25.1716481495734;
        Thu, 23 May 2024 09:24:55 -0700 (PDT)
Received: from viniciushfl-locked.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f09aa48b6fsm140587595ad.254.2024.05.23.09.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:24:55 -0700 (PDT)
From: =?UTF-8?q?Vin=C3=ADcius=20Lima?= <viniciusflima@usp.br>
To: marius.cristea@microchip.com,
	jic23@kernel.org
Cc: =?UTF-8?q?Vin=C3=ADcius=20Henrique=20Ferraz=20Lima?= <viniciusflima@usp.br>,
	Lucas Quaresma <lucasqml08@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: mcp3564.c: Use device_for_each_child_node_scoped() to simplify error paths
Date: Thu, 23 May 2024 13:24:35 -0300
Message-ID: <20240523162437.3823-1-viniciusflima@usp.br>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vinícius Henrique Ferraz Lima <viniciusflima@usp.br>

Use another method to automatically release the handle on early exit,
reducing leaks.

Co-developed-by: Lucas Quaresma <lucasqml08@usp.br>
Signed-off-by: Lucas Quaresma <lucasqml08@usp.br>
Signed-off-by: Vinícius Lima <viniciusflima@usp.br>
---
 drivers/iio/adc/mcp3564.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 311b613b6..52c864974 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -998,7 +998,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 	struct device *dev = &adc->spi->dev;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *child;
 	struct iio_chan_spec chanspec = mcp3564_channel_template;
 	struct iio_chan_spec temp_chanspec = mcp3564_temp_channel_template;
 	struct iio_chan_spec burnout_chanspec = mcp3564_burnout_channel_template;
@@ -1025,7 +1024,7 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	if (!channels)
 		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		node_name = fwnode_get_name(child);
 
 		if (fwnode_property_present(child, "diff-channels")) {
@@ -1041,13 +1040,11 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 			inputs[1] = MCP3564_AGND;
 		}
 		if (ret) {
-			fwnode_handle_put(child);
 			return ret;
 		}
 
 		if (inputs[0] > MCP3564_INTERNAL_VCM ||
 		    inputs[1] > MCP3564_INTERNAL_VCM) {
-			fwnode_handle_put(child);
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Channel index > %d, for %s\n",
 					     MCP3564_INTERNAL_VCM + 1,
-- 
2.45.0


