Return-Path: <linux-iio+bounces-13986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B885CA04704
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BEA3A1432
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6903189F56;
	Tue,  7 Jan 2025 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S8PQbwgz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84F153836
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268505; cv=none; b=BCJ+SChv/MvLP33vjToE8Vxui8WflCQpOFSU6ser0cxyQ4gWWzKR1FsMRNxus7nTIshqmPqAAloJP0ZM/pXMvNVOGOF7zfTaaYQG2SSIbbwYZ9SLGNLGCK043hE53ChecJUVzxuI4y+5qv/fak2VNFttTV0WSnORbWL2H7ug/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268505; c=relaxed/simple;
	bh=nAdNZglN2eO4OkvGU3IXwgna8Nskk9l2fhG//Xse65Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibKyevcLwWz56QOUL1+HZIf7eO0GKsbpTQqOtA2UtYqfjxzOIHhgQmMb1K6FQyB9ycHDZStT8i2diS3DT+RkLIVvI27eAPqHbr39ZgHsq00Rfkh093Nzfvxh03+jJrxM3W/vO6BRQc4YSddOsSuaqBe/QM46mkuyCPvmZEKIZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S8PQbwgz; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e17de2816so7986835a34.0
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736268501; x=1736873301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2CMOR/p6KhjwdOJ+daE2KH7z8aBE6xeU8fSpxafapw=;
        b=S8PQbwgzcxrh4EhaHyFV70m7F/TmiputzPKzMtWqFrsUuam2nzZP2arVJg+7yuOSD2
         PRKlkz97QrbzJ16ylMVJFDZnvOfk+56nDukJyNRnzhT9MzVEu5BsDLSkUsbRhQ6j0c+0
         Ici9fq3HarAduCxnTUgZbSiy6UPuQP9qPRGYu/tOL1xg4KcNa29ajHCqnSd0INOANayA
         DqPdNfrtzwd4KFLEG/LZptSOHKdn+ZhvCMPGuRAvsLb777P42FqEtnyZ1YPKfn0iqAN9
         3A2ARymBXWhTrJZX0O0iIzFmwKtCXh+6nlWNVqA76zTqrp9PD4kP+CjIxoZFTHcbmOzB
         Vxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736268501; x=1736873301;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2CMOR/p6KhjwdOJ+daE2KH7z8aBE6xeU8fSpxafapw=;
        b=i3y56QoRNKcui1pZE91tdjCbECirjofdGMdaQJ6YQTwVXuwAG0e9A1/0FXIXryeAff
         rYOvfFpWpPzubeZFy26CMuE9XsulQssep5ee491/9Uy7gv10jK7eRx8XxbkMjiAMRxxT
         P0/jovrgKXZ/1LaUjgX25nbp8GNSk326+YkvTMhUG5NrYZrsxnzg7G9nHVsxjfMsA+Lr
         mMpHeWCoYaYGrQhLYnHr4KK8kXk0GLTQn5YDQERw6fxBZNo0pU+CHxW6jBXUuVkQBkoj
         wPg8J/WY/1elapiuMztImkNSogWTXsoZLaRCOqyc9oT6ytTqhafO7y+QV/FD9fvHVKY/
         /PVQ==
X-Gm-Message-State: AOJu0YzwvDM4T56UfLe4LXoRheBKDNIn2eXfi6mt4rlyvfbuUMlSsV4O
	RKCG/uaHK+9fUfx7ZBjlZvTLHXhjvDTr3LwTr/Vgi+uZYaDRkvKXo7ktl1gOvMo=
X-Gm-Gg: ASbGnctdHml3mCr6XfyHwddJk2SSJP0Cc1EkqOZDMAm4vOBIWnnL27ZUS2TmZIRGihF
	j6tt9JNxxBqnUWH2SZZ+ihE8WpQHs860s38yzSQN701v6jqzBJ8tYIKIo9oKP+BIf2Bso+4gcqF
	setnPeJlmSKHdMCLoe0QSpJlZzGsIrIOBcP6oH9Bp674gT6kzz89AOvSn/MbL1sSzB8yznAI0+H
	gCiXzNeEsSz60Mub5IGT+PpLgaoWyM6Gwj/xYFaWDZAHSpogLa9XS1evhC44IAZ/tCtG2sPi8fK
	9h93V4bEK9O5o9bXmA==
X-Google-Smtp-Source: AGHT+IHII89kez2WQk20utvd/AETbzX49+VrbyvKcDMVkyyN63b1MuFUr+kVHHKqUXgjrhD1B7itbw==
X-Received: by 2002:a05:6830:3108:b0:71a:5f45:ac3f with SMTP id 46e09a7af769-720ff67da00mr42829898a34.2.1736268500853;
        Tue, 07 Jan 2025 08:48:20 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc976ba23sm10397861a34.1.2025.01.07.08.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:48:19 -0800 (PST)
Message-ID: <e3ef72e6-4f39-488f-9aaa-2bbc91e43bc4@baylibre.com>
Date: Tue, 7 Jan 2025 10:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iio: adc: ad7380: do not use
 iio_device_claim_direct_scoped anymore
To: Julien Stephan <jstephan@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250107-ad7380-add-alert-support-v3-0-bce10afd656b@baylibre.com>
 <20250107-ad7380-add-alert-support-v3-1-bce10afd656b@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250107-ad7380-add-alert-support-v3-1-bce10afd656b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 2:48 AM, Julien Stephan wrote:
> Conditionnal scoped handlers are turning out to be a real pain:
> readability issues, compiler and linker handling issues among others so
> rollback and remove the scoped version of iio_dvice_claim_direct_mode.
> 
> To impove code readability factorize code to set oversampling ratio.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

FYI, might want to hold off on this until we see how [1] ends up.

[1]: https://lore.kernel.org/linux-iio/20250105172613.1204781-1-jic23@kernel.org/


