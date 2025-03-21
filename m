Return-Path: <linux-iio+bounces-17190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7EAA6C473
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6439D481A72
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E32230BD5;
	Fri, 21 Mar 2025 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPOtGyXC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5144A00;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590129; cv=none; b=EM6Ve5maES6vLqrMOWQV98dBfHNcWuYnaImGzPTbJXoKFsBwdzG7tXsTlscUZKsUpjIvXHcgm1ifyTli2m90QRDhaPFumAZg8eybRaBUbeN2oq/dJMoOP0pKFnPKYCI+E8GJOAaK0udmftWComelwHfvpRDxOOSqyFGUmdPNh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590129; c=relaxed/simple;
	bh=CpTm/Ssh7UmOqET4ZoOlwg+ImY4NAduCep5IKrVt6F0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uQKEAal8nLD4ZskkahVRvGzZImmrvM1atE5Iky58KHqIImfyJnv7WI8NolmMW0ThAUYxp9fJkyFJWPg+dQjkjhG07DpZmEG/UvAaAl/LBDhI6O0SDKg4TZUNE0I9b5ZsMYRt+BPcN6C0mHFGYy3cIXZ99pNZmhNLuoqNASPxG8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPOtGyXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87538C4CEE3;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742590128;
	bh=CpTm/Ssh7UmOqET4ZoOlwg+ImY4NAduCep5IKrVt6F0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kPOtGyXCQy2Yc7BkS47MZyVG8dEdvDZnxZYAG3B8IkR1CCOB6D5jVfsqkvmXQ5xcJ
	 9R7dybAze0p+PkrkGAK0KOuO6tFZZS/nOFXyEobUGerVBearLiw/d7dS620Ie9/lJ/
	 l1nrMYe09+sp3rygiToH8vo0WRU/FeWWXqiVrbbwsQ7ZH+DO/xPsRnXCASLaoRlwZo
	 DL3P3XbbkeKt65XvFqNNi/+FD0VUN5Xe4u1W3lHYLzzaddMGx1t/bx+rOOe1NfNK+y
	 2B4c7JFz7/DYuJP1ExuMx1kiXB1t4KBmrxzJjuIH+8XZs1QeVS9MXIOVzhVg9Gub/4
	 dHEhP760w37+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC3AC36002;
	Fri, 21 Mar 2025 20:48:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/7] x86: Kconfig cleanups and help text improvements
Date: Fri, 21 Mar 2025 21:48:42 +0100
Message-Id: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKrQ3WcC/43OSw6CMBSF4a2Qji1pL5WHI/dhiGnKRa5KS1pCQ
 MLeLSTOHf6D8+WsLKAnDOySrMzjRIGcjZGdEmY6bR/IqYnNQMBZZCD4XOb3GfRAhhdYQSNaZVT
 RsDgYPLY0H9itjt161/Ox86h/BIhKSlGqQspUZnmluOS9HtOns+azvK4O0uG9Ux2F0fnluDXBD
 v4/r7dt+wITVH5d2AAAAA==
X-Change-ID: 20250320-x86_x2apic-7e92d0f4c47d
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=CpTm/Ssh7UmOqET4ZoOlwg+ImY4NAduCep5IKrVt6F0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn3dCu7jynvXJK8lPJS6rk08IvynLIer67lxdKm
 KnBsXrlZ5+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ93QrgAKCRBgAj/E00kg
 cpCfEACDlc7AojeczQKU7Rbtzv5C9OW1PHbmmUkO/kclLeIxRlj4FEwSCmqUKbSsDgLXPT35xl+
 s4e0kajKOwaCE7BHBW0vlJsjKHpxOpMJH43hPLvsCoFzUpMfclQ6IJlktdZl3ckqPQAPnc1rr5B
 RtP+w/5sj8I+z513WpRM8Ta9WngD6LdyMsG3Cd83qWmVYsrftURiZH8j0ukWWoWj+Ekau1Bq4wy
 EPyrxqXGJtWpkqFmMiNQikO4fENYwYzynTnTE/XGGOSKL52w3Fv/yfy7YJnVHK2SsddSVu6d2GZ
 pJ+1YzdmfzjkH4fLMRmoPGuow01DYWjRJydkX4vgs/OgLI1rgnnOlRNyCVJfbUnM1KGvtuUU/cM
 s88ySZJ2cPQTEZDovxBoRfUjr3KEiXWuu5T/taK98wA2FsBYXtCdbnxDOJAHX3Wv+X7XydRo1nj
 tGlZEMCyF4ykoFtYhQe3pcyAm5HwE0ODvBFlLp1roDKw385mQq6LuGlWK0CgEMji49LEE87EFXg
 gneGtCI25l6A3sxISuYCYv/xdRrUNm78LDlaDwIUCYS1Y++mS7pzgEtH9ygMh/eXfckSJyidngr
 RTOKihB4C5lXSlFnadYozaUDSJZUYDhPwn094iGa61R8VjqEcyhPCCMdjJmTfoCH2MZHCQL5pzR
 ygzQhK/uzTmf40A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

I'm resending this mainly because of the first patch, but I find
all other patches worthy too, so here is the rebased bulk.

 - David
====

Hello,

There are some problems with Kconfig help texts in the kernel. They are
frequently confusing and use language that is difficult to understand
for people unfamiliar with the feature. Sometimes, the help text was not
updated after important kernel or ecosystem changes. References to
something "future" or "old" are also usually given without specifying
any dates.

First version of this patch series was sent out in February 2022.

Greetings,
Mateusz

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v3:
- Rebased against latest next-20250321.
- Dropped deprecated patches:
   2/10  "x86/apic: fix panic message when x2APIC is not supported"
   4/10  "x86/Kconfig: drop X86_32_NON_STANDARD"
- Dropped patch I was not very sure about, as there are other refs:
   10/10 "x86/Kconfig: remove CONFIG_ISA_BUS"
- Link to v2: https://lore.kernel.org/r/20220911084711.13694-1-mat.jonczyk@o2.pl

---
Mateusz Jończyk (7):
      x86/Kconfig: Enable X86_X2APIC by default and improve help text
      x86/Kconfig: Always enable ARCH_SPARSEMEM_ENABLE
      x86/Kconfig: Move all X86_EXTENDED_PLATFORM options together
      x86/Kconfig: Update lists in X86_EXTENDED_PLATFORM
      x86/Kconfig: Document CONFIG_PCI_MMCONFIG
      x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
      x86/Kconfig: Document release year of glibc 2.3.3

 arch/x86/Kconfig | 85 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 27 deletions(-)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250320-x86_x2apic-7e92d0f4c47d

Best regards,
-- 
David Heidelberg <david@ixit.cz>



