Return-Path: <linux-iio+bounces-17427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ACDA764FC
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE927168236
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45AC1DE4E3;
	Mon, 31 Mar 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTBINCfu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8117A2FA
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420807; cv=none; b=UI6jxSLA1uNqJ8X2gRFJhp/IdeTBVnRzQVURjE6UxiDxYHNpi9J1tdLHg1oCaAFZLjkzJtaenupuu5Nnn8k2IQgTl7uGc9AtdIm5+wQtF9DgLvsbJxsIiZq/hj/0lEKyUiOPxZKO/MqdeuYhyCVZurOjnI8eDGH2lhpz6L5hIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420807; c=relaxed/simple;
	bh=AG7Q5BnJaUJud+ti/GAsZ/1ojpJoiEAvRtx93mtiIlI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDFQW5tP7l7I1gZ0r7/jbYcIu+fkNvOQsN16hCURCA5CxRXSb0GnrisTAD+CcLBeazeQApIVncnV35f0rSG3VOoarXam48ACBiBsCpsfi4F2SuF8QdKC+CQnMdSA/auzWKEtgz/jIUgciGepgdaQUIXPGsB1+4oWW/VvPhhVPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTBINCfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A3C4CEE3;
	Mon, 31 Mar 2025 11:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743420807;
	bh=AG7Q5BnJaUJud+ti/GAsZ/1ojpJoiEAvRtx93mtiIlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sTBINCfu1vE1hvlmOhAGZrxlHFSTQfuTGjEbf1GXOaXYwgqYVfl/Wmouladcq1VYh
	 mWdiXXhEF/WaS5mbtecSmw7wfadmwP3zNy2GTNeq3gttCkAWWj+Bvb5Rkv3KgzDjxc
	 26yt12L4cUzEgTJN9fkn3Vy5hIMYsnqQuWs7/R4ZkS1lN+26U0/PssdL0F862NdXrA
	 6YdcdGd21/70yCATBKG8l/0Tny5AUTn8HC7HhYZJCNjWy278iy6WnWdTzLZgbiik0l
	 t6xJ22gpyWi4NKWcQeTX0TatXvRU0bxq3oDYGuoZSPd0hqLaoEnxcAShVwSZU4NbXO
	 IFgAPC8xpHi1w==
Date: Mon, 31 Mar 2025 12:33:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Frank Li <Frank.Li@nxp.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, linux-iio@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Marek Vasut <marex@denx.de>, Mike
 Looijmans <mike.looijmans@topic.nl>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 0/8] IIO: ADCs: Sparse friendly claim of direct mode
Message-ID: <20250331123321.640c8c6e@jic23-huawei>
In-Reply-To: <c1ffdd06-4907-4f6a-8cfa-698be64a1e79@baylibre.com>
References: <20250309165819.1346684-1-jic23@kernel.org>
	<c1ffdd06-4907-4f6a-8cfa-698be64a1e79@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 18:21:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/9/25 11:58 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Resend of remaining unreviewed updates in drivers/iio/adc/*
> > 
> > I will eventually just apply these, but I'd much rather someone
> > else took a quick look to check I haven't done anything stupid!
> >   
> Only managed to find one little potential oversight in patch 5/8.
Fixed that up.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Applied to the testing branch of iio.git.

Thanks for reviewing!

Jonathan



