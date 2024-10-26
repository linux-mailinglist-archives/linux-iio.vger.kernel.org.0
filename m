Return-Path: <linux-iio+bounces-11365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD309B1A53
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 20:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E867EB21648
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF91D3639;
	Sat, 26 Oct 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fR2PgP0w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC013B2A8;
	Sat, 26 Oct 2024 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729966246; cv=none; b=qogH9CIXu4Md1gwLeSkmiq4BFFOCI6dzSQOxGfG2ycAY15zxD+NplGEpsdLLAtiaVyEejCrhfgFvETPtbF4nMod2IqnSZQy2VC9NQjIEEn0G4pMXCgLEt8Fv9hl9RJMPj8Iy+kmbvsqjzGWpsITuabps+ehuT6u8tLBysQbd6wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729966246; c=relaxed/simple;
	bh=sqTmSUJazM7nhjfb4jtbIvz0Z/sA3IyEDRELq86/kVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzkuXudl8A12OqxltWZqemCisQgaRAX/8ioIFp8CoT1tYmQmcqtxWXd11cwyfALtAXqAuJmRkhw9NMftxqeI6IYcrcO5Lg9/FwygpM6vjAWSLJtclBdvcnNdq0zibRRfr/765eKxOzsziZHzAqu0U3Ba0G0lZ0peAXGP6ziMV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fR2PgP0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54683C4CEC6;
	Sat, 26 Oct 2024 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729966245;
	bh=sqTmSUJazM7nhjfb4jtbIvz0Z/sA3IyEDRELq86/kVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fR2PgP0wqA4/c4qLzwYX49undL34eOeNtT1hCUeujeKS00SbzC5K5SrVnY+ssRDoU
	 8gO88OSBlal6lPGvHOm4jGw+QSWuSmwa4Ktm5b2ztM298RORHsumt13RstGWkln+9Q
	 5CXtyrbzz3P09C46gSmphTXrYhH8cvI5VwRj4DRr1KBALhNUNkweh/g0OcvSWV9MsV
	 1SXhIHjA3KM2b2XHL0rp+qmOi0B9cujN5o3NMzkMHJkFVijn20MB8tLQTkVQmIV2ot
	 k8oiX4EtR0A5c1L3Du/dNABclExSh0bFsdpmjKm45LJLFTYsPfab7dhdTj/mlI88pF
	 X++RfNYdy/5WQ==
Date: Sat, 26 Oct 2024 19:10:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: add support for veml3235
Message-ID: <20241026191001.10acd773@jic23-huawei>
In-Reply-To: <19c8e07f-4b9b-4d4b-aa18-f6766b65b33e@gmail.com>
References: <20241023-veml3235-v3-2-8490f2622f9a@gmail.com>
	<202410251610.kB7u6xMJ-lkp@intel.com>
	<19c8e07f-4b9b-4d4b-aa18-f6766b65b33e@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Javier,

> >    222	
> >    223		return 0;
> >    224	}
> >    225	
> >   
> 
> 
> Unused as there is no processed values anymore. I will drop them for v4.
Given I didn't have any other comments I just fixed these up whilst applying.

Series applied to the togreg branch of iio.git and initially pushed out as
testing for 0-day to take a first look at it.
Thanks,

Jonathan

p.s. Diff was as follows, shout if I mess it up.

diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
index 18ab73f4377c..66361c3012a3 100644
--- a/drivers/iio/light/veml3235.c
+++ b/drivers/iio/light/veml3235.c
@@ -145,7 +145,7 @@ static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)
 static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
 {
        struct veml3235_data *data = iio_priv(indio_dev);
-       int ret, new_it, it_idx;
+       int ret, new_it;
 
        if (val)
                return -EINVAL;
@@ -153,23 +153,18 @@ static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
        switch (val2) {
        case 50000:
                new_it = 0x00;
-               it_idx = 4;
                break;
        case 100000:
                new_it = 0x01;
-               it_idx = 3;
                break;
        case 200000:
                new_it = 0x02;
-               it_idx = 2;
                break;
        case 400000:
                new_it = 0x03;
-               it_idx = 1;
                break;
        case 800000:
                new_it = 0x04;
-               it_idx = 0;
                break;
        default:
                return -EINVAL;
@@ -188,7 +183,7 @@ static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
 static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
 {
        struct veml3235_data *data = iio_priv(indio_dev);
-       int ret, new_gain, gain_idx;
+       int ret, new_gain;
 
        if (val2 != 0)
                return -EINVAL;
@@ -196,19 +191,15 @@ static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
        switch (val) {
        case 1:
                new_gain = 0x00;
-               gain_idx = 3;
                break;
        case 2:
                new_gain = 0x01;
-               gain_idx = 2;
                break;
        case 4:
                new_gain = 0x03;
-               gain_idx = 1;
                break;
        case 8:
                new_gain = 0x07;
-               gain_idx = 0;
                break;
        default:
                return -EINVAL;


> 


