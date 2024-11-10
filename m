Return-Path: <linux-iio+bounces-12100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209E9C311F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 08:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7084B1C20B35
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 07:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C714A4C7;
	Sun, 10 Nov 2024 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hNEkne2B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4AA18E1F;
	Sun, 10 Nov 2024 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731222229; cv=none; b=QNIhS2NKof35DY/5LrCx4Tw2qx1tnUeV2NDITTE/NB2yOUZOidbaG+yuNkZnSzgBRC3MI2Siw5a8vd1qgL6rbhRiv4SoXnovgjQLjqqprvzVuISSDdmPQPRP53biWYtpQQ9M7aQEM+6cjEuID8LUjVQZDIeHivNGi6hyOEK3PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731222229; c=relaxed/simple;
	bh=rFmUl8hnbkFaAtL4L5pqaOHZEA0T2QInlozj5hrnwAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mqn7TOYiVJgYFyB1SQUYCOut/Mi6KyvhvvEZG6LoiPW/VwHOUOgc0rzvyp31pg4Xey5LwwGMrNKiXaMSDM+fs31c/YWa1MVzbSWsTJWpcs2/iEmRiVYzn2lDCrIouIew2VNPainXrYMVw6PZaxD+ZuvHrwA9/x8d6WH5UQ6uCSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hNEkne2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68C9C4CECD;
	Sun, 10 Nov 2024 07:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731222228;
	bh=rFmUl8hnbkFaAtL4L5pqaOHZEA0T2QInlozj5hrnwAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNEkne2B2YgvgbkPLBddqWLNjPRTVZ/yHlumAN+Q+LKNkkfaWOSA51sYZE99kFUo9
	 gVlZ0epOLuldoUziEaHYHeZLgJJAreksunydq6VDAODKrxSOwC6g7Z4Nb4KIlYvb2j
	 YXg2Z1SHDtKPKfI+iNaUMtkE82v7bQh2OTloLM/Q=
Date: Sun, 10 Nov 2024 08:03:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>,
	lars@metafoo.de, parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com, sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/4] staging: iio: Remove TODO file
Message-ID: <2024111007-hardhead-washboard-ecb4@gregkh>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
 <20241107172908.95530-2-dominik.karol.piatkowski@protonmail.com>
 <20241107183908.248ed108@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107183908.248ed108@jic23-huawei>

On Thu, Nov 07, 2024 at 06:39:08PM +0000, Jonathan Cameron wrote:
> On Thu, 07 Nov 2024 17:30:51 +0000
> Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com> wrote:
> 
> > Remove TODO file, as it only contains contact information.
> > 
> > Signed-off-by: Dominik Karol Piątkowski <dominik.karol.piatkowski@protonmail.com>
> > ---
> >  drivers/staging/iio/TODO | 5 -----
> >  1 file changed, 5 deletions(-)
> >  delete mode 100644 drivers/staging/iio/TODO
> > 
> > diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> > deleted file mode 100644
> > index 0fa6a5500bdb..000000000000
> > --- a/drivers/staging/iio/TODO
> > +++ /dev/null
> > @@ -1,5 +0,0 @@
> > -2020-02-25
> > -
> > -
> > -Contact: Jonathan Cameron <jic23@kernel.org>.
> > -Mailing list: linux-iio@vger.kernel.org
> 
> kernel.org entries tend not to get stale very quickly.
> 
> Indeed redundant.  I'll assume Greg will pick this up if he is
> happy with it.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, I'll take this now.

> Hmm. We should probably write a meaningful todo for the left over
> IIO drivers in staging beyond 'fix the driver, mostly ABI issues'
> but doing so involves going half the way to actually fixing them.
> 
> Every now and then I moot just deleting them all and instead
> poke Analog to remind them these exist.

I suggest just dropping them and see who screams :)

greg k-h

