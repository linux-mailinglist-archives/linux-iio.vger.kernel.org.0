Return-Path: <linux-iio+bounces-26074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E6C44124
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 15:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFD4188C686
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9E2ECEBC;
	Sun,  9 Nov 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siUIBeWL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787E1A3166;
	Sun,  9 Nov 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700364; cv=none; b=ATYvmm29oMJfGYfqyu9R9T8p0Z9Ojvh+hMDNSsQ5FcmMi9UeRanKhuNsFvgxoPBPKCugQJJdnf0o74PfDzmhtE3Q+jC08SXVXSEw9UWKCIAcuEPd2igC7ZSDWgN16Pj0pJUAYBuLLe1Cg3sgKTTU6o1bGDHXVXlvGozAh8aD67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700364; c=relaxed/simple;
	bh=6I+rtMwPOpHelGKHeHeJCjRyftYlrRQQORU7itCScmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nW5pv6ukdSU89E7HGFLWhoEk7yWsJ5fsA5wvAeGAh/Xq7JEFR3l4+t0xxLfbGoNfQ/R8pue/QS9MZJjBIHPETPCyxqNmM0JMY1r82vwhUFZ3/7T5qXaRQE/ja2pF34KXjISUO8FSumgIIqDDXMmnvbtfYbOC1dHVUGDQ79JEk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siUIBeWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111FC4CEF7;
	Sun,  9 Nov 2025 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762700363;
	bh=6I+rtMwPOpHelGKHeHeJCjRyftYlrRQQORU7itCScmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=siUIBeWLo0bQClbaxHIX/stwa4n7lLxUQ4WPAvlDir87urjXUoGItl1j8InqhfpFV
	 JefPWOfhvLOVdV8VlStHi6ku34NoacxhOnMVbdeetsSWKcLcC8lyj05lgXwwIz+1BJ
	 gtuFXGhme5v06E4QdDbn43iemfBMN4xM01v25dnYwPJy+2cssmgFGY9mlSVrdjkhiN
	 KSyOwpz/mf3cQ4O5cVAVhTEUoK0n+DsRy/dibh2hM6k68G/KhhZw16kDH3hSdXw7x2
	 rAQRHlleT2TF6oDSl1zfgfPEssnq4v/bMkIAcmeuUtVnFbrJLjj/WDD4aNMdcxRCHG
	 21IpUl94jn3qw==
Date: Sun, 9 Nov 2025 14:59:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jyoti Bhayana
 <jbhayana@google.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: common: scmi_sensors: Get rid of
 const_ilog2()
Message-ID: <20251109145918.3dad4862@jic23-huawei>
In-Reply-To: <20251103082937.4081863-1-andriy.shevchenko@linux.intel.com>
References: <20251103082937.4081863-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Nov 2025 09:29:11 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Fisrt of all, const_ilog2() was a workaround of some sparse issue,
> which was never appeared in the C functions. Second, the calls here
> are done against constants and work with a bit of luck. Replace
> this altogether by a pre-calculated simple integer constant.
> Amend a comment to give a hint where it comes from.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

thanks,

J

