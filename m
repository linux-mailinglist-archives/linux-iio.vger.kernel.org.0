Return-Path: <linux-iio+bounces-16539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10CA576B2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 01:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AAA7A3510
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A884A1C;
	Sat,  8 Mar 2025 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAjLBcPi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB0196;
	Sat,  8 Mar 2025 00:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393031; cv=none; b=mR44nuz60gRAtl4eUzVltcY3kML8cHombcRvvzITYmhATG8hVAAbvsp37UOznltMVaTeuIiJyfB5DKo7FjPu3WeXTyu+TEco1rR8dpn/AO45TzFc5L8nIOedbmF6/wrLfrzGv/LANGhDgacdEazunahC4lFTlSEDhjrixr0kQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393031; c=relaxed/simple;
	bh=K48dDGbOfAtjEwZKUeVi9F4L/hg/zp79smFcJIBF2XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX/pAjLpvAt9Qwksry5bBR1eKAd7ylfnkIvzljIABhXzJ8IPo4fvJl2ixQyjeN2tbrUGNJsxRVDV/XgxwVjnyZrGgR1czl5OApWPnUWxpuZSpN8JQdqJsADI3LTBNuy6wJNIWcjQbnwFKCRsc5MyP6a9WNdx1Yb7BbWy9kEnzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAjLBcPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C87BC4CED1;
	Sat,  8 Mar 2025 00:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741393030;
	bh=K48dDGbOfAtjEwZKUeVi9F4L/hg/zp79smFcJIBF2XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eAjLBcPi7Z+cbhJes7xnEuaKTj/9axZCw71jGJLnxQ1z6jI57I/npvgmGQf6EzlX4
	 PkDsKKx5zlcVHiw5lr4doNT4y9LEiwcRoKXRCA9tLzXEnc9/nGeblHI7aKfXtkvfjy
	 krULEnxAar/u1eGwjpHr/HrJ4/IT15cl7fBCVlPMKc+YjpqYz8jLp3u0Vz1Zp/2axp
	 LDhnYwVmjhpcEaeDtYSe+2hOZaX1AMfi7oyskj1I+j5BAqGBXeFBpUBpi1836fCq2M
	 VMW2lu+DIDUURnnhxL9zVutYqhkttp9FoRPLtUxFGXSWPnWvbCpJLF3O+egIVkak2f
	 ZO6xuAKBhNLoQ==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Dharma.B@microchip.com
Subject: Re: [PATCH v8 0/2] microchip-tcb-capture: Add Capture, Compare, Overflow etc. events
Date: Sat,  8 Mar 2025 09:17:04 +0900
Message-ID: <174139258236.459919.5227805319293627161.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306134441.582819-1-csokas.bence@prolan.hu>
References: <20250306134441.582819-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108; i=wbg@kernel.org; h=from:subject:message-id; bh=x07tfBdhBjiiaz1pNHTW16UZFI8p5Ig8SxC5mcIGNt4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDOmneyqOeDExb1v2ScR/Veduz127go+leDz5eEL02Hclr oq3GcocHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEyvsY/vBlBVyqyvd7+WL+ g1OT/p9MPHboQM2V6gma3N6Lsg0O/v/E8D/MPzXeWHSTmbDg7nWlrRdvRZ1ZL/nC88DTb4u5l0r +8ucAAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Thu, 06 Mar 2025 14:44:35 +0100, Bence Csókás wrote:
> The TCB has three R/W-able "general purpose" hardware registers:
> RA, RB and RC. The hardware is capable of:
> * sampling Counter Value Register (CV) to RA/RB on a trigger edge
> * sending an interrupt of this change
> * sending an interrupt on CV change due to trigger
> * triggering an interrupt on CV compare to RC
> * stop counting after sampling to RB
> 
> [...]

Applied to counter-next, thanks!

[1/2] counter: microchip-tcb-capture: Add IRQ handling
      commit: e5d5813968217b99ef2b83f13353967b218e3841
[2/2] counter: microchip-tcb-capture: Add capture extensions for registers RA/RB
      commit: 1adc6240a80278c613f655b71c6c0d447b2d5932

Bence, I've submitted a patchset adding support for the RC Compare as a
new 'compare' Count extension.[^1] If it works for you, please Ack that
series and we can hopefully get everything picked up by the 6.15 merge
window.

William Breathitt Gray <wbg@kernel.org>

[^1] https://lore.kernel.org/linux-iio/20250306-introduce-compare-component-v1-0-93993b3dca9c@kernel.org/

