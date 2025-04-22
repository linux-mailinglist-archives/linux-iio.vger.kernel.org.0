Return-Path: <linux-iio+bounces-18487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6887A95E94
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19EB1760D4
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 06:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF292356DE;
	Tue, 22 Apr 2025 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P25l369j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4F22B8BF
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304271; cv=none; b=LBeyPNXJ5q4hQE70FGowoq6h7vzwwk7GfumfJOyr+3pg3VyCV7ck0VwO6IL21rZFajRJBrjFIceWg2whuanrxdPU40tOrJqK4/L2CMp3SgCV/SfhL9zEtLHvrzdSNQHAWjRKYv+TOBvVl35kkdrMtoydbgsKhLEArndpgGdS7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304271; c=relaxed/simple;
	bh=pL9CVghxG1ZKZG1MuX1QtZhXgzKhXTo0AK7d0/+p3xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbjq5BFlJ61Z3udVTYCRST6tftSsNAj1u+rE5EDS10pmZNKmTu4QpQUy6ZHLpZrbb6Gsa6RpmTRe9hHHHGnXyEwR5P4wRruXVtJ1jMoQEbk2bHgHvOzRq3uDfwXqBPFD/Gk5X4WY13o0Z1pHObSFDyOkp1d6U9bm+IuFwfb8yUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P25l369j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso39954575e9.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 23:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745304268; x=1745909068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQPImNugkItyfP+G4uJ4TvGScdbcNscFNsfQCd9dZNE=;
        b=P25l369jAn9sNJUob6mGg2mVdvGuM3gRMBmf35Zmk/W5ck+xHjn+4wiLOxBzgjpJqW
         DN30LH7NfsdefQr8jK79hdrwUymBvasQoWCx0L2K6nqOTmOdd+r80O46YRSu1aKRrFjo
         ULJP52yxNqsVXlaxRZzdxosbiXhTWzNfzChfaWEuzLxxsHP2IMIr3GjfOs1BgnCEXJE/
         UsFSkUHuLw5lsCS+smx8Uco9oGNI6aVrrwBZOFR10mOnU6MfQD+n6kMHlETJce/aXSZG
         28gz8G5LhMPuYUcIiG7pxswa0+G18iZyGKqc0UllyERgibFGGdogRPEHavLno2AmrCpp
         aLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745304268; x=1745909068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQPImNugkItyfP+G4uJ4TvGScdbcNscFNsfQCd9dZNE=;
        b=NhpEJwkLwGbj6S50HgNkLL6jUYSWM+rya4HuLLh2bYVuG0kt+O9jI+PftMDntyMWpu
         MwZukHDXUuFvxtQRKw6qkiOGdkzfcAMPBwyXQP6u+/jQKpXU3KBG0vZU5gsm7K4Mof15
         9Qz0kyp4LPC1mPBd/2DUmbGk3G8Cn3Krn0D0vUY8dWoEFxL0yDe0xVl8L8SpEEbjbfnh
         SzA4xI79jOD6zUNFhsozl1rJ/RLEW13osBRf7QzZIwRt6aMj2S7kAp3vGO1GV69sNrH8
         Ev7ER7zloJCUcWY9YspsCV0z/0cW7UouykfcPr742FSRK8Wv3jiaZJgMydE+JM2xawnN
         i4mA==
X-Forwarded-Encrypted: i=1; AJvYcCWyx+U693Rde5IumsfpJJQKgaiRB3NDNc62foTke73i/RKlTs5l3HGTkIl0dw0fbgQl3PdToTi8dXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTa9UJ8wSNcu4K1hdmrLFH7A6PhTzgJ9Wzeujp0gvu7NtIO6e
	+lVbNmgcpZoY8Lz31KAiz6j0dCfM+bQoplsUYWL0HfUERRH4Dd/13uouGr0jxRY=
X-Gm-Gg: ASbGncvy0k+ETNef08pPTNd+mBgp10G70Hg3E5sdM+VSNLFOgjbsIdAxQKAvtGz/ihj
	X04bEtKdC/jiezUfcY3+lsDEVqU9Rne5aO8fK3U5BvK/IzWof2XnOf0X9Kx/r7d3lfNfmafuX8m
	z22HKP+LSftdsv3wChOa6oA5e9s99uIGXkE+4d8Yn6GrcGWJ+MoRkuZwIsAe7Qg5kesAFj6T2Iv
	20cEyqLW6ifVxMMPWJMjsyaC9WaCTy2rq8rTiR9fL5diCicGacyp0QbKKV4amepj8D3OgQSsamk
	MxlpQXYmW2OGHkvYvMfOt0yh5nONBLqtqacwp56ZkA9pOA==
X-Google-Smtp-Source: AGHT+IHUNJ5wQ9P52XuaZE0IU0Ci7qmgXOj8IWWiW+Ga6WWO0mvjKQK2WDhvuSV7fUR8QE54qZimKg==
X-Received: by 2002:a05:600c:5023:b0:43c:fa0e:4713 with SMTP id 5b1f17b1804b1-4406ab7efadmr141939785e9.2.1745304268110;
        Mon, 21 Apr 2025 23:44:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5cf2easm160870545e9.31.2025.04.21.23.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 23:44:27 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:44:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	sonic.zhang@analog.com, vapier@gentoo.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 5/5] staging: iio: adc: ad7816: Simplify channel
 validation using chip_info
Message-ID: <a8aeef26-929d-4601-9eb5-9011d73aa36d@stanley.mountain>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
 <20250419135638.810070-6-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419135638.810070-6-gshahrouzi@gmail.com>

On Sat, Apr 19, 2025 at 09:56:38AM -0400, Gabriel Shahrouzi wrote:
> Refactor the channel validation logic within ad7816_store_channel() to
> leverage the max_channels field previously introduced in the
> ad7816_chip_info structure.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>

Could you add the ->max_channels struct member here?  This patch would be
easier to review if it had all the ->max_channels information in one place
so we didn't have to jump back to patch 3 to verify that it's correct.

regards,
dan carpenter


