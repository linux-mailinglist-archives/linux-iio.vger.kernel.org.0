Return-Path: <linux-iio+bounces-19790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18744AC0A75
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C715417B632
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C6234962;
	Thu, 22 May 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOehXv/I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC0221FD0
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912628; cv=none; b=HgUZCahR0WQSoRRLn4w8qobQ8WLzqpfy/g0npM9+xhqE5QYDJotXleM5kzlRi+WYOCgEA0s0y2O/+jgbebXurmozBGKDZrI8Ip4nD4IEDItLdL8/AENu1DpFcW9pOpOCOH7bcfVU+B4IiLqQgRf0rUeNQhNkXgpTuEKuhC2Q6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912628; c=relaxed/simple;
	bh=rlEMd/wu95TAXuLGUT2m9qOLjaYm3V9nl/u6a/1Gxjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5uQxudqgpSoag6p8A6eyyWWEzzlQwbswrIg5hk1C7TPSl0QW6mFZy60/IXSgQKWQWsgesu+VCvk6tVBjQNy8/Fx/R+jA5Gt3wrAuv70sAPGIHls6lO58nEG2etuM1LzWMYmToYC2ijoEc2YtLhI6DBJYukj1d8MqbzhSwIxgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOehXv/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24286C4CEE4;
	Thu, 22 May 2025 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747912628;
	bh=rlEMd/wu95TAXuLGUT2m9qOLjaYm3V9nl/u6a/1Gxjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOehXv/IGDhDrx9EQaLI1V38v9+NLGKHUzdEYgffZDswjmaZ0qr15cv4nUloWWpYC
	 nfjlvgYpXhDRGedUu2+8d1m2ORw3z6VrlctafFMu/MkkPbp9YpBqLjdbDMGrK3GxOR
	 VNO82eryW8M/yi/eThQ41y6pcCXfy35hOoHmX5jPlTco7N4qHc/+n/KFcTjtRsM8xO
	 LNMSYmwOd0jaj9jJ1JUH9nlFrlXdJThwAJoXo4PKK5YivLVnnSlyApQMuQtE4+QOA7
	 xdyOp1TCppU+E1JfttXEQpjJbeh4UFYYMG3UFvCpeLaA8Db06C2Cf9vpKHpLWZ8m5W
	 nFa9PY0BDPXFg==
From: William Breathitt Gray <wbg@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter fixes for 6.15
Date: Thu, 22 May 2025 20:17:02 +0900
Message-ID: <20250522111704.784288-1-wbg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052211-dealmaker-unblended-c2a3@gregkh>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=wbg@kernel.org; h=from:subject; bh=rlEMd/wu95TAXuLGUT2m9qOLjaYm3V9nl/u6a/1Gxjs=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBn67HMFlY8v2JX5xV9UXSnpwuKyA6pH2ov2/1Kxzirgu +Z/4hN7RykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRc/qMDP/btWOUGvO3TvFR 2zL/+aWDDIdm2d/p4sn9PuE5f2N1SibD/7iybikNGa3bcW83XtWS/M6328ZbzWHyzotxNinaZ27 H8wAA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Thu, May 22, 2025 at 01:12:44PM +0200, Greg KH wrote:
> On Thu, May 22, 2025 at 07:13:22PM +0900, William Breathitt Gray wrote:
> > On Wed, May 21, 2025 at 02:07:29PM +0200, Greg KH wrote:
> > > On Sun, May 11, 2025 at 03:43:29PM +0900, William Breathitt Gray wrote:
> > > > The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:
> > > >
> > > >   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.15
> > > >
> > > > for you to fetch changes up to 7351312632e831e51383f48957d47712fae791ef:
> > > >
> > > >   counter: interrupt-cnt: Protect enable/disable OPs with mutex (2025-05-03 08:45:11 +0900)
> > > >
> > > > ----------------------------------------------------------------
> > > > Counter fixes for 6.15
> > > >
> > > > A fix to prevent a race condition when accessing the Count enable
> > > > component in interrupt-cnt.
> > >
> > > I took this into my -next branch BUT for some reason you have this
> > > commit with a Fixes: tag but NO Cc: stable tag.  Which means it will not
> > > get pulled into the stable trees automatically.  Are you sure you wanted
> > > to do that?
> >
> > Sorry, the missing Cc: stable tag was an oversight; this fix should be
> > pulled into the stable trees as well. What would be the best way for me
> > to resolve this, should I RESEND the patch with the appropriate tag and
> > Cc stable@vger.kernel.org?
> 
> It's already in my trees, so it can't be changed.  Just remember when it
> hits Linus's tree to send the git id to the stable list to ensure that
> it gets included there.
> 
> thanks,
> 
> greg k-h

Thanks for the heads-up, will do!

William Breathitt Gray

