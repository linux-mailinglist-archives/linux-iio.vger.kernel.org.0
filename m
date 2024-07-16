Return-Path: <linux-iio+bounces-7645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00D932FB1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444371F2370D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CB51A01A6;
	Tue, 16 Jul 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mITIhnpr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13B19AD72
	for <linux-iio@vger.kernel.org>; Tue, 16 Jul 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153208; cv=none; b=UmEVTIG2Fw4O5EJJnK5AsNJd8a06Is9RPReBrSYwet14TT/tVoEdFF2/1EdZdH08IHzxsDfax0XiGCydrxLSwKL1dDStvUGSqTsvauZEfxjrPk7S44ohv/IggRQwGWxYewCaxP+eFO8tyAe0IKNY5FFg7LKs8PlPD7uWHNia0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153208; c=relaxed/simple;
	bh=2dHZpWMSAeEcCRzU0VOnILGHLE4wQAt+lrBpkyA5LYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwgKiYB0DoyzqWKjnqgzXEYIVuftuad4QSAjhyAV02DxvXUW3qsBOC78WYz/k8xEjSloyS5gFuYT40es5cAMgPhl6CVETN9wSubnRbXWit/d7+ILOvbHaICswFaA9HyRCoZJwvOskgL2l8ZYbIOS9qzCbKyunWJr7f8SUhpxSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mITIhnpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74D2C4AF0B;
	Tue, 16 Jul 2024 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721153208;
	bh=2dHZpWMSAeEcCRzU0VOnILGHLE4wQAt+lrBpkyA5LYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mITIhnprSmadvvvrgTB4unnPBBF0cWGpq/3UQdBjuXDhxZE4fNLMQToj8D/MYOBnL
	 5+NP19OjaexqEgzGatOtvBA3Kjui7a2+Kw8wOrHK/wqdWM3rv03ZJwcGyOuOXOpf3A
	 +nlyD2icoLz5VKqb5Wbr1KLxrYwezSkno7Um5CBK8I5TPnMVcXSS+HbldEpPZU02L7
	 z4ZRMqzBUlCkDTNYnREefkLy8h7LvRdOu3FZgi1sHdWF6NQffCy3HImeMsRu5i0XxA
	 C6vf6Lb1R2Ld0d9nFZfC7GT8cXU/VCU5oVjP2KheGTF0VmEs1k3dE6GhPFAaqkk4Wl
	 LFd7ayDmRuQKQ==
Date: Tue, 16 Jul 2024 19:06:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, "Olivier Moysan"
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 1/9] iio: backend: remove unused parameter
Message-ID: <20240716190643.11308b14@jic23-huawei>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-1-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	<20240709-dev-iio-backend-add-debugfs-v1-1-fb4b8f2373c7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 13:14:28 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Indio_dev was not being used in iio_backend_extend_chan_spec() so remove
> it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I'll pick this one up even if not the rest (not looked yet!)
as it seems to be obviously correct and makes sense to get
rid of that parameter now.

Jonathan

