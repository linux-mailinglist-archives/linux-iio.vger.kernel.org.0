Return-Path: <linux-iio+bounces-23943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD99B51D9A
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B911695EE
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0B3277B8;
	Wed, 10 Sep 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5wgI8/i"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D7221FCD;
	Wed, 10 Sep 2025 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521638; cv=none; b=JWGzjrt2Qvh3lelnu01s/nu/qboRfrUdu7jGvgPo2v1Zb1FgWIEo1N8gz5psl20ZziRIV1Fdij/g3JaWxclRa7iOnGw+mfL8EYoJirv+t2bMeowci/CUnhX8KO4qszrOIJm8XeSbVOQl6vgoTuoPv55QceqRV+bklF+K94gVwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521638; c=relaxed/simple;
	bh=p491iqx2vANmtGz1zTGwVj8rZPC8tXZP5FDwllQ1luY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UT5UqSnTsSnSkql8aadffmGu5UpKOacm2Fct9JqKsoC3sjqHVdKo1eLrHKuPQExqhMzFIvBINpmge6E2BLcSNULCqq8uNOYBoSTxP1g1wlO8jPiL0XuS7kIjqnSBw23WWuTqf/eq6MvBwu0nlZJURMTLwiL9FHUqZZ9JkSPCr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5wgI8/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA53C4CEF0;
	Wed, 10 Sep 2025 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757521638;
	bh=p491iqx2vANmtGz1zTGwVj8rZPC8tXZP5FDwllQ1luY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R5wgI8/iVTLu13ZSi3EKxfYn6EiQP8GtK6INLDpf1aOlSqpFcGNIQ7kAnzAzCMeRd
	 VBYPGIc1tov55QDxANERGkgVf9RAUB6QATrq9xKk5xqgX6iZAvGrdArUpL81Oor3eJ
	 oNYY8n4UfbAlCRDamgdPzYaomEagsnqns54S6NxCZOc52BPerPwB2BRJmFPaTMxtfw
	 OTMtPVwWvaVbORP7KJ6Tq+ABJnNN0tTr4SCWYmg7YrMxPnQr1b75px1q/8MriTkXXZ
	 fnqR6boOqfwxxC2G/FF4r3RAaGyzOR7ILkJnVDoOH1+5y/Z4BWXEhW+Zlt8UsWeD7Q
	 RC3RfSm1Qir+w==
Date: Wed, 10 Sep 2025 17:27:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad7124: fix sample rate for multi-channel
 use
Message-ID: <20250910172712.3f01a056@jic23-huawei>
In-Reply-To: <0505896b-02b5-465e-adc4-4404d8e657c1@baylibre.com>
References: <20250905-iio-adc-ad7124-fix-samp-freq-for-multi-channel-v3-1-702ff014ec61@baylibre.com>
	<20250907110013.266c2da2@jic23-huawei>
	<0505896b-02b5-465e-adc4-4404d8e657c1@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 10:17:06 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/7/25 5:00 AM, Jonathan Cameron wrote:
> > On Fri, 05 Sep 2025 12:33:34 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> 
> ...
> 
> > Given you replied to Andy's indentation comment on v2 and that seemed
> > reasonable to me + the other change is a simplification for now I think
> > this is ready to go.
> > 
> > Given the whole ABI / fixes tag point I'm going to apply it to the
> > 'slow' path and taking via testing/togreg for the next merge windows.
> > 
> > Applied to togreg and pushed out as testing for 0-day to take a look.  
> 
> With fresh eyes, I spotted a few minor mistakes...
> 
Dropped.  Also dropped the follow on patches that I'd previously picked up
as there is some dependency on this.

