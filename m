Return-Path: <linux-iio+bounces-8196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47989469E2
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF3A1C20B3D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278114C585;
	Sat,  3 Aug 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDKQrDCt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188336A33F
	for <linux-iio@vger.kernel.org>; Sat,  3 Aug 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722692292; cv=none; b=LfGrW+i3VKZSdeY7NeNNlt0/oUR4sKJTRX6Lgj1Y8QPjEdipQauGyxK1fWPreXo34KvV9jEEfAIhl/ZkJFQEsh+C9Efys/JM2vN2W4Tg65eTcw3jay0POHPKmuOzAmF3UvAmgqE9s/L3v7Tk4siIq1U8vC/09F+8AV/maaNaZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722692292; c=relaxed/simple;
	bh=Psli5SB/s+zNndrwww7rAOw08B3qQnduIgLL5+8RF0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQMk5ByZMFyySTZVhnIBaXu8/lqPDdAllL5lH+SJUBSbsWw6DSI33aE2LlQovrLbLFiZ/xEC9JGUbVoyBwy/2tV09nMwOf/Pz8H+da6PHBovCybKd7SbT3eCLJ7kb2K62SByKNnxJZ1aaGDiF1YnKg5Fxfy7wriA/+VaG2TUAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDKQrDCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDA1C116B1;
	Sat,  3 Aug 2024 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722692291;
	bh=Psli5SB/s+zNndrwww7rAOw08B3qQnduIgLL5+8RF0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QDKQrDCtyZXbPe6brdr+yYXMJ/uDsLcBwE8bDzOBH/wu++RO6UrFh6324G3Gw8DtY
	 AdTkWo1shtjFRhWgH0pNcdjKcs+5vbifR7uKCcdymJlJKBZKAIb/H5YHO7cNh1faCU
	 YXheEd/NCGsQbMEXh4MaJ9TnCOj/14IfXvxvLo4cscD2IMlnXE+cGECJUW9tIiBKi1
	 wTFaRseK65zp4dl8K/o7EnKoaMLXkaPDBjQS5LxxhV+QS52KK8qS7p9yFFGKStzwBL
	 kLwPSA7NqY0GYFWt5vBaY3CvtJzhFfuArYJmeX0D6olDhwcwyLaZGAwuCCwMpS4LzF
	 FYAAo5sB+1MTg==
Date: Sat, 3 Aug 2024 14:38:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dragos Bogdan
 <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 8/8] iio: adc: ad9467: add digital interface test to
 debugfs
Message-ID: <20240803143806.17bd4e56@jic23-huawei>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-8-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
	<20240802-dev-iio-backend-add-debugfs-v2-8-4cb62852f0d0@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Aug 2024 16:27:06 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> One useful thing to do (in case of problems) in this high speed devices
> with digital interfaces is to try different test patterns to see if the
> interface is working properly (and properly calibrated). Hence add this
> to debugfs.
> 
> On top of this, for some test patterns, the backend may have a matching
> validator block which can be helpful in identifying possible issues. For
> the other patterns some test equipment must be used so one can look into
> the signal and see how it looks like.
> 
> Hence, we also add the backend debugfs interface with
> iio_backend_debugfs_add().
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I'll apply the series, but I would like a docs update for the
debugfs files this patch adds.  That can be a follow up patch.

Jonathan

