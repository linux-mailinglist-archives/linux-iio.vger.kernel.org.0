Return-Path: <linux-iio+bounces-17330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E689AA75739
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 17:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224417A552D
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 16:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41F1DDC34;
	Sat, 29 Mar 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYDPGUTx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126413C3C2;
	Sat, 29 Mar 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743267011; cv=none; b=qgQlClKC0fH1anEfinq7ECQzLjnAAaAQJrSvHfdzf4KnFDumRJAGa4AQ6vEC3o8ReoTRDzbGXeXjp6labge4dzwiZkjmhFZ95Hy96HgXCBukfwx5tHO8oYlcXn8sEBockXRnt7uiazP6JUfmPLq086MSDtcqfwtuEaJMtfvxqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743267011; c=relaxed/simple;
	bh=TwYKGxk2Xb5h4ET+WdIh5zx2Mu2nuAXbKKhgIRZwD90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKuVCZX7skymoQIOXSZn1py8TfgDqPGKJLO7Md+11yFR6A6PWk3tiPwwkXngfGNsc8p4hyNtnGwueFQMYtaO6hAByB1wDdVoCc4TUZW97n/53GTPWI45Yj9wINpWg6nRkXG4atNXNmgLS9EyVdMy9UMV0GN9/luElBPcO92rRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYDPGUTx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22622ddcc35so30910715ad.2;
        Sat, 29 Mar 2025 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743267009; x=1743871809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBw6C0ziFRnbZ9N8eAluNk0SPMVQX2BRjnDnpLWinvM=;
        b=fYDPGUTx+1hN4QP4LU9vqsYm9uUvlNGXuMg1BUv63a3yaWm6koWyaMXlrR+PZ+8ow+
         D7lJ22oqrEGfmMO9HlJifaAPSAYR0vPLUV+zBdv61moqOTH0eVmKespkz6U1VUUugMto
         sIgOqc+YP4GUfC5gx+1KR/Zzq08afQSVJQde7k/vk8jLtcNqG714SnMJfhEnYgQfmJtu
         sF+COVgdRlaTouHS1uquJMytLLhH8jim7eJr80h9XOX2SfE42FX8gptMxT35nBo4NXA9
         4tZBK1QhNc5Eb6jidm0GYXO8cfhBAPEx+mfg4HoulIZoWyUP23qDvCkLZyX93RCtmvjf
         mXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743267009; x=1743871809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBw6C0ziFRnbZ9N8eAluNk0SPMVQX2BRjnDnpLWinvM=;
        b=O7EEmDIyJ/7JDKiNo7PNAqXwiFG4mT6jy/nXiOG5wI/0vX1yjkRRhIoGzo13pTWdVx
         z/wkEJtlv5YvAMqGb6cCg/zOlxpC9osisgGxmDvxk8FW+EMjfwQ41y1sH027ceVhaTBf
         MpSz/mx6lRCE6hxmg/H2+/C6yCTbshhrlJ/Gy/cylCCouNfiHl3ABmp2bpEHA0cRT6CJ
         3SgiTZN8R5hpCFe5dKkgw6x+UQMn2ILmbGkQ0uV3KDTWRgahqbtzpd6HBvoqCLRmXfKm
         PJOazh30SIY0wNyAue6rKF9BhAGYobRqgp2TSuGGBfBs8TtC1PGZ8XvyqHbTOiONghaQ
         G4gg==
X-Forwarded-Encrypted: i=1; AJvYcCUeWdnjPSQoBiWl1XMKMA6y13CHA6pIIWLpVWxz/QO71YjTKTRU61ewwC9MDm7AazHeZXoLtQWwASb/@vger.kernel.org, AJvYcCW+2O0oi2cWV98ZA4t2dOIoxJ/Mvb3awAGPN0/BvRjR79iVsJ5fGEo6QyndU+MXQptVGvKu5qrsFPs8@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbInnr7RC+GnDRdcEjXfRVeW2i0qNMaVXSP2ihqq2hQskFS+e
	eeDZUrAKNIGm738fS445s3sfMNLVEmVoHpfQyEezL10NOucI27Hz
X-Gm-Gg: ASbGnctegeum2A97nftmczkeCo0K0fEIdSGXKmnSyiWQ3dVpPOKs2w6IlgxUl5CfHxM
	IN3P7ki1+gJJXbRWglT/3sINemnda3qvyQAo7wjcms2Wgyi99Q3+jzaDgcd1gnU4wMmrNIuNgQv
	j0Jr3FvKzl4G+Qm3Oxqm6zsGu7Rm1aEQ2/KM2Y0A2kKuvmwul535PCKit17MabmTsNsEF221sdE
	icdVlSVYWHNsDChgm5A90maK/IIv4WajzuJ+HfvwFrIfoSVpAlxSFZQLf6hUaw54NlFOEWICRdZ
	WDb4sgm54/WUAEdGRhn5IPBGkec4L8Nxt+u4V2mU5QP24iEk/aw=
X-Google-Smtp-Source: AGHT+IFG/WMjPBQ21GhWTbkT3aa8eGLRfNpFat1jbBlXtE5+4nDh0b9rIKwu3zqVe6kSoKSrHaMKgA==
X-Received: by 2002:a17:903:985:b0:21f:35fd:1b7b with SMTP id d9443c01a7336-2292fa08a10mr54995185ad.50.1743267009317;
        Sat, 29 Mar 2025 09:50:09 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2291eec6fb2sm38565425ad.26.2025.03.29.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 09:50:08 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lars@metafoo.de,
	gustavograzs@gmail.com,
	javier.carrasco.cruz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH 3/3] dt-bindings: add winsen to the vendor prefixes
Date: Sun, 30 Mar 2025 01:49:05 +0900
Message-Id: <20250329164905.632491-4-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250329164905.632491-1-gye976@gmail.com>
References: <20250329164905.632491-1-gye976@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add winsen to the vendor prefixes.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5079ca6ce1d1..ee7f6100c432 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1679,6 +1679,8 @@ patternProperties:
     description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
+  "^winsen,.*":
+    description: Winsen Corp.
   "^winstar,.*":
     description: Winstar Display Corp.
   "^wirelesstag,.*":
-- 
2.34.1


