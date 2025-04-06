Return-Path: <linux-iio+bounces-17710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A492A7D00A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BF51705B7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083B1A8F68;
	Sun,  6 Apr 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJrvTcqn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF0156230
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969713; cv=none; b=hmAy67VDK583GLvjZCwxnRO3dl2NpyKaBkjYhhZ/KLVXYWDYQBzYAsRVWk/Cn9vTsbsJtP6jnDYftqhXp+wwkLtqoDPXQki2MrYujvC9fo4TFYyMH0W3sz7uGlSVDmU5BtNP2jc8RoWAMFSjA7VvNu2OocxiBRdMWAnr89+j4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969713; c=relaxed/simple;
	bh=iSXkcUbsxY3DxZJb4frxFs5pjfXPxSfYSUua8756xYQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l2I4UuZ+V8pUfO91t5Yw5c9ipAeWIo9QrXxw+a4KgdqrrJoQh/iXBU04s9PlB0+gW3NBWFu89ygRSmkDj9/E60qJfd+EQkpVzp/vmg6hu19FnaQxmyJJcqFm+5JfLM6EaeMRYLwuPhEJ3bfOj8Y5xLmHBXbvRCQUxLljZ9E0CgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJrvTcqn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912622c9c0so391112f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 13:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743969709; x=1744574509; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1B7AZw7nds/G/Q7UFyxo55SXsrJvSu3ziPQ8Q+kdE2g=;
        b=xJrvTcqn1tLdwURDE2qcbL0jwaUazlJJRo2y5ecjFlJ8irt2Zgvzn1YkyCb4i89rjm
         jF7+9SPQHohZJNRNgC6jphc43ow3Q1tTiB63gK/bkgMfhGvsRBMhlekfkagmAP6skTXT
         H7ao6nNjRKHbRwYmSc2OFvUovXzccSZmTcOaNiruj/VRURJ6BLWkWdvkwk0hFLnbJmDH
         4nUghQDaqf+lTwSvr9KsreQLeJEHG9YzykjlwHZD7YkiPug9kyO5SKcektAA8Q3V3XEX
         HMxDRHynlSjWkqf9atzbBQWBAeK+iAT76TBEyOOby5wqxB6+DXTExYphe4bK/nrnCX4/
         4Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743969709; x=1744574509;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B7AZw7nds/G/Q7UFyxo55SXsrJvSu3ziPQ8Q+kdE2g=;
        b=KRDwQAGQws/XLSHVDE54BUQPKrZxk19yk3+8Ev2lKq0KRsiKizzYPrwng+e1xzovdU
         jlm0oNCjEYPXn1Ob5Voqi6l2lFTfz4kfwDY9H2EsWseI2Zs+pyLP8raIQNI0PHkcxsaD
         EWIyP/NKRAwY8mIk+TcIAMghy1wj9JJBnqCiS9Yxa9gfP+WyxyxPcROaLUSAAuyebGS8
         JZEK42eGztZWESqRPsHkq5c6yD4PSaMQ8hv7Gw31kFpxtEJ0Fzn2pXT05OB5EAKjndzE
         tZCnzWH5bOsrVwEE0Oc/6lKxf+bOJWIa51Pev0xZp2+UarONtIlJp1zCS8ilZ4jpARIA
         bZCQ==
X-Gm-Message-State: AOJu0YwDze/UqijyJQn9ZLcXiqddiySRjBPxzNwklVNJE6hdLZcRvWpv
	Kh4/N6OMUZGXb3B8bn3Qb6exZhqPPzR7/cibSCTbRPS+ZEJ11f4EjHF0mdzxvjd5Z3larzoIbV3
	B
X-Gm-Gg: ASbGncugQlM4bo6xiTM5rW3PgMyB1D2JZ5D8nbMoCcEgJRoPRIrWa4oxtJXqDKtRxuf
	fag2ODB6AnDnZ7hAw40KouaOTU9ibquRXTn9kd+Lsf7gYUn/b40x7DQoAd2TdQyUDVc0XglD2Nx
	onGoxd+b3YwhsYN8Juhy+vuxqZE2rZvIf43bbzB50aVUuN0EweCrwsebvT801DyfFFX35o87sj8
	V8sMgUDhluoVMuAYP+V7JAOdKstrErVFeAOuiT/zgXagMqOoD+tD2t84Z0uvG4if56cIpjARyy2
	yVcKJX6wwJHhBwSisytBFRF/JkjhWGiQ7bmmVpV/0WbB0hdSDtzbLfDTqSM1cOKPWiUw6LG7PQ=
	=
