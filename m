Return-Path: <linux-iio+bounces-19643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A775ABB131
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 20:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FC918917FF
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F221D5AF;
	Sun, 18 May 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACe4FwB7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D739FD9
	for <linux-iio@vger.kernel.org>; Sun, 18 May 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747591974; cv=none; b=TYFRsr2hnEK1zc7o4MT2hYWwkDLk57zbpxshGaf1YB//GV1L3xpmZ0KwPcG/j8Umjz/z6EdCyrymp/cYn0gNHop/tlrSo4F2vSPNNkZJ/+WqwZq+EqAhmLFJnGHCLu3sq6om+1EEhEbVbiz6/n+rd86N21r1NMM73tDGmIgvOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747591974; c=relaxed/simple;
	bh=AuPU3/L44HKd2Ev8mlvtwmOeEx1/pyyCLZohWHP17u8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=JM7J0QmwNbwxFIHTfp3oUdmS7XMIuXviRkLiLMiFZ4mlRJLS7wWbQb+1dDNqkNUBpfcTsVrZX0a0vMKcMPoF4MGQ2/ibZc3OWb7t3S/WXBcNjefnsgwI1Po3xGF+Y3xnqOz3sPcDE/WA0o8bs4rW3jIOVfRtTa6QZBREUjACfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACe4FwB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596B0C4CEE7
	for <linux-iio@vger.kernel.org>; Sun, 18 May 2025 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747591973;
	bh=AuPU3/L44HKd2Ev8mlvtwmOeEx1/pyyCLZohWHP17u8=;
	h=Date:From:To:Subject:From;
	b=ACe4FwB7Fraf52mWwxklnIJZ2hIpJKqIJA/z9UXRlB9zQfN9oFYkER9Mb6S3YXuLs
	 mQZL7mU10uikFRd27r13wIlA33/wD9grrVBigqjS5a8NqfUWEVghXzOcLBPukHb5ta
	 tCbvzRm2S306/76OtX2RRlO0mr171kGm4ahesV14xwWYT7vwsPfoDEr2JPzot7Ik8z
	 kXuskGjaf+58m9pVKInfWFrxvWIeq1sfhIDacjnWpnP8jb0CyClTQNgzxrQBJ/KFpr
	 JlQWJ+lKhyVCY8DxxhGlXQZgiF28cxRFWWDYU1nRk168UF7fl/OW4ZXjFABOYMD6e8
	 Zb8ktiKzR+Xxw==
Date: Sun, 18 May 2025 19:12:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Subject: IIO: Catching up after travel.
Message-ID: <20250518191248.65ca6537@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi All,

I had a fairly crazy couple of weeks so running a bit behind with reviews.
It may take me a little while to catch up but given the merge window is
about to open we should have plenty of time.

Thanks to those who have been busy reviewing whilst I've been largely
absent as that makes this rather less of a mountain than it would otherwise
be.

Jonathan

