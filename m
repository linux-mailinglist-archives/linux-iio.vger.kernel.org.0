Return-Path: <linux-iio+bounces-18074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA12EA87BE7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0091A167CDD
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731B25E822;
	Mon, 14 Apr 2025 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9uzhIcU"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D925A2B5
	for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623098; cv=none; b=WZLqan1zCalOn+o2/VlZgxrXcnhWy0nqLIbf4Lxcut6sb1xzPbpL6yR0dABj6E5lgQXzmCTdWzbPLHI6jnhXbElMv52DWgUcGm7V/M2dg4DlRNoyPg6R4SI00bK/sdkjLBZfcjZrQI3PIJd7ca+5pUu8rK9YuRBK6X67bPOV0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623098; c=relaxed/simple;
	bh=WEfGh8/JZ50VI42QY/UzDVj5QGsc8xf1TZieBe4ZvGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGhdYSqGYbE8u0k5m63VeIQljUtu0TVHjE9W6EqvY9espV8FsFE1L3Re6v2qEsAnVsy6CL1lNf7PSCu3jG/CwTCJTRQvkgpSShpiDCpJX0iAUiL/NzpAMyg3Vj+ckOy3Snee4jIq3HtC5K3PT5rVZhb4qzQPlYnFN8Nk+wNDYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9uzhIcU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744623095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DcJtOZqqmGG/GNqQfI/h8Deen7z+Z9B2I6ayBe0ZS9Y=;
	b=f9uzhIcUe6aZkaGBH/hLegnGxmUqjCHJGBm7/oI3eoPbJjUMCVvNakG/Jco98wWX7vduCF
	831hqCtVX5WsTLccu/6fYrFsGZqdExZc9gG/XQwY2idRd1PRPyLGGL1gXcbXiExtiaWZiE
	1fgHztZ/qOhd6pI5ZjjVnNp+nCwsRIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-olu5v_6mPj29DOzdZ-IUmw-1; Mon, 14 Apr 2025 05:31:29 -0400
X-MC-Unique: olu5v_6mPj29DOzdZ-IUmw-1
X-Mimecast-MFC-AGG-ID: olu5v_6mPj29DOzdZ-IUmw_1744623088
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso25072955e9.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Apr 2025 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744623088; x=1745227888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcJtOZqqmGG/GNqQfI/h8Deen7z+Z9B2I6ayBe0ZS9Y=;
        b=piBtBAXUDHNoSPEF5+MOrG232/uY4QnOoxpRdkPutLUv4/jMDJcO4EGFg3dsJarFLP
         JF5Tkxhfiv09LZbjBwcG65Y3DiR8nsUg+zxhuEY77oBFRFh/6hsuf55hCMOwjE/wTokY
         J83BBKi4zkuljppbf6Z/YV/lr0LamsPFVvAxPE0q7mMiwrFJmog6gxZSfAlsZQD1wQnY
         0QP57iZSIlCDCvgLC0t1Q4YEd/fYlLsdPbaAchOBVWO+0i8kcextZWwYwIrmqGYmgNz7
         +ZZDr9bx+WW0j83LJbIQd7d5sKHMMBfG+DbNePp37Bwk8A0X7Do+yy8qPq1CUEDkdLdX
         uM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXXNfid1W3dcmcTsUGZo2Iy2ASGoP/HuLhTbM1YcJlV5BOlS9S56OhHg8pG1i2EDkFohiO+4zg3m7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgw+4kAEeDise44g42pASubmikp/HMmHdToVkqmsJRbLo6EIJ
	cJGsjJwu9VUHBUBG5my7m6gCAIHK1Gp3lT/5nqvpZzgi/IZrnuEaml4nmS6ajcCYkaWssLI26FT
	nEroDTPDhoyckscIIH2D9tq6O1qsghblu5hURm0ztTvkor9rmDgb2ABet1g==
X-Gm-Gg: ASbGncstpYpNes9BAE3VRV/BKjucimDUqZMSr8ztrGsl+TaSUj2dQij6T7LlT/lmNNi
	SvW6Jrd5lqbOsDI5RNiCgh5KICbZXTuSkk9+B5feqbMHdREsD5SpZ7uZ6vO3bJsw+qxv2uzCYrd
	mWYP8hUQO3ePldgoCS3dcV4r1lvG1nzMm02TsR2wurlbI0A+3Htyu58vx+nieV9fN6nNnnYQweS
	OyA88kxSp3DtHsjN8qrhAnjQoKcYaGTO2cRquUkgp5rVVEApKJBoN0uTtszmzWHrxSpqFVIJYWs
	+D32JloQGDqflVXuK/qh+FwF7oGFXIF6PP9GNyMGoHZSaO4QgcbZm9hP2w==
X-Received: by 2002:a5d:6d8f:0:b0:39c:dfa:e1bb with SMTP id ffacd0b85a97d-39eaaecd89amr8181813f8f.42.1744623088002;
        Mon, 14 Apr 2025 02:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIf80qJHQp64UqJH+NY2wPEKUU4CFrtiWzV4xC6O7YO6zvGgMGZVZiou6pYI9qUGO0MpoZFw==
X-Received: by 2002:a5d:6d8f:0:b0:39c:dfa:e1bb with SMTP id ffacd0b85a97d-39eaaecd89amr8181783f8f.42.1744623087487;
        Mon, 14 Apr 2025 02:31:27 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm169193675e9.10.2025.04.14.02.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 02:31:26 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Havelange <patrick.havelange@essensium.com>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in FLEXTIMER FTM-QUADDEC DRIVER
Date: Mon, 14 Apr 2025 11:31:24 +0200
Message-ID: <20250414093124.19683-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit b7549ed5edc6 ("dt-bindings: counter: Convert ftm-quaddec.txt to yaml
format") renames ftm-quaddec.txt to fsl,ftm-quaddec.yaml in
Documentation/devicetree/bindings/counter as part of this dt-binding
conversion, but misses to adjust the file entry in FLEXTIMER FTM-QUADDEC
DRIVER.

Adjust the file entry after the conversion.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index af3537005de3..661419d7c71b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9216,7 +9216,7 @@ FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
+F:	Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml
 F:	drivers/counter/ftm-quaddec.c
 
 FLOPPY DRIVER
-- 
2.49.0


