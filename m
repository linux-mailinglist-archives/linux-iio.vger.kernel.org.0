Return-Path: <linux-iio+bounces-23345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E30B3AD5A
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 00:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F22A1C86AFD
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 22:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0522609D6;
	Thu, 28 Aug 2025 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="fBZWGDY4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAC13FEE;
	Thu, 28 Aug 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419501; cv=none; b=gdObfzHhwSbvFKFS4g0El+sEYsUfD3xGbBBukq3EXtxYgaliZOoHFkuUUxU9lKISnOE77el6jbHC7LQ7nMmEEdLFrMZTMEa7p2hMnquYpOp2RgQe0RARe+YePKRSJODTYZePUdvo5fX4oVniZcetYPKj6yjea67zAk1bHtvVVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419501; c=relaxed/simple;
	bh=fdmPzeHJYHHuG0oPTtGVH3qCVnuoCo/RhPfd1QjQFPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PtZOnguAlMNVH9woFeixw7W5uz0TMusBxHWpshlYutFarHIrJWGXTMt1lAfoUpfZ3ySLJ6RXS+efIeKy795r4UL2g9gan9jtcTAomdLsNwFmvKacy3ZW6NpkQ1PkFAgv4iOwTHltTh9t8r4D3y6P5QdQ34scl9JCHxBvC1gpv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=fBZWGDY4; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=qKY3zcZM/CH8azg/4Qj0FKectJ/c0nfkvauSDAg1Wj0=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756419476; v=1; x=1756851476;
 b=fBZWGDY4m2qyxjr/2Ue8OdfFc/cREwdbxJODnh4CfQ+8iI+cyt3emL3Vkvr7XDMGKq3oJDHk
 zCdYwOpKWr4JK6JDSBF3k+iQUBEt7ofyTP+KoDsJAtcHB5lxSFRWfsS03Hf/44+Pz4ayXAs3XqK
 ie9MiPFrfiGEcHLfbAhN+Ee6Qw00D3GZN5gLCSnsHdXr6T2L8CDDAfN24hrFcoJg2IIQuK+id3M
 VKvCeA7rSjakjLi7MdLJjZaWMC9Qpl9/p+pCp5ZmHm5ErEusDLXc62hOQ2LJm51KPR0ZXfuA3D9
 kfziiXCoZt9ONi0gEiOY6i+ak4YCORVh23wjTZ8WpY3bQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 909eef81; Fri, 29 Aug 2025 00:17:56 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 29 Aug 2025 00:17:42 +0200
Subject: [PATCH 2/2] mfd: 88pm886: Add GPADC cell
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-88pm886-gpadc-v1-2-f60262266fea@dujemihanovic.xyz>
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
In-Reply-To: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=fdmPzeHJYHHuG0oPTtGVH3qCVnuoCo/RhPfd1QjQFPM=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkbrk7ylOj5M+/EvXvXrI/8zePKYdK+0JP2LLAmZvYTQ
 Smbb5+2dJSyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEsjcxMpw8l69m/WL+sg9v
 1rAd3t/od/fi+0XRbrZxk6TniFu9Si9i+J8wb4/NDcfHc+8uPMi+cGW3Ruu8tO/GmUuP/BdbvvD
 6FDkWAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Add a cell for the PMIC's onboard General Purpose ADC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 drivers/mfd/88pm886.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/88pm886.c b/drivers/mfd/88pm886.c
index 39dd9a818b0f0e1e5839f76768ff54940f4cefa5..dd7a563152e5f845b7d6cd2ed582577c322c91eb 100644
--- a/drivers/mfd/88pm886.c
+++ b/drivers/mfd/88pm886.c
@@ -38,6 +38,7 @@ static const struct mfd_cell pm886_devs[] = {
 	MFD_CELL_RES("88pm886-onkey", pm886_onkey_resources),
 	MFD_CELL_NAME("88pm886-regulator"),
 	MFD_CELL_NAME("88pm886-rtc"),
+	MFD_CELL_NAME("88pm886-gpadc"),
 };
 
 static int pm886_power_off_handler(struct sys_off_data *sys_off_data)

-- 
2.51.0


