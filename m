Return-Path: <linux-iio+bounces-19749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7664ABE782
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CDB3BBADD
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373A25E46E;
	Tue, 20 May 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUvQGd5p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FD254852;
	Tue, 20 May 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781441; cv=none; b=CyyU+jVesHOJLn07f4ohErJpaId68aA+4ZosAap9dJ2yEG16GOFSAYZTAbnNb07lIknEH9dRsXU1LZJdbTq4qV6uTxgLOy0JJqGcXxmQlN0fGTITT6pzjGW6D4ALjsgvjbkfgO6+Jiljm/i6YHYIQf+3rtl2jaKiMjMVfLrFKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781441; c=relaxed/simple;
	bh=cKE0WSkFCIF9Brh/SnNokfm5fFpy6Et8C8/qKo9CJEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bn4LcqW9kzVpw5zkYisgQkocm50GBdotOy23C3/LI7oKhCpv7m9AcHUaEjewZpCt3gWH06SGrhASmh053B22EWPpZex7C/VDyRps9A3W9ojK4FAY+wpZZ/Iad5LwZ993cbAb/A8lV64Obty4qGgt53SKu/lt1JH8Am52/qvSt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUvQGd5p; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43f106a3591so5758805e9.3;
        Tue, 20 May 2025 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781438; x=1748386238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=PUvQGd5pTDd4W6/DqmyCqD+JIN/quFxVsN/k6HqpOukEA+3JvQt2e+aedBakOBLD5f
         7Ns1awoGPflI5F9jKKH+W5ZKlniOEZZuMLobAeM/5stBL850+nFa/aEHG4ihRJcK6Ef2
         RBW+NCXaUf6SKrOoNVZR1+3gR3hzB/ntk5L+1ZuPUWa06iSYdyNPD0w5TyMehYgH1rJe
         3Cu1tInVNm9Jvsq5g9sbDxF+xK6q2sSJ/sWiSQ1USngMgJuiB37ySLR4OWBg/qjBQj4f
         ZmqTua/AagdTgKSnktSEy5Yl0I6ndyW/4HDWEGLZZE66Nifkd8yKgndQCsng4jVyxCc5
         i98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781438; x=1748386238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6DN8I6oWq/48UPwKEfQAdQXXD2jU/KNfzvJAEFs5pM=;
        b=NkWSviMqlNq/otcSEFuo8gqS1ob27ZbcezfH3ReOaJOUB6ZIHBeFFeGbmfnaodMNBt
         GJm2NRY81miPR2Lx5JVPo+ytc7WkwXtwx7HNMCZxmLlnjfonfn5tNEBbS13ZlUAgaVmA
         OCN5RctkJlaN2twrr+2syqw72L2Tl+5EFePbWyF2YpqHSuM+x6/2U/y9Co7RdHmx6lt9
         ObugksG1+2FMIinztisS1Imk7U9p0C165H4ENQmrnkr38d3ktcMAVwNHg57+yVYTkQNY
         w8eXLFAhizshTqAk0jAob+LKfYRyun+foQbX59/RkaQH1dBMwrqztwi3gDAhsvFRAkiW
         b7rw==
X-Forwarded-Encrypted: i=1; AJvYcCUKxMM4TXUWOPu+tB6KIAZJdY7B5HqWRk6HxCcBLxf6H7Ez4iyKgZnt08asMa6SjZbeChGJXpTcris=@vger.kernel.org, AJvYcCVSX79BaG/HD0zD0rtx9Is28zkdwp445Z9b5BQAH8rgVkiTnuC7wVEfsqS58FSxntrShvMC0VToAaEUi/Ku@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yw3LHCJtb+4sD4Ko6sDA/Ee1LLdBHjX2iFr4oANLBEtWlgR5
	cwtc7++hmCN+EgynX0nm3wCNA49ne8xIEUf5wifWp6u9dNm9ZNes7VvCppeVfycU
X-Gm-Gg: ASbGncvkBlMgSoJZKSnLvI8mTvebuouc6uwGGFkC3e5Opt8eH4aFMtqDoIA9JP2mHi+
	/5pGp13m2kWOBlpDdlzcQwRTWNFMe5P1UmmUVyJVGLjtV7Vdy3kQLpazXtIHSQ5FHnRdeNbPhvI
	O2+373KlKDM6e1O3ihdJflGS15KxuFVC0ns+yaSbKjj6rlr1ZjJ5Thhq9AqwnniTaegbWLqDVcu
	5Uvk9vOgdJe4+EHLNzqKkvgiMj1nouaTM2wmtbs4ysj/eJr9MiH5LCapfDmLq19EEVFy9qYGrnt
	iSECmHchoP1+PV1o0ptgLhq+QJQQsXa6fBdO4m2kQzjrBlEwws2upDY7ILfE3ccNUJvlnMtyxzb
	ihzSLx4tcIE109HviIY3DlFLW/6cBNEeX
X-Google-Smtp-Source: AGHT+IEq2nY3oOxRapruyIMUL1d4fqQ5CAoacfmWCWv4dZkHQOKvu4qa8LzEWrdFkMavBZaWVO08Bw==
X-Received: by 2002:a5d:64eb:0:b0:3a3:6e85:a550 with SMTP id ffacd0b85a97d-3a36e85a992mr3110219f8f.5.1747781437985;
        Tue, 20 May 2025 15:50:37 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:37 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/12] iio: accel: adxl313: add debug register
Date: Tue, 20 May 2025 22:49:56 +0000
Message-Id: <20250520225007.10990-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iio debug register for general sensor debugging.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 4de0a41bd679..2f26da5857d4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -321,10 +321,21 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(data->regmap, reg, readval);
+	return regmap_write(data->regmap, reg, writeval);
+}
+
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
 	.read_avail	= adxl313_read_freq_avail,
+	.debugfs_reg_access = &adxl313_reg_access,
 };
 
 static int adxl313_setup(struct device *dev, struct adxl313_data *data,
-- 
2.39.5


