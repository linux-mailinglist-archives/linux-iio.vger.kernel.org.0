Return-Path: <linux-iio+bounces-10484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0A99B2ED
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84092839B5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA67014D433;
	Sat, 12 Oct 2024 10:21:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D7DE712D1FA;
	Sat, 12 Oct 2024 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728514; cv=none; b=e8eWzBDVAJLd2QbNKGtxbeyjBcRcCtiUwC+nArx1qEGGQwnHTF4X93JRVZqLUvyNJd1zsipv1hRzxRTRNql03AOg86DLjEnv1BRzQPb3li3sugZ7wjWFPKvaeaGUsPj2MCocE1qCMbrz9BPTWBe1cr23lnEkXMHwNawxDImDPEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728514; c=relaxed/simple;
	bh=/Sv2b9cfIk4oiF0DWFAzbO94rG6qeMRmR/0kj5NFv2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=kNDej1YXAx9rKc7YcIlhtVwbtJv17sXA+NOplSfrpx4c55M2FCXbZVKKxnaJ5sSvBTlMACayfUSoz1Cxo3xVGZZZ3vW0UfC8Uh2wCean2SlsWma45rECfvW2oRgyziDTkLN5yFTsHxiaML7gvqtuK9PX42QIAt6lb9pgFv6uFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id AB3C260B23F51;
	Sat, 12 Oct 2024 18:21:47 +0800 (CST)
Message-ID: <a39002c0-923d-9c9d-6d42-ea6e4b9ec153@nfschina.com>
Date: Sat, 12 Oct 2024 18:21:46 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] iio: bmi323: mark bmi323_ext_reg_savestate as maybe
 unused
To: Julia Lawall <julia.lawall@inria.fr>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, lars@metafoo.de,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, benato.denis96@gmail.com,
 Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <alpine.DEB.2.22.394.2410121110540.8471@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/12 17:11, Julia Lawall wrote:
> On Sat, 12 Oct 2024, Su Hui wrote:
>
>> When running 'make CC=clang drivers/iio/imu/bmi323/bmi323_core.o', there
>> is a clang warning as follows:
>>
>> drivers/iio/imu/bmi323/bmi323_core.c:133:27: error:
>> variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted
>> [-Werror,-Wunneeded-internal-declaration]
>>    133 | static const unsigned int bmi323_ext_reg_savestate[] = {
>>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> Mark bmi323_ext_reg_savestate as __maybe_unused to silent this warning.
> Why might it be unused?

We only use the size of 'bmi323_ext_reg_savestate[]' not it's value, as 
shown below :

$ git grep  bmi323_ext_reg_savest drivers/iio/imu/
drivers/iio/imu/bmi323/bmi323_core.c:static const unsigned int 
bmi323_ext_reg_savestate[] = {
drivers/iio/imu/bmi323/bmi323_core.c:   unsigned int 
ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
drivers/iio/imu/bmi323/bmi323_core.c:   for (unsigned int i = 0; i < 
ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
drivers/iio/imu/bmi323/bmi323_core.c:   for (unsigned int i = 0; i < 
ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {

And I find some solutions use __maybe_unused to silent this warning. 
Like this one:
3034983db355 ("drm/amdgpu: Mark mmhub_v1_8_mmea_err_status_reg as 
__maybe_unused")

Mark this variable to __maybe_unused is  to eliminate clang's warning.
Perhaps it is also possible to mark it as _used:).

Su Hui




