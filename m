Return-Path: <linux-iio+bounces-19014-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FFAA7D72
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 01:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D64C1BC65A2
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA021FF54;
	Fri,  2 May 2025 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jev2ig8J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFC347C7;
	Fri,  2 May 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229787; cv=none; b=NjPpbIrnD9Fes0vToKb3G0UMG4yyrncFpM3NR9Ss96G4sjZNJWeOHx+kf5m1Znata4QqzC8V9ewcKIHHE+ecM0G8GKY7k7lw8bGr2F7nohUy7ZUfi9tIlRa0kSkXiDIc8jZfOC0rK/d5q4ImINl1QkSayCFSnE0gahJb3ObisUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229787; c=relaxed/simple;
	bh=ruYG2phbOQ1SE0LrGTNorKIuauI6sGzHZZKXVw4/Vj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryeikvoC/rTuP2kXduOy3N3qEPOMLBZ3VcM5VY5+cNw1SrI1rTe57NvEBXQfJJ5rwByJ7qzsSH58eqHD9Po1v3SUE7xamQA/ouRY3AwVmM8CeNDpT9FxgAFavKUx/BCtP2E+GiiZTYhC48CG32hmthZq6paAQR4mVt4JtIVk+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jev2ig8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1891AC4CEE4;
	Fri,  2 May 2025 23:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746229787;
	bh=ruYG2phbOQ1SE0LrGTNorKIuauI6sGzHZZKXVw4/Vj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jev2ig8JghpCuI9xMRPWcJV9uqx24peg457z2Irh/iLOI+ixY8rW4L3/puC+wyfze
	 FhRvhvDH//2zekltH7ytTX5gb/yjgDw6b6Rvjr8nEoAV/CdkieP+qUlA5o37V/9rHy
	 agLiiJyGSCDWpoe99cJLfh2PJ6tdBDuJnh5j1biZ9j37JbE64PHlYevWov3Qr7zVOw
	 t940ID3Az/3dFNIDjsWe3AX43ESS/uT/AyKuN721/QL93CCeyVP9nFZGEWoYWYwLlS
	 cbyT1vl4Ie21wT9C6XaquCojk1rFrbh8UD370efr2Y04B0BAbIZYh/E28EPnSbH2aG
	 8PmPTIMv4pCpw==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-iio@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: interrupt-cnt: Protect enable/disable OPs with mutex
Date: Sat,  3 May 2025 08:49:40 +0900
Message-ID: <174622974059.536802.1308149045945940669.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
References: <20250331163642.2382651-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=469; i=wbg@kernel.org; h=from:subject:message-id; bh=uM3SOY4L0Hb0thQ+0fSQE1nq9FWiZyawXGfrE0msknk=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmikX8vPtz97IBoEYtucLuczPT1j24y5cbMmTrn+Yx/E xTOdJ7921HKwiDGxSArpsjSa3727oNLqho/XszfBjOHlQlkCAMXpwBMhM+TkeGRsKfEmn371i+/ /TSsd/Pq/lVZWhd8717S38MTbqhyxTuT4a+4eTWvEt/EwgWu8g+YqqLL8meVP97z6vqP+G2fr9U uV+UFAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 31 Mar 2025 18:36:40 +0200, A. Sverdlin wrote:
> Enable/disable seems to be racy on SMP, consider the following scenario:
> 
> CPU0					CPU1
> 
> interrupt_cnt_enable_write(true)
> {
> 	if (priv->enabled == enable)
> 		return 0;
> 
> [...]

Applied, thanks!

[1/1] counter: interrupt-cnt: Protect enable/disable OPs with mutex
      commit: 7351312632e831e51383f48957d47712fae791ef

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

