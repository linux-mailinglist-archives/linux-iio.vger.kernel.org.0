Return-Path: <linux-iio+bounces-19787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC0DAC098B
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 12:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E24167402
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 10:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDC028851A;
	Thu, 22 May 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCJaVIE+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0824E4C6
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908813; cv=none; b=oEkVUT2E5xcz7tnJMZcqx+3uSRWV0pFWDAErbb3yt7MlEEGolt68KFBptl4az6b6d+cxwdXnCBp5Bz7smBr9GxmBtT32PrIEDLwO/NMzZkZHwluM+czmrWLSLaoTctJ4cBjAaVO8EZFD68gm2+N2cXGjPuwvkdzbVkf60CZ6Z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908813; c=relaxed/simple;
	bh=bcqbB7I+wI4Z39A3ibWpF7oxMdsGYECgCxJXjqOgGpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0gCoGCfBQogikTaSWlUyqFhvRYjFmftp8kqKdKGJjMJCceZeVhiQD2/NR2mqnMTze1qBB6mgZ0XbuHX0pclE/jj79/JisATLCXrjqLPoWpEmO68lRe5lUWJLWDuiRmcH4sRQslERw/GmwJ7d8PCX01tKOdq3cdLFuZsnj5K2ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCJaVIE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B365C4CEE4;
	Thu, 22 May 2025 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747908812;
	bh=bcqbB7I+wI4Z39A3ibWpF7oxMdsGYECgCxJXjqOgGpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCJaVIE+5z/xckFff8ycK0jWVVKRTHGgDeUVZN1uhRWWeAQuasrYO6GzxS0qZPNt0
	 T7Ygjidn18GfDPwxl4o4Z3ETByy+4j7Shc1LouYdYdRSsWWtY1RbxI4quLI3reEcUv
	 413j7ch1SzbCrFjCKqs/nk7eUbhid19L4LlF4d1GYPYqRuX4NSBfrcWU1cNyCI6GXp
	 ff8s4Xs97VMPhiBJ2jvlZvnZySvPz+tSRuHZRI+7KPIGiFbvgWLSTrwavEiXe+xSMp
	 rlD2nNY6x8EuDwF//ZBbQNPQJ4WddKzboQ5dorMYH+67UW/7M3myhrrdP0ybNV7Us1
	 ux1uaOBXT20uw==
From: William Breathitt Gray <wbg@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter fixes for 6.15
Date: Thu, 22 May 2025 19:13:22 +0900
Message-ID: <20250522101325.779686-1-wbg@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052145-culprit-underdone-c69b@gregkh>
References: 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=wbg@kernel.org; h=from:subject; bh=bcqbB7I+wI4Z39A3ibWpF7oxMdsGYECgCxJXjqOgGpU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBl6P7aWavAd9Lxmn8bN4zOXb6KO6QqlTX+6cw91dZZNq b7z99WWjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiXQYM/7TSlvta5G30n/NT ouMCq/crrZnCk9ZxLrYrnSSy9v+yNWYMf6XyF+lfFFHTFjYzO/J3zmtTxV03LJoYmc+u5J8uMvm fPhsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Wed, May 21, 2025 at 02:07:29PM +0200, Greg KH wrote:
> On Sun, May 11, 2025 at 03:43:29PM +0900, William Breathitt Gray wrote:
> > The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:
> >
> >   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.15
> >
> > for you to fetch changes up to 7351312632e831e51383f48957d47712fae791ef:
> >
> >   counter: interrupt-cnt: Protect enable/disable OPs with mutex (2025-05-03 08:45:11 +0900)
> >
> > ----------------------------------------------------------------
> > Counter fixes for 6.15
> >
> > A fix to prevent a race condition when accessing the Count enable
> > component in interrupt-cnt.
> 
> I took this into my -next branch BUT for some reason you have this
> commit with a Fixes: tag but NO Cc: stable tag.  Which means it will not
> get pulled into the stable trees automatically.  Are you sure you wanted
> to do that?

Sorry, the missing Cc: stable tag was an oversight; this fix should be
pulled into the stable trees as well. What would be the best way for me
to resolve this, should I RESEND the patch with the appropriate tag and
Cc stable@vger.kernel.org?

Thanks,

William Breathitt Gray

