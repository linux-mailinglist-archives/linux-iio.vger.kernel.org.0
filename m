Return-Path: <linux-iio+bounces-18390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5DA949B0
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39247A7521
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 21:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4951C84D5;
	Sun, 20 Apr 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QH2afIdK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA92111
	for <linux-iio@vger.kernel.org>; Sun, 20 Apr 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745183841; cv=none; b=X+383931hCO6FIWb986Mgt1k3JBWoYTkYxp8L5lkkyLPUuV555LPgbnob9ttx95FDetAVnzgWmlBXHoR7aPs9WcpNxVj+c3qr4HM/PbssI2o5g4LOZByShV0VTzLI96hU2VMClFZKf/fTGhLmSOq/BmbTyjdEfMBlu9uACn70xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745183841; c=relaxed/simple;
	bh=GwklWzt1vybVS+f0mn37WJJfLMEYM3nuFS8cL6eFQXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbZaAETogdYY9HPjfy7LIzmb+F2+mILTXsEnaaMjlctD6sf4IQPlQCbgt1eMcGYSxe99n9f7yelydN8g9XgjuJSx+cOjr5fHJ/MjJs3C4l3rZEFBKQS9JNblI3+l1Et0C8S3aVo9nV1jB361yZ7KVPpSkFyBjbdOrYT0LdWbWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QH2afIdK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 7CE3D1FD33;
	Sun, 20 Apr 2025 23:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1745183827;
	bh=SWb5AeZfto9CGbHiKL1gFbW8YUNhcC/p1b5Le7WPmF8=; h=From:To:Subject;
	b=QH2afIdKQsY6hoPoXZjuiGXUrSwbrAt+toyBbgm8KKCw7TyxAeLQ4Y7gV7HVSjsK6
	 HHsWB1xhFZqA6TQ+3yc9uvVEhH3yfkEtwXyTC6ND3K0kBkI3OGvU2AGbJ4YUlUkl51
	 vFBErXJsTHGZ+lXNhybSdDovepeVRhE7S3FuCDCe4EGswN+ncb9Gx0NpBSGX/56eju
	 1RdlB8wT4bKbmwjYhIqJIitQHeKAJeIvpMxPAMute0fGYXKgqkG7giTTlwyKMaj6Ue
	 OuNthBbbyxBg0wWF1YNf1iaS4V3ih2FD6ADWqx/quPpTki2rQ+EEYuZ8RwGwp59Kz+
	 /s+KyNP22uIVw==
Date: Sun, 20 Apr 2025 23:17:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: nattan <nattanferreira58@gmail.com>, francesco@dolcini.it,
	jic23@kernel.org, lucasantonio.santos@usp.br,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Message-ID: <20250420211706.GB5621@francesco-nb>
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
 <c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>

On Sun, Apr 20, 2025 at 01:07:28PM -0300, João Paulo Gonçalves wrote:
> > Use iio_device_claim_direct() to protect register access via debugfs
> > from conflicting with buffered capture modes. This prevents data
> > corruption and ensures correct device operation when users access
> > registers while streaming data.
> > 
> 
> but debugfs is meant to be used during development/integration,
> where this probably is not an issue.

Is even worth doing any such a change? I assume Jonathan will have an
opinion on what's the expectation for an IIO driver.

Nattan, can you explain why you need such a change? What is the use
case?

Francesco


