Return-Path: <linux-iio+bounces-21974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 106C2B10B3B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC67A78AD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655BE2D5C68;
	Thu, 24 Jul 2025 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THlV4AAh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23493267B9B;
	Thu, 24 Jul 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363208; cv=none; b=Cauv5NMoWh+ubi/SHxsYfXhAYnj+tqIhD/diKwML2uyMINppwkph3v6hO0oCy0vIJNbbgTcnNOgVMSmJhwjMUoNcVbln4y3gtkbkWnfcR++bGT7RH67e+r5zNbDJnwc+BNjPY4DPQha5Koh9XEw7wRlQxsV7yPC6PI5aGMA8aik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363208; c=relaxed/simple;
	bh=eNHSlB2zYs8BcvVYhN7PaMANEevtRiQ35ueUwQErWcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFwCj28k0Unly+0ANxrUzeKVcCEkyvEEr5XZZRzZNYK1Ae3udnQ+GxB73XdetEtPlbFUP4QUYDrSkRhI3HfpGGlkM9n9m9qErUs8nEcds60t3OuN7AMJnQKxJac+yqKsN/XdQ+cZjzNSwCjtCN4kHyGP0FWQQEzNYcYZit/1RIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THlV4AAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3578C4CEED;
	Thu, 24 Jul 2025 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753363207;
	bh=eNHSlB2zYs8BcvVYhN7PaMANEevtRiQ35ueUwQErWcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=THlV4AAhpLSQn8ln3JUPQaLD/3P1wfu3nnmh1Z1rNNJfCCsR6q1jjQMrGZH7jg0KU
	 TRWMoB2VmBo0ny5RjZKhlHlF+yhePg3xjMCQ+yvXaMxFrb14e8BLu8wieX/YmLE4mj
	 diwgY0jIWQ0YJQPFxsmGG+EiveVWz2CaxjFRgNbqxRezmeJf6YGJAWg4Dlpyju1sBC
	 0rCKWnU9qQSgAqeGLp+RbwHMcjI5R0oBgmnhYoZjzORpGYcAMU2Y11TruBn2BY6TzO
	 aDbk+T9/ylUH9AYYsHsruXmcIW1ZjKP+QjWgSgwkmaZksM22+wcMPl43NBkT07nf2V
	 swTKadpfpMOug==
Date: Thu, 24 Jul 2025 14:20:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: adc: ad7137: add filter support
Message-ID: <20250724142001.72181c21@jic23-huawei>
In-Reply-To: <29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
	<29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 17:47:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/10/25 5:39 PM, David Lechner wrote:
> > Adding yet another feature to the ad7173 driver, this time,
> > filter support.
> > 
> > There are a couple of leading patches to rename some stuff to minimize
> > the diff in the main patch where filter support is actually added. And
> > there is a bonus patch to clean up the ABI docs for filter_type first
> > before adding the new filter types introduced in this series.
> > 
> > This was tested on the EVAL-AD7173-8ARDZ evaluation board.
> > 
> > This series depends on a bunch of fixes, so we'll have to wait for
> > those to make it back into iio/testing before we can merge this
> > series. There is also an outstanding patch to add SPI offload support
> > to this driver, but that doesn't actually have any merge conflicts
> > with this series, so they can be applied in any order.
> > 
> > ---
> > David Lechner (5):
> >       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
> >       iio: adc: ad7173: rename odr field
> >       iio: adc: ad7173: support changing filter type
> >       iio: ABI: alphabetize filter types
> >       iio: ABI: add filter types for ad7173
> >   
> I don't know why, but I really struggle to write this part number
> correctly. The subject of this cover letter is wrong, but at least
> I got it right in all of the patch subject lines.
> 

Series look good to me. Give me a poke if it looks like I've forgotten
to pick this up after the precursor fix is in my tree.

Jonathan

