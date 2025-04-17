Return-Path: <linux-iio+bounces-18231-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B088EA92458
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311DF7AFBD6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C92561DF;
	Thu, 17 Apr 2025 17:49:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6A245020;
	Thu, 17 Apr 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912145; cv=none; b=OpTenI+yQKiE2aN+RfaiKQdOQyZ3qgMqz0nC2ju0gR+3rp8sdblZD/2/DScr4unLoNpY75ycBSaDDNBa2lqWJt989fPwjYWC2l65qQvuXejz/EFHWAASqiztX58DC2N1wCLtJ54FDsarfar1CkLgZjP3XzwFutjMpw0qEOgErcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912145; c=relaxed/simple;
	bh=Gl6X76E/Y69emDlKlmglVZZYGIfgcpDZ9gti6vs+Be8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ETHuPq2qsSyKI1zLO3WzBI7ZDjYk+PuZ/nuA3THhfZKoSzmmH5d86lWsoy+M+ntlY/6BsYtM84LhHjUapmFKIFOjumG3D1VNU6EWx5ncQEpHFtrgc22MrVJhKWSlp6KIAnSCDhuuqi7RyXC0oEHcXi/kV0yuxvsvrAsPYaRBdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zdlf45xxcz6M4Mj;
	Fri, 18 Apr 2025 01:45:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 99ED6140145;
	Fri, 18 Apr 2025 01:49:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:49:00 +0200
Date: Thu, 17 Apr 2025 18:48:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Cosmin
 Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, "Petre
 Rodan" <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 8/8] iio: pressure: mprls0025pa: use aligned_s64 for
 timestamp
Message-ID: <20250417184859.000022a3@huawei.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-8-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-8-eafac1e22318@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 11:52:40 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure the struct itself it also 8-byte aligned.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/pressure/mprls0025pa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
> index 9d5c30afa9d69a6a606662aa7906a76347329cef..9fe9eb35e79d992b2a576e5d0af71113c6c47400 100644
> --- a/drivers/iio/pressure/mprls0025pa.h
> +++ b/drivers/iio/pressure/mprls0025pa.h
> @@ -41,7 +41,7 @@ struct mpr_ops;
>   */
>  struct mpr_chan {
>  	s32 pres;
> -	s64 ts;
> +	aligned_s64 ts;
>  };
Whilst you are here, no point in there being a named type for this.
Would you mind just pushing it into the struct mpr_data definition.

Might be a bug (I can't be bothered to work out the structure padding
to see if we end up with a gap after this) so fixes tag appropriate for
this one I think.

>  
>  enum mpr_func_id {
> 


