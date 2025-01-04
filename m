Return-Path: <linux-iio+bounces-13891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF56A014EE
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 14:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F983A346F
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8A18FDAF;
	Sat,  4 Jan 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ5dU51I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A82F5E
	for <linux-iio@vger.kernel.org>; Sat,  4 Jan 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735996300; cv=none; b=KRovubBbxyy4zMTavpKvYjvtcFtb/vagFa00HLKZ1oz01yb6oCsq08f998Dk1Wk+zDBoDsnSWAGyigAJaBpzw9zt42jY4RYUznifGTrSjEc4If43JNXeKU8Jl1X4NabH6gtOPZZAhiarimyV0yqk4SjH9c3L5QZnmPXXz52NGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735996300; c=relaxed/simple;
	bh=rNfi0Db/kvS62EBWMmFIvzMf9Z98P4bJpkvWiI3ssr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gd8vxjpg2OkrPDxlsAVO7WDdVcSbDWpEfLXg47+QTz8AiUbgaNtXIkGSfHshzAEOclqu5T7204iM5ZhETLU2ak+/Ua7d5RTnTRco7sUqRuvXAVrhf7P3p1UR4hdKbWioYzNtLR5EfoWlcw31dj8COBjltwuLzk2f4X0QvYxDbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ5dU51I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1165C4CED1;
	Sat,  4 Jan 2025 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735996300;
	bh=rNfi0Db/kvS62EBWMmFIvzMf9Z98P4bJpkvWiI3ssr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YQ5dU51IJjcVI2Ecgrc1mVsF3cYLnzX37pqF5i0y3KcoB8JiXWWAr2/sejBEDI642
	 GLKa2hlssBOzu+RIecewNOYb/ZpID0Jb2WLkpoNaOg/dP6dwTH4K7kJCx8weMepv8O
	 NIlDb0CwEvBDFBQoa5g+h3BzHLO9v31sT+tDUD7BHrplzRR/M2WYsn2K7YPt3A6Dk0
	 +Z/NBAfnaYNG24eRqMA3ysJyz00JBytAwzO7SKnGRvC2kGd/GVyzG4A0v0sD+abJri
	 uZxDC4Je+N5TFxA/YwhaUBUylLhxSZgLCxjsjWQHOQ9JqY9o2lAadd4CNU+m4aR4IO
	 KsmPseWZXLq/w==
Date: Sat, 4 Jan 2025 13:11:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7625: Add ending newlines to error messages
Message-ID: <20250104131132.4c20b330@jic23-huawei>
In-Reply-To: <bbdd02f0-e40a-4ff1-bc7f-10f6b863d2ba@baylibre.com>
References: <20241230151030.3207529-2-u.kleine-koenig@baylibre.com>
	<bbdd02f0-e40a-4ff1-bc7f-10f6b863d2ba@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Dec 2024 10:15:21 -0500
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2024-12-30 10:10, Uwe Kleine-K=C3=B6nig wrote:
> > Error messages passed to dev_err_probe() are supposed to end in "\n".
> > Fix accordingly.
> >
> > Fixes: b7ffd0fa65e9 ("iio: adc: ad7625: add driver")
> > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =20
> Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

Applied.
Thanks,

