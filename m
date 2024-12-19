Return-Path: <linux-iio+bounces-13647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D79F7E19
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9375C18882C1
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4E22616A;
	Thu, 19 Dec 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8FFOvZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B370809;
	Thu, 19 Dec 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622194; cv=none; b=eQvFXkV6aOh0Sccl4L0k86oM0vRgluGusiXPk5zy/9qcswFbJjr1R7+QkjW4rVR95cLSNLqDj5jOX7kG5rIcjomkXsoyoOcCrpPP+gpdgJdaEiAuzSomMPzfhD0NXhuOCMJaBQL+Iy6YXr5Xk8aLIb37Iu2YRm61thRTvV6znsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622194; c=relaxed/simple;
	bh=AoU2GUGvioS85sW/u3jhxrluL37qmCyyEXecYCFGttk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTgYX5C8k1DlshXunys0xkwGtC2f7lvYwwsamytCt1Yz7kwY6HqozcaTv/Mbg8Gz1WDCmOyMuVRS8PngRjcX3watgB+ZWB1CNcwno73DQNNls5c0F8C0kulTV6p7eAYzc4wB3gbG/CXEiJ691BWnnpnYdv1SBloeG8RbFsTkS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8FFOvZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1B3C4CECE;
	Thu, 19 Dec 2024 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734622193;
	bh=AoU2GUGvioS85sW/u3jhxrluL37qmCyyEXecYCFGttk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z8FFOvZAjmtSOc/4WeH92qM5PWIUjrlXU2Dj5OI0r+stZWhyP7nRocjBBFK6mTfFK
	 EhBT8f/EFRyB2oXX2GBgabYHUajcQTj8wd2gIdogThXpLiemhX1Mgav04PCiOps5cS
	 Ud43NB4vepOulxoDYugqXk0Ov4OV8X7zGsLPmNZ4TIFb1mfLa2nJIwhemZWo9mb5BS
	 7f/UWpYCxof61n9/JquJ4xmv46X5RX8wYGbMWXb1VMxKk53qeOwvtJcg0Qx/5XM19z
	 A0Y0uNjTeEh65EPoRNhAOeDPqJszbQbPHy4lgxm4I6cXsIcw6JtM1yvFVl3Ee+3JFM
	 mPxNvF0ZRR22w==
Date: Thu, 19 Dec 2024 15:29:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ABI: use Y consistently as channel number
Message-ID: <20241219152947.0cd882c0@jic23-huawei>
In-Reply-To: <20241216-doc-iio-use-voltagey-consistently-v1-1-9e34a72133bc@baylibre.com>
References: <20241216-doc-iio-use-voltagey-consistently-v1-1-9e34a72133bc@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 17:29:36 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Change X to Y when referring to channel number in the ABI documentation.
> There were only a few cases using X (and one using Z). By far, most
> documented attributes are using Y for the channel number placeholder.
> For consistency, we should follow the same convention throughout.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Thanks for tidying this up.

Applied.

