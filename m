Return-Path: <linux-iio+bounces-17195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E9A6C47A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3433B4029
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA741231A37;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9JppLeC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BF230BE9;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590129; cv=none; b=isjZNztWQbuY/jupwOhHfLBFSuCIYykMU9/CM9GrI7rB8zQBUu00B1Sb/nvVcwYBTeT0d0ex99DVVKKY76m5n+h4ngsJxTEFmRUTnHDD+6NqUsRdaZu42wLrhBJ+GwA54Wa74CkbFwCf87Sy0+G6OuQGZhyo7kylRd/pdqm0Rl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590129; c=relaxed/simple;
	bh=NYRafMSdGbGHF2wgz3nyBIvLnZNYTCdkh/71MBOgJdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyAcTYihcbjfLcYXFEItzm69JPSXfZrN2dOKOkeFhHRe1wLjoIlKLD/HACPFYEA1pZHm8uJ2SL7ucXlS0TqNVlVr8WfXxsXDkX2h3VClFF7jrMiWftcJ5Wx0+d+HnsYL49v/OLofvsKWW9hKNQM9KFEh5idXhoxylZKB/WNJg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9JppLeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D4AC4CEF2;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590129;
	bh=NYRafMSdGbGHF2wgz3nyBIvLnZNYTCdkh/71MBOgJdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L9JppLeCto8aRVKMPYoHs8Qx+CA1cbOP/TG8skcBiOLmeLv/9Ix+8wFxwoLCEQNSL
	 ogq4gfqU5W1k7uwthBjbicjlwltUVpSlkT4BpWKOdzJjyTJQcBDd5j9BEvA7Sn+n28
	 c0l1mnsoRO4297q6D3pb9qHdZzd8cUbrLVzCWcng2eh+nEl+5dXkXJ3GXlQp63t0mU
	 H8/4E8YkQcWy3XclPOqs3JcHlbnCWXwEw16VduLRwn3SnotVEwAgJi9uL2PBSxj83i
	 ja5pU85Kpldv29rS9KkLEs9SaWHM5QWO0IjTJz1DERAYZaMSa+jkmytH9+cKkyP8qN
	 inrFVw+PcKy7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65BC3600A;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 21 Mar 2025 21:48:49 +0100
Subject: [PATCH v3 7/7] x86/Kconfig: Document release year of glibc 2.3.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-x86_x2apic-v3-7-b0cbaa6fa338@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=9OvHfX7hjKPWyoFcg1JfBC1j93k9cRQ1pVfK3nHdJAs=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn3dCui3quEeZQO7ntSazprt9cEZVgq81Us4dJa
 OTGelM2MDKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ93QrgAKCRBgAj/E00kg
 cniOD/48XqqJrrrAlESfe/SxdiR6zjYr5kHsGQkEcmRkUnYaP/g5B3MKUkMr7aAcgXKHbVEnbVO
 SInWdtQ6aGqNpatjC4G4CeEiw6MEqaRNrJbYYKsvarFpRSvfR2WBCCc4+HwYqK4NfFrUeH5P1kg
 6ZQSGWCcnSuVoyMlw22owOb3NMaEHqXKFvsn3PqJNVIlzcu7s9cqGezC4Jjh4wzdYp0nDoRBcZA
 IhE7c5mG8JnDK5P4Y1M4dAyQ14Klp1YbLHh9a1OZJnbSNNL2g+hTvVH+4aN+YLrn/qn6ieQxopl
 Rq2ywqWI0seE54VsCp8jsM00FrFq6d/puV9qxZpK+CFZ9YY/nPIVmP8CnekzdgecFwkwIcZSKpr
 NMxOTPgarQOoYZ5FqlysJ4goTDRq0oIk3IMESK6GVW0Fc1HtqLDtLLfVOfKnlHIyIlzTdCxOdrE
 0HMsi5+MOoOpTwA03izg0aXKhbVpzUroRpPraqbkIfjJXsbeH5+TN6c/IPharOUgZtIY1/KA+CY
 bIDVvzL90uhYHGtUqB/4Q9y0bYFI8pBKwy/0nnQo6dsGIfrpEdm9kHy79fgYbhikIdtJRspfvZz
 bwgEFEnqHraG2vZYDIOwKHj6/me8b4Mki9P4bMhzXeUCpGIGYwalRKI7zFLjeOTZ4xQzwzLC+S2
 kn1fpdXFwpseH9Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Mateusz Jończyk <mat.jonczyk@o2.pl>

I wonder how many people were checking their glibc version when
considering whether to enable this option.

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba6ba3a7011554d9cb58fb0acf48d541da8ed69b..22dd962f8e5c86741a512e12596bd940cd1dae97 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2225,7 +2225,7 @@ config HOTPLUG_CPU
 
 config COMPAT_VDSO
 	def_bool n
-	prompt "Disable the 32-bit vDSO (needed for glibc 2.3.3)"
+	prompt "Workaround for glibc 2.3.2 / 2.3.3 (released in year 2003/2004)"
 	depends on COMPAT_32
 	help
 	  Certain buggy versions of glibc will crash if they are

-- 
2.49.0



