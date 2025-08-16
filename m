Return-Path: <linux-iio+bounces-22838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C402B28EAD
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1201CC4558
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843012ECEBD;
	Sat, 16 Aug 2025 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1/pqoOn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430ED1EEE0
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755356243; cv=none; b=ob065SAH7nw4zQ17kN97ul0el6H4ODFfDFNV22+iA+OzTIkwz8g/3kpTGUwYjRisVu130z4SlMj/UoCBvHK0iAHxYTHM9DsqjIswQ1+Q86zud0mXK1hRCrCfHbPH8uu3WVQg63/Voe2TyuSz0inCXOE/n1SclVxi3gf6fqwguqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755356243; c=relaxed/simple;
	bh=063Ugl+h4foJJ0NJWzGa9zhYvZ4mSgKuQQyn0QBEyfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pB8HUN82Ulf+e9S1l8KFSNn1fxyFYeoKZhbTzYzdlhIYRdpgUpTjCiByGVDmZHY44UrMj8IymuUaUyolX+fJQPMGAmw1yoqG5pRkx2kgVCqfTtz+WPyLPbro7g1XG5AjQL2dCCDZWx9dqAiqcF9SHEaN4X60lUei2lkz8UELmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1/pqoOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818D6C4CEEF;
	Sat, 16 Aug 2025 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755356242;
	bh=063Ugl+h4foJJ0NJWzGa9zhYvZ4mSgKuQQyn0QBEyfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1/pqoOn7bxR/n3vwerxEX19x6ImHgVwsX7VTe1wjaXshxQFJu/0rqipKstH+FzCP
	 pv6ur/zgpzdSpMzSCqrrRHh4gIbDnkpZEMbKHle2ZipO7FxD5O45hqlFbpcJxvSsJT
	 n6xaH8MVHB9pgKj33Efsk6CuNZR8w7dTLvjJRiHgiRpKryhUDmpdCUwI4zK1xj0tcA
	 rnekE16RIBr8LdNkl0gftHCE8Ew4P7kD27GLriXQvaFjKJ/l5fs5SReUlRWVyteT4H
	 Q2wE0ZhNytmJvgdHlYLrax8H46NQkg8cs7cS+Wxyv+fJ4eBOIri+925vMcu1uu09z2
	 Qv8VsU8NvKn3Q==
Date: Sat, 16 Aug 2025 15:57:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 12/16] iio: light: tcs3414: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
Message-ID: <20250816155711.5a4250a7@jic23-huawei>
In-Reply-To: <20250802164436.515988-13-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-13-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Aug 2025 17:44:32 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied with tweaked description as per feedback on earlier patch.

Thanks,

Jonathan

