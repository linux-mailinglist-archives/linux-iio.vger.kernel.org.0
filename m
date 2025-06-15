Return-Path: <linux-iio+bounces-20682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30248ADA210
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D576016D913
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F297C13DBA0;
	Sun, 15 Jun 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8aKpADm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8B1E89C;
	Sun, 15 Jun 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749997685; cv=none; b=s+PASfGdVU4+Uapia5zp0YcRM/PxLNPznQi8RjUT0iZyN5Hpa1a569LHAfMGTzA+1l1r53bLXAl3Q85mU7uTh9nZZCC6WBJARFgEbct5EKlrI/lMAXvjipGfaaJAP7eVHcHCqjwyPWzL97dqvBDfnfl7Ne0aJz2oRim8nPx39dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749997685; c=relaxed/simple;
	bh=6ObUhH6Z/DbZj7sOOb180am+Eh1jhL7E4Y+59Wc7eWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b3d3AXAIf4i8aqekt4rGH3B2OiPXdKH6GhweEbbUhxV3GuNi6DF+2HnV0EUIHOxhXrcMJlUKAc4iN5GGY22RHSWK0HPzT5K0xL84OdSJgkcqCWydJYca+P9JVnWz4H7LkQTCI0ILn6k4QrnN5Mu4Q70Vq5/Yt8oMqJdc93dDs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8aKpADm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A5AC4CEE3;
	Sun, 15 Jun 2025 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749997685;
	bh=6ObUhH6Z/DbZj7sOOb180am+Eh1jhL7E4Y+59Wc7eWw=;
	h=From:Date:Subject:To:Cc:From;
	b=i8aKpADmE4Sjf7WdJ0NTmMUp/9aqxQs4nDfcWsIZ6Os/KgLHrADOH42FYAK6EMuUP
	 hwZKMHxvN9yHZ3d91CMsR+9CpkHeIUX3XyfU1fcxUHSd1dH0ySTX89kIp7wGQJ1gVY
	 TyEaYcPs3tPprtBTmIgtCDJw/tnhzy3at8TWeQ3hPUXj/k/5b6I6V04TssUss3Tmfr
	 HkFtPYf6QaKUj0iBHETKwtZxyEK9ElSiW0As/k/5jfVBAsThNxP8vhUsrPaVEwPbxb
	 WUubaIYz/0Lcij/eNEJrxKLbW+AxjJGoAyC6r2TWIslrf8VGTOVt2mBnaOvxrCCpwb
	 tXwLf8Ji5YLvw==
From: William Breathitt Gray <wbg@kernel.org>
Date: Sun, 15 Jun 2025 23:27:47 +0900
Subject: [PATCH] counter: Alphabetize component_id sysfs attributes
 Documentation list
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250615-alphabetize-component_id-doc-v1-1-4c5943b41198@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGLYTmgC/x3MQQrCMBAF0KuUWTuQlMZSryIicfLbDmgSkiJi6
 d0NLt/m7VRRFJUu3U4Fb62aYoM9dSSrjwtYQzP1pnfmbB37Z179A5t+wZJeOUXE7a6BQxK2Mgw
 TRmucGGpFLpj18++vt+P4AT+SSsxuAAAA
X-Change-ID: 20250615-alphabetize-component_id-doc-1c449e7105c0
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, 
 William Breathitt Gray <wbg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=wbg@kernel.org;
 h=from:subject:message-id; bh=6ObUhH6Z/DbZj7sOOb180am+Eh1jhL7E4Y+59Wc7eWw=;
 b=owGbwMvMwCW21SPs1D4hZW3G02pJDBl+N0p09vx+NKn91f4KLlu9PWHJf9+7vp0pfL+lN0Qls
 HX9nj6mjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAipssYGRrPPm/Zy8jg5+k5
 Z0/Likcf6nf9P1yV/PxCep2o+RG5e+yMDDeX9vIXNTw/Kljj32lofdGtIKRdcOb1GTquKmzP3T4
 zsQEA
X-Developer-Key: i=wbg@kernel.org; a=openpgp;
 fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B

Prefer alphabetical order for the component_id sysfs attributes list in
the Counter ABI Documentation file. This should make it easier for users
to locate a component_id attribute in the list and its respective
Documentation entry.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 3e8259e56d384225ec6e952b6d5d75208f185736..3e7eddd8aff3def02f1611e96ae638e415b64ae5 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -309,26 +309,26 @@ Description:
 
 What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
 What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
-What:		/sys/bus/counter/devices/counterX/countY/compare_component_id
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
-What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
+What:		/sys/bus/counter/devices/counterX/countY/compare_component_id
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
 What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
 What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
+What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
+What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_id
 What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
 What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
 What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_component_id
-What:		/sys/bus/counter/devices/counterX/countY/num_overflows_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
+What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/polarity_component_id
 What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
-What:		/sys/bus/counter/devices/counterX/signalY/frequency_component_id
 KernelVersion:	5.16
 Contact:	linux-iio@vger.kernel.org
 Description:

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250615-alphabetize-component_id-doc-1c449e7105c0

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>


