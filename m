Return-Path: <linux-iio+bounces-19191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E37AABE0E
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20384E1360
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE78264A96;
	Tue,  6 May 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTjHy2i/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AB262804;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522092; cv=none; b=usKLGjk5Y/VYhAMmjZrmnkeqN84BVLC1qggnUumYdtLrWjjNMXE+4fW5WoKAu4jm2OXy9NYTs8kbkQ80ONJrYCSCU9Xe609lg0nEeGf3LysiqwZUVLDpQhT5gzZ8kaDScGEY62dFkkKv0TErlCuGnsWxpGDzDo2Gl7MtO6rybMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522092; c=relaxed/simple;
	bh=qzv6l2KM5Wphcjtib2A3o4KbnGRwbq7CbmvfYDGYewE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HPhiExEW9ZYrZ8wlc41o/4NlGbZHakwzBlsiKfKE+rxuw95Z4LICjRY5dlQ0dKKueMbhrtad9SeQtOrCkjUlDqUoWlApKVH4CVAGCHUAHfmEmBZRCmbMB0rW9/y66lmbygDh9oVT1/8fbbaWJirV/UoIcyBEeD3RuUIe/9fCkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTjHy2i/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 532EFC4CEE4;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746522091;
	bh=qzv6l2KM5Wphcjtib2A3o4KbnGRwbq7CbmvfYDGYewE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uTjHy2i/zFbGh7G+LnhpBBFUhseMZa5r/7tdUXiqe4v5SibZdb94/DsdnrQ2i03UC
	 /jQWLDtsZFSzUNDTG/8QkOVjZiTkLx2xsfZ012w1Z7UNGoYiI9pjEIPq4Kcz3B0Dm4
	 1NXP40hSnsAS9lm//dOJtr7J3/r0cNwJ9PH7DUxmvzqyRHZbVAhbDXaO+xrqNIyKdf
	 nHl+DPyKipCCyg1jr9Nlio32CkBCbboUEpNtb6zRtoD81DCn9eZ0GbQlqGK7tDQ7IF
	 NApKxc8zmNR70M6OldsYbIbTal1YZ/1oSqvOIsveB8Q++fyw0LErKJbLdk9ZnG3dJC
	 pyMj/OyR7XVoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ADDC3ABBF;
	Tue,  6 May 2025 09:01:31 +0000 (UTC)
From: =?utf-8?q?T=C3=B3th_J=C3=A1nos_via_B4_Relay?= <devnull+gomba007.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] Add support for the DFRobot SEN0322 oxygen sensor
Date: Tue, 06 May 2025 11:01:14 +0200
Message-Id: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANrPGWgC/4XNzQqDMAzA8VeRntdR0/q1095j7NDWVANqhx2yI
 b77qpcJQ0ZO/0B+mVnAkTCwSzKzEScK5IcY6pQw2+qhQU51bAYCMqGg5ESe2xZ7srrjAQchAbh
 1pTPGYJGpnMXTx4iOXht7u8duKTz9+N6+TOm6/QNOKRe8Mmkpc+kcKrg2vabubH3PVnCCLxLnA
 IGIQFqoQlalNL+I3CP5ASIjUudaK21rIVDskWVZPgvMSmJCAQAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746522090; l=1369;
 i=gomba007@gmail.com; s=20230706; h=from:subject:message-id;
 bh=qzv6l2KM5Wphcjtib2A3o4KbnGRwbq7CbmvfYDGYewE=;
 b=kH8fyDbLAb2/yZVekSxOK6vqYdfb/tUIuru8yC1sMOijqB1MmJz/fjLonvGuU+dYewRNH21pe
 zIZ2N72O3bDA28WhS4t53g+VxQrdJSeYNmcARn8eIATCtMkJZ6Y2UIQ
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
Changes in v4:
- Collect code-review trailers.
- Link to v3: https://lore.kernel.org/r/20250506-iio-chemical-sen0322-v3-0-d6aa4acd00e0@gmail.com

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



