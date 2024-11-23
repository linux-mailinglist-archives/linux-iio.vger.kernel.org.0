Return-Path: <linux-iio+bounces-12526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B4E9D696B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D3D281A86
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9201D545;
	Sat, 23 Nov 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWGLGx1e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEBA134AB;
	Sat, 23 Nov 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372177; cv=none; b=Lhl9lQQmblzkl1A9k6rGuX9TMGEO8NCo2I5VcBqY7iTo0RrF2zvuVuEHR4Wlu9d0QiRP4GwcpDWCRo9/pqH10aO76ussYmOLrI7yWizHTW+X/rXg7hFvRUhf0dcMlZ8jg6ZfolwpEUlvAh0+m5qPp+q5/IYdqXLxmQKi7bcJkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372177; c=relaxed/simple;
	bh=y5VE1PtWCljW/3H+wXhbTP1YAlxXtL+u/Otf+K++upw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtJcMdB9YOFgJz4eIdyBEMB1ykm4q1CyjlpG/sgnyRKPVZLYQS6wdWb5uintucn3VjJmcnnctTgC2WZ3prbENJ2KYx4Omei9idBjekH1fyfvhrTklJ+4p6+NwwES+Vvr8x88PEnnhQFE/uDy/InErvwparWv9GxoCrWL1wz4g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWGLGx1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FB1C4CECD;
	Sat, 23 Nov 2024 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372175;
	bh=y5VE1PtWCljW/3H+wXhbTP1YAlxXtL+u/Otf+K++upw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWGLGx1eoxDNp47Ig3WILsPLKv2Xr1FSyI6Z8/7P1AvDiOTXQEje07lu73x8+/71Q
	 jLo/qPO/xmxhvyKyBeMP5bC3TDhcU8pheDlYsmGYFVct9RfZnJ2yAhLJVNHUfUMslp
	 xu/JtXpPgxh48vab0CJlplfrOTFHJbzmTsa9kauKGXuEYlR88tMZk7Hkpdkx1GuAUr
	 tueUVJF4h58dpF/kNG77OsVY4QIeNdhYIJ9orb4yrfuTCr0yUqBKDf9nni1CU6Ieko
	 mslJA5p4gvJv4zncfYJkHY4FrEN86oCi6fAIMQItegA/6tHfXVFFCKhg2tM7YSdFBH
	 x/tlIpEyO3Xcw==
Date: Sat, 23 Nov 2024 14:29:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: liambeguin@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
Subject: Re: [PATCH] iio: test : check null return of kunit_kmalloc in
 iio_rescale_test_scale
Message-ID: <20241123142928.6a41147c@jic23-huawei>
In-Reply-To: <34ab4d22-0b07-43ba-9d4f-eb4b2867f36a@kylinos.cn>
References: <ecd56a85e54a96c2f0313c114075a21a76071ea2.1730259869.git.xiaopei01@kylinos.cn>
	<20241101172926.4e8e3f43@jic23-huawei>
	<34ab4d22-0b07-43ba-9d4f-eb4b2867f36a@kylinos.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 09:14:45 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> On 2024/11/2 01:29, Jonathan Cameron Wrote:
> > On Wed, 30 Oct 2024 11:48:54 +0800
> > Pei Xiao <xiaopei01@kylinos.cn> wrote:
> >   
> >> kunit_kmalloc may fail, return value might be NULL and will cause
> >> NULL pointer dereference.Add KUNIT_ASSERT_NOT_ERR_OR_NULL fix it.  
> > Can it be an error?  If not why not use KUNIT_ASSERT_NOT_NULL?  
> As you thought, initially I felt that we should use 
> KUNIT_ASSERT_NOT_NULL. However, when I used grep 
> KUNIT_ASSERT_NOT_ERR_OR_NULL -nr drivers/iio/test/, I found that the 
> drivers/iio/test/ directory exclusively uses 
> KUNIT_ASSERT_NOT_ERR_OR_NULL instead of KUNIT_ASSERT_NOT_NULL. To 
> maintain consistency, I have changed it to KUNIT_ASSERT_NOT_ERR_OR_NULL.
> 
> drivers/iio/test/iio-test-format.c:22: 
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> drivers/iio/test/iio-test-format.c:52: 
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> drivers/iio/test/iio-test-format.c:113: 
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> drivers/iio/test/iio-test-format.c:153: 
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> drivers/iio/test/iio-test-format.c:193: 
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> drivers/iio/test/iio-test-format.c:208: 
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
Ok. May be worth a follow up to tidy that up. A couple more cases do no real harm.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> >>
> >> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> >> Fixes: 8e74a48d17d5 ("iio: test: add basic tests for the iio-rescale driver")
> >> ---
> >>   drivers/iio/test/iio-test-rescale.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
> >> index 31ee55a6faed..11bfff6636a3 100644
> >> --- a/drivers/iio/test/iio-test-rescale.c
> >> +++ b/drivers/iio/test/iio-test-rescale.c
> >> @@ -652,6 +652,8 @@ static void iio_rescale_test_scale(struct kunit *test)
> >>   	int rel_ppm;
> >>   	int ret;
> >>   
> >> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff);
> >> +
> >>   	rescale.numerator = t->numerator;
> >>   	rescale.denominator = t->denominator;
> >>   	rescale.offset = t->offset;
> >> @@ -681,6 +683,8 @@ static void iio_rescale_test_offset(struct kunit *test)
> >>   	int values[2];
> >>   	int ret;
> >>   
> >> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff_off);
> >> +
> >>   	rescale.numerator = t->numerator;
> >>   	rescale.denominator = t->denominator;
> >>   	rescale.offset = t->offset;  
> >   


