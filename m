Return-Path: <linux-iio+bounces-16456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D4A5433A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 08:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673881894524
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C281C7017;
	Thu,  6 Mar 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4RUG5vU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096B1AAE13;
	Thu,  6 Mar 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244755; cv=none; b=V1QudCxIZPWLwxm7lLuYnz14Hea8bM0g53osPXF8ReLt1ysbKIXMBG/NjDTStTpkm9psAluYg98urfQciO0SEuniK0NQegfSKrmWrQoyqq0Nfi9Dwo2IBfASRRSLStgGuCJHz5i3rd5n6V5c51W+jRQ2Qr7Yo4eqJPkPXj01v6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244755; c=relaxed/simple;
	bh=j9Pdlj4VRjam+HMpMP+9l4d9Wirj4tRY7kQm1QzX/GA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRyc91kugkUs/CHp7MFXtqC2DQ6cEFaRC0n2Zo779d2lbcfMdXVeHosEOV0tQpjllyWigKMhlWkoZxLBrwPhkEGRNfKB9CHM8fIlDBTiHNw0+MxIBkp/OZdejJxblWX3ZYSav2GytoYVMe0YVfX+5XiOnpC+2tO/zdqDebw8w8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4RUG5vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93BCC4CEE5;
	Thu,  6 Mar 2025 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741244754;
	bh=j9Pdlj4VRjam+HMpMP+9l4d9Wirj4tRY7kQm1QzX/GA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d4RUG5vUsosy2HxjD2BpjwunUe3VpgVi3MDnecVQ14O4qGQzpJ7xMjImjqp/O6YMR
	 1gunGmUoFe3+TK/CY6Rv6bAcdWdOVT/UNqyJzbHBkMni2ddBGdldK0hopnerpUGLrt
	 swb5vUrRFsOAMXb0xIDuH7TQSJrKX3bQsS/NTN3rM7Iz7zUKySbO93AVF37jM77iyL
	 fHNWiKuHnC2k2NqK+0J4EHwotOqvB94xF5Nx05b1zh+5N+KfAuZfArEMIwdn1Im5gj
	 A3ds4YM587Z9F6Zd5zYVUQbnx1mTDsMgGVhqHVDJPo6J4e5SU8X57ybg3qLSvndhsk
	 GH/YLiGtwN6Sg==
From: William Breathitt Gray <wbg@kernel.org>
Date: Thu, 06 Mar 2025 16:05:43 +0900
Subject: [PATCH 1/2] counter: Introduce the compare component
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-introduce-compare-component-v1-1-93993b3dca9c@kernel.org>
References: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
In-Reply-To: <20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org>
To: csokas.bence@prolan.hu, Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 William Breathitt Gray <wbg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2443; i=wbg@kernel.org;
 h=from:subject:message-id; bh=j9Pdlj4VRjam+HMpMP+9l4d9Wirj4tRY7kQm1QzX/GA=;
 b=owGbwMvMwCW21SPs1D4hZW3G02pJDOknPQNeRzyULZCda8dpJf+O/5/XJ6MO+1v2gtO4BWd+f
 fnyl0ZzRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRE7aMDOe85ra2Xl0imBW9
 7sXHxQkiTzQd/h3s3Sy26sfdXcq9l+cyMrz/fEpeuvqck3wS9+ZYh5buTYaJLgJyvkLnGh9quD9
 z5wQA
X-Developer-Key: i=wbg@kernel.org; a=openpgp;
 fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B

Compare registers are used in devices to compare a counter channel
against a particular count value (e.g. to check if a threshold has been
reached). A macro COUNTER_COMP_COMPARE() is introduced to facilitate the
creation of compare components as Count extensions.

Signed-off-by: William Breathitt Gray <wbg@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-counter | 9 +++++++++
 include/linux/counter.h                     | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 73ac84c0bca76e013f2534efc40c0f0e8d5fb023..3e8259e56d384225ec6e952b6d5d75208f185736 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -34,6 +34,14 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Count data of Count Y represented as a string.
 
+What:		/sys/bus/counter/devices/counterX/countY/compare
+KernelVersion:	6.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		If the counter device supports compare registers -- registers
+		used to compare counter channels against a particular count --
+		the compare count for channel Y is provided by this attribute.
+
 What:		/sys/bus/counter/devices/counterX/countY/capture
 KernelVersion:	6.1
 Contact:	linux-iio@vger.kernel.org
@@ -301,6 +309,7 @@ Description:
 
 What:		/sys/bus/counter/devices/counterX/cascade_counts_enable_component_id
 What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_component_id
+What:		/sys/bus/counter/devices/counterX/countY/compare_component_id
 What:		/sys/bus/counter/devices/counterX/countY/capture_component_id
 What:		/sys/bus/counter/devices/counterX/countY/ceiling_component_id
 What:		/sys/bus/counter/devices/counterX/countY/floor_component_id
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 426b7d58a438d59e5178bc5e76bac82e99737323..f208e867dd0f6995f58cf6a41c67538dad6428d0 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -580,6 +580,9 @@ struct counter_array {
 #define COUNTER_COMP_CEILING(_read, _write) \
 	COUNTER_COMP_COUNT_U64("ceiling", _read, _write)
 
+#define COUNTER_COMP_COMPARE(_read, _write) \
+	COUNTER_COMP_COUNT_U64("compare", _read, _write)
+
 #define COUNTER_COMP_COUNT_MODE(_read, _write, _available) \
 { \
 	.type = COUNTER_COMP_COUNT_MODE, \

-- 
2.48.1


