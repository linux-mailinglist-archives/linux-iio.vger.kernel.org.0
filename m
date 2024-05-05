Return-Path: <linux-iio+bounces-4820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E708BC32F
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5005B20E34
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24F6D1AB;
	Sun,  5 May 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnj2piaE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992C2D60A;
	Sun,  5 May 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714936112; cv=none; b=SuHgoBY+/xv8FxgzHvEogMACBTBPxOLU/YOT+yNBLGLFwCva+RfCXpfgL1nr+/UpBVhTnxVvFdOodKul+A/QFoE+wBr8UwzfgzqxJHthNJmTLghV611rAyezC2DeE/BOcP+kntxtrf4aGH1uCBLoPHyACyQ6TDeib1BS1F0gG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714936112; c=relaxed/simple;
	bh=K16y/nn6xI0FhC18mkIVH38yRFOytXJYADZiDnJAY4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vj5Fkg+HZRphJYuwB5pbost3zTNusWkIBGEwiduS7J9MQ4d3O/nYXdqQ/+3HfGazyh9zma48GUIrB7/5tKh7iOGdqAzi9rWMMnHfH32Gbkf7BQcKEQTZUx62k1Mez3/+gztQupUzoCk/Yn+ESBCc7mwthbxsJgrFQJpVgCL/3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnj2piaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021C7C113CC;
	Sun,  5 May 2024 19:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714936111;
	bh=K16y/nn6xI0FhC18mkIVH38yRFOytXJYADZiDnJAY4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gnj2piaE8RInpdwYMyy6RgWw85A8XOf//mvl3UgTq2s3zxmhMZhSHNqWk6yGnwkVd
	 gAFhvkU/YKPpBvIeoMxWC9U2cIVXNKZttlFZ3ypmzA9g+4ni4gcu2mb76HO7/HDnvZ
	 1ed1+CTaBBwM9oXadxEut3uLyp2q2OmeDR9/9ZlCc5t2W5vaHkv+Gz8n7OA9EQPUeO
	 PahxyRjJngJORHsD9+pllV71aUcaGGMfhbZeFRP21W12wUB+cdkFGGRNEkcvO3RAle
	 bGsCnU0/CyWWpk45g2sHoOmizmaJjkSuP5IZWlCGeSoqW34xBMPHeYU6o6u53yg18L
	 V/DUcBP+OPxQg==
Date: Sun, 5 May 2024 20:08:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: pressure: bmp280: Make return values
 consistent
Message-ID: <20240505200818.1e70c664@jic23-huawei>
In-Reply-To: <20240429190046.24252-6-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
	<20240429190046.24252-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 21:00:41 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Throughout the driver there are quite a few places were return
> values are treated as errors if they are negative or not-zero.
> This commit tries to make the return values of those functions
> consistent and treat them as errors in case there is a negative
> value since the vast majority of the functions are returning
> erorrs coming from regmap_*() functions.

The changes are fine, but that argument isn't correct.
regmap_*() functions never (that I can recall) return positive
values, so if (ret) would be valid for those and I'd have expected
the exact opposite outcome if you are looking at regmap*() return
values to make the decision.

The if (ret) pattern is sometimes used throughout because it
makes
	return function()

consistent without needing to do

	ret = function();
	if (ret < 0)
		return ret;

	return 0;

That pattern isn't particularly common in this driver (there are few cases).
We also tend not to worry too much about that slight inconsistency though
in a few cases it has lead to compilers failing to detect that some paths
are not possible and reporting false warnings.

However, all arguments about which is 'better' aside, key is that consistency
(either choice) is better than a mix.  So I'm fine with ret < 0 on basis
it's the most common in this driver being your justification. Just don't
blame regmap*() return values!

> 
> While at it, add error messages that were not implemented before.
> 
> Finally, remove any extra error checks that are dead code.

Ideally this would be broken up a little more as, whilst all error
code related, these aren't all the same thing.

I'd have preferred:
1) Dead code removal.
2) Message updates.
3) Switch to consistent ret handling.

However it isn't that bad as a single patch, so just address the question
above and I think this will be fine as one patch.

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Jonathan

