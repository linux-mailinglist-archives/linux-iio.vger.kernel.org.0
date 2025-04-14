Return-Path: <linux-iio+bounces-18118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCE1A88BC8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ED7189AE07
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E287B28BAAD;
	Mon, 14 Apr 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj3jeW8k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517828B518;
	Mon, 14 Apr 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656800; cv=none; b=TW1wmq0mBE9NsxTXVKf+PV/BFfXyrFsMYAZIwwbt2CljsN+m1PCM/azGqS85V5CYQn6zPOdbpt7DiCGMPasyPTKXMPne1rmKRsdJLe7ACbvw+Zzm6s0IUVgAiY5Zcj7lInHrwyfEKivOolgMOb0f0KG1KjM/Fpuo/TevupTI+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656800; c=relaxed/simple;
	bh=fOXHTuFEy8BcwPnOUIuFPVYxOii1nkPm25ZbbL/uZAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH8pGba+bD4iLZrs8gTkoWES1COGq7nzRd7aUlnQwbpODg5zTfT1ngUPyaABsTYNO387pdua90tLq3454jiL2CwkNLcToZUoB9JfvqVphXL4SgrCrCyDBlsULvVHrzpRYTesterEXL0w8VqeE5SUWOhSIGpEnzijdlIA8Jus7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj3jeW8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AE1C4CEEF;
	Mon, 14 Apr 2025 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744656800;
	bh=fOXHTuFEy8BcwPnOUIuFPVYxOii1nkPm25ZbbL/uZAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hj3jeW8ket3ot1aAXNwtOuqNU8GADgcExTtC0bOnEZUtzKlOqTCxXPASPNzFhXjwA
	 svzWoOYmt0gkhD71BfR9xyr5Qc7A3eQMhyqZ5FOt/i1Py/Ms/AcdC/t/tjcz8bgnZ4
	 xfjC+/W7I/VjRpD+WDSiuizU/OErb/YLvToMYi8xrT/lXuMRwBEuGd+bF2yGQ3TcpF
	 RTdgcWr7ZLp1Zl7328HShPtojRPRNXpUAxFRI/g2Ij3hAlYaLeS4DG18M4zPgr/NiS
	 Ivvg6oi62y8Turqm/N+4yUGW1oMkbwoZxFZ63V1Rb4SXJ6h+bwlWHHyZeAZKPZS1FV
	 YA6ljFO+4b0mw==
Date: Mon, 14 Apr 2025 19:53:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Siddharth Menon <simeddon@gmail.com>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v6] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <20250414195311.6a406c35@jic23-huawei>
In-Reply-To: <Z_v93dtgks2CquIn@debian-BULLSEYE-live-builder-AMD64>
References: <20250413120354.19163-1-simeddon@gmail.com>
	<Z_v93dtgks2CquIn@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 13 Apr 2025 15:09:33 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Siddharth,
> 
> Your patch looks good to me and I keep the review tag offered on the other email.
> One small thing I noticed right before closing the driver. See comments below.
> 
> On 04/13, Siddharth Menon wrote:
> > Use bitfield and bitmask macros to clearly specify AD9832 SPI
> > command fields to make register write code more readable.
> > 
> > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> > ---  
> ...
> > +
> > +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> >  					st->ctrl_ss);  
> I think st->ctrl_ss alignment with the preceding parenthesis could also have
> been adjusted since the patch is updating the very same assignment.
> 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> 						  st->ctrl_ss);
> There are some other places where similar change could be done but these are
> probably not a reason for a v7.
Good spot.

I'd like these cleaned up. I could do it whilst applying but as there are quite a few of
them it is probably quicker to send me a v7 ;)

Jonathan

> 
> >  		ret = spi_sync(st->spi, &st->msg);
> >  		break;  
> ...
> > -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> > +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
> >  					st->ctrl_fp);  
> This one would have become 
> 		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
> 						  st->ctrl_fp);
> 
> >  		ret = spi_sync(st->spi, &st->msg);
> >  		break;  
> ...
> > -		st->data = cpu_to_be16((AD9832_CMD_FPSELECT << CMD_SHIFT) |
> > +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_FPSELECT) |
> >  					st->ctrl_fp);  
> Same here
> >  		ret = spi_sync(st->spi, &st->msg);
> >  		break;  
> ...
> >  
> > -		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> > +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
> >  					st->ctrl_src);  
> ditto
> 
> >  		ret = spi_sync(st->spi, &st->msg);
> >  		break;
> > @@ -396,7 +400,7 @@ static int ad9832_probe(struct spi_device *spi)
> >  	spi_message_add_tail(&st->phase_xfer[1], &st->phase_msg);
> >  
> >  	st->ctrl_src = AD9832_SLEEP | AD9832_RESET | AD9832_CLR;
> > -	st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> > +	st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SLEEPRESCLR) |
> >  					st->ctrl_src);  
> ditto
> 
> Regards,
> Marcelo


