Return-Path: <linux-iio+bounces-4767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AAE8BA693
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 07:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E1B1C21D0B
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289A13958B;
	Fri,  3 May 2024 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lJFIWcFG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5035E2C181
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713707; cv=none; b=kxVXJYa5KyapX+/SNFsa+RUvsLYsFvIHdWT5FdeblbqqqtLQ3/12Kr8nWmGPDKd2WO2U8TjF+l2Z8Q7hyKkQVqt40Rn5cDiKboa3yqOpWbLYYiBHAX2Db3BTsq9QgCIrL9ZVsb29KUMUlURR/d3gkwMtXLyIvgewq70Lbc/XQUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713707; c=relaxed/simple;
	bh=D958QUulwOQIsF5ZCDtl15zFUR/qzRK89q0qzzzH5U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGcgbjOA2oLr2rR6rv17n9qTKKQzYR6lVOgfvYonAm8oJSw5/yCmKPzsE2VpM5NRzP+Hv1lKznuWSXLPks8FrLlVmBq8SV2O/7oFwRn1P/CftNS7qskKQZHQAx4FlF3aIvwKuQ+cWKNyIGB2832Kg8k9qOX4bKuayOQl8LuJ7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lJFIWcFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC69C116B1;
	Fri,  3 May 2024 05:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714713706;
	bh=D958QUulwOQIsF5ZCDtl15zFUR/qzRK89q0qzzzH5U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJFIWcFGtw8GualUewDCcreY3n32wKN36RhXW3Ni/U7VLxZdj95dd+zuGp9EAQKb9
	 5uqd7SfARyTIL9lvFVohJiNhcKzU/P+RdwImDFC9xaVG1xyVrA/9FdlSQNnGKXsS3t
	 7xybflmPuTpkYmYE/2yd95Cme1gm9+1d6OU0Zic4=
Date: Fri, 3 May 2024 07:21:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for the 6.10 cycle
Message-ID: <2024050321-preshow-unaired-01de@gregkh>
References: <20240502201509.14ae8880@jic23-huawei>
 <2024050353-compel-daycare-f7ce@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024050353-compel-daycare-f7ce@gregkh>

On Fri, May 03, 2024 at 07:16:02AM +0200, Greg KH wrote:
> On Thu, May 02, 2024 at 08:15:09PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:
> > 
> >   Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b
> 
> Pulled and pushed out now, thanks.

Oops, nope, got the following error:

Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
	Has these problem(s):
		- Subject has leading but no trailing quotes

I'll rewrite this one, but note that you will have to rebase your tree
now, sorry.

greg k-h

