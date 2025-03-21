Return-Path: <linux-iio+bounces-17192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84535A6C474
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008C8481955
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0A230BED;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olQGewil"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295761D5CFD;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590129; cv=none; b=CTXBE7jbUDicRhAgI2/u/3/+cRap0v6vZcVyFL585K90ZioKY0364jk6N8nt2Bhv4+pt0clPtv+E9Mk6H0wJ3HlFtljcp8AvvfhYJ4Cp/WtHH2j9ETbG6nZE6/LThB6DNo/ZMjurP8KaTAGdpdudkzA/nqavlPDsN88cK9meghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590129; c=relaxed/simple;
	bh=Sa9bRM4riV9NIaLnG6db+zNr9/vUREUEszuIWeMOixA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qlyltpqXsxUFSnOTSRAiXD9qmBZfA8MIc6/Zr5Rpxsu5TtEIiDlMrj9/H6IVk4Fv+GnUgvYkEPCkCJL/iMWe8kp5AE6a0F2YiJmwpNnCmquiyPekpZcrSD5JEtbH6nhMlu7wNEKKqQFV11QN4aPBHFaifkkUBhcoY1tihQIeSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olQGewil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEDDBC4CEEC;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590128;
	bh=Sa9bRM4riV9NIaLnG6db+zNr9/vUREUEszuIWeMOixA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=olQGewilN6VqYzDzjZNc9IPHee6kd4o+t3L5qvJI/03SdtuTNA+hVYGCIIIlOczDP
	 mvIzW0I7wMN3rthji9pbNl/y6TEKQ3Clqw+fyQq82Ku0F9R5UHW7/iFQmuMOJifKPj
	 YDuNZ5pJhpMSWAE8xlqCq9VUJTum+SGu93ac/R2KOtnwu0kScu6Iye8VQeol3z9ri8
	 ptlRbcnZMcgUZzW6jfUsHYa/vo4jy3YMU5a8eq9PF5iI2NsBDVDLmd3jeGBpjTK0et
	 ThU+XvVWnHv3fv1NQIeKd1e/NKnjVUAMNty2XICZPkKrMPxjJfmYJRBqTxdaCLY8Ft
	 t68wkJpAN1b8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0386C36007;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 21 Mar 2025 21:48:45 +0100
Subject: [PATCH v3 3/7] x86/Kconfig: Move all X86_EXTENDED_PLATFORM options
 together
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-x86_x2apic-v3-3-b0cbaa6fa338@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=51c/Gs0I0J1wJoEtVvTIk8/MWpkL2eyjSInCszhj468=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn3dCuwOuK64hfcf7R2QE3YAT0lY+6Oelez7pDf
 JxQe6F2bFiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ93QrgAKCRBgAj/E00kg
 cgO3D/4pWKx9KjeMiaHWROemKqSuG5xlScxmTbFuezCyyc57EgB9x6sxlndj70T4aaYgj9/18xl
 EnuAb3RPYO7oWEFFza8U3CKko+i9GCEYwZrSnT7NDMr1dFjcTtaOlzHCb9kcPoKjAAYO+shWNXy
 OcjEuNsG2qBkEpMsb0LrTAzXUxLoMQrcfs14S94qpC2vPirb2rznBk4acrRxWxpM3L2Ce6gVM2s
 FLAiAjJk+Xgun3Z3mZjHD6m0jGlVrP7+YdBoWbacphK8+fFFtxZLOl4D2Mx+gMVN62g1kp5E2+U
 mztQDh6bGETmRnNI1zTrX2x69WtWKtxQ7ihSnG4eC9apmKaaTAsNTtjbJb9CwjMWrZX8baLkKiE
 /3pnNDgS98yMh5tbyFUZXoR37Q2gzaVCdZ92mhXkYneTAFbEMN7DEMVxLsqUXV7dXpZXOLKy/IL
 iJgtl0OKxBVdzADj3zSvAmNkyA8M0iEdNWLhVkzpOOD2N+wE9M/sswpd3J9jh1ZNiYklPZ507XX
 FjdLASOl962aBHt4SvoqNYwpQATzUgncx1lTJCNivnH1a0X2ceqjcCQgpodG8+tyPo4sI4veBOL
 GdGfqzwKcODH49y/Ffqwo3HYcw5ockXmJLM8QgtX79Eu+sVEwSwzETjG3XtyVkx56Fiz3Meri/+
 aSXl0cDeI1jP83w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Mateusz Jończyk <mat.jonczyk@o2.pl>

so that these options will be displayed together in menuconfig etc.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/x86/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 38a915f739af45f1b23a197032ce6cff94fdd81d..9e5dea7c9fd7aeceb727f4c372c8880c9182f7f2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -676,6 +676,17 @@ config X86_INTEL_QUARK
 	  Say Y here if you have a Quark based system such as the Arduino
 	  compatible Intel Galileo.
 
+config X86_RDC321X
+	bool "RDC R-321x SoC"
+	depends on X86_32
+	depends on X86_EXTENDED_PLATFORM
+	select M486
+	select X86_REBOOTFIXUPS
+	help
+	  This option is needed for RDC R-321x system-on-chip, also known
+	  as R-8610-(G).
+	  If you don't have one of these chips, you should say N here.
+
 config X86_INTEL_LPSS
 	bool "Intel Low Power Subsystem Support"
 	depends on X86 && ACPI && PCI
@@ -729,17 +740,6 @@ config IOSF_MBI_DEBUG
 
 	  If you don't require the option or are in doubt, say N.
 
-config X86_RDC321X
-	bool "RDC R-321x SoC"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	select M486
-	select X86_REBOOTFIXUPS
-	help
-	  This option is needed for RDC R-321x system-on-chip, also known
-	  as R-8610-(G).
-	  If you don't have one of these chips, you should say N here.
-
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():

-- 
2.49.0



