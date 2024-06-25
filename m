Return-Path: <linux-iio+bounces-6909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF884916DA5
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1D5B223C4
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C82171E5D;
	Tue, 25 Jun 2024 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoYd0tR+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969841E880;
	Tue, 25 Jun 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719331358; cv=none; b=glkLtJ/2HHzYsEhWWmPrnlxXY7FCG1T9zIBQXsbsAIRL4xBCX1EWq1FU4Qa+rgxymEL30ilSd95Jxe4kSs6KdsdQyk2NHFdb5rNByOljeK92i0Ux53xtUlYQn/Hy5ZbxBCTrYZqiDCNa3B272YUneLb0vyQJG1c1f45EsoziVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719331358; c=relaxed/simple;
	bh=H9NhAIwlXxLajGf/VmKJUno8Ov59oH1ORxg5Wfd0ozs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StOoCQy+BtWlUm+Lsk7h5r2WoxGh/cn9OUfSanW7vxjjT7kb0qiR7aG0bSUDAdR05KAh00hzpMtQ2fGX9B9rbUxW6acpDFBXWsSgLl++sQoaqSSWKT5cTtcBzxwH9NOrhWbVbUrTU28uYgKi7FmJPEPepDw0qCdiHWEfOYW3jAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoYd0tR+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c80637d8adso3797578a91.0;
        Tue, 25 Jun 2024 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719331356; x=1719936156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyCedTW1nN8xvbHGjz0S0E8d6Bz8vQg4lJTv3rxgtV0=;
        b=VoYd0tR+MjtYNcU8G2Fb+q02PNnVZtAI6yTRywTzsvNgvulH62OLhJqBDZ9zP3whMz
         QSAamV0a0odZagx4Hx9KuGdWzqVZw2es+IHPShGTKL12w3L4I32uWlUp1262LOwcNVHp
         RRcW8BiTWhVIlQpAkeMJXP6fs9Hty/oxrhZB3tPVT3yUxNSO0Kt/3JU/EhaBThVjdiYD
         JRU86xU7Z9WUuD/pOMy81TrEqa1NVDIbmBcm6ZSHn390rx8tXBQpPf3X+isKN0ZebOTG
         M5OgF7kngaNEGKLv7E2//Z44iO/hb9JzNu6DBt7go+lL5HU6VjnuCvR5M5kjjM8Ik4Md
         6K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719331356; x=1719936156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyCedTW1nN8xvbHGjz0S0E8d6Bz8vQg4lJTv3rxgtV0=;
        b=LNNyyrQArqMcUG91OLMTeTAi4ZpheRoyBoUaZLSykdJ0+UPbvCayb1yIgPn1+oS/Ay
         NcTqe+6W58jnU1BpX75CPKGFbDcAH01ILs0LQOedp14Drnr8DnTAvzHroZEZsG4Xt5f3
         QBML6kLIcSp0iEpCu5rIp4oSEpH9+MvCSQXkq2SGj7REK7MuQ30xb2GS9f/OsQG1jrS4
         hEEysKBmQX6rtG59ZsCawCOOD917Z+fQsElkTg0qzCD6AbRii9R3ZucL9ulvbY7UIiPb
         b/h5Pp638paQLRytjqPH7odFKktvIiFu8nAJkMZwg+EDLVf3UXGaJqvf6KqI+Ur32Him
         7vCg==
X-Forwarded-Encrypted: i=1; AJvYcCWoaF8fRc13gBEXVpx11xyqD+RRV3/9vvycfC+hkfJ5lATlfg4LiT18cmKpLEsPpiMcXOaG70RuFNHL10/xsX4Noh2+yLOB97ENGnLxU2hLN61VfwnknHdAdBfYbym4vCAy/LFGnj1d
X-Gm-Message-State: AOJu0Yx2kKvlo7ZGz0U7Ve/WLN0OUnqDqjXNUAufzFWGYjol1D3cFeQ0
	a214PDcOpZos/2nRkuCUceonpu88Y0tumlHxkFrIrJjLnNffzpTVdUtKCOG1PwCNDrRlRnA=
X-Google-Smtp-Source: AGHT+IFSW58jjiofvaKRWaqssrp7D3AX18x1wfeXyZeD0fMJHK6Qa5Cqr0Rk9QPtHaD/e/T+W4Qh+A==
X-Received: by 2002:a17:90b:4c8f:b0:2c2:d468:76df with SMTP id 98e67ed59e1d1-2c858291902mr7521112a91.31.1719331355631;
        Tue, 25 Jun 2024 09:02:35 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e5af9de9sm10904009a91.37.2024.06.25.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:02:35 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 25 Jun 2024 23:58:52 +0800
Subject: [PATCH v8 1/3] dt-bindings: vendor-prefixes: add tyhx
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-add-tyhx-hx9023s-sensor-driver-v8-1-0c224e3bddbc@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719331341; l=891;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=H9NhAIwlXxLajGf/VmKJUno8Ov59oH1ORxg5Wfd0ozs=;
 b=iCYtLh3hxlVz3dUjriZlJdITToZwKPZwW/NteKt57pf9OrChnNqtJ/osoxg2236GPjqZfmGy3
 K4RYHPSlo7PDeGXfffX5UXr9JdK+PuSE+bHUZ5V7STGTF+1OIf94SHN
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

Add vendor prefix for NanjingTianyihexin Electronics Ltd.
http://www.tianyihexin.com

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index bbae442d01d2..d7d15c9f30e3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1529,6 +1529,8 @@ patternProperties:
     description: Turing Machines, Inc.
   "^tyan,.*":
     description: Tyan Computer Corporation
+  "^tyhx,.*":
+    description: NanjingTianyihexin Electronics Ltd.
   "^u-blox,.*":
     description: u-blox
   "^u-boot,.*":

-- 
2.25.1


