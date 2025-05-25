Return-Path: <linux-iio+bounces-19887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62AAC34D4
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBA3A577C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CC0157A48;
	Sun, 25 May 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCruhJKH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41C3FD4;
	Sun, 25 May 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178995; cv=none; b=Dzjnn+tmi83lU+IlII4ugiC88Y93ZFIxklUKa4QixW9D2w3zvKowwNsJZQ26tFBhlIr2erCC0+4uJWEqfbJ+nmh98Cu7RwdSRFy44Q599A+PZ/P6J3XRPgQj7aFoitqyGRlXhWF+IlYnqiyCgngobMRNG0tj5fkv6pNEl01CGcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178995; c=relaxed/simple;
	bh=UcpFD1MciQfg2krDziwAjGkJkRIfXfC/Ey0Pc/8QYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZRLuj+lLVeiQP5z1Mw7Mf7Ngha6gQ7V6SBd6gvH1NCV7kDPF1sBmfJcAa/XUs84G8deuQPfpzXrpAzrakixfSq30cQki/O2BVc7JMTBapy0Z8zANVJpdr6K9dGYr6aLDNsP0/Ep9aIq9ohwYvUK+10rIMtUadwsdyvP2uTi7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCruhJKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FA8C4CEEA;
	Sun, 25 May 2025 13:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748178994;
	bh=UcpFD1MciQfg2krDziwAjGkJkRIfXfC/Ey0Pc/8QYTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCruhJKH50/r+cVOwLVfScWX7IeRy7JaixWiPaHdUDnItZ0DGmht7Yx6WC/lxs+Dx
	 u7l6I6VEzVtra1X9zvC8HcH7kU3wuVD69B3R9Mp/fJ15AaJL37CKLU2gSo6veczDnc
	 muB9VW3eFzL008Rg/GNSNIh7cdi4U6IqqMVAK2GoSwWeHaC0EBDANqn4oYqlLt4sTv
	 509EVwnAhemD/+c2YrIc2pGrgcBxapHRQYZ4kBbtH/tw7zb2Fs5tq/UeZJU4pMEpiU
	 M+/obk3aBMVaF3oNdi0f2UmGtU1EfLqVzUK/hmsR6R8Jx0Kew6PWnTRL87S50IgBbx
	 0utOPODcWEeHw==
Date: Sun, 25 May 2025 14:16:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/12] docs: iio: add ADXL313 accelerometer
Message-ID: <20250525141625.174ca5b8@jic23-huawei>
In-Reply-To: <20250523223523.35218-13-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-13-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:23 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add documentation for the ADXL313 accelerometer driver.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Looks fine to me.

