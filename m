Return-Path: <linux-iio+bounces-15573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B6A3752B
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D8F3AD78F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F818BC1D;
	Sun, 16 Feb 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZKlpxwE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1D1F94C;
	Sun, 16 Feb 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720483; cv=none; b=pNVNDSGxzPcESRjVHS88gwXsr/ps4B5rGfpgsxUEm5jJZe2z5EUj2AHe5F3WohPdOzMl8Rp4W5IUlauy3tLJ5xcN4f+Xk1zWn+mT5CRcoB+G7m3k8B4GKM4K3Up+keQgTxKyFTg5mJhIV19oVeRzEh1kIOhjOnY+e5HvnOJmSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720483; c=relaxed/simple;
	bh=m7R21IgthMwbzYas9Ri7Wmr+fjBjc8DbdQNopPbTE2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZbgsYig21is7S3iJ4G2QwAVycMapdAKHF0yIqObsbXwK6yJtXxBnRSz8P+pxz8bDx6zGA8oydP2T2bB3+tu+zw9JDhy9vA6WJ3pU97O9/HmFfUqVFoqh3YUvWFZTtQsxgb6mK7R6Mfinn2mFi7C57SOHUq7Jhx5N7LnQxQOgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZKlpxwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0656FC4CEDD;
	Sun, 16 Feb 2025 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739720482;
	bh=m7R21IgthMwbzYas9Ri7Wmr+fjBjc8DbdQNopPbTE2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZKlpxwEFoVmHgvooKn6+dCYvyTwwb7oVhP8k4AeVymSVjSROoARlnE2PfG1pZMQe
	 Tfx0P/zO2pLvxC/TWCQ01g8RlCExz25puLlmJNK2EYSdd1737zo04DPx87uypIPqvY
	 ByaFadIwXhsgJU5Cv+FVrQ1ePiQyhKKV75/ttG74VF9EvjF2fbVSh09VrZ3subpCsb
	 Z9J/ndJgv5tcC4YEdTuV/TTZGAiLg5oVKE8z8lX/32Spd8w1SUph/5+pTjwYxeSI50
	 55rAyNtK6AHSZftsEb6xIjfr9iF1ysMRsaIdPMOqApdqKmT7mtGJqctWDyWM5n9/3+
	 hbyB1s60fupvA==
Date: Sun, 16 Feb 2025 15:41:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Esteban Blanc <eblanc@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 6/6] docs: iio: ad4030: add documentation
Message-ID: <20250216154113.08636975@jic23-huawei>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-6-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
	<20250214-eblanc-ad4630_v1-v4-6-135dd66cab6a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 13:22:36 +0100
Esteban Blanc <eblanc@baylibre.com> wrote:

> This adds a new page to document how to use the ad4030 ADC driver
> 
> Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
There was a bonus blank line at the end of this one as well.
I dropped it.


