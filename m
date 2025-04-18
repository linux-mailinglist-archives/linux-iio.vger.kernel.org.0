Return-Path: <linux-iio+bounces-18256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED520A938FE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC4B4676FE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13521D54FA;
	Fri, 18 Apr 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by2Ul9l2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9BFEEC8;
	Fri, 18 Apr 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988258; cv=none; b=bNyVFWXkQ3cPt7cAl8e3pdv91ww59LBSFC1Dk5NUyhEBMk9MzIL+Mcep1NdrPnq5feWPAsHvwtTiZIqFpg2jG1kKodmmQOAZRbNNbJ8rYzOkQwCH7esPtAVO5EruSlTNYN1Q5f8U3pANqeXbZYIBao34ufm1HMsxSL5B+dyIX9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988258; c=relaxed/simple;
	bh=oTujeQS8sarIls3zP15tI7er8VCZ7VJRqM5QzlZPIFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G05wmehIU2y1EMBKLMajf8Lg6pKzBWK3x1lKjvt6iTDArcOpdTrff/VwSKeIdiBQfXhsaz599SJnHcr5YOMCYLkmpqQMumXlliq1mEZ/JBu0Il7D/TleaSnAEshXCu4fdrlAr2B35WTNxCsh1hLY7ND3oVWq8eLvr5sLuknH5zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by2Ul9l2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5C9C4CEE2;
	Fri, 18 Apr 2025 14:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988257;
	bh=oTujeQS8sarIls3zP15tI7er8VCZ7VJRqM5QzlZPIFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=by2Ul9l2z5ymQ17ajZmbp9iqGHpbsHrnzPyg65f/C0hBFCh0xGEmIRcftdss7w3I0
	 EETLSE8Rh3oOzQaGv1t9e8tYDdBo2IFDZAIZg+4h3FDBdHFpsZsWXR/FbEw7a6MqRu
	 Z2rbb8DT3dR/1mLnvY+PkYB//AdUMcZ3HqJ65fPaVjo/NKnWEpHOXLLcbEcg0uC7fz
	 H4jt51kGuWIskAvsEAtVciLkPly/Icj+hrKkfc61c1w30Wa3bR9iMwLeSKo2z6rFOO
	 +OspogI21J7VVLxRJVxoB5MPAFVaCG9Gh1CMcROf6I6PGpFNcb/EHgbT8kyIQjKq6M
	 3oETvyrsirg4w==
Date: Fri, 18 Apr 2025 15:57:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin
 Tanislav <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, Petre
 Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
Message-ID: <20250418155727.21f65050@jic23-huawei>
In-Reply-To: <aAFC9FsTRNya6eDU@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<aAEz2ZD0Ipd1Xuy6@smile.fi.intel.com>
	<20250417184716.000044bb@huawei.com>
	<aAFC9FsTRNya6eDU@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 21:05:40 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Apr 17, 2025 at 06:47:16PM +0100, Jonathan Cameron wrote:
> > On Thu, 17 Apr 2025 20:01:13 +0300
> > Andy Shevchenko <andy@kernel.org> wrote:  
> > > On Thu, Apr 17, 2025 at 11:52:32AM -0500, David Lechner wrote:  
> 
> ...
> 
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>    
> > Also no need to sign off on cover letters as they don't end up in git.  
> 
> It depends if you use `b4 shazam` or not. I like that feature.
> 
Definitely don't add what you did here though in a reply!

That adds: 

    + Link: URL [1] :-)



