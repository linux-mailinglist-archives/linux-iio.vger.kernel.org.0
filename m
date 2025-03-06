Return-Path: <linux-iio+bounces-16475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB1A54D06
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA981887B0F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D0154430;
	Thu,  6 Mar 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbBGOB0R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AC151990;
	Thu,  6 Mar 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270114; cv=none; b=s/8n4xOLMGwP54OEDmZEHDFIirhVfnpxv1E/gEYxpmlXXLsg9Xrj2j3GCdhDfl41P0PT5pOrzn05J6agBhYe5itjltWMqZplEcNDHXFTRm8l0dZ5qBDBAGKZp+00D490g2fEvwhhhCrI2Qa3rRbHLJrE8vPTmM+ghjxfsrq0HDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270114; c=relaxed/simple;
	bh=LkIfOHx5/dcrgATekQOsPiV7zPoeugPYPaspJUC3TN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C53zVIj4yyJVE6b0hsEtkTMzUCXRFYb0pgkYj+5snWEEw9TFhACbibE+ShKzxDATawQ9WT0xZyfz4nREncno3mIaP46D+3ByEVWn6YcVxliD1RfKtzwdM1/ByIcQYLxywyyFLxZF1yRdL65rVtfQRZ2uD9aG0zaJeabci2xCfnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbBGOB0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49D4C4CEE0;
	Thu,  6 Mar 2025 14:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741270113;
	bh=LkIfOHx5/dcrgATekQOsPiV7zPoeugPYPaspJUC3TN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbBGOB0R7RKhs/DksPDnNSPytvTgwWFHcsTcpTedR628UAdd1V7hYr2OoQ1UTTBvW
	 02xNfRmtsjukygDZ9U43L1V+ZUKF1AYJG6SxQlIJ7KKWZO79EfwGkxPWJQYH7Ttilf
	 3cFm0gEfLbNCT7erksLlyqRjF6GyCUq8wW7rDPKu3tF3FdWFBhnzQC1ZpeyCrIyZBw
	 fYJgkFk9mKgfbi0laikEy2b/4+jDbzZ+2cAhTRd9PS3BsOuxBKrnbBlmzWkA/u3aix
	 wt4PolrAAQV/mMkl4XJJalcoH+8oFj3v/7Bamf309Ggo6+KQE+jEXj5SO2PGZsfoko
	 9elPEPwaigtaw==
From: William Breathitt Gray <wbg@kernel.org>
To: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	William Breathitt Gray <wbg@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: microchip-tcb-capture: Fix undefined counter channel state on probe
Date: Thu,  6 Mar 2025 23:08:23 +0900
Message-ID: <174126995863.355997.16346927228585162675.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
References: <20250305-preset-capture-mode-microchip-tcb-capture-v1-1-632c95c6421e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=566; i=wbg@kernel.org; h=from:subject:message-id; bh=ZYCqo0M2oAeDQGbSQHEhiD46dBjTRHS0YFHniKGFDv0=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOknV787fUt35qeoyqI1PbW3rYTOMHd/VktWXLrpzh1po 0snF1RO6yhlYRDjYpAVU2TpNT9798ElVY0fL+Zvg5nDygQyhIGLUwAmkpHAyLBIM/3u+faOSfom QZ+i/j/YcJ73uMP/TxOre9o28EZdFF3F8IfLqeXPV9bY909uN9zx4Y4VDNcLXlDx6e5cnZ0Rkhu vW3IDAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Wed, 05 Mar 2025 19:01:19 +0900, William Breathitt Gray wrote:
> Hardware initialize of the timer counter channel does not occur on probe
> thus leaving the Count in an undefined state until the first
> function_write() callback is executed. Fix this by performing the proper
> hardware initialization during probe.
> 
> 

Applied to counter-fixes.

[1/1] counter: microchip-tcb-capture: Fix undefined counter channel state on probe
      commit: c0c9c73434666dc99ee156b25e7e722150bee001

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

