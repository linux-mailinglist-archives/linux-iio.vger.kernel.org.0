Return-Path: <linux-iio+bounces-17369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62452A75B67
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CF0188B4AB
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED451C84CE;
	Sun, 30 Mar 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDJPK+T3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F022AEEAA;
	Sun, 30 Mar 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743355826; cv=none; b=IbkHumI5xmxWBdPnssYrAPeqEsLoUCczfxQn/35Vbvu/cE9R7+PyqyIqZfTnbofsjyp9nMvJBcHa6gOv0A4Pj/Xry+L/vg1pbT4dKFgmElGCufVWbOjMmAmfLXWs+dFo+WkRmn/jrGpUYnYmfU4k5rnbfAjk5l0zEnQLqBpryuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743355826; c=relaxed/simple;
	bh=p/jItwHiamDQXwAc2cf88DRIgYGnBxgcorQPHBySPNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WH/HZn8FxE5t0Sz2q1lIbKQONssaUsNLNdA7TRDF6QaF3K2AuMxq6RaczBlJm4L//fMFv6fkpzlq8D6aIPzpxSsYsVhJ/GbbBvoM5eW6nBLtyADW9lPo5rTdGTgEKyB5GDmE/gFWzwMmQBJ47ImxO6z4nvcb2OQyawT9d0lBLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDJPK+T3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0998C4CEDD;
	Sun, 30 Mar 2025 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743355825;
	bh=p/jItwHiamDQXwAc2cf88DRIgYGnBxgcorQPHBySPNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oDJPK+T3ZKE6fIyrPti9sm85woAeg92bbKPb8TkHf6D1o8WHzgkltizTiyAWpvCDZ
	 G82SgKN/TrLGg6mM2LIZblv/nFMkql6zWdlSa7CWmfm28Dm5PObap4e9qPssrP/LkD
	 EcE4Wvhi4ravlR2plKUEwd5IlRyhwS8kW5cdacaclzLlemj2HZo+vpZXtMM0ub4yRw
	 3znj24uwemt0HxXZd43/0drvFls6CWZoZGhNvLd2fyq1Ity/vs3sCTd0qPzoMKOZQb
	 xANMcVFim8mV+mMTnv21UdTk72i7JpO+zEAIT7GHv/TV6i+WjqQF4ApXrljg6bAi9u
	 7HO37HZXXAtYA==
Date: Sun, 30 Mar 2025 18:30:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: david@ixit.cz, Lars-Peter Clausen <lars@metafoo.de>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Robert Eckelmann <longnoserob@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/13] iio: light: al3010: Split set_pwr function
 into set_pwr_on and _off
Message-ID: <20250330183018.577908a2@jic23-huawei>
In-Reply-To: <20250319-al3010-iio-regmap-v2-7-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
	<20250319-al3010-iio-regmap-v2-7-1310729d0543@ixit.cz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 21:59:46 +0100
David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org> wrote:

> From: David Heidelberg <david@ixit.cz>
> 
> Simplifies later conversion to the regmap framework.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
Applied 7-8


