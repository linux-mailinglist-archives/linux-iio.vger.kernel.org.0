Return-Path: <linux-iio+bounces-7973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3442A93DF9D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEF6281FF5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393EB139CEC;
	Sat, 27 Jul 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdg5SwYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889913665D;
	Sat, 27 Jul 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088352; cv=none; b=rq1XsGo1SKqIOtPHQWK8Om+wro2OXKQMzeopJhKURIitxmECN0DraqWdRKcRHf2fCN56SisQJNVgNsUYfbdpS+bK5RmJaz5yFMkRbqBubYVWo57mSXJbqvTNIDxyJ69qvICraUfWianOJbOyjiiLaJQQ9GaSY1WgIhzeD+lSDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088352; c=relaxed/simple;
	bh=SZxQaXO/eySlfBxi/3MC/K/52gNSeLbhASePurFAJCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPuadpCWXzDmd8fNHg/5TIeILzVyO+U3s2omxczD3Bwd0nDvbU0GqDpObj4eRRrs4MEm3tkSNv5RRpkW2Rsw1t8m8bnaSJIXincWu7U7j6MMRdxhf78jd6yS75VG0VhuVNoEU3Qqa4uC84K9tKxD8Bw7T59RHRamAIaPZIB7Y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdg5SwYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815C3C4AF09;
	Sat, 27 Jul 2024 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088351;
	bh=SZxQaXO/eySlfBxi/3MC/K/52gNSeLbhASePurFAJCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdg5SwYhlliZcZzF59zRXlP70myt1WL3m6wuzbhttbbbyO6xGJY3wH//YzI1AEvFo
	 eCccb6pywRkDeKLbLNFqK8OtLBTvhEgj63NHx98s4tnjyaLwNTx9XfAXUsgd9vZfrC
	 byjSYxCoH8XTgwueTECJbrnh8HCImHDdM8moxv8eZya8ueumA5rDKMO2CTpfAd+z2q
	 XUgfm5Exx06XYBZsquShzHj8Q3+KkDt7+7aZcmAl7lG/qx2oCeoWF+twmAimGa3ObD
	 idMuJy1pQpjp81cplAUNFvtgiD83ySyjShUAMh+W1xUSxSJCeBIRkY1fWPmPnZ6a8q
	 iZRpasa6zm9Gw==
Date: Sat, 27 Jul 2024 14:52:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Marius.Cristea@microchip.com>
Cc: <dlechner@baylibre.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: mcp3564: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20240727145224.275cc07f@jic23-huawei>
In-Reply-To: <5d84869757beea84ca9b60daf3c1b4ad1f05b9ec.camel@microchip.com>
References: <20240723-iio-regulator-refactor-round-3-v2-1-ae9291201785@baylibre.com>
	<5d84869757beea84ca9b60daf3c1b4ad1f05b9ec.camel@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 13:50:15 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi David,
> 
> 	Thank you very much for fixing it. The patch is OK.
> 
> Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
> 
Applied.

Thanks,

Jonathan

