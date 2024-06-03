Return-Path: <linux-iio+bounces-5702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B668D886F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CE41F23EBA
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B0137C27;
	Mon,  3 Jun 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="b57Drfdw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D9135A46
	for <linux-iio@vger.kernel.org>; Mon,  3 Jun 2024 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438102; cv=none; b=maDBBySYV9B4bvJs9IWkAEPDceefoDpm3Gs74y9zV1qRGOydLoMdudPqnN1GYBAG8psFvClljB/mp66cmavl1JBILh1Qk33//8qzNcU8z0KMewnAkaSxVOwH2aU9IjTJaMBFlj1hfkcWlGljhLpV4EjcPliMkMPPEp/XXAhApw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438102; c=relaxed/simple;
	bh=VO5oOAZJFAK5khgcpL7w25vOyOac3BiN3yC+4Uft9/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etXS2kSiymTPlpZlIPUJQdSyE/Ie2PEiJwszebWEnMxMVVVXbSOt14fvbPsA90bSAkqpsMFFH+2xgrZAyBp2VTRMx404UDpNqOQv/jfyQZkxXbXEo5ZOdsT2L+zY/+laf13UomhlooOWwfWizeDoQ7UASTUiUlxJ4xafuonFAdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=b57Drfdw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f4a52b9413so36880895ad.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Jun 2024 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1717438099; x=1718042899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcCk6oSoXa7ErpZsuhxmo3A3wJg4HxO8XJktj4ZPfWY=;
        b=b57DrfdwMp6hS+Z02PDj4FsP+Vbz1K1CVG2nn+fcJdVYdA2DgY99gYWL2Nf2DmLMpo
         3FmdZtCYMbcED/Bwp+5+Ng23zu/d22Ur8vJ9Gp1L4QcWNimpfsCvfFiU9qNlk52+FS9v
         cHSmxE/pZyU/J6kZLCQ0XVv8ohjcjrhinIecRkzEvYIMCEoSo+FjvU4ud77KNfj0idzR
         hbM/gmYfw0M8CPSMZgUT6on9PYVrdstmha+Mxkfzkj0CgQFsOaJCn08qsGgeIrC0FUJd
         tGy4/bZbbmeVPMVgs7AT56zWPvwCrLwOjtFANDpaBcqWqBADOQ7qU82TxofoFkRwl5Y1
         OOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717438099; x=1718042899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcCk6oSoXa7ErpZsuhxmo3A3wJg4HxO8XJktj4ZPfWY=;
        b=NYruGnQme1UG65htkbqQu0T5DKDluugQd+Lp93c1UsFZBJLlxQG6cxG23/HRtCXH51
         M7o0wgqm9d5ir/EFnq93T331fR5fqylyAEfNPxGUln3b/JyFj31/sdNvj1mMxb2rz3Ph
         RA3FKWXBVkHsEBygNWOn0tI6+kfb87tQ5wtQzDL9frqObAvEft/0NxcRh4Dz1pX+RMBd
         j9Blrh09Ll8SGDZbkPTYrl52xg3AYYRVDMV/+/EQIxkBnzMNsv2FTxEn70bwiMpCMic5
         VgFMu4MsbvhvufmyGrPk6L8r4nr9U+3/637i3Fl0wzfJDKQuRRXwvNsAWyXlUh1PVcmf
         TApg==
X-Forwarded-Encrypted: i=1; AJvYcCXFZM1gDFy9NOC6OhB3kxuEa9YbgB7ukH4SvZCEgCD3CLNPC7nS8OH3D+uB2IuENC7cfxOLjPQQYosYcdz0+OQ1rBTxcoeUwv8j
X-Gm-Message-State: AOJu0Yz50mP4iCTLtiWn/eWpzC4ICDVh/T62NRfPD8F+AcdN58VIx5j6
	aIDRHuouxS1CNA49OkIgTi9TIkXYAjK0V2HqWXJljlPxrr4IVMdv4tNoTHKOw7SlXtGNSpnZOzP
	TaUQJnQ==
X-Google-Smtp-Source: AGHT+IGi3fTDhv5BSeI4qWBIBiJ1IiWC/cHNGEm6//JLVsoQrMocvOLLSX3CalrAk2cX6Id7+xC1aQ==
X-Received: by 2002:a17:902:e546:b0:1f6:5c5e:d84f with SMTP id d9443c01a7336-1f65c5edabemr65477415ad.59.1717438098621;
        Mon, 03 Jun 2024 11:08:18 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241c39dsm67348985ad.297.2024.06.03.11.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:08:17 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: hagisf@usp.br,
	linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	jic23@kernel.org,
	lars@metafoo.de
Subject: [PATCH v2 1/3] iio: adc: ad7266: Fix variable checking bug
Date: Mon,  3 Jun 2024 15:07:54 -0300
Message-Id: <20240603180757.8560-1-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508155435.183850-1-hagisf@usp.br>
References: <20240508155435.183850-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ret variable was not checked after iio_device_release_direct_mode(),
which could possibly cause errors

Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 353a97f9c..13ea8a107 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val,
-- 
2.34.1


