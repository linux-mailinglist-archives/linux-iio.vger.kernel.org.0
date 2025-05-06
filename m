Return-Path: <linux-iio+bounces-19187-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE9AABDDE
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 10:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074E216297F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 08:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7192641CA;
	Tue,  6 May 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtRIponA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACC25E822;
	Tue,  6 May 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521635; cv=none; b=kftPzTBuKYdCkf9dV0HQivdCSZq3GIBTlaF/AcynaKKeWe3PaVUz4tRdfpz5N1MNhTp5HDEogwWjoeNOcKEH8fAERv+5NuxHRMCab4p/wzdnCr/t80jf/VUmiZLpwwxZStPBCyDn68j4iNJWhVv/Q4JwnMILykJ/74e/PEhO9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521635; c=relaxed/simple;
	bh=jn9lLGkSG4V3RG7ST7Gwm3kBhuCTAbYEo25iK3E0KCM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p37z2u9rdAYTaHGIkHWdkjsWN+EXNkVqd9r79xnjrXTi/QUwxM7P5hRcbikS3CDHQfNe+KOW/+AOUk8LyDl4Batx1PW6ijIQTNso8SImdk7UlfQETCT3FJlJIlv+y69ntzbjhTJ9uTaJqfH6hPz3/KGCai68jFHSVEWTY/+Ri6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtRIponA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5EE9C4CEF4;
	Tue,  6 May 2025 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521635;
	bh=jn9lLGkSG4V3RG7ST7Gwm3kBhuCTAbYEo25iK3E0KCM=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JtRIponAkT8pY5/4dDK4M7B8K+8C0XF8DI/3VDDpRoKu00Msz2XlIy3nhUMX4AAnN
	 hAqHjRUOf+s+CXgy5sAsPy15glLwpIyf6cJNU1AAE42KAvmUAckhwofbcj6bbGPem2
	 qTNSb1EeqzKnmnAYjz/JaFojdaFPzwJT2dgBuayv+S8zID/EP749mP9ZBPPFU/6kSf
	 hGNHxq+ORWQaQbGEgS8Kmrxld8BgOpOW6LuS9NdNNcNFBQreiq+ilDt9jhUcor+JLk
	 InC1j8yd2u/ObBYnFodqozjFDz7oma/2C5r+mLUZESP3UAacUOKBRAYkVub/ReYrzw
	 HT8ZTFjDzbI1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3642C3ABAC;
	Tue,  6 May 2025 08:53:54 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] Add support for the DFRobot SEN0322 oxygen sensor
Date: Tue, 06 May 2025 10:53:43 +0200
Message-Id: <20250506-iio-chemical-sen0322-v3-0-d6aa4acd00e0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABfOGWgC/4XNwQ6CMAyA4VchOzszugHDk+9hPLDZQRNgZjOLh
 vDuDi7GgzE9/U36dWERA2Fkp2JhARNF8nMOeSiYHbq5R0633AwEVEKB5kSe2wEnst3II85CAnD
 rtDPGYFOpmuXTe0BHz529XHMPFB8+vPYvqdy2f8BUcsFbU2pZS+dQwbmfOhqP1k9sAxN8kDw/E
 MgIlI1qZKul+UbWdX0Dd78Xtf0AAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746521633; l=1219;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=jn9lLGkSG4V3RG7ST7Gwm3kBhuCTAbYEo25iK3E0KCM=;
 b=zzKWNLKdpwAFUG0SCqPlYIR+2sJPsAXk73dOfjot8Z+i8Z6zUF4Gnmj7zrEZ/VdWRqxc+ki5n
 wfvW5DQqeRNCXqxK/oIKVvR34nwvfX4FS0GRZUbv23zPman353F562M
X-Developer-Key: i=gomba007@gmail.com; a=ed25519;
 pk=iY9MjPCbud82ULS2PQJIq3QwjKyP/Sg730I6T2M8Y5U=
X-Endpoint-Received: by B4 Relay for gomba007@gmail.com/20230706 with
 auth_id=60
X-Original-From: =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>
Reply-To: gomba007@gmail.com

This patchset adds a driver and the documentation for the
DFRobot SEN0322 oxygen sensor.

Signed-off-by: Tóth János <gomba007@gmail.com>
---
Changes in v3:
- Refactor based on reviewer's suggestions.
- Link to v2: https://lore.kernel.org/r/20250505-iio-chemical-sen0322-v2-0-217473983b42@gmail.com

Changes in v2:
- Add SEN0322 to trivial-devices.
- Use _RAW and _SCALE instead of fixed-point math.
- Refactor based on reviewer's suggestions.
- Link to v1: https://lore.kernel.org/r/20250428-iio-chemical-sen0322-v1-0-9b18363ffe42@gmail.com

---
Tóth János (2):
      dt-bindings: trivial-devices: Document SEN0322
      iio: chemical: Add driver for SEN0322

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 MAINTAINERS                                        |   6 +
 drivers/iio/chemical/Kconfig                       |  10 ++
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/sen0322.c                     | 163 +++++++++++++++++++++
 5 files changed, 182 insertions(+)
---
base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
change-id: 20250428-iio-chemical-sen0322-cf8fbbbe7546

Best regards,
-- 
Tóth János <gomba007@gmail.com>



