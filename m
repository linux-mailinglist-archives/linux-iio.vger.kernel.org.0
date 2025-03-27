Return-Path: <linux-iio+bounces-17290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A95A736BB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5E517DD13
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA931A707A;
	Thu, 27 Mar 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s8HJQPFp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E71A5B8C;
	Thu, 27 Mar 2025 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092544; cv=none; b=ZQ6kzh8Orh9gJY5URvF41RR49gxjiD9ESXg78bFndJuHHmM/DoBRsLs7ctU/ZNWeIuPzPvtwbAEbi47Ozvu4Dhf2OnDTsN6hP1ztFAP25Ulll6tgt/YpMjAI6dfbMgGSShLJ1dor4ldZsUQGxwUg3WNRgZ8MiJvWre7u9lSlnqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092544; c=relaxed/simple;
	bh=mcLTm29uxE+LHUzMUBAe15YyePJkeXPAXV8PfKG43+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uye8AJNlBzRljc49finhBce1LTEb1l40WJWBoHtpKPLf+EKFkOp7mg84kqg9Fj5YgPKta3I6whWpIeT1UEd6V0S04Tbm4/fCNtxEaubUkyJnaaKysBJF9URIrCrvewBgfTTjybZ/WL/o+o5asZ0VZ7D1Eta2jtnTc0vb55znZTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s8HJQPFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B88C4CEDD;
	Thu, 27 Mar 2025 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743092543;
	bh=mcLTm29uxE+LHUzMUBAe15YyePJkeXPAXV8PfKG43+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8HJQPFp81xLqPM4i9I/ckn7jGguWNpCJhvBapVTnTSlgCblVYYkCHnxJl6BDXwQ4
	 0Nbg4eM/MfPqW3VtVaGVEwEukbX3c5HMImBQ/RamX/vePiZ+823KYQOVxNNoi7UAta
	 Go56CsB2k+iW/ezMi0x0lcPsgA4tRxhyRTAufaqg=
Date: Thu, 27 Mar 2025 17:22:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>,
	prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Message-ID: <2025032703-genre-excitable-9473@gregkh>
References: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
 <20250327153845.6ab73574@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327153845.6ab73574@jic23-huawei>

On Thu, Mar 27, 2025 at 03:38:45PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Mar 2025 14:26:25 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > 
> > Hi,
> > 
> > Series adds some cleanups for the RZ/G2L ADC driver after the support
> > for the RZ/G3S SoC.
> 
> This doesn't address Dmitry's comment or highlight the outstanding
> question he had to Greg KH on v3.  
> I appreciate you want to get this fixed but I'd rather we got
> it 'right' first time!
> 
> Also, please make sure to +CC anyone who engaged with an earlier version.
> 
> For reference of Greg if he sees this, Dmitry was expressing view that
> the fix belongs in the bus layer not the individual drivers.
> FWIW that feels like the right layer to me as well.
> 
> https://lore.kernel.org/all/Z8k8lDxA53gUJa0n@google.com/#t

As this is a PM question, Rafael would be the best to ask.

thanks,

greg k-h

