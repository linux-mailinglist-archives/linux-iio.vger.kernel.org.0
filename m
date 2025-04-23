Return-Path: <linux-iio+bounces-18559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A56A98DA0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EBA5A27D7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E328280CE0;
	Wed, 23 Apr 2025 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltTbdJoa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCAF27D76E;
	Wed, 23 Apr 2025 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419636; cv=none; b=Xt43Czqjj8AA0Qvy7yKRlY/+yrzGra8Zx868HhjNnKNJykGHP2BfTF/jsA14jLkF/WUR1Vg7d5cpN5MDmvrV7PIu7tcX9W/NhRyFUaIIBDb8wE8AGg3pXaBtBMkd/c9XyA9Tb/IOfTpzyLpCdpIjyfE4kSFAe6oHeko/o163DMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419636; c=relaxed/simple;
	bh=LrSrr1PAcyOZjm1Ot5sYyk1pBF7ppOE5uJZ/qHaQpTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=llQYjvEVrK29NAWeTTduQTj3RIRHElsXAthn1zpgfZ5Hgm3qlva2rPGzpLU0qfnZ5FThgimD4adQsHaBtsaEAi97/NB8SoH6wJRX0CyHIA0l8VJL2u7Xza62bP8e1mOE5RbykYJIFW90Xjm5nHcATv1+vGI/k5QPnX9+erMOPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltTbdJoa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5825962e87.2;
        Wed, 23 Apr 2025 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745419632; x=1746024432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gxF+9NE84HJoOS1xDmv56fy0JE1OiLRcN6ZLUxKFtbU=;
        b=ltTbdJoaB6+ZVtm0meHPYCzCw7QBNkJdB9d2sllAENZjalWWVJAjid81x74w6xl5J/
         SVMCwvwePYB8GDtPzD/Xr7WQ4opghveXVVmYrcOH/OVXjWmMsEdu5cdAJq+ZZ/KOLNoS
         e09WXspWD1xRrCSqD+qrnOx8m4z2o/UUVxnf8nB0uRSmV0mziLU8V19srV1rZkjS4R1I
         P3LiBjsGNA7oYk3bLMVl2aV/v94Tpy/MhCAjw+uM5SxYZCQahOPG5AWt7TkrzdS5U50X
         m1Kbq/ey4+ql1GaYtkmzXbBLCkhwBrFZply1tN7lNs6P6t/2vkjm45stwHJxnkrxUEQy
         9+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745419632; x=1746024432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxF+9NE84HJoOS1xDmv56fy0JE1OiLRcN6ZLUxKFtbU=;
        b=OtJhGLRsjC6pH/1EpbHrkCbNOd/XzAJaQn07pMQbxn7Q0RbZ974H1Bx17I6Oao8V8Z
         LP+zrVBNy4X7iT5mRaeSjcvd+uFnPT4R0CIN3gZnZ+4PMxuQHtuuVXFBBNCBe1bxu36p
         c01zp1pV6lis7KA0ve2Jr791bASkHF+PaKWES87Z+/eCTUd0vat+vEcZ+QewtmnxR3AE
         rOzKRbEx1QAyMfKwhB5vGEgzqGpj3bQAh+NmWqEGhfY7IOd2srduN+NHBd8L0vM/g497
         lrRCYEz63SmWUyTGRIgYTKmzhu88dZHgvTDR56RIcRRcnUhG3PGCHAbB3vaNRUp6ELBl
         RuEg==
X-Forwarded-Encrypted: i=1; AJvYcCU0BMbDWLMs4g+Q4Cfwxq+zXU5xl3Yj1sMFZEDodyulvIODCxoRat+MOtVNkv1dkKma2Mj7RkOMVFX1@vger.kernel.org, AJvYcCUGYDAFPghBHhJVt0NuEFuZWWzIlaL7lggMGaKZdt6m5uUsFaEjIMYaylAzZ5uwJo5MAsYQkW5abTB/dMM5@vger.kernel.org, AJvYcCVUGFd2E5WDqn1sjSSzVxHcfUU0jeMCKnxJV1M/5Us44uRcUYzh/R3490iue36RSXP0VGw2k6axhMUV@vger.kernel.org
X-Gm-Message-State: AOJu0YwGor4C6pyRmfJofJBYUm5rEGKH4oIUXZ/qOeaYBXNLsDrPnEx3
	4pN4khRBQp8yXOKP65XhW11IIKvD2nmAMOYiPr6QUZqas7VT8m0heE6jhXGdCu8=
X-Gm-Gg: ASbGncslfJLIY6n9wThBjc8XgshAtBZRdSaXMtDflUVr4lT0r60ORroTofIapZ1hFdE
	hC18FZ9GqyyBSEdbUpEn3kEFapH/RaKQtYejF12foIyUBk4DdYrfjaFNRpS3fwNNNGB8Dh2s4uK
	Rb+63xiyUx9d/y4c2FNoh7/vQ2hha8FaHh7PCJuGs68tgKjLnjtrkBGtJObDsUh+lC72YRGiSuc
	QK+ZsMqRw5PE+2m1JoQDF+Ia8z8saNFUc3zLbAulk/VAlZgX0/ywF3+D5U+AsOT+J/XYyvUFEUu
	JK3SsUJfwklN5UswG4/l4XQFTNtcF1vzKtFhIKOp7le9t9JPlFPjCBqVQzzBT83ApIy8s6h/hd8
	pQf7bywF/