X-Google-Smtp-Source: AGHT+IEjlfGioqQrUO4vvsISl/rkiK08Y6eqp4VaGk5U/oVlTDftQ1aVG8HuZicBmI8IgcAr6Zc32Q==
X-Received: by 2002:a05:6000:2481:b0:39a:be16:9f1e with SMTP id ffacd0b85a97d-39cba936295mr3359285f8f.12.1743969708899;
        Sun, 06 Apr 2025 13:01:48 -0700 (PDT)
Received: from [192.168.1.26] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d98bsm10199924f8f.76.2025.04.06.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:01:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] iio: Fix wakeup source leaks on device unbind
Date: Sun, 06 Apr 2025 22:01:41 +0200
Message-Id: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKXd8mcC/x2MWwqAIBAAryL73YKGFXaV6ENrq8UoUXpAdPekz
 4GZeSBRZErQigcinZx43zKoQsCw2G0m5DEzlLKspJY1Oo1j9gbCy3o6Aq5kPTLvqHXVOGNcbY2
 C3IdIE9//u+vf9wMUrxNNawAAAA==
X-Change-ID: 20250406-b4-device-wakeup-leak-iio-4457b99b6a91
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=784;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=iSXkcUbsxY3DxZJb4frxFs5pjfXPxSfYSUua8756xYQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn8t2oyiYKFqMFuIEI+qrJOdqyPUI7XxIjAn1Y0
 XuFYA2+qVmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ/LdqAAKCRDBN2bmhouD
 14vhD/0UdVj5FON7GeEue18yn0kAF4sr1rbTdzOxvjDnh19v7r5l5KOaDq1/jlotutWE3p24gzP
 1/DgIRCP0ZCFWAFTyCYmP7nykaeuqW80Pu6MAEE5oTFfhQ7NnYztRpYyMROOpTauE5aNDfh67xu
 WAGlYk2LahSx6lv8cYYw0IrmIpMoeiRa8HDA+dJ79h38F8U66kAVXcuRDM+X3LmBoBuY1b+mc27
 yecbQYStW1+Ur/sQWjOEbuK+ue0Y4SSTf7CbY7mkeFIAc+zUtFzIwOu0r4ms5JJnudd5QzQBW9Z
 spZblATUlfk64uN8HfYOyrK1JLDbofZ5ug/nQejIxBp4knzpCkdoSW0/tU+wLr66X9pRtWPtrEI
 4WQLrZqARWQyl+L/wsaWyRQm0IKDx1dJF7Me5vOVM+h7o/eDtBdC59OQhDP6hQ7XaRP2fD7urQq
 bozViLpZlg0Ac6Y8E9w8qLFpcDDr6G8u46iIQ7FmdknURcviy/zVHPIAszrAAFDvnSnW+jXkMCl
 jbN84GvH/MlnJotIEQZgTIxWByFE8O4o6om4/0wTCJzTzuaxiHcfMJwGy+UR47vUdXB+qmaMXIv
 CkkcCBseaLhNkk9YmALwULIk6g+vQRcYnDp/SrqfH7fg5NG3s14znkSg3ar8BzOHOXWZde2cWLI
 KQBr4eQU0Fa36EQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device can be unbound, so driver must also release memory for the wakeup
source.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      iio: accel: fxls8962af: Fix wakeup source leaks on device unbind
      iio: adc: qcom-spmi-iadc: Fix wakeup source leaks on device unbind
      iio: imu: st_lsm6dsx: Fix wakeup source leaks on device unbind

 drivers/iio/accel/fxls8962af-core.c          | 7 +++++--
 drivers/iio/adc/qcom-spmi-iadc.c             | 4 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
 3 files changed, 13 insertions(+), 5 deletions(-)
---
base-commit: a4cda136f021ad44b8b52286aafd613030a6db5f
change-id: 20250406-b4-device-wakeup-leak-iio-4457b99b6a91

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


