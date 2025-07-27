Return-Path: <linux-iio+bounces-22039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7160DB12F7B
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C20D189A26C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2D18A6AB;
	Sun, 27 Jul 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+GfULkE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897387E9
	for <linux-iio@vger.kernel.org>; Sun, 27 Jul 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619628; cv=none; b=Bj96pr86dAzl3UTgZQGB63+za72wn0NoqIPRN+WBcLcwL3WbL9xndOKvll+po+5BP0IxK4KFU3Hd+DLgkduHek8jTpGcq2EBe9kZgqp0FjNZyiw5i3qbBeE1SL7p3YhcNHH+mNZjU2tARoQVxtGsuF+3AlZ+JptAXHn0nqiLOmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619628; c=relaxed/simple;
	bh=8uBguKZeCVOhqQ5Hph8RZUh4m+B9W+1858GuujQUnys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7zCWaGQzoyPwMQgPuG2dD7WqCWIIPtVLyCVPQVk/g9OU0vn/pSnwTZOpAJl0te19X305zoN9jJaFOHZCQzFURoRGoCRaaWWkQu+ef/N3ExJOAEjE5kySu39HPsxGwZz6sA0MNCqGOSPF8R/E6CePa8DfqV4sh5FkNXtuUOgXiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+GfULkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E8C4CEEB;
	Sun, 27 Jul 2025 12:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619628;
	bh=8uBguKZeCVOhqQ5Hph8RZUh4m+B9W+1858GuujQUnys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+GfULkEHMekQktESMsXGU1wAC9Nfu0VjtmZYCrTH62fXCTKfLg4MuovIs40/FoCI
	 3KrcEyZKLiIU/k89HpgPoMNMff9elff+py/FSmonsrrExQapW6VVMBT9mmsE/JE0T7
	 +KXA0OFVsyMUwWrxuAiP8ok9Ph8Je7wUpiM8wuHYRWPWnzNgH4x1FKCHzE9zSlNtEK
	 pUjkBBO1FbHjoDnG+CsGa1RGCxgUv2RTCO2MVwOFiFZNBJ1Aby/OxwbyQQqQcm95Kr
	 L6HC4MSi5I6f/N+6CyQ7T9wy09bpEfNsUpcuJAvt2pBxo3yIhfKF0fzpG9VCiqUL3F
	 8qzqZmtqQTfug==
Date: Sun, 27 Jul 2025 13:33:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= via B4 Relay
 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer: buffer-cb: drop double initialization of
 demux list
Message-ID: <20250727133341.05f4f950@jic23-huawei>
In-Reply-To: <20250725-iio-minor-cleanup-v1-1-4e561372142e@analog.com>
References: <20250725-iio-minor-cleanup-v1-1-4e561372142e@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2025 07:32:55 +0100
Nuno S=C3=A1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> Drop the call to INIT_LIST_HEAD(&cb_buff->buffer.demux_list). That's
> already done in iio_buffer_init(&cb_buff->buffer).
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied. Thanks,

