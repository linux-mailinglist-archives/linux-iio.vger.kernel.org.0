Return-Path: <linux-iio+bounces-11565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F279B4BCE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB7DB234EF
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 14:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE672071E8;
	Tue, 29 Oct 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CCuA58Og"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED6206E8B
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211225; cv=none; b=qiy+fPfkT4Lf0rWL4RmkVTNTtI25oxhojeqJnd2zI20qLdk+w/Wr24BC0CEwD3f3DfOp0Dj4k8Vu4u4oJq1/N9iERrHxZPeamYh8gpBvSsUq4CJEyHFN7daXSR+LvgLpNwEYbgTvW3IXh/5QVB+rvffb3Ci5m43panB4W2JUg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211225; c=relaxed/simple;
	bh=AXp9R9SIchOWcn52tYxCXMRJHbP1cxB3uaJJrIOcnfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A75nv0xS2q5z15qEEQj21Ej4SFJDYF7Nr6tVHMnqRkkojfM1i1ljX/IWlytGak8No6q0RiMiwhivNKAb1AkApaiKPMeAGSYvL8oz1L6eoC/07Cmpa2uSDfD3zQxyxe9DIvqqJlR529em+CXmrJq9Lfbw3F0xXG01xj2mA8RjSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CCuA58Og; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so4049956f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730211222; x=1730816022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRMi/UaCb3Fk6BdW82ihmAT7XSEnqkfXgGS7TLc7snw=;
        b=CCuA58OgDYBbBjFyh1CAqzNsQhoEVgojZpWroDbROB/7Q9LpVU2I8kHNO+jpwjnisv
         p/otTc2QcmtWD2fsHoLZjjagSpa8Igzr5zAKRO6fslZZGLil1lTn/n9PGZUVfNJAe1l2
         rZmVCsUYzw/6UFqDsRoTdrh1aWHm4PVYJRWFpB/INILZudckrrLAuNsm1kfDd6I8w98f
         eehTfQuEX9f0QzsFDAJ6CkC+9j7u7E+Do2X50QXIbBD7IWTcl6UDgXwmvec4KSxiyyKy
         qtWz+PTO0/cCk/EuWmYtNosTKW5/RkI5iLVO82+sDqLUoUWBpYKo0kd/DsZ0iTr6nFhZ
         K2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211222; x=1730816022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRMi/UaCb3Fk6BdW82ihmAT7XSEnqkfXgGS7TLc7snw=;
        b=wU/AGPwyRWsx/D4r6ybHyq8U3WHvPD8RsjuJ77hHE2G0/VEBjBCZO8JMWsxKfvXqwD
         7rr7ruJWqRD2fanvCm+V14Q5BDnNVNtq7oLh3/Ytyi/jhRIcdAWqnAzgy4yPPnZl3iR6
         jEAB2vL5JI+6ezlz7MpvxpRcDvfkzHOvo4VSJFxGJ5Ff2/8uO5mV6CCuH8sTDFGwa4Tr
         egeCa9O3zZunrom4LBod/XkELvn4ERP9gzvQDTIX9LqC12bH9YEpu1xI5W0r6V3C6nYL
         un8BxodNIYMubPYnaXuz8yJfxyhlpdY+3kqcRFBQsf/HPcVwaF8QbCs1RGpWtNJfCUeH
         4Wzw==
X-Forwarded-Encrypted: i=1; AJvYcCW12xTUYJn6xiYW9meHCmwMiGQHhVrwRTtgheHJJSqEmW5Uv5x3O1l7z3GttYLVwKRXmJD7Whe00lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyms03huy/4jiZXFqIL+svUxfEKs3WO6lo+P6Yo7791aSsN7qzI
	u7wWq1KllEEpI6hQSDpHzwmVk6t8dLU9uk/HUXbaksB/F9Z4ged7JhUoZ78aNeY=
X-Google-Smtp-Source: AGHT+IG/hANPxkI3R9mBrqcqUgKe6T1qP2N9UPHnkqj3K1X9544Fi2caie3EUqjCpOM1e1Zz2xCWIQ==
X-Received: by 2002:adf:e84f:0:b0:37c:cbd4:ec9 with SMTP id ffacd0b85a97d-3806110a2d1mr8704442f8f.5.1730211221583;
        Tue, 29 Oct 2024 07:13:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b714fesm12645871f8f.71.2024.10.29.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:13:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 29 Oct 2024 15:13:37 +0100
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Allegro
 MicroSystems, Inc
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-topic-input-upstream-als31300-v3-1-147926dd63b3@linaro.org>
References: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
In-Reply-To: <20241029-topic-input-upstream-als31300-v3-0-147926dd63b3@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=AXp9R9SIchOWcn52tYxCXMRJHbP1cxB3uaJJrIOcnfc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnIO2SZASliDAzrjxamRLhdEuyRSBI+fHNaTvToFWt
 tSqwr2KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZyDtkgAKCRB33NvayMhJ0eHAD/
 9RjQH7h0Oyev8CZhPUhsgRTdRv56Wwh1n3zN7PK6GSARAU1V5O6e22pkrwe5vVD/dNJ0AnLnqC+UM/
 CR2fF6o1mh2K8wXYREBQRlsRt8s96ATSIzjGyZT3sLtGogcRY2nJf8an5SqlqCm8A2ff3or2vt24Fg
 HsD2F7RKMbeyBcWpmjpTLcYBuG6H63Uz0PE6vr+nQIuEtW012FFMrrNDwcPRghA/S1i750wxp4J7RS
 zIVzqH/AOxzR9758J9FGM3xECG27opGfmBsMfB7Ol1JYD1Utzd+cBG7l1pn/ccG39oDvZK4XrpIIKH
 fhYQMXLRlaZ62fl8Yh9e3BeHAls2Azm93wbvvEItw6B5dFdlqj0ylbeuUqHgGjsW09YlY0nkDMaAYo
 YBXURLYxATu2UBH/WofqvRpeO8cCUkXTXb+ClAi5d4PK95HzzqaV/07Z/DYz/Mteen6vWLYPUubAbZ
 AWBie9SQs+A6JznwFTfLU9TuejHMIcSKazY84DHW0HBp1nv75e4KDJojLdB1R5Axhoj5glktu1W0tR
 7VApgDIeHQjMvTOuZ40WDxp68qeQO9RbMpp0IF2OFHwbJgDR6mMjv5ixYkKOeWnnBzuX7QlB61jGu8
 ou0yVbBM5r/v7ogI+qqxdRnRVaXfwHBklkLaNqMFSiYazPYDUohUP7lZUjrg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Link: https://www.allegromicro.com/en/about-allegro
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 15877574a4172cbd9395bed531555cfb009ff010..b90355c2b45ada6e20335cd5bb2aace9410e4d3a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -83,6 +83,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^allegromicro,.*":
+    description: Allegro MicroSystems, Inc.
   "^alliedvision,.*":
     description: Allied Vision Technologies GmbH
   "^allo,.*":

-- 
2.34.1


