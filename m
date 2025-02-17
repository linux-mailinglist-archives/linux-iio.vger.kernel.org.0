Return-Path: <linux-iio+bounces-15669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF8A3857E
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A030174C60
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDA21D5BC;
	Mon, 17 Feb 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOVQcTj3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAF21D595;
	Mon, 17 Feb 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801040; cv=none; b=cYZzYtn+CQR8h/OuqxMhRC+Jw3l1bG52DYP/ZZq3v+1QsxNY2pYay10Ydd0KDFLlGyXjLh60UHkDYt16172FiS4QSmPT7cN+UKglD0ShVu6fKMkoOxpL17HVJtAYQE7/wSAwSLWVMvEQs7oBUAQSGHajHXqO8BriWEh2zRr+zrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801040; c=relaxed/simple;
	bh=YWbWWsIv3mMI03pwpX5IuXVcOxaKbV7lgKMiX7Ez3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDVeFWAwHf4oCneDG7SsLXj7buTuouOxXqsIU+Ca1F/8fyXlw5egldsyrYABwzVwWD5HQNtIj1fEEriGGceE0uLBtZWcxk7ZiLk34Dx3YjoXJkKWmUmoZv/1BnMFUf2PnnxaoCbvwBdT6MjPVCOdeJF12MCkOjaNF28328haWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOVQcTj3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30918c29da2so34000321fa.0;
        Mon, 17 Feb 2025 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801037; x=1740405837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L330aLnl7KlKZL4XMYjiJT58mG5vZbDUVYOzSIQvANU=;
        b=hOVQcTj3YU1Eh2JgxYRhO3QUspzuJBJhrRZ/Q/CSe+BwnZL2uDl/A5lDPPCIzjsaS1
         P8i3iCaClq8Vb3kF3Y7y/IBWlTEpWe171fuP1/R2RyoIZAAu//eEv1p2VusMdYAhZ5DI
         poY6eU2O1q8Be83W2+pYpzr5WFxPUHhnQqnewWcoEfcmtqxblG9foSO1FlIA9E+Cqqcr
         SupoZtBBuziG6qvRPuUDkRbiXOfSK6WePXlsfi+Uz3GAPy9DIPrtigevlWHvp4ecgeSB
         +4wMgAJbrvGulOmxSyMElGaKJYB9beqRphJI4YMtwUYrd0kGgtic1v4us6mKPGOVpnjw
         Hqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801037; x=1740405837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L330aLnl7KlKZL4XMYjiJT58mG5vZbDUVYOzSIQvANU=;
        b=Qs5WhWhZds5EYWj5Aqe8/mu7eCC4HZXWoc6/wtVOp88cvWqqadl5EXsmZVa98WJYrD
         3Of/1cZb0dqQu5VVzYVHSSsZQ3e27zX2vl5OTRzKy3GHGTN7Ku6u66hH+x2nsEhRIULc
         KPRLeQfcVZdDyxWzOt2T7kifQT1/Vq4Bsik8Gi5svmJPxSgbdB+F+wBi6HXNDQ72wTp7
         0WrMqewATX8oWWD25pYOglTo62QFJTz+Dm1Ar58sjN4VuMgbJTMugO6D9WvAtc80anNM
         nsm6oqshOf6ZtOCcf1V38PWYQik+G297SCJDJBtBi4sW2UnyCh/TS7RTv4DeeU55bNfY
         fuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/fIKMHkQEcQypH2LJdDWYLg0vEiiLPeKgzqSP4Yl0kJ3hIcrMCmFm7RWAnwqWJDSw1w8NorWuolQByGhR@vger.kernel.org, AJvYcCWVPBqHAbn+LJEAqVd8uArIygAE3dCM9xjRLRBkeZ7PPazCpZXhXXmEQxTvPZfXH9XT//bxA0V4r0OWuk8=@vger.kernel.org, AJvYcCXs8RkNf+9F/xHiK5rGy7MyOFrQKB4Zfthg5a0cXmhsvhMfn+UVCcDj6Iv+7ldrU7pyCq2bl49jWlay@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2NGUc0t89gNr8SlLs0nCijasfnAjnLTu6rd4FSmXhduCriWw
	zE1xhRtEV2rhdKcQ9GFpQyIe2Px51ed+UEk6ympZaSLEMH1Zc7mR
X-Gm-Gg: ASbGncsstBP8888RCWEZwlieS2y3BggAK8To8a+oQmDDHhjvuxORDT+82ne26/QHvgu
	UwJAvVdXN9uYINFUmwVaB+E4huTXOgcaXr+gXRSI41NNf9luRZmIQaijuh1akKGFvWO/0QwoYtO
	EG8R4qPlSHekXEYd0liCIqq+UWE4UHhBW2Ol2K9IH6PKvhzHgCa33+LA1Sx1a9+fSOYnj/L0zSM
	xiP+o0W06MkDIVAOsQOwegAHPSiIFca42jaxqjWWArcNoCjXm4+AzhOkeNftd+o2aOTG2CQSfZB
	4PIvFws=
X-Google-Smtp-Source: AGHT+IGaKgYSMl7JQLwIHAeBKkZ7tsfcjhptrf7X4G05WhrboNQv37tJOvqTiq0zoMsVWI1Ylmln4Q==
X-Received: by 2002:a2e:9ac2:0:b0:308:ec9d:d9c3 with SMTP id 38308e7fff4ca-30927afdb64mr29329161fa.26.1739801036238;
        Mon, 17 Feb 2025 06:03:56 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309306d5f48sm8919601fa.57.2025.02.17.06.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:03:55 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: iio: light: al3010: add al3000a support
Date: Mon, 17 Feb 2025 16:03:34 +0200
Message-ID: <20250217140336.107476-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217140336.107476-1-clamor95@gmail.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is an ambient light sensor quite closely related to
exising AL3010 and can reuse exising schema for AL3010.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
index a3a979553e32..f1048c30e73e 100644
--- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
+++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
@@ -4,14 +4,16 @@
 $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Dyna-Image AL3010 sensor
+title: Dyna-Image AL3000a/AL3010 sensor
 
 maintainers:
   - David Heidelberg <david@ixit.cz>
 
 properties:
   compatible:
-    const: dynaimage,al3010
+    enum:
+      - dynaimage,al3000a
+      - dynaimage,al3010
 
   reg:
     maxItems: 1
-- 
2.43.0


