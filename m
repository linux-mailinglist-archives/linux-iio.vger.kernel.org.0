Return-Path: <linux-iio+bounces-16579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973AA57DE7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 21:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F781892ACA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B5420CCD8;
	Sat,  8 Mar 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzj8uH4D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD9202C4C;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464150; cv=none; b=jnFCEw9uKAMUhkLcmXwWKeTM4eIPxlm/KCM7snoIzaTjWZgehUX82HkL28b8wibWh5nGRPms3H/FxEj9JmQrrVcCexX0H3lcEkBcVxsyP3mofktmLlEwcqYoSGgnV3N69mKWtuLHCVPShIABEEmKX/Cau63/VVpV+O/b6jQRJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464150; c=relaxed/simple;
	bh=xIt64jlNGpBSjIB98ZPKMCJdRE0k8D6fCTj/Gx8DeCY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SrnjwkpuWhfuEam8PFmtRzUMskgd/oLiUFsbQBztj3ESleWAqgsfHm7/sLwl2lrjIrEY/K8oqSHgvqyjfcFNkMvUNdwPzvLhDyoAAaKWMxmIjRO0Cj+K/nZOyJ3ziUr2N4nDVVFNbeOkhdFI1ngtgP5RufftiiAg4yJSxHLWkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzj8uH4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 028DAC4CEE0;
	Sat,  8 Mar 2025 20:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464150;
	bh=xIt64jlNGpBSjIB98ZPKMCJdRE0k8D6fCTj/Gx8DeCY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Vzj8uH4DqiGsFqPjcre5jhca46vkbbQw2Ka1ZVKd4RUPDnibMwEOA40EhmnxNF4YZ
	 E0xTMWDxDiS3rS9fKQI7PLtbSac+C4/ue42q/uCcrZEaAlTQYD7mondwDiHOMoJDTD
	 DIai50AGo8SsU7eAc7SewMQ7u/5Kc2vFjpcVYd9zrQEE34OQuaUUx5bZD7HbfrYrMe
	 Q27hjpHI2j9B38LnoKfqls1qcDPvJP8i5UIAqGXRNdzaASPcwWg5x9/tTgYH2FIZcr
	 s1GFpk0u7oxNF+fNnBM2x5cHGl3cT3phJptaWmAitsdnScTCHO1ntEx9oZMGc5We36
	 BXE1pf3IGMAaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE379C282EC;
	Sat,  8 Mar 2025 20:02:29 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH 0/4] iio: light: Modernize al3010 and al3320a codebase
Date: Sat, 08 Mar 2025 21:00:57 +0100
Message-Id: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqhzGcC/x3MQQqAIBBA0avIrBsYlcC6SrQQm2qgVBQiiO6et
 HyL/x+oXIQrjOqBwpdUSbFBdwrC7uPGKEszGDI9WXLoD0uaUCRh4e30Gcm6wN4Oq+sXaF0uvMr
 9P6f5fT/hyCVUYwAAAA==
X-Change-ID: 20250308-al3010-iio-regmap-038cea39f85d
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=997; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=xIt64jlNGpBSjIB98ZPKMCJdRE0k8D6fCTj/Gx8DeCY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBnzKJU2gbWxDF2He66jbsu8mFd4x/eox6lMFhPZ
 1tgeBFu1ZGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ8yiVAAKCRBgAj/E00kg
 ciySEACdR5M+iogGs02Zrg1ntWq8dguVm0uAhaOnEkpbobf8rFhLxDwNHDGmnO0XKkPY36okJ7A
 zH2qUWo41lYRtkrPu/t/Q6aLyWtF1hA/b9Wvn1ShpH+aZuv9cweQg7NyRCl9dUWFqqk7Js/vHCP
 xSEUzZ7pFR4Peh9HER7/2Qj/J61tEqRRDdanJmfbokSUGvKajlb1+TC9HsnVkS3aQPLuPMWv3B5
 UXuibBOLV6tZa2YD8zYQX09+rXjd0v5XyMsuJprlFdIDcDxCu9deO0E7sjyp3FKFfvAQgZRRWBT
 pSsalpHOcqcS8KOM0lodG63LQr7yHmZ2rmtAWLnkEBsyMvjvRJvysMK7KFdhR+daGS3k7Y918aq
 S8MqNy6hY9E47uslQZBKRE49K1UTl/010tA5ml7B5YM2Wt5yXgcC2HeBZPA3CTYOiZ31yhyl9wF
 ZtEqhd3qo/3o5XQz/BW8WbxAoZXOTAK31SEbWABLxNMBae8U+4WL9RzJrbNAv5D6yVEz01C8/N7
 PTubS511rlSIwSREyic9WN7vGhKyJCq01+DyqgAT/f89P+1srFZgaVrnoUk0gUKQm4tLsou7wuv
 okH+I/nw9SmsRtCPiPXdxfTVnP8Cy1FUKWnbbBZinOCM29yUm/ON5hGdYSJa1DXgJ5noTjHiXit
 Avhx4fP+Lk2Qm1g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

This series targetting improved readability of code
and modernizing code to match today standards.

Except slightly improved error reporting,
there shouldn't be any function changes.

Size before:
72224 al3010.ko
72744 al3320a.ko

Size after:
58032 al3010.ko
58632 al3320a.ko

Signed-off-by: David Heidelberg <david@ixit.cz>
---
David Heidelberg (4):
      iio: light: al3320a: Drop deprecated email for Daniel
      iio: light: al3000a: Use DRV_NAME
      iio: light: al3010: Implement regmap support
      iio: light: al3320a: Implement regmap support

 drivers/iio/light/al3000a.c |   6 ++-
 drivers/iio/light/al3010.c  |  95 ++++++++++++++++++++++------------------
 drivers/iio/light/al3320a.c | 103 ++++++++++++++++++++++++--------------------
 3 files changed, 114 insertions(+), 90 deletions(-)
---
base-commit: 0a2f889128969dab41861b6e40111aa03dc57014
change-id: 20250308-al3010-iio-regmap-038cea39f85d

Best regards,
-- 
David Heidelberg <david@ixit.cz>