X-Google-Smtp-Source: AGHT+IF6oy4OVrmTWdxJiYcpDKTSfFLRcZS0UpsZPb7uyvvQY5z7/A72duQfn43dN+RVZ2u+KWhnPw==
X-Received: by 2002:a05:6512:131b:b0:549:4bf7:6463 with SMTP id 2adb3069b0e04-54d6e65e03cmr4970735e87.44.1745419631873;
        Wed, 23 Apr 2025 07:47:11 -0700 (PDT)
Received: from [192.168.1.11] (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f61afsm1598498e87.246.2025.04.23.07.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:47:11 -0700 (PDT)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH 0/3] MCP3911 fixes
Date: Wed, 23 Apr 2025 16:46:48 +0200
Message-Id: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFn9CGgC/x3LTQqAIBBA4avIrBP8Reoq0aJ0rFlkohCBdPek5
 cfjNahYCCtMrEHBmypdqUMODPyxph05hW5QQllhlOanz3qUkkd6sHKMelPSWOtcgP7kgn/oy7y
 87wdfAzquXwAAAA==
X-Change-ID: 20250423-mcp3911-fixes-ef3b2145577d
To: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lukas Rauber <lukas.rauber@janitza.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003;
 i=marcus.folkesson@gmail.com; h=from:subject:message-id;
 bh=LrSrr1PAcyOZjm1Ot5sYyk1pBF7ppOE5uJZ/qHaQpTo=;
 b=owEBbQKS/ZANAwAIAYiATm9ZXVIyAcsmYgBoCP1aMnQ7FxOaoU3mjBJmjbR+hFZ7wbVHNZzd1
 /C8yOQwoeKJAjMEAAEIAB0WIQQFUaLotmy1TWTBLGWIgE5vWV1SMgUCaAj9WgAKCRCIgE5vWV1S
 MsLDD/sGOWcPbBhDi58mozJ+GjfoTdU2UPpjnT/ZeQmD2xY0hSxM7lClgFGyj17j7KlkJVMe0Il
 19pyMedUUuK4sgrmTIzgBYKkG69iMQFLDzqfwbnY1H9XW8HN9IFU6k6KNGd0OlZfxjM6Y0xWCl5
 Efk9VN/qD7dg/BPuuKCQiXsbGQesui1XhTyfBH7Kmr4+yTMtxYQpkSwNFpo/mR2ffBvKt2zLzdI
 VdpFdSMxs8HYlihvYOMjNIcvs4Dmyp2BYgkI32WZqDIe0xmFn89gFnBug8P4fuGu1Bwds9p2bpI
 t9NDmGsHO6EyNlS5ZJIIaJCl538HvbRl2zwNR7AUnEY5TPZVGsniOxItvhGCGcsSQQUKUFRppPo
 XJzTO+0sXgw59NFX0Y+ucfU5EBmzIa3I0Jygt5NEMiEWqOf8oTI6K3R47u0h8Rw2A5CnhzuzUke
 EnIaQHfl1sLx9abhkHKe0F8ZzLl7d1Jn4/UViIRyLDV7uaqFDDhydDLZDJJNqJ1nrjXeuepflTD
 NGXtJWOHGIHe7bwjAojYrPqAL3b5rH1+ezM8e8Mmqq3yBmuA2vQT/B836FukvdPAbinL1wY+Df0
 bR1d/E3rT4IqK0Cy+v3b4flLhUjaPMMR+VygrpKP2Q8mLYHt1LHqsBmMv48J6ED/12zY/optJbD
 V8Sx8bAV8RZhNDA==
X-Developer-Key: i=marcus.folkesson@gmail.com; a=openpgp;
 fpr=AB91D46C7E0F6E6FB2AB640EC0FE25D598F6C127

This series contain two fixes for the MCP3911 driver:
- Add support for reset signal
- Fix wrong mapping for the coversion result registers

The register map for the conversion result registers of the MCP3911
differs from the other variants so make sure we read from the right
register by introducing device-dependent .read_raw() callbacks.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Marcus Folkesson (3):
      iio: adc: mcp3911: fix device dependent mappings for conversion result registers
      dt-bindings: iio: adc: mcp3911: add reset-gpios
      iio: adc: mcp3911: add reset management

 .../bindings/iio/adc/microchip,mcp3911.yaml        |  5 ++
 drivers/iio/adc/mcp3911.c                          | 54 ++++++++++++++++++++--
 2 files changed, 55 insertions(+), 4 deletions(-)
---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250423-mcp3911-fixes-ef3b2145577d

Best regards,
-- 
Marcus Folkesson <marcus.folkesson@gmail.com>


