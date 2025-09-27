Return-Path: <linux-iio+bounces-24500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B272BA61C7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4558F16CF70
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42A284B29;
	Sat, 27 Sep 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQbd/Z9r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0B14BFA2;
	Sat, 27 Sep 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758992187; cv=none; b=nQZFIuFbSDTDz4tRH0/WQv3JiCJsuGi924cD0m3zy9ZpcEtkl6V2sHXBXN6MnfPsIwO2ZdjnatZv9danSWF8k/AfeZhXzDoM74L37Vm68+9d/oL61pg4TJnOwa2C1CVmErgMbEaD8NIxlEp6rjkwek6UcV0AcDb0RI+89HTuzVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758992187; c=relaxed/simple;
	bh=+xMErzx3xlH0CNRhIykgywnLJ0axfxZcS05DruUxe8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+irBB3caGdUHiOXkrR/WY7G37lba5lVLiGbk8bvdqyDTlr+jCEHfmT3orWgI0XkmG5qOsdUfCF5zQ0kHHFkVaN8YFc2qUHIejWS4pxYADprcXAaP7nOr2GEL+K8DrUopGvkMrbQ0icl11yHSfGZ9YEEQyeEVA6LinSHALZUo1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQbd/Z9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B94C4CEE7;
	Sat, 27 Sep 2025 16:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758992187;
	bh=+xMErzx3xlH0CNRhIykgywnLJ0axfxZcS05DruUxe8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hQbd/Z9rZCqjz6yqI+Tjf9uSSK6+L48ofapGUWlyFcRddILfP+mvCAgD1Ug3d9lJD
	 ll7QsHMQ7alkd0pWTE2cS/yq/rQO74tHijeKH7SRUH+6k8EFtZJWgkoEo9OXhlEv3j
	 USYpR/hdQtoHeyM7N1vUk3nSWlArDUiJJtwgEr3sK5iGn/nUvpGqS3H6iLVvwPEylk
	 MIjcBQBvEw0kKztjxC0G6Y3RrpLFaiE1qQ00fKct2mtMefaHO6BzYuqQsUFg5l8Lwp
	 GPzyDRr2lryyfVDHLyUmMzGzInPhN1zoIrT8XPVtJAU44tlbVEIBtEFH6uJGC7RLuY
	 pOwXwOUqH3I1A==
Date: Sat, 27 Sep 2025 17:56:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux IIO <linux-iio@vger.kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: iio: ade9000, adis*, adx*: Convert IIO
 subsystem cross-references
Message-ID: <20250927175618.5624655f@jic23-huawei>
In-Reply-To: <e233370f-f23b-47b4-a31e-25c2df99a0f5@infradead.org>
References: <20250922063754.21190-1-bagasdotme@gmail.com>
	<e233370f-f23b-47b4-a31e-25c2df99a0f5@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 21:46:40 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 9/21/25 11:37 PM, Bagas Sanjaya wrote:
> > Cross-references to iio_tools.rst (IIO Interfacing Tools) and
> > iio_devbuf.rst (Industrial IIO device buffers) are shown in inline
> > code instead. Convert them to proper cross-references.
> > 
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >   Documentation/iio/ade9000.rst   | 2 +-
> >   Documentation/iio/adis16475.rst | 4 ++--
> >   Documentation/iio/adis16480.rst | 4 ++--
> >   Documentation/iio/adis16550.rst | 4 ++--
> >   Documentation/iio/adxl345.rst   | 4 ++--
> >   Documentation/iio/adxl380.rst   | 4 ++--
> >   6 files changed, 11 insertions(+), 11 deletions(-)  
> 
> Much better. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
Ah. the wonders of cut and pasting wrong stuff.

Applied, thanks!

Jonathan


