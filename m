Return-Path: <linux-iio+bounces-10237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3F991E79
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15030281CBD
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDB5176AC7;
	Sun,  6 Oct 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYUtKkNR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8AEAC6;
	Sun,  6 Oct 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221135; cv=none; b=FZ/ACdvNozq/nnz7bs2bBR8zkeq6xsyp2jgliV7SSmaehcyzFy1FNsxZ0HJqPkjsP60ABF8nQQulngzJP9MfH5GV5/G6xlZzU7pXkhk99IDWCfKa3sp/guOqkeJR91saP9TaUxv1u+njHt84/kegBw37v7yCNBL0TMDWX55jTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221135; c=relaxed/simple;
	bh=Xk3g7JmyOgPe8yyc5fHRQ/4AN+ylDx6qw9SnUZStJ6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVP1vATlf9Yh5b9dFAuaZET3EBrzkywyF859g8O0L5AxQmVk1GvgBxZnPo7zgQcpb18e6L06be8U13j437UMaiV7deNDDaZIqRv/1jj9ogQ64P8m3S+rTlmOUl65G9+JoBYYNnHgHxLRxusPP2+3JS0Rnyt+B7ElEMNgOdjgwtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYUtKkNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21150C4CEC5;
	Sun,  6 Oct 2024 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221135;
	bh=Xk3g7JmyOgPe8yyc5fHRQ/4AN+ylDx6qw9SnUZStJ6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sYUtKkNRj7DuIJVGLZXDUswSx13xWTOn1wzJjtNQNolLZBDWXnAxDgkcL85+PJqHk
	 5naBsGvj5t3Ujz690CwN6XhpnkSABdrnSvfDWt9mJ2H6uJSxvDbOjmFYM+EfVus6ZR
	 +3srByZ6CSUAnk4U4afOA09te03Oyr5O9F9b5rvs3xdlJ7Qxv0qMxnRVvRnJHqXIAq
	 x5DezVr6mGydlrajwRrOZNlVGk2mug26IcT8z6/hiwjnHdCIGyyzWu0Ay1Ys54znA7
	 Byw5uwRHQBzi5M8AUsoIv5nPsLS2WaR1FT90Gv1fVXR96JK7QgEm3CCw0DQcXHRR4f
	 PgosT3+fSTeRQ==
Date: Sun, 6 Oct 2024 14:25:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iio: resolver: ad2s1210: add missing select
 (TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241006142523.1fd8c011@jic23-huawei>
In-Reply-To: <96b0ec27-d001-4d8c-9d20-1b6ce09b4896@baylibre.com>
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
	<20241003-ad2s1210-select-v1-2-4019453f8c33@gmail.com>
	<96b0ec27-d001-4d8c-9d20-1b6ce09b4896@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 17:44:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/3/24 11:49 AM, Javier Carrasco wrote:
> > This driver makes use of triggered buffers, but does not select the
> > required modules.
> > 
> > Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> > 
> > Fixes: 128b9389db0e ("staging: iio: resolver: ad2s1210: add triggered buffer support")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>


applied.

