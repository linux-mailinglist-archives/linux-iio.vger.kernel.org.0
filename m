Return-Path: <linux-iio+bounces-8543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7AA955858
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4023F1F22220
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B6C154439;
	Sat, 17 Aug 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmWPwMBr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94D149E16;
	Sat, 17 Aug 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904922; cv=none; b=Cf/xXbLuHXdax5GObe5qJjwgyV7d8gkse7vZ0E1c62CLImVOcoPzCQO0ZVIcxpYuqs1SF2q8Ja1J+QVQ+j2rS6v+WNOWi77WUcYJv1ka/1Rv/YCG6lSS/Hgel5XXRwMBYcZtVl6FOiOQfTFp1BdbGmwj6SFbcMtRbL9N5YrBUdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904922; c=relaxed/simple;
	bh=OlXqPeL9YUa5JwTYaFO2qac9cA+T7b3XNOuYS+KGZ8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSdiJ9eg5/jTWU5EjQCnH69fugPolqmpWfHe4H5hd/okVsSPLy85mIk21tLgv1SLdk4TxTkxqmZSl72J+440NLbUqdWCvtsjvUCkemTJZ1YfC9qcZl859zcZGxQ0Tss3JOABZaFL8RdaUoF0atonJFFHC16UmOwWYrPAz7sjHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmWPwMBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4865CC116B1;
	Sat, 17 Aug 2024 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723904922;
	bh=OlXqPeL9YUa5JwTYaFO2qac9cA+T7b3XNOuYS+KGZ8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HmWPwMBr0/KDuCfdGCPJsUeVKtfRoWv3aCNU/xWZED0RLFCvGjM/W7JvsLontc4pm
	 mQU/CcTR8AAASO1wO6MQUzNOWP3o4cc7CtejCwGQ06wh0DF+LIDMH3uwVY1hveQfEY
	 UPdrBg5VOJKFni5oPtut6exbw7xhyBCqX4/Y3xnIrSr6+x9PHEmadp3nR1XpkFRgFW
	 e8LCKWQGTzpC82kBljC8sHjI8+mh4vdZF2Na2mHNovBHzhibJpcFL7bK/SWNT5OtiF
	 ztBhgXJ0ex9HSntBE63Lea9a1xSTXFz6mYk8QPeufE9IoqBA944QgpzzzgzSxA3tuW
	 vFwTHCbvBYZIA==
Date: Sat, 17 Aug 2024 15:28:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad4695: implement triggered buffer
Message-ID: <20240817152834.779be1e5@jic23-huawei>
In-Reply-To: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
References: <20240813-iio-adc-ad4695-buffered-read-v2-0-9bb19fc1924b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 12:26:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is a fairly simple series that adds support for triggered buffers
> to the ad4695 driver.
> 
Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons...

Thanks,

Jonathan

