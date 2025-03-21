Return-Path: <linux-iio+bounces-17193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82464A6C477
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE06A3B2635
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C3230BEF;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5p+C3Zd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295C91E1C02;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590129; cv=none; b=UmhNH9JtXsrcEadR2PEUjhCvh5RMk/gO+rqUSKwCoo1+XPI9b8jS8Vh+lo1pDPc2LmDKEe+/ywOCZMz8CmGCqF9qNaG8TPBMZh2hCzSk/wmuxWsODLhlBx99iCrxDdSrS1IRXEoIVJl9Vh+d1hNzIIelsMMmZMkK3/PACsu9/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590129; c=relaxed/simple;
	bh=wybEI1jw76pvEX0By2A0+Zjf8Iv/OqOrlgu9WLh81Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pT9qp+p46YAwUCdN9xIhjq0sc6fNNJE9LLy+oASvtIY5FuNVf/5GwTz9OvQotbrIyniWoVUz/5QTvCEBNtwbl+3ORWhyYIfADRSuiAHAhjH5NoRmj2fnXmrTR9RrTvihqSBAdym3PC6k2+9No9ZcT5qiKfSVhCqmBvxsYVE+Ls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5p+C3Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6746C4CEEA;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590128;
	bh=wybEI1jw76pvEX0By2A0+Zjf8Iv/OqOrlgu9WLh81Qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U5p+C3ZdB3oZW9uIErHbnboDFCz85ZqM4YB1fLNKJbQXfMZEHuq9YLL+c8Zw92yOb
	 oDGuV/Ip2E44uqkL5nrJ2XP6U+vnDiQZZtATJ/eCHAwtEZkC/c53mmf8ZCUxPo7d6/
	 qRdSvfKPwv54eQykyABzYvpQOUQ0tRMmBo0yavNrAlPiL1/At/0gXvwgHpflYkpsIG
	 FQw5pHiT8L8JzrQJgajU+CmxcJEzfWaoaM8dpzgbdSP/fLuMxYeovAua/G1zuPM6lx
	 maVouDdB08rHbjBCFXTaTCDtJjcrVM5iyI+5VW5Ru5Y2oR20j4JFXHYeQkJHz8AiFc
	 IkQb80GsA1T7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90684C3600A;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 21 Mar 2025 21:48:44 +0100
Subject: [PATCH v3 2/7] x86/Kconfig: Always enable ARCH_SPARSEMEM_ENABLE
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-x86_x2apic-v3-2-b0cbaa6fa338@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=gBFoQ/Mwva6BqlKESKTHfSvabeRcf/AwbnhAOXp5CGU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn3dCuQb2kZ5vosmfdS0lmBu5xbidcEqsWd0qx7
 sBiVrjtvOGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ93QrgAKCRBgAj/E00kg
 chphD/sHnhrT5lKYoLP1lD5ks8ntjQlQanb00MDQ4O0VvLzDzi/DYI2S/89wQ8+sBhbXMMEfR51
 NoSxZHNG5b5nAyB/ymHNaVE0arQrMCTaHpLN5pr9fwe95aaVleN0Swf1F8cMMdp5H7uG5PzK1f9
 DUToZE003eHrY8komQjf3QqG0+4dizLp03NN4vdnhvjAfS6nxDy8j8RIUtJNBgYcOHoxeGbhcX/
 YOedr5LyGP8pgbA3lOQD3MdkTgIcwaSaTCmYL8gFmcy3sx257BpZ+i3PI6459s/+T3v2f8oh3yI
 yYqrxfJVK7weNw2aJFou/QgkHlVCHKEZ7AYLyMtp7jR1bYqTSDfqNZa+3jHn2mXxuL5jjV82o+d
 IpyKUM8lxnUQuN32b4PP3U+q+bgVS+KJZrID0yqbtYSWGUVonro+HSHHH36xyCn7xPHr+ticYIl
 PXkA1vF/wwZROSQpfcCVrk/vRtP5h3Q0g4jPPI+MhJjkFypazP5bbWR7i3yh5k5vhwJIQUYlDwD
 rI9sbKW0F6wWB/DRnIT30i6DGJ+ILcQ5hVx+i0w8E2j1uJGSMeXZBFX8dDp77L67DQC1RcTCbe0
 QQ0avnaCqdOMXFQIjGUGzrutuMamFWwoW3bBRGH6BvCNWj2a79NOcBg+E0iY3Il9knjywrhtl0y
 b1tT0OtiRkJcQTg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Mateusz Jończyk <mat.jonczyk@o2.pl>

It appears that (X86_64 || X86_32) is always true on x86.

This logical OR directive was introduced in
commit 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
probably by a trivial mistake.

Fixes: 6ea3038648da ("arch/x86: remove depends on CONFIG_EXPERIMENTAL")
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heideberg <david@ixit.cz>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 10f48afd67f6fd7d250f2effddcc5bc927b057af..38a915f739af45f1b23a197032ce6cff94fdd81d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1574,7 +1574,6 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on X86_64 || NUMA || X86_32
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
 

-- 
2.49.0



