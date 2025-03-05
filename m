Return-Path: <linux-iio+bounces-16425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799BAA501E3
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACCA1898BB0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A8C1624D2;
	Wed,  5 Mar 2025 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz4JNaPJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443B24C089;
	Wed,  5 Mar 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184650; cv=none; b=PcbwQ4mZ+FXnjAXurFgKfdPPkSu4+dMedgKSQb6b7qPUVXTvGen4mbjh2X8RRNJjY9dc7Ji239+/orXO38DwIYXNEx5vX8Y2I+1wOfiBWj2nSrFHIlKy/fxjYXIaDvfG3oJeYphy8EX8JhUugrOX8IJssW2ViuyiDaNFrm0PAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184650; c=relaxed/simple;
	bh=qjIFghAqzxSp38ILvzrPxKS9tuDCzOwCSDS2Csdt7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enAhVSQ1PLkOO05iqa3Raj2ARFztUXngqizRAVrFiu6Df5pq1Qtt7Y5kZcVO/QiPpRJnNlBhM0gBgqGY7HO3D3vA09EpOvPFJxD1rZ9Uh5j8tL0GJ/gNoT8GzVyMG1+Jd7UwEjlvGuEFIFUSBxGezqVmcTMDnj0+3c4tNgwFNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz4JNaPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2496FC4CED1;
	Wed,  5 Mar 2025 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741184649;
	bh=qjIFghAqzxSp38ILvzrPxKS9tuDCzOwCSDS2Csdt7wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lz4JNaPJkppbPkN8SgD6IyMXsgyVB1EjCyxqwpgKh5rFtWv+ek95I5nQFyMTCelPT
	 2fws/6oRqsrkzCSBsq6HhdDJeBO2qQi1BHBuh7KOJCWU+43edpWBhc+Lm1UWrLJ1Di
	 Po/4UOldqF5cxqE8pogFIFsawg806zjjNqSKCJRrSappM/JzXRXz3kEzD2fPRbyCPh
	 s+oT2XIRSkbnLwlBS6IRvMrv/By8xEHaaen8oycddqSFaiYLKCfz5wB+rUJUTS1dXu
	 PDg8TvWMSRjJjUWFxDps5uUXP7xC1PURzRAXRCNYi4rh0e5dUGJAD3of6kmeIPqucO
	 UYWJbU2I1UQ7Q==
Date: Wed, 5 Mar 2025 14:23:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com
Subject: Re: [PATCH v2] iio: filter: admv8818: fix range calculation
Message-ID: <20250305142358.6c916e7c@jic23-huawei>
In-Reply-To: <Z8hNdR21h7b7V8Kx@65YTFL3.secure.tethers.com>
References: <Z7crV0DV1Fq7wE1Z@65YTFL3.secure.tethers.com>
	<20250304233411.3fac7c69@jic23-huawei>
	<Z8hNdR21h7b7V8Kx@65YTFL3.secure.tethers.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 08:11:17 -0500
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> On Tue, Mar 04, 2025 at 11:34:11PM +0000, Jonathan Cameron wrote:
> > On Thu, 20 Feb 2025 08:17:11 -0500
> > Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:
> >   
> > > Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
> > > the ADMV8818 datasheet
> > >   
> > Hi Sam,
> > 
> > Just a trivial process thing.  If you are sending updated code
> > and there isn't an obvious reason why when someone looks at the
> > old patch set (e.g. no reviews asking for changes etc) please
> > reply to that.
> > 
> > At times where reviewers (such as me on this occasion) are running
> > way behind they might look at wrong version otherwise.
> > 
> > Jonathan  
> 
> Hi Jonathan,
> 
> Just to clarify, if I update the patches in, for example v2, then I should
> reply to the v2 email with the new patch set?
> 
> That makes sense... it looks like I can use: "--in-reply-to=<Message-id>" with
> git send-email.

No, not that!  That needs to nested mess in complex threads.

A simple reply from an email client to say that you are revisting for
'x' reason is fine and that you either have or are about to post v3.

Thanks,

Jonathan

> 
> Sorry for any confusion this may have caused.
> 
> Thanks,
> -Sam


