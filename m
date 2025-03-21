Return-Path: <linux-iio+bounces-17196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C9A6C47B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D13B40FB
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA94C231A3B;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3mpYqj9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66F230BE8;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590129; cv=none; b=FWfySxisPKyaySU5zuflv/chNdDKwmMXMIhJdK0tXwMNmaXVkdnTCEoWWNPcWpkwc0kBiQWsHXFLmctj64KrfpFtire5WLh0QJfLI/LZ2SeanstDjOZegpQFGJQRwnAon8JNC3XtosHGVDvv3jNuCuXa3ZXjVidbuP08IUOvXEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590129; c=relaxed/simple;
	bh=9vnz/akLd788rW/+IZt7E4lkjJH+d4qQiNsJAgYFjns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaLGP//rCe1aVjW166X06MoaYkxN0nqxCV1KSJhjfP/WEHtcgx94Cd2PnhCdfr7dlz+AUOUJsXeYFXvu7Pg/+sgQIA893JsgQOK3YwsH2QQQFMRExWO5Dfc0wOIZe109aoklDd7t/MTEscW7TpAgl7sf7VE0gf9pgpLjkJXNTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3mpYqj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4757C4CEFA;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590128;
	bh=9vnz/akLd788rW/+IZt7E4lkjJH+d4qQiNsJAgYFjns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n3mpYqj9tFsrRmBQ2hl5A7DR0ZeYDp0xyepQl2TY0iqqBRSe5vhysFgA7ZqTkpJkd
	 55NVV4zBzkThhy+CHTO+36L+1V9AKw3FJI4BDLDxQET/Yvnv8AMkevGHWjxT/ZES/C
	 4B/4tG3GiOmyzGpvy1C3sbyEMdlxfMc8SxI7w5yCDeggj5qFyIL+vK+3kxhP1f79v2
	 a3WtdM++xacb44l4fGPNxfwonZam9YhNHavEs0/K7AgVdvSfC4yYZO9QbAVok+pa4F
	 wARGBt+gNXwcWSG4pPyGL7sqPIolG/bIgs3gLfV4KmB9lJxMnwvXCjx3Ep9kNBGS3z
	 bT+6PHpeYZJIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA469C36008;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 21 Mar 2025 21:48:47 +0100
Subject: [PATCH v3 5/7] x86/Kconfig: Document CONFIG_PCI_MMCONFIG
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-x86_x2apic-v3-5-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
In-Reply-To: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kees Cook <kees@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
 linux-iio@vger.kernel.org, 
 =?utf-8?q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Wk/lNByjM8U8pBa5Ev4LNdWk6Mu/MLaTMuM+X8ijgiU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn3dCur5z5xbIM6Vj2mqrfW1IC8Kk112jMSEJlL
 9REVC+he/GJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ93QrgAKCRBgAj/E00kg
 ckQDD/0cjn/rv15TNepea/LN5OSmUsvz1KkEO9p5surgD2M2+pPeUuTu1SnmFBRzdrRXetOJqzs
 oK3IntTPEq2ZDf3ynxV2H6fXjfdPr1cvb6gsO8HP8mpYuCUEI10uti8a0iv+p0jEwh2zzJhtTZ8
 HZS3067Oz7z5bcK0McMBBG+nLkdeGg5rwCIs8e7U1LuRsH0bDa0BXp9rA6KKK+3kuizFBEETtKO
 iH0db+yFwbiEd3WJS+rWVxcDyJcpvVa+/ajd1gPVMvgjdDK9Yb2K8okUUtHyTaJVvbmy+9mLvaC
 wP3f4fLL5zXak2gfan0T53XSognvmXLcWRipLFEx4aaaCa+Ysex7X+Y4Sr1OiNDfQqj0ld/kE3F
 nhjnaQspSzAwh5CKXt/iEn4KBjjaVP+QwQb18+5NsN9oqVM8NTuZxTLuzGool4FfaOnV+1iP8DQ
 MSBxeKoE5DuHoo+QnixKx7LMFGpfT5Qbf4Z9728hheIDMxyhpp3sfc6U//+YMdJbxsNh1Hl9Ngi
 7do8AgglsB43/B+MsBoM5n0We9uG5WEZV20YdXpjakMurLwAhNIbtJV0nqgzUxWHyknyFIAuAX3
 v81gCuR1ekowhRbgkccgsJYVsAh3m2MA3GxW1bt0yYGAQubmRZbKWrnXwaM3Kglbra/ArZRhqY3
 dOW1rxWrzMruKxw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Mateusz Jończyk <mat.jonczyk@o2.pl>

This configuration option had no help text, so add it.

CONFIG_EXPERT is enabled on some distribution kernels, so people using a
distribution kernel's configuration as a starting point will see this
option.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
---
 arch/x86/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fbc9ba30fd1cbfb574399a0632b9f77876ba84a8..64a1e00619df95f559488e3004558a7b0f653df3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2914,6 +2914,19 @@ config PCI_MMCONFIG
 	default y
 	depends on PCI && (ACPI || JAILHOUSE_GUEST)
 	depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)
+	help
+	  Add support for accessing the PCI configuration space as a memory
+	  mapped area. It is the recommended method if the system supports
+	  this (it must have PCI Express and ACPI for it to be available).
+
+	  In the unlikely case that enabling this configuration option causes
+	  problems, the mechanism can be switched off with the 'pci=nommconf'
+	  command line parameter.
+
+	  Say 'n' only if you are sure that your platform does not support this
+	  access method or you have problems caused by it.
+
+	  Say 'y' otherwise.
 
 config PCI_OLPC
 	def_bool y

-- 
2.49.0



