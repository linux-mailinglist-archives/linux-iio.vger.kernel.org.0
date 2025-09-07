Return-Path: <linux-iio+bounces-23861-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7ABB47B75
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630F917F575
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99DC26A1AC;
	Sun,  7 Sep 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2cBPQOD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7290B1F542E;
	Sun,  7 Sep 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757249412; cv=none; b=IG/QNKbpQGX8NIeNH5KpZ2VKAMIuO1Kf2J+Uvr5qEH8r/f875VODGWrVBLud+Sfad/cSiy5Nn40yc1VPPweLo4HrLv6RIO3K8YIZP5dY4SNY5uc3eKqWaCLL5HxfSuLAy481KMRzMVzxFb/jLK/ZGqXma421K/giUjP2xRKsFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757249412; c=relaxed/simple;
	bh=QdoyrG0DgAKG/7NojdccPAxFBrdj0Gv/sxwFvImmM5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdUna8Drt800ztI4QMqj3hbge3C/QCOXKFy6AQ8BO3G0GX5x9F8ICcx8V+FBjqy8ujA0ZR5QfoeNpOkAwk8LLYlqTkmTkQHKyYkMLDc0RwxIgi49z3BAjsMMP+tWsG580pFSCKJ05NzLkUkVAFTORyR+0R7NrA272+MtLUb726M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2cBPQOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F28C4CEF0;
	Sun,  7 Sep 2025 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757249412;
	bh=QdoyrG0DgAKG/7NojdccPAxFBrdj0Gv/sxwFvImmM5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A2cBPQODairAWSdOVFg0jqudoGlaj7oMicPe9GgaeYm5QwxCcS/BZ1iPUny+uXYvr
	 64j4ToyCWNUACPsXFNZ6ze9qbSC3zNHfEKtcgOFpn9o1lG1f6cP5CyNt9nnd3/mOuo
	 +GPugcjHZJP9w0Mh0edl4SvDwWPhMQDaOS0Xxg9UBuXQKYFeQ+a7zijN2yDOAvhIXb
	 rjcAhcmmt2GElZX+X3rzBONjqcAxKGMMwxS6SE5BLjbcstL7obx29DFztnxpHOhss3
	 OmVHprasC+xc4CXkv7Zfu7XhF1sC7dAkzMxtYwdR15SqOnCCX2dZXH+OCLqyrUJBH5
	 cDSme6O+fi+3w==
Date: Sun, 7 Sep 2025 13:50:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 06/10] iio: accel: BMA220 add LPF cut-off frequency
 mapping
Message-ID: <20250907135004.6c7faba9@jic23-huawei>
In-Reply-To: <cf18ede2-2077-41f4-a49c-adb3c13c4c44@baylibre.com>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-7-petre.rodan@subdimension.ro>
	<cf18ede2-2077-41f4-a49c-adb3c13c4c44@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 14:59:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/1/25 2:47 PM, Petre Rodan wrote:
> >  - add mapping for the low pass filter cut-off frequency.
> >  - make valid values visible for both the cut-off frequency and the scale.
> > 
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

> > +/*
> > + * Available cut-off frequencies of the low pass filter in Hz.
> > + */
> > +static const int bma220_lpf_3db_freq_hz_table[][2] = {
> > +	[BMA220_COF_1000HZ] = {1000, 0},
> > +	[BMA220_COF_500HZ] = {500, 0},
> > +	[BMA220_COF_250HZ] = {250, 0},
> > +	[BMA220_COF_125HZ] = {125, 0},
> > +	[BMA220_COF_64HZ] = {64, 0},
> > +	[BMA220_COF_32HZ] = {32, 0},  
> 
> If all of these are integer values, why do we need 2-D table?
Style wise, for IIO we are going for 
{ 32, 0 }, 

That is extra spaces.

Mind you that's irrelevant if it's a 1D array ;)

