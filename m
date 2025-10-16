Return-Path: <linux-iio+bounces-25140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EACBE305D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 13:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71CFB500515
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8AF30C34B;
	Thu, 16 Oct 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUjlV0Ol"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E33064AF;
	Thu, 16 Oct 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613151; cv=none; b=mO+TSXAweBRJtU+WmjD76Jt0KeSz084DDR5e4DHckoR6YnE4s7lZURxqDhx1vNr3PJiaynZuiuYUYfuUcKWDRB3Q7T6FuTgJ9jaj6EL8CjS9Q/X395dHUAb43gJaUho+sq30YtNEC+E6OT7ydAO8qOuZ/w0kAUSFqGgXd5RKrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613151; c=relaxed/simple;
	bh=qWN5jRJyu+ZfS0Mz8q6YyNusK6HtE9esHiV2Q5N3IP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMaMo6UMbouMZUceK7cCTkfq8BXbMADrftqrLE32TLOupbYgG4P7MlQcZeOaepgWLG1B59HxDVoKFWc/E6fCZzfjjK/g3qKq6ygjd30DbJtdnMfb04rPK5sYSI3yKE98p61HxFwjLthDXz/1W4UEtOMvvWGd/J0NxHDTdqlJYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUjlV0Ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FE7C4CEF9;
	Thu, 16 Oct 2025 11:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760613150;
	bh=qWN5jRJyu+ZfS0Mz8q6YyNusK6HtE9esHiV2Q5N3IP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUjlV0OlifcMFLBZMW1oR2N63lZhedrxldkjDhwxZ4zRPkVgLLR8tx+no/WpXJrFy
	 NetRxqKtgSplF5tAbjn+PiAQ4mNefzam7iHz6lGy9D3bXh+afCYs5mObf3Q7aphVSx
	 FSkM6Dr9dF0j9cfWO/tQorUxgxuUGiqS97BLnHf6mTKs0pWcKXpi5Y3XzdzBng2Zno
	 m41+gk6UMNdyiuNJrmFTfy9jx/Spuz7PRXXsu+nugGvHoAPynHAuT31K+XwAUJ7PWA
	 TVpAaDcQ5G5/RRECXWyr487iLgB3bPf7T3Vkm56WYNGNrnrgz3wwqDi5HCBBCzDhlb
	 y/zaFZPmFyQZw==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer
Date: Thu, 16 Oct 2025 20:12:19 +0900
Message-ID: <176061309838.174790.14380642459338947302.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014145905.4862-1-ilpo.jarvinen@linux.intel.com>
References: <20251014145905.4862-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=368; i=wbg@kernel.org; h=from:subject:message-id; bh=9nxdi0icLV2/6ycaKJr/4F7sVcSCO09YFZnRpoQS+/Q=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBkfLn2a5leQ2nRVP8p3/5WtUiFO6im77loluS/+KrTWc oIuq7VlRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRrwcY/oebHbl/yczpmuaB RiOTdYssjwTmrAtg1P0inPrhTop5/lJGhoOKgVoHvrVFXbh979B1xlQJzpux+extxRrX1sx0YWJ LZAYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Tue, 14 Oct 2025 17:59:05 +0300, Ilpo Järvinen wrote:
> Jarkko's address is going to bounce soon and I agreed to be the new
> maintainer.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update Intel Quadrature Encoder Peripheral maintainer
      commit: b462fcd08dd589d9cf9eb7f9d8fc7777b5c5521d

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

