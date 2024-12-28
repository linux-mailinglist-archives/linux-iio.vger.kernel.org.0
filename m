Return-Path: <linux-iio+bounces-13842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF039FDB83
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF341614DB
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A5160799;
	Sat, 28 Dec 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+muVLQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA04B67F;
	Sat, 28 Dec 2024 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735400470; cv=none; b=Yb6FuURz+X4lMWHm9lAyPTqDNbE+0wf1tgBgioU+zsSmcL8PHMctayiUqas3nEgBKUmLqjfvoeo59BQ/oLZa23l7An/rLsZwNkJ/VFv4zrg/+ZCNx3zjjdQm6rlvfDX/4MnelqNpJoK3aGwlIsGME1QNnnLHQDXzdRLUNoSJz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735400470; c=relaxed/simple;
	bh=H/smT9WIQrV0an7KQDRTFZ3lwhDFTLFEQDU1vJb6i1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWH7z254TEIA60CWE1Py/xDxAob3XmnH0kL4XJTZX8I0bWQvFu0vt/VW98Z04rKsp593dtpTLAR3hXu6VdVF5v9+tqggjKajdcbQSkgCgiY4+GVXt7pYhPYuCspoI0apbg8Oszx17Xg9y4D+VzgvUi1NYbGwww0TD4MulNiac8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+muVLQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C8DC4CECD;
	Sat, 28 Dec 2024 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735400469;
	bh=H/smT9WIQrV0an7KQDRTFZ3lwhDFTLFEQDU1vJb6i1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+muVLQcAZ3KI/vVVSwkQ3Zss5Wc3EHLv1bCYBotVx7krUa8PZVniLTwkXXN3F4Zr
	 9IVYIGTjdkUDtmq5wO87f583Do8eFZfyCpEdF8d6lhcag0j35ocHDBHcjRMmeXJrA2
	 xl5aVErPNAbfSWSb9rSyfVjji5iG6NKAre8AYTW4vjRQ2zLNOp+qDL1p4mCQol9xbK
	 yih3Golx7glQW0QlJHK8hfnvs7W/zMKHUAb9V1DLYUFPyw0LNaV2deuKkb9gmennPn
	 kxC6IMY6YZCikZP4jAIDOMcSVHTlUOCIJ1tkQmTFAIzje86UBTcaApc+fZPlCjOtqN
	 9BaJyXWbYHTbA==
Date: Sat, 28 Dec 2024 15:41:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/4] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
Message-ID: <20241228154101.7f6f2e11@jic23-huawei>
In-Reply-To: <20241224-veml3235_scale-v2-1-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
	<20241224-veml3235_scale-v2-1-2e1286846c77@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Dec 2024 11:59:00 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This helper functions reduce the burden in the drivers that want to
> fetch a gain selector in all available times or a new optimal gain.
> 
> The former is currently achieved by calling
> iio_gts_find_gain_sel_for_scale_using_time() for the current time
> selector, and then iterating over the rest of time selectors if the
> gain selector was not found.
> 
> The latter requires a combination of multiple iio-gts helpers to find
> the new gain, look for an optimal gain if there was no exact match, and
> set a minimum gain if the optimal gain is not in the range of available
> gains.
> 
> Provide simpler workflows by means of functions that address common
> patterns in the users of the iio-gts helpers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Matti gave an Ack.   If you intentionally dropped it due to significant
changes, you should say so...

> ---

here.

Other than that, looks fine to me.

Jonathan

